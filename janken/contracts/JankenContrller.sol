// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

import "./AccountManager.sol";
import "./Janken.sol";
import "./StakePool.sol";
import "./StringLib.sol";
import "./AddressLib.sol";
import "./UintLib.sol";

contract JankenController is Janken {
  using StringLib for string;
  using AddressLib for address;
  using UintLib for uint256;

  uint256 timeoutBlockNumber = 10;
  AccountManager private accountManager;
  StakePool private stakePool;

  event GameCreated(uint256 gameID, uint256 stake);
  event GameReady(uint256 gameID);
  event GameDone(uint256 gameID, Result result);
  event GameCanceled(uint256 gameID);
  event GameInfo(Game game);

  struct Game {
    uint256 id;
    uint256 stake;
    address addrHost;
    address addrGuest;
    bytes32 hostHashedHand;
    Hand guestHand;
    Status status;
    uint256 blockNumber;
    address winner;
    address loser;
  }

  //key: gameID, value: target Game
  mapping(uint256 => Game) private games;

  enum Status {
    Created,
    Ready,
    Done,
    Canceled
  }

  modifier mustBeMaster() {
    string memory _msg = "only master address is allowed:[sender address] ";
    require(
      msg.sender == accountManager.getMasterAddress(),
      _msg.join(msg.sender.toString()).join(",[expected address] ").join(
        accountManager.getMasterAddress().toString()
      )
    );
    _;
  }

  modifier mustBeHost() {
    string memory _msg = "only host address is allowed:[sender address] ";
    require(
      msg.sender == accountManager.getHostAddress(),
      _msg.join(msg.sender.toString()).join(",[expected address] ").join(
        accountManager.getHostAddress().toString()
      )
    );
    _;
  }

  modifier mustBeThisHost(uint256 _gameID) {

      string memory _msg
     = "only host who created game address is allowed:[sender address] ";
    require(
      msg.sender == games[_gameID].addrHost,
      _msg.join(msg.sender.toString()).join(",[expected address] ").join(
        games[_gameID].addrHost.toString()
      )
    );
    _;
  }

  modifier mustBeGuest() {
    require(
      accountManager.isGuest(msg.sender),
      "only guest address is allowed"
    );
    _;
  }

  modifier notZero(uint256 _gameID) {
    require(_gameID != 0, "gameID must not be 0");
    _;
  }

  modifier uniqueGameID(uint256 _gameID) {
    require(games[_gameID].id != _gameID, "gameID must be unique");
    _;
  }

  modifier existingGameID(uint256 _gameID) {
    require(games[_gameID].id == _gameID, "gameID must be existing");
    _;
  }

  modifier validateGameStatus(uint256 _gameID, Status _expected) {

      string memory _msg
     = "game.status must be expected status: [actual status] ";
    require(
      games[_gameID].status == _expected,
      _msg.join(uint256(games[_gameID].status).toString())
    );
    _;
  }

  modifier validateGameStake(uint256 _gameID, uint256 _givenStake) {
    require(
      games[_gameID].stake == _givenStake,
      "game.stake must be equal to given stake"
    );
    _;
  }

  modifier validateTimeout(uint256 _gameID) {
    string memory _msg = "timeout is not happened yet: [blockNumber] ";
    require(!isTimedout(_gameID), _msg.join(block.number.toString()));
    _;
  }

  constructor(address _addrAccountManager, address _addrStakePool) {
    accountManager = AccountManager(_addrAccountManager);
    stakePool = StakePool(_addrStakePool);

    //accountManager.setJankenControllerAddress(address(this));
  }

  // create new game
  function createGame(
    uint256 _gameID,
    uint256 _stake,
    bytes32 _hostHashedHand
  ) external mustBeHost notZero(_gameID) uniqueGameID(_gameID) {
    // done: only host can call this function by modifier
    // done: only unique gameID is allowed

    //deposit stake to owner by host
    stakePool.depositToken(msg.sender, _stake);

    // create new game
    games[_gameID] = Game(
      _gameID,
      _stake,
      msg.sender,
      address(0),
      _hostHashedHand,
      Hand.Unknown,
      Status.Created,
      block.number,
      address(0),
      address(0)
    );

    // emit event, game is created with gameID and stake
    emit GameCreated(_gameID, _stake);
  }

  // join game by guest
  function joinGame(
    uint256 _gameID,
    uint256 _stake,
    Hand _guestHand
  )
    external
    mustBeGuest
    notZero(_gameID)
    existingGameID(_gameID)
    validateGameStatus(_gameID, Status.Created)
    validateGameStake(_gameID, _stake)
    validateHand(_guestHand)
  {
    // deposit stake by guest
    stakePool.depositToken(msg.sender, _stake);

    // update guest address
    games[_gameID].addrGuest = msg.sender;
    // update guest hand
    games[_gameID].guestHand = _guestHand;
    // update status to ready
    games[_gameID].status = Status.Ready;

    // set current block.number
    games[_gameID].blockNumber = block.number;

    // emit event, game is ready
    emit GameReady(_gameID);
  }

  // after client receive event, game can start by function
  function startGame(uint256 _gameID, string memory _salt)
    external
    mustBeThisHost(_gameID)
    notZero(_gameID)
    existingGameID(_gameID)
    validateGameStatus(_gameID, Status.Ready)
  {
    //TODO: judgement for timeout
    if (isTimedout(_gameID)) {
      cancelGame(_gameID);
    } else {
      judgeGame(_gameID, _salt);
    }
  }

  function judgeGame(uint256 _gameID, string memory _salt) private {
    // get host's te with _salt
    Hand hostHand = retrieveHand(games[_gameID].hostHashedHand, _salt);
    assert(hostHand != Hand.Unknown);

    // judge
    Result result = judge(hostHand, games[_gameID].guestHand);

    // update game
    games[_gameID].status = Status.Done;
    if (result == Result.A) {
      games[_gameID].winner = games[_gameID].addrHost;
      games[_gameID].loser = games[_gameID].addrGuest;
    } else if (result == Result.B) {
      games[_gameID].winner = games[_gameID].addrGuest;
      games[_gameID].loser = games[_gameID].addrHost;
    } else if (result == Result.Draw) {
      games[_gameID].winner = accountManager.getMasterAddress();
      games[_gameID].loser = accountManager.getMasterAddress();
    }
    assert(games[_gameID].winner != address(0));
    assert(games[_gameID].loser != address(0));

    // depost is stored in master account
    // winner can widtdraw depost from master
    if (result == Result.A || result == Result.B) {
      stakePool.widhdrawDeposit(
        games[_gameID].winner,
        games[_gameID].stake * 2
      );
    } else if (result == Result.Draw) {
      // refund tokens to host/guest
      stakePool.widhdrawDeposit(games[_gameID].addrHost, games[_gameID].stake);
      stakePool.widhdrawDeposit(games[_gameID].addrGuest, games[_gameID].stake);
    }

    // emit event, game is done
    emit GameDone(_gameID, result);
  }

  // cancleGame must be called after any requires by caller
  function cancelGame(uint256 _gameID) private {
    // cancel game
    games[_gameID].status = Status.Canceled;
    // win guest due to timed out
    games[_gameID].winner = games[_gameID].addrGuest;
    games[_gameID].loser = games[_gameID].addrHost;

    stakePool.widhdrawDeposit(games[_gameID].winner, games[_gameID].stake * 2);

    // emit event, game is canceled
    emit GameCanceled(_gameID);
  }

  // cancelTimedoutGame is expected to be called from client apps
  function cancelTimedoutGame(uint256 _gameID)
    external
    existingGameID(_gameID)
    validateGameStatus(_gameID, Status.Ready)
    validateTimeout(_gameID)
  {
    // cancel game
    cancelGame(_gameID);
  }

  function isTimedout(uint256 _gameID) private view returns (bool) {
    if (games[_gameID].blockNumber + timeoutBlockNumber < block.number) {
      return true;
    }
    return false;
  }

  function gameInfo(uint256 _gameID) external {
    emit GameInfo(games[_gameID]);
  }
}

// for unittest
contract JankenControllerTest is JankenController {
  StakePool private stakePool;

  constructor(address _addrAccountManager, address _addrStakePool)
    JankenController(_addrAccountManager, _addrStakePool)
  {
    stakePool = StakePool(_addrStakePool);
  }

  function _depositToken(address _addrSender, uint256 _stake) external {
    stakePool.depositToken(_addrSender, _stake);
  }
}

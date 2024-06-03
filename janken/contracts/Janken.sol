// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

contract Janken {
  enum Hand {
    Guu,
    Choki,
    Paa,
    Unknown
  }

  enum Result {
    A,
    B,
    Draw
  }

  mapping(Hand => mapping(Hand => Result)) private judgeMap;

  modifier validateHand(Hand _hand) {
    require(
      _hand == Hand.Guu || _hand == Hand.Choki || _hand == Hand.Paa,
      "hand is out of range"
    );
    _;
  }

  constructor() {
    createJudgeMap();
  }

  function createJudgeMap() private {
    judgeMap[Hand.Guu][Hand.Guu] = Result.Draw;
    judgeMap[Hand.Guu][Hand.Choki] = Result.A;
    judgeMap[Hand.Guu][Hand.Paa] = Result.B;
    judgeMap[Hand.Choki][Hand.Guu] = Result.B;
    judgeMap[Hand.Choki][Hand.Choki] = Result.Draw;
    judgeMap[Hand.Choki][Hand.Paa] = Result.A;
    judgeMap[Hand.Paa][Hand.Guu] = Result.A;
    judgeMap[Hand.Paa][Hand.Choki] = Result.B;
    judgeMap[Hand.Paa][Hand.Paa] = Result.Draw;
  }

  // hashHand is called before createGame() by host
  function hashHand(Hand _hand, string memory _salt)
    public
    pure
    returns (bytes32)
  {
    return keccak256(abi.encodePacked(_hand, _salt));
  }

  function retrieveHand(bytes32 _hashedHand, string memory _salt)
    internal
    pure
    returns (Hand)
  {
    if (hashHand(Hand.Guu, _salt) == _hashedHand) {
      return Hand.Guu;
    } else if (hashHand(Hand.Choki, _salt) == _hashedHand) {
      return Hand.Choki;
    } else if (hashHand(Hand.Paa, _salt) == _hashedHand) {
      return Hand.Paa;
    }
    return Hand.Unknown;
  }

  // judge hand
  function judge(Hand _handA, Hand _handB)
    internal
    view
    validateHand(_handA)
    validateHand(_handB)
    returns (Result)
  {
    return judgeMap[_handA][_handB];
  }
}

// for unittest
contract JankenTest is Janken {
  function _judge(Hand _handA, Hand _handB) external view returns (Result) {
    return judge(_handA, _handB);
  }
}

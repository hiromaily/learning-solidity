const AccountManager = artifacts.require('AccountManager');
const JankenToken = artifacts.require('JankenToken');
const StakePool = artifacts.require('StakePool');
const JankenController = artifacts.require('JankenController');

const { hand, jankenEvent, findEvent, sleep } = require('./helper');
const { nextBlock } = require('./web3');

contract('JankenController', (accounts) => {
  let jankenToken;
  let stakePool;
  let jankenController;
  const deployAndMinter = accounts[0];
  const master = accounts[1];
  const host = accounts[2];
  const guest = accounts[3];

  const integrationTest = async (params) => {
    // 1. hash host's te by salt by host
    const salt = 'salt-string';
    const hostHashedHand = await jankenController.hashHand(
      params.hostHand,
      salt
    );
    console.log('hostHashedHand: ', hostHashedHand);
    assert.equal(
      hostHashedHand,
      params.expectedHash,
      'returned hash is not expected'
    );

    // 2. create game by host
    let resultArgs;
    //const hash = Web3.utils.randomHex(32);
    // 0x875b6a3379d639f0976142f015405e0a4a7dc0f52c7c11debab1ef3fe16f8b93
    try {
      await jankenToken.approve(stakePool.address, params.stake, {
        from: host,
      });
      const tx = await jankenController.createGame(
        params.gameID,
        params.stake,
        hostHashedHand,
        { from: host }
      );
      // {
      //   logIndex: 4,
      //   transactionIndex: 0,
      //   transactionHash: '0xa3de18489df672ed023e42affd2530eb8e01171c893a15ccc7147a14c5bb38b5',
      //   blockHash: '0x3decf1c191139fc232b4d184fa4e97128f4a046db8164d2d774418891ea18f30',
      //   blockNumber: 1682,
      //   address: '0xe1C671508360da1be6443E03786678aA5b9e63e0',
      //   type: 'mined',
      //   id: 'log_949b0661',
      //   event: 'GameCreated',
      //   args: [Result]
      // }

      // 2-2. wait emitted event `GameCreated`
      resultArgs = findEvent(tx.logs, jankenEvent.GameCreated);
    } catch (e) {
      console.log(e);
      assert.fail(e.reason);
    }
    assert.notEqual(resultArgs, undefined, 'event:GameCreated must be emitted');
    assert.equal(
      resultArgs.gameID.toNumber(),
      params.gameID,
      'gameID must be expected value'
    );
    assert.equal(
      resultArgs.stake.toNumber(),
      params.stake,
      'stake must be expected value'
    );
    let hostAmmount = await jankenToken.balanceOf(host);
    assert.equal(
      hostAmmount.toNumber(),
      params.expectedHostAmount,
      'received host amount should be expected amount'
    );

    // 3. join game by guest (guest must be lost in the end)
    try {
      await jankenToken.approve(stakePool.address, params.stake, {
        from: guest,
      });
      const tx = await jankenController.joinGame(
        resultArgs.gameID,
        resultArgs.stake,
        params.guestHand,
        { from: guest }
      );
      // 3-2. wait emitted event `GameReady`
      resultArgs = findEvent(tx.logs, jankenEvent.GameReady);
    } catch (e) {
      console.log(e);
      assert.fail(e.reason);
    }
    assert.notEqual(resultArgs, undefined, 'event:GameReady must be emitted');
    assert.equal(
      resultArgs.gameID.toNumber(),
      params.gameID,
      'gameID must be expected value'
    );
    let guestAmmount = await jankenToken.balanceOf(guest);
    assert.equal(
      guestAmmount.toNumber(),
      params.expectedGuestAmount,
      'received guest amount should be expected amount'
    );

    // 4. start game by host
    // then automatically widhdraw is run for security reason
    try {
      const tx = await jankenController.startGame(resultArgs.gameID, salt, {
        from: host,
      });
      // 4-2. wait emitted event `GameDone`
      resultArgs = findEvent(tx.logs, jankenEvent.GameDone);
    } catch (e) {
      console.log(e);
      assert.fail(e.reason);
    }
    assert.notEqual(resultArgs, undefined, 'event:GameDone must be emitted');
    assert.equal(
      resultArgs.gameID.toNumber(),
      params.gameID,
      'gameID must be expected value'
    );
    assert.equal(
      resultArgs.result.toNumber(),
      params.expectedGameResult,
      'result.A must be expected value'
    );
    hostAmmount = await jankenToken.balanceOf(host);
    guestAmmount = await jankenToken.balanceOf(guest);
    assert.equal(
      hostAmmount.toNumber(),
      params.expectedFinalHostAmount,
      'received host amount should be expected amount'
    );
    assert.equal(
      guestAmmount.toNumber(),
      params.expectedFinalGuestAmount,
      'received guest amount should be expected amount'
    );
  };

  before(async () => {
    const acntMgr = await AccountManager.new(
      deployAndMinter,
      master,
      host,
      guest
    );
    jankenToken = await JankenToken.new();
    stakePool = await StakePool.new(acntMgr.address, jankenToken.address);
    acntMgr.setStakePoolAddress(stakePool.address, { from: deployAndMinter });
    jankenController = await JankenController.new(
      acntMgr.address,
      stakePool.address
    );
    acntMgr.setJankenControllerAddress(jankenController.address, {
      from: deployAndMinter,
    });
  });

  //describe.skip("integration test", async () => {
  describe('integration test', async () => {
    before('call mint() first for initial token of master', async () => {
      await jankenToken.mint(deployAndMinter, 10000, { from: deployAndMinter });
      // transfer to host/guest for game
      // expects that transfer token from master to host
      // jankenToken.approve(host, 1000, { from: deployAndMinter } );
      // jankenToken.approve(guest, 1000, { from: deployAndMinter } );
      jankenToken.transfer(host, 1000, { from: deployAndMinter });
      jankenToken.transfer(guest, 1000, { from: deployAndMinter });
    });

    it('makes sure sequencial flow, host should win', async () => {
      const params = {
        gameID: 123,
        stake: 100,
        hostHand: hand.guu,
        guestHand: hand.choki,
        expectedHash:
          '0xc92c4cb073b716352100c81c1faa48e18c4a10914772709fb7b9973c54526d38',
        expectedHostAmount: 900,
        expectedGuestAmount: 900,
        expectedGameResult: 0,
        expectedFinalHostAmount: 1100,
        expectedFinalGuestAmount: 900,
      };
      await integrationTest(params);
    });

    it('makes sure sequencial flow, guest should win', async () => {
      const params = {
        gameID: 124,
        stake: 200,
        hostHand: hand.choki,
        guestHand: hand.guu,
        expectedHash:
          '0x952fe134268ee4bc883cc10451ea8017790f8863b4e10ceee03dd5191b4c4ddd',
        expectedHostAmount: 900,
        expectedGuestAmount: 700,
        expectedGameResult: 1,
        expectedFinalHostAmount: 900,
        expectedFinalGuestAmount: 1100,
      };
      await integrationTest(params);
    });

    it('makes sure sequencial flow, result must be draw', async () => {
      const params = {
        gameID: 125,
        stake: 300,
        hostHand: hand.paa,
        guestHand: hand.paa,
        expectedHash:
          '0x75f6e26b8bfb3e2f27b5309066961a2b0eb1212367c3e2e48bac3cfd5545f3fb',
        expectedHostAmount: 600,
        expectedGuestAmount: 800,
        expectedGameResult: 2,
        expectedFinalHostAmount: 900,
        expectedFinalGuestAmount: 1100,
      };
      await integrationTest(params);
    });

    it('checks timeout: gameStart must not be run after timeout', async () => {
      const salt = 'salt-string';
      const hostHand = hand.guu;
      const guestHand = hand.choki;
      const stake = 100;
      const gameID = 200;
      const expectexpectedFinalHostAmountedFinal = 800;
      const expectedFinalGuestAmount = 1200;

      // create game
      const hostHashedHand = await jankenController.hashHand(hostHand, salt);
      await jankenToken.approve(stakePool.address, stake, { from: host });
      let tx = await jankenController.createGame(
        gameID,
        stake,
        hostHashedHand,
        { from: host }
      );
      let resultArgs = findEvent(tx.logs, jankenEvent.GameCreated);

      // join game
      await jankenToken.approve(stakePool.address, stake, { from: guest });
      tx = await jankenController.joinGame(
        resultArgs.gameID,
        resultArgs.stake,
        guestHand,
        { from: guest }
      );
      resultArgs = findEvent(tx.logs, jankenEvent.GameReady);

      // check timeout
      let isTimedout = false;
      for (let idx = 0; idx < 10; idx++) {
        try {
          tx = await jankenController.cancelTimedoutGame(gameID, {
            from: guest,
          });
          resultArgs = findEvent(tx.logs, jankenEvent.GameCanceled);
          if (resultArgs) {
            console.log('timed out!');
            isTimedout = true;
            break;
          }
          await sleep(100);
        } catch (e) {
          console.log(e.reason);
        }
      }
      assert.equal(isTimedout, true, 'timeout is not happened');
      const hostAmmount = await jankenToken.balanceOf(host);
      const guestAmmount = await jankenToken.balanceOf(guest);
      assert.equal(
        hostAmmount.toNumber(),
        expectexpectedFinalHostAmountedFinal,
        'received host amount should be expected amount'
      );
      assert.equal(
        guestAmmount.toNumber(),
        expectedFinalGuestAmount,
        'received guest amount should be expected amount'
      );

      // call startGame(), must not be allowed to start game
      let err;
      try {
        const tx = await jankenController.startGame(gameID, salt, {
          from: host,
        });
      } catch (e) {
        err = e;
      }
      assert.equal(
        err.reason,
        'game.status must be expected status: [actual status] 3',
        'err should not be undefined'
      );
    });

    it('checks timeout: game must be  canceled when timeout happens', async () => {
      const salt = 'salt-string';
      const hostHand = hand.guu;
      const guestHand = hand.choki;
      const stake = 100;
      const gameID = 201;
      const expectexpectedFinalHostAmountedFinal = 700;
      const expectedFinalGuestAmount = 1300;

      // create game
      const hostHashedHand = await jankenController.hashHand(hostHand, salt);
      await jankenToken.approve(stakePool.address, stake, { from: host });
      let tx = await jankenController.createGame(
        gameID,
        stake,
        hostHashedHand,
        { from: host }
      );
      let resultArgs = findEvent(tx.logs, jankenEvent.GameCreated);

      // join game
      await jankenToken.approve(stakePool.address, stake, { from: guest });
      tx = await jankenController.joinGame(
        resultArgs.gameID,
        resultArgs.stake,
        guestHand,
        { from: guest }
      );
      resultArgs = findEvent(tx.logs, jankenEvent.GameReady);

      // call nextBlock() to make block moved forward
      for (let idx = 0; idx < 10; idx++) {
        // const tx = await jankenController.gameInfo(gameID);
        // resultArgs = findEvent(tx.logs, jankenEvent.GameInfo);
        // console.log(" game:", resultArgs.game);
        await nextBlock();
      }
      // start game
      tx = await jankenController.startGame(gameID, salt, { from: host });
      resultArgs = findEvent(tx.logs, jankenEvent.GameCanceled);
      assert.notEqual(
        resultArgs,
        undefined,
        'event:GameCanceled must be emitted'
      );

      const hostAmmount = await jankenToken.balanceOf(host);
      const guestAmmount = await jankenToken.balanceOf(guest);
      assert.equal(
        hostAmmount.toNumber(),
        expectexpectedFinalHostAmountedFinal,
        'received host amount should be expected amount'
      );
      assert.equal(
        guestAmmount.toNumber(),
        expectedFinalGuestAmount,
        'received guest amount should be expected amount'
      );
    });
  });
});

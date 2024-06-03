const JankenToken = artifacts.require('JankenToken');

contract('JankenToken', (accounts) => {
  let jankenToken;

  before(async () => {
    jankenToken = await JankenToken.new();
  });

  describe('call mint()', async () => {
    // before("adopt a pet using accounts[0]", async () => {
    //   await adoption.adopt(8, { from: accounts[0] });
    //   expectedAdopter = accounts[0];
    // });

    it('call mint() by admin address', async () => {
      const setAmount = 10000;

      for (let idx = 0; idx < 5; idx++) {
        await jankenToken.mint(accounts[idx], setAmount);
        const accountAmmount = await jankenToken.balanceOf(accounts[idx]);
        assert.equal(
          accountAmmount,
          setAmount,
          'target account should own set amount'
        );
      }
    });

    it('call mint() by NOT admin address', async () => {
      const setAmount = 10000;

      for (let idx = 0; idx < 5; idx++) {
        let err;
        await jankenToken
          .mint(accounts[idx], setAmount, { from: accounts[1] })
          .catch((e) => {
            err = e;
            return;
          });
        assert.equal(
          err.reason,
          'Caller is not a admin',
          'err should not be undefined'
        );
      }
    });
  });
});

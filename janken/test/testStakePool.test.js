const AccountManager = artifacts.require('AccountManager');
const JankenToken = artifacts.require('JankenToken');
const StakePool = artifacts.require('StakePool');
const JankenControllerTest = artifacts.require('JankenControllerTest');
const StringLib = artifacts.require('StringLib');
const AddressLib = artifacts.require('AddressLib');

contract('StakePool', (accounts) => {
  let jankenToken;
  let stakePool;
  let jankenController;

  const deployAndMinter = accounts[0];
  const master = accounts[1];
  const host = accounts[2];
  const guest = accounts[3];

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
    jankenController = await JankenControllerTest.new(
      acntMgr.address,
      stakePool.address
    );
    acntMgr.setJankenControllerAddress(jankenController.address, {
      from: deployAndMinter,
    });
  });

  describe('call depositToken()', async () => {
    before('call mint() first for initial token', async () => {
      await jankenToken.mint(host, 10000);
    });

    it('call deposit() by normal address', async () => {
      const setAmount = 100;
      const addrTarget = stakePool.address;

      // FIXME:
      await jankenToken.approve(stakePool.address, setAmount, { from: host });
      // depositToken of stakePool must be called through jankenController
      await jankenController._depositToken(host, setAmount, { from: host });

      let accountAmmount = await jankenToken.balanceOf(addrTarget);
      assert.equal(
        accountAmmount,
        100,
        'received account should own expected amount'
      );

      accountAmmount = await jankenToken.balanceOf(host);
      assert.equal(
        accountAmmount,
        9900,
        'sending account should own expected amount'
      );
    });
  });
});

const AccountManager = artifacts.require("AccountManager");
const JankenToken = artifacts.require("JankenToken");
const StakePool = artifacts.require("StakePool");
//const Janken = artifacts.require("Janken");
const JankenController = artifacts.require("JankenController");
const JankenControllerTest = artifacts.require("JankenControllerTest");
const StringLib = artifacts.require("StringLib");
const AddressLib = artifacts.require("AddressLib");
const UintLib = artifacts.require("UintLib");

module.exports = async (deployer, _network, accounts) => {
  const deployAndMinter = accounts[0];
  const master = accounts[1];
  const host = accounts[2];
  const guest = accounts[3];

  // 1. stringLib
  await deployer.deploy(StringLib);
  await deployer.link(StringLib, AccountManager);
  await deployer.link(StringLib, StakePool);
  await deployer.link(StringLib, JankenController);
  await deployer.link(StringLib, JankenControllerTest);
  // 2. addressLib
  await deployer.deploy(AddressLib);
  await deployer.link(AddressLib, AccountManager);
  await deployer.link(AddressLib, StakePool);
  await deployer.link(AddressLib, JankenController);
  await deployer.link(AddressLib, JankenControllerTest);
  // 3. uintLib
  await deployer.deploy(UintLib);
  await deployer.link(UintLib, JankenController);
  await deployer.link(UintLib, JankenControllerTest);

  // 4. accountManager
  await deployer.deploy(AccountManager, deployAndMinter, master, host, guest, { from: deployAndMinter });
  const acntMgr = await AccountManager.deployed();
  // 5. jankenToken
  await deployer.deploy(JankenToken);
  const jankenToken = await JankenToken.deployed();
  // 5.2. mint
  await jankenToken.mint(deployAndMinter, 10000, { from: deployAndMinter });
  // 6. stakePool
  await deployer.deploy(StakePool, acntMgr.address, jankenToken.address);
  const stakePool = await StakePool.deployed();
  acntMgr.setStakePoolAddress(stakePool.address, { from: deployAndMinter });
  // 6. janken
  //await deployer.deploy(Janken);
  // 7. jankenController
  await deployer.deploy(JankenController, acntMgr.address, stakePool.address);
  const jankenController = await JankenController.deployed();
  acntMgr.setJankenControllerAddress(jankenController.address, { from: deployAndMinter });
};

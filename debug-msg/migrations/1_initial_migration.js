const Migrations = artifacts.require('Migrations');
// const Web3 = require('web3');
// const TruffleConfig = require('../truffle-config');
// TODO: define at environment variable
const targetAddress = '0xC6b6586B59D9405ad169D2C1Bf43C3BF49ef56E5';

module.exports = (deployer) => {
  //module.exports = (deployer, network, accounts) => {
  // const cfg = TruffleConfig.networks[network];
  // if (process.env.ACCOUNT_PASSWORD) {
  //   const web3 = new Web3(new Web3.providers.HttpProvider(`http://${cfg.host}:${cfg.port}`));

  //   console.log(`>> Unlocking account ${targetAddress}`);
  //   web3.personal.unlockAccount(targetAddress, process.env.ACCOUNT_PASSWORD, 36000);
  // }
  deployer.deploy(Migrations, { from: targetAddress });
};

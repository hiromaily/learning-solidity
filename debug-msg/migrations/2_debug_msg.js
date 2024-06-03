const DebugMsg = artifacts.require("DebugMsg");

module.exports = function(_deployer) {
  //const deployAndMinter = accounts[0];
  _deployer.deploy(DebugMsg);
};

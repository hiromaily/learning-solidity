const ContractMigrations = artifacts.require("ContractMigrations");

module.exports = (deployer) => {
  deployer.deploy(ContractMigrations);
};

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

// Note: deploy must be run before deploying code

import "./Player.sol";
import "./StringLib.sol";
import "./AddressLib.sol";

/* AccountManager
- any address is managed by this contract 
 account[0] = minter and deployer: only minter can handle JankenToken,
 account[1] = game master:
 account[2] = host:
 account[3] = guest:
- TODO:
  - security issue
*/

contract AccountManager is Player {
  using StringLib for string;
  using AddressLib for address;

  mapping(Account => address) private accounts;

  enum Account {
    Deployer,
    Minter,
    Master,
    Host,
    Guest,
    StakePool,
    JankenController
  }

  modifier mustBeDeployer() {
    string memory _msg = "only deployer address is allowed:[sender address] ";
    require(
      msg.sender == accounts[Account.Deployer],
      _msg.join(msg.sender.toString()).join(",[expected address] ").join(
        accounts[Account.Deployer].toString()
      )
    );
    _;
  }

  modifier mustBeMinter() {
    require(
      msg.sender != accounts[Account.Minter],
      "only minter address is allowed"
    );
    _;
  }

  modifier mustBeMaster() {
    require(
      msg.sender != accounts[Account.Master],
      "only master address is allowed"
    );
    _;
  }

  modifier mustBeHost() {
    require(
      msg.sender != accounts[Account.Host],
      "only host address is allowed"
    );
    _;
  }

  modifier mustBeGuest() {
    require(
      msg.sender != accounts[Account.Guest],
      "only guest address is allowed"
    );
    _;
  }

  modifier mustBeStakePool() {
    require(
      msg.sender != accounts[Account.StakePool],
      "only StakePool contract address is allowed"
    );
    _;
  }

  modifier mustBeJankenController() {
    require(
      msg.sender != accounts[Account.JankenController],
      "only JankenController contract address is allowed"
    );
    _;
  }

  constructor(
    address _addrDeployAndMinter,
    address _addrMaster,
    address _addrHost,
    address _addrGuest
  ) {
    accounts[Account.Deployer] = msg.sender;
    accounts[Account.Minter] = _addrDeployAndMinter;
    accounts[Account.Master] = _addrMaster;
    addPlayer(_addrGuest);
    addPlayer(_addrHost);
    setHost(_addrHost);
  }

  // not used anywhere yet
  function getMinterAddress() public view returns (address) {
    return accounts[Account.Minter];
  }

  function getMasterAddress() public view returns (address) {
    return accounts[Account.Master];
  }

  function getHostAddress() public view returns (address) {
    return addrHost;
  }

  // not used anywhere yet
  function getStakePoolAddress() public view returns (address) {
    return accounts[Account.StakePool];
  }

  function getJankenControllerAddress() public view returns (address) {
    return accounts[Account.JankenController];
  }

  function setStakePoolAddress(address _addr) external mustBeDeployer {
    accounts[Account.StakePool] = _addr;
  }

  function setJankenControllerAddress(address _addr) external mustBeDeployer {
    accounts[Account.JankenController] = _addr;
  }
}

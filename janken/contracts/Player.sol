// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

abstract contract Player {
  address addrHost;

  enum PlayerAccount {
    Default,
    Guest,
    Host
  }
  mapping(address => PlayerAccount) private players;

  modifier existingAddr(address _addr) {
    require(
      players[_addr] != PlayerAccount.Default,
      "address is not existing yet"
    );
    _;
  }

  modifier notExistingAddr(address _addr) {
    require(
      players[_addr] == PlayerAccount.Default,
      "address is already existing"
    );
    _;
  }

  constructor() {
    addrHost = address(0);
  }

  function isGuest(address _addr)
    public
    view
    existingAddr(_addr)
    returns (bool)
  {
    if (_addr != addrHost) {
      return true;
    }
    return false;
  }

  function isHost(address _addr)
    public
    view
    existingAddr(_addr)
    returns (bool)
  {
    if (_addr == addrHost) {
      return true;
    }
    return false;
  }

  function addPlayer(address _addr) public notExistingAddr(_addr) {
    players[_addr] = PlayerAccount.Guest;
  }

  function setHost(address _addr) public existingAddr(_addr) {
    if (addrHost != address(0)) {
      players[addrHost] = PlayerAccount.Guest;
    }
    addrHost = _addr;
    players[_addr] = PlayerAccount.Host;
  }
}

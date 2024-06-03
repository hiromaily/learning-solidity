// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/* JankenToken
- only this contract has token 
- only mint/burn are called from outside master client apps
- token is owned by minter/host/guest/stake pool address
- TODO:
*/

contract JankenToken is ERC20, AccessControl {
  bytes32 private constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

  constructor() ERC20("JankenToken", "JKT") {
    _setupRole(ADMIN_ROLE, msg.sender);
  }

  function mint(address _account, uint256 _amount) external {
    require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a admin");
    _mint(_account, _amount);
  }

  function burn(address _account, uint256 _amount) external {
    require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a admin");
    _burn(_account, _amount);
  }
}

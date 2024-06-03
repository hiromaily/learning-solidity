// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

import "./JankenToken.sol";
import "./AccountManager.sol";
import "./StringLib.sol";
import "./AddressLib.sol";

/* StakePool
- can call ERC20 functions through private variable
  which has JankenToken address.
- but mint/burn must not be called from this contract in any way
- has logical amount of token, actual token is handled by JankenToken
- TODO:
- implement logical transfer from JankenController
- tell differences real transfer and logical transfer
  - transfer: real transfer
  - deposit: logical transfer
- Interface definition may be required to limit functionality for this contract
*/

contract StakePool {
  using StringLib for string;
  using AddressLib for address;

  address owner;
  AccountManager private accountManager;

  // must not JankenToken itself to avoid from calling mint()
  IERC20 private jankenToken;

  event Deposit(address from, address to, uint256 amount);

  modifier mustBeJankenController() {

      string memory _msg
     = "only JankenController address is allowed:[sender address] ";
    require(
      msg.sender == accountManager.getJankenControllerAddress(),
      _msg.join(msg.sender.toString()).join(",[expected address] ").join(
        accountManager.getJankenControllerAddress().toString()
      )
    );
    _;
  }

  modifier hasBalance(address _addrSender, uint256 _expectedAmount) {
    require(
      jankenToken.balanceOf(_addrSender) >= _expectedAmount,
      "balance is not enought"
    );
    _;
  }

  modifier hasAllowance(
    address _addrSender,
    address _addrReceiver,
    uint256 _expectedAmount
  ) {
    require(
      jankenToken.allowance(_addrSender, _addrReceiver) >= _expectedAmount,
      "allowance is not enought"
    );
    _;
  }

  constructor(address _addrAccountManager, address _addrJankenToken) {
    accountManager = AccountManager(_addrAccountManager);
    // must not JankenToken itself to avoid from calling mint
    jankenToken = IERC20(_addrJankenToken);

    //accountManager.setStakePoolAddress(address(this));

    // set StakePool address as owner
    owner = address(this);
  }

  // TODO: security
  // sender to owner
  function depositToken(address _sender, uint256 _stake)
    external
    hasBalance(_sender, _stake)
    mustBeJankenController
  {
    // when direct call outer contract, sender.msg is different from this sender.msg
    // sender.msg must be stakePool address in jankenToken
    depositTo(_sender, owner, _stake);
  }

  // TODO: security
  // transfer token from to
  // - this function would be called from outside contract
  function depositTo(
    address _addrSender,
    address _addrReceiver,
    uint256 _stake
  ) private {
    require(
      jankenToken.transferFrom(_addrSender, _addrReceiver, _stake),
      "failed to call transferFrom()"
    );

    // emit event is required to avoid error `Ambiguous event, possible interpretations`
    emit Deposit(_addrSender, _addrReceiver, _stake);
  }

  // TODO: security
  function widhdrawDeposit(address _addrWinner, uint256 _amount)
    external
    mustBeJankenController
  {
    // jankenToken.approve(address(this), _amount);
    // depositTo(owner, _addrWinner, _amount);
    jankenToken.transfer(_addrWinner, _amount);
  }
}

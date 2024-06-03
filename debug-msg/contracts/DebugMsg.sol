// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

contract DebugMsg {
  uint256 counter = 0;

  modifier validateNum(uint256 _num) {
    require(_num == 0, "only 0 is allowed");
    _;
  }

  constructor() {}

  function updateCounter(uint256 _num)
    public
    validateNum(_num)
    returns (uint256)
  {
    counter = _num;
    return _num;
  }

  function returnParam(uint256 _num)
    public
    pure
    validateNum(_num)
    returns (uint256)
  {
    return _num;
  }

  function getByte32Beacon() public view returns(bytes32){
    return bytes32(uint256(keccak256('eip1967.proxy.beacon')) - 1);
  }

  function getByte32Logic() public view returns(bytes32){
    return bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1);
  }

  function getByte32Admin() public view returns(bytes32){
    return bytes32(uint256(keccak256('eip1967.proxy.admin')) - 1);
  }
}

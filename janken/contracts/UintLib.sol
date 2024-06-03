// SPDX-License-Identifier: MIT
pragma solidity >=0.6.8 <0.9.0;

library UintLib {
  function toString(uint256 num) external pure returns (string memory str) {
    uint256 maxlength = 100;
    bytes memory reversed = new bytes(maxlength);
    uint256 i = 0;
    while (num != 0) {
      uint256 remainder = num % 10;
      num = num / 10;
      reversed[i++] = bytes1(uint8(48 + remainder));
    }
    bytes memory s = new bytes(i);
    for (uint256 j = 0; j < i; j++) {
      s[j] = reversed[i - 1 - j];
    }
    str = string(s);
  }
}

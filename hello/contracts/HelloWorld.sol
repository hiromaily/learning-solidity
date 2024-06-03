// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// contract HelloWorld {
//   constructor() public {
//   }
// }

contract HelloWorld {
  string defaultMessage;
  constructor() public {
    defaultMessage = 'Hello World';
  }
  function getMessage() public view returns(string memory){
    return defaultMessage;
  }
}

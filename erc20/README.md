# ERC20トークン作成のコード
```
$ mkdir erc20

$ npm install @openzeppelin/contracts
```

```
$ truffle init
$ truffle create contract MyToken

modify code

```
- https://docs.openzeppelin.com/contracts/4.x/erc20

```
$ truffle compile

$ truffle create migration MyToken
modify migrations/16xxxxxxxx_my_token.js

$ truffle migrate
 or
$ truffle migrate --reset

```

## Console operation
```
truffle console
```
```
truffle(development)> let myToken = await MyToken.deployed()
truffle(development)> myToken.balanceOf('0xF0Ab727aC703158A9BAD1D03c286ABfc6e4F1678') //ganacheの消費されているアカウント
=>
BN {
  negative: 0,
  words: [ 1000, <1 empty item> ],
  length: 1,
  red: null
}
```

```
truffle(development)> myToken.transfer('0x6456049a4E40e14A73d233DD4D92aaCC6ef8f187', 1000)  //2番目のアドレスを指定
truffle(development)> myToken.balanceOf('0x6456049a4E40e14A73d233DD4D92aaCC6ef8f187')
truffle(development)> myToken.balanceOf('0xF0Ab727aC703158A9BAD1D03c286ABfc6e4F1678')
```


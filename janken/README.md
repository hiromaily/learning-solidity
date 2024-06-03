# Janken

## TODO

- [ ] guest による、joinGame()後、timeout を設定し、指定時間までに host が startGame()を実行しなければ、host の負けとする。
  - master は基本的に game に介入することなく、コントラクトのロジックだけで資産が移動できるようにしないとダメ
  - 可能な限り trustless である(master すら信用しなくて良い)
  - 実行者を master に制限せず誰でも実行できるようにしたほうが良い
- [ ] セキュリティーを考慮したリファクタリング
  - pure/view function なら transaction が発行されないのでセキュア？？
- [ ] host/guest が必要な機能はそれぞれしか実行できないようにする
- [x] mint は限られたコントラクトしか実行できないようにする、つまり token は独立させる。admin すら悪意がある行為ができないようにする(trustless)。
  - remove JankenToken from StakePool
  - JankenController calls JankenToken itself
  - only JankenToken can call mint()
  - JankenToken all approve()
  - JankenController calls deposit() or transfer()
- [x] StakePool の機能スコープの修正
  - mint()は実行できてはならない
  - ユーザー毎の残高を持つ
  - transfer()は外部から呼び出せないようにする
- [x] JankenController からしか StakePool を呼び出せないようにする => JankenController のアドレスを指定して実行すると、testStakePool.test でエラーになる。`Error: Returned error: sender account not recognized`
- [x] そのために JankenController のアドレスを AccountManager に登録しておく
- [x] Token が保持されるのはあくまでも ERC20、もしくは ERC20 を継承しているコントラクトである。mapping で保持している。つまりそのコントラクトの storage。
  - つまりコントラクタが違えば、同じアドレスに transfer したとしても、見ている先は別物
- [x] 最初に mint するのは master アドレスのみ
- [x] transfer()前に approve を呼ばないといけない
- [x] JankenController の createGame()のなかで、host に master から transfer してやる
  - approve はその送金者によって実行される必要があるため、外部コントラクト呼び出しをしている限り、難しい
  - stakePool は継承したほうがいいかも
- [x] StakePool コントラクトでは mint できない方がいい。->Admin アカウントでしか実行できない。

## frequent error

1. TypeError: Contract "JankenController" should be marked as abstract.

- [Contract should be marked as abstract](https://ethereum.stackexchange.com/questions/83267/contract-should-be-marked-as-abstract)
- [Solidity Inheritance: Use of Constructors, Interfaces and Arguments](https://www.bitdegree.org/learn/solidity-inheritance)

- Returned error: VM Exception while processing transaction: revert ERC20: transfer amount exceeds allowance -- Reason given: ERC20: transfer amount exceeds allowance
  - should call approve() properly

## working history

```
$ yarn add @openzeppelin/contracts
```

```
$ truffle init

$ truffle create contract AccountManager
$ truffle create migration AccountManager

$ truffle create contract JankenToken
$ truffle create migration JankenToken

$ truffle create contract StakePool
$ truffle create migration StakePool

$ truffle create contract Janken
$ truffle create migration Janken

$ truffle create contract JankenController
$ truffle create migration JankenController

```

```
$ truffle console
 or
$ truffle develop --log

truffle(development)> let jc = await JankenController.deployed()
truffle(development)> jc.createGame(123, 100, 0x875b6a3379d639f0976142f015405e0a4a7dc0f52c7c11debab1ef3fe16f8b93)

truffle(development)> let sp = await StakePool.deployed()
truffle(development)> sp.balanceOf('0x6456049a4E40e14A73d233DD4D92aaCC6ef8f187')

```

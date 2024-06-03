# Learning-solidity

## 準備 (Ethereum のプライベートネットワークをローカルに作る)

```sh
$ cd target directory
$ truffle init
```

```sh
Try our scaffold commands to get started:
  $ truffle create contract YourContractName # scaffold a contract
  $ truffle create test YourTestName         # scaffold a test
```

- modify truffle-config.js (port should be 7545)
- open ganache
  - new workspace
  - add project `select target truffle-config.js`
  - save

## 確認

```sh
$ truffle console
```

## HelloWorld コントラクトを作成

```sh
$ truffle create contract HelloWorld
```

- modify contracts/HelloWOrld.sol

## コンパイル

```sh
$ truffle compile
```

## マイグレーションファイル作成 for deployment

```sh
$ truffle create migration HelloWorld
```

- modify migrations/16xxxxxxxx_hello_world.js

## デプロイ

```sh
$ truffle migrate
```

migrate コマンドは前回のデプロイが成功だった場合、それ以降の新しいマイグレーションだけ実行する。
なので、一度デプロイしたコントラクトコードを修正した場合は以下のコマンドを実行することで新しいコントラクトコードでデプロイしなおす必要がある。

```sh
$ truffle migrate --reset
```

## HelloWorld の動作確認

- コンソールから HelloWorld コントラクトの動作確認ができる

```sh
$ truffle console
```

```sh
truffle(development)> let helloWorld = await HelloWorld.deployed()
truffle(development)> helloWorld.getMessage()
'Hello World'
```

## スマートコントラクタの Test

```sh
$ truffle test
```

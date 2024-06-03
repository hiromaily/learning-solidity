const HDWalletProvider = require("@truffle/hdwallet-provider");
const Web3 = require("web3");

const mnemonicPhrase = "cradle update plug wolf soup unhappy asset elbow play stereo genuine wise"; // 12 word mnemonic

let provider = new HDWalletProvider({
  mnemonic: mnemonicPhrase,
  providerOrUrl: "http://localhost:8545",
  numberOfAddresses: 10,
  shareNonce: true,
  derivationPath: "m/44'/9099000'/1'/0/" // same to mycelo
});
// m/44'/%d'/%d'/0/%d

for (let i = 0; i < 10; i++) {
  console.log(`address:${provider.getAddress(i)}`);
}

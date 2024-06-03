const Web3 = require("web3");
const web3 = new Web3("http://127.0.0.1:8545");
web3.eth.handleRevert = true;

const contractAbi = require("../build/contracts/DebugMsg.json").abi;
const conAddress = "0xa34e3D812F5eBe9B64073D8D5EeEC9029E246802";

const contract = new web3.eth.Contract(contractAbi, conAddress);

const callUpdateCounter = async (owner, param) => {
  const txObject = {
    from: owner,
    to: conAddress,
    data: contract.methods.updateCounter(param).encodeABI()
  };
  return await web3.eth.sendTransaction(txObject);
};

const callReturnParam = async (owner, param) => {
  const txObject = {
    from: owner,
    to: conAddress,
    data: contract.methods.returnParam(param).encodeABI()
  };
  return await web3.eth.call(txObject);
};

const main = async () => {
  const owner = '0xF512F9E94c7B97916ec69cd80F3750F4410EaA63';
  try {
    //const txHash = await callReturnParam(owner, 1);
    const txHash = await callUpdateCounter(owner, 1);
    console.log(`tx hash: ${txHash}`);  
  } catch (e) {
    console.log(`error in main: ${e}`);
    console.dir(e);
  }
  //when calling callReturnParam()
  //Error: Error: Returned error: execution reverted  
}
main();

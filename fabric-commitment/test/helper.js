const decodeEvent = {
  CommitmentProofInfo: 'CommitmentProofInfo',
  ProposalResponsePayload: 'ProposalResponsePayload',
  ChaincodeAction: 'ChaincodeAction',
  TxReadWriteSet: 'TxReadWriteSet',
  KVRWsetKVRWSet: 'KVRWsetKVRWSet',
  KVRWsetHashedRWSet: 'KVRWsetHashedRWSet',
  KVRWsetHashedRWSets: 'KVRWsetHashedRWSets',
  MspIdentity: 'MspIdentity',
  MspIdentities: 'MspIdentities',
};

const findEvent = (logs, eventName) => {
  if (!logs) {
    return false;
  }
  let result = undefined;
  logs.forEach((elem, index) => {
    if (elem.event == eventName) {
      result = elem.args;
      return;
    }
  });
  return result;
};

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

module.exports = {
  decodeEvent,
  findEvent,
  sleep,
};

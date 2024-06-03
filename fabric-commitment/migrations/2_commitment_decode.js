const FabricCommitment = artifacts.require("FabricCommitment");
const FabricTxRwSet = artifacts.require("FabricTxRwSet");

const IbcLightclientsFabricV1CommitmentProof = artifacts.require("IbcLightclientsFabricV1CommitmentProof");
const ProtosProposalResponsePayload = artifacts.require("ProtosProposalResponsePayload");
const ProtosChaincodeAction = artifacts.require("ProtosChaincodeAction");
const RwsetTxReadWriteSet = artifacts.require("RwsetTxReadWriteSet");
const KvrwsetKVRWSet = artifacts.require("KvrwsetKVRWSet");
const KvrwsetHashedRWSet = artifacts.require("KvrwsetHashedRWSet");
const MspSerializedIdentity = artifacts.require("MspSerializedIdentity");

module.exports = async (deployer) => {
  // deployer.deploy(FabricTxRwSet).then(function() {
  //   return deployer.link(FabricTxRwSet, [ProtosProposalResponsePayload, ProtosChaincodeAction, RwsetTxReadWriteSet, KvrwsetKVRWSet, KvrwsetHashedRWSet]);
  // });

  // deployer.deploy(FabricCommitment).then(function() {
  //   return deployer.link(FabricCommitment, [IbcLightclientsFabricV1CommitmentProof, MspSerializedIdentity, FabricTxRwSet]);
  // });


  await deployer.deploy(IbcLightclientsFabricV1CommitmentProof);
  await deployer.deploy(ProtosProposalResponsePayload);
  await deployer.deploy(ProtosChaincodeAction);
  await deployer.deploy(RwsetTxReadWriteSet);
  await deployer.deploy(KvrwsetKVRWSet);
  await deployer.deploy(KvrwsetHashedRWSet);
  await deployer.deploy(MspSerializedIdentity);
  await deployer.deploy(FabricTxRwSet);

  await deployer.link(ProtosProposalResponsePayload, FabricTxRwSet);
  await deployer.link(ProtosChaincodeAction, FabricTxRwSet);
  await deployer.link(RwsetTxReadWriteSet, FabricTxRwSet);
  await deployer.link(KvrwsetKVRWSet, FabricTxRwSet);
  await deployer.link(KvrwsetHashedRWSet, FabricTxRwSet);

  await deployer.link(IbcLightclientsFabricV1CommitmentProof, FabricCommitment);
  await deployer.link(MspSerializedIdentity, FabricCommitment);
  await deployer.link(FabricTxRwSet, FabricCommitment);

  deployer.deploy(FabricCommitment);
};

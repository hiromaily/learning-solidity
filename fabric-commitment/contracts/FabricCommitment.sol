// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./ibc/lightclients/fabric/v1/fabric.sol";
import "./fabric/msp/identities.sol";
import "./FabricTxRwSet.sol";

// refer to
// https://ittone.ma/ittone/javascript-how-to-send-bytes-parameters-from-web3-js-to-solidity-contract/
contract FabricCommitment {
  event KVRWsetHashedRWSets(KvrwsetHashedRWSet.Data[] data);
  event MspIdentities(MspSerializedIdentity.Data[] data);

  function decode(bytes memory commitment) external {
    // decode commitment proof
    IbcLightclientsFabricV1CommitmentProof.Data
      memory data = IbcLightclientsFabricV1CommitmentProof.decode(commitment);

    // decode proposal to get hashedRWSets
    KvrwsetHashedRWSet.Data[] memory hashedRWSets = FabricTxRwSet.decode(
      data.proposal
    );
    emit KVRWsetHashedRWSets(hashedRWSets);

    // decode identities
    MspSerializedIdentity.Data[]
      memory identities = new MspSerializedIdentity.Data[](
        data.identities.length
      );
    for (uint256 i = 0; i < data.identities.length; i++) {
      identities[i] = MspSerializedIdentity.decode(data.identities[i]);
    }
    emit MspIdentities(identities);
  }
}

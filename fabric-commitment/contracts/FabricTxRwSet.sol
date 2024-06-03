// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./fabric/peer/proposal.sol";
import "./fabric/peer/proposal_response.sol";
import "./fabric/ledger/rwset/rwset.sol";
import "./fabric/ledger/rwset/kvrwset/kv_rwset.sol";

library FabricTxRwSet {
  function decode(bytes memory proposal)
    external
    pure
    returns (KvrwsetHashedRWSet.Data[] memory)
  {
    // decode data.proposal
    ProtosProposalResponsePayload.Data
      memory payload = ProtosProposalResponsePayload.decode(proposal);

    // decode payload.extension
    ProtosChaincodeAction.Data memory chaincodeAction = ProtosChaincodeAction
      .decode(payload.extension);

    // decode chaincodeAction.results
    RwsetTxReadWriteSet.Data memory txRWSet = RwsetTxReadWriteSet.decode(
      chaincodeAction.results
    );

    // decode txRWSet.ns_rwset[i].rwset
    KvrwsetKVRWSet.Data[] memory kvrwsets = new KvrwsetKVRWSet.Data[](
      txRWSet.ns_rwset.length
    );
    for (uint256 i = 0; i < txRWSet.ns_rwset.length; i++) {
      kvrwsets[i] = KvrwsetKVRWSet.decode(txRWSet.ns_rwset[i].rwset);
    }
    // get count of KvrwsetHashedRWSet.Data
    uint256 hashedRWSetsCount;
    for (uint256 i = 0; i < kvrwsets.length; i++) {
      hashedRWSetsCount += txRWSet.ns_rwset[i].collection_hashed_rwset.length;
    }

    // decode txRWSet.ns_rwset[i].collection_hashed_rwset[j].hashed_rwset
    KvrwsetHashedRWSet.Data[]
      memory hashedRWSets = new KvrwsetHashedRWSet.Data[](hashedRWSetsCount);
    uint256 counter;
    for (uint256 i = 0; i < kvrwsets.length; i++) {
      for (
        uint256 j = 0;
        j < txRWSet.ns_rwset[i].collection_hashed_rwset.length;
        j++
      ) {
        hashedRWSets[counter] = KvrwsetHashedRWSet.decode(
          txRWSet.ns_rwset[i].collection_hashed_rwset[j].hashed_rwset
        );
        counter++;
      }
    }
    return hashedRWSets;
  }
}

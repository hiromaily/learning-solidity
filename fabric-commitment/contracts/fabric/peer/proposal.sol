// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";
import "./chaincode.sol";
import "./proposal_response.sol";

library ProtosSignedProposal {
  //struct definition
  struct Data {
    bytes proposal_bytes;
    bytes signature;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_proposal_bytes(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_signature(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_proposal_bytes(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.proposal_bytes = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_signature(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.signature = x;
    return sz;
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;

    if (r.proposal_bytes.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.proposal_bytes, pointer, bs);
    }
    if (r.signature.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.signature, pointer, bs);
    }
    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.proposal_bytes.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.signature.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.proposal_bytes.length != 0) {
      return false;
    }

    if (r.signature.length != 0) {
      return false;
    }

    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    output.proposal_bytes = input.proposal_bytes;
    output.signature = input.signature;
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}

//library ProtosSignedProposal

library ProtosProposal {
  //struct definition
  struct Data {
    bytes header;
    bytes payload;
    bytes extension;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_header(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_payload(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_extension(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_header(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.header = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_payload(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.payload = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_extension(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.extension = x;
    return sz;
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;

    if (r.header.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.header, pointer, bs);
    }
    if (r.payload.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.payload, pointer, bs);
    }
    if (r.extension.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.extension, pointer, bs);
    }
    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.header.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.payload.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.extension.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.header.length != 0) {
      return false;
    }

    if (r.payload.length != 0) {
      return false;
    }

    if (r.extension.length != 0) {
      return false;
    }

    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    output.header = input.header;
    output.payload = input.payload;
    output.extension = input.extension;
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}

//library ProtosProposal

library ProtosChaincodeHeaderExtension {
  //struct definition
  struct Data {
    ProtosChaincodeID.Data chaincode_id;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 2) {
        pointer += _read_chaincode_id(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_chaincode_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (ProtosChaincodeID.Data memory x, uint256 sz) = _decode_ProtosChaincodeID(
      p,
      bs
    );
    r.chaincode_id = x;
    return sz;
  }

  // struct decoder
  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_ProtosChaincodeID(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosChaincodeID.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosChaincodeID.Data memory r, ) = ProtosChaincodeID._decode(
      pointer,
      bs,
      sz
    );
    return (r, sz + bytesRead);
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeID._encode_nested(r.chaincode_id, pointer, bs);

    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(ProtosChaincodeID._estimate(r.chaincode_id));
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    ProtosChaincodeID.store(input.chaincode_id, output.chaincode_id);
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}

//library ProtosChaincodeHeaderExtension

library ProtosChaincodeProposalPayload {
  //struct definition
  struct Data {
    bytes input;
    ProtosChaincodeProposalPayloadTransientMapEntry.Data[] TransientMap;
    //non serialized fields
    uint256 _size_TransientMap;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256[3] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_input(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_TransientMap(
          pointer,
          bs,
          nil(),
          counters
        );
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    pointer = offset;
    if (counters[2] > 0) {
      require(r.TransientMap.length == 0);
      r
        .TransientMap = new ProtosChaincodeProposalPayloadTransientMapEntry.Data[](
        counters[2]
      );
    }

    r._size_TransientMap = counters[2];
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 2) {
        pointer += _read_unpacked_repeated_TransientMap(
          pointer,
          bs,
          r,
          counters
        );
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_input(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.input = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_TransientMap(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[3] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory x,
      uint256 sz
    ) = _decode_ProtosChaincodeProposalPayloadTransientMapEntry(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.TransientMap[r.TransientMap.length - counters[2]] = x;
      counters[2] -= 1;
    }
    return sz;
  }

  // struct decoder
  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_ProtosChaincodeProposalPayloadTransientMapEntry(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory,
      uint256
    )
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory r,

    ) = ProtosChaincodeProposalPayloadTransientMapEntry._decode(
        pointer,
        bs,
        sz
      );
    return (r, sz + bytesRead);
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;
    uint256 i;
    if (r.input.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.input, pointer, bs);
    }
    if (r.TransientMap.length != 0) {
      for (i = 0; i < r._size_TransientMap; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtosChaincodeProposalPayloadTransientMapEntry
          ._encode_nested(r.TransientMap[i], pointer, bs);
      }
    }
    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    uint256 i;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.input.length);
    for (i = 0; i < r._size_TransientMap; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          ProtosChaincodeProposalPayloadTransientMapEntry._estimate(
            r.TransientMap[i]
          )
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.input.length != 0) {
      return false;
    }

    if (r.TransientMap.length != 0) {
      return false;
    }

    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    output.input = input.input;

    for (uint256 i2 = 0; i2 < input.TransientMap.length; i2++) {
      output.TransientMap.push(input.TransientMap[i2]);
    }
    output._size_TransientMap = input._size_TransientMap;
  }

  //map helpers for TransientMap
  /**
   * @dev Get value from a map
   * @param self The in-memory struct
   * @param key The key to get
   * @return The value in map if it exists
   */
  function getTransientMap(Data memory self, string memory key)
    internal
    pure
    returns (bytes memory)
  {
    bytes memory defaultValue;
    for (uint256 i = 0; i < self._size_TransientMap; i++) {
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory data = self
        .TransientMap[i];
      if (
        keccak256(abi.encodePacked((key))) ==
        keccak256(abi.encodePacked((data.key)))
      ) {
        return data.value;
      }
    }
    return defaultValue;
  }

  /**
   * @dev Search value from a map
   * @param self The in-memory struct
   * @param key The key to search
   * @return Whether the key exists in the map
   * @return The value in map if it exists
   */
  function searchTransientMap(Data memory self, string memory key)
    internal
    pure
    returns (bool, bytes memory)
  {
    bytes memory defaultValue;
    for (uint256 i = 0; i < self._size_TransientMap; i++) {
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory data = self
        .TransientMap[i];
      if (
        keccak256(abi.encodePacked((key))) ==
        keccak256(abi.encodePacked((data.key)))
      ) {
        return (true, data.value);
      }
    }
    return (false, defaultValue);
  }

  /**
   * @dev Add key-value pair from a map
   * @param self The in-memory struct
   * @param key The key to add
   * @param value The value to add
   */
  function addTransientMap(
    Data memory self,
    string memory key,
    bytes memory value
  ) internal pure {
    /**
     * First search whether the key exists.
     * If not, add to the array. Otherwise, replace the value.
     * If a resize is needed, the array size will be doubled.
     */
    for (uint256 i = 0; i < self._size_TransientMap; i++) {
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory data = self
        .TransientMap[i];
      if (
        keccak256(abi.encodePacked((key))) ==
        keccak256(abi.encodePacked((data.key)))
      ) {
        self.TransientMap[i].value = value;
        return;
      }
    }
    if (self.TransientMap.length == 0) {
      self
        .TransientMap = new ProtosChaincodeProposalPayloadTransientMapEntry.Data[](
        10
      );
    }
    if (self._size_TransientMap == self.TransientMap.length) {
      ProtosChaincodeProposalPayloadTransientMapEntry.Data[]
        memory tmp = new ProtosChaincodeProposalPayloadTransientMapEntry.Data[](
          self.TransientMap.length * 2
        );
      for (uint256 i = 0; i < self._size_TransientMap; i++) {
        tmp[i] = self.TransientMap[i];
      }
      self.TransientMap = tmp;
    }
    ProtosChaincodeProposalPayloadTransientMapEntry.Data memory entry;
    entry.key = key;
    entry.value = value;
    self.TransientMap[self._size_TransientMap++] = entry;
  }

  /**
   * @dev Delete key from a map
   * @param self The in-memory struct
   * @param key The key to delete
   */
  function rmTransientMap(Data memory self, string memory key) internal pure {
    /**
     * First search whether the key exists.
     * If not, do nothing.
     * Otherwise, replace with last key-value pair in the array.
     */
    uint256 pos;
    for (uint256 i = 0; i < self._size_TransientMap; i++) {
      ProtosChaincodeProposalPayloadTransientMapEntry.Data memory data = self
        .TransientMap[i];
      if (
        keccak256(abi.encodePacked((key))) ==
        keccak256(abi.encodePacked((data.key)))
      ) {
        pos = i + 1;
        break;
      }
    }
    if (pos == 0) {
      return;
    }
    pos -= 1;
    self.TransientMap[pos] = self.TransientMap[--self._size_TransientMap];
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}

//library ProtosChaincodeProposalPayload

library ProtosChaincodeProposalPayloadTransientMapEntry {
  //struct definition
  struct Data {
    string key;
    bytes value;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_key(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_value(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_key(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.key = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_value(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.value = x;
    return sz;
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;

    if (bytes(r.key).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.key, pointer, bs);
    }
    if (r.value.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.value, pointer, bs);
    }
    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.key).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.value.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.key).length != 0) {
      return false;
    }

    if (r.value.length != 0) {
      return false;
    }

    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    output.key = input.key;
    output.value = input.value;
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}

//library ProtosChaincodeProposalPayloadTransientMapEntry

library ProtosChaincodeAction {
  //struct definition
  struct Data {
    bytes results;
    bytes events;
    ProtosResponse.Data response;
    ProtosChaincodeID.Data chaincode_id;
  }

  // Decoder section

  /**
   * @dev The main decoder for memory
   * @param bs The bytes array to be decoded
   * @return The decoded struct
   */
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x, ) = _decode(32, bs, bs.length);
    return x;
  }

  /**
   * @dev The main decoder for storage
   * @param self The in-storage struct
   * @param bs The bytes array to be decoded
   */
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x, ) = _decode(32, bs, bs.length);
    store(x, self);
  }

  // inner decoder

  /**
   * @dev The decoder for internal usage
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param sz The number of bytes expected
   * @return The decoded struct
   * @return The number of bytes decoded
   */
  function _decode(
    uint256 p,
    bytes memory bs,
    uint256 sz
  ) internal pure returns (Data memory, uint256) {
    Data memory r;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_results(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_events(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_response(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_chaincode_id(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    return (r, sz);
  }

  // field readers

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_results(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.results = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_events(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.events = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_response(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (ProtosResponse.Data memory x, uint256 sz) = _decode_ProtosResponse(p, bs);
    r.response = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_chaincode_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (ProtosChaincodeID.Data memory x, uint256 sz) = _decode_ProtosChaincodeID(
      p,
      bs
    );
    r.chaincode_id = x;
    return sz;
  }

  // struct decoder
  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_ProtosResponse(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosResponse.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosResponse.Data memory r, ) = ProtosResponse._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_ProtosChaincodeID(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosChaincodeID.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosChaincodeID.Data memory r, ) = ProtosChaincodeID._decode(
      pointer,
      bs,
      sz
    );
    return (r, sz + bytesRead);
  }

  // Encoder section

  /**
   * @dev The main encoder for memory
   * @param r The struct to be encoded
   * @return The encoded byte array
   */
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint256 sz = _encode(r, 32, bs);
    assembly {
      mstore(bs, sz)
    }
    return bs;
  }

  // inner encoder

  /**
   * @dev The encoder for internal usage
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    uint256 offset = p;
    uint256 pointer = p;

    if (r.results.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.results, pointer, bs);
    }
    if (r.events.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.events, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      3,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosResponse._encode_nested(r.response, pointer, bs);

    pointer += ProtoBufRuntime._encode_key(
      4,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeID._encode_nested(r.chaincode_id, pointer, bs);

    return pointer - offset;
  }

  // nested encoder

  /**
   * @dev The encoder for inner struct
   * @param r The struct to be encoded
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The number of bytes encoded
   */
  function _encode_nested(
    Data memory r,
    uint256 p,
    bytes memory bs
  ) internal pure returns (uint256) {
    /**
     * First encoded `r` into a temporary array, and encode the actual size used.
     * Then copy the temporary array into `bs`.
     */
    uint256 offset = p;
    uint256 pointer = p;
    bytes memory tmp = new bytes(_estimate(r));
    uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
    uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
    uint256 size = _encode(r, 32, tmp);
    pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
    ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
    pointer += size;
    delete tmp;
    return pointer - offset;
  }

  // estimator

  /**
   * @dev The estimator for a struct
   * @param r The struct to be encoded
   * @return The number of bytes encoded in estimation
   */
  function _estimate(Data memory r) internal pure returns (uint256) {
    uint256 e;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.results.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.events.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(ProtosResponse._estimate(r.response));
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(ProtosChaincodeID._estimate(r.chaincode_id));
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.results.length != 0) {
      return false;
    }

    if (r.events.length != 0) {
      return false;
    }

    return true;
  }

  //store function
  /**
   * @dev Store in-memory struct to storage
   * @param input The in-memory struct
   * @param output The in-storage struct
   */
  function store(Data memory input, Data storage output) internal {
    output.results = input.results;
    output.events = input.events;
    ProtosResponse.store(input.response, output.response);
    ProtosChaincodeID.store(input.chaincode_id, output.chaincode_id);
  }

  //utility functions
  /**
   * @dev Return an empty struct
   * @return r The empty struct
   */
  function nil() internal pure returns (Data memory r) {
    assembly {
      r := 0
    }
  }

  /**
   * @dev Test whether a struct is empty
   * @param x The struct to be tested
   * @return r True if it is empty
   */
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly {
      r := iszero(x)
    }
  }
}
//library ProtosChaincodeAction

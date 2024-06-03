// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";

library MspSerializedIdentity {
  //struct definition
  struct Data {
    string mspid;
    bytes id_bytes;
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
        pointer += _read_mspid(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_id_bytes(pointer, bs, r);
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
  function _read_mspid(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.mspid = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_id_bytes(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.id_bytes = x;
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

    if (bytes(r.mspid).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.mspid, pointer, bs);
    }
    if (r.id_bytes.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.id_bytes, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.mspid).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.id_bytes.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.mspid).length != 0) {
      return false;
    }

    if (r.id_bytes.length != 0) {
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
    output.mspid = input.mspid;
    output.id_bytes = input.id_bytes;
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

//library MspSerializedIdentity

library MspSerializedIdemixIdentity {
  //struct definition
  struct Data {
    bytes nym_x;
    bytes nym_y;
    bytes ou;
    bytes role;
    bytes proof;
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
        pointer += _read_nym_x(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_nym_y(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_ou(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_role(pointer, bs, r);
      } else if (fieldId == 5) {
        pointer += _read_proof(pointer, bs, r);
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
  function _read_nym_x(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.nym_x = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_nym_y(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.nym_y = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_ou(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.ou = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_role(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.role = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_proof(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.proof = x;
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

    if (r.nym_x.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.nym_x, pointer, bs);
    }
    if (r.nym_y.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.nym_y, pointer, bs);
    }
    if (r.ou.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.ou, pointer, bs);
    }
    if (r.role.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.role, pointer, bs);
    }
    if (r.proof.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        5,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.proof, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.nym_x.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.nym_y.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.ou.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.role.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.proof.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.nym_x.length != 0) {
      return false;
    }

    if (r.nym_y.length != 0) {
      return false;
    }

    if (r.ou.length != 0) {
      return false;
    }

    if (r.role.length != 0) {
      return false;
    }

    if (r.proof.length != 0) {
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
    output.nym_x = input.nym_x;
    output.nym_y = input.nym_y;
    output.ou = input.ou;
    output.role = input.role;
    output.proof = input.proof;
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
//library MspSerializedIdemixIdentity

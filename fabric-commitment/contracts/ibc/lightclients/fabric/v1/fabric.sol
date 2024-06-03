// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";
//import "../../../../gogoproto/gogo.sol";
import "../../../../commitment/types.sol";

library IbcLightclientsFabricV1ClientState {
  //struct definition
  struct Data {
    string id;
    IbcLightclientsFabricV1ChaincodeHeader.Data last_chaincode_header;
    IbcLightclientsFabricV1ChaincodeInfo.Data last_chaincode_info;
    IbcLightclientsFabricV1MSPInfos.Data last_msp_infos;
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
        pointer += _read_id(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_last_chaincode_header(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_last_chaincode_info(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_last_msp_infos(pointer, bs, r);
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
  function _read_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.id = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_last_chaincode_header(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1ChaincodeHeader.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1ChaincodeHeader(p, bs);
    r.last_chaincode_header = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_last_chaincode_info(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1ChaincodeInfo.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1ChaincodeInfo(p, bs);
    r.last_chaincode_info = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_last_msp_infos(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1MSPInfos.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MSPInfos(p, bs);
    r.last_msp_infos = x;
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
  function _decode_IbcLightclientsFabricV1ChaincodeHeader(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1ChaincodeHeader.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1ChaincodeHeader.Data memory r,

    ) = IbcLightclientsFabricV1ChaincodeHeader._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1ChaincodeInfo(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1ChaincodeInfo.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1ChaincodeInfo.Data memory r,

    ) = IbcLightclientsFabricV1ChaincodeInfo._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1MSPInfos(uint256 p, bytes memory bs)
    internal
    pure
    returns (IbcLightclientsFabricV1MSPInfos.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MSPInfos.Data memory r,

    ) = IbcLightclientsFabricV1MSPInfos._decode(pointer, bs, sz);
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

    if (bytes(r.id).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.id, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1ChaincodeHeader._encode_nested(
      r.last_chaincode_header,
      pointer,
      bs
    );

    pointer += ProtoBufRuntime._encode_key(
      3,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1ChaincodeInfo._encode_nested(
      r.last_chaincode_info,
      pointer,
      bs
    );

    pointer += ProtoBufRuntime._encode_key(
      4,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1MSPInfos._encode_nested(
      r.last_msp_infos,
      pointer,
      bs
    );

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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.id).length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1ChaincodeHeader._estimate(
          r.last_chaincode_header
        )
      );
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1ChaincodeInfo._estimate(r.last_chaincode_info)
      );
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1MSPInfos._estimate(r.last_msp_infos)
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.id).length != 0) {
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
    output.id = input.id;
    IbcLightclientsFabricV1ChaincodeHeader.store(
      input.last_chaincode_header,
      output.last_chaincode_header
    );
    IbcLightclientsFabricV1ChaincodeInfo.store(
      input.last_chaincode_info,
      output.last_chaincode_info
    );
    IbcLightclientsFabricV1MSPInfos.store(
      input.last_msp_infos,
      output.last_msp_infos
    );
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

//library IbcLightclientsFabricV1ClientState

library IbcLightclientsFabricV1ConsensusState {
  //struct definition
  struct Data {
    int64 timestamp;
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
        pointer += _read_timestamp(pointer, bs, r);
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
  function _read_timestamp(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (int64 x, uint256 sz) = ProtoBufRuntime._decode_int64(p, bs);
    r.timestamp = x;
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

    if (r.timestamp != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_int64(r.timestamp, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_int64(r.timestamp);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.timestamp != 0) {
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
    output.timestamp = input.timestamp;
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

//library IbcLightclientsFabricV1ConsensusState

library IbcLightclientsFabricV1Header {
  //struct definition
  struct Data {
    IbcLightclientsFabricV1ChaincodeHeader.Data ChaincodeHeader;
    IbcLightclientsFabricV1ChaincodeInfo.Data ChaincodeInfo;
    IbcLightclientsFabricV1MSPHeaders.Data MSPHeaders;
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
        pointer += _read_ChaincodeHeader(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_ChaincodeInfo(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_MSPHeaders(pointer, bs, r);
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
  function _read_ChaincodeHeader(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1ChaincodeHeader.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1ChaincodeHeader(p, bs);
    r.ChaincodeHeader = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_ChaincodeInfo(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1ChaincodeInfo.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1ChaincodeInfo(p, bs);
    r.ChaincodeInfo = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_MSPHeaders(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      IbcLightclientsFabricV1MSPHeaders.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MSPHeaders(p, bs);
    r.MSPHeaders = x;
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
  function _decode_IbcLightclientsFabricV1ChaincodeHeader(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1ChaincodeHeader.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1ChaincodeHeader.Data memory r,

    ) = IbcLightclientsFabricV1ChaincodeHeader._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1ChaincodeInfo(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1ChaincodeInfo.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1ChaincodeInfo.Data memory r,

    ) = IbcLightclientsFabricV1ChaincodeInfo._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1MSPHeaders(uint256 p, bytes memory bs)
    internal
    pure
    returns (IbcLightclientsFabricV1MSPHeaders.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MSPHeaders.Data memory r,

    ) = IbcLightclientsFabricV1MSPHeaders._decode(pointer, bs, sz);
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
      1,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1ChaincodeHeader._encode_nested(
      r.ChaincodeHeader,
      pointer,
      bs
    );

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1ChaincodeInfo._encode_nested(
      r.ChaincodeInfo,
      pointer,
      bs
    );

    pointer += ProtoBufRuntime._encode_key(
      3,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1MSPHeaders._encode_nested(
      r.MSPHeaders,
      pointer,
      bs
    );

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
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1ChaincodeHeader._estimate(r.ChaincodeHeader)
      );
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1ChaincodeInfo._estimate(r.ChaincodeInfo)
      );
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1MSPHeaders._estimate(r.MSPHeaders)
      );
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
    IbcLightclientsFabricV1ChaincodeHeader.store(
      input.ChaincodeHeader,
      output.ChaincodeHeader
    );
    IbcLightclientsFabricV1ChaincodeInfo.store(
      input.ChaincodeInfo,
      output.ChaincodeInfo
    );
    IbcLightclientsFabricV1MSPHeaders.store(
      input.MSPHeaders,
      output.MSPHeaders
    );
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

//library IbcLightclientsFabricV1Header

library IbcLightclientsFabricV1ChaincodeHeader {
  //struct definition
  struct Data {
    CommitmentSequence.Data sequence;
    IbcLightclientsFabricV1CommitmentProof.Data proof;
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
        pointer += _read_sequence(pointer, bs, r);
      } else if (fieldId == 2) {
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
  function _read_sequence(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (CommitmentSequence.Data memory x, uint256 sz) = _decode_CommitmentSequence(
      p,
      bs
    );
    r.sequence = x;
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
    (
      IbcLightclientsFabricV1CommitmentProof.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1CommitmentProof(p, bs);
    r.proof = x;
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
  function _decode_CommitmentSequence(uint256 p, bytes memory bs)
    internal
    pure
    returns (CommitmentSequence.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (CommitmentSequence.Data memory r, ) = CommitmentSequence._decode(
      pointer,
      bs,
      sz
    );
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1CommitmentProof(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1CommitmentProof.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1CommitmentProof.Data memory r,

    ) = IbcLightclientsFabricV1CommitmentProof._decode(pointer, bs, sz);
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
      1,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += CommitmentSequence._encode_nested(r.sequence, pointer, bs);

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1CommitmentProof._encode_nested(
      r.proof,
      pointer,
      bs
    );

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
      ProtoBufRuntime._sz_lendelim(CommitmentSequence._estimate(r.sequence));
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1CommitmentProof._estimate(r.proof)
      );
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
    CommitmentSequence.store(input.sequence, output.sequence);
    IbcLightclientsFabricV1CommitmentProof.store(input.proof, output.proof);
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

//library IbcLightclientsFabricV1ChaincodeHeader

library IbcLightclientsFabricV1ChaincodeInfo {
  //struct definition
  struct Data {
    string channel_id;
    IbcLightclientsFabricV1ChaincodeID.Data chaincode_id;
    bytes endorsement_policy;
    bytes ibc_policy;
    IbcLightclientsFabricV1MessageProof.Data proof;
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
        pointer += _read_channel_id(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_chaincode_id(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_endorsement_policy(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_ibc_policy(pointer, bs, r);
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
  function _read_channel_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.channel_id = x;
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
    (
      IbcLightclientsFabricV1ChaincodeID.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1ChaincodeID(p, bs);
    r.chaincode_id = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_endorsement_policy(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.endorsement_policy = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_ibc_policy(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.ibc_policy = x;
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
    (
      IbcLightclientsFabricV1MessageProof.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MessageProof(p, bs);
    r.proof = x;
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
  function _decode_IbcLightclientsFabricV1ChaincodeID(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1ChaincodeID.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1ChaincodeID.Data memory r,

    ) = IbcLightclientsFabricV1ChaincodeID._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_IbcLightclientsFabricV1MessageProof(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1MessageProof.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MessageProof.Data memory r,

    ) = IbcLightclientsFabricV1MessageProof._decode(pointer, bs, sz);
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

    if (bytes(r.channel_id).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.channel_id, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1ChaincodeID._encode_nested(
      r.chaincode_id,
      pointer,
      bs
    );

    if (r.endorsement_policy.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(
        r.endorsement_policy,
        pointer,
        bs
      );
    }
    if (r.ibc_policy.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.ibc_policy, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      5,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1MessageProof._encode_nested(
      r.proof,
      pointer,
      bs
    );

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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.channel_id).length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1ChaincodeID._estimate(r.chaincode_id)
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(r.endorsement_policy.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.ibc_policy.length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1MessageProof._estimate(r.proof)
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.channel_id).length != 0) {
      return false;
    }

    if (r.endorsement_policy.length != 0) {
      return false;
    }

    if (r.ibc_policy.length != 0) {
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
    output.channel_id = input.channel_id;
    IbcLightclientsFabricV1ChaincodeID.store(
      input.chaincode_id,
      output.chaincode_id
    );
    output.endorsement_policy = input.endorsement_policy;
    output.ibc_policy = input.ibc_policy;
    IbcLightclientsFabricV1MessageProof.store(input.proof, output.proof);
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

//library IbcLightclientsFabricV1ChaincodeInfo

library IbcLightclientsFabricV1MSPHeaders {
  //struct definition
  struct Data {
    IbcLightclientsFabricV1MSPHeader.Data[] headers;
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
    uint256[2] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_headers(
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
    if (counters[1] > 0) {
      require(r.headers.length == 0);
      r.headers = new IbcLightclientsFabricV1MSPHeader.Data[](counters[1]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_headers(pointer, bs, r, counters);
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_headers(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[2] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      IbcLightclientsFabricV1MSPHeader.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MSPHeader(p, bs);
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.headers[r.headers.length - counters[1]] = x;
      counters[1] -= 1;
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
  function _decode_IbcLightclientsFabricV1MSPHeader(uint256 p, bytes memory bs)
    internal
    pure
    returns (IbcLightclientsFabricV1MSPHeader.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MSPHeader.Data memory r,

    ) = IbcLightclientsFabricV1MSPHeader._decode(pointer, bs, sz);
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
    if (r.headers.length != 0) {
      for (i = 0; i < r.headers.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += IbcLightclientsFabricV1MSPHeader._encode_nested(
          r.headers[i],
          pointer,
          bs
        );
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
    for (i = 0; i < r.headers.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          IbcLightclientsFabricV1MSPHeader._estimate(r.headers[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.headers.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.headers.length; i1++) {
      output.headers.push(input.headers[i1]);
    }
  }

  //array helpers for Headers
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addHeaders(
    Data memory self,
    IbcLightclientsFabricV1MSPHeader.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    IbcLightclientsFabricV1MSPHeader.Data[]
      memory tmp = new IbcLightclientsFabricV1MSPHeader.Data[](
        self.headers.length + 1
      );
    for (uint256 i = 0; i < self.headers.length; i++) {
      tmp[i] = self.headers[i];
    }
    tmp[self.headers.length] = value;
    self.headers = tmp;
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

//library IbcLightclientsFabricV1MSPHeaders

library IbcLightclientsFabricV1MSPHeader {
  //struct definition
  struct Data {
    FABRIC_PROTO_GLOBAL_ENUMS.MSPHeaderType msgheader_type;
    string msp_id;
    bytes config;
    bytes policy;
    IbcLightclientsFabricV1MessageProof.Data proof;
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
        pointer += _read_type(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_msp_id(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_config(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_policy(pointer, bs, r);
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
  function _read_type(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (int64 tmp, uint256 sz) = ProtoBufRuntime._decode_enum(p, bs);
    FABRIC_PROTO_GLOBAL_ENUMS.MSPHeaderType x = FABRIC_PROTO_GLOBAL_ENUMS
      .decode_MSPHeaderType(tmp);
    r.msgheader_type = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_msp_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.msp_id = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_config(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.config = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_policy(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.policy = x;
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
    (
      IbcLightclientsFabricV1MessageProof.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MessageProof(p, bs);
    r.proof = x;
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
  function _decode_IbcLightclientsFabricV1MessageProof(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (IbcLightclientsFabricV1MessageProof.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MessageProof.Data memory r,

    ) = IbcLightclientsFabricV1MessageProof._decode(pointer, bs, sz);
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

    if (uint256(r.msgheader_type) != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      int32 _enum_type = FABRIC_PROTO_GLOBAL_ENUMS.encode_MSPHeaderType(
        r.msgheader_type
      );
      pointer += ProtoBufRuntime._encode_enum(_enum_type, pointer, bs);
    }
    if (bytes(r.msp_id).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.msp_id, pointer, bs);
    }
    if (r.config.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.config, pointer, bs);
    }
    if (r.policy.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.policy, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      5,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += IbcLightclientsFabricV1MessageProof._encode_nested(
      r.proof,
      pointer,
      bs
    );

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
      ProtoBufRuntime._sz_enum(
        FABRIC_PROTO_GLOBAL_ENUMS.encode_MSPHeaderType(r.msgheader_type)
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.msp_id).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.config.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.policy.length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        IbcLightclientsFabricV1MessageProof._estimate(r.proof)
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (uint256(r.msgheader_type) != 0) {
      return false;
    }

    if (bytes(r.msp_id).length != 0) {
      return false;
    }

    if (r.config.length != 0) {
      return false;
    }

    if (r.policy.length != 0) {
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
    output.msgheader_type = input.msgheader_type;
    output.msp_id = input.msp_id;
    output.config = input.config;
    output.policy = input.policy;
    IbcLightclientsFabricV1MessageProof.store(input.proof, output.proof);
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

//library IbcLightclientsFabricV1MSPHeader

library IbcLightclientsFabricV1MSPInfos {
  //struct definition
  struct Data {
    IbcLightclientsFabricV1MSPInfo.Data[] infos;
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
    uint256[2] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_infos(pointer, bs, nil(), counters);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    pointer = offset;
    if (counters[1] > 0) {
      require(r.infos.length == 0);
      r.infos = new IbcLightclientsFabricV1MSPInfo.Data[](counters[1]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_infos(pointer, bs, r, counters);
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_infos(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[2] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      IbcLightclientsFabricV1MSPInfo.Data memory x,
      uint256 sz
    ) = _decode_IbcLightclientsFabricV1MSPInfo(p, bs);
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.infos[r.infos.length - counters[1]] = x;
      counters[1] -= 1;
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
  function _decode_IbcLightclientsFabricV1MSPInfo(uint256 p, bytes memory bs)
    internal
    pure
    returns (IbcLightclientsFabricV1MSPInfo.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      IbcLightclientsFabricV1MSPInfo.Data memory r,

    ) = IbcLightclientsFabricV1MSPInfo._decode(pointer, bs, sz);
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
    if (r.infos.length != 0) {
      for (i = 0; i < r.infos.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += IbcLightclientsFabricV1MSPInfo._encode_nested(
          r.infos[i],
          pointer,
          bs
        );
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
    for (i = 0; i < r.infos.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          IbcLightclientsFabricV1MSPInfo._estimate(r.infos[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.infos.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.infos.length; i1++) {
      output.infos.push(input.infos[i1]);
    }
  }

  //array helpers for Infos
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addInfos(
    Data memory self,
    IbcLightclientsFabricV1MSPInfo.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    IbcLightclientsFabricV1MSPInfo.Data[]
      memory tmp = new IbcLightclientsFabricV1MSPInfo.Data[](
        self.infos.length + 1
      );
    for (uint256 i = 0; i < self.infos.length; i++) {
      tmp[i] = self.infos[i];
    }
    tmp[self.infos.length] = value;
    self.infos = tmp;
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

//library IbcLightclientsFabricV1MSPInfos

library IbcLightclientsFabricV1MSPInfo {
  //struct definition
  struct Data {
    string msp_id;
    bytes config;
    bytes policy;
    bool freezed;
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
        pointer += _read_msp_id(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_config(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_policy(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_freezed(pointer, bs, r);
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
  function _read_msp_id(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.msp_id = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_config(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.config = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_policy(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.policy = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_freezed(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.freezed = x;
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

    if (bytes(r.msp_id).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.msp_id, pointer, bs);
    }
    if (r.config.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.config, pointer, bs);
    }
    if (r.policy.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.policy, pointer, bs);
    }
    if (r.freezed != false) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.freezed, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.msp_id).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.config.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.policy.length);
    e += 1 + 1;
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.msp_id).length != 0) {
      return false;
    }

    if (r.config.length != 0) {
      return false;
    }

    if (r.policy.length != 0) {
      return false;
    }

    if (r.freezed != false) {
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
    output.msp_id = input.msp_id;
    output.config = input.config;
    output.policy = input.policy;
    output.freezed = input.freezed;
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

//library IbcLightclientsFabricV1MSPInfo

library IbcLightclientsFabricV1ChaincodeID {
  //struct definition
  struct Data {
    string path;
    string name;
    string version;
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
        pointer += _read_path(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_name(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_version(pointer, bs, r);
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
  function _read_path(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.path = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_name(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.name = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_version(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.version = x;
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

    if (bytes(r.path).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.path, pointer, bs);
    }
    if (bytes(r.name).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.name, pointer, bs);
    }
    if (bytes(r.version).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.version, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.path).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.name).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.version).length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.path).length != 0) {
      return false;
    }

    if (bytes(r.name).length != 0) {
      return false;
    }

    if (bytes(r.version).length != 0) {
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
    output.path = input.path;
    output.name = input.name;
    output.version = input.version;
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

//library IbcLightclientsFabricV1ChaincodeID

library IbcLightclientsFabricV1Prefix {
  //struct definition
  struct Data {
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

    if (r.value.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.value.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
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

//library IbcLightclientsFabricV1Prefix

library IbcLightclientsFabricV1CommitmentProof {
  //struct definition
  struct Data {
    bytes proposal;
    uint32 ns_index;
    uint32 write_set_index;
    bytes[] identities;
    bytes[] signatures;
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
    uint256[6] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_proposal(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_ns_index(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_write_set_index(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_unpacked_repeated_identities(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 5) {
        pointer += _read_unpacked_repeated_signatures(
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
    if (counters[4] > 0) {
      require(r.identities.length == 0);
      r.identities = new bytes[](counters[4]);
    }
    if (counters[5] > 0) {
      require(r.signatures.length == 0);
      r.signatures = new bytes[](counters[5]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 4) {
        pointer += _read_unpacked_repeated_identities(pointer, bs, r, counters);
      } else if (fieldId == 5) {
        pointer += _read_unpacked_repeated_signatures(pointer, bs, r, counters);
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
  function _read_proposal(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.proposal = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_ns_index(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
    r.ns_index = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_write_set_index(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
    r.write_set_index = x;
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
  function _read_unpacked_repeated_identities(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[6] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    if (isNil(r)) {
      counters[4] += 1;
    } else {
      r.identities[r.identities.length - counters[4]] = x;
      counters[4] -= 1;
    }
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
  function _read_unpacked_repeated_signatures(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[6] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    if (isNil(r)) {
      counters[5] += 1;
    } else {
      r.signatures[r.signatures.length - counters[5]] = x;
      counters[5] -= 1;
    }
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
    uint256 i;
    if (r.proposal.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.proposal, pointer, bs);
    }
    if (r.ns_index != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint32(r.ns_index, pointer, bs);
    }
    if (r.write_set_index != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint32(r.write_set_index, pointer, bs);
    }
    if (r.identities.length != 0) {
      for (i = 0; i < r.identities.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          4,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(r.identities[i], pointer, bs);
      }
    }
    if (r.signatures.length != 0) {
      for (i = 0; i < r.signatures.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          5,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(r.signatures[i], pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.proposal.length);
    e += 1 + ProtoBufRuntime._sz_uint32(r.ns_index);
    e += 1 + ProtoBufRuntime._sz_uint32(r.write_set_index);
    for (i = 0; i < r.identities.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.identities[i].length);
    }
    for (i = 0; i < r.signatures.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.signatures[i].length);
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.proposal.length != 0) {
      return false;
    }

    if (r.ns_index != 0) {
      return false;
    }

    if (r.write_set_index != 0) {
      return false;
    }

    if (r.identities.length != 0) {
      return false;
    }

    if (r.signatures.length != 0) {
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
    output.proposal = input.proposal;
    output.ns_index = input.ns_index;
    output.write_set_index = input.write_set_index;
    output.identities = input.identities;
    output.signatures = input.signatures;
  }

  //array helpers for Identities
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addIdentities(Data memory self, bytes memory value) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.identities.length + 1);
    for (uint256 i = 0; i < self.identities.length; i++) {
      tmp[i] = self.identities[i];
    }
    tmp[self.identities.length] = value;
    self.identities = tmp;
  }

  //array helpers for Signatures
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addSignatures(Data memory self, bytes memory value) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.signatures.length + 1);
    for (uint256 i = 0; i < self.signatures.length; i++) {
      tmp[i] = self.signatures[i];
    }
    tmp[self.signatures.length] = value;
    self.signatures = tmp;
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

//library IbcLightclientsFabricV1CommitmentProof

library IbcLightclientsFabricV1MessageProof {
  //struct definition
  struct Data {
    bytes[] identities;
    bytes[] signatures;
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
        pointer += _read_unpacked_repeated_identities(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_signatures(
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
    if (counters[1] > 0) {
      require(r.identities.length == 0);
      r.identities = new bytes[](counters[1]);
    }
    if (counters[2] > 0) {
      require(r.signatures.length == 0);
      r.signatures = new bytes[](counters[2]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_identities(pointer, bs, r, counters);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_signatures(pointer, bs, r, counters);
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_identities(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[3] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.identities[r.identities.length - counters[1]] = x;
      counters[1] -= 1;
    }
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
  function _read_unpacked_repeated_signatures(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[3] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.signatures[r.signatures.length - counters[2]] = x;
      counters[2] -= 1;
    }
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
    uint256 i;
    if (r.identities.length != 0) {
      for (i = 0; i < r.identities.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(r.identities[i], pointer, bs);
      }
    }
    if (r.signatures.length != 0) {
      for (i = 0; i < r.signatures.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(r.signatures[i], pointer, bs);
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
    for (i = 0; i < r.identities.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.identities[i].length);
    }
    for (i = 0; i < r.signatures.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.signatures[i].length);
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.identities.length != 0) {
      return false;
    }

    if (r.signatures.length != 0) {
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
    output.identities = input.identities;
    output.signatures = input.signatures;
  }

  //array helpers for Identities
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addIdentities(Data memory self, bytes memory value) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.identities.length + 1);
    for (uint256 i = 0; i < self.identities.length; i++) {
      tmp[i] = self.identities[i];
    }
    tmp[self.identities.length] = value;
    self.identities = tmp;
  }

  //array helpers for Signatures
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addSignatures(Data memory self, bytes memory value) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.signatures.length + 1);
    for (uint256 i = 0; i < self.signatures.length; i++) {
      tmp[i] = self.signatures[i];
    }
    tmp[self.signatures.length] = value;
    self.signatures = tmp;
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

//library IbcLightclientsFabricV1MessageProof

library FABRIC_PROTO_GLOBAL_ENUMS {
  //enum definition
  // Solidity enum definitions
  enum MSPHeaderType {
    MSP_HEADER_TYPE_CREATE,
    MSP_HEADER_TYPE_UPDATE_POLICY,
    MSP_HEADER_TYPE_UPDATE_CONFIG,
    MSP_HEADER_TYPE_FREEZE
  }

  // Solidity enum encoder
  function encode_MSPHeaderType(MSPHeaderType x) internal pure returns (int32) {
    if (x == MSPHeaderType.MSP_HEADER_TYPE_CREATE) {
      return 0;
    }

    if (x == MSPHeaderType.MSP_HEADER_TYPE_UPDATE_POLICY) {
      return 1;
    }

    if (x == MSPHeaderType.MSP_HEADER_TYPE_UPDATE_CONFIG) {
      return 2;
    }

    if (x == MSPHeaderType.MSP_HEADER_TYPE_FREEZE) {
      return 3;
    }
    revert();
  }

  // Solidity enum decoder
  function decode_MSPHeaderType(int64 x) internal pure returns (MSPHeaderType) {
    if (x == 0) {
      return MSPHeaderType.MSP_HEADER_TYPE_CREATE;
    }

    if (x == 1) {
      return MSPHeaderType.MSP_HEADER_TYPE_UPDATE_POLICY;
    }

    if (x == 2) {
      return MSPHeaderType.MSP_HEADER_TYPE_UPDATE_CONFIG;
    }

    if (x == 3) {
      return MSPHeaderType.MSP_HEADER_TYPE_FREEZE;
    }
    revert();
  }

  /**
   * @dev The estimator for an packed enum array
   * @return The number of bytes encoded
   */
  function estimate_packed_repeated_MSPHeaderType(MSPHeaderType[] memory a)
    internal
    pure
    returns (uint256)
  {
    uint256 e = 0;
    for (uint256 i = 0; i < a.length; i++) {
      e += ProtoBufRuntime._sz_enum(encode_MSPHeaderType(a[i]));
    }
    return e;
  }
}
//library FABRIC_PROTO_GLOBAL_ENUMS

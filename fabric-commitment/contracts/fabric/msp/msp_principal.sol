// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";

library CommonMSPPrincipal {
  //enum definition
  // Solidity enum definitions
  enum Classification {
    ROLE,
    ORGANIZATION_UNIT,
    IDENTITY,
    ANONYMITY,
    COMBINED
  }

  // Solidity enum encoder
  function encode_Classification(Classification x)
    internal
    pure
    returns (int32)
  {
    if (x == Classification.ROLE) {
      return 0;
    }

    if (x == Classification.ORGANIZATION_UNIT) {
      return 1;
    }

    if (x == Classification.IDENTITY) {
      return 2;
    }

    if (x == Classification.ANONYMITY) {
      return 3;
    }

    if (x == Classification.COMBINED) {
      return 4;
    }
    revert();
  }

  // Solidity enum decoder
  function decode_Classification(int64 x)
    internal
    pure
    returns (Classification)
  {
    if (x == 0) {
      return Classification.ROLE;
    }

    if (x == 1) {
      return Classification.ORGANIZATION_UNIT;
    }

    if (x == 2) {
      return Classification.IDENTITY;
    }

    if (x == 3) {
      return Classification.ANONYMITY;
    }

    if (x == 4) {
      return Classification.COMBINED;
    }
    revert();
  }

  /**
   * @dev The estimator for an packed enum array
   * @return The number of bytes encoded
   */
  function estimate_packed_repeated_Classification(Classification[] memory a)
    internal
    pure
    returns (uint256)
  {
    uint256 e = 0;
    for (uint256 i = 0; i < a.length; i++) {
      e += ProtoBufRuntime._sz_enum(encode_Classification(a[i]));
    }
    return e;
  }

  //struct definition
  struct Data {
    CommonMSPPrincipal.Classification principal_classification;
    bytes principal;
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
        pointer += _read_principal_classification(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_principal(pointer, bs, r);
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
  function _read_principal_classification(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (int64 tmp, uint256 sz) = ProtoBufRuntime._decode_enum(p, bs);
    CommonMSPPrincipal.Classification x = CommonMSPPrincipal
      .decode_Classification(tmp);
    r.principal_classification = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_principal(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.principal = x;
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

    if (uint256(r.principal_classification) != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      int32 _enum_principal_classification = CommonMSPPrincipal
        .encode_Classification(r.principal_classification);
      pointer += ProtoBufRuntime._encode_enum(
        _enum_principal_classification,
        pointer,
        bs
      );
    }
    if (r.principal.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.principal, pointer, bs);
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
    e +=
      1 +
      ProtoBufRuntime._sz_enum(
        CommonMSPPrincipal.encode_Classification(r.principal_classification)
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(r.principal.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (uint256(r.principal_classification) != 0) {
      return false;
    }

    if (r.principal.length != 0) {
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
    output.principal_classification = input.principal_classification;
    output.principal = input.principal;
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

//library CommonMSPPrincipal

library CommonOrganizationUnit {
  //struct definition
  struct Data {
    string msp_identifier;
    string organizational_unit_identifier;
    bytes certifiers_identifier;
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
        pointer += _read_msp_identifier(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_organizational_unit_identifier(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_certifiers_identifier(pointer, bs, r);
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
  function _read_msp_identifier(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.msp_identifier = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_organizational_unit_identifier(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.organizational_unit_identifier = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_certifiers_identifier(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.certifiers_identifier = x;
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

    if (bytes(r.msp_identifier).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.msp_identifier, pointer, bs);
    }
    if (bytes(r.organizational_unit_identifier).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(
        r.organizational_unit_identifier,
        pointer,
        bs
      );
    }
    if (r.certifiers_identifier.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(
        r.certifiers_identifier,
        pointer,
        bs
      );
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.msp_identifier).length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        bytes(r.organizational_unit_identifier).length
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(r.certifiers_identifier.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.msp_identifier).length != 0) {
      return false;
    }

    if (bytes(r.organizational_unit_identifier).length != 0) {
      return false;
    }

    if (r.certifiers_identifier.length != 0) {
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
    output.msp_identifier = input.msp_identifier;
    output.organizational_unit_identifier = input
      .organizational_unit_identifier;
    output.certifiers_identifier = input.certifiers_identifier;
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

//library CommonOrganizationUnit

library CommonMSPRole {
  //enum definition
  // Solidity enum definitions
  enum MSPRoleType {
    MEMBER,
    ADMIN,
    CLIENT,
    PEER,
    ORDERER
  }

  // Solidity enum encoder
  function encode_MSPRoleType(MSPRoleType x) internal pure returns (int32) {
    if (x == MSPRoleType.MEMBER) {
      return 0;
    }

    if (x == MSPRoleType.ADMIN) {
      return 1;
    }

    if (x == MSPRoleType.CLIENT) {
      return 2;
    }

    if (x == MSPRoleType.PEER) {
      return 3;
    }

    if (x == MSPRoleType.ORDERER) {
      return 4;
    }
    revert();
  }

  // Solidity enum decoder
  function decode_MSPRoleType(int64 x) internal pure returns (MSPRoleType) {
    if (x == 0) {
      return MSPRoleType.MEMBER;
    }

    if (x == 1) {
      return MSPRoleType.ADMIN;
    }

    if (x == 2) {
      return MSPRoleType.CLIENT;
    }

    if (x == 3) {
      return MSPRoleType.PEER;
    }

    if (x == 4) {
      return MSPRoleType.ORDERER;
    }
    revert();
  }

  /**
   * @dev The estimator for an packed enum array
   * @return The number of bytes encoded
   */
  function estimate_packed_repeated_MSPRoleType(MSPRoleType[] memory a)
    internal
    pure
    returns (uint256)
  {
    uint256 e = 0;
    for (uint256 i = 0; i < a.length; i++) {
      e += ProtoBufRuntime._sz_enum(encode_MSPRoleType(a[i]));
    }
    return e;
  }

  //struct definition
  struct Data {
    string msp_identifier;
    CommonMSPRole.MSPRoleType role;
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
        pointer += _read_msp_identifier(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_role(pointer, bs, r);
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
  function _read_msp_identifier(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.msp_identifier = x;
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
    (int64 tmp, uint256 sz) = ProtoBufRuntime._decode_enum(p, bs);
    CommonMSPRole.MSPRoleType x = CommonMSPRole.decode_MSPRoleType(tmp);
    r.role = x;
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

    if (bytes(r.msp_identifier).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.msp_identifier, pointer, bs);
    }
    if (uint256(r.role) != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      int32 _enum_role = CommonMSPRole.encode_MSPRoleType(r.role);
      pointer += ProtoBufRuntime._encode_enum(_enum_role, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.msp_identifier).length);
    e += 1 + ProtoBufRuntime._sz_enum(CommonMSPRole.encode_MSPRoleType(r.role));
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.msp_identifier).length != 0) {
      return false;
    }

    if (uint256(r.role) != 0) {
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
    output.msp_identifier = input.msp_identifier;
    output.role = input.role;
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

//library CommonMSPRole

library CommonMSPIdentityAnonymity {
  //enum definition
  // Solidity enum definitions
  enum MSPIdentityAnonymityType {
    NOMINAL,
    ANONYMOUS
  }

  // Solidity enum encoder
  function encode_MSPIdentityAnonymityType(MSPIdentityAnonymityType x)
    internal
    pure
    returns (int32)
  {
    if (x == MSPIdentityAnonymityType.NOMINAL) {
      return 0;
    }

    if (x == MSPIdentityAnonymityType.ANONYMOUS) {
      return 1;
    }
    revert();
  }

  // Solidity enum decoder
  function decode_MSPIdentityAnonymityType(int64 x)
    internal
    pure
    returns (MSPIdentityAnonymityType)
  {
    if (x == 0) {
      return MSPIdentityAnonymityType.NOMINAL;
    }

    if (x == 1) {
      return MSPIdentityAnonymityType.ANONYMOUS;
    }
    revert();
  }

  /**
   * @dev The estimator for an packed enum array
   * @return The number of bytes encoded
   */
  function estimate_packed_repeated_MSPIdentityAnonymityType(
    MSPIdentityAnonymityType[] memory a
  ) internal pure returns (uint256) {
    uint256 e = 0;
    for (uint256 i = 0; i < a.length; i++) {
      e += ProtoBufRuntime._sz_enum(encode_MSPIdentityAnonymityType(a[i]));
    }
    return e;
  }

  //struct definition
  struct Data {
    CommonMSPIdentityAnonymity.MSPIdentityAnonymityType anonymity_type;
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
        pointer += _read_anonymity_type(pointer, bs, r);
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
  function _read_anonymity_type(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (int64 tmp, uint256 sz) = ProtoBufRuntime._decode_enum(p, bs);
    CommonMSPIdentityAnonymity.MSPIdentityAnonymityType x = CommonMSPIdentityAnonymity
        .decode_MSPIdentityAnonymityType(tmp);
    r.anonymity_type = x;
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

    if (uint256(r.anonymity_type) != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      int32 _enum_anonymity_type = CommonMSPIdentityAnonymity
        .encode_MSPIdentityAnonymityType(r.anonymity_type);
      pointer += ProtoBufRuntime._encode_enum(
        _enum_anonymity_type,
        pointer,
        bs
      );
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
    e +=
      1 +
      ProtoBufRuntime._sz_enum(
        CommonMSPIdentityAnonymity.encode_MSPIdentityAnonymityType(
          r.anonymity_type
        )
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (uint256(r.anonymity_type) != 0) {
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
    output.anonymity_type = input.anonymity_type;
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

//library CommonMSPIdentityAnonymity

library CommonCombinedPrincipal {
  //struct definition
  struct Data {
    CommonMSPPrincipal.Data[] principals;
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
        pointer += _read_unpacked_repeated_principals(
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
      require(r.principals.length == 0);
      r.principals = new CommonMSPPrincipal.Data[](counters[1]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_principals(pointer, bs, r, counters);
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
  function _read_unpacked_repeated_principals(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[2] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (CommonMSPPrincipal.Data memory x, uint256 sz) = _decode_CommonMSPPrincipal(
      p,
      bs
    );
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.principals[r.principals.length - counters[1]] = x;
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
  function _decode_CommonMSPPrincipal(uint256 p, bytes memory bs)
    internal
    pure
    returns (CommonMSPPrincipal.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (CommonMSPPrincipal.Data memory r, ) = CommonMSPPrincipal._decode(
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
    if (r.principals.length != 0) {
      for (i = 0; i < r.principals.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += CommonMSPPrincipal._encode_nested(
          r.principals[i],
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
    for (i = 0; i < r.principals.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          CommonMSPPrincipal._estimate(r.principals[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.principals.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.principals.length; i1++) {
      output.principals.push(input.principals[i1]);
    }
  }

  //array helpers for Principals
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addPrincipals(Data memory self, CommonMSPPrincipal.Data memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    CommonMSPPrincipal.Data[] memory tmp = new CommonMSPPrincipal.Data[](
      self.principals.length + 1
    );
    for (uint256 i = 0; i < self.principals.length; i++) {
      tmp[i] = self.principals[i];
    }
    tmp[self.principals.length] = value;
    self.principals = tmp;
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
//library CommonCombinedPrincipal

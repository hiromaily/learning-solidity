// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";

library KvrwsetKVRWSet {
  //struct definition
  struct Data {
    KvrwsetKVRead.Data[] reads;
    KvrwsetRangeQueryInfo.Data[] range_queries_info;
    KvrwsetKVWrite.Data[] writes;
    KvrwsetKVMetadataWrite.Data[] metadata_writes;
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
    uint256[5] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_reads(pointer, bs, nil(), counters);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_range_queries_info(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 3) {
        pointer += _read_unpacked_repeated_writes(pointer, bs, nil(), counters);
      } else if (fieldId == 4) {
        pointer += _read_unpacked_repeated_metadata_writes(
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
      require(r.reads.length == 0);
      r.reads = new KvrwsetKVRead.Data[](counters[1]);
    }
    if (counters[2] > 0) {
      require(r.range_queries_info.length == 0);
      r.range_queries_info = new KvrwsetRangeQueryInfo.Data[](counters[2]);
    }
    if (counters[3] > 0) {
      require(r.writes.length == 0);
      r.writes = new KvrwsetKVWrite.Data[](counters[3]);
    }
    if (counters[4] > 0) {
      require(r.metadata_writes.length == 0);
      r.metadata_writes = new KvrwsetKVMetadataWrite.Data[](counters[4]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_reads(pointer, bs, r, counters);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_range_queries_info(
          pointer,
          bs,
          r,
          counters
        );
      } else if (fieldId == 3) {
        pointer += _read_unpacked_repeated_writes(pointer, bs, r, counters);
      } else if (fieldId == 4) {
        pointer += _read_unpacked_repeated_metadata_writes(
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_reads(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[5] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (KvrwsetKVRead.Data memory x, uint256 sz) = _decode_KvrwsetKVRead(p, bs);
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.reads[r.reads.length - counters[1]] = x;
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
  function _read_unpacked_repeated_range_queries_info(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[5] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      KvrwsetRangeQueryInfo.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetRangeQueryInfo(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.range_queries_info[r.range_queries_info.length - counters[2]] = x;
      counters[2] -= 1;
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
  function _read_unpacked_repeated_writes(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[5] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (KvrwsetKVWrite.Data memory x, uint256 sz) = _decode_KvrwsetKVWrite(p, bs);
    if (isNil(r)) {
      counters[3] += 1;
    } else {
      r.writes[r.writes.length - counters[3]] = x;
      counters[3] -= 1;
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
  function _read_unpacked_repeated_metadata_writes(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[5] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      KvrwsetKVMetadataWrite.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetKVMetadataWrite(p, bs);
    if (isNil(r)) {
      counters[4] += 1;
    } else {
      r.metadata_writes[r.metadata_writes.length - counters[4]] = x;
      counters[4] -= 1;
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
  function _decode_KvrwsetKVRead(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVRead.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVRead.Data memory r, ) = KvrwsetKVRead._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_KvrwsetRangeQueryInfo(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetRangeQueryInfo.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetRangeQueryInfo.Data memory r, ) = KvrwsetRangeQueryInfo._decode(
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
  function _decode_KvrwsetKVWrite(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVWrite.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVWrite.Data memory r, ) = KvrwsetKVWrite._decode(pointer, bs, sz);
    return (r, sz + bytesRead);
  }

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_KvrwsetKVMetadataWrite(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVMetadataWrite.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVMetadataWrite.Data memory r, ) = KvrwsetKVMetadataWrite._decode(
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
    if (r.reads.length != 0) {
      for (i = 0; i < r.reads.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVRead._encode_nested(r.reads[i], pointer, bs);
      }
    }
    if (r.range_queries_info.length != 0) {
      for (i = 0; i < r.range_queries_info.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetRangeQueryInfo._encode_nested(
          r.range_queries_info[i],
          pointer,
          bs
        );
      }
    }
    if (r.writes.length != 0) {
      for (i = 0; i < r.writes.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          3,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVWrite._encode_nested(r.writes[i], pointer, bs);
      }
    }
    if (r.metadata_writes.length != 0) {
      for (i = 0; i < r.metadata_writes.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          4,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVMetadataWrite._encode_nested(
          r.metadata_writes[i],
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
    for (i = 0; i < r.reads.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(KvrwsetKVRead._estimate(r.reads[i]));
    }
    for (i = 0; i < r.range_queries_info.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetRangeQueryInfo._estimate(r.range_queries_info[i])
        );
    }
    for (i = 0; i < r.writes.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(KvrwsetKVWrite._estimate(r.writes[i]));
    }
    for (i = 0; i < r.metadata_writes.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVMetadataWrite._estimate(r.metadata_writes[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.reads.length != 0) {
      return false;
    }

    if (r.range_queries_info.length != 0) {
      return false;
    }

    if (r.writes.length != 0) {
      return false;
    }

    if (r.metadata_writes.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.reads.length; i1++) {
      output.reads.push(input.reads[i1]);
    }

    for (uint256 i2 = 0; i2 < input.range_queries_info.length; i2++) {
      output.range_queries_info.push(input.range_queries_info[i2]);
    }

    for (uint256 i3 = 0; i3 < input.writes.length; i3++) {
      output.writes.push(input.writes[i3]);
    }

    for (uint256 i4 = 0; i4 < input.metadata_writes.length; i4++) {
      output.metadata_writes.push(input.metadata_writes[i4]);
    }
  }

  //array helpers for Reads
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addReads(Data memory self, KvrwsetKVRead.Data memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVRead.Data[] memory tmp = new KvrwsetKVRead.Data[](
      self.reads.length + 1
    );
    for (uint256 i = 0; i < self.reads.length; i++) {
      tmp[i] = self.reads[i];
    }
    tmp[self.reads.length] = value;
    self.reads = tmp;
  }

  //array helpers for RangeQueriesInfo
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addRangeQueriesInfo(
    Data memory self,
    KvrwsetRangeQueryInfo.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetRangeQueryInfo.Data[] memory tmp = new KvrwsetRangeQueryInfo.Data[](
      self.range_queries_info.length + 1
    );
    for (uint256 i = 0; i < self.range_queries_info.length; i++) {
      tmp[i] = self.range_queries_info[i];
    }
    tmp[self.range_queries_info.length] = value;
    self.range_queries_info = tmp;
  }

  //array helpers for Writes
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addWrites(Data memory self, KvrwsetKVWrite.Data memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVWrite.Data[] memory tmp = new KvrwsetKVWrite.Data[](
      self.writes.length + 1
    );
    for (uint256 i = 0; i < self.writes.length; i++) {
      tmp[i] = self.writes[i];
    }
    tmp[self.writes.length] = value;
    self.writes = tmp;
  }

  //array helpers for MetadataWrites
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addMetadataWrites(
    Data memory self,
    KvrwsetKVMetadataWrite.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVMetadataWrite.Data[]
      memory tmp = new KvrwsetKVMetadataWrite.Data[](
        self.metadata_writes.length + 1
      );
    for (uint256 i = 0; i < self.metadata_writes.length; i++) {
      tmp[i] = self.metadata_writes[i];
    }
    tmp[self.metadata_writes.length] = value;
    self.metadata_writes = tmp;
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

//library KvrwsetKVRWSet

library KvrwsetHashedRWSet {
  //struct definition
  struct Data {
    KvrwsetKVReadHash.Data[] hashed_reads;
    KvrwsetKVWriteHash.Data[] hashed_writes;
    KvrwsetKVMetadataWriteHash.Data[] metadata_writes;
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
    uint256[4] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_hashed_reads(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_hashed_writes(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 3) {
        pointer += _read_unpacked_repeated_metadata_writes(
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
      require(r.hashed_reads.length == 0);
      r.hashed_reads = new KvrwsetKVReadHash.Data[](counters[1]);
    }
    if (counters[2] > 0) {
      require(r.hashed_writes.length == 0);
      r.hashed_writes = new KvrwsetKVWriteHash.Data[](counters[2]);
    }
    if (counters[3] > 0) {
      require(r.metadata_writes.length == 0);
      r.metadata_writes = new KvrwsetKVMetadataWriteHash.Data[](counters[3]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_hashed_reads(
          pointer,
          bs,
          r,
          counters
        );
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_hashed_writes(
          pointer,
          bs,
          r,
          counters
        );
      } else if (fieldId == 3) {
        pointer += _read_unpacked_repeated_metadata_writes(
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_hashed_reads(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[4] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (KvrwsetKVReadHash.Data memory x, uint256 sz) = _decode_KvrwsetKVReadHash(
      p,
      bs
    );
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.hashed_reads[r.hashed_reads.length - counters[1]] = x;
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
  function _read_unpacked_repeated_hashed_writes(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[4] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (KvrwsetKVWriteHash.Data memory x, uint256 sz) = _decode_KvrwsetKVWriteHash(
      p,
      bs
    );
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.hashed_writes[r.hashed_writes.length - counters[2]] = x;
      counters[2] -= 1;
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
  function _read_unpacked_repeated_metadata_writes(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[4] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      KvrwsetKVMetadataWriteHash.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetKVMetadataWriteHash(p, bs);
    if (isNil(r)) {
      counters[3] += 1;
    } else {
      r.metadata_writes[r.metadata_writes.length - counters[3]] = x;
      counters[3] -= 1;
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
  function _decode_KvrwsetKVReadHash(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVReadHash.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVReadHash.Data memory r, ) = KvrwsetKVReadHash._decode(
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
  function _decode_KvrwsetKVWriteHash(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVWriteHash.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVWriteHash.Data memory r, ) = KvrwsetKVWriteHash._decode(
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
  function _decode_KvrwsetKVMetadataWriteHash(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVMetadataWriteHash.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVMetadataWriteHash.Data memory r, ) = KvrwsetKVMetadataWriteHash
      ._decode(pointer, bs, sz);
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
    if (r.hashed_reads.length != 0) {
      for (i = 0; i < r.hashed_reads.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVReadHash._encode_nested(
          r.hashed_reads[i],
          pointer,
          bs
        );
      }
    }
    if (r.hashed_writes.length != 0) {
      for (i = 0; i < r.hashed_writes.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVWriteHash._encode_nested(
          r.hashed_writes[i],
          pointer,
          bs
        );
      }
    }
    if (r.metadata_writes.length != 0) {
      for (i = 0; i < r.metadata_writes.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          3,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVMetadataWriteHash._encode_nested(
          r.metadata_writes[i],
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
    for (i = 0; i < r.hashed_reads.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVReadHash._estimate(r.hashed_reads[i])
        );
    }
    for (i = 0; i < r.hashed_writes.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVWriteHash._estimate(r.hashed_writes[i])
        );
    }
    for (i = 0; i < r.metadata_writes.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVMetadataWriteHash._estimate(r.metadata_writes[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.hashed_reads.length != 0) {
      return false;
    }

    if (r.hashed_writes.length != 0) {
      return false;
    }

    if (r.metadata_writes.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.hashed_reads.length; i1++) {
      output.hashed_reads.push(input.hashed_reads[i1]);
    }

    for (uint256 i2 = 0; i2 < input.hashed_writes.length; i2++) {
      output.hashed_writes.push(input.hashed_writes[i2]);
    }

    for (uint256 i3 = 0; i3 < input.metadata_writes.length; i3++) {
      output.metadata_writes.push(input.metadata_writes[i3]);
    }
  }

  //array helpers for HashedReads
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addHashedReads(Data memory self, KvrwsetKVReadHash.Data memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVReadHash.Data[] memory tmp = new KvrwsetKVReadHash.Data[](
      self.hashed_reads.length + 1
    );
    for (uint256 i = 0; i < self.hashed_reads.length; i++) {
      tmp[i] = self.hashed_reads[i];
    }
    tmp[self.hashed_reads.length] = value;
    self.hashed_reads = tmp;
  }

  //array helpers for HashedWrites
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addHashedWrites(
    Data memory self,
    KvrwsetKVWriteHash.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVWriteHash.Data[] memory tmp = new KvrwsetKVWriteHash.Data[](
      self.hashed_writes.length + 1
    );
    for (uint256 i = 0; i < self.hashed_writes.length; i++) {
      tmp[i] = self.hashed_writes[i];
    }
    tmp[self.hashed_writes.length] = value;
    self.hashed_writes = tmp;
  }

  //array helpers for MetadataWrites
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addMetadataWrites(
    Data memory self,
    KvrwsetKVMetadataWriteHash.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVMetadataWriteHash.Data[]
      memory tmp = new KvrwsetKVMetadataWriteHash.Data[](
        self.metadata_writes.length + 1
      );
    for (uint256 i = 0; i < self.metadata_writes.length; i++) {
      tmp[i] = self.metadata_writes[i];
    }
    tmp[self.metadata_writes.length] = value;
    self.metadata_writes = tmp;
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

//library KvrwsetHashedRWSet

library KvrwsetKVRead {
  //struct definition
  struct Data {
    string key;
    KvrwsetVersion.Data version;
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
  function _read_version(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (KvrwsetVersion.Data memory x, uint256 sz) = _decode_KvrwsetVersion(p, bs);
    r.version = x;
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
  function _decode_KvrwsetVersion(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetVersion.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetVersion.Data memory r, ) = KvrwsetVersion._decode(pointer, bs, sz);
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

    if (bytes(r.key).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.key, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += KvrwsetVersion._encode_nested(r.version, pointer, bs);

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
    e += 1 + ProtoBufRuntime._sz_lendelim(KvrwsetVersion._estimate(r.version));
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.key).length != 0) {
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
    KvrwsetVersion.store(input.version, output.version);
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

//library KvrwsetKVRead

library KvrwsetKVWrite {
  //struct definition
  struct Data {
    string key;
    bool is_delete;
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
        pointer += _read_is_delete(pointer, bs, r);
      } else if (fieldId == 3) {
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
  function _read_is_delete(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.is_delete = x;
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
    if (r.is_delete != false) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.is_delete, pointer, bs);
    }
    if (r.value.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
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
    e += 1 + 1;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.value.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.key).length != 0) {
      return false;
    }

    if (r.is_delete != false) {
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
    output.is_delete = input.is_delete;
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

//library KvrwsetKVWrite

library KvrwsetKVMetadataWrite {
  //struct definition
  struct Data {
    string key;
    KvrwsetKVMetadataEntry.Data[] entries;
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
        pointer += _read_key(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_entries(
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
      require(r.entries.length == 0);
      r.entries = new KvrwsetKVMetadataEntry.Data[](counters[2]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 2) {
        pointer += _read_unpacked_repeated_entries(pointer, bs, r, counters);
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
   * @param counters The counters for repeated fields
   * @return The number of bytes decoded
   */
  function _read_unpacked_repeated_entries(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[3] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      KvrwsetKVMetadataEntry.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetKVMetadataEntry(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.entries[r.entries.length - counters[2]] = x;
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
  function _decode_KvrwsetKVMetadataEntry(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVMetadataEntry.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVMetadataEntry.Data memory r, ) = KvrwsetKVMetadataEntry._decode(
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
    if (bytes(r.key).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.key, pointer, bs);
    }
    if (r.entries.length != 0) {
      for (i = 0; i < r.entries.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVMetadataEntry._encode_nested(
          r.entries[i],
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.key).length);
    for (i = 0; i < r.entries.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVMetadataEntry._estimate(r.entries[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.key).length != 0) {
      return false;
    }

    if (r.entries.length != 0) {
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

    for (uint256 i2 = 0; i2 < input.entries.length; i2++) {
      output.entries.push(input.entries[i2]);
    }
  }

  //array helpers for Entries
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addEntries(
    Data memory self,
    KvrwsetKVMetadataEntry.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVMetadataEntry.Data[]
      memory tmp = new KvrwsetKVMetadataEntry.Data[](self.entries.length + 1);
    for (uint256 i = 0; i < self.entries.length; i++) {
      tmp[i] = self.entries[i];
    }
    tmp[self.entries.length] = value;
    self.entries = tmp;
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

//library KvrwsetKVMetadataWrite

library KvrwsetKVReadHash {
  //struct definition
  struct Data {
    bytes key_hash;
    KvrwsetVersion.Data version;
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
        pointer += _read_key_hash(pointer, bs, r);
      } else if (fieldId == 2) {
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
  function _read_key_hash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.key_hash = x;
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
    (KvrwsetVersion.Data memory x, uint256 sz) = _decode_KvrwsetVersion(p, bs);
    r.version = x;
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
  function _decode_KvrwsetVersion(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetVersion.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetVersion.Data memory r, ) = KvrwsetVersion._decode(pointer, bs, sz);
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

    if (r.key_hash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.key_hash, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += KvrwsetVersion._encode_nested(r.version, pointer, bs);

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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.key_hash.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(KvrwsetVersion._estimate(r.version));
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.key_hash.length != 0) {
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
    output.key_hash = input.key_hash;
    KvrwsetVersion.store(input.version, output.version);
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

//library KvrwsetKVReadHash

library KvrwsetKVWriteHash {
  //struct definition
  struct Data {
    bytes key_hash;
    bool is_delete;
    bytes value_hash;
    bool is_purge;
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
        pointer += _read_key_hash(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_is_delete(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_value_hash(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_is_purge(pointer, bs, r);
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
  function _read_key_hash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.key_hash = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_is_delete(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.is_delete = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_value_hash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.value_hash = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_is_purge(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.is_purge = x;
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

    if (r.key_hash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.key_hash, pointer, bs);
    }
    if (r.is_delete != false) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.is_delete, pointer, bs);
    }
    if (r.value_hash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.value_hash, pointer, bs);
    }
    if (r.is_purge != false) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.is_purge, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.key_hash.length);
    e += 1 + 1;
    e += 1 + ProtoBufRuntime._sz_lendelim(r.value_hash.length);
    e += 1 + 1;
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.key_hash.length != 0) {
      return false;
    }

    if (r.is_delete != false) {
      return false;
    }

    if (r.value_hash.length != 0) {
      return false;
    }

    if (r.is_purge != false) {
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
    output.key_hash = input.key_hash;
    output.is_delete = input.is_delete;
    output.value_hash = input.value_hash;
    output.is_purge = input.is_purge;
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

//library KvrwsetKVWriteHash

library KvrwsetKVMetadataWriteHash {
  //struct definition
  struct Data {
    bytes key_hash;
    KvrwsetKVMetadataEntry.Data[] entries;
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
        pointer += _read_key_hash(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_entries(
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
      require(r.entries.length == 0);
      r.entries = new KvrwsetKVMetadataEntry.Data[](counters[2]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 2) {
        pointer += _read_unpacked_repeated_entries(pointer, bs, r, counters);
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
  function _read_key_hash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.key_hash = x;
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
  function _read_unpacked_repeated_entries(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[3] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      KvrwsetKVMetadataEntry.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetKVMetadataEntry(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.entries[r.entries.length - counters[2]] = x;
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
  function _decode_KvrwsetKVMetadataEntry(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVMetadataEntry.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVMetadataEntry.Data memory r, ) = KvrwsetKVMetadataEntry._decode(
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
    if (r.key_hash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.key_hash, pointer, bs);
    }
    if (r.entries.length != 0) {
      for (i = 0; i < r.entries.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVMetadataEntry._encode_nested(
          r.entries[i],
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.key_hash.length);
    for (i = 0; i < r.entries.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          KvrwsetKVMetadataEntry._estimate(r.entries[i])
        );
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.key_hash.length != 0) {
      return false;
    }

    if (r.entries.length != 0) {
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
    output.key_hash = input.key_hash;

    for (uint256 i2 = 0; i2 < input.entries.length; i2++) {
      output.entries.push(input.entries[i2]);
    }
  }

  //array helpers for Entries
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addEntries(
    Data memory self,
    KvrwsetKVMetadataEntry.Data memory value
  ) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVMetadataEntry.Data[]
      memory tmp = new KvrwsetKVMetadataEntry.Data[](self.entries.length + 1);
    for (uint256 i = 0; i < self.entries.length; i++) {
      tmp[i] = self.entries[i];
    }
    tmp[self.entries.length] = value;
    self.entries = tmp;
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

//library KvrwsetKVMetadataWriteHash

library KvrwsetKVMetadataEntry {
  //struct definition
  struct Data {
    string name;
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
        pointer += _read_name(pointer, bs, r);
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

    if (bytes(r.name).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.name, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.name).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.value.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.name).length != 0) {
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
    output.name = input.name;
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

//library KvrwsetKVMetadataEntry

library KvrwsetVersion {
  //struct definition
  struct Data {
    uint64 block_num;
    uint64 tx_num;
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
        pointer += _read_block_num(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_tx_num(pointer, bs, r);
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
  function _read_block_num(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint64 x, uint256 sz) = ProtoBufRuntime._decode_uint64(p, bs);
    r.block_num = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_tx_num(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint64 x, uint256 sz) = ProtoBufRuntime._decode_uint64(p, bs);
    r.tx_num = x;
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

    if (r.block_num != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint64(r.block_num, pointer, bs);
    }
    if (r.tx_num != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint64(r.tx_num, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_uint64(r.block_num);
    e += 1 + ProtoBufRuntime._sz_uint64(r.tx_num);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.block_num != 0) {
      return false;
    }

    if (r.tx_num != 0) {
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
    output.block_num = input.block_num;
    output.tx_num = input.tx_num;
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

//library KvrwsetVersion

library KvrwsetRangeQueryInfo {
  //struct definition
  struct Data {
    string start_key;
    string end_key;
    bool itr_exhausted;
    KvrwsetQueryReads.Data raw_reads;
    KvrwsetQueryReadsMerkleSummary.Data reads_merkle_hashes;
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
        pointer += _read_start_key(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_end_key(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_itr_exhausted(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_raw_reads(pointer, bs, r);
      } else if (fieldId == 5) {
        pointer += _read_reads_merkle_hashes(pointer, bs, r);
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
  function _read_start_key(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.start_key = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_end_key(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.end_key = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_itr_exhausted(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.itr_exhausted = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_raw_reads(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (KvrwsetQueryReads.Data memory x, uint256 sz) = _decode_KvrwsetQueryReads(
      p,
      bs
    );
    r.raw_reads = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_reads_merkle_hashes(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      KvrwsetQueryReadsMerkleSummary.Data memory x,
      uint256 sz
    ) = _decode_KvrwsetQueryReadsMerkleSummary(p, bs);
    r.reads_merkle_hashes = x;
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
  function _decode_KvrwsetQueryReads(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetQueryReads.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetQueryReads.Data memory r, ) = KvrwsetQueryReads._decode(
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
  function _decode_KvrwsetQueryReadsMerkleSummary(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetQueryReadsMerkleSummary.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      KvrwsetQueryReadsMerkleSummary.Data memory r,

    ) = KvrwsetQueryReadsMerkleSummary._decode(pointer, bs, sz);
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

    if (bytes(r.start_key).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.start_key, pointer, bs);
    }
    if (bytes(r.end_key).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.end_key, pointer, bs);
    }
    if (r.itr_exhausted != false) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.itr_exhausted, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      4,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += KvrwsetQueryReads._encode_nested(r.raw_reads, pointer, bs);

    pointer += ProtoBufRuntime._encode_key(
      5,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += KvrwsetQueryReadsMerkleSummary._encode_nested(
      r.reads_merkle_hashes,
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.start_key).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.end_key).length);
    e += 1 + 1;
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(KvrwsetQueryReads._estimate(r.raw_reads));
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        KvrwsetQueryReadsMerkleSummary._estimate(r.reads_merkle_hashes)
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.start_key).length != 0) {
      return false;
    }

    if (bytes(r.end_key).length != 0) {
      return false;
    }

    if (r.itr_exhausted != false) {
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
    output.start_key = input.start_key;
    output.end_key = input.end_key;
    output.itr_exhausted = input.itr_exhausted;
    KvrwsetQueryReads.store(input.raw_reads, output.raw_reads);
    KvrwsetQueryReadsMerkleSummary.store(
      input.reads_merkle_hashes,
      output.reads_merkle_hashes
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

//library KvrwsetRangeQueryInfo

library KvrwsetQueryReads {
  //struct definition
  struct Data {
    KvrwsetKVRead.Data[] kv_reads;
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
        pointer += _read_unpacked_repeated_kv_reads(
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
      require(r.kv_reads.length == 0);
      r.kv_reads = new KvrwsetKVRead.Data[](counters[1]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_kv_reads(pointer, bs, r, counters);
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
  function _read_unpacked_repeated_kv_reads(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[2] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (KvrwsetKVRead.Data memory x, uint256 sz) = _decode_KvrwsetKVRead(p, bs);
    if (isNil(r)) {
      counters[1] += 1;
    } else {
      r.kv_reads[r.kv_reads.length - counters[1]] = x;
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
  function _decode_KvrwsetKVRead(uint256 p, bytes memory bs)
    internal
    pure
    returns (KvrwsetKVRead.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (KvrwsetKVRead.Data memory r, ) = KvrwsetKVRead._decode(pointer, bs, sz);
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
    if (r.kv_reads.length != 0) {
      for (i = 0; i < r.kv_reads.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += KvrwsetKVRead._encode_nested(r.kv_reads[i], pointer, bs);
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
    for (i = 0; i < r.kv_reads.length; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(KvrwsetKVRead._estimate(r.kv_reads[i]));
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.kv_reads.length != 0) {
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
    for (uint256 i1 = 0; i1 < input.kv_reads.length; i1++) {
      output.kv_reads.push(input.kv_reads[i1]);
    }
  }

  //array helpers for KvReads
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addKvReads(Data memory self, KvrwsetKVRead.Data memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    KvrwsetKVRead.Data[] memory tmp = new KvrwsetKVRead.Data[](
      self.kv_reads.length + 1
    );
    for (uint256 i = 0; i < self.kv_reads.length; i++) {
      tmp[i] = self.kv_reads[i];
    }
    tmp[self.kv_reads.length] = value;
    self.kv_reads = tmp;
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

//library KvrwsetQueryReads

library KvrwsetQueryReadsMerkleSummary {
  //struct definition
  struct Data {
    uint32 max_degree;
    uint32 max_level;
    bytes[] max_level_hashes;
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
    uint256[4] memory counters;
    uint256 fieldId;
    ProtoBufRuntime.WireType wireType;
    uint256 bytesRead;
    uint256 offset = p;
    uint256 pointer = p;
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_max_degree(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_max_level(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_unpacked_repeated_max_level_hashes(
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
    if (counters[3] > 0) {
      require(r.max_level_hashes.length == 0);
      r.max_level_hashes = new bytes[](counters[3]);
    }

    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 3) {
        pointer += _read_unpacked_repeated_max_level_hashes(
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
  function _read_max_degree(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
    r.max_degree = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_max_level(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
    r.max_level = x;
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
  function _read_unpacked_repeated_max_level_hashes(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[4] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    if (isNil(r)) {
      counters[3] += 1;
    } else {
      r.max_level_hashes[r.max_level_hashes.length - counters[3]] = x;
      counters[3] -= 1;
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
    if (r.max_degree != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint32(r.max_degree, pointer, bs);
    }
    if (r.max_level != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_uint32(r.max_level, pointer, bs);
    }
    if (r.max_level_hashes.length != 0) {
      for (i = 0; i < r.max_level_hashes.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          3,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(
          r.max_level_hashes[i],
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
    e += 1 + ProtoBufRuntime._sz_uint32(r.max_degree);
    e += 1 + ProtoBufRuntime._sz_uint32(r.max_level);
    for (i = 0; i < r.max_level_hashes.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.max_level_hashes[i].length);
    }
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.max_degree != 0) {
      return false;
    }

    if (r.max_level != 0) {
      return false;
    }

    if (r.max_level_hashes.length != 0) {
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
    output.max_degree = input.max_degree;
    output.max_level = input.max_level;
    output.max_level_hashes = input.max_level_hashes;
  }

  //array helpers for MaxLevelHashes
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addMaxLevelHashes(Data memory self, bytes memory value)
    internal
    pure
  {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.max_level_hashes.length + 1);
    for (uint256 i = 0; i < self.max_level_hashes.length; i++) {
      tmp[i] = self.max_level_hashes[i];
    }
    tmp[self.max_level_hashes.length] = value;
    self.max_level_hashes = tmp;
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
//library KvrwsetQueryReadsMerkleSummary

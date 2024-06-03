// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../yui-ibc-solidity/contracts/core/types/ProtoBufRuntime.sol";
import "../../yui-ibc-solidity/contracts/core/types/GoogleProtobufAny.sol";
import "../common/policies.sol";

library ProtosChaincodeID {
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

//library ProtosChaincodeID

library ProtosChaincodeInput {
  //struct definition
  struct Data {
    bytes[] args;
    ProtosChaincodeInputDecorationsEntry.Data[] decorations;
    bool is_init;
    //non serialized fields
    uint256 _size_decorations;
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
        pointer += _read_unpacked_repeated_args(pointer, bs, nil(), counters);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_decorations(
          pointer,
          bs,
          nil(),
          counters
        );
      } else if (fieldId == 3) {
        pointer += _read_is_init(pointer, bs, r);
      } else {
        pointer += ProtoBufRuntime._skip_field_decode(wireType, pointer, bs);
      }
    }
    pointer = offset;
    if (counters[1] > 0) {
      require(r.args.length == 0);
      r.args = new bytes[](counters[1]);
    }
    if (counters[2] > 0) {
      require(r.decorations.length == 0);
      r.decorations = new ProtosChaincodeInputDecorationsEntry.Data[](
        counters[2]
      );
    }

    r._size_decorations = counters[2];
    while (pointer < offset + sz) {
      (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(pointer, bs);
      pointer += bytesRead;
      if (fieldId == 1) {
        pointer += _read_unpacked_repeated_args(pointer, bs, r, counters);
      } else if (fieldId == 2) {
        pointer += _read_unpacked_repeated_decorations(
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
  function _read_unpacked_repeated_args(
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
      counters[1] += 1;
    } else {
      r.args[r.args.length - counters[1]] = x;
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
  function _read_unpacked_repeated_decorations(
    uint256 p,
    bytes memory bs,
    Data memory r,
    uint256[4] memory counters
  ) internal pure returns (uint256) {
    /**
     * if `r` is NULL, then only counting the number of fields.
     */
    (
      ProtosChaincodeInputDecorationsEntry.Data memory x,
      uint256 sz
    ) = _decode_ProtosChaincodeInputDecorationsEntry(p, bs);
    if (isNil(r)) {
      counters[2] += 1;
    } else {
      r.decorations[r.decorations.length - counters[2]] = x;
      counters[2] -= 1;
    }
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_is_init(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bool x, uint256 sz) = ProtoBufRuntime._decode_bool(p, bs);
    r.is_init = x;
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
  function _decode_ProtosChaincodeInputDecorationsEntry(
    uint256 p,
    bytes memory bs
  )
    internal
    pure
    returns (ProtosChaincodeInputDecorationsEntry.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      ProtosChaincodeInputDecorationsEntry.Data memory r,

    ) = ProtosChaincodeInputDecorationsEntry._decode(pointer, bs, sz);
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
    if (r.args.length != 0) {
      for (i = 0; i < r.args.length; i++) {
        pointer += ProtoBufRuntime._encode_key(
          1,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtoBufRuntime._encode_bytes(r.args[i], pointer, bs);
      }
    }
    if (r.decorations.length != 0) {
      for (i = 0; i < r._size_decorations; i++) {
        pointer += ProtoBufRuntime._encode_key(
          2,
          ProtoBufRuntime.WireType.LengthDelim,
          pointer,
          bs
        );
        pointer += ProtosChaincodeInputDecorationsEntry._encode_nested(
          r.decorations[i],
          pointer,
          bs
        );
      }
    }
    if (r.is_init != false) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bool(r.is_init, pointer, bs);
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
    for (i = 0; i < r.args.length; i++) {
      e += 1 + ProtoBufRuntime._sz_lendelim(r.args[i].length);
    }
    for (i = 0; i < r._size_decorations; i++) {
      e +=
        1 +
        ProtoBufRuntime._sz_lendelim(
          ProtosChaincodeInputDecorationsEntry._estimate(r.decorations[i])
        );
    }
    e += 1 + 1;
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.args.length != 0) {
      return false;
    }

    if (r.decorations.length != 0) {
      return false;
    }

    if (r.is_init != false) {
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
    output.args = input.args;

    for (uint256 i2 = 0; i2 < input.decorations.length; i2++) {
      output.decorations.push(input.decorations[i2]);
    }
    output._size_decorations = input._size_decorations;

    output.is_init = input.is_init;
  }

  //map helpers for Decorations
  /**
   * @dev Get value from a map
   * @param self The in-memory struct
   * @param key The key to get
   * @return The value in map if it exists
   */
  function getDecorations(Data memory self, string memory key)
    internal
    pure
    returns (bytes memory)
  {
    bytes memory defaultValue;
    for (uint256 i = 0; i < self._size_decorations; i++) {
      ProtosChaincodeInputDecorationsEntry.Data memory data = self.decorations[
        i
      ];
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
  function searchDecorations(Data memory self, string memory key)
    internal
    pure
    returns (bool, bytes memory)
  {
    bytes memory defaultValue;
    for (uint256 i = 0; i < self._size_decorations; i++) {
      ProtosChaincodeInputDecorationsEntry.Data memory data = self.decorations[
        i
      ];
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
  function addDecorations(
    Data memory self,
    string memory key,
    bytes memory value
  ) internal pure {
    /**
     * First search whether the key exists.
     * If not, add to the array. Otherwise, replace the value.
     * If a resize is needed, the array size will be doubled.
     */
    for (uint256 i = 0; i < self._size_decorations; i++) {
      ProtosChaincodeInputDecorationsEntry.Data memory data = self.decorations[
        i
      ];
      if (
        keccak256(abi.encodePacked((key))) ==
        keccak256(abi.encodePacked((data.key)))
      ) {
        self.decorations[i].value = value;
        return;
      }
    }
    if (self.decorations.length == 0) {
      self.decorations = new ProtosChaincodeInputDecorationsEntry.Data[](10);
    }
    if (self._size_decorations == self.decorations.length) {
      ProtosChaincodeInputDecorationsEntry.Data[]
        memory tmp = new ProtosChaincodeInputDecorationsEntry.Data[](
          self.decorations.length * 2
        );
      for (uint256 i = 0; i < self._size_decorations; i++) {
        tmp[i] = self.decorations[i];
      }
      self.decorations = tmp;
    }
    ProtosChaincodeInputDecorationsEntry.Data memory entry;
    entry.key = key;
    entry.value = value;
    self.decorations[self._size_decorations++] = entry;
  }

  /**
   * @dev Delete key from a map
   * @param self The in-memory struct
   * @param key The key to delete
   */
  function rmDecorations(Data memory self, string memory key) internal pure {
    /**
     * First search whether the key exists.
     * If not, do nothing.
     * Otherwise, replace with last key-value pair in the array.
     */
    uint256 pos;
    for (uint256 i = 0; i < self._size_decorations; i++) {
      ProtosChaincodeInputDecorationsEntry.Data memory data = self.decorations[
        i
      ];
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
    self.decorations[pos] = self.decorations[--self._size_decorations];
  }

  //array helpers for Args
  /**
   * @dev Add value to an array
   * @param self The in-memory struct
   * @param value The value to add
   */
  function addArgs(Data memory self, bytes memory value) internal pure {
    /**
     * First resize the array. Then add the new element to the end.
     */
    bytes[] memory tmp = new bytes[](self.args.length + 1);
    for (uint256 i = 0; i < self.args.length; i++) {
      tmp[i] = self.args[i];
    }
    tmp[self.args.length] = value;
    self.args = tmp;
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

//library ProtosChaincodeInput

library ProtosChaincodeInputDecorationsEntry {
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

//library ProtosChaincodeInputDecorationsEntry

library ProtosChaincodeSpec {
  //enum definition
  // Solidity enum definitions
  enum Type {
    UNDEFINED,
    GOLANG,
    NODE,
    CAR,
    JAVA
  }

  // Solidity enum encoder
  function encode_Type(Type x) internal pure returns (int32) {
    if (x == Type.UNDEFINED) {
      return 0;
    }

    if (x == Type.GOLANG) {
      return 1;
    }

    if (x == Type.NODE) {
      return 2;
    }

    if (x == Type.CAR) {
      return 3;
    }

    if (x == Type.JAVA) {
      return 4;
    }
    revert();
  }

  // Solidity enum decoder
  function decode_Type(int64 x) internal pure returns (Type) {
    if (x == 0) {
      return Type.UNDEFINED;
    }

    if (x == 1) {
      return Type.GOLANG;
    }

    if (x == 2) {
      return Type.NODE;
    }

    if (x == 3) {
      return Type.CAR;
    }

    if (x == 4) {
      return Type.JAVA;
    }
    revert();
  }

  /**
   * @dev The estimator for an packed enum array
   * @return The number of bytes encoded
   */
  function estimate_packed_repeated_Type(Type[] memory a)
    internal
    pure
    returns (uint256)
  {
    uint256 e = 0;
    for (uint256 i = 0; i < a.length; i++) {
      e += ProtoBufRuntime._sz_enum(encode_Type(a[i]));
    }
    return e;
  }

  //struct definition
  struct Data {
    ProtosChaincodeSpec.Type chaincode_spec_type;
    ProtosChaincodeID.Data chaincode_id;
    ProtosChaincodeInput.Data input;
    int32 timeout;
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
        pointer += _read_chaincode_id(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_input(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_timeout(pointer, bs, r);
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
    ProtosChaincodeSpec.Type x = ProtosChaincodeSpec.decode_Type(tmp);
    r.chaincode_spec_type = x;
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
    (
      ProtosChaincodeInput.Data memory x,
      uint256 sz
    ) = _decode_ProtosChaincodeInput(p, bs);
    r.input = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_timeout(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (int32 x, uint256 sz) = ProtoBufRuntime._decode_int32(p, bs);
    r.timeout = x;
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

  /**
   * @dev The decoder for reading a inner struct field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @return The decoded inner-struct
   * @return The number of bytes used to decode
   */
  function _decode_ProtosChaincodeInput(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosChaincodeInput.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosChaincodeInput.Data memory r, ) = ProtosChaincodeInput._decode(
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

    if (uint256(r.chaincode_spec_type) != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      int32 _enum_type = ProtosChaincodeSpec.encode_Type(r.chaincode_spec_type);
      pointer += ProtoBufRuntime._encode_enum(_enum_type, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      2,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeID._encode_nested(r.chaincode_id, pointer, bs);

    pointer += ProtoBufRuntime._encode_key(
      3,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeInput._encode_nested(r.input, pointer, bs);

    if (r.timeout != 0) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.Varint,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_int32(r.timeout, pointer, bs);
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
        ProtosChaincodeSpec.encode_Type(r.chaincode_spec_type)
      );
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(ProtosChaincodeID._estimate(r.chaincode_id));
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(ProtosChaincodeInput._estimate(r.input));
    e += 1 + ProtoBufRuntime._sz_int32(r.timeout);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (uint256(r.chaincode_spec_type) != 0) {
      return false;
    }

    if (r.timeout != 0) {
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
    output.chaincode_spec_type = input.chaincode_spec_type;
    ProtosChaincodeID.store(input.chaincode_id, output.chaincode_id);
    ProtosChaincodeInput.store(input.input, output.input);
    output.timeout = input.timeout;
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

//library ProtosChaincodeSpec

library ProtosChaincodeDeploymentSpec {
  //struct definition
  struct Data {
    ProtosChaincodeSpec.Data chaincode_spec;
    bytes code_package;
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
        pointer += _read_chaincode_spec(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_code_package(pointer, bs, r);
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
  function _read_chaincode_spec(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      ProtosChaincodeSpec.Data memory x,
      uint256 sz
    ) = _decode_ProtosChaincodeSpec(p, bs);
    r.chaincode_spec = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_code_package(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.code_package = x;
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
  function _decode_ProtosChaincodeSpec(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosChaincodeSpec.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosChaincodeSpec.Data memory r, ) = ProtosChaincodeSpec._decode(
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
      1,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeSpec._encode_nested(
      r.chaincode_spec,
      pointer,
      bs
    );

    if (r.code_package.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.code_package, pointer, bs);
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
      ProtoBufRuntime._sz_lendelim(
        ProtosChaincodeSpec._estimate(r.chaincode_spec)
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(r.code_package.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.code_package.length != 0) {
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
    ProtosChaincodeSpec.store(input.chaincode_spec, output.chaincode_spec);
    output.code_package = input.code_package;
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

//library ProtosChaincodeDeploymentSpec

library ProtosChaincodeInvocationSpec {
  //struct definition
  struct Data {
    ProtosChaincodeSpec.Data chaincode_spec;
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
        pointer += _read_chaincode_spec(pointer, bs, r);
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
  function _read_chaincode_spec(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      ProtosChaincodeSpec.Data memory x,
      uint256 sz
    ) = _decode_ProtosChaincodeSpec(p, bs);
    r.chaincode_spec = x;
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
  function _decode_ProtosChaincodeSpec(uint256 p, bytes memory bs)
    internal
    pure
    returns (ProtosChaincodeSpec.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (ProtosChaincodeSpec.Data memory r, ) = ProtosChaincodeSpec._decode(
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
      1,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += ProtosChaincodeSpec._encode_nested(
      r.chaincode_spec,
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
        ProtosChaincodeSpec._estimate(r.chaincode_spec)
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
    ProtosChaincodeSpec.store(input.chaincode_spec, output.chaincode_spec);
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

//library ProtosChaincodeInvocationSpec

library ProtosLifecycleEvent {
  //struct definition
  struct Data {
    string chaincode_name;
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
        pointer += _read_chaincode_name(pointer, bs, r);
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
  function _read_chaincode_name(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.chaincode_name = x;
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

    if (bytes(r.chaincode_name).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.chaincode_name, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.chaincode_name).length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.chaincode_name).length != 0) {
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
    output.chaincode_name = input.chaincode_name;
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

//library ProtosLifecycleEvent

library ProtosCDSData {
  //struct definition
  struct Data {
    bytes hash;
    bytes metadatahash;
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
        pointer += _read_hash(pointer, bs, r);
      } else if (fieldId == 2) {
        pointer += _read_metadatahash(pointer, bs, r);
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
  function _read_hash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.hash = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_metadatahash(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.metadatahash = x;
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

    if (r.hash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.hash, pointer, bs);
    }
    if (r.metadatahash.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.metadatahash, pointer, bs);
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
    e += 1 + ProtoBufRuntime._sz_lendelim(r.hash.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.metadatahash.length);
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (r.hash.length != 0) {
      return false;
    }

    if (r.metadatahash.length != 0) {
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
    output.hash = input.hash;
    output.metadatahash = input.metadatahash;
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

//library ProtosCDSData

library ProtosChaincodeData {
  //struct definition
  struct Data {
    string name;
    string version;
    string escc;
    string vscc;
    CommonSignaturePolicyEnvelope.Data policy;
    bytes data;
    bytes id;
    CommonSignaturePolicyEnvelope.Data instantiation_policy;
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
        pointer += _read_version(pointer, bs, r);
      } else if (fieldId == 3) {
        pointer += _read_escc(pointer, bs, r);
      } else if (fieldId == 4) {
        pointer += _read_vscc(pointer, bs, r);
      } else if (fieldId == 5) {
        pointer += _read_policy(pointer, bs, r);
      } else if (fieldId == 6) {
        pointer += _read_data(pointer, bs, r);
      } else if (fieldId == 7) {
        pointer += _read_id(pointer, bs, r);
      } else if (fieldId == 8) {
        pointer += _read_instantiation_policy(pointer, bs, r);
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
  function _read_version(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.version = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_escc(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.escc = x;
    return sz;
  }

  /**
   * @dev The decoder for reading a field
   * @param p The offset of bytes array to start decode
   * @param bs The bytes array to be decoded
   * @param r The in-memory struct
   * @return The number of bytes decoded
   */
  function _read_vscc(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
    r.vscc = x;
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
    (
      CommonSignaturePolicyEnvelope.Data memory x,
      uint256 sz
    ) = _decode_CommonSignaturePolicyEnvelope(p, bs);
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
  function _read_data(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
    r.data = x;
    return sz;
  }

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
    (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
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
  function _read_instantiation_policy(
    uint256 p,
    bytes memory bs,
    Data memory r
  ) internal pure returns (uint256) {
    (
      CommonSignaturePolicyEnvelope.Data memory x,
      uint256 sz
    ) = _decode_CommonSignaturePolicyEnvelope(p, bs);
    r.instantiation_policy = x;
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
  function _decode_CommonSignaturePolicyEnvelope(uint256 p, bytes memory bs)
    internal
    pure
    returns (CommonSignaturePolicyEnvelope.Data memory, uint256)
  {
    uint256 pointer = p;
    (uint256 sz, uint256 bytesRead) = ProtoBufRuntime._decode_varint(
      pointer,
      bs
    );
    pointer += bytesRead;
    (
      CommonSignaturePolicyEnvelope.Data memory r,

    ) = CommonSignaturePolicyEnvelope._decode(pointer, bs, sz);
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

    if (bytes(r.name).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        1,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.name, pointer, bs);
    }
    if (bytes(r.version).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        2,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.version, pointer, bs);
    }
    if (bytes(r.escc).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        3,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.escc, pointer, bs);
    }
    if (bytes(r.vscc).length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        4,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_string(r.vscc, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      5,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += CommonSignaturePolicyEnvelope._encode_nested(
      r.policy,
      pointer,
      bs
    );

    if (r.data.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        6,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.data, pointer, bs);
    }
    if (r.id.length != 0) {
      pointer += ProtoBufRuntime._encode_key(
        7,
        ProtoBufRuntime.WireType.LengthDelim,
        pointer,
        bs
      );
      pointer += ProtoBufRuntime._encode_bytes(r.id, pointer, bs);
    }

    pointer += ProtoBufRuntime._encode_key(
      8,
      ProtoBufRuntime.WireType.LengthDelim,
      pointer,
      bs
    );
    pointer += CommonSignaturePolicyEnvelope._encode_nested(
      r.instantiation_policy,
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
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.name).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.version).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.escc).length);
    e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.vscc).length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        CommonSignaturePolicyEnvelope._estimate(r.policy)
      );
    e += 1 + ProtoBufRuntime._sz_lendelim(r.data.length);
    e += 1 + ProtoBufRuntime._sz_lendelim(r.id.length);
    e +=
      1 +
      ProtoBufRuntime._sz_lendelim(
        CommonSignaturePolicyEnvelope._estimate(r.instantiation_policy)
      );
    return e;
  }

  // empty checker

  function _empty(Data memory r) internal pure returns (bool) {
    if (bytes(r.name).length != 0) {
      return false;
    }

    if (bytes(r.version).length != 0) {
      return false;
    }

    if (bytes(r.escc).length != 0) {
      return false;
    }

    if (bytes(r.vscc).length != 0) {
      return false;
    }

    if (r.data.length != 0) {
      return false;
    }

    if (r.id.length != 0) {
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
    output.version = input.version;
    output.escc = input.escc;
    output.vscc = input.vscc;
    CommonSignaturePolicyEnvelope.store(input.policy, output.policy);
    output.data = input.data;
    output.id = input.id;
    CommonSignaturePolicyEnvelope.store(
      input.instantiation_policy,
      output.instantiation_policy
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
//library ProtosChaincodeData

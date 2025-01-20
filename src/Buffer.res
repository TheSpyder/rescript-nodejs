type t = {length: int}
open Js.TypedArray2

module Constants = {
  @module("node:buffer") @scope("constants") @val
  external _MAX_LENGTH: int = "MAX_LENGTH"
  @module("node:buffer") @scope("constants") @val
  external _MAX_STRING_LENGTH: int = "MAX_STRING_LENGTH"
}

@val external isBuffer: 'a => bool = "Buffer.isBuffer"
@val external fromString: string => t = "Buffer.from"
@val
external fromStringWithEncoding: (string, StringEncoding.t) => t = "Buffer.from"

@ocaml.doc("
 * `fromArray(array)`
 *
 * Constructs a new `Buffer` object from an array of integers.
 ")
@val
external fromArray: array<int> => t = "Buffer.from"

@ocaml.doc("
 * `fromArrayBuffer(arrayBuffer)`
 *
 * Constructs a new `Buffer` object from an `ArrayBuffer` object.
 *
 * **Note:** This does not copy the data from the `ArrayBuffer` instance, but instead creates
 * a \"view\" over the existing data in memory. Mutations of the underlying `ArrayBuffer`
 * will be reflected in the `Buffer` view, and vice versa.
 ")
@val
external fromArrayBuffer: ArrayBuffer.t => t = "Buffer.from"

@ocaml.doc("
 * `fromArrayBufferOffset(arrayBuffer, ~offset)`
 *
 * Constructs a new `Buffer` object from an `ArrayBuffer` object, starting at index
 * `offset`.
 *
 * **Note:** This does not copy the data from the `ArrayBuffer` instance, but instead creates
 * a \"view\" over the existing data in memory. Mutations of the underlying `ArrayBuffer`
 * will be reflected in the `Buffer` view, and vice versa.
 ")
@val
external fromArrayBufferOffset: (ArrayBuffer.t, ~offset: int) => t = "Buffer.from"

@ocaml.doc("
 * `fromArrayBufferRange(arrayBuffer, ~offset, ~length)`
 *
 * Constructs a new `Buffer` object from an `ArrayBuffer` object, starting at index
 * `~offset`, and ending at index `~length`.
 *
 * **Note:** This does not copy the data from the `ArrayBuffer` instance, but instead creates
 * a \"view\" over the existing data in memory. Mutations of the underlying `ArrayBuffer`
 * will be reflected in the `Buffer` view, and vice versa.
 ")
@val
external fromArrayBufferRange: (ArrayBuffer.t, ~offset: int, ~length: int) => t = "Buffer.from"

@ocaml.doc("
 * `fromBuffer(buffer)`
 *
 * Constructs a new `Buffer` object from an existing `Buffer` object, creating a **copy** of
 * its internal data.
 ")
@val
external fromBuffer: t => t = "Buffer.from"

@ocaml.doc("
 * `alloc(size)`
 *
 * Allocates a new `Buffer` object with a length specified by `size`, setting each element
 * to zero.
 ")
@val
external alloc: int => t = "Buffer.alloc"

@ocaml.doc("
 * `allocFillInt(size, ~fill)`
 *
 * Allocates a new `Buffer` object with a length specified by `size`, and fills each element
 * with the value of `~fill`.
 ")
@val
external allocFillInt: (int, ~fill: int) => t = "Buffer.alloc"

@ocaml.doc("
 * `allocFillString(size, ~fill)`
 *
 * Allocates a new `Buffer` object with a length specified by `size`, and fills each element
 * with the value of `~fill`.
 ")
@val
external allocFillString: (int, ~fill: string) => t = "Buffer.alloc"

@ocaml.doc("
 * `allocFillStringWithEncoding(size, ~fill, encoding)`
 *
 * Allocates a new `Buffer` object with a length specified by `size`, fills each element
 * with the value of `~fill`, and sets the string encoding to `encoding`.
 ")
@val
external allocFillStringWithEncoding: (int, ~fill: string, StringEncoding.t) => t = "Buffer.alloc"

@ocaml.doc("
 * `allocFillBuffer(size, ~fill)
 *
 * Allocates a new `Buffer` object with a length specified by `size`, copying the data
 * from the `Buffer` object passed to the `~fill` parameter.
 ")
@val
external allocFillBuffer: (int, ~fill: t) => t = "Buffer.alloc"
@val external allocUnsafe: int => t = "Buffer.allocUnsafe"
@val external allocUnsafeSlow: int => t = "Buffer.allocUnsafeSlow"

@get_index external unsafeGet: (t, int) => int = ""
@set_index external unsafeSet: (t, int, int) => unit = ""

@val external byteLengthString: string => int = "Buffer.byteLength"
@val
external byteLengthStringWithEncoding: (string, StringEncoding.t) => int = "Buffer.byteLength"
@val external byteLengthBuffer: t => int = "Buffer.byteLength"
@val
external byteLengthInt8Array: Int8Array.t => int = "Buffer.byteLength"
@val
external byteLengthUint8Array: Uint8Array.t => int = "Buffer.byteLength"
@val
external byteLengthInt16Array: Int16Array.t => int = "Buffer.byteLength"
@val
external byteLengthUint16Array: Uint16Array.t => int = "Buffer.byteLength"
@val
external byteLengthInt32Array: Int32Array.t => int = "Buffer.byteLength"
@val
external byteLengthUint32Array: Uint32Array.t => int = "Buffer.byteLength"
@val
external byteLengthFloat32Array: Float32Array.t => int = "Buffer.byteLength"
@val
external byteLengthFloat64Array: Float64Array.t => int = "Buffer.byteLength"
@val external byteLengthDataView: DataView.t => int = "Buffer.byteLength"
@val
external byteLengthArrayBuffer: ArrayBuffer.t => int = "Buffer.byteLength"

@val external compare: (t, t) => int = "Buffer.compare"

@val external concat: array<t> => t = "Buffer.concat"
@val
external concatLength: (array<t>, ~length: int) => t = "Buffer.concat"

@val external isEncoding: string => bool = "Buffer.isEncoding"

type bufferClass

@val external bufferClass: bufferClass = "Buffer"
@val external poolSize: int = "Buffer.poolSize"
@set external setPoolSize: (bufferClass, int) => int = "poolSize"

@send external copy: (t, t) => int = "copy"
@send external copyOffset: (t, t, ~offset: int) => int = "copy"
@send
external copyOffsetFromOffset: (t, t, ~targetStart: int, ~sourceStart: int) => int = "copy"
@send
external copyOffsetFromRange: (t, t, ~targetStart: int, ~sourceStart: int, ~sourceEnd: int) => int =
  "copy"
@send external copyToUint8Array: (t, Uint8Array.t) => int = "copy"
@send
external copyToUint8ArrayOffset: (t, Uint8Array.t, ~targetStart: int) => int = "copy"
@send
external copyToUint8ArrayFrom: (t, Uint8Array.t, ~targetStart: int, ~sourceStart: int) => int =
  "copy"
@send
external copyToUint8ArrayFromRange: (
  t,
  Uint8Array.t,
  ~targetStart: int,
  ~sourceStart: int,
  ~sourceEnd: int,
) => int = "copy"

/* FIXME after iterators support */
/* external entries : t -> Iterator = "" [@@bs.get] */

@send external equals: (t, t) => bool = "equals"

@send external fillString: (t, string) => t = "fill"
@send external fillStringOffset: (t, string, ~offset: int) => t = "fill"
@send
external fillStringRange: (t, string, ~offset: int, ~end_: int) => t = "fill"
@send
external fillStringRangeWithEncoding: (t, string, ~offset: int, ~end_: int, StringEncoding.t) => t =
  "fill"
@send external fillBuffer: (t, t) => t = "fill"
@send external fillBufferOffset: (t, t, ~offset: int) => t = "fill"
@send
external fillBufferRange: (t, t, ~offset: int, ~end_: int) => t = "fill"
@send external fillInt: (t, int) => t = "fill"
@send external fillIntOffset: (t, int, ~offset: int) => t = "fill"
@send
external fillIntRange: (t, int, ~offset: int, ~end_: int) => t = "fill"

@send external includesString: (t, string) => bool = "includes"
@send
external includesStringFrom: (t, string, ~offset: int) => bool = "includes"
@send
external includesStringWithEncodingFrom: (t, string, ~offset: int, StringEncoding.t) => bool =
  "includes"
@send external includesBuffer: (t, t) => bool = "includes"
@send
external includesBufferFrom: (t, t, ~offset: int) => bool = "includes"
@send external includesInt: (t, int) => bool = "includes"
@send
external includesIntFrom: (t, int, ~offset: int) => bool = "includes"

@send external indexOfString: (t, string) => int = "indexOf"
@send
external indexOfStringFrom: (t, string, ~offset: int) => int = "indexOf"
@send
external indexOfStringWithEncodingFrom: (t, string, ~offset: int, StringEncoding.t) => int =
  "indexOf"
@send external indexOfBuffer: (t, t) => int = "indexOf"
@send external indexOfBufferFrom: (t, t, ~offset: int) => int = "indexOf"
@send external indexOfInt: (t, int) => int = "indexOf"
@send external indexOfIntFrom: (t, int, ~offset: int) => int = "indexOf"

/* FIXME after iterators support */
/* external keys : t -> Iterator = "" [@@bs.send] */

@send external lastIndexOfString: (t, string) => int = "lastIndexOf"
@send
external lastIndexOfStringFrom: (t, string, ~offset: int) => int = "lastIndexOf"
@send
external lastIndexOfStringWithEncodingFrom: (t, string, ~offset: int, StringEncoding.t) => int =
  "lastIndexOf"
@send external lastIndexOfBuffer: (t, t) => int = "lastIndexOf"
@send
external lastIndexOfBufferFrom: (t, t, ~offset: int) => int = "lastIndexOf"
@send external lastIndexOfInt: (t, int) => int = "lastIndexOf"
@send
external lastIndexOfIntFrom: (t, int, ~offset: int) => int = "lastIndexOf"

@get external length: t => int = "length"

@send external readDoubleBE: (t, ~offset: int) => float = "readDoubleBE"
@send external readDoubleLE: (t, ~offset: int) => float = "readDoubleLE"

@send external readFloatBE: (t, ~offset: int) => float = "readFloatBE"
@send external readFloatLE: (t, ~offset: int) => float = "readFloatLE"

@send external readInt8: (t, ~offset: int) => float = "readInt8"

@send external readInt16BE: (t, ~offset: int) => float = "readInt16BE"
@send external readInt16LE: (t, ~offset: int) => float = "readInt16LE"

@send external readInt32BE: (t, ~offset: int) => float = "readInt32BE"
@send external readInt32LE: (t, ~offset: int) => float = "readInt32LE"

@send external readIntBE: (t, ~offset: int) => float = "readIntBE"
@send
external readIntLE: (t, ~offset: int, ~length: int) => float = "readIntLE"

@send external readUint8: (t, ~offset: int) => float = "readUint8"

@send external readUint16BE: (t, ~offset: int) => float = "readUint16BE"
@send external readUint16LE: (t, ~offset: int) => float = "readUint16LE"

@send external readUint32BE: (t, ~offset: int) => float = "readUint32BE"
@send external readUint32LE: (t, ~offset: int) => float = "readUint32LE"

@send
external readUintBE: (t, ~offset: int, ~length: int) => float = "readUintBE"
@send
external readUintLE: (t, ~offset: int, ~length: int) => float = "readUintLE"

@send
external readBigInt64BE: (t, ~offset: int) => bigint = "readBigInt64BE"

@send
external readBigInt64LE: (t, ~offset: int) => bigint = "readBigInt64LE"

@send
external readBigUint64BE: (t, ~offset: int) => bigint = "readBigUInt64BE"

@send
external readBigUint64LE: (t, ~offset: int) => bigint = "readBigUInt64LE"

@send external slice: (t, ~start: int, ~end_: int) => t = "slice"
@send external sliceToEnd: (t, ~start: int) => t = "slice"

@send external subarray: (t, ~start: int, ~end_: int) => t = "subarray"
@send external subarrayToEnd: (t, ~start: int) => t = "subarray"

@send external swap16: t => t = "swap16"
@send external swap32: t => t = "swap32"
@send external swap64: t => t = "swap64"

@send external toJSON: t => Js.Json.t = "toJSON"

@send external toString: t => string = "toString"
@send
external toStringWithEncoding: (t, StringEncoding.t) => string = "toString"
@send
external toStringWithEncodingOffset: (t, StringEncoding.t, ~start: int) => string = "toString"
@send
external toStringWithEncodingRange: (t, StringEncoding.t, ~start: int, ~end_: int) => string =
  "toString"

@send external write: (t, string) => int = "write"
@send
external writeWithEncoding: (t, string, StringEncoding.t) => int = "write"
@send external writeOffset: (t, string, ~offset: int) => int = "write"
@send
external writeRange: (t, string, ~offset: int, ~length: int) => int = "write"
@send
external writeRangeWithEncoding: (t, string, ~offset: int, ~length: int, StringEncoding.t) => int =
  "write"

@send
external writeDoubleBE: (t, float, ~offset: int) => float = "writeDoubleBE"
@send
external writeDoubleLE: (t, float, ~offset: int) => float = "writeDoubleLE"
@send
external writeFloatBE: (t, float, ~offset: int) => float = "writeFloatBE"
@send
external writeFloatLE: (t, float, ~offset: int) => float = "writeFloatLE"
@send external writeInt8: (t, int, ~offset: int) => float = "writeInt8"
@send
external writeInt16BE: (t, int, ~offset: int) => float = "writeInt16BE"
@send
external writeInt16LE: (t, int, ~offset: int) => float = "writeInt16LE"
@send
external writeInt32BE: (t, int, ~offset: int) => float = "writeInt32BE"
@send
external writeInt32LE: (t, int, ~offset: int) => float = "writeInt32LE"
@send
external writeIntBE: (t, int, ~offset: int, ~length: int) => float = "writeIntBE"
@send
external writeIntLE: (t, int, ~offset: int, ~length: int) => float = "writeIntLE"
@send external writeUint8: (t, int, ~offset: int) => float = "writeUint8"
@send
external writeUint16BE: (t, int, ~offset: int) => float = "writeUint16BE"
@send
external writeUint16LE: (t, int, ~offset: int) => float = "writeUint16LE"
@send
external writeUint32BE: (t, int, ~offset: int) => float = "writeUint32BE"
@send
external writeUint32LE: (t, int, ~offset: int) => float = "writeUint32LE"
@send
external writeUintBE: (t, int, ~offset: int, ~length: int) => float = "writeUintBE"
@send
external writeUintLE: (t, int, ~offset: int, ~length: int) => float = "writeUintLE"

@get external _INSPECT_MAX_BYTES: t => int = "INSPECT_MAX_BYTES"
@get external kMaxLength: t => int = "kMaxLength"

@send
external transcode: (t, ~source: t, ~from: StringEncoding.t, ~to_: StringEncoding.t) => t =
  "transcode"

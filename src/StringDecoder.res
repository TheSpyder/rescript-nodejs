type t
@new @module("node:string_decoder")
external make: StringEncoding.t => t = "StringDecoder"
@send external end_: t => string = "end"
@send external writeEnd: (t, Buffer.t) => string = "end"
@send external write: (t, Buffer.t) => string = "write"

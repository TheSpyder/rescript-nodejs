module Impl: {
  type t = private string
  @inline("ascii")
  let ascii: t
  @inline("utf8")
  let utf8: t
  @inline("utf16le")
  let utf16le: t
  @inline("usc2")
  let usc2: t
  @inline("base64")
  let base64: t
  @inline("latin1")
  let latin1: t
  @inline("binary")
  let binary: t
  @inline("hex")
  let hex: t
} = {
  type t = string
  @inline("ascii")
  let ascii = "ascii"
  @inline("utf8")
  let utf8 = "utf8"
  @inline("utf16le")
  let utf16le = "utf16le"
  @inline("usc2")
  let usc2 = "usc2"
  @inline("base64")
  let base64 = "base64"
  @inline("latin1")
  let latin1 = "latin1"
  @inline("binary")
  let binary = "binary"
  @inline("hex")
  let hex = "hex"
}

include Impl

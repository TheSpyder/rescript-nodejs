type tty = [#Tty]

module ReadStream = {
  type kind<'r> = [Stream.readable<'r> | tty]
  type subtype<'r, 'ty> = Stream.subtype<[> kind<'r>] as 'ty>
  type supertype<'r, 'ty> = Stream.subtype<[< kind<'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t>>
  module Events = {
    include Stream.Readable.Events
  }
  module Impl = {
    include Stream.Readable.Impl
    @get external isRaw: t => bool = "isRaw"
    @get external isTTY: t => bool = "isTTY"
    @send external setRawMode: (t, bool) => t = "setRawMode"
    external unsafeCoerceToSocket: t => Net.Socket.t = "%identity"
    external unsafeCoerceFromSocket: Net.Socket.t => t = "%identity"
    external unsafeCoerceToReadable: t => Stream.Readable.t<Buffer.t> = "%identity"
    external unsafeCoerceFromReadable: Stream.Readable.t<Buffer.t> => t = "%identity"
  }
  include Events
  include Impl
}

module WriteStream = {
  type kind<'w> = [Stream.writable<'w> | tty]
  type subtype<'w, 'ty> = Stream.subtype<[> kind<'w>] as 'ty>
  type supertype<'w, 'ty> = Stream.subtype<[< kind<'w>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t>>
  module Events = {
    include Stream.Writable.Events
    @send
    external onResize: (subtype<'w, 'ty>, @as("resize") _, @uncurry (unit => unit)) => unit = "on"
    @send
    external offResize: (subtype<'w, 'ty>, @as("resize") _, @uncurry (unit => unit)) => unit = "off"
    @send
    external onResizeOnce: (subtype<'w, 'ty>, @as("resize") _, @uncurry (unit => unit)) => unit =
      "once"
  }

  module Impl = {
    include Stream.Writable.Impl
    @send
    external clearLineLeft: (t, @as(json`-1`) _, @uncurry (unit => unit), unit) => bool =
      "clearLine"
    @send
    external clearLineRight: (t, @as(json`1`) _, @uncurry (unit => unit), unit) => bool =
      "clearLine"
    @send
    external clearLine: (t, @as(json`0`) _, @uncurry (unit => unit), unit) => bool = "clearLine"
    @send
    external clearScreenDown: (t, @uncurry (unit => unit), unit) => bool = "clearScreenDown"
    @get external columns: t => int = "columns"
    @send external getColorDepth: t => int = "getColorDepth"
    @send
    external getColorDepthFromEnv: (t, Js.Dict.t<'ty>) => int = "getColorDepth"
    @send external getWindowSize: t => (int, int) = "getWindowSize"
    @send external hasColors: (t, int) => bool = "hasColors"
    @send
    external hasColorsFromEnv: (t, int, Js.Dict.t<'ty>) => bool = "hasColors"
    @send external hasAtLeast16Colors: t => bool = "hasColors"
    @send
    external moveCursor: (t, int, int, @uncurry (unit => unit)) => bool = "moveCursor"
    @get external rows: t => int = "rows"
    @get external isTTY: t => bool = "isTTY"
    external unsafeCoerceToSocket: t => Net.Socket.t = "%identity"
    external unsafeCoerceFromSocket: Net.Socket.t => t = "%identity"
    external unsafeCoerceToWritable: t => Stream.Writable.t<Buffer.t> = "%identity"
    external unsafeCoerceFromWritable: Stream.Writable.t<Buffer.t> => t = "%identity"
  }
  include Events
  include Impl
}

@module("tty") external isatty: Fs.fd => bool = "isatty"

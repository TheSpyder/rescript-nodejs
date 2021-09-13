type stream = [#Stream]
type objectMode = [stream | #ObjectMode]
type writable<'w> = [stream | #Writable('w)]
type readable<'r> = [stream | #Readable('r)]
type duplex<'w, 'r> = [writable<'w> | readable<'r>]
type transform<'w, 'r> = [duplex<'w, 'r> | #Transform]
type passThrough<'w, 'r> = [transform<'w, 'r> | #PassThrough]
type socket<'w, 'r> = [duplex<'w, 'r> | #Socket]
type tcpSocket<'w, 'r> = [socket<'w, 'r> | #Tcp]
type icpSocket<'w, 'r> = [socket<'w, 'r> | #Icp]
type fsWritable<'w> = [writable<'w> | #FileSystem]
type fsReadable<'r> = [readable<'r> | #FileSystem]

type kind = [stream]
type subtype<'ty> constraint 'ty = [> stream]
type t = subtype<stream>

type chunk<'a> = private {
  chunk: 'a,
  encoding: string,
}

module Common = {
  type kind = [stream]

  module Events = {
    @send
    external onError: (
      subtype<'ty> as 'stream,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => 'stream = "on"

    @send
    external onClose: (
      subtype<'ty> as 'stream,
      @as("close") _,
      @uncurry (unit => unit),
    ) => 'stream = "on"

    @send
    external offError: (
      subtype<'ty> as 'stream,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => 'stream = "off"

    @send
    external offClose: (
      subtype<'ty> as 'stream,
      @as("close") _,
      @uncurry (unit => unit),
    ) => 'stream = "off"

    @send
    external onCloseOnce: (
      subtype<'ty> as 'stream,
      @as("close") _,
      @uncurry (unit => unit),
    ) => 'stream = "once"

    @send
    external onErrorOnce: (
      subtype<'ty> as 'stream,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => 'stream = "once"

    @send
    external removeAllListeners: (subtype<'ty> as 'stream) => 'stream = "removeAllListeners"
  }

  module Impl = {
    include Events
    @send
    external destroy: (subtype<[> kind]> as 'stream) => 'stream = "destroy"
    @send
    external destroyWithError: (subtype<[> kind]> as 'stream, Js.Exn.t) => 'stream = "destroy"
    @get external destroyed: subtype<[> kind]> => bool = "destroyed"
  }
  include Impl
}

module Writable = {
  type kind<'w> = writable<'w>
  module Events = {
    @send
    external onDrain: (
      subtype<[> writable<'w>]> as 'ws,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => 'ws = "on"
    @send
    external onFinish: (
      subtype<[> writable<'w>]> as 'ws,
      @as("finish") _,
      @uncurry (unit => unit),
    ) => 'ws = "on"
    @send
    external onPipe: (
      subtype<[> writable<'w>]> as 'ws,
      @as("pipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "on"
    @send
    external onUnpipe: (
      subtype<[> writable<'w>]> as 'ws,
      @as("unpipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "on"
    @send
    external offDrain: (
      subtype<[> writable<'w>]> as 'ws,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => 'ws = "off"
    @send
    external offFinish: (
      subtype<[> writable<'w>]> as 'ws,
      @as("finish") _,
      @uncurry (unit => unit),
    ) => 'ws = "off"
    @send
    external offPipe: (
      subtype<[> writable<'w>]> as 'ws,
      @as("pipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "off"
    @send
    external offUnpipe: (
      subtype<[> writable<'w>]> as 'ws,
      @as("unpipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "off"
    @send
    external onDrainOnce: (
      subtype<[> writable<'w>]> as 'ws,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => 'ws = "once"
    @send
    external onFinishOnce: (
      subtype<[> writable<'w>]> as 'ws,
      @as("finish") _,
      @uncurry (unit => unit),
    ) => 'ws = "once"
    @send
    external onPipeOnce: (
      subtype<[> writable<'w>]> as 'ws,
      @as("pipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "once"
    @send
    external onUnpipeOnce: (
      subtype<[> writable<'w>]> as 'ws,
      @as("unpipe") _,
      @uncurry (subtype<[> readable<'r>]> => unit),
    ) => 'ws = "once"
  }
  module Impl = {
    include Common.Impl
    include Events
    @send external cork: subtype<[> writable<'w>]> => unit = "cork"
    @send external end_: subtype<[> writable<'w>]> => unit = "end"
    @send external uncork: subtype<[> writable<'w>]> => unit = "uncork"
    @send
    external write: (subtype<[> writable<'w>]>, 'w) => bool = "write"
    @send
    external writeWith: (
      subtype<[> writable<'w>]>,
      'w,
      ~callback: Js.Nullable.t<Js.Exn.t> => unit=?,
      unit,
    ) => bool = "write"
    @get
    external writable: subtype<[> writable<'w>]> => bool = "writable"
    @get
    external writableEnded: subtype<[> writable<'w>]> => bool = "writableEnded"
    @get
    external writableCorked: subtype<[> writable<'w>]> => bool = "writableCorked"
    @get
    external writableFinished: subtype<[> writable<'w>]> => bool = "writableFinished"
    @get
    external writableLength: subtype<[> writable<'w>]> => int = "writableLength"
    @get
    external writableHighWaterMark: subtype<[> writable<'w>]> => int = "writableHighWaterMark"
    @get
    external writableObjectMode: subtype<[> writable<'w>]> => bool = "writableObjectMode"
  }
  include Impl

  type t<'w> = subtype<writable<'w>>
  type objStream<'w> = subtype<[writable<'w> | objectMode]>
  type supertype<'w, 'ty> = subtype<[< writable<'w>] as 'ty>
  type subtype<'w, 'ty> = subtype<[> writable<'w>] as 'ty>

  type makeOptions<'w>
  @obj
  external makeOptions: (
    ~highWaterMark: int=?,
    ~objectMode: @as(json`false`) _,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      t<'w>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~final: @this (t<'w>, ~callback: (~error: option<Js.Exn.t>) => unit) => unit=?,
    ~writev: @this (
      t<'w>,
      ~data: array<chunk<'w>>,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~write: @this (
      t<'w>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    unit,
  ) => makeOptions<'w> = ""
  @module("stream") @new
  external make: makeOptions<Buffer.t> => t<Buffer.t> = "Writable"

  type makeOptionsObjMode<'w>
  @obj
  external makeOptionsObjMode: (
    ~highWaterMark: int=?,
    ~objectMode: @as(json`true`) _,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      objStream<'w>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~final: @this (objStream<'w>, ~callback: (~error: option<Js.Exn.t>) => unit) => unit=?,
    ~writev: @this (
      objStream<'w>,
      ~data: array<chunk<'w>>,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~write: @this (
      objStream<'w>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    unit,
  ) => makeOptionsObjMode<'w> = ""
  @module("stream") @new
  external makeObjMode: makeOptionsObjMode<'w> => objStream<'w> = "Writable"
}

module Readable = {
  type kind<'r> = [readable<'r>]
  module Events = {
    include Common.Events
    @send
    external onData: (
      subtype<[> readable<'r>]> as 'rs,
      @as("data") _,
      @uncurry ('r => unit),
    ) => 'rs = "on"
    @send
    external onEnd: (
      subtype<[> readable<'r>]> as 'rs,
      @as("end") _,
      @uncurry (unit => unit),
    ) => 'rs = "on"
    @send
    external onPause: (
      subtype<[> readable<'r>]> as 'rs,
      @as("pause") _,
      @uncurry (unit => unit),
    ) => 'rs = "on"
    @send
    external onReadable: (
      subtype<[> readable<'r>]> as 'rs,
      @as("readable") _,
      @uncurry (unit => unit),
    ) => 'rs = "on"
    @send
    external onResume: (
      subtype<[> readable<'r>]> as 'rs,
      @as("resume") _,
      @uncurry (unit => unit),
    ) => 'rs = "on"
    @send
    external offData: (
      subtype<[> readable<'r>]> as 'rs,
      @as("data") _,
      @uncurry ('r => unit),
    ) => 'rs = "off"
    @send
    external offEnd: (
      subtype<[> readable<'r>]> as 'rs,
      @as("end") _,
      @uncurry (unit => unit),
    ) => 'rs = "off"
    @send
    external offPause: (
      subtype<[> readable<'r>]> as 'rs,
      @as("pause") _,
      @uncurry (unit => unit),
    ) => 'rs = "off"
    @send
    external offReadable: (
      subtype<[> readable<'r>]> as 'rs,
      @as("readable") _,
      @uncurry (unit => unit),
    ) => 'rs = "off"
    @send
    external offResume: (
      subtype<[> readable<'r>]> as 'rs,
      @as("resume") _,
      @uncurry (unit => unit),
    ) => 'rs = "off"
    @send
    external onDataOnce: (
      subtype<[> readable<'r>]> as 'rs,
      @as("data") _,
      @uncurry ('r => unit),
    ) => 'rs = "once"
    @send
    external onEndOnce: (
      subtype<[> readable<'r>]> as 'rs,
      @as("end") _,
      @uncurry (unit => unit),
    ) => 'rs = "once"
    @send
    external onPauseOnce: (
      subtype<[> readable<'r>]> as 'rs,
      @as("pause") _,
      @uncurry (unit => unit),
    ) => 'rs = "once"
    @send
    external onReadableOnce: (
      subtype<[> readable<'r>]> as 'rs,
      @as("readable") _,
      @uncurry (unit => unit),
    ) => 'rs = "once"
    @send
    external onResumeOnce: (
      subtype<[> readable<'r>]> as 'rs,
      @as("resume") _,
      @uncurry (unit => unit),
    ) => 'rs = "once"
  }
  module Impl = {
    include Common.Impl
    include Events
    @send
    external isPaused: subtype<[> readable<'r>]> => bool = "isPaused"
    @send
    external pause: (subtype<[> readable<'r>]> as 'rs) => 'rs = "pause"
    @send
    external pipe: (subtype<[> readable<'r>]>, subtype<[> writable<'r>]> as 'ws) => 'ws = "pipe"
    @send
    external push: (subtype<[> readable<'r>]>, 'r) => unit = "push"
    @send external read: subtype<[> readable<'r>]> => unit = "read"
    @send
    external readSize: (subtype<[> readable<'r>]>, int) => unit = "read"
    @get
    external readable: subtype<[> readable<'r>]> => bool = "readable"
    @get
    external readableEncoding: subtype<[> readable<'r>]> => Js.nullable<string> = "readableEncoding"
    @get
    external readableEnded: subtype<[> readable<'r>]> => bool = "readableEnded"
    @get
    external readableFlowing: subtype<[> readable<'r>]> => bool = "readableFlowing"
    @get
    external readableHighWaterMark: subtype<[> readable<'r>]> => int = "readableHighWaterMark"
    @get
    external readableLength: subtype<[> readable<'r>]> => int = "readableLength"
    @get
    external readableObjectMode: subtype<[> readable<'r>]> => bool = "readableObjectMode"
    @send
    external resume: (subtype<[> readable<'r>]> as 'rs) => 'rs = "resume"
    @send
    external unpipe: (subtype<[> readable<'r>]>, subtype<[> writable<'r>]> as 'ws) => 'ws = "unpipe"
    @send
    external unshift: (subtype<[> readable<'r>]>, 'r) => unit = "unshift"
  }
  include Impl

  type t<'r> = subtype<readable<'r>>
  type objStream<'r> = subtype<[readable<'r> | objectMode]>
  type supertype<'r, 'ty> = subtype<[< readable<'r>] as 'ty>
  type subtype<'r, 'ty> = subtype<[> readable<'r>] as 'ty>

  type makeOptions<'r>
  @obj
  external makeOptions: (
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~objectMode: @as(json`false`) _,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      t<'r>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    ~read: @this (t<'r>, ~size: Js.nullable<int>) => unit,
    unit,
  ) => makeOptions<'r> = ""
  @module("stream") @new
  external make: makeOptions<Buffer.t> => t<Buffer.t> = "Readable"

  type makeOptionsObjMode<'r>
  @obj
  external makeOptionsObjMode: (
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~objectMode: @as(json`true`) _,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      objStream<'r>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    ~read: @this (objStream<'r>, ~size: Js.nullable<int>) => unit,
    unit,
  ) => makeOptionsObjMode<'r> = ""

  @module("stream") @new
  external makeObjMode: makeOptionsObjMode<'r> => objStream<'r> = "Readable"
}

module Duplex = {
  type kind<'w, 'r> = [duplex<'w, 'r>]
  module Events = {
    include Readable.Events
    include Writable.Events
  }
  module Impl = {
    include Readable.Impl
    include Writable.Impl
    include Events
  }
  include Impl

  type t<'w, 'r> = subtype<duplex<'w, 'r>>
  type supertype<'w, 'r, 'ty> = subtype<[< duplex<'w, 'r>] as 'ty>
  type subtype<'w, 'r, 'ty> = subtype<[> duplex<'w, 'r>] as 'ty>
  type objStream<'w, 'r> = subtype<'w, 'r, [duplex<'w, 'r> | objectMode]>

  type makeOptions<'w, 'r>
  @obj
  external makeOptions: (
    ~objectMode: @as(json`false`) _,
    ~allowHalfOpen: bool=?,
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      t<'w, 'r>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~final: @this (t<'w, 'r>, ~data: 'w, ~callback: (~error: option<Js.Exn.t>) => unit) => unit=?,
    ~writev: @this (
      t<'w, 'r>,
      ~data: array<chunk<'w>>,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~read: @this (t<'w, 'r>, ~size: Js.nullable<int>) => unit,
    ~write: @this (
      t<'w, 'r>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    unit,
  ) => makeOptions<'w, 'r> = ""

  @module("stream") @new
  external make: makeOptions<Buffer.t, Buffer.t> => t<Buffer.t, Buffer.t> = "Duplex"

  type makeOptionsObjMode<'w, 'r>
  @obj
  external makeOptionsObjMode: (
    ~objectMode: @as(json`true`) _,
    ~allowHalfOpen: bool=?,
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~destroy: @this (
      objStream<'w, 'r>,
      ~error: Js.nullable<Js.Exn.t>,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~final: @this (objStream<'w, 'r>, ~callback: (~error: option<Js.Exn.t>) => unit) => unit=?,
    ~writev: @this (
      objStream<'w, 'r>,
      ~data: array<chunk<'w>>,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit=?,
    ~read: @this (objStream<'w, 'r>, ~size: Js.nullable<int>) => unit,
    ~write: @this (
      objStream<'w, 'r>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>) => unit,
    ) => unit,
    unit,
  ) => makeOptionsObjMode<'w, 'r> = ""

  @module("stream") @new
  external makeObjMode: makeOptionsObjMode<'w, 'r> => t<'w, 'r> = "Duplex"
}

module Transform = {
  type kind<'w, 'r> = [transform<'w, 'r>]
  module Events = {
    include Duplex.Events
  }
  module Impl = {
    include Duplex.Impl
    include Events
  }
  include Impl
  type t<'w, 'r> = subtype<transform<'w, 'r>>
  type objStream<'w, 'r> = subtype<[transform<'w, 'r> | objectMode]>
  type supertype<'w, 'r, 'ty> = subtype<[< transform<'w, 'r>] as 'ty>
  type subtype<'w, 'r, 'ty> = subtype<[> transform<'w, 'r>] as 'ty>

  type makeOptions<'w, 'r>

  @obj
  external makeOptions: (
    ~objectMode: @as(json`false`) _,
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~transform: @this (
      t<'w, 'r>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>, ~data: option<'r>) => unit,
    ) => unit,
    ~flush: @this (
      t<'w, 'r>,
      ~callback: (~error: option<Js.Exn.t>, ~data: option<'r>) => unit,
    ) => unit,
    unit,
  ) => makeOptions<'w, 'r> = ""

  @module("stream") @new
  external make: makeOptions<Buffer.t, Buffer.t> => t<Buffer.t, Buffer.t> = "Transform"

  type makeOptionsObjMode<'w, 'r>
  @obj
  external makeOptionsObjMode: (
    ~objectMode: @as(json`true`) _,
    ~highWaterMark: int=?,
    ~emitClose: bool=?,
    ~autoDestroy: bool=?,
    ~transform: @this (
      objStream<'w, 'r>,
      ~data: 'w,
      ~encoding: StringEncoding.t,
      ~callback: (~error: option<Js.Exn.t>, ~data: option<'r>) => unit,
    ) => unit,
    ~flush: @this (
      objStream<'w, 'r>,
      ~callback: (~error: option<Js.Exn.t>, ~data: option<'r>) => unit,
    ) => unit,
    unit,
  ) => makeOptionsObjMode<'w, 'r> = ""

  @module("stream") @new
  external makeObjMode: makeOptionsObjMode<'w, 'r> => objStream<'w, 'r> = "Transform"
}

module PassThrough = {
  type kind<'w, 'r> = [passThrough<'w, 'r>]
  module Events = {
    include Transform.Events
  }
  module Impl = {
    include Transform.Impl
    include Events
  }
  include Impl
  type t<'w, 'r> = subtype<passThrough<'w, 'r>>
  type supertype<'w, 'r, 'ty> = subtype<[< passThrough<'w, 'r>] as 'ty>
  type subtype<'w, 'r, 'ty> = subtype<[> passThrough<'w, 'r>] as 'ty>
  @module("stream") @new
  external make: unit => t<Buffer.t, Buffer.t> = "PassThrough"
}

module Events = {
  include Common.Events
  include Readable.Events
  include Writable.Events
}
include Common.Impl
include Readable.Impl
include Writable.Impl
include Events

type cleanupFn = unit => unit

@module("stream")
external finished: (subtype<'ty>, Js.nullable<Js.Exn.t> => unit) => cleanupFn = "finished"

@module("stream")
external pipeline2: (
  subtype<[> readable<'t1>] as 'src>,
  subtype<[> writable<'t1>] as 'dest>,
  Js.nullable<Js.Exn.t> => unit,
) => subtype<[> writable<'t1>] as 'dest> = "pipeline"

@module("stream")
external pipeline3: (
  subtype<[> readable<'t1>] as 'src>,
  subtype<[> writable<'t1> | readable<'t2>] as 'kindA>,
  subtype<[> writable<'t2>] as 'dest>,
  Js.nullable<Js.Exn.t> => unit,
) => subtype<[> writable<'t2>] as 'dest> = "pipeline"
@module("stream")
external pipeline4: (
  subtype<[> readable<'t1>] as 'src>,
  subtype<[> writable<'t1> | readable<'t2>] as 'kindA>,
  subtype<[> writable<'t2> | readable<'t3>] as 'kindA>,
  subtype<[> writable<'t3>] as 'dest>,
  Js.nullable<Js.Exn.t> => unit,
) => subtype<[> writable<'t3>] as 'dest> = "pipeline"

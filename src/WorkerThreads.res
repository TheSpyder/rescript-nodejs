@ocaml.doc("
 * TODO:
 *
 * Not sure if the functor approach is the best way to use this module. But it
 * does allow us to \"lock in\" the data types we want to use across contexts.
 * There may be some other issues with this implementaiton due to a naive
 * understanding of how data is passed/shared.
 *
 * We should revisit this with concrete tests to determine the best design.
 ")
module MessagePort = {
  type t<'a>
  @send
  external onClose: (t<'a>, @as("close") _, @uncurry (unit => unit)) => t<'a> = "on"
  @send
  external onMessage: (t<'a>, @as("message") _, @uncurry ('a => unit)) => t<'a> = "on"
  @send external close: t<'a> => unit = "close"
  @send external postMessage: (t<'a>, 'a) => unit = "postMessage"
  @send external ref: t<'a> => unit = "ref"
  @send external start: t<'a> => unit = "start"
  @send external unref: t<'a> => unit = "unref"

  module WithMessageType = (
    T: {
      type message
    },
  ) => {
    type t = t<T.message>
    @send
    external onClose: (t, @as("close") _, @uncurry (unit => unit)) => t = "on"
    @send
    external onMessage: (t, @as("message") _, @uncurry (T.message => unit)) => t = "on"
    @send external close: t => unit = "close"
    @send external postMessage: (t, T.message) => unit = "postMessage"
    @send external ref: t => unit = "ref"
    @send external start: t => unit = "start"
    @send external unref: t => unit = "unref"
  }
}

module MessageChannel = {
  type t<'message1, 'message2>
  @module("worker_threads") @new
  external make: unit => t<'message1, 'message2> = "MessageChannel"
  @get
  external port1: t<'message1, 'message2> => MessagePort.t<'message1> = "port1"
  @get
  external port2: t<'message1, 'message2> => MessagePort.t<'message2> = "port2"

  module WithMessageTypes = (
    T: {
      type message1
      type message2
    },
  ) => {
    type t = t<T.message1, T.message2>
    @module("worker_threads") @new
    external make: unit => t = "MessageChannel"
    @get external port1: t => MessagePort.t<T.message1> = "port1"
    @get external port2: t => MessagePort.t<T.message2> = "port2"
  }
}

type workerResourceLimits = {
  @as("maxYoungGenerationSizeMb")
  maxYoungGenerationSizeMb: int,
  @as("maxOldGenerationSizeMb")
  maxOldGenerationSizeMb: int,
  @as("codeRangeSizeMb")
  codeRangeSizeMb: int,
}

module Worker = {
  type t<'a>

  type makeOptions<'a>
  @obj
  external makeOptions: (
    ~argv: array<string>=?,
    ~env: {..}=?,
    ~eval: bool=?,
    ~execArgv: array<string>=?,
    ~stdin: bool=?,
    ~stdout: bool=?,
    ~stderr: bool=?,
    ~workerData: 'a=?,
    ~resourceLimits: workerResourceLimits=?,
    unit,
  ) => makeOptions<'a> = ""

  @module("worker_threads") @new
  external make: (~file: string, ~options: makeOptions<'a>=?, unit) => t<'a> = "Worker"
  @send
  external onError: (t<'a>, @as("error") _, @uncurry (Js.Exn.t => unit)) => t<'a> = "on"
  @send
  external onMessage: (t<'a>, @as("message") _, @uncurry ('a => unit)) => t<'a> = "on"
  @send
  external onExit: (t<'a>, @as("exit") _, @uncurry (int => unit)) => t<'a> = "on"
  @send
  external onOnline: (t<'a>, @as("online") _, @uncurry (unit => unit)) => t<'a> = "on"
  @send external postMessage: (t<'a>, 'a) => unit = "postMessage"
  @send external ref: t<'a> => unit = "ref"
  @send
  external resourceLimits: t<'a> => workerResourceLimits = "workerResourceLimits"
  @get external stderr: t<'a> => Stream.Readable.t<'a> = "stderr"
  @get
  external stdin: t<'a> => Js.nullable<Stream.Writable.t<'a>> = "stdin"
  @get external stdout: t<'a> => Stream.Readable.t<'a> = "stdout"
  @send external terminate: t<'a> => Js.Promise.t<int> = "terminate"
  @get external threadId: t<'a> => int = "threadId"
  @send external unref: t<'a> => unit = "unref"

  module WithMessageType = (
    T: {
      type message
    },
  ) => {
    type t = t<T.message>

    type makeOptions = makeOptions<T.message>
    @obj
    external makeOptions: (
      ~argv: array<string>=?,
      ~env: {..}=?,
      ~eval: bool=?,
      ~execArgv: array<string>=?,
      ~stdin: bool=?,
      ~stdout: bool=?,
      ~stderr: bool=?,
      ~workerData: T.message=?,
      ~resourceLimits: workerResourceLimits=?,
      unit,
    ) => makeOptions = ""

    @module("worker_threads") @new
    external make: (~file: string, ~options: makeOptions=?, unit) => t = "Worker"
    @send
    external onError: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "on"
    @send
    external onMessage: (t, @as("message") _, @uncurry (T.message => unit)) => t = "on"
    @send
    external onExit: (t, @as("exit") _, @uncurry (int => unit)) => t = "on"
    @send
    external onOnline: (t, @as("online") _, @uncurry (unit => unit)) => t = "on"
    @send external postMessage: (t, T.message) => unit = "postMessage"
    @send external ref: t => unit = "ref"
    @send
    external resourceLimits: t => workerResourceLimits = "workerResourceLimits"
    @get external stderr: t => Stream.Readable.t<'a> = "stderr"
    @get
    external stdin: t => Js.nullable<Stream.Writable.t<'a>> = "stdin"
    @get external stdout: t => Stream.Readable.t<'a> = "stdout"
    @send external terminate: t => Js.Promise.t<int> = "terminate"
    @get external threadId: t => int = "threadId"
    @send external unref: t => unit = "unref"
  }
}

@val @module("worker_threads")
external isMainThread: bool = "isMainThread"
@val @module("worker_threads")
external moveMessagePortToContext: (
  MessagePort.t<'a>,
  VM.contextifiedObject<'b>,
) => MessagePort.t<'a> = "moveMessagePortToContext"
@val @module("worker_threads") @return(nullable)
external parentPort: option<MessagePort.t<'a>> = "parentPort"
@val @module("worker_threads") @return(nullable)
external receiveMessageOnPort: MessagePort.t<'a> => option<{..}> = "receiveMessageOnPort"
@val @module("worker_threads")
external resourceLimits: workerResourceLimits = "resourceLimits"
@val @module("worker_threads")
external _SHARE_ENV: Js.Types.symbol = "SHARE_ENV"
@val @module("worker_threads") external threadId: int = "threadId"
@val @module("worker_threads") external workerData: 'a = "workerData"

module WithMessageType = (
  T: {
    type message
  },
) => {
  module Worker = Worker.WithMessageType({
    type message = T.message
  })
  @val @module("worker_threads")
  external isMainThread: bool = "isMainThread"
  @val @module("worker_threads")
  external moveMessagePortToContext: (
    MessagePort.t<T.message>,
    VM.contextifiedObject<'b>,
  ) => MessagePort.t<T.message> = "moveMessagePortToContext"
  @val @module("worker_threads") @return(nullable)
  external parentPort: option<MessagePort.t<T.message>> = "parentPort"
  @val @module("worker_threads") @return(nullable)
  external receiveMessageOnPort: MessagePort.t<T.message> => option<{..}> = "receiveMessageOnPort"
  @val @module("worker_threads")
  external resourceLimits: workerResourceLimits = "resourceLimits"
  @val @module("worker_threads")
  external _SHARE_ENV: Js.Types.symbol = "SHARE_ENV"
  @val @module("worker_threads") external threadId: int = "threadId"
  @val @module("worker_threads")
  external workerData: T.message = "workerData"
}

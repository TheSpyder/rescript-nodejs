type settingsObject = {
  headerTableSize?: int,
  enablePush?: bool,
  initialWindowSize?: int,
  maxFrameSize?: int,
  maxConcurrentStreams?: int,
  maxHeaderListSize?: int,
  enableConnectProtocol?: bool,
}

module Http2Stream = {
  type kind<'w, 'r> = [Stream.duplex<'w, 'r> | #Http2Stream]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t<'w, 'r> = Stream.subtype<kind<'w, 'r>>
  module Events = {
    include Stream.Duplex.Events
  }
  module Impl = {
    include Stream.Duplex.Impl
    @get external aborted: subtype<'w, 'r, 'ty> => bool = "aborted"
    @get external bufferSize: subtype<'w, 'r, 'ty> => int = "bufferSize"
    @get external closed: subtype<'w, 'r, 'ty> => bool = "closed"
    @get external destroyed: subtype<'w, 'r, 'ty> => bool = "destroyed"
    @get
    external endAfterHeaders: subtype<'w, 'r, 'ty> => bool = "endAfterHeaders"
    @get @return(nullable)
    external id: subtype<'w, 'r, 'ty> => option<int> = "id"
    @get external pending: subtype<'w, 'r, 'ty> => bool = "pending"
    @get external rstCode: subtype<'w, 'r, 'ty> => int = "rstCode"
    @get
    external sentHeaders: subtype<'w, 'r, 'ty> => bool = "sentHeaders"
  }
  include Impl
}

module ClientHttp2Stream = {
  type kind<'w, 'r> = [Http2Stream.kind<'w, 'r> | #ClientHttp2Stream]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t<'w, 'r> = Stream.subtype<kind<'w, 'r>>
  module Events = {
    include Http2Stream.Events
  }
  module Impl = {
    include Http2Stream.Impl
  }
  include Impl
}

module ServerHttp2Stream = {
  type kind<'w, 'r> = [Http2Stream.kind<'w, 'r> | #ServerHttp2Stream]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Events = {
    include Http2Stream.Events
  }
  module Impl = {
    include Http2Stream.Impl
  }
  include Impl
}

module Http2Session = {
  type t
  @send
  external onClose: (t, @as("close") _, @uncurry unit => unit) => t = "on"
  @send
  external onConnect: (t, @as("connect") _, @uncurry (t, Net.Socket.t) => unit) => t = "on"
  @send
  external onError: (t, @as("error") _, @uncurry Js.Exn.t => unit) => t = "on"
  @send
  external onFrameError: (
    t,
    @as("frameError") _,
    (@uncurry ~type_: int, ~errorCode: int, ~streamId: int) => unit,
  ) => t = "on"
  @send
  external onGoAway: (
    t,
    @as("goAway") _,
    (@uncurry ~errorCode: int, ~lastStreamId: int, Buffer.t) => unit,
  ) => t = "on"
  @send
  external onLocalSettings: (t, @as("localSettings") _, @uncurry settingsObject => unit) => t = "on"
  @send
  external onPing: (t, @as("ping") _, @uncurry Buffer.t => unit) => t = "on"
  @send
  external onRemoteSettings: (t, @as("remoteSettings") _, @uncurry settingsObject => unit) => t =
    "on"
  @send
  external onStream: (
    t,
    @as("stream") _,
    @uncurry (t, {.."status": string, "content-type": string}, int, array<{..}>) => unit,
  ) => t = "on"
  @send
  external onTimeout: (t, @as("timeout") _, @uncurry unit => unit) => t = "on"
  @get @return(nullable)
  external alpnProtocol: t => option<string> = "alpnProtocol"
  @send external close: t => unit = "close"
  @get external closed: t => bool = "closed"
  @send external destroy: t => unit = "destroy"
  @send external destroyWithError: (t, Js.Exn.t) => unit = "destroy"
  @send external destroyWithCode: (t, int) => unit = "destroy"
  @get external destroyed: t => bool = "destroyed"
  @get @return(nullable)
  external encrypted: t => option<bool> = "encrypted"
  @send external goaway: t => unit = "goaway"
  @send
  external goawayWith: (t, ~code: int=?, ~lastStreamId: int=?, ~data: Buffer.t=?, unit) => unit =
    "goaway"
  @get
  external localSettings: t => {
    "headerTableSize": int,
    "enablePush": bool,
    "initialWindowSize": int,
    "maxFrameSize": int,
    "maxConcurrentStreams": int,
    "maxHeaderListSize": int,
    "enableConnectProtocol": bool,
  } = "on"
  @get @return(nullable)
  external originSet: t => option<array<string>> = "originSet"
  @get external pendingSettingsAck: t => bool = "pendingSettingsAck"
  @send
  external ping: (t, (Js.Nullable.t<Js.Exn.t>, int, Buffer.t) => unit) => bool = "ping"
  @send
  external pingWith: (
    t,
    ~payload: Buffer.t,
    (Js.Nullable.t<Js.Exn.t>, int, Buffer.t) => unit,
  ) => bool = "ping"
  @send external ref: t => unit = "ref"
  @get
  external remoteSettings: t => {
    "headerTableSize": int,
    "enablePush": bool,
    "initialWindowSize": int,
    "maxFrameSize": int,
    "maxConcurrentStreams": int,
    "maxHeaderListSize": int,
    "enableConnectProtocol": bool,
  } = "remoteSettings"
  @send
  external setTimeout: (t, int, unit => unit) => unit = "setTimeout"
  @get external socket: t => Net.TcpSocket.t = "socket"
  @get
  external state: t => {
    "effectiveLocalWindowSize": int,
    "effectiveRecvDataLength": int,
    "nextStreamID": int,
    "localWindowSize": int,
    "lastProcStreamID": int,
    "remoteWindowSize": int,
    "deflateDynamicTableSize": int,
    "inflateDynamicTableSize": int,
  } = "state"
  @send
  external settings: (
    t,
    settingsObject,
    ~callback: (Js.Null.t<Js.Exn.t>, settingsObject, int) => unit=?,
  ) => unit = "settings"
  @get external type_: t => int = "type"
}

module ServerHttp2Session = {
  include Http2Session

  module Origin = {
    type t<'a>
    type urlString = [#UrlString]
    type url = [#Url]
    type object_ = [#Object]
    type streamId = [#StreamId]
    external urlString: string => t<urlString> = "%identity"
    external url: Url.t => t<url> = "%identity"
    external object_: {"origin": string} => t<object_> = "%identity"
    external streamId: int => t<streamId> = "%identity"
  }

  @send
  external altsvc: (
    t,
    string,
    Origin.t<[Origin.urlString | Origin.url | Origin.object_ | Origin.streamId]>,
  ) => unit = "altsvc"

  @send @variadic
  external origin: array<Origin.t<[Origin.urlString | Origin.url | Origin.object_]>> => unit =
    "origin"
}

module Http2ServerRequest = {
  type kind<'r> = [Stream.readable<'r> | #Http2ServerRequest]
  type subtype<'r, 'ty> = Stream.subtype<[> kind<'r>] as 'ty>
  type supertype<'r, 'ty> = Stream.subtype<[< kind<'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t>>
  module Impl = {
    include Stream.Readable.Impl
    @send
    external onAborted: (
      subtype<'r, 'ty>,
      @as("aborted") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'ty> = "on"
    @send
    external onClose: (
      subtype<'r, 'ty>,
      @as("close") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'ty> = "on"
    @get external aborted: subtype<'r, 'ty> => bool = "aborted"
    @get external authority: subtype<'r, 'ty> => string = "authority"
    @get external complete: subtype<'r, 'ty> => bool = "complete"
    @send external destroy: subtype<'r, 'ty> => unit = "destroy"
    @send
    external destroyWithError: (subtype<'r, 'ty>, Js.Exn.t) => unit = "destroy"
    @get external headers: subtype<'r, 'ty> => {..} = "headers"
    @get
    external httpVersion: subtype<'r, 'ty> => string = "httpVersion"
    @get external method__: subtype<'r, 'ty> => string = "method"
    @get
    external rawHeaders: subtype<'r, 'ty> => array<string> = "rawHeaders"
    @get
    external rawTrailers: subtype<'r, 'ty> => array<string> = "rawTrailers"
    @get external scheme: subtype<'r, 'ty> => string = "scheme"
    @send
    external setTimeout: (subtype<'r, 'ty>, int, unit => unit) => subtype<'r, 'ty> = "setTimeout"
    @get
    external socket: t => Stream.subtype<[< Net.Socket.kind<'w, 'r> | Tls.TlsSocket.kind<'w, 'r>]> =
      "socket"
    @get external stream: t => Stream.t = "stream"
    @get external trailers: t => {..} = "trailers"
    @get external url: t => string = "url"
  }
  include Impl
}

module Http2ServerResponse = {
  type kind = [Stream.stream | #Http2ServerResponse]
  type subtype<'ty> = Stream.subtype<[> kind] as 'ty>
  type supertype<'ty> = Stream.subtype<[< kind] as 'ty>
  type t = Stream.subtype<kind>
  module Impl = {
    include Stream.Duplex.Impl
    @send
    external onClose: (subtype<'ty>, @as("close") _, @uncurry unit => unit) => subtype<'ty> = "on"
    @send
    external onFinish: (subtype<'ty>, @as("finish") _, @uncurry unit => unit) => subtype<'ty> = "on"
    @send
    external setTrailers: (subtype<'ty>, {..}) => unit = "setTrailers"
    @send external end_: subtype<'ty> => unit = "end"
    @send
    external endWith: (subtype<'ty>, ~data: Buffer.t=?, ~callback: unit => unit=?) => subtype<'ty> =
      "end"
    @send
    external getHeader: (subtype<'ty>, string) => string = "getHeader"
    @send
    external getHeaderNames: subtype<'ty> => array<string> = "getHeaderNames"
    @send
    external getHeaders: subtype<'ty> => {..} = "getHeaders"
    @send
    external hasHeader: (subtype<'ty>, string) => bool = "hasHeader"
    @send external headersSent: subtype<'ty> => bool = "headersSent"
    @send
    external removeHeader: (subtype<'ty>, string) => unit = "removeHeader"
    @send
    external setHeader: (subtype<'ty>, string) => unit = "setHeader"
    @send
    external setHeaderArray: (subtype<'ty>, array<string>) => unit = "setHeader"
    @send
    external setTimeout: (subtype<'ty>, int, unit => unit) => Http2Stream.t<'w, 'r> = "setTimeout"
    @get external socket: subtype<'ty> => Net.TcpSocket.t = "socket"
    @get external statusCode: subtype<'ty> => int = "statusCode"
    @get
    external statusMessage: subtype<'ty> => string = "statusMessage"
    @get
    external stream: subtype<'ty> => Http2Stream.t<'w, 'r> = "stream"
    @get external writableEnded: subtype<'ty> => bool = "writableEnded"
    @send external write: (subtype<'ty>, Buffer.t) => bool = "write"
    @send
    external writeWith: (subtype<'ty>, Buffer.t, ~callback: unit => unit=?) => bool = "write"
    @send external writeContinue: subtype<'ty> => unit = "writeContinue"
    @send
    external writeHead: (subtype<'ty>, int) => subtype<'ty> = "writeHead"
    @send
    external writeHeadWith: (
      subtype<'ty>,
      int,
      ~message: string=?,
      ~headers: {..}=?,
    ) => subtype<'ty> = "writeHead"
    @send
    external createPushResponse: (
      subtype<'ty>,
      {..},
      @uncurry (Js.Exn.t, ServerHttp2Stream.t) => unit,
    ) => unit = "writeHead"
  }
  include Impl
}

type http = [#Http]

type headersObject = {
  accept: option<string>,
  @as("accept-language")
  acceptLanguage: option<string>,
  @as("accept-patch")
  acceptPatch: option<string>,
  @as("accept-ranges")
  acceptRanges: option<string>,
  @as("access-control-allow-credentials")
  accessControlAllowCredentials: option<string>,
  @as("access-control-allow-headers")
  accessControlAllowHeaders: option<string>,
  @as("access-control-allow-methods")
  accessControlAllowMethods: string,
  @as("access-control-allow-origin")
  accessControlAllowOrigin: option<string>,
  @as("access-control-expose-headers")
  accessControlExposeHeaders: option<string>,
  @as("access-control-max-age")
  accessControlMaxAge: option<string>,
  age: option<string>,
  allow: option<string>,
  @as("alt-svc")
  altSvc: option<string>,
  authorization: option<string>,
  @as("cache-control")
  cacheControl: option<string>,
  connection: option<string>,
  @as("content-disposition")
  contentDisposition: option<string>,
  @as("content-encoding")
  contentEncoding: option<string>,
  @as("content-language")
  contentLanguage: option<string>,
  @as("content-length")
  contentLenth: option<string>,
  @as("content-location")
  contentLocation: option<string>,
  @as("content-range")
  contentRange: option<string>,
  @as("content-type")
  contentType: option<string>,
  cookie: option<string>,
  date: option<string>,
  expect: option<string>,
  expires: option<string>,
  forwarded: option<string>,
  from: option<string>,
  host: option<string>,
  @as("if-match")
  ifMatch: option<string>,
  @as("if-modified-since")
  ifModifiedSince: option<string>,
  @as("if-none-match")
  ifNoneMatch: option<string>,
  @as("if-unmodified-since")
  ifUnmodifiedSince: option<string>,
  @as("last-modified")
  lastModified: option<string>,
  location: option<string>,
  pragma: option<string>,
  @as("proxy-authenticate")
  proxyAuthenticate: option<string>,
  @as("proxy-authorization")
  proxyAuthorization: option<string>,
  @as("public-key-pins")
  publicKeyPins: option<string>,
  range: option<string>,
  referer: option<string>,
  @as("retry-after")
  retryAfter: option<string>,
  @as("set-cookie")
  setCookie: option<array<string>>,
  @as("strict-transport-security")
  strictTransportPolicy: option<string>,
  tk: option<string>,
  trailer: option<string>,
  @as("transfer-encoding")
  transferEncoding: option<string>,
  upgrade: option<string>,
  @as("user-agent")
  userAgent: option<string>,
  vary: option<string>,
  via: option<string>,
  warning: option<string>,
  @as("www-authenticate")
  wwwAuthenticate: option<string>,
}

module IncomingMessage = {
  type kind<'r> = [Stream.readable<'r> | #IncomingMessage]
  type subtype<'r, 'a> = Stream.subtype<[> kind<'r>] as 'a>
  type supertype<'r, 'a> = Stream.subtype<[< kind<'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t>>
  module Events = {
    include Stream.Readable.Events
    @send
    external onAborted: (
      subtype<'r, 'a>,
      @as("aborted") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'a> = "on"
    @send
    external onClose: (subtype<'r, 'a>, @as("close") _, @uncurry unit => unit) => subtype<'r, 'a> =
      "on"
    @send
    external offAborted: (
      subtype<'r, 'a>,
      @as("aborted") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'a> = "off"
    @send
    external offClose: (subtype<'r, 'a>, @as("close") _, @uncurry unit => unit) => subtype<'r, 'a> =
      "off"
    @send
    external onAbortedOnce: (
      subtype<'r, 'a>,
      @as("aborted") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'a> = "once"
    @send
    external onCloseOnce: (
      subtype<'r, 'a>,
      @as("close") _,
      @uncurry unit => unit,
    ) => subtype<'r, 'a> = "once"
  }

  module Impl = {
    include Stream.Readable.Impl
    include Events
    @get external method__: subtype<'r, 'a> => string = "method"
    @get external url: subtype<'r, 'a> => string = "url"
    @get external port: subtype<'r, 'a> => int = "port"
    @get external headers: subtype<'r, 'a> => headersObject = "headers"
    @get
    external rawHeaders: subtype<'r, 'a> => array<string> = "rawHeaders"
    @get
    external rawTrailers: subtype<'r, 'a> => array<string> = "rawTrailers"
    @get
    external connection: subtype<'r, 'a> => Net.TcpSocket.t = "connection"
    @get external aborted: subtype<'r, 'a> => bool = "aborted"
    @get external complete: subtype<'r, 'a> => bool = "complete"
    @send external destroy: subtype<'r, 'a> => unit = "destroy"
    @send
    external destroyWithError: (subtype<'r, 'a>, Js.Exn.t) => bool = "destroy"
    @send
    external setTimeout: (subtype<'r, 'a>, int) => subtype<'r, 'a> = "setTimeout"
    @send
    external setTimeoutWithCallback: (
      subtype<'r, 'a>,
      int,
      subtype<'r, 'a> => unit,
    ) => subtype<'r, 'a> = "setTimeout"
    @get external socket: subtype<'r, 'a> => Net.TcpSocket.t = "socket"
    @get external statusCode: subtype<'r, 'a> => int = "statusCode"
    @get
    external statusMessage: subtype<'r, 'a> => string = "statusMessage"
    @get
    external trailers: subtype<'r, 'a> => Js.Dict.t<string> = "trailers"
  }
  include Impl
}

module ClientRequest = {
  type kind<'w, 'r> = [Stream.duplex<'w, 'r> | #ClientRequest]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  type information = {
    httpVersion: string,
    httpVersionMajor: int,
    httpVersionMinor: int,
    statusCode: int,
    statusMessage: string,
    headers: headersObject,
    rawHeaders: array<string>,
  }
  module Events = {
    include Stream.Duplex.Events
    @send
    external onAbort: (
      subtype<'w, 'r, 'a>,
      @as("abort") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onConnect: (
      subtype<'w, 'r, 'a>,
      @as("connect") _,
      (IncomingMessage.t, Net.TcpSocket.t, Buffer.t) => unit,
    ) => unit = "on"
    @send
    external onContinue: (
      subtype<'w, 'r, 'a>,
      @as("continue") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onInformation: (
      subtype<'w, 'r, 'a>,
      @as("information") _,
      @uncurry information => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onResponse: (
      subtype<'w, 'r, 'a>,
      @as("response") _,
      @uncurry IncomingMessage.t => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onSocket: (
      subtype<'w, 'r, 'a>,
      @as("socket") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onTimeout: (
      subtype<'w, 'r, 'a>,
      @as("timeout") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onUpgrade: (
      subtype<'w, 'r, 'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Buffer.t) => unit,
    ) => subtype<'w, 'r, 'a> = "on"

    @send
    external offAbort: (
      subtype<'w, 'r, 'a>,
      @as("abort") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offConnect: (
      subtype<'w, 'r, 'a>,
      @as("connect") _,
      (IncomingMessage.t, Net.TcpSocket.t, Buffer.t) => unit,
    ) => unit = "off"
    @send
    external offContinue: (
      subtype<'w, 'r, 'a>,
      @as("continue") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offInformation: (
      subtype<'w, 'r, 'a>,
      @as("information") _,
      @uncurry information => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offResponse: (
      subtype<'w, 'r, 'a>,
      @as("response") _,
      @uncurry IncomingMessage.t => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offSocket: (
      subtype<'w, 'r, 'a>,
      @as("socket") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offTimeout: (
      subtype<'w, 'r, 'a>,
      @as("timeout") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offUpgrade: (
      subtype<'w, 'r, 'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Buffer.t) => unit,
    ) => subtype<'w, 'r, 'a> = "off"

    @send
    external onAbortOnce: (
      subtype<'w, 'r, 'a>,
      @as("abort") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onConnectOnce: (
      subtype<'w, 'r, 'a>,
      @as("connect") _,
      (IncomingMessage.t, Net.Socket.subtype<'w, 'r, 'c>, Buffer.t) => unit,
    ) => unit = "once"
    @send
    external onContinueOnce: (
      subtype<'w, 'r, 'a>,
      @as("continue") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onInformationOnce: (
      subtype<'w, 'r, 'a>,
      @as("information") _,
      @uncurry information => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onResponseOnce: (
      subtype<'w, 'r, 'a>,
      @as("response") _,
      @uncurry IncomingMessage.t => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onSocketOnce: (
      subtype<'w, 'r, 'a>,
      @as("socket") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onTimeoutOnce: (
      subtype<'w, 'r, 'a>,
      @as("timeout") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onUpgradeOnce: (
      subtype<'w, 'r, 'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Buffer.t) => unit,
    ) => subtype<'w, 'r, 'a> = "once"
  }
  module Impl = {
    include Stream.Duplex.Impl
    include Events
    @send external abort: subtype<'w, 'r, 'a> => unit = "abort"
    @get external aborted: subtype<'w, 'r, 'a> => bool = "aborted"
    @send external end_: subtype<'w, 'r, 'a> => unit = "end"
    @send
    external endWithData: (subtype<'w, 'r, 'a>, Buffer.t) => unit = "end"
    @send
    external endWithCallback: (subtype<'w, 'r, 'a>, unit => unit) => unit = "end"
    @send
    external endWithDataCallback: (subtype<'w, 'r, 'a>, Buffer.t, unit => unit) => unit = "end"
    @send
    external flushHeaders: subtype<'w, 'r, 'a> => unit = "flushHeaders"
    @send
    external getHeader: (subtype<'w, 'r, 'a>, string) => 'any = "getHeader"
    @send
    external maxHeadersCount: subtype<'w, 'r, 'a> => int = "maxHeadersCount"
    @send external path: subtype<'w, 'r, 'a> => string = "path"
    @send
    external reusedSocket: subtype<'w, 'r, 'a> => bool = "reusedSocket"
    @send
    external setHeader: (subtype<'w, 'r, 'a>, string, 'any) => unit = "setHeader"
    @send
    external setHeaderArray: (subtype<'w, 'r, 'a>, string, array<'any>) => unit = "setHeader"
    @send
    external setNoDelay: (subtype<'w, 'r, 'a>, bool) => unit = "setNoDelay"
    @send
    external setSocketKeepAlive: (subtype<'w, 'r, 'a>, bool) => unit = "setSocketKeepAlive"
    @send
    external setSocketKeepAliveWithDelay: (subtype<'w, 'r, 'a>, bool, int) => unit =
      "setSocketKeepAlive"
    @send
    external setTimeout: (subtype<'w, 'r, 'a>, int) => unit = "setTimeout"
    @send
    external setTimeoutWithCallback: (subtype<'w, 'r, 'a>, int, unit => unit) => unit = "setTimeout"
    @send
    external socket: subtype<'w, 'r, 'a> => Net.TcpSocket.t = "socket"
    @send
    external writableEnded: subtype<'w, 'r, 'a> => bool = "writableEnded"
    @send
    external write: (subtype<'w, 'r, 'a>, Buffer.t) => bool = "write"
    @send
    external writeWithCallback: (subtype<'w, 'r, 'a>, Buffer.t, unit => unit) => bool = "write"
  }

  include Impl
}

module ServerResponse = {
  type kind<'w, 'r> = [Stream.duplex<'w, 'r> | #ServerResponse]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Events = {
    include Stream.Duplex.Events
    @send
    external onClose: (
      subtype<'w, 'r, 'a>,
      @as("close") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external onFinish: (
      subtype<'w, 'r, 'a>,
      @as("finish") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "on"
    @send
    external offClose: (
      subtype<'w, 'r, 'a>,
      @as("close") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external offFinish: (
      subtype<'w, 'r, 'a>,
      @as("finish") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "off"
    @send
    external onCloseOnce: (
      subtype<'w, 'r, 'a>,
      @as("close") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "once"
    @send
    external onFinishOnce: (
      subtype<'w, 'r, 'a>,
      @as("finish") _,
      @uncurry unit => unit,
    ) => subtype<'w, 'r, 'a> = "once"
  }
  module Impl = {
    include Stream.Duplex.Impl
    include Events
    @get external statusCode: subtype<'w, 'r, 'a> => int = "statusCode"
    @set
    external setStatusCode: (subtype<'w, 'r, 'a>, int) => unit = "statusCode"
    @send
    external write: (subtype<'w, 'r, 'a>, Buffer.t) => bool = "write"
    @send
    external writeWithEncodingCallback: (subtype<'w, 'r, 'a>, Buffer.t, unit => unit) => bool =
      "write"
    @send
    external writeStatus: (subtype<'w, 'r, 'a>, int) => unit = "writeHead"
    @send external cork: subtype<'w, 'r, 'a> => unit = "cork"
    @send external end_: subtype<'w, 'r, 'a> => unit = "end"
    @send
    external endWithData: (subtype<'w, 'r, 'a>, Buffer.t) => unit = "end"
    @send
    external endWithCallback: (subtype<'w, 'r, 'a>, unit => unit) => unit = "end"
    @send
    external endWithDataCallback: (subtype<'w, 'r, 'a>, Buffer.t, unit => unit) => unit = "end"
    @send external uncork: subtype<'w, 'r, 'a> => unit = "uncork"
    @send
    external flushHeaders: subtype<'w, 'r, 'a> => unit = "flushHeaders"
    @send
    external getHeader: (subtype<'w, 'r, 'a>, string) => 'any = "getHeader"
    @send
    external getHeaderNames: subtype<'w, 'r, 'a> => array<string> = "getHeaderNames"
    @send
    external getHeaders: subtype<'w, 'r, 'a> => headersObject = "getHeaders"
    @send
    external hasHeader: (subtype<'w, 'r, 'a>, string) => bool = "hasHeader"
    @get
    external headersSent: subtype<'w, 'r, 'a> => bool = "headersSent"
    @send
    external removeHeader: (subtype<'w, 'r, 'a>, string) => unit = "removeHeader"
    @get external sendDate: subtype<'w, 'r, 'a> => bool = "sendDate"
    @send
    external setHeader: (subtype<'w, 'r, 'a>, string, 'any) => unit = "setHeader"
    @send
    external setHeaderArray: (subtype<'w, 'r, 'a>, string, array<'any>) => unit = "setHeader"
    @send
    external setTimeout: (subtype<'w, 'r, 'a>, int) => unit = "setTimeout"
    @send
    external setTimeoutWithCallback: (subtype<'w, 'r, 'a>, int, unit => unit) => unit = "setTimeout"
    @get
    external socket: subtype<'w, 'r, 'a> => Net.TcpSocket.t = "socket"
    @get
    external statusMessage: subtype<'w, 'r, 'a> => string = "statusMessage"
    @get
    external writableEnded: subtype<'w, 'r, 'a> => bool = "writableEnded"
    @get
    external writableFinished: subtype<'w, 'r, 'a> => bool = "writableFinished"
    @send
    external writeContinue: subtype<'w, 'r, 'a> => unit = "writeContinue"
    @send
    external writeHead: (subtype<'w, 'r, 'a>, int, {..}) => subtype<'w, 'r, 'a> = "writeHead"
    @send
    external writeHeadWithMessage: (subtype<'w, 'r, 'a>, int, string, {..}) => subtype<'w, 'r, 'a> =
      "writeHead"
    @send
    external writeProcessing: subtype<'w, 'r, 'a> => unit = "writeProcessing"
  }

  include Impl
}

module Agent = {
  type t
  @send
  external createConnection: (t, {..}) => Net.TcpSocket.t = "createConnection"
  @send
  external createConnectionWithCallback: (t, {..}, unit => unit) => Net.TcpSocket.t =
    "createConnection"
  @send
  external keepSocketAlive: (t, Net.TcpSocket.t) => unit = "keepSocketAlive"
  @send
  external reuseSocket: (t, Net.TcpSocket.t, ClientRequest.t) => unit = "reuseSocket"
  @send external destroy: t => unit = "destroy"
  @get external freeSockets: t => {..} = "freeSockets"
  @send external getName: (t, {..}) => string = "getName"
  @send external maxFreeSockets: t => int = "maxFreeSockets"
  @send external maxSockets: t => int = "maxSockets"
  @get external requests: t => {..} = "requests"
  @get external sockets: t => {..} = "sockets"
}

module Server = {
  type kind = [Net.TcpServer.kind | http]
  type subtype<'a> = Net.Server.subtype<[> kind] as 'a>
  type supertype<'a> = Net.Server.subtype<[< kind] as 'a>
  type t = subtype<kind>
  module Events = {
    include Net.TcpServer.Events
    @send
    external onCheckContinue: (
      subtype<'a>,
      @as("checkContinue") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "on"
    @send
    external onCheckExpectation: (
      subtype<'a>,
      @as("checkExpectation") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "on"
    @send
    external onClientError: (
      subtype<'a>,
      @as("clientError") _,
      @uncurry (Js.Exn.t, Net.TcpSocket.t) => unit,
    ) => subtype<'a> = "on"
    @send
    external onConnect: (
      subtype<'a>,
      @as("connect") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "on"
    @send
    external onRequest: (
      subtype<'a>,
      @as("request") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "on"
    @send
    external onUpgrade: (
      subtype<'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "on"
    @send
    external onTimeout: (
      subtype<'a>,
      @as("timeout") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'a> = "on"
    @send
    external offCheckContinue: (
      subtype<'a>,
      @as("checkContinue") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "off"
    @send
    external offCheckExpectation: (
      subtype<'a>,
      @as("checkExpectation") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "off"
    @send
    external offClientError: (
      subtype<'a>,
      @as("clientError") _,
      @uncurry (Js.Exn.t, Net.TcpSocket.t) => unit,
    ) => subtype<'a> = "off"
    @send
    external offConnect: (
      subtype<'a>,
      @as("connect") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "off"
    @send
    external offRequest: (
      subtype<'a>,
      @as("request") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "off"
    @send
    external offUpgrade: (
      subtype<'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "off"
    @send
    external offTimeout: (
      subtype<'a>,
      @as("timeout") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'a> = "off"
    @send
    external onCheckContinueOnce: (
      subtype<'a>,
      @as("checkContinue") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "once"
    @send
    external onCheckExpectationOnce: (
      subtype<'a>,
      @as("checkExpectation") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "once"
    @send
    external onClientErrorOnce: (
      subtype<'a>,
      @as("clientError") _,
      @uncurry (Js.Exn.t, Net.TcpSocket.t) => unit,
    ) => subtype<'a> = "once"
    @send
    external onConnectOnce: (
      subtype<'a>,
      @as("connect") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "once"
    @send
    external onRequestOnce: (
      subtype<'a>,
      @as("request") _,
      @uncurry (IncomingMessage.t, ServerResponse.t) => unit,
    ) => subtype<'a> = "once"
    @send
    external onUpgradeOnce: (
      subtype<'a>,
      @as("upgrade") _,
      @uncurry (IncomingMessage.t, Net.TcpSocket.t, Js.nullable<Buffer.t>) => unit,
    ) => subtype<'a> = "once"
    @send
    external onTimeoutOnce: (
      subtype<'a>,
      @as("timeout") _,
      @uncurry Net.TcpSocket.t => unit,
    ) => subtype<'a> = "once"
  }
  module Impl = {
    include Events
    @send
    external setTimeout: (subtype<'a>, int, @uncurry Net.Socket.t => unit) => unit = "setTimeout"
    @get external timeout: subtype<'a> => int = "timeout"
    @send
    external keepAliveTimeout: (subtype<'a>, int) => unit = "keepAliveTimeout"
    include Net.TcpServer.Impl
  }

  @send
  external listen: (t, ~port: int, ~host: string, ~callback: unit => unit=?, unit) => t = "listen"

  include Impl
}

type createServerOptions = {
  incomingMessage?: IncomingMessage.t,
  serverResponse?: ServerResponse.t,
  maxHeaderSize?: int,
}

@module("node:http")
external createServer: (@uncurry (IncomingMessage.t, ServerResponse.t) => unit) => Server.t =
  "createServer"

@module("node:http")
external createServerWithOptions: (
  createServerOptions,
  (IncomingMessage.t, ServerResponse.t) => unit,
) => Server.t = "createServer"

@module("node:http") external _METHODS: array<string> = "METHODS"
@module("node:http")
external _STATUS_CODES: Js.Dict.t<string> = "STATUS_CODES"

type requestOptions = {
  agent?: Agent.t,
  auth?: string,
  createConnection?: unit => Net.TcpSocket.t,
  defaultPort?: int,
  family?: int,
  headers?: headersObject,
  host?: string,
  hostName?: string,
  localAddress?: string,
  lookup?: (string, Dns.options, (Js.Exn.t, string, int) => unit) => string,
  maxHeaderSize?: int,
  method?: string,
  path?: string,
  port?: int,
  protocol?: string,
  setHost?: bool,
  socketPath?: string,
  timeout?: int,
}

@module("node:http") external request: string => ClientRequest.t = "request"
@module("node:http")
external requestWithCallback: (string, IncomingMessage.t => unit) => ClientRequest.t = "request"
@module("node:http")
external requestWithOptions: (string, requestOptions) => ClientRequest.t = "request"
@module("node:http")
external requestWithOptionsCallback: (
  string,
  requestOptions,
  IncomingMessage.t => unit,
) => ClientRequest.t = "request"
@module("node:http") external requestUrl: Url.t => ClientRequest.t = "request"
@module("node:http")
external requestUrlWithCallback: (Url.t, IncomingMessage.t => unit) => ClientRequest.t = "request"
@module("node:http")
external requestUrlWithOptions: (Url.t, requestOptions) => ClientRequest.t = "request"
@module("node:http")
external requestUrlWithOptionsCallback: (
  Url.t,
  requestOptions,
  IncomingMessage.t => unit,
) => ClientRequest.t = "request"

@module("node:http") external get: string => ClientRequest.t = "get"
@module("node:http")
external getWithCallback: (string, IncomingMessage.t => unit) => ClientRequest.t = "get"
@module("node:http")
external getWithOptions: (string, requestOptions) => ClientRequest.t = "get"
@module("node:http")
external getWithOptionsCallback: (
  string,
  requestOptions,
  IncomingMessage.t => unit,
) => ClientRequest.t = "get"

@module("node:http") external getUrl: Url.t => ClientRequest.t = "get"
@module("node:http")
external getUrlWithCallback: (Url.t, IncomingMessage.t => unit) => ClientRequest.t = "get"
@module("node:http")
external getUrlWithOptions: (Url.t, requestOptions) => ClientRequest.t = "get"
@module("node:http")
external getUrlWithOptionsCallback: (
  Url.t,
  requestOptions,
  IncomingMessage.t => unit,
) => ClientRequest.t = "get"

@module("node:http") external globalAgent: Agent.t = "globalAgent"
@module("node:http") external maxHeaderSize: int = "maxHeaderSize"

type statusCodes = Js.Dict.t<string>
@module("node:http") external _STATUS_CODES: statusCodes = "STATUS_CODES"

type methods = array<string>
@module("node:http") external _METHODS: methods = "METHODS"

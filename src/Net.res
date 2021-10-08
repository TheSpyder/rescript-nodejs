type tcp = [#Tcp]
type icp = [#Icp]

type address = {
  @as("port")
  port: int,
  @as("family")
  family: string,
  @as("address")
  address: string,
}

module Socket = {
  type kind<'w, 'r> = [Stream.socket<'w, 'r>]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>

  module Events = {
    @send
    external onClose: (
      subtype<'w, 'r, 'ty>,
      @as("close") _,
      @uncurry (bool => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onConnect: (
      subtype<'w, 'r, 'ty>,
      @as("connect") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onData: (
      subtype<'w, 'r, 'ty>,
      @as("data") _,
      @uncurry ('r => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onDrain: (
      subtype<'w, 'r, 'ty>,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onEnd: (
      subtype<'w, 'r, 'ty>,
      @as("end") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onError: (
      subtype<'w, 'r, 'ty>,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onLookup: (
      subtype<'w, 'r, 'ty>,
      @as("lookup") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onReady: (
      subtype<'w, 'r, 'ty>,
      @as("ready") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "on"
    @send
    external onTimeout: (
      subtype<'w, 'r, 'ty>,
      @as("timeout") _,
      unit => unit,
    ) => subtype<'w, 'r, 'ty> = "on"

    @send
    external offClose: (
      subtype<'w, 'r, 'ty>,
      @as("close") _,
      @uncurry (bool => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offConnect: (
      subtype<'w, 'r, 'ty>,
      @as("connect") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offData: (
      subtype<'w, 'r, 'ty>,
      @as("data") _,
      @uncurry ('r => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offDrain: (
      subtype<'w, 'r, 'ty>,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offEnd: (
      subtype<'w, 'r, 'ty>,
      @as("end") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offError: (
      subtype<'w, 'r, 'ty>,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offLookup: (
      subtype<'w, 'r, 'ty>,
      @as("lookup") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offReady: (
      subtype<'w, 'r, 'ty>,
      @as("ready") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"
    @send
    external offTimeout: (
      subtype<'w, 'r, 'ty>,
      @as("timeout") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "off"

    @send
    external onCloseOnce: (
      subtype<'w, 'r, 'ty>,
      @as("close") _,
      @uncurry (bool => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onConnectOnce: (
      subtype<'w, 'r, 'ty>,
      @as("connect") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onDataOnce: (
      subtype<'w, 'r, 'ty>,
      @as("data") _,
      @uncurry ('r => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onDrainOnce: (
      subtype<'w, 'r, 'ty>,
      @as("drain") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onEndOnce: (
      subtype<'w, 'r, 'ty>,
      @as("end") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onErrorOnce: (
      subtype<'w, 'r, 'ty>,
      @as("error") _,
      @uncurry (Js.Exn.t => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onLookupOnce: (
      subtype<'w, 'r, 'ty>,
      @as("lookup") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onReadyOnce: (
      subtype<'w, 'r, 'ty>,
      @as("ready") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
    @send
    external onTimeoutOnce: (
      subtype<'w, 'r, 'ty>,
      @as("timeout") _,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "once"
  }

  module Impl = {
    include Stream.Duplex.Impl
    include Events
    @send external address: subtype<'w, 'r, 'ty> => address = "address"
    @get external bufferSize: subtype<'w, 'r, 'ty> => int = "bufferSize"
    @get external bytesRead: subtype<'w, 'r, 'ty> => int = "bytesRead"
    @get
    external bytesWritten: subtype<'w, 'r, 'ty> => int = "bytesWritten"
    @get
    external connecting: subtype<'w, 'r, 'ty> => bool = "connecting"
    @get external destroyed: subtype<'w, 'r, 'ty> => bool = "destroyed"
    @send
    external destroy: (subtype<'w, 'r, 'ty>, ~error: option<Js.Exn.t>) => subtype<'w, 'r, 'ty> =
      "destroy"
    @get
    external localAddress: subtype<'w, 'r, 'ty> => string = "localAddress"
    @get external localPort: subtype<'w, 'r, 'ty> => int = "localPort"
    @send
    external pause: subtype<'w, 'r, 'ty> => subtype<'w, 'r, 'ty> = "pause"
    @get external pending: subtype<'w, 'r, 'ty> => bool = "pending"
    @send
    external ref: subtype<'w, 'r, 'ty> => subtype<'w, 'r, 'ty> = "ref"
    @get
    external remoteAddress: subtype<'w, 'r, 'ty> => string = "remoteAddress"
    @get
    external remoteFamily: subtype<'w, 'r, 'ty> => string = "remoteFamily"
    @get external remotePort: subtype<'w, 'r, 'ty> => int = "remotePort"
    @send
    external resume: subtype<'w, 'r, 'ty> => subtype<'w, 'r, 'ty> = "resume"
    @send
    external setKeepAlive: (
      subtype<'w, 'r, 'ty>,
      ~enable: bool,
      ~delay: int,
    ) => subtype<'w, 'r, 'ty> = "setKeepAlive"
    @send
    external setNoDelay: (subtype<'w, 'r, 'ty>, ~noDelay: bool) => subtype<'w, 'r, 'ty> =
      "setNoDelay"
    @send
    external setTimeout: (
      subtype<'w, 'r, 'ty>,
      int,
      ~callback: @this (subtype<'w, 'r, 'ty> => unit),
    ) => subtype<'w, 'r, 'ty> = "setTimeout"
    @send
    external unref: subtype<'w, 'r, 'ty> => subtype<'w, 'r, 'ty> = "unref"
    @send
    external connectIcp: (
      subtype<'w, 'r, [> kind<'w, 'r> | icp]> as 'icpSocket,
      ~path: string,
      @uncurry (unit => unit),
    ) => 'icpSocket = "connect"
    @send
    external connectTcp: (
      subtype<'w, 'r, [> kind<'w, 'r> | tcp]> as 'tcpSocket,
      ~port: int,
      ~host: string,
      @uncurry (unit => unit),
    ) => 'tcpSocket = "connect"
  }
  include Impl
  include EventEmitter.Impl({
    type t = t
  })

  type makeOptions

  @obj
  external makeOptions: (~fd: int=?, ~readable: bool=?, ~writable: bool=?, unit) => makeOptions = ""

  @module("net") @new
  external make: (~options: makeOptions=?, unit) => t = "Socket"
}

module TcpSocket = {
  type kind<'w, 'r> = [Socket.kind<'w, 'r> | tcp]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Events = {
    include Socket.Events
  }
  module Impl = {
    include Socket.Impl
    include Events
    @send
    external connect: (
      subtype<'w, 'r, 'ty>,
      ~port: int,
      ~host: string,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "connect"
  }
  include Impl
  @module("net") @new external make: unit => t = "Socket"
}

module IcpSocket = {
  type kind<'w, 'r> = [Socket.kind<'w, 'r> | icp]
  type subtype<'w, 'r, 'ty> = Stream.subtype<[> kind<'w, 'r>] as 'ty>
  type supertype<'w, 'r, 'ty> = Stream.subtype<[< kind<'w, 'r>] as 'ty>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Events = {
    include Socket.Events
  }
  module Impl = {
    include Socket.Impl
    @send
    external connect: (
      subtype<'w, 'r, 'ty>,
      ~path: string,
      @uncurry (unit => unit),
    ) => subtype<'w, 'r, 'ty> = "connect"
  }
  include Impl
  @module("net") @new external make: unit => t = "Socket"
}

module Server = {
  type kind = [#Server]
  type subtype<'ty> constraint 'ty = [> kind]
  type supertype<'ty> constraint 'ty = [< kind]
  type t<'ty> = subtype<'ty>
  module Events = {
    @send
    external onClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (Socket.t => unit),
    ) => subtype<'ty> = "on"
    @send
    external onListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "on"
    @send
    external offClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (Socket.t => unit),
    ) => subtype<'ty> = "off"
    @send
    external offListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "off"
    @send
    external onCloseOnce: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onErrorOnce: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onConnectionOnce: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (Socket.t => unit),
    ) => subtype<'ty> = "once"
    @send
    external onListeningOnce: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "once"
  }
  module Impl = {
    include Events
    @send
    external close: (
      subtype<'ty>,
      ~callback: Js.nullable<Js.Exn.t> => unit=?,
      unit,
    ) => subtype<'ty> = "close"
    @send
    external getConnections: (subtype<'ty>, (Js.nullable<Js.Exn.t>, int) => unit) => subtype<'ty> =
      "getConnections"
    @set
    external setMaxConnections: (subtype<'ty>, int) => unit = "maxConnections"
    @get external maxConnections: subtype<'ty> => int = "maxConnections"
    @send external ref: subtype<'ty> => subtype<'ty> = "ref"
    @send external unref: subtype<'ty> => subtype<'ty> = "unref"
    @get external listening: subtype<'ty> => bool = "listening"
  }

  include Impl
}

module TcpServer = {
  type kind = [Server.kind | tcp]
  type t = Server.subtype<kind>
  type subtype<'ty> = Server.subtype<[> kind] as 'ty>
  type supertype<'ty> = Server.subtype<[< kind] as 'ty>
  module Events = {
    @send
    external onClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (TcpSocket.t => unit),
    ) => subtype<'ty> = "on"
    @send
    external onListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "on"
    @send
    external offClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (TcpSocket.t => unit),
    ) => subtype<'ty> = "off"
    @send
    external offListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "off"
    @send
    external onCloseOnce: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onErrorOnce: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onConnectionOnce: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (TcpSocket.t => unit),
    ) => subtype<'ty> = "once"
    @send
    external onListeningOnce: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "once"
  }
  module Impl = {
    include Events
    @send
    external close: (subtype<'ty>, ~callback: Js.nullable<Js.Exn.t> => unit) => subtype<'ty> =
      "close"
    @send
    external getConnections: (subtype<'ty>, (Js.nullable<Js.Exn.t>, int) => unit) => subtype<'ty> =
      "getConnections"
    @set
    external setMaxConnections: (subtype<'ty>, int) => unit = "maxConnections"
    @get external maxConnections: subtype<'ty> => int = "maxConnections"
    @send external ref: subtype<'ty> => subtype<'ty> = "ref"
    @send external unref: subtype<'ty> => subtype<'ty> = "unref"
    @get external listening: subtype<'ty> => bool = "listening"
  }
  include Impl
  type listenOptions
  @obj
  external listenOptions: (
    ~port: int=?,
    ~host: string=?,
    ~backlog: int=?,
    ~exclusive: bool=?,
    ~ipv6Only: bool=?,
    unit,
  ) => listenOptions = ""
  @module("net") @new external make: unit => t = "Server"
  @send
  external listen: (t, ~port: int, ~host: string, ~callback: unit => unit) => t = "listen"
  @send
  external listenWithOptions: (t, listenOptions, ~callback: unit => unit) => t = "listen"
}

module IcpServer = {
  type kind = [Server.kind | icp]
  type t = Server.subtype<kind>
  type subtype<'ty> = Server.subtype<[> kind] as 'ty>
  type supertype<'ty> = Server.subtype<[< kind] as 'ty>
  module Events = {
    @send
    external onClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> = "on"
    @send
    external onConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (IcpSocket.t => unit),
    ) => subtype<'ty> = "on"
    @send
    external onListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "on"
    @send
    external offClose: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offError: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "off"
    @send
    external offConnection: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (IcpSocket.t => unit),
    ) => subtype<'ty> = "off"
    @send
    external offListening: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "off"
    @send
    external onCloseOnce: (subtype<'ty>, @as("close") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onErrorOnce: (subtype<'ty>, @as("error") _, @uncurry (unit => unit)) => subtype<'ty> =
      "once"
    @send
    external onConnectionOnce: (
      subtype<'ty>,
      @as("connection") _,
      @uncurry (IcpSocket.t => unit),
    ) => subtype<'ty> = "once"
    @send
    external onListeningOnce: (
      subtype<'ty>,
      @as("listening") _,
      @uncurry (unit => unit),
    ) => subtype<'ty> = "once"
  }
  module Impl = {
    include Events
    @send
    external close: (subtype<'ty>, ~callback: Js.nullable<Js.Exn.t> => unit) => subtype<'ty> =
      "close"
    @send
    external getConnections: (subtype<'ty>, (Js.nullable<Js.Exn.t>, int) => unit) => subtype<'ty> =
      "getConnections"
    @set
    external setMaxConnections: (subtype<'ty>, int) => unit = "maxConnections"
    @get external maxConnections: subtype<'ty> => int = "maxConnections"
    @send external ref: subtype<'ty> => subtype<'ty> = "ref"
    @send external unref: subtype<'ty> => subtype<'ty> = "unref"
    @get external listening: subtype<'ty> => bool = "listening"
  }
  include Impl
  type listenOptions
  @obj
  external listenOptions: (
    ~path: string=?,
    ~host: string=?,
    ~backlog: int=?,
    ~exclusive: bool=?,
    ~readableAll: bool=?,
    ~writableAll: bool=?,
    unit,
  ) => listenOptions = ""
  @send
  external listen: (t, ~path: string, ~callback: unit => unit) => t = "listen"
  @send
  external listenWithOptions: (t, ~options: listenOptions, ~callback: unit => unit) => t = "listen"
}

@module("net") @val external isIP: string => bool = "isIP"
@module("net") @val external isIPv4: string => bool = "isIPv4"
@module("net") @val external isIPv6: string => bool = "isIPv6"

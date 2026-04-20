module Address = {
  type t = private {
    @as("address")
    address: string,
    @as("port")
    port: string,
  }
  type internalView<'a> = private {
    @as("address")
    address: string,
    @as("port")
    port: string,
    @as("addressType")
    addressType: 'a,
  }
  type case =
    | TcpV4(t)
    | TcpV6(t)
    | UnixDomainSocket(t)
    | Udp4(t)
    | Udp6(t)
    | Unknown(t)

  let classify: t => case = x =>
    switch x {
    | address =>
      let internalReturn: internalView<'a> = Obj.magic(address)
      let addressType = internalReturn.addressType
      let intOrString = typeof(addressType)
      switch intOrString {
      | #number =>
        switch (Obj.magic(addressType): int) {
        | 4 => TcpV4(address)
        | 6 => TcpV6(address)
        | -1 => UnixDomainSocket(address)
        | _ => Unknown(address)
        }
      | #string =>
        switch (Obj.magic(addressType): string) {
        | "udp4" => Udp4(address)
        | "udp6" => Udp6(address)
        | _ => Unknown(address)
        }
      | _ => Unknown(address)
      }
    }
}

module Message = {
  type t<'a> = 'a
}

module Worker = {
  type t = {id: int, process: ChildProcess.t}
  module Events = {
    @send
    external onDisconnect: (t, @as("disconnect") _, unit => unit) => t = "on"
    @send
    external onError: (t, @as("error") _, JsExn.t => unit) => t = "on"
    @send
    external onExit: (t, @as("exit") _, (nullable<int>, nullable<string>) => unit) => t = "on"
    @send
    external onListening: (t, @as("listening") _, Address.t => unit) => t = "on"
    @send
    external onMessage: (t, @as("message") _, (Message.t<'a>, nullable<'a>) => unit) => t = "on"
    @send
    external onOnline: (t, @as("online") _, unit => unit) => t = "on"

    @send
    external offDisconnect: (t, @as("disconnect") _, unit => unit) => t = "off"
    @send
    external offError: (t, @as("error") _, JsExn.t => unit) => t = "off"
    @send
    external offExit: (t, @as("exit") _, (nullable<int>, nullable<string>) => unit) => t = "off"
    @send
    external offListening: (t, @as("listening") _, Address.t => unit) => t = "off"
    @send
    external offMessage: (t, @as("message") _, (Message.t<'a>, nullable<'a>) => unit) => t = "off"
    @send
    external offOnline: (t, @as("online") _, unit => unit) => t = "off"

    @send
    external onDisconnectOnce: (t, @as("disconnect") _, unit => unit) => t = "once"
    @send
    external onErrorOnce: (t, @as("error") _, JsExn.t => unit) => t = "once"
    @send
    external onExitOnce: (t, @as("exit") _, (nullable<int>, nullable<string>) => unit) => t =
      "once"
    @send
    external onListeningOnce: (t, @as("listening") _, Address.t => unit) => t = "once"
    @send
    external onMessageOnce: (t, @as("message") _, (Message.t<'a>, nullable<'a>) => unit) => t =
      "once"
    @send
    external onOnlineOnce: (t, @as("online") _, unit => unit) => t = "once"

    @send external removeAllListeners: t => unit = "removeAllListeners"
  }
  @send external disconnect: t => unit = "disconnect"
  @send
  external exitedAfterDisconnect: t => bool = "exitedAfterDisconnect"
  @get external id: t => int = "id"
  @send external isConnected: t => bool = "isConnected"
  @send external isDead: t => bool = "isConnected"
  @send external kill: t => unit = "kill"
  @send external killWith: (t, ~signal: string) => unit = "kill"
  @get external process: t => ChildProcess.t = "process"
  @send external send: string => unit = "send"

  @send
  external sendHttpServerHandle: (string, Http.Server.t, nullable<{..}>) => unit = "send"
  let sendHttpServerHandle = (~options=?, msg, handle) =>
    sendHttpServerHandle(msg, handle, Nullable.fromOption(options))
  @send
  external sendSocketHandle: (string, Net.Socket.subtype<'w, 'r, 'a>, nullable<{..}>) => unit =
    "send"
  let sendSocketHandle = (~options=?, msg, handle) =>
    sendSocketHandle(msg, handle, Nullable.fromOption(options))
}

type clusterSettings = private {
  execArgv: nullable<array<string>>,
  exec: nullable<string>,
  args: nullable<array<string>>,
  cwd: nullable<string>,
  serialization: nullable<string>,
  silent: nullable<bool>,
  stdio: nullable<array<string>>,
  uid: nullable<int>,
  gid: nullable<int>,
  inspectPort: nullable<int>,
  windowsHide: nullable<bool>,
}

@module
external disconnect: nullable<unit => unit> => unit = "disconnect"
let disconnect = (~callback=?) => disconnect(Nullable.fromOption(callback))
@module("node:cluster")
external fork: option<dict<string>> => Worker.t = "fork"
let fork = (~env=?) => fork(env)
@module("node:cluster") external isMaster: bool = "isMaster"
@module("node:cluster") external isWorker: bool = "isWorker"
@module("node:cluster") external settings: clusterSettings = "settings"
@module("node:cluster")
external setupMaster: clusterSettings => unit = "setupMaster"
@module("node:cluster") external _SCHED_NONE: int = "SCHED_NONE"
@module("node:cluster") external _SCHED_RR: int = "SCHED_RR"
@module("node:cluster") external schedulingPolicy: int = "schedulingPolicy"
type schedulingPolicy =
  | SCHED_NONE
  | SCHED_RR
let decodeSchedulingPolicy = if schedulingPolicy === _SCHED_RR {
  SCHED_RR
} else {
  SCHED_NONE
}
@module("node:cluster") external worker: Worker.t = "worker"
@module("node:cluster") external workers: dict<Worker.t> = "workers"
let getWorker: (dict<Worker.t>, int) => option<Worker.t> = (_workers, id) =>
  Dict.get(_workers, Int.toString(id))

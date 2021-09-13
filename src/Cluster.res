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
      let intOrString = Js.typeof(addressType)
      switch intOrString {
      | "number" =>
        switch (Obj.magic(addressType): int) {
        | 4 => TcpV4(address)
        | 6 => TcpV6(address)
        | -1 => UnixDomainSocket(address)
        | _ => Unknown(address)
        }
      | "string" =>
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
  type t
  module Events = {
    @send
    external onDisconnect: (t, @as("disconnect") _, @uncurry (unit => unit)) => t = "on"
    @send
    external onError: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "on"
    @send
    external onExit: (
      t,
      @as("exit") _,
      @uncurry (Js.nullable<int>, Js.nullable<string>) => unit,
    ) => t = "on"
    @send
    external onListening: (t, @as("listening") _, @uncurry (Address.t => unit)) => t = "on"
    @send
    external onMessage: (
      t,
      @as("message") _,
      @uncurry (Message.t<'a>, Js.nullable<'a>) => unit,
    ) => t = "on"
    @send
    external onOnline: (t, @as("online") _, @uncurry (unit => unit)) => t = "on"

    @send
    external offDisconnect: (t, @as("disconnect") _, @uncurry (unit => unit)) => t = "off"
    @send
    external offError: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "off"
    @send
    external offExit: (
      t,
      @as("exit") _,
      @uncurry (Js.nullable<int>, Js.nullable<string>) => unit,
    ) => t = "off"
    @send
    external offListening: (t, @as("listening") _, @uncurry (Address.t => unit)) => t = "off"
    @send
    external offMessage: (
      t,
      @as("message") _,
      @uncurry (Message.t<'a>, Js.nullable<'a>) => unit,
    ) => t = "off"
    @send
    external offOnline: (t, @as("online") _, @uncurry (unit => unit)) => t = "off"

    @send
    external onDisconnectOnce: (t, @as("disconnect") _, @uncurry (unit => unit)) => t = "once"
    @send
    external onErrorOnce: (t, @as("error") _, @uncurry (Js.Exn.t => unit)) => t = "once"
    @send
    external onExitOnce: (
      t,
      @as("exit") _,
      @uncurry (Js.nullable<int>, Js.nullable<string>) => unit,
    ) => t = "once"
    @send
    external onListeningOnce: (t, @as("listening") _, @uncurry (Address.t => unit)) => t = "once"
    @send
    external onMessageOnce: (
      t,
      @as("message") _,
      @uncurry (Message.t<'a>, Js.nullable<'a>) => unit,
    ) => t = "once"
    @send
    external onOnlineOnce: (t, @as("online") _, @uncurry (unit => unit)) => t = "once"

    @send external removeAllListeners: t => unit = "removeAllListeners"
  }
  @send external disconnect: t => unit = "disconnect"
  @send
  external exitedAfterDisconnect: t => bool = "exitedAfterDisconnect"
  @send external id: t => int = "id"
  @send external isConnected: t => bool = "isConnected"
  @send external isDead: t => bool = "isConnected"
  @send external kill: t => unit = "kill"
  @send external killWith: (t, ~signal: string) => unit = "kill"
  @send external process: t => ChildProcess.t = "process"
  @send external send: string => unit = "send"

  @send
  external sendHttpServerHandle: (string, Http.Server.t, Js.nullable<{..}>) => unit = "send"
  let sendHttpServerHandle = (~options=?, msg, handle) =>
    sendHttpServerHandle(msg, handle, Js.Nullable.fromOption(options))
  @send
  external sendSocketHandle: (string, Net.Socket.subtype<'w, 'r, 'a>, Js.nullable<{..}>) => unit =
    "send"
  let sendSocketHandle = (~options=?, msg, handle) =>
    sendSocketHandle(msg, handle, Js.Nullable.fromOption(options))
}

type clusterSettings = private {
  execArgv: Js.nullable<array<string>>,
  exec: Js.nullable<string>,
  args: Js.nullable<array<string>>,
  cwd: Js.nullable<string>,
  serialization: Js.nullable<string>,
  silent: Js.nullable<bool>,
  stdio: Js.nullable<array<string>>,
  uid: Js.nullable<int>,
  gid: Js.nullable<int>,
  inspectPort: Js.nullable<int>,
  windowsHide: Js.nullable<bool>,
}

@obj
external clusterSettings: (
  ~execArgv: array<string>=?,
  ~exec: string=?,
  ~args: array<string>=?,
  ~cwd: string=?,
  ~serialization: string=?,
  ~silent: bool=?,
  ~stdio: array<string>=?,
  ~uid: int=?,
  ~gid: int=?,
  ~inspectPort: int=?,
  ~windowsHide: bool=?,
  unit,
) => clusterSettings = ""

@module
external disconnect: Js.Nullable.t<unit => unit> => unit = "disconnect"
let disconnect = (~callback=?, ()) => disconnect(Js.Nullable.fromOption(callback))
@module("cluster")
external fork: option<Js.Dict.t<string>> => Worker.t = "fork"
let fork = (~env=?, ()) => fork(env)
@module("cluster") external isMaster: bool = "isMaster"
@module("cluster") external isWorker: bool = "isWorker"
@module("cluster") external settings: clusterSettings = "settings"
@module("cluster")
external setupMaster: clusterSettings => unit = "setupMaster"
@module("cluster") external _SCHED_NONE: int = "SCHED_NONE"
@module("cluster") external _SCHED_RR: int = "SCHED_RR"
@module("cluster") external schedulingPolicy: int = "schedulingPolicy"
type schedulingPolicy =
  | SCHED_NONE
  | SCHED_RR
let decodeSchedulingPolicy = if schedulingPolicy === _SCHED_RR {
  SCHED_RR
} else {
  SCHED_NONE
}
@module("cluster") external worker: Worker.t = "worker"
@module("cluster") external workers: Js.Dict.t<Worker.t> = "workers"
let getWorker: (Js.Dict.t<Worker.t>, int) => option<Worker.t> = (_workers, id) =>
  Js.Dict.get(_workers, Js.Int.toString(id))

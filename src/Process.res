type t = {
  argv: array<string>,
  argv0: string,
  env: dict<string>,
  execArgv: array<string>,
  execPath: string,
  exitCode: int,
}
@module external process: t = "process"

type warning = {
  name: string,
  message: string,
  stack: string,
}

module Events = {
  @send
  external onBeforeExit: (t, @as("beforeExit") _, int => unit) => t = "on"
  @send
  external onDisconnect: (t, @as("disconnect") _, unit => unit) => t = "on"
  @send
  external onExit: (t, @as("exit") _, int => unit) => t = "on"
  @send
  external onMultipleResolves: (
    t,
    @as("multipleResolves") _,
    (string, promise<'a>, 'a) => unit,
  ) => t = "on"
  @send
  external onRejectionHandled: (t, @as("rejectionHandled") _, promise<'a> => unit) => t = "on"
  @send
  external onUncaughtException: (t, @as("uncaughtException") _, (JsExn.t, string) => unit) => t =
    "on"
  @send
  external onUnhandledRejection: (
    t,
    @as("unhandledRejection") _,
    (JsExn.t, promise<'a>) => unit,
  ) => t = "on"
  @send
  external onWarning: (t, @as("warning") _, warning => unit) => t = "on"

  @send
  external offBeforeExit: (t, @as("beforeExit") _, int => unit) => t = "off"
  @send
  external offDisconnect: (t, @as("disconnect") _, unit => unit) => t = "off"
  @send
  external offExit: (t, @as("exit") _, int => unit) => t = "off"
  @send
  external offMultipleResolves: (
    t,
    @as("multipleResolves") _,
    (string, promise<'a>, 'a) => unit,
  ) => t = "off"
  @send
  external offRejectionHandled: (t, @as("rejectionHandled") _, promise<'a> => unit) => t = "off"
  @send
  external offUncaughtException: (t, @as("uncaughtException") _, (JsExn.t, string) => unit) => t =
    "off"
  @send
  external offUnhandledRejection: (
    t,
    @as("unhandledRejection") _,
    (JsExn.t, promise<'a>) => unit,
  ) => t = "off"
  @send
  external offWarning: (t, @as("warning") _, warning => unit) => t = "off"

  @send
  external onBeforeExitOnce: (t, @as("beforeExit") _, int => unit) => t = "once"
  @send
  external onDisconnectOnce: (t, @as("disconnect") _, unit => unit) => t = "once"
  @send
  external onExitOnce: (t, @as("exit") _, int => unit) => unit = "once"
  @send
  external onMultipleResolvesOnce: (
    t,
    @as("multipleResolves") _,
    (string, promise<'a>, 'a) => unit,
  ) => t = "once"
  @send
  external onRejectionHandledOnce: (t, @as("rejectionHandled") _, promise<'a> => unit) => t = "once"
  @send
  external onUncaughtExceptionOnce: (
    t,
    @as("uncaughtException") _,
    (JsExn.t, string) => unit,
  ) => t = "once"
  @send
  external onUnhandledRejectionOnce: (
    t,
    @as("unhandledRejection") _,
    (JsExn.t, promise<'a>) => unit,
  ) => t = "once"
  @send
  external onWarningOnce: (t, @as("warning") _, warning => unit) => t = "once"

  @send external removeAllListeners: t => t = "removeAllListeners"
}
include Events

@send external abort: t => unit = "abort"
@get external argv: t => array<string> = "argv"
@get external argv0: t => string = "argv0"
@send external chdir: (t, string) => unit = "chdir"
@send external cwd: t => string = "cwd"
@send external disconnect: t => unit = "disconnect"
@get external env: t => dict<string> = "env"
@get external execArgv: t => array<string> = "execArgv"
@get external execPath: t => string = "execPath"
@send external exit: (t, unit) => unit = "exit"
@send external exitWithCode: (t, int) => unit = "exit"
@get external exitCode: t => int = "exitCode"
@send
external nextTick: (t, unit => unit) => unit = "nextTick"
@send
external nextTickApply1: (t, 'a => unit, 'a) => unit = "nextTick"
@send
external nextTickApply2: (t, ('a, 'b) => unit, 'a, 'b) => unit = "nextTick"
@send
external nextTickApply3: (t, ('a, 'b, 'c) => unit, 'a, 'b, 'c) => unit = "nextTick"
@send
external nextTickApply4: (t, ('a, 'b, 'c, 'd) => unit, 'a, 'b, 'c, 'd) => unit = "nextTick"
@send
external nextTickApply5: (t, ('a, 'b, 'c, 'd, 'e) => unit, 'a, 'b, 'c, 'd, 'e) => unit = "nextTick"
@send external hrtime: t => (int, int) = "hrtime"
@send @scope("hrtime")
external hrtimeBigInt: t => BigInt.t = "bigint"
@get external stderr: t => Stream.Writable.t<Buffer.t> = "stderr"
@get external stdin: t => Stream.Readable.t<Buffer.t> = "stdin"
@get external stdout: t => Stream.Writable.t<Buffer.t> = "stdout"
@get external pid: t => int = "pid"
@get external platform: t => string = "platform"
@get external ppid: t => int = "ppid"
@get external uptime: t => float = "uptime"
@get external title: t => string = "title"
@get external version: t => string = "version"
@get external versions: t => dict<string> = "versions"
type memoryUsageStats = {
  @as("rss")
  rss: int,
  @as("heapTotal")
  heapTotal: int,
  @as("heapUsed")
  heapUsed: int,
  @as("external")
  external_: int,
  @as("arrayBuffers")
  arrayBuffers: int,
}
@send external memoryUsage: t => memoryUsageStats = "memoryUsage"

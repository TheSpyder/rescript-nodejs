type cpuTimes = private {
  user: int,
  nice: int,
  sys: int,
  idle: int,
  irq: int,
}
type cpu = private {
  model: string,
  speed: string,
  times: cpuTimes,
}
@module("node:os") @val external eol: string = "EOL"
@module("node:os") @val external arch: string = "arch"
@module("node:os") @val external cpus: unit => array<cpu> = "cpus"
@module("node:os") @val external endianness: unit => string = "endianness"
@module("node:os") @val external freemem: unit => int = "freemem"
@module("node:os") @val external getPriority: int => int = "getPriority"
@module("node:os") @val external homedir: unit => string = "homedir"
@module("node:os") @val external hostname: unit => string = "hostname"
@module("node:os") @val
external loadavg: unit => array<float> = "loadavg"
@module("node:os") @val external platform: unit => string = "platform"
@module("node:os") @val external release: unit => string = "release"
@module("node:os") @val
external setPriority: (int, int) => unit = "setPriority"
@module("node:os") @val external tmpdir: unit => string = "tmpdir"
@module("node:os") @val external totalmem: unit => int = "totalmem"
@module("node:os") @val external type_: unit => string = "type"
@module("node:os") @val external uptime: unit => int = "uptime"

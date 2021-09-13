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
@module("os") @val external eol: string = "EOL"
@module("os") @val external arch: string = "arch"
@module("os") @val external cpus: unit => array<cpu> = "cpus"
@module("os") @val external endianness: unit => string = "endianness"
@module("os") @val external freemem: unit => int = "freemem"
@module("os") @val external getPriority: int => int = "getPriority"
@module("os") @val external homedir: unit => string = "homedir"
@module("os") @val external hostname: unit => string = "hostname"
@module("os") @val
external loadavg: unit => array<float> = "loadavg"
@module("os") @val external platform: unit => string = "platform"
@module("os") @val external release: unit => string = "release"
@module("os") @val
external setPriority: (int, int) => unit = "setPriority"
@module("os") @val external tmpdir: unit => string = "tmpdir"
@module("os") @val external totalmem: unit => int = "totalmem"
@module("os") @val external type_: unit => string = "type"
@module("os") @val external uptime: unit => int = "uptime"

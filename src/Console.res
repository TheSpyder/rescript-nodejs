// We'll only bind to the instance version of console.Console for now: https://nodejs.org/api/console.html
// For global console.log and others, use the existing Js.Console.* provided by BuckleScript out of the box

type t
@val external console: t = "console"

type consoleOptions<'w, 'a> = {
  stdout: Stream.Writable.subtype<'w, 'a>,
  stderr?: Stream.Writable.subtype<'w, 'a>,
  ignoreErrors?: bool,
  colorMode?: bool,
  inspectOptions?: Util.inspectOptions,
}

@new @module("node:console")
external make: consoleOptions<'w, 'a> => t = "Console"
@new @module("node:console")
external make2: {.."stdout": Stream.Writable.subtype<'w, 'a>} => t = "Console"

@send external assert_: (t, bool) => unit = "assert"
// TODO: reconsider naming
@send external assertWithMessage: (t, bool, string) => unit = "assert"
@send external clear: t => unit = "clear"
@send external count: (t, string) => unit = "count"
@send external countReset: (t, string) => unit = "countReset"

@send external debug: (t, string) => unit = "debug"
@send @variadic
external debugMany: (t, array<'a>) => unit = "debug"

@send external dir: (t, 'a) => unit = "dir"
@send @variadic external dirMany: (t, array<'a>) => unit = "dir"

@send external dirxml: (t, string) => unit = "dirxml"
@send @variadic
external dirxmlMany: (t, array<'a>) => unit = "dirxml"

@send external error: (t, string) => unit = "error"
@send @variadic
external errorMany: (t, array<'a>) => unit = "error"

@send external group: (t, string) => unit = "group"
@send @variadic
external groupMany: (t, array<'a>) => unit = "group"

@send external groupEnd: (t, unit) => unit = "groupEnd"

@send external info: (t, string) => unit = "info"
@send @variadic external infoMany: (t, array<'a>) => unit = "info"

@send external log: (t, string) => unit = "log"
@send @variadic external logMany: (t, array<'a>) => unit = "log"

@send external table: (t, array<'a>) => unit = "table"

@send external time: (t, string) => unit = "time"

//TODO: research more into this function. Not sure how it works.
@send @variadic
external timeLog: (t, string, array<'a>) => unit = "timeLog"

@send external trace: (t, string) => unit = "trace"
@send @variadic
external traceMany: (t, array<'a>) => unit = "trace"

@send external warn: (t, string) => unit = "warn"
@send @variadic external warnMany: (t, array<'a>) => unit = "warn"

type t = {
  dir: string,
  root: string,
  base: string,
  name: string,
  ext: string,
}

@module("node:path") external basename: string => string = "basename"

@module("node:path")
external basenameExt: (string, string) => string = "basename"

@module("node:path") external delimiter: string = "delimiter"

@module("node:path") external dirname: string => string = "dirname"

@module("node:path") external extname: string => string = "extname"

@module("node:path") external format: t => string = "format"

@module("node:path") external isAbsolute: string => bool = "isAbsolute"

@module("node:path") @variadic
external join: array<string> => string = "join"

@module("node:path") external join2: (string, string) => string = "join"

@module("node:path") external normalize: string => string = "normalize"

@module("node:path") external parse: string => t = "parse"

@module("node:path")
external relative: (~from: string, ~to_: string) => string = "relative"

@module("node:path") @variadic
external resolve: array<string> => string = "resolve"

@module("node:path") external sep: string = "sep"

@module("node:path")
external toNamespacedPath: string => string = "toNamespacedPath"

module Posix = {
  @module("node:path") @scope("posix")
  external basename: string => string = "basename"

  @module("node:path") @scope("posix")
  external basenameExt: (string, string) => string = "basename"

  @module("node:path") @scope("posix")
  external delimiter: string = "delimiter"

  @module("node:path") @scope("posix")
  external dirname: string => string = "dirname"

  @module("node:path") @scope("posix")
  external extname: string => string = "extname"

  @module("node:path") @scope("posix")
  external format: t => string = "format"

  @module("node:path") @scope("posix")
  external isAbsolute: string => bool = "isAbsolute"

  @module("node:path") @scope("posix") @variadic
  external join: array<string> => string = "join"

  @module("node:path") @scope("posix")
  external join2: (string, string) => string = "join"

  @module("node:path") @scope("posix")
  external normalize: string => string = "normalize"

  @module("node:path") @scope("posix")
  external parse: string => t = "parse"

  @module("node:path") @scope("posix")
  external relative: (~from: string, ~to_: string) => string = "relative"

  @module("node:path") @scope("posix") @variadic
  external resolve: array<string> => string = "resolve"

  @module("node:path") @scope("posix") external sep: string = "sep"

  @module("node:path") @scope("posix")
  external toNamespacedPath: string => string = "toNamespacedPath"
}

module Win32 = {
  @module("node:path") @scope("win32")
  external basename: string => string = "basename"

  @module("node:path") @scope("win32")
  external basenameExt: (string, string) => string = "basename"

  @module("node:path") @scope("win32")
  external delimiter: string = "delimiter"

  @module("node:path") @scope("win32")
  external dirname: string => string = "dirname"

  @module("node:path") @scope("win32")
  external extname: string => string = "extname"

  @module("node:path") @scope("win32")
  external format: t => string = "format"

  @module("node:path") @scope("win32")
  external isAbsolute: string => bool = "isAbsolute"

  @module("node:path") @scope("win32") @variadic
  external join: array<string> => string = "join"

  @module("node:path") @scope("win32")
  external join2: (string, string) => string = "join"

  @module("node:path") @scope("win32")
  external normalize: string => string = "normalize"

  @module("node:path") @scope("win32")
  external parse: string => t = "parse"

  @module("node:path") @scope("win32")
  external relative: (~from: string, ~to_: string) => string = "relative"

  @module("node:path") @scope("win32") @variadic
  external resolve: array<string> => string = "resolve"

  @module("node:path") @scope("win32") external sep: string = "sep"

  @module("node:path") @scope("win32")
  external toNamespacedPath: string => string = "toNamespacedPath"
}

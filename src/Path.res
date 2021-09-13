type t = {
  dir: string,
  root: string,
  base: string,
  name: string,
  ext: string,
}

@module("path") external basename: string => string = "basename"

@module("path")
external basenameExt: (string, string) => string = "basename"

@module("path") external delimiter: string = "delimiter"

@module("path") external dirname: string => string = "dirname"

@module("path") external extname: string => string = "extname"

@module("path") external format: t => string = "format"

@module("path") external isAbsolute: string => bool = "isAbsolute"

@module("path") @variadic
external join: array<string> => string = "join"

@module("path") external join2: (string, string) => string = "join"

@module("path") external normalize: string => string = "normalize"

@module("path") external parse: string => t = "parse"

@module("path")
external relative: (~from: string, ~to_: string) => string = "relative"

@module("path") @variadic
external resolve: array<string> => string = "resolve"

@module("path") external sep: string = "sep"

@module("path")
external toNamespacedPath: string => string = "toNamespacedPath"

module Posix = {
  @module("path") @scope("posix")
  external basename: string => string = "basename"

  @module("path") @scope("posix")
  external basenameExt: (string, string) => string = "basename"

  @module("path") @scope("posix")
  external delimiter: string = "delimiter"

  @module("path") @scope("posix")
  external dirname: string => string = "dirname"

  @module("path") @scope("posix")
  external extname: string => string = "extname"

  @module("path") @scope("posix")
  external format: t => string = "format"

  @module("path") @scope("posix")
  external isAbsolute: string => bool = "isAbsolute"

  @module("path") @scope("posix") @variadic
  external join: array<string> => string = "join"

  @module("path") @scope("posix")
  external join2: (string, string) => string = "join"

  @module("path") @scope("posix")
  external normalize: string => string = "normalize"

  @module("path") @scope("posix")
  external parse: string => t = "parse"

  @module("path") @scope("posix")
  external relative: (~from: string, ~to_: string) => string = "relative"

  @module("path") @scope("posix") @variadic
  external resolve: array<string> => string = "resolve"

  @module("path") @scope("posix") external sep: string = "sep"

  @module("path") @scope("posix")
  external toNamespacedPath: string => string = "toNamespacedPath"
}

module Win32 = {
  @module("path") @scope("win32")
  external basename: string => string = "basename"

  @module("path") @scope("win32")
  external basenameExt: (string, string) => string = "basename"

  @module("path") @scope("win32")
  external delimiter: string = "delimiter"

  @module("path") @scope("win32")
  external dirname: string => string = "dirname"

  @module("path") @scope("win32")
  external extname: string => string = "extname"

  @module("path") @scope("win32")
  external format: t => string = "format"

  @module("path") @scope("win32")
  external isAbsolute: string => bool = "isAbsolute"

  @module("path") @scope("win32") @variadic
  external join: array<string> => string = "join"

  @module("path") @scope("win32")
  external join2: (string, string) => string = "join"

  @module("path") @scope("win32")
  external normalize: string => string = "normalize"

  @module("path") @scope("win32")
  external parse: string => t = "parse"

  @module("path") @scope("win32")
  external relative: (~from: string, ~to_: string) => string = "relative"

  @module("path") @scope("win32") @variadic
  external resolve: array<string> => string = "resolve"

  @module("path") @scope("win32") external sep: string = "sep"

  @module("path") @scope("win32")
  external toNamespacedPath: string => string = "toNamespacedPath"
}

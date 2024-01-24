type contextifiedObject<'a>

type createContextOptions = {
  name?: string,
  origin?: string,
  codeGeneration?: {"strings": bool, "wasm": bool},
}
@val @module("node:vm")
external createContext: ({..} as 'a) => contextifiedObject<'a> = "createContext"
@val @module("node:vm")
external createContextWithOptions: ({..} as 'a, createContextOptions) => contextifiedObject<'a> =
  "createContext"

module Script = {
  type t
  type options = {
    filename?: string,
    lineOffset?: int,
    columnOffset?: int,
    cachedData?: Buffer.t,
    produceCachedData?: bool,
  }
  @new @module("node:vm") external make: string => t = "Script"
  @new @module("node:vm")
  external makeWithOptions: (string, options) => t = "Script"
  @send external createCachedData: t => Buffer.t = "createCachedData"
  @send
  external runInContext: (t, contextifiedObject<'a>) => 'b = "runInContext"
  @send
  external runInNewContext: (t,  contextifiedObject<'a>) => 'b = "runInNewContext"
  @send external runInThisContext: t => 'a = "runInThisContext"
}

type contextifiedObject<'a>

type createContextOptions
@obj
external createContextOptions: (
  ~name: string=?,
  ~origin: string=?,
  ~codeGeneration: {"strings": bool, "wasm": bool}=?,
) => createContextOptions = ""
@val @module("vm")
external createContext: ({..} as 'a) => contextifiedObject<'a> = "createContext"
@val @module("vm")
external createContextWithOptions: ({..} as 'a, createContextOptions) => contextifiedObject<'a> =
  "createContext"

module Script = {
  type t
  type makeOptions
  @obj
  external makeOptions: (
    ~filename: string=?,
    ~lineOffset: int=?,
    ~columnOffset: int=?,
    ~cachedData: Buffer.t=?,
    ~produceCachedData: bool=?,
  ) => makeOptions = ""
  @new @module("vm") external make: string => t = "Script"
  @new @module("vm")
  external makeWithOptions: (string, makeOptions) => t = "Script"
  @send external createCachedData: t => Buffer.t = "createCachedData"
  @send
  external runInContext: (t, string, contextifiedObject<'a>) => 'b = "runInContext"
  @send
  external runInNewContext: (t, string, contextifiedObject<'a>) => 'b = "runInNewContext"
  @send external runInThisContext: (t, string) => 'a = "runInThisContext"
}

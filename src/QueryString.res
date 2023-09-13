type t = string

@module("node:querystring")
external parse: string => Js.Dict.t<string> = "parse"
@module("node:querystring")
external decode: string => Js.Dict.t<string> = "decode"
@module("node:querystring")
external stringify: Js.Dict.t<string> => string = "stringify"

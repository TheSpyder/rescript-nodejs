type t = string

@module("querystring")
external parse: string => Js.Dict.t<string> = "parse"
@module("querystring")
external decode: string => Js.Dict.t<string> = "decode"
@module("querystring")
external stringify: Js.Dict.t<string> => string = "stringify"

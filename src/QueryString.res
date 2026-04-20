type t = string

@module("node:querystring")
external parse: string => dict<string> = "parse"
@module("node:querystring")
external decode: string => dict<string> = "decode"
@module("node:querystring")
external stringify: dict<string> => string = "stringify"

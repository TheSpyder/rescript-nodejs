module SearchParams = {
  type rec t = {
    @as("append")
    append: (~name: string, ~value: string) => unit,
    @as("delete")
    delete: string => unit,
    @as("forEach")
    forEach: ((~value: string, ~name: string=?, ~searchParams: t=?) => unit) => unit,
    @as("get")
    get: string => Js.Null.t<string>,
    @as("getAll")
    getAll: string => array<string>,
    @as("has")
    has: string => bool,
    @as("set")
    set: (~name: string, ~value: string) => unit,
    @as("sort")
    sort: unit => unit,
    @as("toString")
    toString: unit => string,
    // [@bs.as "[Symbol.iterator]"] iteratorSymbol: unit => iterator, // no type definition for 'iterator'
    // [@bs.as "values"] values: unit => iterator, // no type definition for 'iterator'
    // [@bs.as "entries"] entries: unit => iterator, // no type definition for 'iterator'
    // [@bs.as "keys"] keys: unit => iterator, // no type definition for 'iterator'
  }
  @new external empty: unit => t = "URLSearchParams"
  @new external fromString: string => t = "URLSearchParams"
  @new external fromDict: Js.Dict.t<string> => t = "URLSearchParams"
  // [@bs.new] external fromIterable: iterable => t = "URLSearchParams"; // no type definition for 'iterator'
}

type t = {
  hash: string,
  host: string,
  hostname: string,
  href: string,
  origin: string,
  password: string,
  pathname: string,
  port: int,
  protocol: string,
  search: string,
  searchParams: SearchParams.t,
  username: string,
  toString: unit => string,
  toJson: unit => Js.Json.t,
}

@module("url") @new external make: string => t = "URL"
@module("url") @new
external fromBaseString: (~input: string, ~base: string) => t = "URL"
@module("url") @new
external fromBaseUrl: (~input: string, ~base: t) => t = "URL"

@module("url") external domainToASCII: string => string = "domainToASCII"
@module("url")
external domainToUnicode: string => string = "domainToUnicode"
@module("url") external fileURLToPath: t => string = "fileURLToPath"
@module("url")
external fileStringToPath: string => string = "fileURLToPath"

type urlFormatOptions = {"auth": bool, "fragment": bool, "search": bool, "unicode": bool}

@module("url")
external format: (
  t,
  {
    "auth": Js.Nullable.t<bool>,
    "fragment": Js.Nullable.t<bool>,
    "search": Js.Nullable.t<bool>,
    "unicode": Js.Nullable.t<bool>,
  },
) => string = "format"
let format = (~auth=?, ~fragment=?, ~search=?, ~unicode=?, url) =>
  format(
    url,
    {
      "auth": Js.Nullable.fromOption(auth),
      "fragment": Js.Nullable.fromOption(fragment),
      "search": Js.Nullable.fromOption(search),
      "unicode": Js.Nullable.fromOption(unicode),
    },
  )

@module("url") external pathToFileURL: string => t = "pathToFileURL"

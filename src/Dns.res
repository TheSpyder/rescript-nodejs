type lookupOptions
@obj
external lookupOptions: (
  ~family: int=?,
  ~hints: int=?,
  ~all: bool=?,
  ~verbatim: bool=?,
) => lookupOptions = ""
@module("dns") @scope("promise")
external lookup: string => Js.Promise.t<array<{"address": string, "family": int}>> = "lookup"
@module("node:dns") @scope("promise")
external lookupWithOptions: (
  string,
  lookupOptions,
) => Js.Promise.t<array<{"address": string, "family": int}>> = "lookup"
@module("node:dns") @scope("promise")
external lookupService: (string, int) => Js.Promise.t<{"hostname": string, "service": string}> =
  "lookupService"
@module("node:dns") @scope("promise")
external resolve4: string => Js.Promise.t<array<string>> = "resolve4"
@module("node:dns") @scope("promise")
external resolve4TTL: (string, @as(json` {"ttl": true} `) _) => Js.Promise.t<array<string>> =
  "resolve4"
@module("node:dns") @scope("promise")
external resolve6: string => Js.Promise.t<array<string>> = "resolve6"
@module("node:dns") @scope("promise")
external resolve6TTL: (string, @as(json` {"ttl": true} `) _) => Js.Promise.t<array<string>> =
  "resolve6"
@module("node:dns") @scope("promise")
external resolveAny: string => Js.Promise.t<array<{..}>> = "resolveAny"
@module("node:dns") @scope("promise")
external resolveCname: string => Js.Promise.t<array<string>> = "resolveCname"
@module("node:dns") @scope("promise")
external resolveMx: string => Js.Promise.t<array<{"priority": int, "exchange": string}>> =
  "resolveMx"
@module("node:dns") @scope("promise")
external resolveNaptr: string => Js.Promise.t<
  array<{
    "flags": string,
    "service": string,
    "regexp": string,
    "replacement": string,
    "order": int,
    "preference": int,
  }>,
> = "resolveNaptr"
@module("node:dns") @scope("promise")
external resolveNs: string => Js.Promise.t<array<string>> = "resolveNs"
@module("node:dns") @scope("promise")
external resolvePtr: string => Js.Promise.t<array<string>> = "resolvePtr"
@module("node:dns") @scope("promise")
external resolveSoa: string => Js.Promise.t<
  array<{
    "nsname": string,
    "hostmaster": string,
    "serial": float,
    "refresh": int,
    "retry": int,
    "expire": int,
    "minttl": int,
  }>,
> = "resolveSoa"

@module("node:dns") @scope("promise")
external resolveSrv: string => Js.Promise.t<
  array<{
    "priority": int,
    "weight": int,
    "port": int,
    "name": string,
  }>,
> = "resolveSrv"
@module("node:dns") @scope("promise")
external resolveTxt: string => Js.Promise.t<array<array<string>>> = "resolveTxt"
@module("node:dns") @scope("promise")
external reverse: string => Js.Promise.t<array<string>> = "reverse"
@module("node:dns") @scope("promise")
external setServers: array<string> => Js.Promise.t<unit> = "setServers"

module CallbackAPI = {
  @module("node:dns")
  external lookup: (string, (Js.Exn.t, string, int) => unit) => string = "lookup"
  @module("node:dns")
  external lookupWithOptions: (string, lookupOptions, (Js.Exn.t, string, int) => unit) => string =
    "lookup"
  @module("node:dns")
  external getServers: unit => array<string> = "getServers"
  @module("node:dns")
  external resolveAny: (string, (Js.Exn.t, array<{..}>) => unit) => unit = "resolveAny"
  @module("node:dns")
  external resolve4: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolve4"
  @module("node:dns")
  external resolve4TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (Js.Exn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve4"
  @module("node:dns")
  external resolve6: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolve6"
  @module("node:dns")
  external resolve6TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (Js.Exn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve6"
  @module("node:dns")
  external resolveCname: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolveCname"
  @module("node:dns")
  external resolveMx: (string, (Js.Exn.t, array<{"exchange": string, "priority": int}>)) => unit =
    "resolveMx"
  @module("node:dns")
  external resolveNaptr: (
    string,
    (
      Js.Exn.t,
      array<{
        "flags": string,
        "service": string,
        "regexp": string,
        "replacement": string,
        "order": int,
        "preference": int,
      }>,
    ) => unit,
  ) => unit = "resolveNaptr"
  @module("node:dns")
  external resolveNs: (string, (Js.Exn.t, array<string>)) => unit = "resolveNs"
  @module("node:dns")
  external resolvePtr: (string, (Js.Exn.t, array<string>)) => unit = "resolvePtr"
  @module("node:dns")
  external resolveSoa: (
    string,
    (
      Js.Exn.t,
      {
        "nsname": string,
        "hostmaster": string,
        "serial": float,
        "refresh": int,
        "retry": int,
        "expire": int,
        "minttl": int,
      },
    ) => unit,
  ) => unit = "resolveSoa"
  @module("node:dns")
  external resolveSrv: (
    string,
    (Js.Exn.t, array<{"priority": int, "weight": int, "port": int, "name": string}>) => unit,
  ) => unit = "resolveSrv"
  @module("node:dns")
  external resolveTxt: (string, (Js.Exn.t, array<array<string>>)) => unit = "resolveTxt"
  @module("node:dns")
  external reverse: (string, (Js.Exn.t, array<string>) => unit) => unit = "reverse"
  @module("node:dns")
  external setServers: array<string> => unit = "setServers"
}

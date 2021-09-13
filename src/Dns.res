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
@module("dns") @scope("promise")
external lookupWithOptions: (
  string,
  lookupOptions,
) => Js.Promise.t<array<{"address": string, "family": int}>> = "lookup"
@module("dns") @scope("promise")
external lookupService: (string, int) => Js.Promise.t<{"hostname": string, "service": string}> =
  "lookupService"
@module("dns") @scope("promise")
external resolve4: string => Js.Promise.t<array<string>> = "resolve4"
@module("dns") @scope("promise")
external resolve4TTL: (string, @as(json` {"ttl": true} `) _) => Js.Promise.t<array<string>> =
  "resolve4"
@module("dns") @scope("promise")
external resolve6: string => Js.Promise.t<array<string>> = "resolve6"
@module("dns") @scope("promise")
external resolve6TTL: (string, @as(json` {"ttl": true} `) _) => Js.Promise.t<array<string>> =
  "resolve6"
@module("dns") @scope("promise")
external resolveAny: string => Js.Promise.t<array<{..}>> = "resolveAny"
@module("dns") @scope("promise")
external resolveCname: string => Js.Promise.t<array<string>> = "resolveCname"
@module("dns") @scope("promise")
external resolveMx: string => Js.Promise.t<array<{"priority": int, "exchange": string}>> =
  "resolveMx"
@module("dns") @scope("promise")
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
@module("dns") @scope("promise")
external resolveNs: string => Js.Promise.t<array<string>> = "resolveNs"
@module("dns") @scope("promise")
external resolvePtr: string => Js.Promise.t<array<string>> = "resolvePtr"
@module("dns") @scope("promise")
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

@module("dns") @scope("promise")
external resolveSrv: string => Js.Promise.t<
  array<{
    "priority": int,
    "weight": int,
    "port": int,
    "name": string,
  }>,
> = "resolveSrv"
@module("dns") @scope("promise")
external resolveTxt: string => Js.Promise.t<array<array<string>>> = "resolveTxt"
@module("dns") @scope("promise")
external reverse: string => Js.Promise.t<array<string>> = "reverse"
@module("dns") @scope("promise")
external setServers: array<string> => Js.Promise.t<unit> = "setServers"

module CallbackAPI = {
  @module("dns")
  external lookup: (string, (Js.Exn.t, string, int) => unit) => string = "lookup"
  @module("dns")
  external lookupWithOptions: (string, lookupOptions, (Js.Exn.t, string, int) => unit) => string =
    "lookup"
  @module("dns")
  external getServers: unit => array<string> = "getServers"
  @module("dns")
  external resolveAny: (string, (Js.Exn.t, array<{..}>) => unit) => unit = "resolveAny"
  @module("dns")
  external resolve4: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolve4"
  @module("dns")
  external resolve4TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (Js.Exn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve4"
  @module("dns")
  external resolve6: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolve6"
  @module("dns")
  external resolve6TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (Js.Exn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve6"
  @module("dns")
  external resolveCname: (string, (Js.Exn.t, array<string>) => unit) => unit = "resolveCname"
  @module("dns")
  external resolveMx: (string, (Js.Exn.t, array<{"exchange": string, "priority": int}>)) => unit =
    "resolveMx"
  @module("dns")
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
  @module("dns")
  external resolveNs: (string, (Js.Exn.t, array<string>)) => unit = "resolveNs"
  @module("dns")
  external resolvePtr: (string, (Js.Exn.t, array<string>)) => unit = "resolvePtr"
  @module("dns")
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
  @module("dns")
  external resolveSrv: (
    string,
    (Js.Exn.t, array<{"priority": int, "weight": int, "port": int, "name": string}>) => unit,
  ) => unit = "resolveSrv"
  @module("dns")
  external resolveTxt: (string, (Js.Exn.t, array<array<string>>)) => unit = "resolveTxt"
  @module("dns")
  external reverse: (string, (Js.Exn.t, array<string>) => unit) => unit = "reverse"
  @module("dns")
  external setServers: array<string> => unit = "setServers"
}

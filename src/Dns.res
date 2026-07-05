type options = {
  family?: int,
  hints?: int,
  all?: bool,
  verbatim?: bool,
}
@module("dns") @scope("promise")
external lookup: string => promise<array<{"address": string, "family": int}>> = "lookup"
@module("node:dns") @scope("promise")
external lookupWithOptions: (
  string,
  options,
) => promise<array<{"address": string, "family": int}>> = "lookup"
@module("node:dns") @scope("promise")
external lookupService: (string, int) => promise<{"hostname": string, "service": string}> =
  "lookupService"
@module("node:dns") @scope("promise")
external resolve4: string => promise<array<string>> = "resolve4"
@module("node:dns") @scope("promise")
external resolve4TTL: (string, @as(json` {"ttl": true} `) _) => promise<array<string>> = "resolve4"
@module("node:dns") @scope("promise")
external resolve6: string => promise<array<string>> = "resolve6"
@module("node:dns") @scope("promise")
external resolve6TTL: (string, @as(json` {"ttl": true} `) _) => promise<array<string>> = "resolve6"
@module("node:dns") @scope("promise")
external resolveAny: string => promise<array<{..}>> = "resolveAny"
@module("node:dns") @scope("promise")
external resolveCname: string => promise<array<string>> = "resolveCname"
@module("node:dns") @scope("promise")
external resolveMx: string => promise<array<{"priority": int, "exchange": string}>> = "resolveMx"
@module("node:dns") @scope("promise")
external resolveNaptr: string => promise<
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
external resolveNs: string => promise<array<string>> = "resolveNs"
@module("node:dns") @scope("promise")
external resolvePtr: string => promise<array<string>> = "resolvePtr"
@module("node:dns") @scope("promise")
external resolveSoa: string => promise<
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
external resolveSrv: string => promise<
  array<{
    "priority": int,
    "weight": int,
    "port": int,
    "name": string,
  }>,
> = "resolveSrv"
@module("node:dns") @scope("promise")
external resolveTxt: string => promise<array<array<string>>> = "resolveTxt"
@module("node:dns") @scope("promise")
external reverse: string => promise<array<string>> = "reverse"
@module("node:dns") @scope("promise")
external setServers: array<string> => promise<unit> = "setServers"

module CallbackAPI = {
  @module("node:dns")
  external lookup: (string, (JsExn.t, string, int) => unit) => string = "lookup"
  @module("node:dns")
  external lookupWithOptions: (string, options, (JsExn.t, string, int) => unit) => string = "lookup"
  @module("node:dns")
  external getServers: unit => array<string> = "getServers"
  @module("node:dns")
  external resolveAny: (string, (JsExn.t, array<{..}>) => unit) => unit = "resolveAny"
  @module("node:dns")
  external resolve4: (string, (JsExn.t, array<string>) => unit) => unit = "resolve4"
  @module("node:dns")
  external resolve4TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (JsExn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve4"
  @module("node:dns")
  external resolve6: (string, (JsExn.t, array<string>) => unit) => unit = "resolve6"
  @module("node:dns")
  external resolve6TTL: (
    string,
    @as(json` {"ttl": true} `) _,
    (JsExn.t, array<{"address": string, "ttl": int}>) => unit,
  ) => unit = "resolve6"
  @module("node:dns")
  external resolveCname: (string, (JsExn.t, array<string>) => unit) => unit = "resolveCname"
  @module("node:dns")
  external resolveMx: (string, (JsExn.t, array<{"exchange": string, "priority": int}>)) => unit =
    "resolveMx"
  @module("node:dns")
  external resolveNaptr: (
    string,
    (
      JsExn.t,
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
  external resolveNs: (string, (JsExn.t, array<string>)) => unit = "resolveNs"
  @module("node:dns")
  external resolvePtr: (string, (JsExn.t, array<string>)) => unit = "resolvePtr"
  @module("node:dns")
  external resolveSoa: (
    string,
    (
      JsExn.t,
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
    (JsExn.t, array<{"priority": int, "weight": int, "port": int, "name": string}>) => unit,
  ) => unit = "resolveSrv"
  @module("node:dns")
  external resolveTxt: (string, (JsExn.t, array<array<string>>)) => unit = "resolveTxt"
  @module("node:dns")
  external reverse: (string, (JsExn.t, array<string>) => unit) => unit = "reverse"
  @module("node:dns")
  external setServers: array<string> => unit = "setServers"
}

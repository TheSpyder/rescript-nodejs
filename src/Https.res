type https = [#Https]

module HttpsServer = {
  type kind = [Tls.TlsServer.kind | https]
  type subtype<'a> = Net.Server.subtype<[> kind] as 'a>
  type supertype<'a> = Net.Server.subtype<[< kind] as 'a>
  type t = subtype<kind>
  module Events = {
    include Tls.TlsServer.Events
  }
  module Impl = {
    include Tls.TlsServer.Impl
    include Events
  }
  include Impl
}

module Agent = {
  type t
  module Events = {
    @send
    external onKeylog: (t, @as("keylog") _, @uncurry (Buffer.t, Tls.TlsSocket.t) => unit) => t =
      "on"
    @send
    external onKeylogOnce: (t, @as("keylog") _, @uncurry (Buffer.t, Tls.TlsSocket.t) => unit) => t =
      "once"
    @send
    external offKeylog: (t, @as("keylog") _, @uncurry (Buffer.t, Tls.TlsSocket.t) => unit) => t =
      "off"
  }
  include Events
}

@module("node:https") external request: string => Http.ClientRequest.t = "request"
@module("node:https")
external requestWithCallback: (string, Http.IncomingMessage.t => unit) => Http.ClientRequest.t =
  "request"
@module("node:https")
external requestWithOptions: (string, Http.requestOptions) => Http.ClientRequest.t = "request"
@module("node:https")
external requestWithOptionsCallback: (
  string,
  Http.requestOptions,
  Http.IncomingMessage.t => unit,
) => Http.ClientRequest.t = "request"
@module("node:https") external requestUrl: Url.t => Http.ClientRequest.t = "request"
@module("node:https")
external requestUrlWithCallback: (Url.t, Http.IncomingMessage.t => unit) => Http.ClientRequest.t =
  "request"
@module("node:https")
external requestUrlWithOptions: (Url.t, Http.requestOptions) => Http.ClientRequest.t = "request"
@module("node:https")
external requestUrlWithOptionsCallback: (
  Url.t,
  Http.requestOptions,
  Http.IncomingMessage.t => unit,
) => Http.ClientRequest.t = "request"

@module("node:https") external get: string => Http.ClientRequest.t = "get"
@module("node:https")
external getWithCallback: (string, Http.IncomingMessage.t => unit) => Http.ClientRequest.t = "get"
@module("node:https")
external getWithOptions: (string, Http.requestOptions) => Http.ClientRequest.t = "get"
@module("node:https")
external getWithOptionsCallback: (
  string,
  Http.requestOptions,
  Http.IncomingMessage.t => unit,
) => Http.ClientRequest.t = "get"

@module("node:https") external getUrl: Url.t => Http.ClientRequest.t = "get"
@module("node:https")
external getUrlWithCallback: (Url.t, Http.IncomingMessage.t => unit) => Http.ClientRequest.t = "get"
@module("node:https")
external getUrlWithOptions: (Url.t, Http.requestOptions) => Http.ClientRequest.t = "get"
@module("node:https")
external getUrlWithOptionsCallback: (
  Url.t,
  Http.requestOptions,
  Http.IncomingMessage.t => unit,
) => Http.ClientRequest.t = "get"

@module("node:https") external globalAgent: Agent.t = "globalAgent"
@module("node:https") external maxHeaderSize: int = "maxHeaderSize"

type statusCodes = Js.Dict.t<string>
@module("node:https") external _STATUS_CODES: statusCodes = "STATUS_CODES"

type methods = array<string>
@module("node:https") external _METHODS: methods = "METHODS"

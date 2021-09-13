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

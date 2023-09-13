@ocaml.doc("
 * UNDER CONSTRUCTION - API UNSTABLE
 ")
module // TODO: Consider alternative implementation of KeyObject subtype.
KeyObject = {
  type t<'a, 'b>
  type symmetric = [#Symmetric]
  type asymmetric = [#Asymmetric]
  type publicKey = [#PublicKey]
  type privateKey = [#PrivateKey]
  type secretKey = [#SecretKey]
  @send
  external symmetricExport: t<symmetric, [< publicKey | privateKey]> => Buffer.t = "export"
  @send
  external asymmetricExport: t<asymmetric, [< publicKey | privateKey | secretKey]> => Buffer.t =
    "export"
  module Symmetric = {
    type kind = [symmetric]
    type t<'a> = t<[kind], 'a>
    module Impl = {}
  }
  module Asymmetric = {
    type kind = [asymmetric]
    type t<'a> = t<[kind], 'a>
    module Impl = {}
  }
  module Impl = {
    include Symmetric.Impl
    include Asymmetric.Impl
  }
  include Impl
}

module PivateKey = {
  include KeyObject.Impl
  type kind = [KeyObject.privateKey]
  type t<'a> = KeyObject.t<'a, [kind]>
  @module("node:crypto") external make: Buffer.t => t<'a> = "createPrivateKey"
  @module("node:crypto")
  external makeWithPassphrase: {.."key": Buffer.t, "passphrase": Buffer.t} => t<'a> =
    "createPrivateKey"
}

module PublicKey = {
  include KeyObject.Impl
  type kind = [KeyObject.publicKey]
  type t<'a> = KeyObject.t<'a, [kind]>
  @module("node:crypto") external make: Buffer.t => t<'a> = "createPublicKey"
  @module("node:crypto")
  external fromPrivateKey: KeyObject.t<'a, [> KeyObject.privateKey]> => t<'a> = "createPublicKey"
}

module Hash = {
  type kind<'w, 'r> = [Stream.transform<'w, 'r> | #Hash]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Impl = {
    include Stream.Transform.Impl
    @send external copy: t => t = "copy"
    @send external digest: t => Buffer.t = "digest"
    @send external update: (t, Buffer.t) => unit = "update"
  }
  include Impl
}

@module("node:crypto") external createHash: string => Hash.t = "createHash"

module Hmac = {
  type kind<'w, 'r> = [Stream.transform<'w, 'r> | #Hmac]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = subtype<Buffer.t, Buffer.t, kind<'w, 'r>>
  module Impl = {
    include Stream.Transform.Impl
    @send external digest: t => Buffer.t = "digest"
    @send external update: (t, Buffer.t) => unit = "update"
  }
  include Impl
}

@module("node:crypto")
external createHmac: (string, ~key: string) => Hmac.t = "createHmac"

module Certificate = {
  type t
  @send
  external exportChallenge: (t, Buffer.t) => Buffer.t = "exportChallenge"
  @send
  external exportPublicKey: (t, Buffer.t) => Buffer.t = "exportPublicKey"
  @send
  external verifyCertificate: (t, Buffer.t) => bool = "verifyCertificate"
}

module Cipher = {
  type kind<'w, 'r> = [Stream.transform<'w, 'r> | #Cipher]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Impl = {
    include Stream.Transform.Impl
    @send external final: (t, string) => Buffer.t = "final"
    @send external setAAD: (t, Buffer.t) => t = "setAAD"
    @send
    external setAADWith: (
      t,
      Buffer.t,
      ~options: Stream.Transform.makeOptions<Buffer.t, Buffer.t>,
    ) => t = "setAAD"
    @send external getAuthTag: t => Buffer.t = "getAuthTag"
    @send external setAutoPadding: (t, bool) => t = "setAutoPadding"
    @send external update: (t, Buffer.t) => Buffer.t = "update"
  }
  include Impl
  @module("node:crypto")
  external make: (
    ~algorithm: string,
    ~key: KeyObject.t<'a, [> KeyObject.secretKey]>,
    ~iv: Js.Null.t<Buffer.t>,
  ) => t = "createCipheriv"
  @module("node:crypto")
  external makeWith: (
    ~algorithm: string,
    ~key: KeyObject.t<'a, [> KeyObject.secretKey]>,
    ~iv: Js.Null.t<Buffer.t>,
    ~options: Stream.Transform.makeOptions<Buffer.t, Buffer.t>=?,
  ) => t = "createCipheriv"
}

module Decipher = {
  type kind<'w, 'r> = [Stream.transform<'w, 'r> | #Decipher]
  type subtype<'w, 'r, 'a> = Stream.subtype<[> kind<'w, 'r>] as 'a>
  type supertype<'w, 'r, 'a> = Stream.subtype<[< kind<'w, 'r>] as 'a>
  type t = Stream.subtype<kind<Buffer.t, Buffer.t>>
  module Impl = {
    @send
    external final: (subtype<'w, 'r, 'a>, string) => Buffer.t = "final"
    @send
    external setAAD: (subtype<'w, 'r, 'a>, Buffer.t) => t = "setAAD"
    @send
    external setAADWith: (
      subtype<'w, 'r, 'a>,
      Buffer.t,
      ~options: Stream.Transform.makeOptions<Buffer.t, Buffer.t>,
    ) => t = "setAAD"
    @send
    external setAuthTag: (subtype<'w, 'r, 'a>, Buffer.t) => t = "setAuthTag"
    @send
    external setAutoPatting: (subtype<'w, 'r, 'a>, bool) => t = "setAutoPadding"
    @send
    external update: (subtype<'w, 'r, 'a>, Buffer.t) => Buffer.t = "update"
  }
  include Impl
  @module("node:crypto")
  external make: (
    ~algorithm: string,
    ~key: KeyObject.t<'a, [> KeyObject.secretKey]>,
    ~iv: Js.Null.t<Buffer.t>,
  ) => t = "createDecipheriv"
  @module("node:crypto")
  external makeWith: (
    ~algorithm: string,
    ~key: KeyObject.t<'a, [> KeyObject.secretKey]>,
    ~iv: Js.Null.t<Buffer.t>,
    ~options: Stream.Transform.makeOptions<Buffer.t, Buffer.t>=?,
  ) => t = "createDecipheriv"
} /* } */ /* } */ /* module Verify = */

// module DiffieHellman = {

// };

// module DiffieHellmanGroup = {

// };

// module Sign = {

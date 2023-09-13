@module("node:zlib") external deflateRawSync: Buffer.t => Buffer.t = "deflateRawSync"
@module("node:zlib") external deflateRaw: (Buffer.t, (. Buffer.t) => unit) => unit = "deflateRaw"
@module("node:zlib") external inflateRawSync: Buffer.t => Buffer.t = "inflateRawSync"
@module("node:zlib") external inflateRaw: (Buffer.t, (. Buffer.t) => unit) => unit = "inflateRaw"

@module("zlib") external deflateRawSync: Buffer.t => Buffer.t = "deflateRawSync"
@module("zlib") external deflateRaw: (Buffer.t, (. Buffer.t) => unit) => unit = "deflateRaw"
@module("zlib") external inflateRawSync: Buffer.t => Buffer.t = "inflateRawSync"
@module("zlib") external inflateRaw: (Buffer.t, (. Buffer.t) => unit) => unit = "inflateRaw"

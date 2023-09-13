@module("node:assert") external ok: 'a => unit = "ok"
@module("node:assert") external equal: ('a, 'a) => unit = "equal"
@module("node:assert") external notEqual: ('a, 'a) => unit = "notEqual"
@module("node:assert") external deepEqual: ('a, 'a) => unit = "deepEqual"
@module("node:assert") external notDeepEqual: ('a, 'a) => unit = "notDeepEqual"
@module("node:assert") external strictEqual: ('a, 'a) => unit = "strictEqual"
@module("node:assert")
external notStrictEqual: ('a, 'a) => unit = "notStrictEqual"
@module("node:assert")
external deepStrictEqual: ('a, 'a) => unit = "deepStrictEqual"
@module("node:assert")
external notDeepStrictEqual: ('a, 'a) => unit = "notDeepStrictEqual"
@module("node:assert")
external throws: (@uncurry (unit => 'a)) => unit = "throws"
@module("node:assert")
external throwsError: (@uncurry (unit => 'a), 'e) => unit = "throws"
@module("node:assert")
external doesNotThrow: (@uncurry (unit => 'a)) => unit = "doesNotThrow"
@module("node:assert")
external doesNotThrowError: (@uncurry (unit => 'a), 'e) => unit = "doesNotThrow"
@module("node:assert") external ifError: 'a => unit = "ifError"
@module("node:assert")
external rejects: (@uncurry (unit => Js.Promise.t<'a>)) => unit = "rejects"
@module("node:assert")
external rejectsError: (@uncurry (unit => Js.Promise.t<'a>), 'e) => unit = "rejects"
@module("node:assert")
external doesNotReject: (@uncurry (unit => Js.Promise.t<'a>)) => unit = "doesNotReject"
@module("node:assert")
external doesNotRejectError: (@uncurry (unit => Js.Promise.t<'a>), 'e) => unit = "doesNotReject"

module AssertionError = Errors.AssertionError

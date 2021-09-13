@module("assert") external ok: 'a => unit = "ok"
@module("assert") external equal: ('a, 'a) => unit = "equal"
@module("assert") external notEqual: ('a, 'a) => unit = "notEqual"
@module("assert") external deepEqual: ('a, 'a) => unit = "deepEqual"
@module("assert") external notDeepEqual: ('a, 'a) => unit = "notDeepEqual"
@module("assert") external strictEqual: ('a, 'a) => unit = "strictEqual"
@module("assert")
external notStrictEqual: ('a, 'a) => unit = "notStrictEqual"
@module("assert")
external deepStrictEqual: ('a, 'a) => unit = "deepStrictEqual"
@module("assert")
external notDeepStrictEqual: ('a, 'a) => unit = "notDeepStrictEqual"
@module("assert")
external throws: (@uncurry (unit => 'a)) => unit = "throws"
@module("assert")
external throwsError: (@uncurry (unit => 'a), 'e) => unit = "throws"
@module("assert")
external doesNotThrow: (@uncurry (unit => 'a)) => unit = "doesNotThrow"
@module("assert")
external doesNotThrowError: (@uncurry (unit => 'a), 'e) => unit = "doesNotThrow"
@module("assert") external ifError: 'a => unit = "ifError"
@module("assert")
external rejects: (@uncurry (unit => Js.Promise.t<'a>)) => unit = "rejects"
@module("assert")
external rejectsError: (@uncurry (unit => Js.Promise.t<'a>), 'e) => unit = "rejects"
@module("assert")
external doesNotReject: (@uncurry (unit => Js.Promise.t<'a>)) => unit = "doesNotReject"
@module("assert")
external doesNotRejectError: (@uncurry (unit => Js.Promise.t<'a>), 'e) => unit = "doesNotReject"

module AssertionError = Errors.AssertionError

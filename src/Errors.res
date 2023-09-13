@val @scope("Error")
external captureStackTrace: {..} => unit = "captureStackTrace"
@val @scope("Error")
external stackTraceLimit: int = "captureStackTrace"
%%raw(`
  function setStackTraceLimit(n) {
    Error.stackTraceLimit = n;
    return undefined;
  }
`)
@val
external setStackTraceLimit: int => Js.Undefined.t<'a> = "setStackTraceLimit"
let setStackTraceLimit: int => unit = n => setStackTraceLimit(n)->ignore

module Error = {
  type t = exn
  type constructor
  @val external constructor: constructor = "Error"
  @new external make: string => t = "Error"
  @get external name: t => string = "name"
  @get external code: t => string = "code"
  @get external message: t => string = "message"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "Error" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isError(exn) ? Some(fromJsExn(exn)) : None
}

module AssertionError = {
  type t = exn
  type constructor
  type makeOptions
  @obj
  external makeOptions: (
    ~message: string=?,
    ~actual: 'actual=?,
    ~expected: 'expected=?,
    ~operator: string=?,
    ~stackStartFn: 'a => 'b=?,
    unit,
  ) => makeOptions = ""
  @module("node:assert") external constructor: constructor = "AssertionError"
  @module("node:assert") @new
  external make: makeOptions => t = "AssertionError"
  @get external actual: t => 'a = "actual"
  @get external expected: t => 'a = "expected"
  @get external generatedMessage: t => bool = "generatedMessage"
  @get external code: t => string = "code"
  @get external name: t => string = "name"
  @get external message: t => string = "message"
  @get external operator: t => string = "operator"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isAssertionError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "AssertionError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isAssertionError(exn) ? Some(fromJsExn(exn)) : None
}

module EvalError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "EvalError"
  @new external make: string => t = "EvalError"
  @get external message: t => string = "message"
  @get external name: t => string = "name"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isEvalError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "EvalError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isEvalError(exn) ? Some(fromJsExn(exn)) : None
}

module RangeError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "RangeError"
  @new external make: string => t = "RangeError"
  @get external name: t => string = "name"
  @get external code: t => string = "code"
  @get external message: t => string = "message"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isRangeError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "RangeError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isRangeError(exn) ? Some(fromJsExn(exn)) : None
}

module ReferenceError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "ReferenceError"
  @new external make: string => t = "ReferenceError"
  @get external name: t => string = "name"
  @get external code: t => string = "code"
  @get external message: t => string = "message"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isReferenceError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "ReferenceError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isReferenceError(exn) ? Some(fromJsExn(exn)) : None
}

module SyntaxError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "SyntaxError"
  @new external make: string => t = "SyntaxError"
  @get external name: t => string = "name"
  @get external code: t => string = "code"
  @get external message: t => string = "message"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isSyntaxError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "SyntaxError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isSyntaxError(exn) ? Some(fromJsExn(exn)) : None
}

// It's not clear that SystemError works as expressed in the Node API.
// `SystemError` is an undefined identifier at runtime.

module SystemError = {
  type t = exn
  @get external name: t => string = "name"
  @get @return(nullable)
  external address: t => option<string> = "address"
  @get external code: t => string = "code"
  @get @return(nullable) external dest: t => option<string> = "dest"
  @get external errno: t => int = "errno"
  @get @return(nullable)
  external info: t => option<{..}> = "info"
  @get external message: t => string = "message"
  @get @return(nullable) external path: t => option<string> = "path"
  @get @return(nullable) external port: t => option<int> = "port"
  @get @return(nullable)
  external stack: t => option<string> = "stack"
  @get external syscall: t => string = "syscall"
}

module TypeError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "TypeError"
  @new external make: string => t = "TypeError"
  @get external name: t => string = "name"
  @get external code: t => string = "code"
  @get external message: t => string = "message"
  @get external stack: t => string = "stack"
  external toJsExn: t => Js.Exn.t = "%identity"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isTypeError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "TypeError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isTypeError(exn) ? Some(fromJsExn(exn)) : None
}

module URIError = {
  type t = exn
  type constructor
  @val external constructor: constructor = "URIError"
  @new external make: string => t = "URIError"
  @get external message: t => string = "message"
  @get external name: t => string = "name"
  @get external stack: t => string = "stack"
  let instanceOf = x => Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  let isURIError: Js.Exn.t => bool = x =>
    Internal__JsTypeReflection.constructorName(x) == "URIError" &&
      Internal__JsTypeReflection.instanceOfClass(~instance=x, ~class_=constructor)
  external toJsExn: t => Js.Exn.t = "%identity"
  external fromJsExn: Js.Exn.t => t = "%identity"
  let fromJsExn: Js.Exn.t => option<t> = exn => isURIError(exn) ? Some(fromJsExn(exn)) : None
}

type case =
  | Error(Error.t)
  | AssertionError(AssertionError.t)
  | EvalError(EvalError.t)
  | RangeError(RangeError.t)
  | ReferenceError(ReferenceError.t)
  | SyntaxError(SyntaxError.t)
  | TypeError(TypeError.t)
  | URIError(URIError.t)

let classifyOpt: Js.Exn.t => option<case> = value =>
  if AssertionError.isAssertionError(value) {
    Some(AssertionError(Obj.magic(value)))
  } else if EvalError.isEvalError(value) {
    Some(EvalError(Obj.magic(value)))
  } else if RangeError.isRangeError(value) {
    Some(RangeError(Obj.magic(value)))
  } else if ReferenceError.isReferenceError(value) {
    Some(ReferenceError(Obj.magic(value)))
  } else if SyntaxError.isSyntaxError(value) {
    Some(SyntaxError(Obj.magic(value)))
  } else if TypeError.isTypeError(value) {
    Some(TypeError(Obj.magic(value)))
  } else if URIError.isURIError(value) {
    Some(URIError(Obj.magic(value)))
  } else if Error.isError(value) {
    Some(Error(Obj.magic(value)))
  } else {
    None
  }

let classifyExn: Js.Exn.t => case = value =>
  switch classifyOpt(value) {
  | None => failwith("Unknown data type")
  | Some(err) => err
  }

let classify: Js.Exn.t => Belt.Result.t<case, 'a> = value =>
  switch classifyOpt(value) {
  | None => Error(value)
  | Some(err) => Ok(err)
  }

module ErrorCodes = {}

@ocaml.doc("
 * The `Event` type represents the strings/symbols used in Node to
 * identify event types for `EventEmitter` and its subclasses, including
 * streams, sockets, and servers.
 * 
 * Given a type signature `Event.t('a => 'b, 'ty)`, the first type
 * variable, `'a => 'b`, denotes the type signature of the event listener
 * function, and `'ty` denotes the type of the associated `EventEmitter`.
 * 
 * These abstract `Event.t` types must be passed to `EventEmitter`
 * functions to register event listeners or emit events. By encoding the
 * listener function type in a type variable, we can ensure that each
 * listener has the correct type. The type parameter for the emitter
 * prevents two different emitters from using each other's events.
 * 
 * While this gives us some degree of type safety, it is still possible
 * to introduce runtime errors with this API. In particular, two or more
 * `Event.t` types can be defined from the same string/symbol, but with
 * different listener types. Therefore, we strongly recommend using
 * 100% unique strings/symbols to define events.
 * 
 ")
type t<'listener, 'ty>
external fromString: string => t<'a => 'b, 'ty> = "%identity"
external fromString2: string => t<('a, 'b) => 'c, 'ty> = "%identity"
external fromString3: string => t<('a, 'b, 'c) => 'd, 'ty> = "%identity"
external fromSymbol: Js.Types.symbol => t<'a => 'b, 'ty> = "%identity"
external fromSymbol2: Js.Types.symbol => t<('a, 'b) => 'c, 'ty> = "%identity"
external fromSymbol3: Js.Types.symbol => t<('a, 'b, 'c) => 'd, 'ty> = "%identity"
external unsafeToString: t<'a => 'b, 'ty> => string = "%identity"
external unsafeToString2: t<('a, 'b) => 'c, 'ty> => string = "%identity"
external unsafeToString3: t<('a, 'b, 'c) => 'd, 'ty> => string = "%identity"
external unsafeToSymbol: t<'a => 'b, 'ty> => Js.Types.symbol = "%identity"
external unsafeToSymbol2: t<('a, 'b) => 'c, 'ty> => Js.Types.symbol = "%identity"
external unsafeToSymbol3: t<('a, 'b, 'c) => 'd, 'ty> => Js.Types.symbol = "%identity"
type case =
  | String(string)
  | Symbol(Js.Types.symbol)
  | Unknown
let classify = evt =>
  switch Js.typeof(evt) {
  | "string" => String(unsafeToString(evt))
  | "symbol" => Symbol(unsafeToSymbol(evt))
  | _ => Unknown
  }
let eq = (event1, event2) =>
  switch (Js.typeof(event1), Js.typeof(event2)) {
  | ("string", "string") => Obj.magic(event1) === Obj.magic(event2)
  | ("symbol", "symbol") => Obj.magic(event1) === Obj.magic(event2)
  | _ => false
  }
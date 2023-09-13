@ocaml.doc("
 * `Impl` is a functor which generates FFI bindings to Node's `EventEmitter`
 * class for any type `t`. This is not inherently type-safe. Type-safety can
 * be achieved by implementing the known `Event.t('a => 'b, t)` types
 ")
module Impl = (
  T: {
    type t
  },
) => {
  @ocaml.doc("
   * `addListener(emitter, event, listener)`
   *
   * Adds a new event listener function to the event emitter.
   ")
  @send
  external addListener: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "addListener"

  @send
  external emit: (T.t, Event.t<'a => 'b, T.t>, 'a) => bool = "emit"

  @get external errorMonitor: T.t => Js.Types.symbol = "errorMonitor"

  @send
  external eventNames: (T.t, Event.t<'a => 'b, T.t>) => array<Event.t<'a => 'b, T.t>> = "eventNames"

  @send external getMaxListeners: T.t => int = "getMaxListeners"

  @send
  external listenerCount: (T.t, Event.t<'a => 'b, T.t>) => int = "listenerCount"
  @send
  external listeners: (T.t, Event.t<'a => 'b, T.t>) => array<'a => 'b> = "listeners"

  @ocaml.doc("
   * `on(emitter, event, listener)`
   *
   * Adds a new event listener function to the event emitter.
   * Alias for `addListener`.
   ")
  @send
  external on: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "on"

  @ocaml.doc("
   * `once(emitter, event, listener)`
   *
   * Adds a new **single-use** event listener function to the event
   * emitter. Then next time the given event is emitted, this listener
   * will fire exactly once, and then be removed from the emitter's
   * internal listener array.
   ")
  @send
  external once: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "once"

  @ocaml.doc("
   * `off(emitter, event, listener)`
   *
   * Removes the listener function from the event emitter.
   *
   * The specified listener function is compared by **referential
   * equality** to each function in the emitter's internal listener
   * array.
   *
   * This means that, when the target listener is initially added, that
   * exact function reference must be maintained and provided here
   * in order to ensure removal.
   *
   * Alias for `removeListener`.
   ")
  @send
  external off: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "off"

  @ocaml.doc("
   * `prependListener(emitter, event, listener)`
   *
   * Adds a new event listener function to the event emitter.
   *
   * Unlike `on` and `addListener`, `prependListener` adds the listener
   * function to the front of the internal listener array, ensuring
   * that this function is called before the rest of the listeners for
   * the given event.
   ")
  @send
  external prependListener: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "prependListener"

  @ocaml.doc("
   * `prependListenerOnce(emitter, event, listener)`
   *
   * Adds a new **single-use** event listener function to the event
   * emitter. Then next time the given event is emitted, this listener
   * will fire exactly once, and then be removed from the emitter's
   * internal listener array.
   *
   * Unlike `once`, `prependListenerOnce` adds the listener function
   * to the front of the internal listener array, ensuring that this
   * function is called before the rest of the listeners for the
   * given event.
   ")
  @send
  external prependOnceListener: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t =
    "prependOnceListener"

  @send external removeAllListeners: T.t => T.t = "removeAllListeners"

  @ocaml.doc("
   * `removeListener(emitter, event, listener)`
   *
   * Removes the listener function from the event emitter.
   *
   * The specified listener function is compared by **referential
   * equality** to each function in the emitter's internal listener
   * array.
   *
   * This means that, when the target listener is initially added, that
   * exact function reference must be maintained and provided here
   * in order to ensure removal.
   ")
  @send
  external removeListener: (T.t, Event.t<'a => 'b, T.t>, 'a => 'b) => T.t = "removeListener"

  @ocaml.doc("
   * `setMaxListeners(emitter, numberOfListeners)`
   *
   * Sets the maximum number of event listeners that may be added to
   * an event emitter before Node begins emitting warnings.
   *
   * By default, each event emitter has this value set to 10. This is
   * intended to warn the user about possible memory leaks.
   * `setMaxListeners` will increase this threshold.
   ")
  @send
  external setMaxListeners: (T.t, int) => T.t = "setMaxListeners"
}

@ocaml.doc("
 * A generative functor that creates a unique type `t` with the `EventEmitter`
 * interface bindings.
")
module Make = () => {
  type t
  include Impl({
    type t = t
  })
  @module("node:events") @new external make: unit => t = "EventEmitter"
}

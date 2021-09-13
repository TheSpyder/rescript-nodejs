open Zora
open EventEmitterTestLib

zoraBlock("EventEmitter", t => {
  t->notEqual(
    Emitter1.make()->Js.Undefined.return,
    Js.Undefined.empty,
    "'Emitter.make' should create a new emitter instance that is defined",
  )

  t->equal(
    {
      open Emitter1
      make()->addListener(Events.text, _ => ())->listeners(Events.text)
    }->Array.length,
    1,
    "'Emitter.addListener' should add a new event listener",
  )

  t->equal(
    {
      open Emitter1
      make()->on(Events.text, _ => ())->listeners(Events.text)
    }->Array.length,
    1,
    "'Emitter.on' should add a new event listener",
  )

  t->equal(
    {
      open Emitter1
      make()->on(Events.text, _ => ())->listeners(Events.text)
    }->Array.length,
    1,
    "'Emitter.on' should add a new event listener",
  )

  t->block("'Emitter.removeListener' should remove the event listener", t => {
    let eventListener = _ => ()
    let listeners = {
      open Emitter1
      make()
      |> on(_, Events.text, eventListener)
      |> removeListener(_, Events.text, eventListener)
      |> listeners(_, Events.text)
    }
    t->equal(Array.length(listeners), 0, "")
  })

  t->block("'Emitter.off' should remove the event listener", t => {
    let eventListener = _ => ()
    let listeners = {
      open Emitter1
      make()
      |> on(_, Events.text, eventListener)
      |> off(_, Events.text, eventListener)
      |> listeners(_, Events.text)
    }
    t->equal(Array.length(listeners), 0, "")
  })

  t->block("'Emitter.emit' should execute each listener for the correct event", t => {
    let ref1 = ref(0)
    let ref2 = ref(0)
    let data1 = 1
    let data2 = 2
    let listener1 = _ => ref1 := data1
    let listener2 = _ => ref2 := data2

    {
      open Emitter1
      let emitter = make() |> on(_, Events.integer, listener1) |> on(_, Events.integer, listener2)
      emit(emitter, Events.integer, data1)->ignore
      emit(emitter, Events.integer, data2)->ignore
    }

    t->equal(ref1.contents, 1, "")
    t->equal(ref2.contents, 2, "")
  })

  t->block("'Emitter.removeAllListeners' should remove all event listeners", t => {
    let eventListener = _ => ()
    let emitter = {
      open Emitter1
      make()
      |> on(_, Events.text, eventListener)
      |> on(_, Events.text, eventListener)
      |> on(_, Events.text, eventListener)
    }
    // Make sure 3 listeners were indeed added:
    Assert.strictEqual(
      {
        open Emitter1
        listeners(emitter, Events.text)
      }->Array.length,
      3,
    )
    // Remove all the listeners:
    Emitter1.removeAllListeners(emitter)->ignore
    open Emitter1
    t->equal(listeners(emitter, Events.text)->Array.length, 0, "")
  })
})

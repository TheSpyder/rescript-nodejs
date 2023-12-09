open Zora
open StreamTestLib

zoraBlock("Stream.Readable", t => {
  t->block("'Stream.Readable.make' should return a defined value", t => {
    let readable = makeReadableEmpty()
    t->notEqual(readable->Js.Undefined.return, Js.Undefined.empty, "")
  })

  t->block("'Stream.Readable.make' should return an instance of 'Readable'", t => {
    let readable = makeReadableEmpty()
    t->equal(readable->Internal__JsTypeReflection.constructorName, "Readable", "")
  })

  t->block("'Stream.Readable.pipe' returns a writable stream", t => {
    let readable = makeReadableEmpty()
    let writable = makeWritableEmpty()
    t->equal(Stream.pipe(readable, writable), writable, "")
  })

  t->test("'Stream.Readable.destroyWithError' should emit 'error' event", t => {
    open! Errors
    let dummyError = Error.make("Expected error: Stream destroyed")->Error.toJsExn
    Js.Promise2.make(
      (~resolve, ~reject as _) => {
        let stream = StreamTestLib.makeReadableEmpty()->Stream.onError(
          err => {
            t->equal(err, dummyError, "")
            resolve()
          },
        )

        Js.Global.setTimeout(() => stream->Stream.destroyWithError(dummyError)->ignore, 10)->ignore
      },
    )
  })

  t->block("'Stream.Readable.destroy' should return the exact same instance of 'Readable'", t => {
    let readable = StreamTestLib.makeReadableEmpty()
    t->equal(readable->Stream.destroy, readable, "")
  })
})

zoraBlock("Stream.Writable", t => {
  t->block("'Stream.Writable.make' should return a defined value", t => {
    let writable = makeWritableEmpty()
    t->notEqual(writable->Js.Undefined.return, Js.Undefined.empty, "")
  })

  t->block("'Stream.Writable.make' should return an instance of 'Writable'", t => {
    let writable = makeWritableEmpty()
    t->equal(writable->Internal__JsTypeReflection.constructorName, "Writable", "")
  })

  t->test(
    "Stream.Writable.makeObjMode should have a 'write' function with the correct function signature",
    t => {
      open Stream

      let args = ref(None)

      let options = Writable.makeOptionsObjMode(
        ~write=@this
        (wstream, ~data, ~encoding, ~callback) => {
          args := Some((wstream, data, encoding, callback))
          callback(~error=None)
        },
        (),
      )

      Js.Promise2.make(
        (~resolve, ~reject as _) => {
          let writeStream = Writable.makeObjMode(options)

          Writable.writeWith(
            writeStream,
            42,
            ~callback=_ => {
              let actual = switch args.contents {
              | None => None
              | Some((wstream, value, encoding, cb)) =>
                Some((
                  Internal__JsTypeReflection.constructorName(wstream),
                  Js.typeof(value),
                  encoding,
                  Js.typeof(cb),
                ))
              }
              t->equal(
                actual,
                Some(("Writable", "number", Js.Null.return(StringEncoding.utf8), "function")),
                "",
              )

              resolve()
            },
            (),
          )->ignore
        },
      )
    },
  )
})

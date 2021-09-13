open Fs
open Zora

// avoid using rescript-zora `then` or `done`, to retain commonjs compatibility
let {then, resolve: done} = module(Promise)

zora("Fs", t => {
  t->test("readFile should read entire file", t => {
    open_(Global.filename, Flag.read)
    ->then(fh =>
      Fs.FileHandle.readFile(fh)->then(buffer => FileHandle.close(fh)->then(_ => done(buffer)))
    )
    ->then(buffer => {
      let needle = "Random string: Gh2e71pdHhPxU"
      t->ok(buffer->Buffer.indexOfString(needle) > 1, "buffer index was not greater than zero")
      done()
    })
  })

  t->test("readFileWith should read entire file as a string", t => {
    open_(Global.filename, Flag.read)
    ->then(fh =>
      Fs.FileHandle.readFileWith(fh, ~encoding="UTF-8")->then(buffer =>
        FileHandle.close(fh)->then(_ => done(buffer))
      )
    )
    ->then(content => {
      let needle = "Random string: uCF6c5f3Arrq"

      t->ok(
        Js.String.indexOf(needle, content) > 0,
        "buffer string indexOf was not greater than zero",
      )
      done()
    })
  })
  done()
})

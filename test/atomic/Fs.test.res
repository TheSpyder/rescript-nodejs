open Fs
open Zora

zora("Fs", async t => {
  t->test("readFile should read entire file", async t => {
    let fh = await open_(Global.filename, Flag.read)
    let buffer = await FileHandle.readFile(fh)
    let _ = await FileHandle.close(fh)

    let needle = "Random string: Gh2e71pdHhPxU"
    t->ok(buffer->Buffer.indexOfString(needle) > 1, "buffer index was not greater than zero")
  })

  t->test("readFileWith should read entire file as a string", async t => {
    let fh = await open_(Global.filename, Flag.read)
    let buffer = await FileHandle.readFileWith(fh, readFileOptions(~encoding="UTF-8", ()))
    let _ = await FileHandle.close(fh)
    let needle = "Random string: uCF6c5f3Arrq"

    t->ok(Js.String.indexOf(needle, buffer) > 0, "buffer string indexOf was not greater than zero")
  })
})

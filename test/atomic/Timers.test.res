open Zora

zora("Timers (promises)", async t => {
  t->test("setTimeout", async t => {
    let () = await Timers.Promises.setTimeout(100)
    t->ok(true, "")
  })
  t->test("setImmediate", async t => {
    let yes = await Timers.Promises.setImmediate("yes")
    t->equal(yes, "yes", "")
  })
})

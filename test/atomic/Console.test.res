open Zora
let process = Process.process

zoraBlock("Console", t => {
  let c1 = {
    open Console
    make(
      consoleOptions(
        ~stderr=Process.stderr(process),
        ~ignoreErrors=false,
        ~colorMode=true,
        ~inspectOptions=Util.inspectOptions(),
        ~stdout=Process.stdout(process),
        (),
      ),
    )
  }

  let c2 = Console.make2({
    "stderr": Process.stderr(process),
    "ignoreErrors": false,
    "colorMode": true,
    "inspectOptions": Util.inspectOptions(),
    "stdout": Process.stdout(process),
  })

  c1->Console.logMany(["a", "b"])
  c2->Console.table(["hi", "bye"])
  c2->Console.table([Js.Dict.fromArray([("a", 1), ("b", 2)])])

  t->block("New console instance should be defined", t =>
    t->notEqual(Js.Undefined.return(c1), Js.Undefined.empty, "")
  )
  t->block("New console instance should be defined", t =>
    t->notEqual(Js.Undefined.return(c2), Js.Undefined.empty, "")
  )
})

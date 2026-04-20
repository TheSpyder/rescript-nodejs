open Zora
let process = Process.process

zoraBlock("Console", t => {
  let c1 = {
    open Console
    make({
      stderr: Process.stderr(process),
      ignoreErrors: false,
      colorMode: true,
      inspectOptions: {},
      stdout: Process.stdout(process),
    })
  }

  let c2 = Console.make2({
    "stderr": Process.stderr(process),
    "ignoreErrors": false,
    "colorMode": true,
    "stdout": Process.stdout(process),
  })

  Stdlib.Console.log("=== Testing console output styles ===")
  c1->Console.logMany(["a", "b"])
  c2->Console.table(["hi", "bye"])
  c2->Console.table([
    {
      "a": 1,
      "b": 2,
    },
  ])
  Console.console->Console.dir({
    "hello": "world",
    "this": "is",
    "an": "object",
  })
  Stdlib.Console.log("=== END testing console output styles ===")

  t->block("New console instance should be defined", t =>
    t->notEqual(Nullable.make(c1), Nullable.undefined, "")
  )
  t->block("New console instance should be defined", t =>
    t->notEqual(Nullable.make(c2), Nullable.undefined, "")
  )
})

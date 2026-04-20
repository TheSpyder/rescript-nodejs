// codegen verification only, not intended to run
Readline.clearLine(Process.stdout(Process.process), 1, ~callback=() =>
  Stdlib.Console.log("line cleared")
)->ignore
Readline.clearScreenDown(Process.stdout(Process.process), ~callback=() =>
  Stdlib.Console.log("screen cleared")
)->ignore

Readline.cursorTo(
  Process.stdout(Process.process),
  ~x=1,
  ~y=2,
  ~callback=() => Stdlib.Console.log("cursor to"),
)->ignore

Readline.moveCursor(
  Process.stdout(Process.process),
  ~dx=1,
  ~dy=2,
  ~callback=() => Stdlib.Console.log("cursor moved"),
)->ignore

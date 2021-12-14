// codegen verification only, not intended to run
Readline.clearLine(Process.stdout(Process.process), 1, ~callback=() =>
  Js.log("line cleared")
)->ignore
Readline.clearScreenDown(Process.stdout(Process.process), ~callback=() =>
  Js.log("screen cleared")
)->ignore

Readline.cursorTo(
  Process.stdout(Process.process),
  ~x=1,
  ~y=2,
  ~callback=() => Js.log("cursor to"),
  (),
)->ignore

Readline.moveCursor(
  Process.stdout(Process.process),
  ~dx=1,
  ~dy=2,
  ~callback=() => Js.log("cursor moved"),
  (),
)->ignore

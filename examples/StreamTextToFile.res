// Normally `open NodeJs` would be used to shorten the module accessors
// this is not done in the example to make it clear where things come from

let data = "Sample text to write to a file!"->NodeJs.Buffer.fromString
let process = NodeJs.Process.process

let outputPath = NodeJs.Path.relative(~from=NodeJs.Process.cwd(process), ~to_="example__output.txt")

let writeStream = NodeJs.Fs.createWriteStream(outputPath)

let logErrorIfExists = maybeError =>
  switch Js.Nullable.toOption(maybeError) {
  | Some(err) => Js.log2("An error occurred", err)
  | None => ()
  }

let () =
  writeStream
  ->NodeJs.Stream.writeWith(
    data,
    ~callback=maybeError => {
      logErrorIfExists(maybeError)
      Js.log("Finished")
    },
    (),
  )
  ->ignore

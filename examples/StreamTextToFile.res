open NodeJs
let data = "Sample text to write to a file!"->Buffer.fromString
let process = Process.process

let outputPath = Path.relative(~from=Process.cwd(process), ~to_="example__output.txt")

let writeStream = Fs.createWriteStream(outputPath)

let logErrorIfExists = maybeError =>
  switch Nullable.toOption(maybeError) {
  | Some(err) => Stdlib.Console.log2("An error occurred", err)
  | None => ()
  }

let () =
  writeStream
  ->Stream.writeWith(data, ~callback=maybeError => {
    logErrorIfExists(maybeError)
    Stdlib.Console.log("Finished")
  })
  ->ignore

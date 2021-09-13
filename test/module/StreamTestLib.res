/* Creates a readable stream with no functionality */
let makeReadableEmpty = () => {
  open Stream.Readable
  let options = makeOptions(
    ~destroy=@this (_, ~error, ~callback) => callback(~error=Js.Nullable.toOption(error)),
    ~read=@this (_, ~size as _) => (),
    ~autoDestroy=true,
    (),
  )
  make(options)
}

/* Creates a writable stream with no functionality */
let makeWritableEmpty = () => {
  open Stream.Writable
  let options = makeOptions(
    ~destroy=@this (_, ~error, ~callback) => callback(~error=Js.Nullable.toOption(error)),
    ~write=@this (_, ~data as _, ~encoding as _, ~callback) => callback(~error=None),
    ~autoDestroy=true,
    (),
  )
  make(options)
}

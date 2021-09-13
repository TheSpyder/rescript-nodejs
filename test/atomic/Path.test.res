open Zora

zoraBlock("Path", t =>
  t->block("basename should isolate filename with extension", t => {
    t->equal(Path.Posix.basename("/tmp/myfile.html"), "myfile.html", "")
  })
)

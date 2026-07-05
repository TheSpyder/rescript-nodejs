type rec t = {
  id: string,
  exports: Exports.t,
  // in REPL V4 it is `undefined` in CLI it can be `null`
  parrent: nullable<t>,
  filename: string,
  loaded: bool,
  children: array<t>,
  paths: array<string>,
}

@val
external module_: {"__cache": dict<t>} = "module"

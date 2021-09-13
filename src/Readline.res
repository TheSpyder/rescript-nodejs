module Interface = {
  type t
  type interfaceOptions
  @obj
  external interfaceOptions: (
    ~input: Stream.Readable.subtype<Buffer.t, 'rtype>,
    ~output: Stream.Writable.subtype<Buffer.t, 'wtype>=?,
    ~completer: (string, (string, (array<string>, string)) => unit) => unit=?,
    ~terminal: bool=?,
    ~historySize: int=?,
    ~prompt: string=?,
    ~crlfDelay: int=?,
    ~removeHistoryDuplicates: bool=?,
    ~escapeCodeTimeout: int=?,
    unit,
  ) => interfaceOptions = ""
  @send external make: (t, interfaceOptions) => t = "createInterface"
  @send external close: t => unit = "close"
  @send external pause: t => unit = "pause"
  @send external prompt: (t, Js.nullable<bool>) => unit = "prompt"
  @send
  external question: (t, string, string => unit) => unit = "question"
  @send external resume: t => unit = "resume"
  @send external setPrompt: (t, string) => unit = "setPrompt"
  @send external write: (t, string) => unit = "write"
  type keyOptions
  @obj
  external keyOptions: (
    ~ctrl: bool=?,
    ~meta: bool=?,
    ~shift: bool=?,
    ~name: string=?,
  ) => keyOptions = ""
  @send
  external writeKey: (t, Js.Null.t<string>, keyOptions) => unit = "write"
  @send
  external writeKey2: (
    t,
    Js.Null.t<string>,
    {"ctrl": option<bool>, "meta": option<bool>, "shift": option<bool>, "name": option<string>},
  ) => unit = "write"
  @get @return(nullable) external line: t => option<string> = "line"
  @get @return(nullable)
  external cursor: t => option<int> = "cursor"
  @send
  external clearLine: (t, Stream.Writable.subtype<Buffer.t, 'ty>, int) => bool = "clearLine"
  @send
  external clearScreenDown: (t, Stream.Writable.subtype<Buffer.t, 'ty>, unit => unit) => bool =
    "clearScreenDown"
  @send
  external cursorTo: (
    t,
    Stream.Writable.subtype<Buffer.t, 'ty>,
    int,
    Js.Undefined.t<int>,
    Js.Undefined.t<unit => unit>,
  ) => bool = "cursorTo"
  @send
  external moveCursor: (
    t,
    Stream.Writable.subtype<Buffer.t, 'ty>,
    int,
    int,
    Js.Undefined.t<unit => unit>,
  ) => bool = "moveCursor"
}

open Zora

zoraBlock("Global", t => {
  t->block("dirname should be defined", t =>
    t->notEqual(Js.Undefined.return(Global.dirname), Js.Undefined.empty, "")
  )
  t->block("dirname should be of type 'string'", t =>
    t->equal(Global.dirname->Js.typeof, "string", "")
  )

  t->block("filename should be defined", t =>
    t->notEqual(Js.Undefined.return(Global.filename), Js.Undefined.empty, "")
  )
  t->block("filename should be of type 'string'", t =>
    t->equal(Global.filename->Js.typeof, "string", "")
  )

  t->block("'global object' should be defined", t =>
    t->notEqual(Js.Undefined.return(Global.global), Js.Undefined.empty, "")
  )
  t->block("'global' object should be of type 'object'", t =>
    t->equal(Global.global->Js.typeof, "object", "")
  )

  t->block("'require' function should be defined", t =>
    t->notEqual(Js.Undefined.return(Global.require), Js.Undefined.empty, "")
  )
  t->block("'require' function should be defined", t =>
    t->equal(Global.require->Js.typeof, "function", "")
  )

  t->block("'require' fuction should return a defined value from a relative path", t =>
    t->notEqual(Js.Undefined.return(Global.require("path")), Js.Undefined.empty, "")
  )
  t->block("'require' fuction should successfully import a module object from a relative path", t =>
    t->equal(Global.require("path")->Js.typeof, "object", "")
  )
})

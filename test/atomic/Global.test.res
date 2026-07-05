open Zora

zoraBlock("Global", t => {
  t->block("dirname should be defined", t =>
    t->notEqual(Nullable.make(Global.dirname), Nullable.undefined, "")
  )
  t->block("dirname should be of type 'string'", t => t->equal(Global.dirname->typeof, #string, ""))

  t->block("filename should be defined", t =>
    t->notEqual(Nullable.make(Global.filename), Nullable.undefined, "")
  )
  t->block("filename should be of type 'string'", t =>
    t->equal(Global.filename->typeof, #string, "")
  )

  t->block("'global object' should be defined", t =>
    t->notEqual(Nullable.make(Global.global), Nullable.undefined, "")
  )
  t->block("'global' object should be of type 'object'", t =>
    t->equal(Global.global->typeof, #object, "")
  )

  t->block("'require' function should be defined", t =>
    t->notEqual(Nullable.make(Global.require), Nullable.undefined, "")
  )
  t->block("'require' function should be defined", t =>
    t->equal(Global.require->typeof, #function, "")
  )

  t->block("'require' fuction should return a defined value from a relative path", t =>
    t->notEqual(Nullable.make(Global.require("path")), Nullable.undefined, "")
  )
  t->block("'require' fuction should successfully import a module object from a relative path", t =>
    t->equal(Global.require("path")->typeof, #object, "")
  )
})

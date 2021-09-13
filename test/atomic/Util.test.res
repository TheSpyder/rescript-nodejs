open Zora

zoraBlock("Util.Types", t => {
  t->block("Util.Types.isAnyArrayBuffer(arrayBuffer) should return true", t => {
    let arrayBuffer = Js.TypedArray2.ArrayBuffer.make(16)
    t->equal(arrayBuffer->Util.Types.isAnyArrayBuffer, true, "")
  })

  t->block("Util.Types.isAnyArrayBuffer(string) should return false", t => {
    let str = "not array buffer"
    t->equal(str->Util.Types.isAnyArrayBuffer, false, "")
  })
})

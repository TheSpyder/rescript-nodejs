open Zora
zoraBlock("BinaryLike", t => {
  open Js.TypedArray2

  let string_ = "test1234"
  let binaryLikeString = string_->BinaryLike.string

  let buffer_ = Buffer.fromArray([1, 2, 3, 4])
  let binaryLikeBuffer = BinaryLike.buffer(buffer_)

  let uInt8Array = Uint8Array.make([1, 2, 3, 4])
  let binaryLikeUint8Array = BinaryLike.uInt8Array(uInt8Array)

  let int8Array = Int8Array.make([1, 2, 3, 4])
  let binaryLikeInt8Array = BinaryLike.int8Array(int8Array)

  let uInt8ClampedArray = Uint8ClampedArray.make([1, 2, 3, 4])
  let binaryLikeUint8ClampedArray = BinaryLike.uInt8ClampedArray(uInt8ClampedArray)

  let uInt16Array = Uint16Array.make([1, 2, 3, 4])
  let binaryLikeUint16Array = BinaryLike.uInt16Array(uInt16Array)

  let int16Array = Int16Array.make([1, 2, 3, 4])
  let binaryLikeInt16Array = BinaryLike.int16Array(int16Array)

  t->block("BinaryLike.classify(string) should return a 'String' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeString) {
      | String(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(buffer) should return a 'Buffer' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeBuffer) {
      | Buffer(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(uInt8Array) should return a 'Uint8Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeUint8Array) {
      | Uint8Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(int8Array) should return a 'Int8Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeInt8Array) {
      | Int8Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block(
    "BinaryLike.classify(uInt8ClampedArray) should return a 'Uint8ClampedArray' variant",
    t => {
      t->ok(
        switch BinaryLike.classify(binaryLikeUint8ClampedArray) {
        | Uint8ClampedArray(_) => true
        | _ => false
        },
        "",
      )
    },
  )

  t->block("BinaryLike.classify(uInt16Array) should return a 'Uint16Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeUint16Array) {
      | Uint16Array(_) => true
      | _ => false
      },
      "",
    )
  })

  t->block("BinaryLike.classify(int16Array) should return a 'Int16Array' variant", t => {
    t->ok(
      switch BinaryLike.classify(binaryLikeInt16Array) {
      | Int16Array(_) => true
      | _ => false
      },
      "",
    )
  })
})

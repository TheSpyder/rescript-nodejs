open Zora

zoraBlock("BigInt", t => {
  Random.init(84611)

  let fourHundred = 400
  let randomInt = _ => Random.int(fourHundred)

  t->block(
    "'BigInt.fromInt' and 'BigInt.toInt' are associative operations for all 32-bit integers",
    t => {
      let arrA = Belt.Array.makeByU(1000, (. _) => Random.int(1000000))
      let arrB = Belt.Array.map(arrA, BigInt.fromInt)
      let arrC = Belt.Array.map(arrB, BigInt.toInt)
      t->equal(arrA, arrC, "")
    },
  )

  t->block("BigInt.add", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a + b

    open BigInt
    t->equal(add(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(+)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a + b

    open! BigInt
    t->equal(fromInt(a) + fromInt(b), BigInt.fromInt(c), "")
  })

  t->block("BigInt.subtract", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a - b

    open BigInt
    t->equal(subtract(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(-)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a - b

    open! BigInt
    t->equal(fromInt(a) - fromInt(b), BigInt.fromInt(c), "")
  })

  t->block("BigInt.multiply", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a * b

    open BigInt
    t->equal(multiply(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(*)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a * b

    open! BigInt
    t->equal(fromInt(a) * fromInt(b), BigInt.fromInt(c), "")
  })

  t->block("BigInt.divide", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a / b

    open BigInt
    t->equal(divide(fromInt(a), fromInt(b)), fromInt(c), "")
  })

  t->block("BigInt.(/)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = a / b

    open! BigInt
    t->equal(fromInt(a) / fromInt(b), BigInt.fromInt(c), "")
  })

  t->block("BigInt.negate", t => {
    let a = randomInt()
    let b = -a

    open BigInt
    t->equal(negate(fromInt(a)), fromInt(b), "")
  })

  t->block("BigInt.(~-)", t => {
    let a = randomInt()
    let b = -a

    open! BigInt
    t->equal(-fromInt(a), BigInt.fromInt(b), "")
  })

  t->block("BigInt.modulo", t => {
    let a = randomInt()
    let b = randomInt()
    let c = mod(a, b)

    open BigInt
    t->equal(modulo(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(mod)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = mod(a, b)

    open! BigInt
    t->equal(mod(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.power", t => {
    let a = Random.int(6)->Js.Int.toFloat
    let b = Random.int(8)->Js.Int.toFloat

    let c = Js.Math.pow_float(~base=a, ~exp=b)

    open BigInt
    t->equal(power(fromFloat(a), fromFloat(b)), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.(**)", t => {
    let a = Random.int(6)->Js.Int.toFloat
    let b = Random.int(8)->Js.Int.toFloat

    @ocaml.warning("-3")
    let c = Js.Math.pow_float(~base=a, ~exp=b)

    open! BigInt
    t->equal(fromFloat(a) ** fromFloat(b), BigInt.fromFloat(c), "")
  })

  t->block("BigInt.logicalAnd", t => {
    let a = Random.int(256)
    let b = Random.int(256)
    let c = land(a, b)

    open BigInt
    t->equal(logicalAnd(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(land)", t => {
    let a = Random.int(256)
    let b = Random.int(256)
    let c = land(a, b)

    open! BigInt
    t->equal(land(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalOr", t => {
    let a = randomInt()
    let b = randomInt()
    let c = lor(a, b)

    open BigInt
    t->equal(logicalOr(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lor)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = lor(a, b)

    open! BigInt
    t->equal(lor(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalXor", t => {
    let a = randomInt()
    let b = randomInt()
    let c = lxor(a, b)

    open BigInt
    t->equal(logicalXor(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lxor)", t => {
    let a = randomInt()
    let b = randomInt()
    let c = lxor(a, b)

    open! BigInt
    t->equal(lxor(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.logicalNot", t => {
    let a = randomInt()
    let b = lnot(a)

    open BigInt
    t->equal(logicalNot(fromInt(a)), BigInt.fromInt(b), "")
  })

  t->block("BigInt.(lnot)", t => {
    let a = randomInt()
    let b = lnot(a)

    open! BigInt
    t->equal(lnot(fromInt(a)), BigInt.fromInt(b), "")
  })

  t->block("BigInt.logicalShiftLeft", t => {
    let a = 26
    let b = 7
    let c = lsl(a, b)

    open BigInt
    t->equal(logicalShiftLeft(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(lsl)", t => {
    let a = 26
    let b = 7
    let c = lsl(a, b)

    open! BigInt
    t->equal(lsl(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.arithmeticShiftRight", t => {
    let a = 32
    let b = 4
    let c = asr(a, b)

    open BigInt
    t->equal(arithmeticShiftRight(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })

  t->block("BigInt.(asr)", t => {
    let a = 32
    let b = 4
    let c = asr(a, b)

    open! BigInt
    t->equal(asr(fromInt(a), fromInt(b)), BigInt.fromInt(c), "")
  })
})

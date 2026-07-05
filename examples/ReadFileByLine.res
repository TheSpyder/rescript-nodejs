open NodeJs

// example from the NodeJS docs
let rl = Readline.make({input: Fs.createReadStream("sample.txt"), crlfDelay: infinity})

rl
->Readline.Interface.on(Event.fromString("line"), line => {
  Stdlib.Console.log(`Received: ${line}`)
})
->ignore

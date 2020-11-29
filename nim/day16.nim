import strutils, strscans, sequtils
import unpack # nimble install unpack

let input = readFile("./inputs/16.txt")

type
  Registers = array[4, int]
  Instruction = tuple[op, a, b, c: int]
  Sample = object
    before: Registers
    instruction: Instruction
    after: Registers
  Samples = seq[Sample]
  Operation = enum
    opAddr = "addr", opAddi = "addi", opMulr = "mulr", opMuli = "muli",
    opBanr = "banr", opBani = "bani", opBorr = "borr", opBori = "bori",
    opSetr = "setr", opSeti = "seti", opGtir = "gtir", opGtrr = "gtrr",
    opGtri = "gtri", opEqir = "eqir", opEqrr = "eqrr", opEqri = "eqri"
  OperationsCandidates = array[16, set[Operation]]
  OperationsList = array[16, Operation]

[samplesList, testProgram] <- input.split("\n\n\n").mapIt(it.splitLines)
var
  registers: Registers
  possibleOperations: OperationsCandidates
for i in 0 .. 15:
  for op in Operation.low .. Operation.high:
    possibleOperations[i].incl op


proc execute(instr: Instruction, operation: Operation): int =
  case operation
    of opAddr: registers[instr.a] + registers[instr.b]
    of opAddi: registers[instr.a] + instr.b
    of opMulr: registers[instr.a] * registers[instr.b]
    of opMuli: registers[instr.a] * instr.b
    of opBanr: registers[instr.a] and registers[instr.b]
    of opBani: registers[instr.a] and instr.b
    of opBorr: registers[instr.a] or registers[instr.b]
    of opBori: registers[instr.a] or instr.b
    of opSetr: registers[instr.a]
    of opSeti: instr.a
    of opGtir: int instr.a > registers[instr.b]
    of opGtrr: int registers[instr.a] > registers[instr.b]
    of opGtri: int registers[instr.a] > instr.b
    of opEqir: int instr.a == registers[instr.b]
    of opEqrr: int registers[instr.a] == registers[instr.b]
    of opEqri: int registers[instr.a] == instr.b

proc getSamples(samplesList: seq[string]): Samples =
  var sample: Sample
  for line in samplesList:
    var a, b, c, d: int
    if line.scanf("Before: [$i, $i, $i, $i]", a, b, c, d):
      sample.before = [a, b, c, d]
    elif line.scanf("$i $i $i $i", a, b, c, d):
      sample.instruction = (a, b, c, d)
    elif line.scanf("After:  [$i, $i, $i, $i]", a, b, c, d):
      sample.after = [a, b, c, d]
      result.add sample

proc first(samples: Samples): int =
  for sample in samples:
    var possible: int
    registers = sample.before
    for op in Operation.low .. Operation.high:
      if sample.instruction.execute(op) == sample.after[sample.instruction.c]:
        inc possible
      else:
        possibleOperations[sample.instruction.op].excl op
    if possible >= 3:
      inc result

let samples = samplesList.getSamples
echo first(samples)


proc decodeOperations: OperationsList =
  var solvedOperations: set[Operation]
  while possibleOperations.anyIt(it.card > 1):
    for i, candidates in possibleOperations:
      if candidates.card == 1:
        for x in candidates: solvedOperations.incl x # poor man's `pop`
      else:
        possibleOperations[i] = candidates - solvedOperations
  for i, candidates in possibleOperations:
    for x in candidates:
      result[i] = x

let operations = decodeOperations()
registers = [0, 0, 0, 0]

for line in testProgram:
  var op, a, b, c: int
  if line.scanf("$i $i $i $i", op, a, b, c):
    let instruction = (op, a, b, c)
    registers[c] = instruction.execute Operation(operations[op])

echo registers[0]

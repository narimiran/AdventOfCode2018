import strutils, strscans, sequtils
import unpack # nimble install unpack

let input = readFile("./inputs/16.txt")

type
  Registers = array[4, int]
  Instruction = tuple[op, a, b, c: int]
  Sample = tuple
    before: Registers
    instruction: Instruction
    after: Registers
  Samples = seq[Sample]
  Operation = enum
    adrr, addi, mulr, muli, banr, bani, borr, bori,
    setr, seti, gtir, gtrr, gtri, eqir, eqrr, eqri
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
    of adrr: registers[instr.a] + registers[instr.b]
    of addi: registers[instr.a] + instr.b
    of mulr: registers[instr.a] * registers[instr.b]
    of muli: registers[instr.a] * instr.b
    of banr: registers[instr.a] and registers[instr.b]
    of bani: registers[instr.a] and instr.b
    of borr: registers[instr.a] or registers[instr.b]
    of bori: registers[instr.a] or instr.b
    of setr: registers[instr.a]
    of seti: instr.a
    of gtir: int instr.a > registers[instr.b]
    of gtrr: int registers[instr.a] > registers[instr.b]
    of gtri: int registers[instr.a] > instr.b
    of eqir: int instr.a == registers[instr.b]
    of eqrr: int registers[instr.a] == registers[instr.b]
    of eqri: int registers[instr.a] == instr.b

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
    for x in candidates: result[i] = x

let operations = decodeOperations()
registers = [0, 0, 0, 0]

for line in testProgram:
  var op, a, b, c: int
  if line.scanf("$i $i $i $i", op, a, b, c):
    let instruction = (op, a, b, c)
    registers[c] = instruction.execute Operation(operations[op])

echo registers[0]

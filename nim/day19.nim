import strutils, strscans, sequtils
import unpack # nimble install unpack

let input = readFile("./inputs/19.txt")

type
  Registers = array[6, int]
  Operation = enum
    opAddr = "addr", opAddi = "addi", opMulr = "mulr", opMuli = "muli",
    opBanr = "banr", opBani = "bani", opBorr = "borr", opBori = "bori",
    opSetr = "setr", opSeti = "seti", opGtir = "gtir", opGtrr = "gtrr",
    opGtri = "gtri", opEqir = "eqir", opEqrr = "eqrr", opEqri = "eqri"
  Instruction = tuple[op: Operation, a, b, c: int]


[ipline, testProgram] <- input.split("\n\n\n").mapIt(it.splitLines)

let ip = ipline[0].split()[^1].parseInt

var
  instructions: seq[Instruction]
  op: string
  a, b, c: int
for line in testProgram:
  if line.scanf("$w $i $i $i", op, a, b, c):
    instructions.add (parseEnum[Operation](op), a, b, c)


func execute(r: Registers, i: Instruction): int =
  case i.op
    of opAddr: r[i.a] + r[i.b]
    of opAddi: r[i.a] + i.b
    of opMulr: r[i.a] * r[i.b]
    of opMuli: r[i.a] * i.b
    of opBanr: r[i.a] and r[i.b]
    of opBani: r[i.a] and i.b
    of opBorr: r[i.a] or r[i.b]
    of opBori: r[i.a] or i.b
    of opSetr: r[i.a]
    of opSeti: i.a
    of opGtir: int i.a > r[i.b]
    of opGtrr: int r[i.a] > r[i.b]
    of opGtri: int r[i.a] > i.b
    of opEqir: int i.a == r[i.b]
    of opEqrr: int r[i.a] == r[i.b]
    of opEqri: int r[i.a] == i.b

func loop(r: Registers): int =
  let r4 = r[4]
  var r5 = 1
  while r5*r5 < r4:
    if r4 mod r5 == 0:
      result += r5
      result += r4 div r5
    inc r5

proc solve(part: int): int =
  var r: Registers
  r[0] = part - 1

  while r[ip] in 0 .. instructions.high:
    if r[ip] == 3:
      r[0] = loop r
      r[ip] = 16
    else:
      let instr = instructions[r[ip]]
      r[instr.c] = r.execute instr
      inc r[ip]
  return r[0]

echo solve 1
echo solve 2

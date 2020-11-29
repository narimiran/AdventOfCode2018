import strutils

let input = readFile("./inputs/05.txt")


func reactions(polymer: string): string =
  # Since lower and upper letters are 32 (2^5) characters apart, we can use
  # `a xor b`, which is faster than `abs(a - b)`.
  result = newString(12_000) # manually tweaked
  var pos: int
  for unit in polymer:
    if pos > 0 and (ord(unit) xor ord(result[pos-1])) == 32:
      dec pos
    else:
      result[pos] = unit
      inc pos
  result.setLen(pos)


func shortest(polymer: string): int =
  result = int.high
  var
    improvedPolymer: string
    polymerSize: int
  for unit in 'a' .. 'z':
    improvedPolymer = polymer.replace($unit).replace($unit.toUpperAscii)
    polymerSize = improvedPolymer.reactions.len
    if polymerSize < result:
      result = polymerSize


let resultingPolymer = input.reactions

echo resultingPolymer.len
echo resultingPolymer.shortest

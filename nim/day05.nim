import strutils, math

let input = readFile("./inputs/05.txt")


func reactions(polymer: string): seq[char] =
  # A version with just `add` and `pop` to the `seq[char]` is more elegant,
  # but it is 30% slower than this.
  var
    stack: array[11000, char] # manually tweaked
    pos: int
  for unit in polymer:
    if pos > 0 and abs(ord(unit) - ord(stack[pos-1])) == 32:
      dec pos
    else:
      stack[pos] = unit
      inc pos
  result = stack[0 ..< pos]


func shortest(polymer: string): int =
  result = int.high
  var
    improvedPolymer: string
    polymerSize: int
  for unit in {'a' .. 'z'}:
    improvedPolymer = polymer.replace($unit, "").replace($unit.toUpperAscii, "")
    polymerSize = improvedPolymer.reactions.len
    if polymerSize < result:
      result = polymerSize


let resultingPolymer = input.reactions.join

echo resultingPolymer.len
echo resultingPolymer.shortest

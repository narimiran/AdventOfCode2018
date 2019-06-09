import strutils, sequtils, intsets
import itertools # nimble install itertools


let input = readFile("./inputs/01.txt").splitLines.map(parseInt)
let first = input.foldl(a + b)

var
  second: int
  frequencies = initIntSet()

for n in cycle input:
  second += n
  if frequencies.containsOrIncl second:
    break

echo first
echo second

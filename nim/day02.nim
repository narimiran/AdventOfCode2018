import strutils, sequtils

let input = readFile("./inputs/02.txt").splitLines()

func first(input: seq[string]): int =
  var twice, thrice: int
  for line in input:
    var hasPairs, hasTriplets: bool
    for c in line:
      case line.count(c)
        of 2: hasPairs = true
        of 3: hasTriplets = true
        else: discard
    if hasPairs: inc twice
    if hasTriplets: inc thrice
  result = twice * thrice

func sameLetters(line1, line2: string): string =
  for c1, c2 in zip(line1, line2).items:
    if c1 == c2:
      result.add c1

func second(input: seq[string]): string =
  for i, line1 in input:
    for line2 in input[i+1 .. input.high]:
      var differences: int
      for c1, c2 in zip(line1, line2).items:
        if c1 != c2:
          inc differences
      if differences == 1:
        return sameLetters(line1, line2)


echo first(input)
echo second(input)

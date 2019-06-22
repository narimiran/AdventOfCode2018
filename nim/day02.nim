import strutils

let input = readFile("./inputs/02.txt").splitLines

func first(input: seq[string]): int =
  var twice, thrice: int
  for line in input:
    var hasPairs, hasTriplets: bool
    for c in line:
      case line.count c
        of 2: hasPairs = true
        of 3: hasTriplets = true
        else: discard
    if hasPairs: inc twice
    if hasTriplets: inc thrice
  result = twice * thrice

func sameLetters(line1, line2: string): string =
  for c in 0 ..< line1.len:
    if line1[c] == line2[c]:
      result.add line1[c]

func second(input: seq[string]): string =
  let l = input[0].len
  var found: bool
  for i, line1 in input:
    for line2 in input[i+1 .. input.high]:
      for c in 0 ..< l:
        if line1[c] != line2[c]:
          found = not found
          if not found: break
      if found:
        return sameLetters(line1, line2)


echo first(input)
echo second(input)

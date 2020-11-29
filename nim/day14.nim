import strutils, sequtils

const input = 765071

type
  Solution = tuple[first: string, second: int]

proc matches(rl, digits: seq[int8], nrOfRecipes: int): bool =
  for i in 1 .. 6:
    if rl[nrOfRecipes-i] != digits[6-i]:
      return false
  return true

template put(rl: seq[int8], value: int8) =
  rl[nrOfRecipes] = value
  inc nrOfRecipes

template move(elf: var int, digit: int8) =
  inc elf
  elf += digit
  while elf >= nrOfRecipes:
    elf -= nrOfRecipes


proc solve(digits: seq[int8]): Solution =
  var
    firstDigit, secondDigit, sum: int8
    firstElf = 0
    secondElf = 1
    nrOfRecipes = 2
    recipeList = newSeq[int8](22_000_000) # manually tweaked
  recipeList[firstElf] = 3
  recipeList[secondElf] = 7

  while true:
    firstDigit = recipeList[firstElf]
    secondDigit = recipeList[secondElf]
    sum = firstDigit + secondDigit
    if sum > 9:
      recipeList.put 1
      sum -= 10
      if recipeList.matches(digits, nrOfRecipes):
        break
    recipeList.put sum
    firstElf.move firstDigit
    secondElf.move secondDigit

  result.first = recipeList[input ..< input+10].join
  result.second = nrOfRecipes - 6


let digits = toSeq($input).mapIt(it.int8 - '0'.int8)
let s = solve digits
echo s.first
echo s.second

import strutils, sequtils

const input = 765071
let digits = toSeq($input).mapIt(it.int8 - '0'.int8)
var
  recipeList = newSeqUninitialized[int8](22_000_000) # manually tweaked
  firstElf = 0
  secondElf = 1
  nrOfRecipes = 2

recipeList[firstElf] = 3
recipeList[secondElf] = 7


proc matches(rl, digits: seq[int8]): bool =
  for i in 1 .. 6:
    if rl[nrOfRecipes-i] != digits[6-i]:
      return false
  return true

template put(rl: seq[int8], value: int8) =
  rl[nrOfRecipes] = value
  inc nrOfRecipes
  if rl.matches digits:
    break


while true:
  let
    firstDigit = recipeList[firstElf]
    secondDigit = recipeList[secondElf]
  var sum = firstDigit + secondDigit
  if sum > 9:
    recipeList.put 1
    sum -= 10
  recipeList.put sum
  firstElf = (firstElf + firstDigit + 1) mod nrOfRecipes
  secondElf = (secondElf + secondDigit + 1) mod nrOfRecipes

let
  first = recipeList[input ..< input+10].join
  second = nrOfRecipes - 6

echo first
echo second

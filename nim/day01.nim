import strutils, sequtils
import itertools # nimble install itertools


let input = readFile("./inputs/01.txt").splitLines.map(parseInt)

let first = input.foldl(a + b)


var
  second: int
  frequencies: array[-1000..200_000, bool] # manually tweaked

let infiniteList = input.cycle()
for n in infiniteList():
  second += n
  if frequencies[second]:
    break
  frequencies[second] = true


echo first
echo second

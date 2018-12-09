import strutils, sequtils

let input = readFile("./inputs/08.txt").split.map(parseInt)

type Solution = tuple[first, second: int]
var position: int

proc solve(): Solution =
  var
    (children, meta) = (input[position], input[position+1])
    kidValue = newSeq[int](children+1)
    metaSum: int
  position += 2
  for child in 1 .. children:
    (metaSum, kidValue[child]) = solve()
    result.first += metaSum

  for i in 0 ..< meta:
    let value = input[position]
    inc position

    case children
    of 0: result.second += value
    else:
      if value <= children:
        result.second += kidValue[value]
    result.first += value


echo solve()

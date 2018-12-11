import strformat

const
  input = 4172
  gridLimit = 300

type
  Solution = tuple[x, y, size, sum: int]
  Grid = array[gridLimit+1, array[gridLimit+1, int]]

let coordinates = 1 .. gridLimit
var cells, sums: Grid

for y in coordinates:
  for x in coordinates:
    let power = ((x + 10) * y + input) * (x + 10) div 100 mod 10 - 5
    cells[y][x] = power
    sums[y][x] = power + sums[y-1][x] + sums[y][x-1] - sums[y-1][x-1]

proc mostPowerfulSquare(size = 3): Solution =
  for y in size .. gridLimit:
    for x in size .. gridLimit:
      let sum = sums[y][x] - sums[y-size][x] - sums[y][x-size] + sums[y-size][x-size]
      if sum > result.sum:
        result = (x-size+1, y-size+1, size, sum)

proc mostPowerfulSquareOfAnySize(): Solution =
  for size in coordinates:
    let res = mostPowerfulSquare(size)
    if res.sum > result.sum:
      result = res

let
  first = mostPowerfulSquare()
  second = mostPowerfulSquareOfAnySize()

echo fmt"{first.x},{first.y}"
echo fmt"{second.x},{second.y},{second.size}"

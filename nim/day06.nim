import strutils, strscans, sequtils

let input = readFile("./inputs/06.txt").splitLines

type
  Limits = 50..360 # manually tweaked, based on the input coordinates
  Grid = array[Limits, array[Limits, int]]
  Point = tuple[x, y: int]

iterator items(x: typedesc[Limits]): int =
  for i in x.low .. x.high:
    yield i

func manhattan(p1, p2: Point): int =
  abs(p2.x - p1.x) + abs(p2.y - p1.y)

let points = block:
  var res = newSeq[Point](input.len)
  for i, line in input:
    var x, y: int
    if line.scanf("$i, $i", x, y):
      res[i] = (x, y)
  res


var grid: Grid
var regionSize: int

for x in Limits:
  for y in Limits:
    var
      minimalDistance = int.high
      currentOwner: int
      totalDistances: int
    for i, point in points:
      let distance = (x, y).manhattan(point)
      totalDistances += distance
      if distance < minimalDistance:
        minimalDistance = distance
        currentOwner = i
      elif distance == minimalDistance:
        currentOwner = -1
    if currentOwner >= 0:
      grid[y][x] = currentOwner
    if totalDistances < 10_000:
      inc regionSize


proc removeInfiniteAreas(grid: Grid): auto =
  result = {1 .. input.len}
  for n in grid[grid.low]: result.excl n
  for n in grid[grid.high]: result.excl n
  for row in grid:
    result.excl row[row.low]
    result.excl row[row.high]

let finites = removeInfiniteAreas grid

func territorySize(g: Grid, n: int): int =
  for line in g:
    result += line.count n

var maxFiniteArea: int
for n in finites:
  let area = grid.territorySize(n)
  if area > maxFiniteArea:
    maxFiniteArea = area

echo maxFiniteArea
echo regionSize

import strutils, strscans, sequtils

let input = readFile("./inputs/06.txt")

type
  Limits = 50..360 # manually tweaked, based on the input coordinates
  Grid = array[Limits, array[Limits, int]]
  Point = tuple[x, y: int]

iterator items(x: typedesc[Limits]): int =
  for i in x.low .. x.high:
    yield i

proc read(input: string): seq[Point] =
  var x, y: int
  for line in input.splitLines:
    if line.scanf("$i, $i", x, y):
      result.add (x, y)

func manhattan(p1, p2: Point): int =
  abs(p2.x - p1.x) + abs(p2.y - p1.y)

proc removeInfiniteAreas(grid: Grid): auto =
  result = {0 .. input.len-1}
  for n in grid[grid.low]: result.excl n
  for n in grid[grid.high]: result.excl n
  for row in grid:
    result.excl row[row.low]
    result.excl row[row.high]


proc solve =
  let points = read input
  var
    grid: Grid
    regionSize: int
    areas = newSeq[int](points.len)

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
        inc areas[currentOwner]
      if totalDistances < 10_000:
        inc regionSize

  let finites = removeInfiniteAreas grid
  var maxFiniteArea: int
  for i, area in areas:
    if i in finites and area > maxFiniteArea:
      maxFiniteArea = area

  echo maxFiniteArea
  echo regionSize


solve()

import strscans

type
  Limits = 50..360 # manually tweaked, based on the input coordinates
  Grid = array[Limits, array[Limits, uint8]]
  Point = tuple[x, y: int]
  Solution = tuple[first, second: int]

iterator items(x: typedesc[Limits]): int =
  for i in x.low .. x.high:
    yield i

proc read(input: string): seq[Point] =
  var x, y: int
  for line in input.lines:
    if line.scanf("$i, $i", x, y):
      result.add (x, y)

func manhattan(p1, p2: Point): int =
  abs(p2.x - p1.x) + abs(p2.y - p1.y)

proc findInfiniteAreas(grid: Grid): set[uint8] =
  for n in grid[grid.low]: result.incl n
  for n in grid[grid.high]: result.incl n
  for row in grid:
    result.incl row[row.low]
    result.incl row[row.high]

proc solve: Solution =
  let points = read "./inputs/06.txt"
  var
    grid: Grid
    areas = newSeq[int](points.len)
  for y in Limits:
    for x in Limits:
      var
        minimalDistance = int.high
        currentOwner: int
        totalDistances: int
      for i, point in points:
        let distance = (x, y).manhattan(point)
        totalDistances += distance
        if distance < minimalDistance:
          minimalDistance = distance
          currentOwner = i+1
        elif distance == minimalDistance:
          currentOwner = 0
      if currentOwner != 0:
        grid[y][x] = uint8 currentOwner
        inc areas[currentOwner]
      if totalDistances < 10_000:
        inc result.second
  let infinites = findInfiniteAreas grid
  for i, area in areas:
    if uint8(i) notin infinites and area > result.first:
      result.first = area


let solutions = solve()
echo solutions.first
echo solutions.second

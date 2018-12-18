import strutils, sequtils

let
  input = readFile("./inputs/18.txt").splitLines
  gridSize = input.len

const
  openAcre = '.'
  tree = '|'
  lumberyard = '#'
type LumberArea = seq[string]

var grid = newSeqWith(gridSize+2, ' '.repeat(gridSize+2))
for i, line in input:
  for j, c in line:
    grid[i+1][j+1] = c


func countNeighbours(grid: LumberArea, i, j: int, c: char): int =
  for y in i-1 .. i+1:
    for x in j-1 .. j+1:
      if grid[y][x] == c:
        inc result

func evolvePoint(grid: LumberArea, i, j: int): char =
  result = case grid[i][j]
    of openAcre:
      if grid.countNeighbours(i, j, tree) >= 3: tree else: openAcre
    of tree:
      if grid.countNeighbours(i, j, lumberyard) >= 3: lumberyard else: tree
    of lumberyard:
      if grid.countNeighbours(i, j, lumberyard) > 1 and
         grid.countNeighbours(i, j, tree) >= 1:
        lumberyard
      else: openAcre
    else: ' '

func evolveArea(grid: LumberArea): LumberArea =
  result = grid
  for i in 0 ..< grid.len:
    for j in 0 ..< grid[0].len:
      result[i][j] = grid.evolvePoint(i, j)

func numberOf(grid: LumberArea, c: char): int =
  for line in grid:
    result += line.count(c)

func resourceValue(grid: LumberArea): int =
  let
    trees = grid.numberOf(tree)
    lumberyards = grid.numberOf(lumberyard)
  result = trees * lumberyards


func first(grid: LumberArea, totalSteps = 10): int =
  var grid = grid
  for step in 1 .. totalSteps:
    grid = grid.evolveArea
  result = resourceValue grid

func second(grid: LumberArea, totalSteps = 1_000_000_000): int =
  var
    grid = grid
    seen = @[grid]
    stoppedAt, period, index: int
  for step in 1 .. totalSteps:
    grid = grid.evolveArea
    index = seen.find(grid)
    if index > -1:
      stoppedAt = step
      period = step - index
      break
    else: seen.add grid
  let remaining = (totalSteps - stoppedAt) mod period
  result = resourceValue seen[index + remaining]


echo grid.first
echo grid.second

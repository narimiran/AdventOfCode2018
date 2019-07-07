import strutils, strscans

type
  Tile = enum
    sand, clay, flowingWater, stillWater
  Ground = array[0..2000, array[350..600, Tile]]
  WaterFlow = enum
    vertical, horizontal
  Position = tuple[x, y: int]

template `[]`(g: Ground, p: Position): untyped = g[p.y][p.x]
template `[]=`(g: Ground, p: Position, v: Tile): untyped = g[p.y][p.x] = v
template below(p: Position): Position = (p.x, p.y+1)
template above(p: Position): Position = (p.x, p.y-1)
template left(p: Position): Position = (p.x-1, p.y)
template right(p: Position): Position = (p.x+1, p.y)

const
  input = "./inputs/17.txt"
  startingX = 500
var
  minY = int.high
  maxY = int.low

proc constructGround(input: string, minY, maxY: var int): Ground =
  var x, xa, xb, y, ya, yb: int
  for line in input.lines:
    if line.scanf("x=$i, y=$i..$i", x, ya, yb):
      for y in ya..yb:
        result[y][x] = clay
      if ya < minY: minY = ya
      if yb > maxY: maxY = yb
    elif line.scanf("y=$i, x=$i..$i", y, xa, xb):
      for x in xa..xb:
        result[y][x] = clay
      if y < minY: minY = y
      if y > maxY: maxY = y

func makeStillWater(g: var Ground, pos: Position) =
  var a, b = pos.x
  while g[pos.y][a] == flowingWater: dec a
  while g[pos.y][b] == flowingWater: inc b
  if g[pos.y][a] == clay and g[pos.y][b] == clay:
    for x in a+1 .. b-1:
      g[pos.y][x] = stillWater

proc flow(g: var Ground, flow: WaterFlow, pos: Position) =
  if pos.y > maxY: return

  if g[pos] != stillWater: g[pos] = flowingWater

  if g[pos.below] == sand:
    g.flow vertical, pos.below
  elif g[pos.below] in {stillWater, clay}:
    if g[pos.left] == sand:
      g.flow horizontal, pos.left
    if g[pos.right] == sand:
      g.flow horizontal, pos.right
    g.makeStillWater pos
    if g[pos] == stillWater and flow == vertical:
      g.flow vertical, pos.above

func countWaterTiles(g: Ground): tuple[flowing, still, total: int] =
  for y in g:
    for x in y:
      if x == flowingWater:
        inc result.flowing
      elif x == stillWater:
        inc result.still
  result.total = result.still + result.flowing


var ground = constructGround(input, minY, maxY)

ground.flow vertical, (startingX, minY)

let solutions = ground.countWaterTiles
echo solutions.total
echo solutions.still

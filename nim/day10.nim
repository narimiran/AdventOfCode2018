import strutils, sequtils, re
import unpack # nimble install unpack

let input = readFile("./inputs/10.txt").splitLines

const initialWait = 10_000 # positions are ~10000x larger than velocities

type
  Star = tuple[x, y, vx, vy: int]
  StarryNight = seq[Star]
  Boundary = tuple[min, max: int]
var
  nightSky: StarryNight
  time: int
  messageSpotted: bool

for line in input:
  [x, y, vx, vy] <- line.findAll(re"-?\d+").map(parseInt)
  nightSky.add (x + initialWait*vx, y + initialWait*vy, vx, vy)


template boundary(nightSky: StarryNight, field: untyped): Boundary =
  var edge: Boundary
  edge.min = nightSky.foldl(min(a, b.field), int.high)
  edge.max = nightSky.foldl(max(a, b.field), int.low)
  edge

func isCompact(boundaries: Boundary): bool =
  boundaries.max - boundaries.min < 10

proc show(nightSky: StarryNight) =
  let
    (minX, maxX) = nightSky.boundary x
    (minY, maxY) = nightSky.boundary y
    horizontalSpace = maxX - minX + 1
    verticalSpace = maxY - minY + 1
  var display = newSeqWith(verticalSpace, spaces(horizontalSpace))

  for star in nightSky:
    display[star.y - minY][star.x - minX] = '#'
  for line in display:
    echo line


while not messageSpotted:
  inc time
  for i, star in nightSky:
    (nightSky[i].x, nightSky[i].y) = (star.x + star.vx, star.y + star.vy)
  if nightSky.boundary(y).isCompact:
    show nightSky
    messageSpotted = true
    echo initialWait + time

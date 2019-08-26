import heapqueue

const
  depth = 6084
  xLim = 30   # manually
  yLim = 710  # tweaked

type
  Position = tuple[x, y: int]
  RegionType = enum
    rocky, wet, narrow
  Tool = enum
    # forbidden tool for each RegionType:
    neither, torch, climbing
  PosDetails = tuple
    pos: Position
    tool: Tool
    time: int
  Grid[T] = array[xLim, array[yLim, T]]

template `[]`(m: typed, p: Position): untyped = m[p.x][p.y]
template `[]=`(m: typed, p: Position, v: typed): untyped = m[p.x][p.y] = v

proc `<`(a, b: PosDetails): bool =
  # Calculating priority for heapqueue.
  # We're going mostly in y-direction, x can be ignored.
  a.time - a.pos.y < b.time - b.pos.y


let target = (x: 14, y: 709)
var
  eroMap: Grid[int]
  regMap: Grid[RegionType]

proc erosionLevel(p: Position, geoInd: int): int =
  (geoInd + depth) mod 20183

proc tileType(p: Position): RegionType =
  RegionType(eroMap[p] mod 3)


proc geologicIndex(p: Position): int =
  if p == (0, 0) or p == target: 0
  else:
    let (x, y) = p
    if y == 0: 16807 * x
    elif x == 0: 48271 * y
    else: eroMap[x-1][y] * eroMap[x][y-1]

proc createMaps =
  var pos = (x: 0, y: 0)
  while pos.x < xLim:
    pos.y = 0
    while pos.y < yLim:
      let geoInd = geologicIndex pos
      eroMap[pos] = erosionLevel(pos, geoInd)
      regMap[pos] = tileType pos
      inc pos.y
    inc pos.x

createMaps()


proc riskLevel: int =
  for x in 0 .. target.x:
    for y in 0 .. target.y:
      result += ord regMap[x][y]


proc isValidCoord(p: Position): bool =
  p.x >= 0 and p.x < xLim and p.y >= 0 and p.y < yLim

proc switchTool(current, forbidden: Tool): Tool =
  for t in {neither, torch, climbing} - {current, forbidden}:
    return t

iterator neighbours(p: Position): Position =
  yield (p.x-1, p.y)
  yield (p.x+1, p.y)
  yield (p.x, p.y-1)
  yield (p.x, p.y+1)

proc reachTarget: int =
  var
    minutes: array[Tool, Grid[int]]
    queue = initHeapQueue[PosDetails]()
    start = (x: 0, y: 0)
    current = (pos: start, tool: torch, time: 0)
  queue.push current

  while queue.len > 0:
    current = queue.pop
    if current.pos == target and current.tool == torch:
      return current.time

    let otherTool = switchTool(current.tool, Tool(regMap[current.pos]))
    queue.push (pos: current.pos, tool: otherTool, time: current.time+7)

    for neighbour in current.pos.neighbours:
      if neighbour.isValidCoord and current.tool != Tool(regMap[neighbour]):
        let time = current.time + 1
        if minutes[current.tool][neighbour] == 0 or time < minutes[current.tool][neighbour]:
          minutes[current.tool][neighbour] = time
          queue.push (pos: neighbour, tool: current.tool, time: time)


echo riskLevel()
echo reachTarget()

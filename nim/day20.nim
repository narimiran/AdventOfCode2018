import sets

let input = readFile "./inputs/20.txt"

const
  limits = 101

type
  Tile = enum
    wall, room, door
  Direction = enum
    north, south, west, east
  Map = array[-limits..limits, array[-limits..limits, Tile]]
  Position = tuple[x, y: int]

template `[]`(m: Map, p: Position): untyped = m[p.y][p.x]
template `[]=`(m: Map, p: Position, v: Tile): untyped = m[p.y][p.x] = v

template go(d: Direction): untyped =
  case d
  of north: dec p.y
  of south: inc p.y
  of west: dec p.x
  of east: inc p.x

template move(d: Direction): untyped =
  go d; m[p] = door
  go d; m[p] = room

proc move(m: var Map, p: var Position, c: char) =
  case c
  of 'N': move north
  of 'S': move south
  of 'W': move west
  of 'E': move east
  else: discard

proc makeMap(input: string): Map =
  var
    pos: Position
    positionStack: seq[Position]
  result[0][0] = room
  for c in input:
    case c
    of 'N', 'E', 'W', 'S': result.move pos, c
    of '(': positionStack.add pos
    of '|': pos = positionStack[^1]
    of ')': pos = pop positionStack
    else: discard


type
  Neigbhour = tuple[between, room: Position]
  Solution = tuple[first, second: int]

proc neighbours(p: Position): array[4, Neigbhour] =
  let (x, y) = p
  result = [((x-1, y), (x-2, y)),
            ((x+1, y), (x+2, y)),
            ((x, y-1), (x, y-2)),
            ((x, y+1), (x, y+2))]

proc dfs(m: Map): Solution =
  var
    seen: HashSet[Position]
    stack: seq[(Position, int)]
  stack.add ((0, 0), 0)

  while stack.len > 0:
    let (pos, dist) = pop stack
    seen.incl pos
    if dist > result.first: result.first = dist
    if dist >= 1000: inc result.second
    for (b, r) in neighbours(pos):
      if m[b] == door and r notin seen:
        stack.add (r, dist+1)


let solutions = dfs(makeMap input)

echo solutions.first
echo solutions.second

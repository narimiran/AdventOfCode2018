let input = readFile "./inputs/20.txt"

const
  limits = 50

type
  Distance = int
  DistanceMap = array[-limits..limits, array[-limits..limits, Distance]]
  Position = tuple[x, y: int]
  Solution = tuple[first, second: int]

template `[]`(m: DistanceMap, p: Position): untyped = m[p.y][p.x]
template `[]=`(m: DistanceMap, p: Position, v: int): untyped = m[p.y][p.x] = v


proc move(p: var Position, c: char) =
  case c
  of 'N': dec p.y
  of 'S': inc p.y
  of 'W': dec p.x
  of 'E': inc p.x
  else: discard

proc createDistanceMap(input: string): DistanceMap =
  var
    pos: Position
    dist: Distance
    stack = newSeqOfCap[(Position, Distance)](256)
  for c in input:
    case c
    of 'N', 'E', 'W', 'S':
      pos.move c
      inc dist
      if result[pos] == 0 or dist < result[pos]:
        result[pos] = dist
    of '(': stack.add (pos, dist)
    of '|': (pos, dist) = stack[^1]
    of ')': (pos, dist) = pop stack
    else: discard

proc countDistances(a: DistanceMap): Solution =
  for row in a:
    for x in row:
      if x > result.first: result.first = x
      if x >= 1000: inc result.second


let distMap = createDistanceMap input
let solutions = countDistances distMap

echo solutions.first
echo solutions.second

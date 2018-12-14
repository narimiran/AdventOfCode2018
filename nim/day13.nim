import strutils, algorithm

let input = readFile("./inputs/13.txt").splitLines

type
  IntersectionChoice = enum
    turnLeft, goStraight, turnRight
  Cartesian = tuple
    x, y: int
  Cart = object
    pos: Cartesian
    dir: Cartesian
    choice: IntersectionChoice
    isDead: bool
  Carts = seq[Cart]
  TrackMap = seq[string]

func `<`(a, b: Cart): bool =
  # Enables cart sorting.
  (a.pos.y < b.pos.y) or (a.pos.y == b.pos.y and a.pos.x < b.pos.x)

func next(a: var IntersectionChoice) =
  # Cycles through intersection options.
  a = IntersectionChoice((ord(a) + 1) mod 3)

func `$`(a: Cartesian): string =
  # Prints the solution in the correct format.
  $a.x & "," & $a.y

func alive(carts: Carts): int =
  for cart in carts:
    if not cart.isDead:
      inc result

func lastCartStanding(carts: Carts): Cartesian =
  for cart in carts:
    if not cart.isDead:
      return (cart.pos.x, cart.pos.y)

func changeDirection(cart: Cart): Cartesian =
  result = case cart.choice
    of turnLeft: (cart.dir.y, -cart.dir.x)
    of goStraight: cart.dir
    of turnRight: (-cart.dir.y, cart.dir.x)

func makeTurnAt(cart: Cart, turnShape: char): Cartesian =
  if turnShape == '/': (-cart.dir.y, -cart.dir.x) else: (cart.dir.y, cart.dir.x)


var
  tracks: TrackMap
  carts: Carts

for y, line in input:
  for x, c in line:
    var direction: Cartesian
    case c
      of '^': direction = ( 0,-1)
      of '<': direction = (-1, 0)
      of 'v': direction = ( 0, 1)
      of '>': direction = ( 1, 0)
      else: continue
    carts.add Cart(pos: (x, y), dir: direction)
  tracks.add line


var
  foundFirst: bool
  first: Cartesian

while alive(carts) > 1:
  sort carts
  for i, c1 in carts:
    if c1.isDead:
      continue
    let (x, y) = (c1.pos.x + c1.dir.x, c1.pos.y + c1.dir.y)
    for j, c2 in carts:
      if c2.isDead:
        continue
      if c2.pos.x == x and c2.pos.y == y:
        if not foundFirst:
          first = (x, y)
          foundFirst = true
        carts[i].isDead = true
        carts[j].isDead = true
        break
    (carts[i].pos.x, carts[i].pos.y) = (x, y)
    case tracks[y][x]
      of '+':
        carts[i].dir = changeDirection c1
        next carts[i].choice
      of '\\', '/':
        carts[i].dir = c1.makeTurnAt tracks[y][x]
      else: discard


echo first
echo carts.lastCartStanding

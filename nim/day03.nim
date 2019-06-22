import strscans

let input = "./inputs/03.txt"

const size = 1000
type
  Claim = tuple
    id, x, y, w, h: int16
  Fabric = array[size, array[size, int16]]

template forGrid(start1, size1, start2, size2: int, body: untyped) =
  for i {.inject.} in start1 ..< start1 + size1:
    for j {.inject.} in start2 ..< start2 + size2:
      body

template ifOverlappingFabric(start1, size1, start2, size2: int, body: untyped) =
  forGrid(start1, size1, start2, size2):
    if fabric[i][j] > 1:
      body


var
  fabric: Fabric
  claims: seq[Claim]

for line in input.lines:
  var id, x, y, w, h: int
  if line.scanf("#$i @ $i,$i: $ix$i", id, x, y, w, h):
    forGrid(y, h, x, w):
      inc fabric[i][j]
    claims.add (id.int16, x.int16, y.int16, w.int16, h.int16)

proc first(): int =
  ifOverlappingFabric(0, size, 0, size):
    inc result

proc second(): int =
  for c in claims:
    block outer:
      ifOverlappingFabric(c.y, c.h, c.x, c.w):
        break outer
      return c.id


echo first()
echo second()

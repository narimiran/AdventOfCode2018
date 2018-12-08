import strscans

let input = "./inputs/03.txt"

const size = 1000
type
  Claim = tuple
    id, x, y, w, h: int
var
  fabric: array[size, array[size, int]]
  claims: seq[Claim]

for line in input.lines:
  var id, x, y, w, h: int
  if line.scanf("#$i @ $i,$i: $ix$i", id, x, y, w, h):
    for i in y ..< y+h:
      for j in x ..< x+w:
        inc fabric[i][j]
    claims.add (id, x, y, w, h)


proc first(): int =
  for i in 0 ..< size:
    for j in 0 ..< size:
      if fabric[i][j] > 1:
        inc result

proc second(): int =
  for c in claims:
    block outer:
      for i in c.y ..< (c.y + c.h):
        for j in c.x ..< (c.x + c.w):
          if fabric[i][j] > 1:
            break outer
      return c.id


echo first()
echo second()

import strscans, sets

type
  Star = tuple[w, x, y, z: int]
  Constellation = HashSet[Star]
  Sky = seq[Constellation]

proc readInput(f: string): seq[Star] =
  var w, x, y, z: int
  for line in f.lines:
    if line.scanf("$i,$i,$i,$i", w, x, y, z):
      result.add (w, x, y, z)

func manhattan(a, b: Star): int =
  abs(a.w - b.w) + abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)

func createConstellations(stars: seq[Star]): Sky =
  for star in stars:
    result.add toHashSet(@[star])

func areSameConstellation(a, b: Constellation): bool =
  for c1 in a:
    for c2 in b:
      if manhattan(c1, c2) <= 3:
        return true

proc processSky(sky: Sky): int =
  var sky = sky
  var somethingChanged = true
  while somethingChanged:
    somethingChanged = false
    for i in 0 ..< sky.len:
      if sky[i].card > 0:
        for j in i+1 ..< sky.len:
          if sky[j].card > 0 and areSameConstellation(sky[i], sky[j]):
            somethingChanged = true
            sky[i].incl sky[j]
            clear sky[j]
  for c in sky:
    if c.card > 0:
      inc result


let input = "./inputs/25.txt"
let stars = readInput(input)
let sky = createConstellations(stars)
echo processSky(sky)

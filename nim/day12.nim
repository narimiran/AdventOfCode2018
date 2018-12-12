import strutils, strscans

let input = "./inputs/12.txt"

const
  length = 300
  leftPad = 50
var
  state = ".".repeat(length)
  fruitful: seq[string]

for line in input.lines:
  var s: string
  if line.scanf("initial state:"):
    let initial = line.split[^1]
    for i in 0 ..< initial.len:
      state[leftPad + i] = initial[i]
  elif line.scanf("$+ => #", s):
    fruitful.add s


type PlantCount = tuple[plants, total: int]

func countPlants(state: string): PlantCount =
  for i, c in state:
    if c == '#':
      result.plants += 1
      result.total += i - leftPad

proc live(state: string, generations: int64): int64 =
  var
    previous: PlantCount
    state = state
    newState: string
  for generation in 1 .. generations:
    newState = ".".repeat(length)
    for i in 2 ..< length-2:
      if state[i-2 .. i+2] in fruitful:
        newState[i] = '#'
    let (plants, total) = countPlants newState
    if plants == previous.plants and total == previous.total + plants:
      let remaining = generations - generation
      return total + plants * remaining
    previous = (plants, total)
    state = newState
  return previous.total


echo state.live(20)
echo state.live(50_000_000_000)

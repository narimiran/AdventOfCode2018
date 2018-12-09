# use `--gc:regions` flag when compiling
import lists

const
  nrOfPlayers = 410
  totalMarbles = 72059

var
  circle = initDoublyLinkedRing[int]()
  scores: array[nrOfPlayers, int]

circle.append 0


proc collect(marble: int) =
  for i in 1 .. 7:
    circle.head = circle.head.prev
  let toRemove = circle.head.prev.prev
  scores[marble mod nrOfPlayers] += marble + toRemove.value
  circle.remove toRemove

proc playTurn(marble: int) =
  circle.head = circle.head.next
  if marble mod 23 == 0:
    collect marble
  else:
    circle.append marble


for marble in 1 ..< totalMarbles:
  playTurn marble
echo scores.max

for marble in totalMarbles ..< totalMarbles*100:
  playTurn marble
echo scores.max

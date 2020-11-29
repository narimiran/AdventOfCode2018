import strscans, heapqueue, tables

let input = "./inputs/07.txt"

var
  predecessors = initTable[char, set[char]]()
  successors = initTable[char, set[char]]()
  availableAtStart = initHeapQueue[char]()

for line in input.lines:
  var before, after: string
  if line.scanf("Step $w must be finished before step $w can begin.", before, after):
    let (a, b) = (after[0], before[0])
    if not predecessors.hasKey(a): predecessors[a] = {}
    if not successors.hasKey(b): successors[b] = {}
    predecessors[a].incl b
    successors[b].incl a

for letter in {'A' .. 'Z'}:
  if not predecessors.hasKey(letter):
    availableAtStart.push letter


proc solve(workers: int): (string, int) =
  var
    remainingPredecessors = predecessors
    availableLetters = availableAtStart
    availableWorkers = workers
    workingQueue = initHeapQueue[(int, char)]()

  proc processingTime(x: char): int =
    if availableWorkers == 1: 0 else: ord(x) - 4

  proc getBusy(time = 0) =
    while availableLetters.len > 0 and availableWorkers > 0:
      dec availableWorkers
      let currentLetter = availableLetters.pop
      workingQueue.push (time + currentLetter.processingTime, currentLetter)

  getBusy()

  while workingQueue.len > 0:
    let (currentTime, letter) = workingQueue.pop
    inc availableWorkers
    result[0].add letter
    result[1] = currentTime

    if not successors.hasKey(letter): break

    for s in successors[letter]:
      remainingPredecessors[s].excl letter
      if remainingPredecessors[s].card == 0:
        availableLetters.push s

    getBusy(currentTime)


echo solve(workers = 1)[0]
echo solve(workers = 5)[1]

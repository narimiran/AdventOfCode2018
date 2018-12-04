import strutils, strscans, algorithm, tables

let input = readFile("./inputs/04.txt").splitLines

type
  MidnightHour = array[60, int]
  Guard = tuple
    sleepStart: int
    sleepTimes: MidnightHour
  Solution = tuple
    minute, guard: int

var
  currentGuard: int
  guards = initTable[int, Guard]()

for i, line in input.sorted:
  var
    date: string
    hh, mm, gid: int

  if line.scanf("[$+ $i:$i] Guard #$i begins shift", date, hh, mm, gid):
    currentGuard = gid
    if not guards.hasKey(gid):
      var mh: MidnightHour
      guards[gid] = (0, mh)

  if line.scanf("[$+ $i:$i] falls asleep", date, hh, mm):
    guards[currentGuard].sleepStart = mm

  if line.scanf("[$+ $i:$i] wakes up", date, hh, mm):
    for m in guards[currentGuard].sleepStart ..< mm:
      inc guards[currentGuard].sleepTimes[m]


var
  totalSleepingTime, maxSleepAmount: int
  first, second: Solution

for guard, info in guards.pairs:
  var sleepingTime, maxAmount, maxMinute: int

  for minute, amount in info.sleepTimes:
    sleepingTime += amount
    if amount > maxAmount:
      maxAmount = amount
      maxMinute = minute
    if amount > maxSleepAmount:
      maxSleepAmount = amount
      second = (minute, guard)

  if sleepingTime > totalSleepingTime:
    totalSleepingTime = sleepingTime
    first = (maxMinute, guard)


echo first.minute * first.guard
echo second.minute * second.guard

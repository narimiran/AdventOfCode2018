import strutils, strscans, algorithm, tables

let input = readFile("./inputs/04.txt").splitLines

type
  SleepRecord = array[60, int]
  Solution = tuple
    minute, guard: int

var
  currentGuard, sleepStart: int
  guards = initTable[int, SleepRecord]()

for i, line in sorted input:
  var
    date: string
    hh, mm, guard: int

  if line.scanf("[$+ $i:$i] Guard #$i begins shift", date, hh, mm, guard):
    currentGuard = guard
    if not guards.hasKey(guard):
      var sr: SleepRecord
      guards[guard] = sr
  if line.scanf("[$+ $i:$i] falls asleep", date, hh, mm):
    sleepStart = mm
  if line.scanf("[$+ $i:$i] wakes up", date, hh, mm):
    for m in sleepStart ..< mm:
      inc guards[currentGuard][m]


var
  highestSleepingTime, maxSleepAmount: int
  first, second: Solution

for guard, sleepRecord in guards.pairs:
  var sleepingTime, maxAmount, sleepiestMinute: int

  for minute, slept in sleepRecord:
    sleepingTime += slept
    if slept > maxAmount:
      maxAmount = slept
      sleepiestMinute = minute
    if slept > maxSleepAmount:
      maxSleepAmount = slept
      second = (minute, guard)

  if sleepingTime > highestSleepingTime:
    highestSleepingTime = sleepingTime
    first = (sleepiestMinute, guard)

proc `$`(x: Solution): string =
  $(x.minute * x.guard)

echo first
echo second

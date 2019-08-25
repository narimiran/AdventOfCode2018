import sets

const
  m1 = 0x10000
  m2 = 0xff
  m3 = 0xffffff
  n = 65_899
  d = 256
  r = 4_843_319

template `&=`(a, b: int): untyped =
  a = a and b

proc loop(r2: int): int =
  var
    r5 = r2 or m1
    r2 = r
  while r5 > 0:
    r2 += r5 and m2
    r2 &= m3
    r2 *= n
    r2 &= m3
    r5 = r5 div d
  return r2

proc second: int =
  var
    seen: HashSet[int]
    i, n: int
  while true:
    n = loop i
    if seen.containsOrIncl n:
      return i
    i = n


let first = loop 0

echo first
echo second()

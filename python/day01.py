from aoc import read_input
from itertools import cycle, accumulate


data = read_input(1, int)

print(sum(data))

seen = set()
print(next(f for f in accumulate(cycle(data)) if f in seen or seen.add(f)))
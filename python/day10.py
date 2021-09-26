from aoc import *
from itertools import count


positions = lambda data, t: [(x + dx*t, y + dy*t) for (x, y, dx, dy) in data]
boundaries = lambda positions: (lambda xs, ys: (min(xs), max(xs), min(ys), max(ys)))(*zip(*positions))
area = lambda xmin, xmax, ymin, ymax: (xmax - xmin) * (ymax - ymin)
size = lambda data, t: area(*boundaries(positions(data, t)))


data = mapl(extract_numbers, read_input(10))

INITIAL_WAIT = 10_000 # positions are ~10_000x larger than velocities
time = first(t for t in count(INITIAL_WAIT) if size(data, t) < size(data, t+1))
stars = positions(data, time)
xmin, xmax, ymin, ymax = boundaries(stars)

print('\n'.join(cat(" #"[(x, y) in stars] for x in range(xmin, xmax+1))
                for y in range(ymin, ymax+1)))
print(time)

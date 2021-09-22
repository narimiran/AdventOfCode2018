from aoc import *
from collections import Counter
from itertools import product


def find_owner(point, coords):
    c1, c2 = sorted(coords, key = lambda p: manhattan(p, point))[:2]
    return c1 if manhattan(c1, point) < manhattan(c2, point) else None

def finite_areas(coords):
    owned_points = Counter(find_owner(pt, coords) for pt in product(x_lim, y_lim))
    border = ({(min(x_lim), y) for y in y_lim} |
              {(max(x_lim), y) for y in y_lim} |
              {(x, min(y_lim)) for x in x_lim} |
              {(x, max(y_lim)) for x in x_lim})
    infinite = {find_owner(pt, coords) for pt in border}
    return {pt: cnt for pt, cnt in owned_points.items() if pt not in infinite}

def part_2(coords, dist = 10_000):
    return count(product(x_lim, y_lim), lambda pt: sum(manhattan(pt, coord) for coord in coords) < dist)


coords = mapl(extract_numbers, read_input(6))
x_lim, y_lim = map(lambda c: range(min(c), max(c)+1), zip(*coords))

print(max(finite_areas(coords).values()))
print(part_2(coords))

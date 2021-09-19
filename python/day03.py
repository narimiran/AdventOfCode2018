from aoc import *


def make_fabric(data):
    fabric = [[0 for _ in range(1000)] for _ in range(1000)]
    for _, x, y, w, h in data:
        for dy in range(h):
            for dx in range(w):
                fabric[y+dy][x+dx] += 1
    return fabric

part_1 = lambda fabric: sum(count(row, lambda x: x > 1) for row in fabric)

part_2 = lambda data, fabric: next(i for i, x, y, w, h in data
                                   if all(fabric[y+dy][x+dx] == 1
                                          for dy in range(h) for dx in range(w)))

data = mapl(extract_numbers, read_input(3))
fabric = make_fabric(data)

print(part_1(fabric))
print(part_2(data, fabric))

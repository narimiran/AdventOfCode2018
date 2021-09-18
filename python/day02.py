from aoc import read_input, cat
from collections import Counter
from itertools import product


def part_1(data):
    has_pairs, has_triplets = zip(*((2 in (c := Counter(row).values()), 3 in c) for row in data))
    return sum(has_pairs) * sum(has_triplets)

def part_2(data):
    l = len(data[0])
    for l1, l2 in product(data, repeat=2):
        r = [c1 for c1, c2 in zip(l1, l2) if c1 == c2]
        if len(r) == l - 1:
            return cat(r)


data = read_input(2)

print(part_1(data))
print(part_2(data))

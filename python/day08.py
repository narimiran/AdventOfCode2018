from aoc import *


def solve(kids, meta):
    if not kids:
        return 2 * (sum(next(data) for _ in range(meta)),)
    meta_sum = meta_val = 0
    kids_vals = {}
    for k in range(kids):
        ms, kv = solve(next(data), next(data))
        meta_sum += ms
        kids_vals[k+1] = kv
    for _ in range(meta):
        val = next(data)
        meta_sum += val
        meta_val += kids_vals.get(val, 0)
    return meta_sum, meta_val


data = iter(read_input_line(8, int))
print(solve(next(data), next(data)))

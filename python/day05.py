from aoc import *
from string import ascii_lowercase


def reactions(polymer):
    result = ['_']
    for unit in polymer:
        if ord(unit) ^ ord(result[-1]) == 32: # faster than `abs`
            result.pop()
        else:
            result.append(unit)
    return cat(result[1:])

part_2 = lambda polymer: min(len(reactions(polymer.replace(unit, '').replace(unit.upper(), '')))
                                 for unit in ascii_lowercase)


data = read_input_line(5)[0]
resulting_polymer = reactions(data)

print(len(resulting_polymer))
print(part_2(resulting_polymer))

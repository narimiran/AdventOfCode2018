from aoc import *
import re
from collections import defaultdict


def part_1(data):
    letters = {letter for line in data for letter in line}
    requirements = defaultdict(set)
    for (a, b) in data:
        requirements[b].add(a)
    is_available = lambda letter: not (letters & requirements[letter])
    result = []
    while letters:
        next_letter = min(filter(is_available, letters))
        result.append(next_letter)
        letters.remove(next_letter)
    return cat(result)


def part_2(data, workers = 1):
    letters = {letter for line in data for letter in line}
    end_times = {l: 999999 for l in letters}
    requirements = defaultdict(set)
    for (a, b) in data:
        requirements[b].add(a)
    time = 0
    while letters:
        workers += count(end_times[l] == time for l in end_times)
        is_available = lambda letter: all(end_times[l] <= time for l in requirements[letter])
        available_letters = sorted(filter(is_available, letters))
        for l in available_letters[:workers]:
            letters.remove(l)
            end_times[l] = time + ord(l) - 4
            workers -= 1
        time += 1
    return max(end_times.values())


data = mapl(lambda line: re.findall(" ([A-Z]) ", line), read_input(7))
print(part_1(data))
print(part_2(data, 5))

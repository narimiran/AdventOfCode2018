from collections import Counter, defaultdict
from aoc import *


def parse_input(data):
    guards = defaultdict(Counter)
    for line in data:
        last_digit = extract_numbers(line)[-1]
        if line[-2] == 'f': # ...shiFt
            current_guard = last_digit
        elif line[-2] == 'e': # ...asleEp
            sleep_start = last_digit
        elif line[-2] == 'u': # ...wakes Up
            guards[current_guard] += Counter(range(sleep_start, last_digit))
    return guards


def solve(guards):
    most_asleep = worst_minute = 0
    for guard, record in guards.items():
        if not record: continue
        sleepy_minutes = sum(record.values())
        sleepiest_minute = max(record.items(), key = lambda x: x[1])
        if sleepy_minutes > most_asleep:
            most_asleep = sleepy_minutes
            first_solution = guard * sleepiest_minute[0]
        if sleepiest_minute[1] > worst_minute:
            worst_minute = sleepiest_minute[1]
            second_solution = guard * sleepiest_minute[0]
    return first_solution, second_solution


data = sorted(read_input(4))
guards = parse_input(data)
print(solve(guards))

import re
from itertools import chain


cat = ''.join
flatten = chain.from_iterable


def mapl(f, iterable):
    return list(map(f, iterable))

def mapt(f, iterable):
    return tuple(map(f, iterable))

def read_input(filename, datatype=str, sep='\n'):
    filename = f"{filename:02d}" if isinstance(filename, int) else filename
    with open(f"inputs/{filename}.txt") as f:
        contents = f.read().strip().split(sep)
        return mapl(datatype, contents)

def read_input_line(filename, datatype=str, sep=' '):
    return read_input(filename, datatype=datatype, sep=sep)

def digits(line):
    return mapt(int, line)

def extract_numbers(line, negative=True):
    return mapt(int, re.findall(r"-?\d+" if negative else r"\d+", line))

def count(iterable, pred=bool):
    return sum(1 for item in iterable if pred(item))

def first(iterable, default=None):
    return next(iter(iterable), default)

def filter_first(iterable, pred):
    return first(el for el in iterable if pred(el))

def manhattan(x, y = (0, 0)):
    return abs(x[0] - y[0]) + abs(x[1] - y[1])

def sign(n):
    if n > 0: return 1
    elif n < 0: return -1
    else: return 0

def line_print(lines):
    for line in lines:
        print(cat(line))

def maxval(d):
    return max(d.values())

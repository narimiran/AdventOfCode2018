from aoc import *


SERIAL = 4172
GRID_SIZE = 300


power_level = lambda x, y: ((x + 10) * y + SERIAL) * (x + 10) // 100 % 10 - 5

def square_sum(grid, x, y, size=3):
    return grid[y][x] - grid[y-size][x] - grid[y][x-size] + grid[y-size][x-size]

def create_grid():
    grid = [[0 for _ in range(GRID_SIZE+1)] for _ in range(GRID_SIZE+1)]
    for y in range(1, GRID_SIZE+1):
        for x in range(1, GRID_SIZE+1):
            grid[y][x] = power_level(x, y) - square_sum(grid, x, y, 1)
    return grid

def most_powerful(grid, size=3):
    res = (0, 0, 0, 0)
    for y in range(size, GRID_SIZE+1):
        for x in range(size, GRID_SIZE+1):
            res = max(res, (square_sum(grid, x, y, size), x-size+1, y-size+1, size))
    return res

def most_powerful_any_size(grid):
    res = (0, 0, 0, 0)
    for size in range(2, GRID_SIZE):
        r = most_powerful(grid, size)
        res = max(res, r)
    return res


grid = create_grid()
print(most_powerful(grid)[1:3])
print(most_powerful_any_size(grid)[1:])

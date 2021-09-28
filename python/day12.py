from aoc import *


def grow(plants):
  creates_new_life = lambda i: cat('.#'[j in plants] for j in range(i-2, i+3)) in fruitful
  return [i for i in range(plants[0]-2, plants[-1]+3) if creates_new_life(i)]

def live(plants, generations=20):
  new_plants = plants[:]
  for _ in range(generations):
    new_plants = grow(new_plants)
  return new_plants

def part_2(plants, generations=50_000_000_000):
  after_200 = live(plants, 200)
  increase_rate = sum(grow(after_200)) - sum(after_200)
  return sum(after_200) + (generations - 200) * increase_rate


data = read_input(12)

initial = [i for i, c in enumerate(data[0][15:]) if c == '#']
fruitful = [(l := line.split())[0] for line in data[2:] if line[-1] == '#']

print(sum(live(initial)))
print(part_2(initial))

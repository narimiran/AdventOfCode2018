# Advent of Code 2018

My previous AoC repos:

* [AoC 2015 in Nim](https://github.com/narimiran/advent_of_code_2015)
* [AoC 2016 in Python](https://github.com/narimiran/advent_of_code_2016)
* [AoC 2017 in both Nim and Python](https://github.com/narimiran/AdventOfCode2017)


This year, I will do it once again in [Nim](https://nim-lang.org/), and later on maybe in some other language too.

My aim is to provide clean, readable, and idiomatic solutions.
If you have any comment/suggestion/advice, please let me know!


&nbsp;


## Solutions

Task | Solution | Comment
--- | --- | ---
[Day 1: Chronal Calibration](https://adventofcode.com/2018/day/1) | [day01.nim](nim/day01.nim) | Dogfooding by using [itertools](https://github.com/narimiran/itertools) to `cycle` through the input. The initial version used `sets`, but an array is twice as fast.
[Day 2: Inventory Management System](https://adventofcode.com/2018/day/2) | [day02.nim](nim/day02.nim) | Iterator `items` allows for tuple unpacking in for-loops.
[Day 3: No Matter How You Slice It](https://adventofcode.com/2018/day/3) | [day03.nim](nim/day03.nim) | No need for regex, `scanf` macro is great for these kinds of input.
[Day 4: Repose Record](https://adventofcode.com/2018/day/4) | [day04.nim](nim/day04.nim) | [2018-12-04 06:00] Guard narimiran begins shift
[Day 5: Alchemical Reduction](https://adventofcode.com/2018/day/5) | [day05.nim](nim/day05.nim) | 4x speed improvement when using the already shortened polymer (first part) for the second part.
[Day 6: Chronal Coordinates](https://adventofcode.com/2018/day/6) | [day06.nim](nim/day06.nim) | The slowest task so far.
[Day 7: The Sum of Its Parts](https://adventofcode.com/2018/day/7) | [day07.nim](nim/day07.nim) | Using `heapqueue` is a no-brainer here.
[Day 8: Memory Maneuver](https://adventofcode.com/2018/day/8) | [day08.nim](nim/day08.nim) | Using recursion is a no-brainer here.
[Day 9: Marble Mania](https://adventofcode.com/2018/day/9) | [day09.nim](nim/day09.nim) | Compile it with `--gc:regions` to get the most performance out of it.
[Day 10: The Stars Align](https://adventofcode.com/2018/day/10) | [day10.nim](nim/day10.nim) | The first usage of Nim templates this year. Using [unpack](https://github.com/technicallyagd/unpack) for `<-` sequence unpacking.
[Day 11: Chronal Charge](https://adventofcode.com/2018/day/11) | [day11.nim](nim/day11.nim) | Using [summed-area table](https://en.wikipedia.org/wiki/Summed-area_table) to have O(n^3) solution. (Naïve solution is O(n^5))
[Day 12: Subterranean Sustainability](https://adventofcode.com/2018/day/12) | [day12.nim](nim/day12.nim) | Nothing to write home about.
[Day 13: Mine Cart Madness](https://adventofcode.com/2018/day/13) | [day13.nim](nim/day13.nim) | Using [complex plane](https://en.wikipedia.org/wiki/Complex_plane) is the obvious choice in the tasks like this, but `complex` in Nim is limited to floats, so I decided to use plain old tuples of integers.
[Day 14: Chocolate Charts](https://adventofcode.com/2018/day/14) | [day14.nim](nim/day14.nim) | Using `int8` to keep the memory usage down.
[Day 15: Beverage Bandits](https://adventofcode.com/2018/day/15) | | Ain't nobody got time for that.
[Day 16: Chronal Classification](https://adventofcode.com/2018/day/16) | [day16.nim](nim/day16.nim) | Nim bitsets don't have `pop`.
[Day 17: Reservoir Research](https://adventofcode.com/2018/day/17) |  | Soon (TM)
[Day 18: Settlers of The North Pole](https://adventofcode.com/2018/day/18) | [day18.nim](nim/day18.nim) | Simplified boundary conditions by creating a border around the area.

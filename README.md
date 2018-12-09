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

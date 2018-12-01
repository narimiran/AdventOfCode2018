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

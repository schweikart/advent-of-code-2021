# Day 01: Sonar Sweep
The ["Sonar Sweep" problem](https://adventofcode.com/2021/day/1) is about finding increments in a list of numbers.

## Learnings and resources
I wanted to implement a solution that reads the puzzle input from a file. Since Haskell is a functional language, the usual pure functions do not allow accessing files and similar resources functions. The following guide helped me to understand IO Monads, a concept that allows accessing external resources through "IO actions":
* [Learn you a Haskell for Great Good: Input and Output](http://learnyouahaskell.com/input-and-output) (at the time of writing this, the website is unavailable but can still be [accessed through the Wayback Machine](https://web.archive.org/web/20211102000749/http://learnyouahaskell.com/input-and-output))

## File structure
* [`./day01.hs`](./day01.hs): My solution for part one of this puzzle
* [`./input.txt`](./input.txt): My personal puzzle input for this challenge
* [`./README.md`](./README.md): documentation for this solution :)

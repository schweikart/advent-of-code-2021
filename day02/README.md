# Day 02: Dive!
The ["Dive!" problem](https://adventofcode.com/2021/day/2) is about parsing and executing commands based on twodimensional positioning data.

## Learnings and resources
The command typings given in the exercise closely resemble the data type declaration syntax, so I read up about data type declarations on the Haskell wiki:
* [Haskell Wiki: Type](https://wiki.haskell.org/Type)

For debugging purposes, I made my type implement the "Show" class and implemented the "show" method for my type, as shown in this post:
* [StackOverflow: "Haskell: Deriving Show for custom type"](https://stackoverflow.com/a/6082118/5424404)

After having implemented the solutions for both parts, I realized that I could use a folding operation to apply the position changes dictated by the given commands.
I learned that `foldr` and `foldl` have different results if the combinator function (`applyCommandPartTwo`, in this case) is not associative.
The combination function's arguments are also flipped:
* [StackOverflow: "Haskell - foldl and foldr?"](https://stackoverflow.com/a/13280185/5424404)

## File structure
* [`./day02.hs`](./day02.hs): My solution for part one of this puzzle
* [`./input.txt`](./input.txt): My personal puzzle input for this challenge
* [`./README.md`](./README.md): documentation for this solution :)

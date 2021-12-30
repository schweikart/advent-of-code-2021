main = do
    input <- readFile "input.txt"
    let parsed = parseInput input
        increments = countIncrements parsed
        tripleIncrements = countTripleIncrements parsed
    putStrLn ("Solution to part one: " ++ show increments ++ " increments")
    putStrLn ("Solution to part two: " ++ show tripleIncrements ++ " increments")

{-|
Parses an integer list from file contents that contain one decimal integer per line.
-}
parseInput :: String -> [Int]
parseInput input = map read (lines input)

{-|
Count the number of times a that a measurement value is higher than it's predecessor.
-}
countIncrements :: [Int] -> Int
countIncrements [] = 0
countIncrements [x] = 0
countIncrements (first:rest@(second:_)) = (if first < second then 1 else 0) + countIncrements rest

{-|
Counts the number of times the sum of measurements in three-measurement sliding windows increases in the given input list.
-}
countTripleIncrements :: [Int] -> Int
countTripleIncrements = countIncrements . makeTripleSums

{-|
Builds a list of three-measurement sliding windows from the given list.
-}
makeTripleSums :: [Int] -> [Int]
makeTripleSums [] = []
makeTripleSums entries@(first:rest)
    | enoughForTriple entries = tripleSum entries : makeTripleSums rest -- if there are three items left, build a 3-sum and attach it to the front of acc
    | otherwise = []
    where tripleSum list = sum (take 3 list)
          enoughForTriple list = length (take 3 entries) == 3

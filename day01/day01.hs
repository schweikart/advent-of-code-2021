main = do
    input <- readFile "input.txt"
    let parsed = parseInput input
        increments = countIncrements parsed
    putStrLn ("Solution to part one: " ++ show increments ++ " increments")

parseInput :: String -> [Int]
parseInput input = map read (lines input)

countIncrements :: [Int] -> Int
countIncrements [] = 0
countIncrements [x] = 0
countIncrements (first:bigrest@(second:rest)) = (if first < second then 1 else 0) + countIncrements bigrest

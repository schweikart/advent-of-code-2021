data Command = Forward Int | Down Int | Up Int
instance Show Command where
    show (Forward amount) = "forward " ++ show amount
    show (Down amount) = "down " ++ show amount
    show (Up amount) = "up " ++ show amount

main = do
    input <- readFile "input.txt"
    let parsed = parseInput input
        (endHor1,endDep1) = calculateEndPositionPartOne parsed
    putStrLn ("Solution to part one: " ++ show (endHor1 * endDep1))
    let (endHor2, endDep2, _) = calculateEndPositionPartTwo parsed
    putStrLn ("Solution to part two: " ++ show (endHor2 * endDep2))

{-|
Parses a list of commands from the contents of an input file.
-}
parseInput :: String -> [Command]
parseInput input = map (parseCommand . words) (lines input) where
    parseCommand :: [String] -> Command -- parses the words of a line into a command
    parseCommand (cmd:amt:_)
        | cmd == "forward" = Forward (read amt)
        | cmd == "down" = Down (read amt)
        | cmd == "up" = Up (read amt)

{-|
Calculates the end position (horizontal position, depth) of the submarine when applying the given set of commands
using the interpretation of part one of the puzzle.

>>> calculateEndPositionPartOne [Forward 5, Down 5, Forward 8, Up 3, Down 8, Forward 2]
(15,10)
-}
calculateEndPositionPartOne :: [Command] -> (Int, Int)
calculateEndPositionPartOne = foldl applyCommandPartOne (0,0) -- partial application of foldr

{-|
Applies the position (horizontal position, depth) update given through a command,
by the interpretation of part one of the puzzle.
-}
applyCommandPartOne :: (Int, Int) -> Command -> (Int, Int)
applyCommandPartOne (hor,dep) (Forward amt) = (hor + amt, dep)
applyCommandPartOne (hor,dep) (Down amt)    = (hor,       dep + amt) -- note that "down" increases the depth
applyCommandPartOne (hor,dep) (Up amt)      = (hor,       dep - amt)

{-|
Calculates the end position (horizontal position, depth, aim) of the submarine when applying the given set of commands
using the interpretation of part two of the puzzle.

>>> calculateEndPositionPartTwo [Forward 5, Down 5, Forward 8, Up 3, Down 8, Forward 2]
(15,60,10)
-}
calculateEndPositionPartTwo :: [Command] -> (Int, Int, Int)
calculateEndPositionPartTwo = foldl applyCommandPartTwo (0,0,0) -- partial application of foldl

{-|
Applies the position (horizontal position, depth, aim) update given through a command,
by the interpretation of part two of the puzzle.

>>> applyCommandPartTwo (5,0,0) (Down 5)
(5,0,5)
-}
applyCommandPartTwo :: (Int, Int, Int) -> Command -> (Int, Int, Int)
applyCommandPartTwo (hor,dep,aim) (Forward amt) = (hor + amt, dep + aim*amt, aim)
applyCommandPartTwo (hor,dep,aim) (Down amt)    = (hor,       dep,           aim + amt)
applyCommandPartTwo (hor,dep,aim) (Up amt)      = (hor,       dep,           aim - amt)

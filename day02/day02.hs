data Command = Forward Int | Down Int | Up Int
instance Show Command where
    show (Forward amount) = "forward " ++ show amount
    show (Down amount) = "down " ++ show amount
    show (Up amount) = "up " ++ show amount

main = do
    input <- readFile "input.txt"
    let parsed = parseInput input
        (endH,endD) = calculateEndPosition parsed (0,0)
    putStrLn ("Solution to part one: " ++ show (endH * endD))

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
Calculates the position (new horizontal position, new depth) if a submarine starting at (horizontal position, depth) follows all of the given commands.

>>> calculateEndPosition [Forward 5, Down 5, Forward 8, Up 3, Down 8, Forward 2] (0,0)
(15,10)
-}
calculateEndPosition :: [Command] -> (Int, Int) -> (Int, Int)
calculateEndPosition [] (h,d) = (h,d)
calculateEndPosition ((Forward amt):cmds) (h,d) = calculateEndPosition cmds (h + amt, d)
calculateEndPosition ((Down amt):cmds) (h,d) = calculateEndPosition cmds (h, d + amt) -- note that "down" increases the depth
calculateEndPosition ((Up amt):cmds) (h,d) = calculateEndPosition cmds (h, d - amt)

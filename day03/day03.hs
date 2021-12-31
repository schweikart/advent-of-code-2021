data Bit = Zero | One

instance (Eq Bit) where
    (==) Zero Zero = True
    (==) One One = True
    (==) _ _ = False

instance (Show Bit) where
    show Zero = "0"
    show One = "1"

negateBit :: Bit -> Bit
negateBit Zero = One
negateBit One = Zero

main = do
    input <- readFile "input.txt"
    let parsed = parseInput input
    putStrLn ("Solution to part one: " ++ show (powerConsumption parsed))

{-|
Parses the bit sequences in the given file contents, line by line.
-}
parseInput :: String -> [[Bit]]
parseInput input = map parseBits (lines input)

{-|
Parses a bit sequence given through a string of zeros and ones.
-}
parseBits :: String -> [Bit]
parseBits = map parseBit


{-|
Parses a bit given through a '0' or '1' character.
-}
parseBit :: Char -> Bit
parseBit '0' = Zero
parseBit '1' = One
parseBit x = error "character is not a bit"

{-|
Counts the amount of occurrences of the given bit (2nd arg) in each column of the bit table (1st arg)

>>> countInCols (parseInput "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010") Zero
[5,7,4,5,7]
-}
countInCols :: [[Bit]] -> Bit -> [Int]
countInCols input bit = [length (filter (== bit) (map (!! col) input)) | col <- [0..(length (head input) - 1)]]

{-|
Finds the most common bit for each column of the given bit table.

>>> mostCommonBits (parseInput "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
[1,0,1,1,0]
-}
mostCommonBits :: [[Bit]] -> [Bit]
mostCommonBits bits = map (\zeroCount -> if 2 * zeroCount > length bits then Zero else One) (countInCols bits Zero)

{-|
Finds the least common bit for each column of the given bit table.

>>> leastCommonBits (parseInput "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
[0,1,0,0,1]
-}
leastCommonBits :: [[Bit]] -> [Bit]
leastCommonBits bits = map negateBit (mostCommonBits bits)

bitValue :: Bit -> Int
bitValue Zero = 0
bitValue One = 1

{-|
Calculates the binary number given through a bit sequence, assuming that the first bit is the most significant bit (MSB).

>>> integerValue [One, Zero, One, One, Zero]
22

>>> integerValue [Zero, One, Zero, Zero, One]
9
-}
integerValue :: [Bit] -> Int
integerValue bits = ivAcc bits 0 where
    ivAcc [] acc = acc
    ivAcc (b:bs) acc = ivAcc bs (2 * acc + bitValue b)

{-|
Calculates the power consumption of the submarine with the formula given through the first part of the puzzle.

>>> powerConsumption (parseInput "00100\n11110\n10110\n10111\n10101\n01111\n00111\n11100\n10000\n11001\n00010\n01010")
198
-}
powerConsumption :: [[Bit]] -> Int
powerConsumption bits = gammaRate * epsilonRate where
    gammaRate = integerValue $ mostCommonBits bits
    epsilonRate = integerValue $ leastCommonBits bits

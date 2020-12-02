data Pass = Pass Int Int Char String deriving (Eq, Show, Read)

processLine :: String -> Pass
processLine line = Pass lower upper char pass
  where
    lower = read $ minMax !! 0
    upper = read $ minMax !! 1
    char = words line !! 1 !! 0
    pass = words line !! 2
    minMax = words $ map (\c -> if c == '-' then ' ' else c) (words line !! 0)

countChar:: Char -> String -> Int
countChar c str = foldr (\x acc -> if x == c then acc+1 else acc) 0 str

xor :: Bool -> Bool -> Bool
xor a b = (a || b) && not (a && b)

isValid1st :: Pass -> Bool
isValid1st (Pass lower upper char pass) =
  elem (countChar char pass) [lower..upper]

isValid2nd :: Pass -> Bool
isValid2nd (Pass lower upper char pass) =
  (pass !! (lower -1) == char) `xor` (pass !! (upper-1) == char)

main = do
  contents <- readFile "dat/day_02.dat"
  let input = map (processLine) (lines contents)
  putStrLn $ show $ length $ filter isValid1st input
  putStrLn $ show $ length $ filter isValid2nd input

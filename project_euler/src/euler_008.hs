import Data.Char

substring :: Int -> Int -> String -> String
substring start end text = take (end - start) (drop start text)

substrings13 :: String -> [String]
substrings13 string = [substring n (n+13) string | n <- [0..length string -13]]

prodString :: String -> Int
prodString string = foldl1 (*) (map (\x -> ord x - 48) string)

answer :: String -> Int
answer string = maximum $ map prodString (substrings13 string)

main = do
        contents <- readFile "dat/euler_008.txt"
        putStrLn $ show $ answer contents


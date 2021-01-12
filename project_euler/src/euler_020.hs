import Data.Char

fac n = foldr1 (*) [1..n]
sumDigits = sum . map digitToInt . show

main = putStrLn $ show $ sumDigits $ fac 100

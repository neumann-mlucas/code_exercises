import Data.Char

awnser  = sum . map digitToInt . show . (^1000)
main = putStrLn $ show $ awnser 2

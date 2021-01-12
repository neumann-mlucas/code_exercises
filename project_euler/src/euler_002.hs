fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
answer x = sum $ filter (even) $ takeWhile (<x) fibs
main = putStrLn $ show $ answer 4000000

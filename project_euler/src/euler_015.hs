fac n = foldr1 (*) [1..n]
binomial n k = fac n `div` (fac k * fac (n-k))
main = putStrLn $ show $ binomial 40 20

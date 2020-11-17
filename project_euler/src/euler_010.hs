isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

isPrime :: (Int) -> Bool
isPrime n = and [mod n x /= 0 | x <- [2..isqrt n]]

answer :: Int -> Int
answer lim = sum $ filter isPrime [2..lim]
main = putStrLn $ show $ answer 2000000

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

factors :: Int -> [Int]
factors n = [x | x <- [2..isqrt n], mod n x == 0]

isPrime :: (Int) -> Bool
isPrime n = factors n == []

answer :: Int -> Int
answer n = last $ take n [x | x <-[2..], isPrime x]
main = putStrLn $ show $ answer 10001

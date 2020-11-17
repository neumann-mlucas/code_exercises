answer :: Int -> Int
answer n = foldl1 (lcm) [1..n]
main = putStrLn $ show $ answer 20

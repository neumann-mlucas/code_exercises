answer :: Int -> Int
answer n = ((^2) $ sum [1..n]) - (sum $ map (^2) [1..n])
main = putStrLn $ show $ answer 100

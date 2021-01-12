isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral

factors :: Int -> [Int]
factors n = [x | x <- [1..isqrt n], n `mod` x == 0]

nfactors :: Int -> Int
nfactors n =
  sum . map (\x -> if x == n `div` x then 1 else 2) $ factors n

triangular = scanl1 (+) [1..]
answer = head . filter ((>=500) . nfactors)

main = putStrLn $ show $ answer triangular

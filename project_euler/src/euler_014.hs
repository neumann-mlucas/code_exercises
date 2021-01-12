import Data.List

collatz :: Int -> Maybe (Int,Int)
collatz 1 = Nothing
collatz n
  | even n = Just (n, div n 2)
  | odd  n = Just (n, 3 * n +1)

awnser = last . sortOn (length . unfoldr collatz)

main = putStrLn $ show $ awnser [1..1000000]

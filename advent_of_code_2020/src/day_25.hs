import Data.List

transform num loop =
  foldl' (\x _ -> (x * num ) `mod` 20201227)
  num [1..loop-1]

findLoopSize key =
  length $
  unfoldr
  (\x -> if x == key
         then Nothing
         else Just (x, (x * 7 ) `mod` 20201227)) 1

main = do
  (keyOne:keyTwo:_) <- map (read::String->Int) <$> lines <$> readFile "dat/day_25.dat"
  putStrLn $ show $ transform keyOne (findLoopSize keyTwo)

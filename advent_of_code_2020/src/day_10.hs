import Data.List (sort)
import Data.Map ((!), fromList, insert)


countDeltas list = (count 1) * (count 3 + 1)
  where
  count n = length $ filter (==n) deltas
  deltas = zipWith (-) (tail sorted) (init sorted)
  sorted = 0:(sort list)

countWays list = finalDict ! maximum list
  where
    chain = sort $ (maximum list + 3):list
    initalDict = fromList [if n == 0 then (0,1) else (n,0) | n <- [-3.. maximum chain]]
    finalDict  = foldl (\d n -> helper d n) initalDict chain
    helper dict n = insert n (sum $ map (dict !) [n-1,n-2,n-3]) dict


main = do
  contents <- readFile "dat/day_10.dat"
  let input = map (read::String->Int) (lines contents)

  putStrLn $ show $ countDeltas input
  putStrLn $ show $ countWays $ input

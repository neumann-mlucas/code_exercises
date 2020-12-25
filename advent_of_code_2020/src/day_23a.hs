import Data.List
import Data.Char
import Control.Monad

move input =
  take (idx+1) cups ++ picked ++ drop (idx+1) cups
  where
    (current, picked) = (head input, drop 1 $ take 4 input)
    cups = drop 4 input ++ [current]
    target = getTarget cups (current-1)
    idx = head $ elemIndices target cups

getTarget cups 0 = maximum cups
getTarget cups target
  | target `elem` cups = target
  | otherwise = getTarget cups (target-1)

cleanOutput list =
  drop (idx+1) str ++ take idx str
  where
  str = join $ map show list
  idx = head $ elemIndices '1' str

main = do
  input <- map digitToInt <$> filter isNumber <$> readFile "dat/day_23.dat"
  putStrLn $ cleanOutput $ (!!100) $ iterate move input

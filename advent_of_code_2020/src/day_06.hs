import qualified Data.Set as Set
import Data.List
import Control.Monad

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

uniqueChars :: [String] -> Int
uniqueChars group =
  Set.size $ Set.fromList list
    where
      list = join group

commonChars :: [String] -> Int
commonChars group =
  Set.size $ intersection
    where
      sets = map Set.fromList group
      intersection = foldr (\x acc -> Set.intersection x acc) (head sets) (tail sets)

main = do
  contents <- readFile "dat/day_06.dat"
  let groups = map lines (splitStr "\n\n" contents)
  putStrLn $ show $ sum $ map uniqueChars groups
  putStrLn $ show $ sum $ map commonChars groups

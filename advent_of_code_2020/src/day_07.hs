import qualified Data.Map as M
import Data.List
import Control.Monad

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

processLine :: String -> (String, [(Int,String)])
processLine line = (parent, children)
  where
    bags = splitStr "contain" line
    parent = (join . take 2 . words . head) bags
    children = map  (toPair . take 3 . words) (splitStr "," $ last bags)
    toPair pair =
      if pair /= ["no","other","bags."]
        then (read $ head pair, join $ tail pair)
        else (0,"empty")

hasBag :: M.Map String [(Int,String)] -> [String] -> Int
hasBag graph [] = 0
hasBag graph (x:xs)
  | hasTarget = 1
  | otherwise = hasBag graph (bags ++ xs)
  where
    hasTarget = "shinygold" `elem` bags
    bags = if M.member x graph then (map snd (graph M.! x)) else []

countBags :: M.Map String [(Int,String)] -> Int -> [(Int,String)] -> Int
countBags graph acc [] = 0
countBags graph acc (x:xs)
  | endPoint = acc * num
  | otherwise = acc * num + (countBags graph (acc * num) bags) + (countBags graph acc xs)
  where
    num = fst x
    key = snd x
    endPoint =  key `M.notMember` graph
    bags = graph M.! key


main = do
  contents <- readFile "dat/day_07.dat"
  let dict = M.fromList $ map processLine (lines contents)

  putStrLn $ show $ sum [hasBag dict [k] | k<-(M.keys dict)]
  putStrLn $ show $ countBags dict 1 [(1,"shinygold")] -1

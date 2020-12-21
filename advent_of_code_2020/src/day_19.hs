import Data.Map ((!), updateWithKey, fromList, Map)
import Data.Char
import Data.List
import Data.Maybe

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

readRules input =
  (fromList . map (readLine . splitStr ": ") . lines . head . splitStr "\n\n") input
readLine (x:y:_) = (x, words $ filter (not . isPunctuation) y)

readMsgs input =
  (lines . last . splitStr "\n\n") input

test :: Map String [String] -> String -> [String] -> Bool
test _ "" []  = True
test _ _  []  = False
test _ ""  _  = False

test dRules str seq
  | isMatch = if (head str):"" `elem` rules
              then test dRules (tail str) (tail seq)
              else False
  | otherwise = any (test dRules str) (getPaths rules seq)
  where
    isMatch = all isLetter (head rules)
    rules = dRules ! (head seq)

getPaths list seq
  | "|" `elem` list = [p ++ (tail seq) | p <- [take pos list, drop (pos+1) list]]
  | otherwise = [list ++ (tail seq)]
  where
    pos = fromJust $ elemIndex "|" list

f "8"  _ = Just ["42", "|", "42", "8"]
f "11" _ = Just ["42", "31", "|", "42", "11", "31"]

main = do
  contents <- readFile "dat/day_19.dat"
  let rules = readRules contents
  let msgs =  readMsgs  contents

  -- Part 1
  putStrLn $ show $ length $ filter (\x -> test rules x ["0"]) msgs

  -- Part 2
  let newRules = updateWithKey f "11" $ updateWithKey f "8" rules
  putStrLn $ show $ length $ filter (\x -> test newRules x ["0"]) msgs

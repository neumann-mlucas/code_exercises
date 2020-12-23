import Data.List
import Data.Foldable (toList)

import qualified Data.Sequence as Seq
import Data.Sequence (fromList,Seq,Seq(..))
import Data.Sequence (Seq (Empty))

import Data.Set (Set)
import qualified Data.Set as Set

data Player = P1 | P2 deriving (Show, Eq)

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

readInput :: String -> [Seq Int]
readInput line = map (fromList . map read . tail . lines) (splitStr "\n\n" line)

game :: Seq Int -> Seq Int -> (Player, Seq Int)
game xs Empty = (P1, xs)
game Empty ys = (P2, ys)
game (x :<| xs) (y :<| ys)
  | x > y     = game (xs :|> x :|> y) ys
  | otherwise = game xs (ys :|> y :|> x)

score :: (Player, Seq Int) -> Int
score = sum . zipWith (*) [1..] . reverse . toList . snd

game' :: Set (Seq Int,Seq Int) -> Seq Int -> Seq Int -> (Player, Seq Int)
game' _ xs Empty = (P1, xs)
game' _ Empty ys = (P2, ys)
game' seen xall@(x :<| xs) yall@(y :<| ys)
  | isSeen    = (P1, xall)
  | subGame   = case game' Set.empty (Seq.take x xs) (Seq.take y ys) of
                (P1,_) -> winP1
                (P2,_) -> winP2
  | x > y     = winP1
  | otherwise = winP2
  where
    isSeen  = (xall, yall) `Set.member` seen
    seen'   = Set.insert (xall,yall) seen
    subGame = Seq.length xs >= x && Seq.length ys >= y
    winP1   = game' seen' (xs :|> x :|> y) ys
    winP2   = game' seen' xs (ys :|> y :|> x)

main = do
  contents <- readFile "dat/day_22.dat"
  let (p1:p2:_) = readInput contents

  putStrLn $ show $ score $ game p1 p2
  putStrLn $ show $ score $ game' Set.empty p1 p2

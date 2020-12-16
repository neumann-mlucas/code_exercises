import Data.List
import Data.Map (Map, notMember, (!))
import qualified Data.Map as Map

fn :: (Int, Int, Map Int [Int]) -> (Int, Int, Map Int [Int])
fn (turn, last, history)
  | last `notMember` history = (succ turn, 0, addNum history)
  | otherwise = (succ turn, new, addTurn history)
  where
    new = (\(a:b:_)-> a-b) $ (addTurn history) ! last
    addTurn = Map.adjust (turn:) last
    addNum = Map.insert last [turn]

toHistory list = Map.fromList [(e, elemIndices e list) | e<-list]
seed x = (length x -1, last x, toHistory $ init x)
extract n = head . Map.keys . Map.filter (n-1 `elem`) . (\(a,b,c)->c)

main = do
  contents <- readFile "dat/day_15.dat"
  let input = (read::String->[Int]) contents

  putStrLn $ show $ extract 2020 $ foldl' (\a b -> fn a) (seed input) [1..2020]
  putStrLn $ show $ extract 30000000 $ foldl' (\a b -> fn a) (seed input) [1..30000000]


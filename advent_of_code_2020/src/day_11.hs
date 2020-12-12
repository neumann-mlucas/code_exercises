import Data.List
import Data.Monoid
import Control.Monad

applyUntilStable :: [String] -> [String]
applyUntilStable board =
  fst $ head $ dropWhile (\(a,b) -> a /= b) $ zip states (tail states)
  where
    states = scanl (\a b -> applyToBoard a) board [0..]

applyToBoard :: [String] -> [String]
applyToBoard board = map (applyToLine board) indexes
  where
  indexes = groupBy (\a b -> fst a == fst b) [(x,y) | x <- [0..heigth], y <- [0..width]]
  heigth = (length $ board) -1
  width = (length $ head board) -1

applyToLine :: [String] -> [(Int,Int)] -> String
applyToLine board indexes =
  map (applyRules board) indexes

applyRules :: [String] -> (Int,Int) -> Char
applyRules board idx
  | isEmpty && uncrowded = '#'
  | isOccupied && tooCrowded = 'L'
  | otherwise = state
  where
    isEmpty = state == 'L'
    isOccupied = state == '#'
    neighbors = getNeighbors board idx
    state = getState board idx
    tooCrowded = countChar '#' neighbors >= 4
    uncrowded = countChar '#' neighbors == 0

countChar:: Char -> String -> Int
countChar c str = foldr (\x acc -> if x == c then acc+1 else acc) 0 str

getNeighbors :: [String] -> (Int,Int) -> String
getNeighbors board idx = map (getState board) (adjacent size idx)
  where
    size = ((length board) -1,(length $ head board)-1)

getState :: [String] -> (Int,Int) -> Char
getState board (x,y) = board !! x !! y

adjacent :: (Int,Int) -> (Int,Int) -> [(Int,Int)]
adjacent boardSize (x,y) =
 [(x+dx, y+dy) | dx<-[-1..1], dy<-[-1..1], predicate (x+dx,y+dy)]
 where
   xLim (x,_) = x >= 0 && x <= (fst boardSize)
   yLim (_,y) = y >= 0 && y <= (snd boardSize)
   notItself pt = pt /= (x,y)
   predicate = getAll . foldMap (All .) [xLim, yLim, notItself]

-- Part Two

applyUntilStable' :: [String] -> [String]
applyUntilStable' board =
  fst $ head $ dropWhile (\(a,b) -> a /= b) $ zip states (tail states)
  where
    states = scanl (\a b -> applyToBoard' a) board [0..]

applyToBoard' :: [String] -> [String]
applyToBoard' board = map (applyToLine' board) indexes
  where
  indexes = groupBy (\a b -> fst a == fst b) [(x,y) | x <- [0..heigth], y <- [0..width]]
  heigth = (length $ board) -1
  width = (length $ head board) -1

applyToLine' :: [String] -> [(Int,Int)] -> String
applyToLine' board indexes =
  map (applyRules' board) indexes

applyRules' :: [String] -> (Int,Int) -> Char
applyRules' board idx
  | isEmpty && uncrowded = '#'
  | isOccupied && tooCrowded = 'L'
  | otherwise = state
  where
    sigth = getSigth board idx
    state = getState board idx
    tooCrowded = countChar '#' sigth >= 5
    uncrowded = countChar '#' sigth == 0
    isEmpty = state == 'L'
    isOccupied = state == '#'

getSigth board idx =
  map (\f -> f idx) [goN,goS,goE,goW,goNE,goNW,goSE,goSW]
  where
    goN (px,py)  = nearest [getState board (px-n,py+0) | n<-[1..px]]
    goS (px,py)  = nearest [getState board (px+n,py+0) | n<-[1..limX-px]]
    goE (px,py)  = nearest [getState board (px+0,py+n) | n<-[1..limY-py]]
    goW (px,py)  = nearest [getState board (px+0,py-n) | n<-[1..py]]
    goNE (px,py) = nearest [getState board (px-n,py+n) | n<-[1..(min px (limY-py))]]
    goNW (px,py) = nearest [getState board (px-n,py-n) | n<-[1..(min px py)]]
    goSE (px,py) = nearest [getState board (px+n,py+n) | n<-[1..(min (limX-px) (limY-py))]]
    goSW (px,py) = nearest [getState board (px+n,py-n) | n<-[1..(min (limX-px) py)]]
    nearest [] = '.'
    nearest [x] = x
    nearest (x:xs)
      | x == 'L' || x == '#' = x
      | x `elem` "L#" = x
      | otherwise = nearest xs
    limY = (length $ head board) -1
    limX = (length board) -1


main = do
  contents <- readFile "dat/day_11.dat"
  let input = lines contents
  putStrLn $ show $ countChar '#' $ join $ applyUntilStable  input
  putStrLn $ show $ countChar '#' $ join $ applyUntilStable' input

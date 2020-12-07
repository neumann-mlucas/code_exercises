import qualified Data.Set as Set

bintodec :: [Bool] -> Int
bintodec = foldr (\x y -> fromEnum x + 2*y) 0

strToInt :: String -> [Int]
strToInt str = map (bintodec . reverse) [take 7 bin, drop 7 bin]
  where
    bin = map trans str
    trans 'B' = True
    trans 'F' = False
    trans 'R' = True
    trans 'L' = False

getID :: [Int] -> Int
getID (row:col:_) = row * 8 + col

notInList :: [Int] -> [Int]
notInList list = Set.toList $ Set.difference (Set.fromList allSeats) (Set.fromList list)
  where
    allSeats = [getID [x,y] | x<-[0..127], y<-[0..7]]

findSeat :: [Int] -> Int
findSeat ids = head $ filter predicate (notInList ids)
  where
    predicate = (\x -> (x+1) `elem` ids && (x-1) `elem` ids)

main = do
  contents <- readFile "dat/day_05.dat"
  let ids = map (getID . strToInt) (lines contents)
  putStrLn $ show $ maximum $ ids
  putStrLn $ show $ findSeat ids

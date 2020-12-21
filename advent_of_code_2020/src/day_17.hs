import Data.Set (member, fromList, toList, size, Set)
import Data.Maybe
import Data.List (iterate)
import Control.Monad

data Point = Point3D Int Int Int | Point4D Int Int Int Int deriving (Show,Read,Ord,Eq)

getNeighbors :: Point -> [Point]
getNeighbors (Point3D x y z) =
  [Point3D (x+dx) (y+dy) (z+dz) | dx<-d, dy<-d, dz<-d, pred [dx,dy,dz]]
  where
    d = [-1,0,1] -- delta
    pred = not . all (==0)

getNeighbors (Point4D x y z w) =
  [Point4D (x+dx) (y+dy) (z+dz) (w+dw) | dx<-d, dy<-d, dz<-d, dw<-d, pred [dx,dy,dz,dw]]
  where
    d = [-1,0,1] -- delta
    pred = not . all (==0)

countNeighbours :: Set Point -> Point -> Int
countNeighbours set pt =
  length $ filter (`member` set) neighbors
  where
    neighbors = getNeighbors pt

rules :: Set Point -> Point -> Maybe Point
rules set pt
  | num == 3 = Just pt
  | num == 2 && pt `member`set = Just pt
  | otherwise = Nothing
  where
    num = countNeighbours set pt

updateConway :: Set Point -> Set Point
updateConway set =
  fromList newPts
  where
    neighbors = concat . map getNeighbors . toList
    allPts = (toList . fromList) $ (toList set) ++ (neighbors set)
    newPts = catMaybes $ map (rules set) allPts

readBoard text =
  fromList $ occupied $ items $ text
  where
  occupied = map (\(a,b,c) -> Point3D a b 0) . filter (\(a,b,c) -> c == '#')
  items = concat . map (uncurry helper) . zip [0..] . lines
  helper i line =
    [(i, j, c) | (j,c) <- zip [0..] line]

readBoard' text =
  fromList $ occupied $ items $ text
  where
  occupied = map (\(a,b,c) -> Point4D a b 0 0) . filter (\(a,b,c) -> c == '#')
  items = concat . map (uncurry helper) . zip [0..] . lines
  helper i line =
    [(i, j, c) | (j,c) <- zip [0..] line]

main = do
  contents <- readFile "dat/day_17.dat"
  let seed3D = readBoard  contents
  let seed4D = readBoard' contents

  putStrLn $ show $ size . (!!6) $ iterate updateConway seed3D
  putStrLn $ show $ size . (!!6) $ iterate updateConway seed4D

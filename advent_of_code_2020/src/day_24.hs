import Data.List
import Data.Set (Set,difference,fromList,intersection,unions)
import qualified Data.Set as Set

data Move = E | W | SE | SW | NE | NW deriving (Show, Read, Eq)

processLine []           = []
processLine ('e':xs)     = E  : processLine xs
processLine ('w':xs)     = W  : processLine xs
processLine ('s':'e':xs) = SE : processLine xs
processLine ('s':'w':xs) = SW : processLine xs
processLine ('n':'e':xs) = NE : processLine xs
processLine ('n':'w':xs) = NW : processLine xs

move (x,y,z) E  = (x+1,y+0,z-1)
move (x,y,z) W  = (x-1,y+0,z+1)
move (x,y,z) SE = (x+1,y-1,z+0)
move (x,y,z) SW = (x+0,y-1,z+1)
move (x,y,z) NE = (x+0,y+1,z-1)
move (x,y,z) NW = (x-1,y+1,z+0)

getBlackTiles = concat . filter (odd . length) . group . sort . map (foldl move (0,0,0))
countBlackTiles = length . getBlackTiles

getAdjacent tile = fromList $ map (move tile) [E,W,SE,SW,NE,NW]

ruleBlack :: Set (Int,Int,Int) -> (Int,Int,Int) -> Bool
ruleBlack set tile =
  case adjacent of
    0 -> False
    1 -> True
    2 -> True
    _ -> False
  where
  adjacent = length $ intersection (getAdjacent tile) set

ruleWhite :: Set (Int,Int,Int) -> (Int,Int,Int) -> Bool
ruleWhite set tile =
  case adjacent of
    2 -> True
    _ -> False
  where
  adjacent = length $ intersection (getAdjacent tile) set

applyRules :: Set (Int,Int,Int) -> Set (Int,Int,Int)
applyRules bTiles =
  Set.union stayBlack turnBlack
  where
    allAdjacent = unions . Set.map getAdjacent
    wTiles      = difference (allAdjacent bTiles) bTiles
    stayBlack   = Set.filter (ruleBlack bTiles) bTiles
    turnBlack   = Set.filter (ruleWhite bTiles) wTiles

main = do
  contents <- map processLine <$> lines <$> readFile "dat/day_24.dat"
  let bTiles = fromList $ getBlackTiles contents
  -- Part 1
  putStrLn $ show $ countBlackTiles contents
  -- Part 2
  putStrLn $ show $ length $ (!!100) $ iterate applyRules bTiles

genPath :: Int->Int->Int->Int->[(Int,Int)]
genPath dx dy heigth width = [(x, y `mod` width) | (x,y) <- zip [0,dx..heigth-1] [0,dy..]]

genPaths slopes = map (\xy -> genPath (fst xy) (snd xy)) slopes

getCoord :: [String]->(Int,Int)->Char
getCoord array coord = array !! (fst coord) !! (snd coord)

countChar:: Char->String->Int
countChar c str = foldr (\x acc -> if x == c then acc+1 else acc) 0 str
countTrees = countChar '#'


main = do
  contents <- readFile "dat/day_03.dat"
  let terrain = lines contents
  let heigth = length terrain
  let width = length $ head terrain

  let slopes = [(1,1),(1,3),(1,5),(1,7),(2,1)]
  let paths = map (\f -> f heigth width) (genPaths slopes)
  let trees = map (\path -> countTrees $ map (getCoord terrain) path) paths

  putStrLn $ show $ trees !! 1
  putStrLn $ show $ foldr1 (*) trees

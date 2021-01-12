import Data.List

processInput :: String -> [[Int]]
processInput = map (map read . words) . lines

directions = [(0,1),(1,0),(1,1),(1,-1)]
move (x,y) (dx,dy) = (x+dx,y+dy)

answer matrix =
  maximum [ product (takeLine x y dir) | x <- [0..17], y <- [0..17], dir <- directions ]
  where
    takeLine x y dir =
      [ matrix !! x' !! y' | (x',y') <- take 4 $ iterate (move dir) (x,y), inRange x' y' ]

inRange x y = x >= 0 && y >= 0 && x <= 19 && y <= 19

main = do
  contents <- processInput <$> readFile "dat/euler_011.txt"
  putStrLn $ show $ answer contents

data Instruction = North Int | South Int | East Int | West Int | Foward Int | TurnRigth | TurnLeft | TurnBack
  deriving (Show, Read, Eq)
data Ship = Ship Int Int Int deriving (Show, Read, Eq)
data ShipWP = ShipWP Int Int Int Int deriving (Show, Read, Eq)

processLine :: String -> Instruction
processLine (cmd:num) =
  case cmd of
    'N' -> North (read num)
    'S' -> South (read num)
    'E' -> East (read num)
    'W' -> West (read num)
    'F' -> Foward (read num)
    'R' -> case num of
             "90"  -> TurnRigth
             "180" -> TurnBack
             "270" -> TurnLeft
    'L' -> case num of
             "90"  -> TurnLeft
             "180" -> TurnBack
             "270" -> TurnRigth

moveShip :: Ship -> Instruction -> Ship
moveShip (Ship x y d) (North n) = Ship x (y+n) d
moveShip (Ship x y d) (South n) = Ship x (y-n) d
moveShip (Ship x y d) (East  n) = Ship (x+n) y d
moveShip (Ship x y d) (West  n) = Ship (x-n) y d
-- North -> East -> South -> West
moveShip (Ship x y 0) (Foward n) = Ship x (y+n) 0
moveShip (Ship x y 1) (Foward n) = Ship (x+n) y 1
moveShip (Ship x y 2) (Foward n) = Ship x (y-n) 2
moveShip (Ship x y 3) (Foward n) = Ship (x-n) y 3
-- Works with negative numbers, e.g. -1 mod 4 = 3
moveShip (Ship x y d) TurnRigth = Ship x y ((d + 1) `mod` 4)
moveShip (Ship x y d) TurnLeft  = Ship x y ((d - 1) `mod` 4)
moveShip (Ship x y d) TurnBack  = Ship x y ((d + 2) `mod` 4)

moveShipWP :: ShipWP -> Instruction -> ShipWP
moveShipWP (ShipWP x y wx wy) (North n) = ShipWP x y wx (wy+n)
moveShipWP (ShipWP x y wx wy) (South n) = ShipWP x y wx (wy-n)
moveShipWP (ShipWP x y wx wy) (East  n) = ShipWP x y (wx+n) wy
moveShipWP (ShipWP x y wx wy) (West  n) = ShipWP x y (wx-n) wy
-- NorthWP -> East -> South -> West
moveShipWP (ShipWP x y wx wy) (Foward n) = ShipWP (x+n*wx) (y+n*wy) wx wy
-- Basic Linear Albegra
moveShipWP (ShipWP x y wx wy) TurnRigth = ShipWP x y wy (-wx)
moveShipWP (ShipWP x y wx wy) TurnLeft  = ShipWP x y (-wy) wx
moveShipWP (ShipWP x y wx wy) TurnBack  = ShipWP x y (-wx) (-wy)

getManhattan (Ship x y _) = abs x + abs y
travel :: Ship -> [Instruction] -> Int
travel ship instructions =
  getManhattan $ foldl (\s i -> moveShip s i) ship instructions

getManhattanWP (ShipWP x y _ _) = abs x + abs y
travelWP :: ShipWP -> [Instruction] -> Int
travelWP ship instructions =
  getManhattanWP $ foldl (\s i -> moveShipWP s i) ship instructions

main = do
    contents <- readFile "dat/day_12.dat"
    let input = map (processLine) (lines contents)
    putStrLn $ show $ travel (Ship 0 0 1) input
    putStrLn $ show $ travelWP (ShipWP 0 0 10 1) input

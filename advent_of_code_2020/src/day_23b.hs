import Data.Char
import Data.List
import qualified Data.IntMap as M
import Data.IntMap (fromList,size,IntMap,(!))

type Cups = (Int, IntMap Int)

move :: Cups -> Cups
move (current, cups) = (cups' ! current, cups')
  where
    -- pickUp
    (p1:p2:p3:_) = tail $ scanl' (\x _ -> cups ! x) current [1..]
    -- not in pickUp, is one minus the current, if zero cycles
    destination = getDestination [p1,p2,p3] (current-1)
    -- insert pickup and current in destination
    cups' = M.insert destination p1 $
            M.insert p3          (cups M.! destination) $
            M.insert current     (cups M.! p3) cups

getDestination pickup 0 = 1000000
getDestination pickup target
  | target `notElem` pickup = target
  | otherwise = getDestination pickup (target-1)

main = do
  input <- (++ [10..1000000]) <$> map digitToInt <$>
    filter isNumber <$> readFile "dat/day_23.dat"

  let iterations = 10000000
  let start = (head input, fromList $ zip input (tail (cycle input)))
  let (_ , final) = iterate move start !! iterations

  putStrLn $ show $ (final ! 1) * (final ! (final ! 1))


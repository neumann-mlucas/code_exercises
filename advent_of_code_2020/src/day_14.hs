import Data.Map (Map, alter, elems, empty, (!))
import Data.Char
import Data.List
import Data.Maybe
import Text.Printf
import Numeric

data Instruction = Mask String | Mov Int Int deriving (Read,Show)
data State = State String (Map Int Int) deriving (Read,Show)

processLine :: String -> Instruction
processLine line
  | isMask = Mask num
  | otherwise = Mov (read num) (read loc)
    where
      isMask = (head . words) line == "mask"
      num = (last . words) line
      loc = filter (isNumber) $ (head . words) line

applyInstruction :: State -> Instruction -> State
applyInstruction (State mask mem) (Mov num loc) =
  State mask (alter val loc mem)
    where
      val _ = Just $ toInt $ zipWith applyMask (toBin num) mask
applyInstruction (State oldMask mem) (Mask newMask) =
  State newMask mem

applyMask  n 'X' = n
applyMask  _  n  = n

toBin int = printf "%036b" int
toInt = head . map fst . readInt 2 (`elem` "01") digitToInt

sumState (State _ values) = sum $ elems values

applyInstruction' :: State -> Instruction -> State
applyInstruction' (State mask mem) (Mov num loc) =
  State mask writeMem
    where
      val _    = Just num
      bLoc     = toBin loc
      maskLoc  = zipWith applyMask' bLoc mask
      masks    = getMasks [maskLoc]
      locs     = map (toInt . zipWith applyMask bLoc) masks
      writeMem = foldl (\m l -> alter val l m) mem locs
applyInstruction' (State oldMask mem) (Mask newMask) =
  State newMask mem

-- ["01X"] -> ["010", "011"]
getMasks :: [String] -> [String]
getMasks mask =
  case pos of
    [] -> mask
    _  -> getMasks new
  where
    pos = catMaybes $ map (elemIndex 'X') mask
    new = concatMap (\(m,p) -> [sub m p '0', sub m p '1']) $ zip mask pos
    sub str pos char = take pos str ++ char : drop (pos+1) str

applyMask' 'X'  _  = 'X'
applyMask'  _  'X' = 'X'
applyMask' '1' '1' = '1'
applyMask' '0' '1' = '1'
applyMask' '1' '0' = '1'
applyMask' '0' '0' = '0'


main = do
  contents <- readFile "dat/day_14.dat"
  let input = map (processLine) (lines contents)
  let initial = State [] empty

  putStrLn $ show $ sumState $ foldl applyInstruction  initial input
  putStrLn $ show $ sumState $ foldl applyInstruction' initial input



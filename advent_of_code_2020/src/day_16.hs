import qualified Data.Set as Set
import Data.Char
import Data.List

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

processInfo :: String -> [Set.Set Int]
processInfo text = map Set.fromList $ fnum text
  where
  fnum = map (concat . map getRanges) . fstr
  fstr = map (splitStr "or" . (!!1) . splitStr ":") . take 20 . lines

processTickets :: String -> [[Int]]
processTickets =
  map (map read) . map (splitStr ",") . drop 25 . lines

getRanges :: String -> [Int]
getRanges str = [a..b]
  where
    getBounds = map read . splitStr "-" . filter (not . isSpace)
    (a:b:_) = getBounds str

checkAll constrains = all (flip Set.member constrains)

checkCol :: [[Int]] -> Set.Set Int -> [Int]
checkCol list range =
  map fst $ filter (\x-> snd x `Set.isSubsetOf` range) col
    where
    col = [(i, Set.fromList $ map (!!i) list) | i<-[0..19]]

getDepartures :: [Int] -> [[Int]] -> [Int]
getDepartures pass match = map (\x-> pass !! x) (extract cols)
  where
      cols = iterate eliminateMatchs match
      extract = concat . take 6 . last . take 100

eliminateMatchs :: [[Int]] -> [[Int]]
eliminateMatchs matchs = map removeForbidden matchs
  where
    forbidden = concat $ filter (\x -> length x == 1) matchs
    removeForbidden list
      | length list == 1 = list
      | otherwise = filter (\x -> not $ elem x forbidden) list


main = do
  contents <- readFile "dat/day_16.dat"
  let constrainsCol =  processInfo contents
  let constrainsAll = foldr (\x y -> Set.union x y) (Set.fromList []) constrainsCol

  let pass = processTickets contents
  let validPass = filter (checkAll constrainsAll) pass

  -- Part 1
  putStrLn $ show $ sum $ filter (flip Set.notMember constrainsAll) (concat pass)

  -- Part 2
  let myPass = map (read::String->Int) $ splitStr "," $ lines contents !! 22
  let matchKeyCol = map (checkCol validPass) constrainsCol
  putStrLn $ show $ product $ getDepartures myPass matchKeyCol

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

processInput line = (rst line, snd line)
  where
  rst = words . head . splitStr "(contains "
  snd = splitStr "," . filter pred . last . splitStr "(contains "
  pred x = x /= ')' && (not . isSpace) x

findTrans list str = (str, match)
  where
    match = foldl Set.intersection (head setFoods) (tail setFoods)
    setFoods = map (Set.fromList . fst) $
      filter (\x -> str `elem` snd x) list

getSets list = sort $ map (findTrans list) $ uniq list
  where
    uniq = nub . concat . map snd

notAllergen list = filter (`Set.notMember` set) ing
  where
    ing = concat $ map fst list
    set = Set.unions $ map snd $ getSets list

getSingletons :: [(String,Set.Set String)] -> [String]
getSingletons input =
  Set.elems $ Set.unions $ map snd $ filter (\x -> (Set.size $ snd x) == 1) input

reduceSets sets =
  foldl (\x y -> map (fn y) x) sets (getSingletons sets)
  where
    fn str (word,set)
      | set == Set.singleton str = (word,set)
      | otherwise = (word, Set.delete str set)

getSolution sets =
  intercalate "," $ concat $ map (Set.toList . snd) sets

main = do
  contents <- readFile "dat/day_21.dat"
  let input = map processInput (lines contents)
  let sets = getSets input

  -- Part 1
  putStrLn $ show $ length $ notAllergen input
  -- Part 2
  putStrLn $ show $ getSolution $ (iterate reduceSets sets) !! 10

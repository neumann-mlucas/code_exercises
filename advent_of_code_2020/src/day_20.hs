import qualified Data.Set as Set
import Data.Set (empty, fromList, intersection)
import Data.List

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

processFile text =
  map (\s -> (getID s, tail s)) (squares text)
  where
    squares = map lines . init . splitStr "\n\n"
    getID = init . last . words . head

getSides (_, square) =
  fromList $ sides ++ rsides
  where
    sides  = [head square, last square, map (head) square, map (last) square]
    rsides = map reverse sides

findNumMatchs set square =
  length $
  filter (/=empty) $
  map (intersection sides) $
  delete sides set
  where
    sides = getSides square

getSolution :: [(String,b)] -> Int
getSolution = product . map (read . fst)

main = do
  squares <- processFile <$> readFile "dat/day_20.dat"
  let setSides = map getSides squares
  let corners = filter (\s -> (==2) $ findNumMatchs setSides s) squares
  putStrLn $ show $ getSolution corners

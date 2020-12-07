import qualified Data.Map as M
import Data.Char
import Data.List
import Data.Monoid

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

toDict :: String -> M.Map String String
toDict passport = M.fromList keyvals
  where
    keyvals = map toKeyVal (words passport)
    toKeyVal str = (x !! 0, x !! 1)
      where
        x = splitStr ":" str

hasField = getAll . foldMap (All .) predicates
  where
    predicates = map (M.member) ["byr","iyr", "eyr","hgt","hcl","ecl","pid"]

checkFields = getAll . foldMap (All .) predicates
  where
    predicates = [byrCheck, iyrCheck, eyrCheck, hgtCheck, hclCheck, eclCheck, pidCheck]

isNum :: String -> Bool
isNum str = getAll $ foldMap (All . isNumber) str

isBetween :: String -> Int -> Int -> Bool
isBetween year lower upper = if isNum year then (read year >= lower) && (read year <= upper) else False

byrCheck pass = isBetween (pass M.! "byr") 1920 2002
iyrCheck pass = isBetween (pass M.! "iyr") 2010 2020
eyrCheck pass = isBetween (pass M.! "eyr") 2020 2030

hgtCheck pass
  | unit == "cm" = num >= 150 && num <= 193
  | unit == "in" = num >= 59 && num <= 76
  | otherwise = False
  where
    content = pass M.! "hgt"
    unit = drop (length content - 2) content
    num = read $ take (length content - 2) content

hclCheck pass
  | x == '#' = length xs == 6
  | otherwise = False
  where
    (x:xs) = pass M.! "hcl"

eclCheck pass = pass M.! "ecl" `elem` ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
pidCheck pass = isNum (pass M.! "pid") && (length $ pass M.! "pid") == 9

main = do
  contents <- readFile "dat/day_04.dat"
  let passports = map (toDict) (splitStr "\n\n" contents)
  let validPass  = filter hasField passports
  let validPass' = filter checkFields validPass
  putStrLn $ show $ length $ validPass
  putStrLn $ show $ length $ validPass'

import Data.List
import Control.Monad (zipWithM)

--- Code from Rosseta

egcd :: Int -> Int -> (Int, Int)
egcd _ 0 = (1, 0)
egcd a b = (t, s - q * t)
  where
    (s, t) = egcd b r
    (q, r) = a `quotRem` b

modInv :: Int -> Int -> Either String Int
modInv a b =
  case egcd a b of
    (x, y)
      | a * x + b * y == 1 -> Right x
      | otherwise ->
        Left $ "No modular inverse for " ++ show a ++ " and " ++ show b

chineseRemainder :: [Int] -> [Int] -> Either String Int
chineseRemainder residues modulii =
  zipWithM modInv crtModulii modulii >>=
  (Right . (`mod` modPI) . sum . zipWith (*) crtModulii . zipWith (*) residues)
  where
    modPI = product modulii
    crtModulii = (modPI `div`) <$> modulii

---

splitStr :: Eq a => [a] -> [a] -> [[a]]
splitStr sub str = split' sub str [] []
  where
  split' _   []  subacc acc = reverse (reverse subacc:acc)
  split' sub str subacc acc
    | sub `isPrefixOf` str = split' sub (drop (length sub) str) [] (reverse subacc:acc)
    | otherwise            = split' sub (tail str) (head str:subacc) acc

getIDs :: String -> [Int]
getIDs line =
  map read $ filter (/="x") (splitStr "," line)

waitingTime :: Int -> Int -> Int
waitingTime start interval  = arrivel - start
  where
   arrivel = interval * ((div start interval) + 1)

getRemMod :: String -> ([Int],[Int])
getRemMod line = unzip values
  where
    values =
      map (\(a,b) -> (read b - a,read b)) $
      filter ((/="x") . snd) $
      zip [0..] (splitStr "," line)


main = do
  contents <- readFile "dat/day_13.dat"
  let start = ((read . head . lines) :: String -> Int)  contents
  let ids = (getIDs . last . lines) contents
  putStrLn $ show $ (\(a,b)->a*b) $ minimum [(waitingTime start id, id) | id <- ids]

  let (a,n) = (getRemMod . last . lines) contents
  putStrLn $ either id show $ chineseRemainder a n

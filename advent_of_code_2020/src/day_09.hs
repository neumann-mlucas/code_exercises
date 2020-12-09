import Data.List

combinations :: (Eq a) => [a] -> Int -> [[a]]
combinations xs n =  filter ((n==).length.nub) $ mapM (const xs) [1..n]

sumPairs :: [Int] -> [Int]
sumPairs xs = map sum (combinations xs 2)

findInvalid [] = 0
findInvalid xs
  | isValid = findInvalid (drop 1 xs)
  | otherwise = num
  where
    isValid = num `elem` (sumPairs preamble)
    num = xs !! 25
    preamble = take 25 xs

findSeq _ [] = []
findSeq target xs
  | isTarget = take idx xs
  | otherwise = findSeq target (drop 1 xs)
  where
    accList = scanl (+) 0 xs
    idx = head $ elemIndices target accList
    isTarget = target `elem` accList

maxMinSeq xs = minimum seq + maximum seq
  where
    seq = findSeq (findInvalid xs) xs

main = do
    contents <- readFile "dat/day_09.dat"
    let input = map (read :: String -> Int) (lines contents)

    putStrLn $ show $ findInvalid input
    putStrLn $ show $ maxMinSeq input

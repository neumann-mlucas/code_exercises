import Data.List

readLine :: String -> [Int]
readLine = map read . words

lastButOne :: [a] -> a
lastButOne = last . take 2 . reverse

step :: [[Int]] -> [[Int]]
step [[x]] = [[x]]
step array =
  let sumLeft  = zipWith (+) (lastButOne array) (tail $ last array)
      sumRigth = zipWith (+) (lastButOne array) (init $ last array)
      maxLine  = zipWith max sumLeft sumRigth
  in
     (++ [maxLine]) $ take (length array - 2) array

helper [[0]] = Nothing
helper i
  | step i == i  = Just (i, [[0]])
  | otherwise    = Just (i, step i)

main = do
  content <- map readLine . lines <$> readFile "dat/euler_018.txt"
  putStrLn $ show $ head . head . last $ unfoldr helper content

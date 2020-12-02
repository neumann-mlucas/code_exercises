import Data.List

combinations :: (Eq a) => [a] -> Int -> [[a]]
combinations xs n =  filter ((n==).length.nub) $ mapM (const xs) [1..n]

find_match :: [Int] -> Int -> [Int]
find_match xs n = head $ filter (\x -> sum x == 2020) (combinations xs n)

solve1st :: [Int] -> Int
solve1st xs = foldr1 (*) (find_match xs 2)
solve2nd :: [Int] -> Int
solve2nd xs = foldr1 (*) (find_match xs 3)

main = do
    contents <- readFile "dat/day_01.dat"
    let input = map (read :: String -> Int) (words contents)
    putStrLn $ show $ solve1st input
    putStrLn $ show $ solve2nd input

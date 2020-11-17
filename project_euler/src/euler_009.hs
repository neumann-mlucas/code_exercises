pythagorean :: Int -> Int -> [Int]
pythagorean m n = [m^2 - n^2, 2 * m * n, m^2 + n^2]
predicate :: Int -> Int -> Bool
predicate m n = (2 * m ^ 2 + 2 * m * n) == 1000

answer :: Int -> Int
answer lim = foldl1 (*) triple
    where triple = head [ pythagorean a b | a <- [1..100], b <- [1..100], (a > b) && predicate a b ]

main = putStrLn $ show $ answer 1000

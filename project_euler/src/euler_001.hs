answer x = sum $ takeWhile (<x) [i | i<-[1..], i `mod` 5 == 0 || i `mod` 3 == 0]
main = putStrLn $ show $ answer 1000

main = do
  content <- map ((read::String->Int) . take 11) . lines <$> readFile "dat/euler_013.txt"
  putStrLn $ take 10 $ show $ sum content

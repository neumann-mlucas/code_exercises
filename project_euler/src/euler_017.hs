unit = ["dummy","one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eighteen","nineteen"]
decimal = ["dummy","dummy","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]

intToWord :: Int -> String
intToWord 1000 = "onethousand"
intToWord n
  | n >= 100 = unit !! q ++ "hundred" ++ tail
  | n >=  20 = decimal !! q' ++ tail'
  | n >=   0 = unit !! n
  where
    (q , r ) = divMod n 100
    (q', r') = divMod n  10
    tail  = if r  > 0 then "and" ++ intToWord r else ""
    tail' = if r' > 0 then intToWord r' else ""

awnser = sum . map (length . intToWord)
main = putStrLn $ show $ awnser [1..1000]

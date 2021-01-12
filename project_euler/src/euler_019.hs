import Data.Time
import Data.List

helper :: Day -> Day -> Maybe (Day,Day)
helper end day
  | end == day = Nothing
  | otherwise  = Just (day, succ day)

isFirstOfMonth :: Day -> Bool
isFirstOfMonth  = (=="01") . drop 8 . show

isSumday = (==Sunday) . dayOfWeek
predicate day = isSumday day && isFirstOfMonth day

main = do
  let begin = fromGregorian 1901 1 1
  let end   = fromGregorian 2000 12 31
  let interval = unfoldr (helper end) begin
  putStrLn $ show $ length $ filter predicate interval


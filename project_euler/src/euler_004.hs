palindrome = read . reverse . show
isPalindrome = \x -> x == palindrome x
answer = maximum [ a*b | a <- [100..999], b <- [100..999], isPalindrome (a*b)]
main = putStrLn $ show $ answer

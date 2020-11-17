palindrome = read . reverse . show
isPalindrome n = n == (palindrome n)
answer = maximum [ a*b | a <- [100..999], b <- [100..999], isPalindrome (a*b)]
main = putStrLn $ show $ answer

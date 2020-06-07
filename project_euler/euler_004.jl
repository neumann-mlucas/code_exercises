ispalindrome(n) = digits(n) == reverse(digits(n))
M = hcat(100:999) .* reshape(100:999,(1,900))
filter(ispalindrome,M) |> maximum |> println

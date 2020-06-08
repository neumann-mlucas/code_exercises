ispalindrome(n) = digits(n) == reverse(digits(n))

function answer(range)
    M = hcat(range) .* reshape(range,(1,length(range)))
    filter(ispalindrome,M) |> maximum
end

answer(100:999) |> print

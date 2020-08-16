to_bin(n) = bitstring(n)[findfirst('1', bitstring(n)):end]
is_palindrome(n) = string(n) == reverse(string(n))
bin_palindrome = is_palindrome ∘ to_bin

function answer(lim)
    filter(x -> is_palindrome(x) && bin_palindrome(x), 1:lim) |> sum
end

answer(1_000_000) |> print

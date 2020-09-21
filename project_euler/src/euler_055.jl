import Base.Iterators: accumulate, drop

is_palindrome(n) = string(n) == reverse(string(n))
helper(n) = n + parse(BigInt, reverse(string(n)))

function is_lychrel(n)
    input = vcat([n], zeros(Int, 50))
    iterations = accumulate((x, _) -> helper(x), input)
    !any(is_palindrome, drop(iterations, 1))
end

function answer(lim)
    filter(is_lychrel, 1:lim) |> length
end


answer(10_000) |> print

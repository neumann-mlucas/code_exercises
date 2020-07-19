is_sum_of_fifth(n) = sum(map(x -> x^5, digits(n))) == n

function answer(lim)
    filter(is_sum_of_fifth, 2:lim) |> sum
end

answer(1_000_000) |> print

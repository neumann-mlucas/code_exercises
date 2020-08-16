is_fact_digits(n) = sum(map(factorial, digits(n))) == n

function answer(lim)
    filter(is_fact_digits, 10:lim) |> sum
end

answer(100000) |> print

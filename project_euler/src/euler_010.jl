is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(n)
    sum(filter(is_prime, 3:2:n)) + 2
end

answer(2_000_000) |> print

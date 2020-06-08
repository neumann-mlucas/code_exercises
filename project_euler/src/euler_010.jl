isprime(n) = map(x -> n % x != 0, 2:isqrt(n)) |> all

function answer(n)
    filter(isprime, 3:2:n) |> x -> sum(x) + 2
end

answer(2_000_000) |> print

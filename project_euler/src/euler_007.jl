isprime(n) = map(x -> n % x != 0, 2:isqrt(n)) |> all

function answer(n)
    filter(isprime, 3:2:200_000) |> x -> getindex(x, n - 1)
end

answer(10_001) |> print

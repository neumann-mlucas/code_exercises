function answer(lim)
    fn(n) = map(x -> binomial(n, x), 1:n-1) |> x -> filter(y -> y > lim, x) |> length
    map(x -> fn(BigInt(x)), 1:100) |> sum
end

answer(1_000_000) |> print

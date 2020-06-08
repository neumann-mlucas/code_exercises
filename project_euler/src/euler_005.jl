function answer(n)
    primes = (2, 3, 5, 7, 11, 13, 17, 19)
    reduce(*, (p^floor(Int, log(p, n)) for p in primes))
end

answer(20) |> print

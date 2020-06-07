let N = 20
    primes = (2, 3, 5, 7, 11, 13, 17, 19)
    reduce(*,(p ^ floor(Int,log(p,N)) for p in primes)) |> println
end

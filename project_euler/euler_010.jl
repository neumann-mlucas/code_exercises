let N = 2_000_000
    isprime(n) = all(n%i!=0 for i in 2:isqrt(n))
    filter(isprime, 3:2:2_000_000) |> x->sum(x)+2 |> println
end

let N = 10001
    isprime(n) = all(n % i != 0 for i in 2:isqrt(n))
    filter(isprime,3:2:1000000) |> x->getindex(x,N-1) |> println
end

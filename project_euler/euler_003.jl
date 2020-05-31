let N = 600851475143
    isprime(n) = all(n%i!=0 for i in 2:isqrt(n))
    filter(x->(N % x == 0 && isprime(x)), 3:2:isqrt(N)) |> last |> println
end

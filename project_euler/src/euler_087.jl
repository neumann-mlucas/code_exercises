using Base.Iterators

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    primes = filter(is_prime, 2:isqrt(lim))
    fn(x) = x[1]^2 + x[2]^3 + x[3]^4
    (fn(x) for x in product(primes, primes, primes) if fn(x) < lim) |> unique |> length
end

answer(50_000_000) |> print

using Base.Iterators

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    primes = filter(is_prime, 2:lim)
    takewhile(x -> x < lim, accumulate(*, primes)) |> collect |> last

end

answer(1_000_000) |> print

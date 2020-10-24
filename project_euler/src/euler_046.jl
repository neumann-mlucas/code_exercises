using Base.Iterators

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function is_prime_plus_square(n)
    twice_square = takewhile(x -> x < n, (2 * x^2 for x in countfrom()))
    any(is_prime, (n - i for i in twice_square))
end

function answer(lim)
    primes = filter(is_prime, 3:2:lim) |> Set
    odd_composite = setdiff(3:2:lim, primes)
    filter(x -> !is_prime_plus_square(x), odd_composite) |> first
end

answer(10_000) |> print

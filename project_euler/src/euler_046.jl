import Base.Iterators: countfrom, filter, first, takewhile

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    primes = filter(is_prime, 3:2:lim) |> Set
    odd_composite = setdiff(3:2:lim, primes)
    filter(x -> !is_prime_plus_square(x), odd_composite) |> first
end

function is_prime_plus_square(n)
    twice_square = takewhile(x -> x < n, (2 * x^2 for x in countfrom()))
    any(is_prime, (n - i for i in twice_square))
end


answer(10_000) |> print

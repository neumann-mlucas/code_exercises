import Base.Iterators: filter, first

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    primes = filter(is_prime, 2:lim) |> collect
    not_prime = [!(n in primes) for n = 1:lim]

    all_factors(n) = (p for p in primes if rem(n, p) == 0 && p < 2 * isqrt(n))
    has_four_factors(n) = length(collect(all_factors(n))) == 4

    predicate(q) = all(x -> not_prime[x], q) && all(has_four_factors, q)
    filter(x -> predicate(x:x+3), 1:lim-4) |> first
end


answer(150_000) |> print

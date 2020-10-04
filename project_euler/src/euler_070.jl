import Base.Iterators: filter, product

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))
is_perm(m, n) = sort(digits(m)) == sort(digits(n))
totient(p1, p2) = (p1 - 1) * (p2 - 1)

function answer(lim)
    lower, upper = 1_000, 5_000

    primes = filter(is_prime, lower:upper) |> collect
    pairs = filter(x -> x[1] != x[2], product(primes, primes))

    tots =
        ((p[1] * p[2], totient(p...)) for p in pairs) |>
        t -> filter(x -> is_perm(x...) && x[1] < lim, t) |> collect

    argmin([n / t for (n, t) in tots]) |> x -> first(tots[x])
end

answer(10_000_000) |> print

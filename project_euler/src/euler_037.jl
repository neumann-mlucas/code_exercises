import Base.Iterators: map, zip, flatten

is_prime(n) = map(x -> n % x != 0, 2:isqrt(n)) |> all
str_prime(s) = s != "1" && is_prime(parse(Int64, s))

function is_truncatable(n)
    N, L = string(n), length(string(n))

    left = map(x -> N[1:x], 1:L)
    rigth = map(x -> N[x:end], 1:L)

    c1 = all(map(str_prime, left))
    c2 = all(map(str_prime, rigth))

    (n > 10 && c1 && c2) ? true : false
end

function answer(lim)
    primes = filter(is_prime, 2:lim)
    filter(is_truncatable, primes) |> sum
end

answer(1_000_000) |> print

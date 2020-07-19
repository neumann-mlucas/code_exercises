isprime(n) = map(x -> n % x != 0, 2:isqrt(n)) |> all


function quadratic(a, b)
    fn(x) = x^2 + a * x + b
end

function quadratic_primes(eq)
    map(eq, 0:1000) |>
    x -> Base.Iterators.takewhile(y -> (y > 0 && isprime(y)), x) |> collect |> length
end

function answer(lim)
    fn(x, y) = (quadratic_primes(quadratic(x, y)), x, y)

    Base.Iterators.product(-lim:lim, -lim:lim) |>
    x -> map(y -> fn(y...), x) |> maximum |> x -> x[2] * x[3]

end

answer(1000) |> print

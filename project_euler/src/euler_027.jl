import Base.Iterators: product, takewhile

is_prime(n) = n > 0 && all(x -> n % x != 0, 2:isqrt(n))
quadratic(a, b) = fn(x) = x^2 + a * x + b

function quadratic_primes(eq)
    takewhile(is_prime, (eq(x) for x = 0:1_000)) |> collect |> length
end

function answer(lim)
    fn(x, y) = (quadratic_primes(quadratic(x, y)), x, y)

    product(-lim:lim, filter(is_prime, 1:lim)) |>
    x -> map(y -> fn(y...), x) |> maximum |> x -> x[2] * x[3]

end

answer(1000) |> print

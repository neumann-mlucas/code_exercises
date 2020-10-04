import Base.Iterators: accumulate, filter, takewhile

function iter_frac(m, d, a, S)
    M = d * a - m
    D = (S - M^2) ÷ d
    A = (isqrt(S) + M) ÷ D
    return M, D, A, S
end

function fraq_sqrt(n)
    init = (0, 1, isqrt(n), n)
    frac = accumulate((x, _) -> iter_frac(x...), zeros(100), init = init)
    (n, (x -> x[3]).(frac))
end

function find_root(S, frac)
    fn(x, y) = (x[2], BigInt(frac[y]) * x[2] + x[1])
    nth = accumulate((x, y) -> fn(x, y), 1:100, init = (1, isqrt(S))) .|> last

    fd(x, y) = (x[2], BigInt(frac[y]) * x[2] + x[1])
    dth = accumulate((x, y) -> fd(x, y), 1:100, init = (0, 1)) .|> last

    filter(x -> (x[1]^2 - S * x[2]^2) == 1, zip(nth, dth)) |> first
end

function answer(lim)
    i_sqrt = filter(x -> !isinteger(sqrt(x)), 1:lim)
    map(x -> find_root(fraq_sqrt(x)...), i_sqrt) |> x -> collect(i_sqrt)[argmax(x)]
end

answer(1000) |> print

bash: line 1: bash:: command not found

function fn(m, d, a, S)
    M = d * a - m
    D = (S - M^2) ÷ d
    A = (isqrt(S) + M) ÷ D
    return M, D, A, S
end

function fraq_sqrt(n)
    init = (0, 1, isqrt(n), n)
    frac = accumulate((x, _) -> fn(x...), zeros(1_000), init = init)
    # periodic part ends when the condition is satisfied
    cycle = takewhile(x -> x[3] != 2 * isqrt(n), frac)
    (x -> x[3]).(cycle)
end

cycle_len(n) = fraq_sqrt(n) |> x -> length(x) + 1

function answer(lim)
    i_sqrt = filter(x -> !isinteger(sqrt(x)), 1:lim)
    map(x -> cycle_len(x) % 2 != 0, i_sqrt) |> sum
end

answer(10_000) |> print

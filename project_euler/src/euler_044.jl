P(n) = Int64((3 * n * n - n) / 2)
is_P(n) = isinteger((1 + sqrt(1 + 24 * n)) / 6)
is_2P(n) = n % 2 == 0 && is_P(div(n, 2))

# 2P(k+i) = P(m) + P(n)
# 2P(k)   = P(m) - P(n)
predicate(m, n) = is_2P(P(m) + P(n)) && is_2P(P(m) - P(n))

function answer(lim)
    idx = ((i, j) for i = 1:lim for j = 1:i-1)
    for (m, n) in idx
        predicate(m, n) && return P(n)
    end
end

answer(1_000_000) |> print

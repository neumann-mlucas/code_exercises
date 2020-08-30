import Base.Iterators: filter

T(n) = Int64((n * n + n) / 2)
P(n) = Int64((3 * n * n - n) / 2)
H(n) = Int64((2 * n * n - n))

is_T(n) = isinteger(sqrt(8 * n + 1))
is_P(n) = isinteger((1 + sqrt(1 + 24 * n)) / 6)

predicate(n) = is_T(n) && is_P(n)

function answer(lim)
    filter(predicate, (H(x) for x = 144:lim)) |> first
end


answer(1_000_000) |> print

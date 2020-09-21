import Base.Iterators: first, filter

multiples(n) = map(x -> digits(x * n), 1:6)
same_digits(m) = all(x -> x == sort(m[1]), sort.(m))

function answer(lim)
    predicate(n) = same_digits(multiples(n))
    filter(predicate, 1:lim) |> first
end


answer(1_000_000) |> print

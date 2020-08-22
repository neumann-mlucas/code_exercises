is_pandigital(n) = length(n) == 9 && Set(n) == Set("123456789")
cat_prod(n, i) = reduce((a, b) -> a * b, map(string, collect(1:i) * n))

function cat_is_pandigital(n)
    any(is_pandigital, map(x -> cat_prod(n, x), 1:10))
end

function answer(lim)
    n = filter(cat_is_pandigital, 1:lim) |> maximum
    filter(is_pandigital, map(x -> cat_prod(n, x), 1:10)) |> first
end

answer(10_000) |> print

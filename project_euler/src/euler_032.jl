import Base.Iterators.product
import Base.Iterators.filter

function is_pandigital(m, n)
    pandigital = string(m) * string(n) * string(m * n)
    m > n && length(pandigital) == 9 && Set(pandigital) == Set("123456789")
end

function answer(lim)
    filter(x -> is_pandigital(x...), product(1:lim, 1:lim)) |>
    x -> map(prod, x) |> x -> Set(x) |> sum
end

answer(2000) |> print

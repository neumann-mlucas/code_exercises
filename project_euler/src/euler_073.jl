using Base.Iterators

in_range(n) = (1 // 3 < n < 1 // 2) ? n : 1 // 1
fn(d) = (in_range(n // d) for n = div(d, 3):div(d, 2))

function answer(lim)
    (fn(d) for d = 2:lim) |> flatten |> Set |> x -> length(x) - 1
end

answer(12_000) |> print

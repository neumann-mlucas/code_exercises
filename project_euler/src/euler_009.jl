get_pythagorean(m, n) = m^2 - n^2, 2 * m * n, m^2 + n^2
condition(x) = x[1] > x[2] && sum(get_pythagorean(x...)) == 1000

function answer(range)
    Base.Iterators.product(range, range) |>
    collect |>
    x -> filter(condition, x) |> first |> x -> reduce(*, get_pythagorean(x...))
end

answer(1:100) |> print

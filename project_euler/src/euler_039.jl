count_div(n) = sum(map(x -> n % x == 0, 1:div(n, 2)))

function answer(lim)
    ps = 12:2:1000
    sort(ps, by = x -> count_div(x)) |> last
end

answer(1_000) |> print

sort_cube(n) = BigInt(n)^3 |> string |> collect |> sort |> join
hist(l) = (count(i -> i == n, l) for n in l) |> collect

function answer(lim)
    h = map(sort_cube, 1:lim) |> hist
    findnext(i -> i == 5, h, 1)^3
end

answer(10_000) |> print

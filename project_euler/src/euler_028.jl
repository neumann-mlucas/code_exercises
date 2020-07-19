nth_stride(n) = 2 * n
nth_start(n) = 1 + sum(map(x -> 4 * x, 2:2:nth_stride(n)))

sum_corners(start, stride) = map(x -> (start + x * stride), 1:4) |> sum

function answer(size)
    lim = div(size - 1, 2)

    map(x -> (nth_start(x - 1), nth_stride(x)), 1:lim) |>
    x -> map(y -> sum_corners(y...), x) |> x -> sum(x) + 1
end

answer(1001) |> print

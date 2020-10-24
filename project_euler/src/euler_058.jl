using Base.Iterators

nth_stride(n) = 2 * n
nth_start(n) = 1 + sum(map(x -> 4 * x, 2:2:nth_stride(n)))
nth_corners(start, stride) = map(x -> (start + x * stride), 1:4)

function gen_corners(size)
    map(x -> (nth_start(x - 1), nth_stride(x)), 1:div(size - 1, 2)) |>
    x -> map(y -> nth_corners(y...), x) |> flatten |> collect
end

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))
predicate(vec) = (sum(vec) / (1 + length(vec))) <= 0.1

function answer(lim)
    p_corners = is_prime.(gen_corners(lim))
    filter(x -> predicate(p_corners[1:2*(x-1)]), 3:2:lim) |> first
end

answer(50_000) |> print

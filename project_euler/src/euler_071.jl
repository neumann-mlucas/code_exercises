function answer(lim)
    ((3 * n - 1) // (7 * n) for n = 1:div(lim, 7)) |> collect |> sort |> last |> numerator
end

answer(1_000_000) |> print

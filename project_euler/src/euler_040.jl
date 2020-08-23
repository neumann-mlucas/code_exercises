function answer(lim)
    n = reduce((x, y) -> x * y, map(string, 1:lim))
    reduce((x, y) -> x * y, map(x -> parse(Int64, n[10^x]), 0:6))
end

answer(1_000_000) |> print

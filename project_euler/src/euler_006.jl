function answer(range)
    map(x -> x^2, range) |> sum |> x -> (sum(range)^2 - x)
end

answer(1:100) |> print

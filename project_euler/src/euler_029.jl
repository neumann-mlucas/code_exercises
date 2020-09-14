function answer(range)
    pairs = Base.Iterators.product(range, range)
    map(x -> BigInt(x[1])^BigInt(x[2]), pairs) |> Set |> length
end

answer(2:100) |> print

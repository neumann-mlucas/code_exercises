function answer(pow)
    BigInt(2)^pow |> digits |> sum
end

answer(1_000) |> print

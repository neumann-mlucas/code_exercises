function answer(n)
    BigInt(n) |> factorial |> digits |> sum
end

answer(100) |> print

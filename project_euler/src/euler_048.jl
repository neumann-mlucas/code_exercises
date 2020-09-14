function answer(lim)
    sum(BigInt(x)^x for x = 1:lim) % 10^10
end

answer(1000) |> print

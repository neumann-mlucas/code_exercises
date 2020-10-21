function answer(lim)
    pow = powermod(2, 7830457, 10^lim)
    (28433 * pow + 1) % (10^lim)
end

answer(10) |> print

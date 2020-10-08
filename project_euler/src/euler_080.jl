function answer(lim)
    setprecision(BigFloat, 512)

    str_sqrt = collect ∘ string ∘ sqrt ∘ BigFloat
    sum_one_hundred(n) = parse.(Int, str_sqrt(n)[3:101]) |> x -> (sum(x) + isqrt(n))

    i_sqrt = filter(x -> !isinteger(sqrt(x)), 1:lim)
    sum(sum_one_hundred, i_sqrt)
end

answer(100) |> print

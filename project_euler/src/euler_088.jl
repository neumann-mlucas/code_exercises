function answer(lim)
    # DP algorithm
    function prodsum(p, s, c, start)
        k = p - s + c
        if k < lim
            factors[k] = min(p, factors[k])
            foreach(i -> prodsum(p * i, s + i, c + 1, i), start:div(lim, p)*2)
        end
    end
    factors = fill(2 * lim, lim - 1)
    prodsum(1, 1, 1, 2)
    factors |> unique |> x -> sum(x) - 1
end

answer(12_000) |> print

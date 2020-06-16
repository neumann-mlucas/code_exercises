function answer(n, m, d)

    if m == 0
        return d
    end

    q, n = divrem(n, factorial(m))
    d[q+1] |> print

    answer(n, m - 1, d[1:q] * d[q+2:end])
end

d = "0123456789"
answer(999_999, 9, d) |> print

function answer(lim)
    # recursive solutions for the quadratic diophantine equation
    fn(b, n) = (n > lim) ? b : fn(3 * b + 2 * n - 2, 4 * b + 3 * n - 3)
    fn(15, 21)
end

answer(10^12) |> print

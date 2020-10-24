using Base.Iterators

function do_cancel(m, n)
    a, b = divrem(m, 10)
    c, d = divrem(n, 10)
    (c == 0 || d == 0) ? false : (b == c && m // n == a // d) || (a == d && m // n == b / c)
end

function answer(lim)
    numbers = Iterators.filter(x -> x[1] < x[2], product(1:lim, 1:lim))
    fraq = Iterators.filter(x -> do_cancel(x...), numbers) |> collect
    prod(map(prod, map(x -> x[1] // x[2], fraq))) |> denominator

end

answer(99) |> print

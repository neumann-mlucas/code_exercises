import Base.Iterators: dropwhile, filter, takewhile

function fn(power)
    (BigInt(n)^power for n = 1:100_000) |>
    i ->
        dropwhile(x -> ndigits(x) < power, i) |>
        i -> takewhile(x -> ndigits(x) == power, i) |> i -> length(collect(i))
end

function answer(lim)
    map(fn, 1:lim) |> sum
end

answer(25) |> print

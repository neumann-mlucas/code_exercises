using Base.Iterators

function nth_A143714(n)
    fn(a, b) = ((a + b)^2 + n^2) |> sqrt |> isinteger
    ((fn(a, b) for b = 1:a) for a = 1:n) |> flatten |> sum
end

function answer(lim)
    acc = Iterators.accumulate(+, (nth_A143714(n) for n in countfrom()))
    takewhile(x -> x < lim, acc) |> collect |> x -> length(x) + 1
end

answer(1_000_000) |> print

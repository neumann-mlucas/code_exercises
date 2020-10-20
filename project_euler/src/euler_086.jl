using Base.Iterators: accumulate, countfrom, flatten, takewhile

function answer(lim)
    acc = accumulate(+, (nth_A143714(n) for n in countfrom()))
    takewhile(x->x<lim, acc) |> collect |> x->length(x)+1
end

function nth_A143714(n)
    fn(a,b) = ((a+b)^2 + n^2) |> sqrt |> isinteger
    ((fn(a,b) for b in 1:a) for a in 1:n) |> flatten |> sum
end

answer(1_000_000) |> print

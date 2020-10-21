import Base.Iterators: accumulate, countfrom, repeated, takewhile

function gen_divtable(lim)
    list = [1 for i = 1:lim]
    for d = 2:lim
        foreach(x -> list[x] += d, (d+d):d:lim)
    end
    list
end

function answer(lim)
    function gen_chain(n)
        fn(x) = (x < lim) ? d[x] : 1
        predicate(x) = x != start && x != 1

        start = reduce((x, f) -> f(x), repeated(fn, 75), init = n)
        accumulate((x, _) -> fn(x), countfrom(), init = start) |>
        acc -> takewhile(predicate, acc) |> collect
    end
    d = gen_divtable(lim)
    [gen_chain(n) for n = 1:lim] |> x -> sort(x, by = length) |> last |> minimum
end

answer(1_000_000) |> print

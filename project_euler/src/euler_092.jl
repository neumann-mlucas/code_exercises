function chain(n::Int64)
    if n == 1 || n == 89
        return n
    end
    sum(digits(n) .^ 2) |> chain
end

function answer(lim)
    map(x -> chain(x) == 89, 1:lim) |> sum
end

answer(10_000_000) |> print

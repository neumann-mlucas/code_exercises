helper(current::BigInt, next::BigInt, n::BigInt) =
    n == 0 ? current : helper(next, next + current, n - 1)
tfib(n) = helper(BigInt(0), BigInt(1), BigInt(n))

function answer(range)
    ns = map(tfib, range)
    filter(x -> length(string(x)) < 1000, ns) |> x -> length(x) + 1
end

answer(1:5000) |> print

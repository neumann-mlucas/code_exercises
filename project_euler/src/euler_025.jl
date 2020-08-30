import Base.Iterators: countfrom, takewhile

helper(current::BigInt, next::BigInt, n::BigInt) =
    n == 0 ? current : helper(next, next + current, n - 1)
tfib(n) = helper(BigInt(0), BigInt(1), BigInt(n))

function answer(lim)
    predicate(n) = length(string(tfib(n))) < lim
    takewhile(predicate, countfrom()) |> collect |> x -> last(x) + 1
end

answer(1000) |> print

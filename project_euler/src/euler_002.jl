helper(current, next, n) = n == 0 ? current : helper(next, next + current, n - 1)
tfib(n) = helper(0, 1, n)

function answer(lim)
    upper = filter(x -> tfib(x) > lim, 1:50) |> first
    mapreduce(tfib, +, 3:3:upper-1)
end

answer(4_000_000) |> print

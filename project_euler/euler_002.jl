helper(current, next, n) = n==0 ? current : helper(next, next+current, n-1)
tfib(n) = helper(0, 1, n)

let LIM = 33
    mapreduce(tfib, +, 3:3:LIM) |> println
end

function answer(m,n)
    union(m:m:999, n:n:999) |> sum
end

answer(5,3) |> print

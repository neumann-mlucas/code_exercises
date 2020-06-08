function answer(m,n)
    filter(x->x % n == 0,1:m:1000) |> sum
end

answer(5,3) |> print

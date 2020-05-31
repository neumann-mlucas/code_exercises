let m = 3, n = 5
    filter(x->x%n==0,1:m:1000) |> sum |> println
end

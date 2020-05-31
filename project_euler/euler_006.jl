map(x->x^2, 1:100) |> sum |> x->(sum(1:100)^2 -x) |> println

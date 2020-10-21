import Base.Iterators: filter, flatten, product

function n_triangles(a, b)
    fn(x) = (a * (a - x)) / b + b
    predicate(y) = (isinteger(y) && 0 <= y <= 50) ? 1 : 0
    x_is_valid(x) = predicate(fn(x))

    (x_is_valid(x) for x in 0:50 if x != a) |> sum
end

function answer(lim)
    base_case = lim * lim * 3
    (n_triangles(x, y) for (x, y) in product(1:50, 1:50)) |> x -> sum(x) + base_case
end

answer(50) |> print

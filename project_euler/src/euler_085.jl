import Base.Iterators: flatten

num_rectangles(m, n) = div(m * (m + 1) * n * (n + 1), 4)

function answer(lim)
    goal = 2_000_000
    loss(n, m) = abs(num_rectangles(n, m) - goal)
    fn(m) = ((loss(m, n), m * n) for n = 1:m)
    flatten((fn(m) for m = 1:lim)) |> minimum |> last
end

answer(100) |> print

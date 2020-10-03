import Base.Iterators: dropwhile, filter, takewhile
m(n) = ((n + 1) % 3 == 0) ? 2 * div(n + 1, 3) : 1 # 1,2,1,1,4,1,1,6...
# Bad way to do recursion
function answer(lim)
    fn(x, y) = (last(x), BigInt(m(y)) * last(x) + first(x))
    reduce((x, y) -> fn(x, y), 1:lim, init = (1, 2)) |> last |> digits |> sum
end

answer(99) |> print

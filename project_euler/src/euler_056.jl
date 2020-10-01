import Base.Iterators: product

fn(x, y) = (sum ∘ digits ∘ ^)(BigInt(x), y)

function answer(lim)
    map(x -> fn(x...), product(1:lim, 1:lim)) |> maximum
end

answer(100) |> print

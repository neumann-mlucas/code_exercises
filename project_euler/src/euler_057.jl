ln = length ∘ string ∘ numerator
ld = length ∘ string ∘ denominator

fn(c) = (c != 0) ? BigInt(1) // (2 + fn(c - 1)) : 0
predicate(f) = ln(f) == ld(f) + 1

function answer(lim)
    map(x -> fn(x) + 1, 1:lim) .|> predicate |> sum
end

answer(1000) |> print

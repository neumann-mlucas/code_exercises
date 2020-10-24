using Base.Iterators

factorial_digits(n) = sum(factorial.(digits(n)))

function answer(lim)
    d_cycles = Dict(
        169 => 4,
        363601 => 4,
        1454 => 4,
        871 => 3,
        45361 => 3,
        872 => 3,
        45362 => 3,
        1 => 1,
        2 => 1,
        145 => 1,
        40585 => 1,
    )
    forbid = keys(d_cycles) |> Set

    gen_chain(n) =
        Iterators.accumulate((x, _) -> factorial_digits(x), cycle(0), init = n) |>
        iter -> takewhile(x -> !(x in forbid), iter) |> collect

    cycle_length(c) = (isempty(c)) ? 0 : last(c) |> factorial_digits |> x -> d_cycles[x]
    len_chain(n) = gen_chain(n) |> c -> (length(c) + cycle_length(c))

    map(x -> len_chain(x) == 60, 1:lim) |> sum
end

answer(1_000_000) |> print

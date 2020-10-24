using Base.Iterators

IDXS = [
    BitArray([1, 1, 0, 0, 0, 1]),
    BitArray([1, 0, 1, 0, 0, 1]),
    BitArray([1, 0, 0, 1, 0, 1]),
    BitArray([1, 0, 0, 0, 1, 1]),
    BitArray([0, 1, 1, 0, 0, 1]),
    BitArray([0, 1, 0, 1, 0, 1]),
    BitArray([0, 1, 0, 0, 1, 1]),
    BitArray([0, 0, 1, 1, 0, 1]),
    BitArray([0, 0, 1, 0, 1, 1]),
    BitArray([0, 0, 0, 1, 1, 1]),
]

is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))
predicate(vec) = sum(map(is_prime, vec)) == 8 # sum works with iterators

function gen_number(d, n, idx)
    out = fill(d, 6)
    out[idx] = reverse(digits(n))
    join(out) |> x -> parse(Int, x)
end

function gen_series(n, idx)
    out = map(x -> gen_number(x, n, idx), 1:9)
    any(out .< 100_000) ? [0] : out # not necessary
end

function answer()
    global IDXS
    series = (gen_series(n...) for n in product(100:999, IDXS))
    Iterators.filter(predicate, series) |> first |> first
end

answer() |> print

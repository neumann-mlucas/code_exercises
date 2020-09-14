is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))
is_pandigital(n) = sort(digits(n)) == sort(1:ceil(Int64, log10(n)))
predicate(n) = is_pandigital(n) && is_prime(n)

function answer(lim)
    filter(predicate, 11:2:lim) |> last
end

answer(10_000_000) |> print

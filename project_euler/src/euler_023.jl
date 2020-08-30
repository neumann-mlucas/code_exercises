using Base.Iterators

divisors(n) = filter(x -> rem(n, x) == 0, 1:isqrt(n))
sum_divisors(n) = union(divisors(n), map(x -> div(n, x), divisors(n))) |> sum
is_abundant(n) = n < (sum_divisors(n) - n)

function answer()
    abundant = filter(is_abundant, 1:28123)
    map(sum, product(abundant, abundant)) |> x -> setdiff(1:28123, x) |> sum
end

answer() |> print

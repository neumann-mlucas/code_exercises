using Base.Iterators

divisors(n) = filter(x -> rem(n, x) == 0, 1:isqrt(n))
sum_divisors(n) = union(divisors(n), map(x -> n ÷ x, divisors(n))) |> x -> sum(x) - n
is_abundant(n) = n < sum_divisors(n)

function answer()
    abundant = filter(is_abundant, 1:28123)
    product(abundant, abundant) .|> sum |> x -> setdiff(1:28123, x) |> sum
end

answer() |> print

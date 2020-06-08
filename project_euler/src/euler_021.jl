divisors(n) = filter(x -> rem(n, x) == 0, 1:isqrt(n))
sum_divisors(n) = union(divisors(n), map(x -> n ÷ x, divisors(n))) |> x -> sum(x) - n
is_amicable(n) = n == sum_divisors(sum_divisors(n)) && n != sum_divisors(n)

function answer(lim)
    filter(is_amicable, 1:lim) |> sum
end

answer(10_000) |> print

using Base.Iterators

trigonal(n) = (n+1) * n ÷ 2
divisors(n) = filter(x->rem(n,x) == 0, 1:isqrt(n))
number_of_divisors(n) = sum(map(x->(x == n/x) ? 1 : 2, divisors(n)))

function answer(lim)
    n = Iterators.map(trigonal,1:100_000)
    m = Iterators.filter(x->number_of_divisors(x) >= lim,n)
    Iterators.first(m)
end

answer(500) |> print

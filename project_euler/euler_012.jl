trigonal(n) = (n+1) * n ÷ 2
divisors(n) = filter(x->rem(n,x) == 0, 1:isqrt(n))
number_of_divisors(n) = sum(map(x->(x == n/x) ? 1 : 2, divisors(n)))

let LIM = 500
    n = Base.Iterators.map(trigonal,1:100_000)
    m = Base.Iterators.filter(x->number_of_divisors(x) >= LIM,n)
    Base.Iterators.first(m) |> println
end



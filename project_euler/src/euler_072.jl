is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    T = collect(1:lim)
    primes = filter(is_prime, 2:lim)
    for p in primes
        foreach(i -> T[i] *= (1 - 1 // p), p:p:lim)
    end
    sum(T) - 1
end

answer(1_000_000) |> print

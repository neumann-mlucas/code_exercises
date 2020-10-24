is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))
seq_is_prime(n) = is_prime(n + 3330) && is_prime(n + 6660)
predicate(n) = seq_is_prime(n) && seq_is_permutation(n)

function seq_is_permutation(n)
    a, b, c = string(n), string(n + 3330), string(n + 6660)
    Set(a) == Set(b) == Set(c)
end

function answer()
    primes = filter(is_prime, 1_000:10_000)
    n = filter(predicate, primes) |> last
    string(n) * string(n + 3330) * string(n + 6660)
end

answer() |> print

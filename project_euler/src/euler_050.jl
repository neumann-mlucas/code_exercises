is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(lim)
    predicate(x) = x < lim && is_prime(x)
    find_longest_seq(pn) = map(predicate, accumulate(+, primes[pn:end])) |> findlast

    primes = filter(is_prime, 2:100_000)
    seqs = map(find_longest_seq, 1:length(primes))
    l, p = findmax(seqs)

    accumulate(+, primes[p:p+l-1]) |> last
end


answer(1_000_000) |> print

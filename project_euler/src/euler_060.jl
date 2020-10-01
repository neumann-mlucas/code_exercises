using Combinatorics
import Base.Iterators: filter, flatten

⋆(a::Integer, b::Integer) = a * 10^ndigits(b) + b

function sieve(n::Int)
    isprime = trues(n)
    isprime[1] = false
    for p = 2:n
        if isprime[p]
            j = p * p
            if j > n
                return findall(isprime)
            else
                for k = j:p:n
                    isprime[k] = false
                end
            end
        end
    end
end

function hist(pairs)
    d = Dict()
    foreach(x -> d[x] = [], flatten(pairs))
    for (a, b) in pairs
        push!(d[a], b)
    end
    return d
end


function answer(lim)

    cat_isprime(m::Integer, n::Integer) = (m ⋆ n in primes) && (n ⋆ m in primes)
    predicate(v) = all(x -> cat_isprime(x...), combinations(v, 2))

    fn(a, b, c) = intersect(h[a], h[b], h[c])
    ff(a, b, s) = a in s && b in s

    primes = sieve(lim^2) |> Set
    pairs = filter(x -> cat_isprime(x...), combinations(sieve(lim), 2)) |> collect
    h = hist(pairs)

    for (a, b) in pairs
        k = intersect(h[a], h[b])
        if isempty(k) || length(k) < 3
            continue
        end
        p = filter(predicate, combinations(k, 3))
        (!isempty(p)) ? (return sum([a b only(p)...])) : continue
    end
end

answer(10_000) |> print

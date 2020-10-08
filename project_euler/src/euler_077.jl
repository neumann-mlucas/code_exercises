is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(target)
    primes = filter(is_prime, 2:1000)
    ways = vcat([1], zeros(Int, target))
    for p in primes
        for i = p+1:length(ways)
            ways[i] += ways[i-p]
        end
    end
    findnext(i -> i > target, ways, 1) - 1
end

answer(5000) |> print

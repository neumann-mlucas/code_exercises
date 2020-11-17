is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function answer(n)
    filter(x -> (n % x == 0 && is_prime(x)), 3:2:isqrt(n)) |> last
end

answer(600851475143) |> print

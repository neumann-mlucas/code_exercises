to_integer(n) = map(x -> x[2] * 10^(x[1] - 1), enumerate(n)) |> sum
is_prime(n) = all(x -> n % x != 0, 2:isqrt(n))

function all_rotations(n)
    shifts = length(digits(n)) - 1
    map(x -> to_integer(circshift(digits(n), x)), 0:shifts)
end

function answer(lim)
    primes = filter(is_prime, 2:lim)
    p_circ = map(all_rotations, primes) .|> x -> all(map(is_prime, x))
    sum(p_circ)
end

answer(1_000_000) |> print

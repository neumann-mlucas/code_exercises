function collatz(n, c = 0)
    c += 1
    (n == 1) ? c : (n % 2 == 0) ? collatz(n / 2, c) : collatz(3n + 1, c)
end

function answer(lim)
    map(collatz, 1:lim) |> argmax
end

answer(1_000_000) |> print

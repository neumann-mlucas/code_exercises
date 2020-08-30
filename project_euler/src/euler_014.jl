function collatz(n, c = 0)
    (n == 1) ? c : (n % 2 == 0) ? collatz(div(n, 2), c + 1) : collatz(3n + 1, c + 1)
end

function answer(lim)
    map(collatz, 1:lim) |> argmax
end

answer(1_000_000) |> print

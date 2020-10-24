using Base.Iterators

function pentagonal(n)
    iter = zip(1:n, -1:-1:-n) |> flatten
    [div(k * (3 * k - 1), 2) for k in iter]
end

psign(n) = (n % 4 == 1 || n % 4 == 2) ? 1 : -1

function answer(goal)
    p = pentagonal(250)
    piles = vcat([1, 1], zeros(Int, 100_000))
    # particions(0) = 1 and particions(1) = 1
    # but that would raise a BoundError
    n = 2
    while piles[n] != 0
        n += 1
        for (nth, pth) in takewhile(x -> x[2] < n, enumerate(p))
            piles[n] += psign(nth) * piles[n-pth]
        end
        piles[n] %= goal
    end
    return n - 1 # off-by-one error
end

answer(1_000_000) |> print

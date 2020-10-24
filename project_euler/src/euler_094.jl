using Base.Iterators

sides(m, n) = [m^2 - n^2, 2 * m * n, m^2 + n^2]

function perimeter(a, b, c)
    (abs(2 * a - c) == 1) ? 2 * (a + c) : 2 * (b + c)
end

function almost_equilateral(m::Int64)
    M = m * m
    predicate(m, n, N) = abs(M - 3 * N) == 1 || abs(4 * m * n - M - N) == 1
    fn(m, n) = perimeter(sides(m, n)...)
    (fn(m, n) for n in 1:(m-1) if predicate(m, n, n * n))
end

function answer(lim)
    mlim = 25_000
    triangles = flatten(almost_equilateral(m) for m = 2:mlim)
    (t for t in triangles if t < lim) |> sum
end

answer(1_000_000_000) |> print

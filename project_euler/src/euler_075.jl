using Base.Iterators

sides(m, n) = [m^2 - n^2, 2 * m * n, m^2 + n^2]

function answer(lim)
    multiples(m, n) =
        (sort(i .* sides(m, n)) for i in countfrom()) |>
        iter -> takewhile(x -> sum(x) < lim, iter)

    mth_multiples(m) = flatten(multiples(m, n) for n = 1:m-1)

    mlim = 1000
    triangles = flatten(mth_multiples(m) for m = 1:mlim) |> unique

    L = zeros(lim)
    for triangle in triangles
        L[sum(triangle)] += 1
    end
    count(x -> x == 1, L)
end

answer(1_500_000) |> print

using Base.Iterators
using Random

p0(n) = n[1] != 0
p1(n) = n[4] % 2 == 0
p2(n) = n[6] == 0 || n[6] == 5
p3(n) = (n[3] + n[4] + n[5]) % 3 == 0
p4(n) = (100 * n[5] + 10 * n[6] + n[7]) % 7 == 0
p5(n) = (100 * n[6] + 10 * n[7] + n[8]) % 11 == 0
p6(n) = (100 * n[7] + 10 * n[8] + n[9]) % 13 == 0
p7(n) = (100 * n[8] + 10 * n[9] + n[10]) % 17 == 0

predicate(n) = p0(n) && p1(n) && p2(n) && p3(n) && p4(n) && p5(n) && p6(n) && p7(n)

dig2int(n) = map((x, y) -> x * 10^y, reverse(n), 0:10) |> sum

# MONTE CARLO LIKE SEARCH
function answer(lim)
    D = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    Iterators.filter(predicate, map(shuffle, repeated(D, lim))) |>
    x -> map(dig2int, x) |> unique |> sum
end

answer(25_000_000) |> print

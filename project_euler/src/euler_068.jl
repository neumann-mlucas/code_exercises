using Combinatorics
using Base.Iterators

function to_int(m, v)
    id = m .* transpose(v)

    # 5-gon lines ordered from ext. node to int. node
    l1 = (id[1, :][3], id[1, :][2], id[1, :][1])
    l2 = (id[2, :][5], id[2, :][4], id[2, :][2])
    l3 = (id[3, :][7], id[3, :][6], id[3, :][4])
    l4 = (id[4, :][9], id[4, :][8], id[4, :][6])
    l5 = (id[5, :][10], id[5, :][1], id[5, :][8])

    M = [l1, l2, l3, l4, l5]

    # clockwise order
    rst = argmin(first.(M))
    collect.(M)[vcat(rst:-1:1, 5:-1:rst+1)] |>
    flatten .|>
    string |>
    join |>
    x -> parse(BigInt, x)
end

function answer()

    function predicate(m, v)
        k = m * v
        all(x -> x == k[1], k)
    end

    m = [
        [1 1 1 0 0 0 0 0 0 0]
        [0 1 0 1 1 0 0 0 0 0]
        [0 0 0 1 0 1 1 0 0 0]
        [0 0 0 0 0 1 0 1 1 0]
        [1 0 0 0 0 0 0 1 0 1]
    ]

    solutions =
        Iterators.filter(x -> predicate(m, x), permutations(1:10)) .|> x -> to_int(m, x)
    maximum(n for n in solutions if ndigits(n) == 16)
end

answer() |> print

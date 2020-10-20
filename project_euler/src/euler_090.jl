using Combinatorics

function all_squares(dices)
    pred(n,m) = (a,b)->(n in a && m in b) || (n in b && m in a)

    squares = [(0,1), (0,4), (0,9), (1,6), (2,5), (3,6), (4,9), (8,1)]
    predicates = (x->pred(x...)).(squares)

    all(x->x(dices...),predicates)
end

function add_six_nine(dice)
    (6 in dice || 9 in dice) ? Set(union([6,9],dice)) : Set(dice)
end

function answer()
    dices = combinations(0:9,6) |> collect .|> add_six_nine
    (all_squares(d) for d in combinations(dices,2)) |> sum
end

answer() |> print

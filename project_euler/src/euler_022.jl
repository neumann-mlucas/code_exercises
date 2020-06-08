data = open("dat/euler_022.txt") do file
    readline(file)
end
data = split(data, ",") |> sort .|> collect .|> x -> filter(y -> y != '"', x)

score(s) = mapreduce(x -> Int(x) - Int('A') + 1, +, s)
score_idx(n, s) = n * score(s)

function answer(data)
    mapreduce(x -> score_idx(x...), +, enumerate(data))
end

answer(data) |> print

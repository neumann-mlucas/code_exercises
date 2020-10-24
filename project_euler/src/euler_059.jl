using Base.Iterators

data = open("dat/euler_059.txt") do file
    readline(file)
end
data = map(x -> parse(Int, x), split(data, ","))

decode_triade(s, k) = s .⊻ Int.(k) .|> Char |> join
decode(s, k) = map(x -> decode_triade(x, k), partition(s, 3)) |> join
predicate(msg) = occursin(" the ", msg)

function answer(data)
    keys = product('a':'z', 'a':'z', 'a':'z')
    msg = Iterators.filter(predicate, (decode(data, k) for k in keys)) |> first
    collect(msg) .|> Int |> sum
end

answer(data) |> print

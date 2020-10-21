data = open("dat/euler_099.txt") do file
    readlines(file)
end
data = map(x -> parse.(Int, x), split.(data, ","))

function answer(data)
    fn(b,p) = p * log(b)
    (x->fn(x...)).(data) |> argmax
end

answer(data) |> print

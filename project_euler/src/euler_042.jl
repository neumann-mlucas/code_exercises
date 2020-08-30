data = open("dat/euler_042.txt") do file
    readline(file)
end

char2int(c) = (c != '"') ? Int(c) - 64 : 0
is_triangular(n) = isinteger(sqrt(8 * n + 1))

data = split(data, ",") .|> x -> mapreduce(char2int, +, collect(x))

function answer(data)
    filter(is_triangular, data) |> length
end

answer(data) |> print

data = open("dat/euler_018.txt") do file
    readlines(file)
end
data = map(x->map(y->parse(Int64,y),split(x," ")),data)

N = length(data)
permutations = map(x->string(x, base=2, pad=N), 0:2^N-1) .|> x->map(y->parse(Int64,y),collect(x)) |> cumsum

let max_path = 0
    for p in permutations
        temp = sum(data[i][j+1] for (i,j) in zip(2:N,p))
        max_path = max(max_path, temp)
    end
    println(max_path + data[1][1])
end

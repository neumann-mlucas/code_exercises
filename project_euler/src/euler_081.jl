data = open("dat/euler_081.txt") do file
    readlines(file)
end
data = map(x -> parse.(Int, x), split.(data, ",")) |> x -> hcat(x...)

function pad_data(data)
    r = CartesianIndex((1, 1))
    s = first(size(data)) + 2
    map(i -> (1 in i.I || s in i.I) ? Inf : data[i-r], CartesianIndices((1:s, 1:s)))
end

function answer(data)

    D = pad_data(data)
    G = fill(Inf, size(D))

    cost(idx) = G[idx]

    down = CartesianIndex((1, 0))
    left = CartesianIndex((0, 1))

    Q = [CartesianIndex((2, 2))]
    G[2, 2] = D[2, 2]

    while !isempty(Q)
        index = popfirst!(Q)
        if (index == CartesianIndex((81, 81)))
            return Int(G[index])
        end

        ni = (x -> index + x).((down, left))
        ng = (i -> G[index] + D[i]).(ni)
        for (id, g) in zip(ni, ng)
            (g > G[id]) ? continue : push!(Q, id)
            G[id] = g
        end
        sort!(Q, by = i -> cost(i))
    end
end

answer(data) |> print

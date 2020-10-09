data = open("dat/euler_082.txt") do file
    readlines(file)
end
data = map(x -> parse.(Int, x), split.(data, ",")) |> x -> hcat(x...)

function pad_data(data)
    r = CartesianIndex((1, 1))
    s = first(size(data)) + 2
    map(i -> (1 in i.I || s in i.I) ? Inf : data[i-r], CartesianIndices((1:s, 1:s)))
end

function dijkstra(data, start)

    D = pad_data(data)
    G = fill(Inf, size(D))

    left = CartesianIndex((1, 0))
    down = CartesianIndex((0, 1))
    up = CartesianIndex((0, -1))

    Q = [start]
    G[start] = D[start]

    while !isempty(Q)
        index = popfirst!(Q)
        if (first(index.I) == 81)
            return Int(G[index])
        end

        ni = (x -> index + x).((left, down, up))
        ng = (i -> G[index] + D[i]).(ni)
        for (id, g) in zip(ni, ng)
            (g > G[id]) ? continue : push!(Q, id)
            G[id] = g
        end
        sort!(Q, by = i -> G[i])
    end
end

function answer(data)
    map(i -> dijkstra(data, i), CartesianIndices((2, 2:81))) |> minimum
end

answer(data) |> print

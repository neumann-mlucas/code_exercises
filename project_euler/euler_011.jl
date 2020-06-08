data = open("dat/euler_011.txt") do file
    readlines(file)
end
data = map(split,data)

M = zeros(Int64,20,20)
for i in 1:20
    for j in 1:20
        M[i,j] = parse(Int64,data[i][j])
    end
end

idxs = Base.Iterators.product(1:20,1:20) |> collect |> vec
out_of_bounds = x->all(map(y-> 0<y[1]<=20 && 0<y[2]<=20,x))

path_a = (x,y)->(map(z->CartesianIndex(x,y+z),0:3))
path_b = (x,y)->(map(z->CartesianIndex(x+z,y),0:3))
path_c = (x,y)->(map(z->CartesianIndex(x+z,y+z),0:3))
path_d = (x,y)->(map(z->CartesianIndex(x-z,y+z),0:3))

function answer(matrix)
    m = 0
    for path in (path_a,path_b,path_c,path_d)
        idx = filter(out_of_bounds,map(x->path(x...),idxs))
        m = max(m,maximum(map(x->reduce(*,matrix[x]),idx)))
    end
    return m
end

answer(M) |> print

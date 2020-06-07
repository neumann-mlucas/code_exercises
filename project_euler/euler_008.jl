data = open("dat/euler_008.jl") do file
    readline(file)
end
data = parse(BigInt, data) |> digits

F(x) = reduce(*,getindex(data,x:x+12))
map(F,1:length(data)-13) |> maximum |> println


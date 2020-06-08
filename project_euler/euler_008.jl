data = open("dat/euler_008.jl") do file
    readline(file)
end
data = parse(BigInt, data) |> digits

prod_of_13(x) = reduce(*,getindex(data,x:x+12))
function answer(data)
    map(prod_of_13,1:length(data)-13) |> maximum
end

answer(data) |> print


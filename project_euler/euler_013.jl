data = open("dat/euler_013.txt") do file
    readlines(file)
end

map(x->parse(BigInt,x),data) |> sum |> digits |> reverse |> x->getindex(x,1:10) |> x->foreach(print,x)

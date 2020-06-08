data = open("dat/euler_013.txt") do file
    readlines(file)
end

array_to_int(x) = map((i,j)->i*10^j,reverse(x),0:length(x)-1) |> sum

function answer(n)
    map(x->parse(BigInt,x),data) |> sum |> digits |> reverse |> x->getindex(x,1:10) |> array_to_int
end

answer(data) |> print

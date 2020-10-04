data = open("dat/euler_067.txt") do file
    readlines(file)
end
data = map(x -> map(y -> parse(Int64, y), split(x, " ")), data) |> reverse

function answer(data)
    dig_sum(n, i) = data[n][i] .+ (data[n-1][i], data[n-1][i+1])
    for n = 2:length(data)
        temp = map(i -> max(dig_sum(n, i)...), 1:length(data[n]))
        data[n] = temp
    end
    last(data) |> only
end

answer(data) |> print

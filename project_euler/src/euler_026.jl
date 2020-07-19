function period(n)
    for i = 2:(n-1)
        if BigInt(10)^BigInt(i) % BigInt(n) == 1
            return i
        end
    end
    return 0
end


function answer(lim)
    map(period, 1:lim) |> argmax
end

answer(1000) |> print

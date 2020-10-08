function answer(target)
    nums = collect(1:target-1)
    ways = vcat([1], zeros(Int, target))
    for n in nums
        for i = n+1:length(ways)
            ways[i] += ways[i-n]
        end
    end
    last(ways)
end

answer(100) |> print

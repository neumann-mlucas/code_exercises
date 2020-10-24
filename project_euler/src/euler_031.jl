function recursive(target)
    pennies = (1, 2, 5, 10, 20, 50, 100, 200)
    count = 0

    function helper(index, value)
        p = pennies[index]

        if index == 1
            (value % p == 0) ? count += 1 : return
            return
        end

        while value >= 0
            helper(index - 1, value)
            value -= p
        end
    end

    helper(length(pennies), target)
    return count
end

function answer(target)
    pennies = (1, 2, 5, 10, 20, 50, 100, 200)
    ways = vcat([1], zeros(target))
    for p in pennies
        for i = p+1:target+1
            ways[i] += ways[i-p]
        end
    end
    last(ways)
end

recursive(200) |> print

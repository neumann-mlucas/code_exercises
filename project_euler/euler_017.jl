unit = ["one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"]
decimal = ["dummy" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"]

function int_to_word(n)
    if n == 1000
        result = "onethousand"
    elseif n >= 100
        q, r = divrem(n, 100)
        tail = r > 0 ? "and" * int_to_word(r) : ""
        return unit[q] * "hundred" * tail
    elseif n >= 20
        q, r = divrem(n,10)
        tail = r > 0 ? int_to_word(r) : ""
        return decimal[q] * tail
    elseif n > 0
        return unit[n]
    end
end

reduce(*, map(int_to_word,1:1000)) |> length |> println


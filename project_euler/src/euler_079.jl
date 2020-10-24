using Combinatorics
using Base.Iterators

data = open("dat/euler_079.txt") do file
    readlines(file)
end

function answer(data)

    function is_valid_password(pass)
        is_valid_response(r) = any(c -> pass[c] == r, three_digits)
        all(is_valid_response, data)
    end

    three_digits = combinations(1:8, 3) |> collect
    passwords = permutations("01236789") .|> join
    filter(is_valid_password, passwords) |> first
end

answer(data) |> print

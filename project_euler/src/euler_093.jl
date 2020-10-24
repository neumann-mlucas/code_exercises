using Combinatorics
using Base.Iterators

function apply(numbers, functions)
    f1, f2, f3 = functions
    a, b, c, d = numbers

    o1 = f1(a, b) |> x -> f2(x, c) |> x -> f3(x, d)
    o2 = f1(a, b) |> x -> f2(x, c) |> x -> f3(d, x)
    o3 = f1(a, b) |> x -> f2(c, x) |> x -> f3(x, d)
    o4 = f1(a, b) |> x -> f2(c, x) |> x -> f3(d, x)
    max(o1, o2, o3, o4)
end

function unique_solutions(numbers)
    ops = [+, -, *, /]
    p_ops = product(ops, ops, ops) |> collect
    function helper(perm)
        (apply(perm, f) for f in p_ops) |> l -> (Int(n) for n in l if isinteger(n) && n > 0)
    end
    (helper(p) for p in permutations(numbers)) |> flatten |> unique |> sort
end

function sequnece_length(numbers)
    check = numbers .- collect(1:length(numbers))
    takewhile(x -> x == 0, check) |> collect |> length
end

function answer()
    digits_combinations = combinations(1:9, 4)
    helper(x) = (sequnece_length(unique_solutions(x)), x)
    (helper(c) for c in digits_combinations) |> maximum |> last |> x -> join(string.(x))
end

answer() |> print

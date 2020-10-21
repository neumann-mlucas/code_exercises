using Combinatorics
import Base.Iterators: flatten, product, takewhile

function apply(numbers, functions)
    f1, f2, f3 = functions
    a, b, c, d = numbers
    f1(a,b) |> x->f2(x,c) |> x->f3(x,d)
end

function unique_solutions(numbers)
    ops = [+,-,*,/]
    p_ops = product(ops,ops,ops) |> collect
    function helper(perm)
        (apply(perm, f) for f in p_ops) |>
        l->(Int(abs(n)) for n in l if isinteger(n) && n != 0)
    end
    (helper(p) for p in permutations(numbers)) |> flatten |> unique |> sort
end

function sequnece_length(numbers)
    check = numbers .- collect(1:length(numbers))
    takewhile(x->x==0, check) |>
    collect |> length
end

function answer()
    digits_combinations = combinations(1:9,4)
    helper(x) = (sequnece_length(unique_solutions(x)), x)
    (helper(c) for c  in digits_combinations) |> maximum |> last |>
    x->join(string.(x))
end

answer() |> print

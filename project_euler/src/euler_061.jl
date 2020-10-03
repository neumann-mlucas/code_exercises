import Base.Iterators: first, filter

T(n::Integer) = (1, (n * (n + 1)) ÷ 2)
S(n::Integer) = (2, (n * n))
P(n::Integer) = (3, (n * (3 * n - 1)) ÷ 2)
X(n::Integer) = (4, (n * (2 * n - 1)))
H(n::Integer) = (5, (n * (5 * n - 3)) ÷ 2)
O(n::Integer) = (6, (n * (3 * n - 2)))

fn(f) = (f(n) for n in 1:500 if ndigits(f(n)[2]) == 4) |> collect

function gen_dict(numbers)
    suffixes = unique(n % 100 for (_, n) in numbers)
    Dict(s => collect((p, n) for (p, n) in numbers if s == n ÷ 100) for s in suffixes)
end

function answer()

    function get_next(list)
        ends_cycle(l) = first(l)[2] ÷ 100 == last(l)[2] % 100
        no_repeat_no_same_poly(x) = !(x in last.(list)) && !(x[1] in first.(list))

        if length(list) == 6 && ends_cycle(list)
            sum(last.(list)) |> print
            return
        end

        _, num = last(list)
        next = filter(no_repeat_no_same_poly, d[num%100])

        if isempty(next)
            return
        end

        for n in next
            get_next(push!(list[:], n))
        end
    end

    t = fn(T)
    s = fn(S)
    p = fn(P)
    x = fn(X)
    h = fn(H)
    o = fn(O)

    d = gen_dict(vcat(t, s, p, x, h, o))
    map(x -> get_next([x]), o)
end

answer()

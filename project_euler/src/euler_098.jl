using Combinatorics
using Base.Iterators

data = open("dat/euler_098.txt") do file
    readline(file)
end
data = replace(data, "\"" => "") |> s -> split(s, ",")

function gen_anagrams(strings)
    anagram_dict = Dict()
    for str in filter(x -> length(x) > 4, strings)
        sorted_str = collect(str) |> sort |> join
        (haskey(anagram_dict, sorted_str)) ? push!(anagram_dict[sorted_str], str) :
        anagram_dict[sorted_str] = [str]
    end
    [(k, v) for (k, v) in anagram_dict if !isempty(v) && length(v) > 1]
end

function find_sq_anagrams(anagram)
    _, (a, b) = anagram

    perm_to_int(p) = string.(p) |> join |> x -> parse(Int, x)
    is_sq(p) = perm_to_int(p) |> sqrt |> isinteger

    trans_str(s, t) = [t[c] for c in collect(s)]
    trans_is_sq(s, t) = trans_str(s, t) |> is_sq
    trans_to_int(s, t) = trans_str(s, t) |> perm_to_int

    function find_valid_translations(str)
        permutations(0:9, length(str)) |>
        ps ->
            (p for p in ps if is_sq(p) && first(p) != 0) |>
            ps -> (Dict((c, n) for (c, n) in zip(str, p)) for p in ps)
    end
    translations = find_valid_translations(a) |> collect

    helper(t) = trans_to_int(a, t), trans_to_int(b, t)
    (helper(t) for t in translations if trans_is_sq(b, t) && t[b[1]] != 0) |> flatten
end

function answer(data)
    anagrams = gen_anagrams(data)
    find_sq_anagrams.(anagrams) |> flatten |> maximum
end

answer(data) .|> print

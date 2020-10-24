data = open("dat/euler_089.txt") do file
    readlines(file)
end

roman = Dict((
    (' ', 0),
    ('I', 1),
    ('V', 5),
    ('X', 10),
    ('L', 50),
    ('C', 100),
    ('D', 500),
    ('M', 1000),
))

function roman_to_int(s)
    global roman
    pad_s = collect(s * ' ')
    pairwise = zip(pad_s, pad_s[2:end])

    fn(a, b) = (roman[a] >= roman[b]) ? roman[a] : -roman[a]
    sum(x -> fn(x...), pairwise)
end

function int_to_roman(n)
    t = ("M", "MM", "MMM", "MMMM", "", "", "", "", "", "")
    h = ("C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM", "")
    d = ("X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC", "")
    u = ("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "")

    pad_n = ((d != '0') ? parse(Int, d) : 10 for d in collect(lpad(n, 4, "0")))
    fn(w, x, y, z) = t[w] * h[x] * d[y] * u[z]

    fn(pad_n...)
end

function answer(data)
    orinal = data |> join |> length
    int_to_roman.(roman_to_int.(data)) |> join |> length |> x -> orinal - x
end

answer(data) |> print

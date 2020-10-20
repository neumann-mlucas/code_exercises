import Base.Iterators: filter

struct state
    pos::Int
    double::Int
    card::Int
    chess::Int
end

function move(st, roll)
    double = (roll[1] == roll[2]) ? st.double + 1 : 0
    # pos, ca, ch = (st.pos + sum(roll)) % 40 |> p->board_rules(p, st)
    pos = (st.pos + sum(roll)) % 40
    pos, ca, ch = board_rules(pos, st)
    (double > 2) ? state(10, 0, st.card, st.chess) : state(pos, double, ca, ch)
end

function board_rules(pos, st)

    if pos in (7, 22, 36)
        p, ca, ch = cards(pos, st)
    elseif pos in (2, 17, 33)
        p, ca, ch = chess(pos, st)
    elseif pos == 30
        p, ca, ch = 10, st.card, st.chess
    else
        p, ca, ch = pos, st.card, st.chess
    end

    (p, ca, ch)
end

function chess(pos, st)
    id = (st.chess + 1) % 16
    pos = (id < 2) ? (0, 10)[id+1] : pos
    (pos, st.card, id)
end

function cards(pos, st)
    m = [0, 10, 11, 24, 39, 5]
    d = Dict([(7, 15), (22, 25), (36, 5)])
    id = (st.card + 1) % 16

    if (id < 6)
        pos = m[id+1]
    elseif (id == 6 || id == 7)
        pos = get(d, pos, pos)
    elseif (id == 8)
        pos = (pos == 22) ? 28 : 12
    elseif (id == 9)
        pos -= 3
    end

    (pos, id, st.chess)
end

function hist(pos)
    d = Dict()
    for p in pos
        d[p] = get(d, p, 0) + 1
    end
    [(v, k) for (k, v) in d]
end

function answer(samples)
    dice = collect(1:4)
    rolls = (rand(dice, 2) for i in 1:samples)
    accumulate(move, rolls, init = state(0, 0, 0, 0)) .|>
    (p -> p.pos) |>
    hist |>
    sort |>
    reverse .|>
    last |>
    (x -> x[1:3]) .|>
    string |>
    join
end


answer(5_000_000) |> print

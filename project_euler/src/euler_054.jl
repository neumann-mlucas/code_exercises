data = open("dat/euler_054.txt") do file
    readlines(file)
end

function answer(data)
    hands = map(x -> f_hand(f_card.(split(x, ' '))), data)
    (get_score(l) > get_score(r) for (l, r) in hands) |> sum
end

function get_score(hand)

    if is_royalflush(hand)
        score = 10
    elseif is_flush(hand) && is_straigh(hand)
        score = 9
    elseif is_4kind(hand)
        score = 8
    elseif is_fullhouse(hand)
        score = 7
    elseif is_flush(hand)
        score = 6
    elseif is_straigh(hand)
        score = 5
    elseif is_3kind(hand)
        score = 4
    elseif is_2pair(hand)
        score = 3
    elseif is_pair(hand)
        score = 2
    else
        score = 1
    end

    rank =
        ((c, n) for (c, n) in zip(hist(hand), first.(hand))) |>
        unique |>
        x -> sort(x, rev = true)
    (score, last.(rank))
end

d = Dict(c => n for (n, c) in enumerate("123456789TJQKA"))
f_card(card) = d[card[1]], card[2]
f_hand(hand) = sort(hand[1:5]), sort(hand[6:10])

is_royalflush(h) = is_flush(h) && first.(h) == [10, 11, 12, 13, 14]
is_flush(h) = length(unique(last.(h))) == 1
is_straigh(h) =
    first.(h) in ([v, v + 1, v + 2, v + 3, v + 4] for v = 1:10) ||
    first.(h) == [2, 3, 4, 5, 14]
is_4kind(h) = any(x -> x == 4, hist(h))
is_fullhouse(h) = sort(hist(h)) == [2, 2, 3, 3, 3]
is_3kind(h) = any(x -> x == 3, hist(h))
is_2pair(h) = sort(hist(h)) == [1, 2, 2, 2, 2]
is_pair(h) = any(x -> x == 2, hist(h))

hist(h) = (count(i -> i == c, first.(h)) for c in first.(h)) |> collect

answer(data) |> print

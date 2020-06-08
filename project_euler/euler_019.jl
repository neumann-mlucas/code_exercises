using Dates

is_sunday(x) =  Dates.dayname(x) == "Sunday"

function answer(y_start, y_end)
    dates = Date(y_start):Month(1):Date(y_end)
    filter(is_sunday, dates) |> length
end

answer(1901,2001) |> print

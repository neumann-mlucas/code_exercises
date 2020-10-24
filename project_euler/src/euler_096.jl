using Combinatorics
using Base.Iterators

data = open("dat/euler_096.txt") do file
    readlines(file)
end
process_grid(start) = map(x -> parse.(Int, x), split.(data[start+1:start+9], "")) |> x -> hcat(x...) |> transpose
data = map(process_grid,1:10:500)

function find_next(grid)
    valid = (pos for pos in CartesianIndices(grid) if grid[pos] == 0)
    (isempty(valid)) ? -1 : first(valid)
end

function get_set(grid, pos)
    fn(i) = (i > 3) ? (i > 6) ? (7:9) : (4:6) : (1:3)
    i, j = pos.I
    line, colomn = grid[i,:], grid[:,j]
    square = grid[fn(i),fn(j)]
    union(line, colomn, square)
end

is_valid(grid,pos,val) = (val in get_set(grid,pos)) ? false : true

function solve(grid)
    pos = find_next(grid)
    if pos == -1
        return true
    end
    for val in (v for v in 1:9 if is_valid(grid,pos,v))
        grid[pos] = val
        (solve(grid)) ? (return true) : grid[pos] = 0
    end
    return false
end

function answer(data)
    foreach(sudoku->solve(sudoku), data)
    fn(m) = m[1,1:3] .|> string |> join |> s->parse(Int,s)
    fn.(data) |> sum
end

answer(data) |> print

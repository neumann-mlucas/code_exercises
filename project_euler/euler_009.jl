get_pythagorean(m,n) = m^2-n^2, 2*m*n, m^2+n^2
pythagoreans = [get_pythagorean(m,n) for m in 1:100 for n in 1:m]
        filter(x->sum(x) == 1000, pythagoreans) .|> x->reduce(*,x) |> println



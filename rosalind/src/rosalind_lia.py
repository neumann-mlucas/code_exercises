from functools import reduce


def fact(n):
    if n < 2:
        return 1
    else:
        return reduce(lambda x, y: x * y, range(1, n + 1))


def binomial(n, r):
    return fact(n) / (fact(r) * fact(n - r))


def prob(n, k):
    return binomial(2 ** k, n) * 0.25 ** n * 0.75 ** (2 ** k - n)


def iter_generations(k, N):
    p = 1 - sum([prob(n, k) for n in range(N)])
    return f"{p:.3f}"


DATA_FILE = "dat/rosalind_lia.txt"

SAMPLE_DATA = "2 1"
SAMPLE_OUTPUT = "0.684"

t_matrix = [[0.5, 0.0, 0.25], [0.0, 0.5, 0.25], [0.5, 0.5, 0.5]]

# Read data
with open(DATA_FILE, "r") as f:
    k, n = f.readline().strip().split(" ")
    k, n = int(k), int(n)


# Assert sample
SAMPLE_DATA = map(int, SAMPLE_DATA.split(" "))
assert iter_generations(*SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(iter_generations(k, n))

from functools import lru_cache


@lru_cache(maxsize=None)
def fib(n, k):
    if n < 2:
        return n
    return fib(n - 1, k) + k * fib(n - 2, k)


DATA_FILE = "dat/rosalind_fib.txt"

SAMPLE_DATA = "5 3"
SAMPLE_OUTPUT = "19"

# Read data
with open(DATA_FILE, "r") as f:
    data = f.readline().strip()

# Assert sample
n, k = list(map(int, SAMPLE_DATA.split(" ")))
assert str(fib(n, k)) == SAMPLE_OUTPUT

# Produce output
n, k = list(map(int, data.split(" ")))
print(fib(n, k))

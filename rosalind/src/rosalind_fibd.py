from functools import lru_cache


@lru_cache(maxsize=None)
def fibd(n, m):
    if n < 2:
        return n
    elif n < m + 1:
        return fibd(n - 1, m) + fibd(n - 2, m)
    elif n == m + 1:
        return fibd(n - 1, m) + fibd(n - 2, m) - 1
    else:
        return fibd(n - 1, m) + fibd(n - 2, m) - fibd(n - m - 1, m)


DATA_FILE = "dat/rosalind_fibd.txt"

SAMPLE_DATA = "6 3"
SAMPLE_OUTPUT = "4"

if __name__ == "__main__":
    # Assert sample
    n, m = map(int, SAMPLE_DATA.split(" "))
    assert str(fibd(n, m)) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    n, m = map(int, data.split(" "))
    print(fibd(n, m))

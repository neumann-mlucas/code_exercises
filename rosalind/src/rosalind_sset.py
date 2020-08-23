from math import factorial


def sset(data):
    n = int(data)
    return str(int((2 ** n) % 1_000_000))


def binomial(n, k):
    return factorial(n) / (factorial(n - k) * factorial(k))


DATA_FILE = "dat/rosalind_sset.txt"

SAMPLE_DATA = "3"
SAMPLE_OUTPUT = "8"

if __name__ == "__main__":
    # Assert sample
    assert sset(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(sset(data))

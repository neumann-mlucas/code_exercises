from math import factorial


def aspc(data):
    n, m = [int(i) for i in data.split(" ")]
    return str(sum(binomial(n, k) for k in range(m, n + 1)) % 1_000_000)


def binomial(n, k):
    return factorial(n) // (factorial(n - k) * factorial(k))


DATA_FILE = "dat/rosalind_aspc.txt"

SAMPLE_DATA = "6 3"
SAMPLE_OUTPUT = "42"

if __name__ == "__main__":
    # Assert sample
    assert aspc(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(aspc(data))

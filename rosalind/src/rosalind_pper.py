from math import factorial


def pper(data):
    m, n = map(int, data.split(" "))
    pper = (factorial(m) / factorial(m - n)) % 1_000_000
    return str(int(pper))


DATA_FILE = "dat/rosalind_pper.txt"

SAMPLE_DATA = "21 7"
SAMPLE_OUTPUT = "51200"

if __name__ == "__main__":
    # Assert sample
    assert pper(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(pper(data))

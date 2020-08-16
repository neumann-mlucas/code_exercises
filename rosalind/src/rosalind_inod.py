def inod(n):
    return str(int(n) - 2)


DATA_FILE = "dat/rosalind_inod.txt"

SAMPLE_DATA = "4"
SAMPLE_OUTPUT = "2"

if __name__ == "__main__":
    # Assert sample
    assert inod(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(inod(data))

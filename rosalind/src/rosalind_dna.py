from collections import Counter


def dna(seq):
    count = Counter(seq).items()
    numbers = map(lambda x: str(x[1]), sorted(count))
    return " ".join(numbers)


DATA_FILE = "dat/rosalind_dna.txt"

SAMPLE_DATA = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
SAMPLE_OUTPUT = "20 12 17 21"

if __name__ == "__main__":
    # Assert sample
    assert dna(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(dna(data))

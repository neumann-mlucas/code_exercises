from collections import Counter


def count_nucleotides(seq):
    count = Counter(seq).items()
    numbers = map(lambda x: str(x[1]), sorted(count))
    return " ".join(numbers)


DATA_FILE = "dat/rosalind_dna.txt"

SAMPLE_DATA = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
SAMPLE_OUTPUT = "20 12 17 21"

# Read data
with open(DATA_FILE, "r") as f:
    seq = f.readline().strip()

# Assert sample
assert count_nucleotides(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(count_nucleotides(seq))

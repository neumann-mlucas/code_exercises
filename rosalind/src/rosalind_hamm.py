def hamm(seqs):
    distance = sum(0 if a == b else 1 for (a, b) in zip(*seqs))
    return str(distance)


DATA_FILE = "dat/rosalind_hamm.txt"

SAMPLE_DATA = """GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT"""
SAMPLE_OUTPUT = "7"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert hamm(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(hamm(data))

def hamm_distance(seqs):
    distance = sum(0 if a == b else 1 for (a, b) in zip(*seqs))
    return str(distance)


DATA_FILE = "dat/rosalind_hamm.txt"

SAMPLE_DATA = """GAGCCTACTAACGGGAT
CATCGTAATGACGGCCT"""
SAMPLE_OUTPUT = "7"

translate_dict = {ord("T"): ord("U")}

# Read data
with open(DATA_FILE, "r") as f:
    seqs = [l.strip() for l in f.readlines()]

# Assert sample
SAMPLE_DATA = SAMPLE_DATA.split()
assert hamm_distance(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(hamm_distance(seqs))

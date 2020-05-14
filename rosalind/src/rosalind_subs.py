def find_locations(seq, sub):
    locations = (i for i in range(len(seq)) if seq[i : i + len(sub)] == sub)
    # Off-by-one error and convert to str
    locations = map(lambda x: str(x + 1), locations)
    return " ".join(locations)


DATA_FILE = "dat/rosalind_subs.txt"

SAMPLE_DATA = """GATATATGCATATACTT
ATAT"""
SAMPLE_OUTPUT = "2 4 10"


# Read data
with open(DATA_FILE, "r") as f:
    seqs = [l.strip() for l in f.readlines()]

# Assert sample
SAMPLE_DATA = SAMPLE_DATA.split()
assert find_locations(*SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(find_locations(*seqs))

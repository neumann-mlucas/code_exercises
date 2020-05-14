def to_rna(seq):
    return seq.translate(translate_dict)


DATA_FILE = "dat/rosalind_rna.txt"

SAMPLE_DATA = "GATGGAACTTGACTACGTAAATT"
SAMPLE_OUTPUT = "GAUGGAACUUGACUACGUAAAUU"

translate_dict = {ord("T"): ord("U")}

# Read data
with open(DATA_FILE, "r") as f:
    seq = f.readline().strip()

# Assert sample
assert to_rna(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(to_rna(seq))

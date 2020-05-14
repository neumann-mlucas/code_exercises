def reverse_complement(seq):
    # complement
    complement = seq.translate(translate_dict)
    # reverse
    return complement[::-1]


DATA_FILE = "dat/rosalind_rna.txt"

SAMPLE_DATA = "AAAACCCGGT"
SAMPLE_OUTPUT = "ACCGGGTTTT"

translate_dict = {
    ord("A"): ord("T"),
    ord("C"): ord("G"),
    ord("G"): ord("C"),
    ord("T"): ord("A"),
}
# Read data
with open(DATA_FILE, "r") as f:
    seq = f.readline().strip()

# Assert sample
assert reverse_complement(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(reverse_complement(seq))

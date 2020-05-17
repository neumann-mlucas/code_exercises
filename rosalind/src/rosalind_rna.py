def rna(seq):
    return seq.translate(rna_map)


DATA_FILE = "dat/rosalind_rna.txt"

SAMPLE_DATA = "GATGGAACTTGACTACGTAAATT"
SAMPLE_OUTPUT = "GAUGGAACUUGACUACGUAAAUU"

rna_map = {ord("T"): ord("U")}

if __name__ == "__main__":
    # Assert sample
    assert rna(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        seq = f.readline().strip()
    # Produce output
    print(rna(seq))

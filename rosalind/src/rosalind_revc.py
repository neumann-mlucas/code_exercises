def revc(seq):
    complement = seq.translate(revc_mapping)
    return complement[::-1]


DATA_FILE = "dat/rosalind_rna.txt"

SAMPLE_DATA = "AAAACCCGGT"
SAMPLE_OUTPUT = "ACCGGGTTTT"

revc_mapping = {
    ord("A"): ord("T"),
    ord("C"): ord("G"),
    ord("G"): ord("C"),
    ord("T"): ord("A"),
}

if __name__ == "__main__":
    # Assert sample
    assert revc(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(revc(data))

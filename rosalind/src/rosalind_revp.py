def format_revp(func):
    def wrapper(*args, **kargs):
        output = func(*args, **kargs)
        return "\n".join(f"{s[0]} {len(s[1])}" for s in output)

    return wrapper


@format_revp
def revp(seq):
    idxs = (
        (i + 1, seq[i:j]) for i in range(len(seq)) for j in range(i + 4, len(seq) + 1)
    )
    palindromes = list(filter(lambda x: x[1] == revc(x[1]), idxs))
    return palindromes


def revc(seq):
    complement = seq.translate(revc_mapping)
    return complement[::-1]


DATA_FILE = "dat/rosalind_revp.txt"

SAMPLE_DATA = """
>Rosalind_24
TCAATGCATGCGGGTCTATATGCAT"""
SAMPLE_OUTPUT = """
4 6
5 4
6 6
7 4
17 4
18 4
20 6
21 4"""

revc_mapping = {
    ord("A"): ord("T"),
    ord("C"): ord("G"),
    ord("G"): ord("C"),
    ord("T"): ord("A"),
}

if __name__ == "__main__":
    # Assert sample
    _, SAMPLE_DATA = SAMPLE_DATA.split()
    assert revp(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = "".join(l.strip() for l in f.readlines() if not l.startswith(">"))
    # Produce output
    print(revp(data))

import re
import urllib


def mprt(data):

    output = ""

    seqs = (get_seq(s_id) for s_id in data)
    motifs = (find_motif(seq) for seq in seqs)
    for (name, locs) in zip(data, motifs):
        locs = " ".join(str(n) for n in locs)
        if locs:
            output += f"{name}\n{locs}\n"
    return output


def get_seq(uniprot_id):
    addrs = f"http://www.uniprot.org/uniprot/{uniprot_id}.fasta"
    _, *seq = urllib.request.urlopen(addrs, timeout=None).read().split(b"\n")
    return b"".join(seq).decode("utf-8")


def find_motif(seq):
    re_motif = "(?=(N{1}[^P]{1}[ST]{1}[^P]{1}))"
    starts = [m.start() + 1 for m in re.finditer(re_motif, seq)]
    return starts


DATA_FILE = "dat/rosalind_mprt.txt"

SAMPLE_DATA = """
A2Z669
B5ZC00
P07204_TRBM_HUMAN
P20840_SAG1_YEAST"""
SAMPLE_OUTPUT = """
B5ZC00
85 118 142 306 395
P07204_TRBM_HUMAN
47 115 116 382 409
P20840_SAG1_YEAST
79 109 135 248 306 348 364 402 485 501 614"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert mprt(SAMPLE_DATA).rstrip() == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(mprt(data))

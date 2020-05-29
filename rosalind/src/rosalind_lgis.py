from collections import defaultdict


def lgis(data):

    seq = [int(n) for n in data[1].split(" ")]

    increasing = find_longest_sub(seq, lambda x, y: x < y)
    decreasing = find_longest_sub(seq, lambda x, y: x > y)

    f = lambda x: " ".join(map(str, x))
    return f"\n{f(increasing)}\n{f(decreasing)}"


def find_longest_sub(seq, key):

    l_seq = defaultdict(list)

    for i in range(len(seq)):
        for j in range(i):
            if key(seq[j], seq[i]) and len(l_seq[j]) > len(l_seq[i]):
                l_seq[i] = l_seq[j].copy()
        l_seq[i].append(seq[i])

    return max(l_seq.values(), key=lambda x: len(x))


DATA_FILE = "dat/rosalind_lgis.txt"

SAMPLE_DATA = """5
5 1 4 2 3"""
SAMPLE_OUTPUT = """
1 2 3
5 4 2"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split("\n")
    assert lgis(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(lgis(data))

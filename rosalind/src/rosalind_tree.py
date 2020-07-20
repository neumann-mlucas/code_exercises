def tree(data):
    n, *nodes = data
    return str(int(n) - len(nodes) - 1)


DATA_FILE = "dat/rosalind_tree.txt"

SAMPLE_DATA = """
10
1 2
2 8
4 10
5 9
6 10
7 9"""
SAMPLE_OUTPUT = "3"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.strip().split("\n")
    assert tree(SAMPLE_DATA) == SAMPLE_OUTPUT.strip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(tree(data))

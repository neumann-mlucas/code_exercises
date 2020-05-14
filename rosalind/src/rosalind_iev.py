from itertools import permutations, tee


def calc_prob(population):
    dominant_offspring = sum(p * dominant_prob[n] for (n, p) in enumerate(population))
    return str(dominant_offspring)


DATA_FILE = "dat/rosalind_iev.txt"

SAMPLE_DATA = "1 0 0 1 0 1"
SAMPLE_OUTPUT = "3.5"

# AA-AA AA-Aa AA-aa Aa-Aa Aa-aa aa-aa
dominant_prob = (2.0, 2.0, 2.0, 1.5, 1.0, 0.0)

# Read data
with open(DATA_FILE, "r") as f:
    data = f.readline().strip().split(" ")

# Assert sample
SAMPLE_DATA = map(int, SAMPLE_DATA.split(" "))
assert calc_prob(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
data = map(int, data)
print(calc_prob(data))

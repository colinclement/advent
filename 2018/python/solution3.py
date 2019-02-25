"""
solution3.py
"""

import numpy as np

def readfile(fname='../data/input-3.txt'):
    with open(fname, 'r') as fin:
        return [l.strip() for l in fin]

def parseline(line):
    """
    Parse Elf area claim into coordinate ranges:
        #1 @ 509,796: 18x15
        -> [[509, 527], [796, 811]]
    """
    offset, widths = line.split('@')[1].strip().split(': ')
    offset = list(map(int, offset.split(',')))
    widths = list(map(int, widths.split('x')))
    return (slice(offset[1], offset[1]+widths[1]),
            slice(offset[0], offset[0]+widths[0]))

def parse_data(fname='../data/input-3.txt'):
    return [parseline(d) for d in readfile(fname)]

def count_claims(data):
    L = max(map(lambda x: max(x[0].stop, x[1].stop), data))
    claims = np.zeros((L+1, L+1))
    for d in data:
        claims[d] += 1
    return claims

def count_conflicts(claims):
    return np.sum(claims > 1)

def find_free_claim(data, claims):
    for i, d in enumerate(data):
        if np.all(claims[d] == 1):
            return i + 1

DATA = parse_data()
CLAIMS = count_claims(DATA)
print("Overlapping claims = {}".format(count_conflicts(CLAIMS)))
print("Free claim = {}".format(find_free_claim(DATA, CLAIMS)))

"""
Advent of code day 1
"""

def find_endstate(fname):
    total = 0
    with open(fname, 'r') as fin:
        for line in fin:
            total += int(line)
    return total


def find_repeat(fname):
    with open(fname, 'r') as fin:
        data = [int(line) for line in fin]
    total = 0
    seen = set([total])
    while True:
        for d in data:
            total += d
            if total in seen:
                return total
            seen.add(total)

print("First repeat = {}".format(find_repeat("../data/input-1.txt")))

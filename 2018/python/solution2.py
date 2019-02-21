"""
solution-2.py
"""

def two_or_three(string):
    """
    Return whether the string has a character which repeats twice and
    three times
    """
    chars = set(string)
    two, three = False, False
    for c in chars:
        count = string.count(c)
        if count == 2:
            two = True
        elif count == 3:
            three = True
    return two, three

def readfile(filename):
    """ read ID list """
    with open(filename, 'r') as fin:
        return list(map(lambda x: x.strip(), fin.readlines()))

def find_checksum(idlist):
    """ Compute checksum of box IDs """
    twos, threes = 0, 0
    for i in idlist:
        two, three = two_or_three(i)
        twos += two
        threes += three
    return twos * threes

def common_letters(idlist):
    """ Computes shared characters from IDs """
    pos = 0
    for i, id0 in enumerate(idlist):
        for id1 in idlist[i+1:]:
            ndiff = 0
            for idx in range(len(idlist[i])):
                if not id0[idx] == id1[idx]:
                    ndiff += 1
                    pos = idx
                if ndiff > 1:
                    break
            if ndiff == 1:
                return id1[:pos]+id1[pos+1:]


TESTLIST = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee',
            'ababab']

assert find_checksum(TESTLIST) == 12
id_data = readfile("../data/input-2.txt")
print(find_checksum(id_data))
print(common_letters(id_data))

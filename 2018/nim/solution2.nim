#[
#  solution2.nim
]#

import strutils, sequtils, strformat

proc parseFile(fname: string): seq[string] =
  for line in open(fname).lines:
    result.add(line.strip)

type
  TwoThree = tuple[two: bool, three:bool]

proc two_or_three(id: string): TwoThree =
  #[ return tuple of id string such that 
  # (id has letter appearing twice, id has letter appearing thrice
  #]#
  result.two = false
  result.three = false
  var counts: array[26, int]
  for i in 0..<id.len:
    var idx = int(id[i]) - int('a')  #a=0, b=1, c=2, ...
    counts[idx] += 1
  for i in 0..26:
    if counts[i] == 2:
      result.two = true
    elif counts[i] == 3:
      result.three = true

proc checkSum(idlist: seq[string]): int =
  var
    twos: int
    threes: int
  for id in idlist:
    var twothree = two_or_three(id)
    twos += int(twothree.two)
    threes += int(twothree.three)
  result = twos * threes

proc commonLetters(idlist: seq[string]): string =
  var pos = 0
  for i, id in idlist:
    for j in i+1..<idlist.len:
      var ndiff = 0
      for idx in 0..<id.len:
        if not(id[idx] == idlist[j][idx]):
          inc(ndiff)
          pos = idx
        if ndiff > 1:
          break
      if ndiff == 1:
        result = id
        result.delete(pos, pos)

let TEST = @["abcdef", "bababc", "abbcde", "abcccd", "aabcdd",
  "abcdee", "ababab"]

assert checkSum(TEST) == 12

let data = parseFile("../data/input-2.txt")
var answer = checksum(data)
echo "The Checksum is {answer}".fmt
var letters = commonLetters(data)
echo "The shared letters are {letters}".fmt

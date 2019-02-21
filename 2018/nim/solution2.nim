#[
#  solution2.nim
]#

import strutils, sequtils, strformat

proc parse_file(fname: string): seq[string] =
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

proc checksum(idlist: seq[string]): int =
  var
    twos: int
    threes: int
  for id in idlist:
    var twothree = two_or_three(id)
    twos += int(twothree.two)
    threes += int(twothree.three)
  result = twos * threes

let TEST = @["abcdef", "bababc", "abbcde", "abcccd", "aabcdd",
  "abcdee", "ababab"]

assert checksum(TEST) == 12

let data = parse_file("../data/input-2.txt")
var answer = checksum(data)
echo "The Checksum is {answer}".fmt

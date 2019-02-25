#[
#  Day 3
]#

import strutils, strformat, sequtils, sets

var seps: set[char] = {':', ',', 'x'}
seps.incl(Whitespace)

proc parseLine(line: string): seq[int]=
  var tokens = split(line, seps)
  var squares = @[parseInt(tokens[3]),  ## top offset
                  parseInt(tokens[6]),  ## height
                  parseInt(tokens[2]),  ## left offset
                  parseInt(tokens[5])]  ## width
  result.add(squares[0])
  result.add(squares[0] + squares[1])
  result.add(squares[2])
  result.add(squares[2] + squares[3])

proc parseFile(fname: string="../data/input-3.txt"): seq[seq[int]] =
  for line in open(fname).lines:
    result.add(parseLine(line.strip))

proc max(x: seq[seq[int]]): int=
  for y in x:
    result = max(result, max(y))

proc addClaim(claims: var seq[seq[int]], newclaim: seq[int]): int {.discardable.} =
  assert len(newclaim) == 4
  for row in newclaim[0]..<newclaim[1]:
    for col in newclaim[2]..<newclaim[3]:
      claims[row][col] += 1

proc countClaims(data: seq[seq[int]]): seq[seq[int]] =
  let L = max(data)
  result = newSeqWith(L, newSeq[int](L))
  for d in data:
    result.addClaim(d)

proc countConflicts(claims: seq[seq[int]]): int =
  let L = len(claims)
  for i in 0..<L:
    for j in 0..<L:
      if claims[i][j] > 1:
        inc(result)

proc findFreeClaim(data, claims: seq[seq[int]]): int =
  for i, d in data:
    var free = true
    for r in d[0]..<d[1]:
      for c in d[2]..<d[3]:
        if claims[r][c] > 1:
          free = false
    if free:
      return i + 1

let data = parseFile()
var claims = countClaims(data)
var conflicts = countConflicts(claims)
var freeclaim = findFreeClaim(data, claims)
echo fmt("Number conflicting claims = {conflicts}")
echo fmt("Free claim = {freeclaim}")

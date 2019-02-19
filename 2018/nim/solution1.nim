"""
Advent of code day 1
"""
import strutils, sequtils, intsets

proc parse_file(fname: string): seq[int] =
  for line in open(fname).lines:
    result.add(line.parseInt)

func sum[T](x: seq[T]): T =
  for elem in x:
    result += elem

proc find_endstate(fname: string): int =
  return parse_file(fname).sum

proc find_repeat(fname: string): int =
  let input = parse_file(fname)
  var seen = initIntSet()
  seen.incl(result)
  while true:
    for line in input:
      result += line
      if seen.containsOrIncl(result):
        return result

echo find_endstate("../data/input-1.txt")
echo find_repeat("../data/input-1.txt")

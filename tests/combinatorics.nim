# https://forum.nim-lang.org/t/5937
#
#            Nimrod Combinatorics Module
#        (c) Copyright 2014 Reimer Behrends
#
#    See the file "LICENSE", included in this
#    distribution, for details about the copyright.
#

## The combinatorics module contains routines to enumerate permutations,
## choices, or combinations of a sequence or array. These routines are
## implemented as iterators that yield sequences. ``sequtils.toSeq``
## can be used to gather all results in a single sequence.
##
## The implementations assume that the input does not contain duplicates;
## if it contains duplicate entries, these will be treated as distinct
## items.

iterator permutations*[T](s: openarray[T]): seq[T] =
  ## Enumerates all possible permutations of `s`. Example:
  ##
  ## .. code-block:: nimrod
  ##   for p in permutations(@[1,2,3]):
  ##
  ## ...generates this output:
  ##
  ## .. code-block::
  ##   @[1, 2, 3]
  ##   @[2, 1, 3]
  ##   @[1, 3, 2]
  ##   @[2, 3, 1]
  ##   @[3, 2, 1]
  ##   @[3, 1, 2]
  let n = len(s)
  var pos = newSeq[int](n)
  var current = newSeq[T](n)
  for i in 0..n-1:
    pos[i] = i
  while true:
    for i in 0..n-1:
      current[i] = current[pos[i]]
      current[pos[i]] = s[i]
    yield current
    var i = 1
    while i < n:
      pos[i] -= 1
      if pos[i] < 0:
        pos[i] = i
        i += 1
      else:
        break
    if i >= n:
      break

iterator combinations*[T](s: openarray[T], k: int): seq[T] =
  ## Enumerates all combinations of `k` distinct elements
  ## out of `s`. Example:
  ##
  ## .. code-block:: nimrod
  ##   for p in combinations(@[1,2,3], 2):
  ##
  ## ...generates this output:
  ##
  ## .. code-block::
  ##   @[1, 2]
  ##   @[1, 3]
  ##   @[2, 3]
  let n = len(s)
  assert k >= 0 and k <= n
  var pos = newSeq[int](k)
  var current = newSeq[T](k)
  for i in 0..k-1:
    pos[k-i-1] = i
  var done = false
  while not done:
    for i in 0..k-1:
      current[i] = s[pos[k-i-1]]
    yield current
    var i = 0
    while i < k:
      pos[i] += 1
      if pos[i] < n-i:
        for j in 0..i-1:
          pos[j] = pos[i] + i - j
        break
      i += 1
    if i >= k:
      break

iterator multicombinations*[T](s: openarray[T], k: int): seq[T] =
  ## Enumerates all ordered combinations of `k` elements
  ## out of `s` where the elements can be repeated.
  ## Example:
  ##
  ## .. code-block:: nimrod
  ##   for p in multicombinations(@[1,2,3], 2):
  ##
  ## ...generates this output:
  ##
  ## .. code-block::
  ##   @[1, 1]
  ##   @[1, 2]
  ##   @[1, 3]
  ##   @[2, 2]
  ##   @[2, 3]
  ##   @[3, 3]
  let n = len(s)
  assert k >= 0 and k <= n
  var pos = newSeq[int](k)
  var current = newSeq[T](k)
  var done = false
  while not done:
    for i in 0..k-1:
      current[i] = s[pos[k-i-1]]
    yield current
    var i = 0
    while i < k:
      pos[i] += 1
      if pos[i] < n:
        for j in 0..i-1:
          pos[j] = pos[i]
        break
      i += 1
    if i == k:
      break

iterator tuples*[T](s: openarray[T], k: int): seq[T] =
  ## Enumerates all ordered combinations of `k` elements
  ## out of `s` where the elements can be repeated. This is
  ## essentially the Cartesian product of `s` with itself
  ## for `k` factors. Example:
  ##
  ## .. code-block:: nimrod
  ##   for p in tuples(@[1,2], 2):
  ##
  ## ...generates this output:
  ##
  ## .. code-block::
  ##   @[1, 1]
  ##   @[1, 2]
  ##   @[2, 1]
  ##   @[2, 2]
  if k >= 0 and len(s) > 0:
    var pos = newSeq[int](k)
    var current = newSeq[T](k)
    while true:
      for i in 0..k-1:
        current[i] = s[pos[i]]
      yield current
      var i = 0
      while i < k:
        pos[i] += 1
        if pos[i] >= len(s):
          pos[i] = 0
          i += 1
        else:
          break
      if i == k:
        break

when isMainModule:
  import sets, math, sequtils
  template count(s: untyped): untyped =
    block:
      var i = 0
      for x in s: i += 1
      i
  proc mcoeff(a, b: int): int =
    binom(a+b-1, b)

  for x in combinations([1,2,3], 2):
    echo x


  #doAssert count(permutations[int]([])) == 1
  assert toSeq(permutations([1,2,3,4,5])).len == fac(5)
  assert toSeq(permutations([1,2,3,4,5])).len == fac(5)
  assert toSeq(permutations(["a", "b", "c"])).len == fac(3)
  assert toSeq(combinations([1,2,3,4], 1)).len == binom(4, 1)
  assert toSeq(combinations([1,2,3,4], 2)).len == binom(4, 2)
  assert toSeq(combinations([1,2,3,4], 3)).len == binom(4, 3)
  assert toSeq(combinations(["a", "b", "c", "d", "e"], 3)).len == 10
  assert toSeq(multicombinations([1,2,3,4], 1)).len == mcoeff(4, 1)
  assert toSeq(multicombinations([1,2,3,4], 2)).len == mcoeff(4, 2)
  assert toSeq(multicombinations([1,2,3,4], 3)).len == mcoeff(4, 3)
  assert toSeq(tuples([1,2,3,4], 3)).len == 4*4*4
  assert toSeq(tuples([1,2], 10)).len == 1024


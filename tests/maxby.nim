# https://forum.nim-lang.org/t/4763

proc maxIndexBy*[T](s: openArray[T], cmp: proc (x, y: T): int {.closure.}): int =
  ## Returns the index of the maximum value of all elements in s.
  ## Comparison is done by cmp() proc.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxIndexBy(proc (x,y: string): int = cmp(x.len, y.len)) == 1
  if s.len > 0:
    var maxVal = s[0]
    for i in 1 .. s.high:
      if cmp(s[i], maxVal) > 0:
        result = i
        maxVal = s[i]

proc minIndexBy*[T](s: openArray[T], cmp: proc (x, y: T): int {.closure.}): int =
  ## Returns the index of the minimum value of all elements in s.
  ## Comparison is done by cmp() proc.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minIndexBy(proc (x,y: string): int = cmp(x.len, y.len)) == 3
  if s.len > 0:
    var minVal = s[0]
    for i in 1 .. s.high:
      if cmp(s[i], minVal) < 0:
        result = i
        minVal = s[i]

# see system.sortedByIt()
template maxIndexByIt*(seq1, op: untyped): untyped =
  ## Returns the maximum index of all elements in s.
  ## Comparison is done by it expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxIndexByIt(it.len) == 1
  var result = maxIndexBy(seq1, proc(x, y: type(seq1[0])): int =
    var it {.inject.} = x
    let a = op
    it = y
    let b = op
    result = cmp(a, b))
  result

template minIndexByIt*(seq1, op: untyped): untyped =
  ## Returns the minimum index of all elements in s.
  ## Comparison is done by it expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minIndexByIt(it.len) == 3
  var result = minIndexBy(seq1, proc(x, y: type(seq1[0])): int =
    var it {.inject.} = x
    let a = op
    it = y
    let b = op
    result = cmp(a, b))
  result

template maxIndex*(seq1, el, op: untyped): untyped =
  ## Returns the maximum index of all elements in s.
  ## Comparison is done by custom expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxIndex(el, el.len) == 1
  var result = maxIndexBy(seq1, proc(x, y: type(seq1[0])): int =
    var el {.inject.} = x
    let a = op
    el = y
    let b = op
    result = cmp(a, b))
  result

template minIndex*(seq1, el, op: untyped): untyped =
  ## Returns the minimum index of all elements in s.
  ## Comparison is done by custom expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minIndex(el, el.len) == 3
  var result = minIndexBy(seq1, proc(x, y: type(seq1[0])): int =
    var el {.inject.} = x
    let a = op
    el = y
    let b = op
    result = cmp(a, b))
  result

func maxValueBy*[T](s: openArray[T], cmp: proc (x, y: T): int {.closure.}): T =
  ## Returns the maximum value of all elements in s.
  ## Comparison is done by cmp() proc.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == "Nim"
  assert(s.len > 0)
  result = s[0]
  if s.len > 0:
    for i in 1 .. s.high:
      if cmp(s[i], result) > 0:
        result = s[i]

func minValueBy*[T](s: openArray[T], cmp: proc (x, y: T): int {.closure.}): T =
  ## Returns the minimum value of all elements in s.
  ## Comparison is done by cmp() proc.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == "D"
  assert(s.len > 0)
  result = s[0]
  if s.len > 0:
    for i in 1 .. s.high:
      if cmp(s[i], result) < 0:
        result = s[i]

template maxValueByIt*(seq1, op: untyped): untyped =
  ## Returns the maximum value of all elements in s.
  ## Comparison is done by it expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxValueByIt(it.len) == "Nim"
  var result = maxValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var it {.inject.} = x
    let a = op
    it = y
    let b = op
    result = cmp(a, b))
  result

template minValueByIt*(seq1, op: untyped): untyped =
  ## Returns the minimum value of all elements in s.
  ## Comparison is done by it expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minValueByIt(it.len) == "D"
  var result = minValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var it {.inject.} = x
    let a = op
    it = y
    let b = op
    result = cmp(a, b))
  result

template maxValue*(seq1, el, op: untyped): untyped =
  ## Returns the maximum value of all elements in s.
  ## Comparison is done by custom expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].maxValue(el, el.len) == "Nim"
  var result = maxValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var el {.inject.} = x
    let a = op
    el = y
    let b = op
    result = cmp(a, b))
  result

template minValue*(seq1, el, op: untyped): untyped =
  ## Returns the minimum value of all elements in s.
  ## Comparison is done by custom expression
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minValue(el, el.len) == "D"
  var result = minValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var el {.inject.} = x
    let a = op
    el = y
    let b = op
    result = cmp(a, b))
  result

func minMaxValueBy*[T](s: openArray[T], cmp: proc (x, y: T): int {.closure.}): (T, T) =
  ## Returns the minimum and maximum values of all elements in s.
  ## Comparison is done by cmp() proc.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minMaxValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == ("D", "Nim")
  assert(s.len > 0)
  if s.len > 0:
    result[0] = s[0] 
    result[1] = s[0] 
    for i in 1 .. s.high:
      if cmp(result[1], s[i]) < 0:
        result[1] = s[i]
      elif cmp(result[0], s[i]) > 0:
        result[0] = s[i]

template minMaxValueByIt*(seq1, op: untyped): untyped =
  ## Returns the minimum and maximum values of all elements in s.
  ## Comparison is done by it expression.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minMaxValueByIt(it.len) == ("D", "Nim")
  var result = minMaxValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var it {.inject.} = x
    let a = op
    it = y
    let b = op
    result = cmp(a, b))
  result

template minMaxValue*(seq1, el, op: untyped): untyped =
  ## Returns the minimum and maximum values of all elements in s.
  ## Comparison is done by custom expression.
  ##
  ## Example:
  ##
  ## .. code-block:
  ##   assert ["Go", "Nim", "C++", "D"].minMaxValue(el, el.len) == ("D", "Nim")
  var result = minMaxValueBy(seq1, proc(x, y: type(seq1[0])): int =
    var el {.inject.} = x
    let a = op
    el = y
    let b = op
    result = cmp(a, b))
  result

when isMainModule:

  type
    Person = object
      name: string
      age: int

  var people: seq[Person] = @[Person(name: "Eve", age: 11), Person(name: "Sarah", age: 25), Person(name: "Anna", age: 23)]

  var (min, max) = people.minMaxValue(p, p.name)

  echo "Min: ", min.name, ", ", min.age
  echo "Max: ", max.name, ", ", max.age

  var m = people.maxValueByIt(it.name.len)

  echo "Max by length of name: ", m.name

  var h = people.minIndexBy(proc (x,y: Person): int = cmp(x.name.len, y.name.len))

  echo "Min index by length of name: ", h

  assert ["Go", "Nim", "C++", "D"].maxIndexBy(proc (x,y: string): int = cmp(x.len, y.len)) == 1

  assert ["Go", "Nim", "C++", "D"].minIndexBy(proc (x,y: string): int = cmp(x.len, y.len)) == 3

  assert ["Go", "Nim", "C++", "D"].maxIndexByIt(it.len) == 1

  assert ["Go", "Nim", "C++", "D"].minIndexByIt(it.len) == 3

  assert ["Go", "Nim", "C++", "D"].maxIndex(el, el.len) == 1

  assert ["Go", "Nim", "C++", "D"].minIndex(el, el.len) == 3

  assert ["Go", "Nim", "C++", "D"].maxValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == "Nim"

  assert ["Go", "Nim", "C++", "D"].minValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == "D"

  assert ["Go", "Nim", "C++", "D"].maxValueByIt(it.len) == "Nim"

  assert ["Go", "Nim", "C++", "D"].minValueByIt(it.len) == "D"

  assert ["Go", "Nim", "C++", "D"].maxValue(el, el.len) == "Nim"

  assert ["Go", "Nim", "C++", "D"].minValue(el, el.len) == "D"

  assert ["Go", "Nim", "C++", "D"].minMaxValueBy(proc (x,y: string): int = cmp(x.len, y.len)) == ("D", "Nim")

  assert ["Go", "Nim", "C++", "D"].minMaxValueByIt(it.len) == ("D", "Nim")

  assert ["Go", "Nim", "C++", "D"].minMaxValue(el, el.len) == ("D", "Nim")

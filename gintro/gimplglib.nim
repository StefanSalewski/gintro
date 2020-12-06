import macros
from strutils import `%`

macro mAddWatch(ch: IOChannel; pri: cint; cond: IOCondition; p: untyped; arg: typed; ignoreArg: bool): untyped =
  var IdleID {.compileTime, global.}: int
  inc(IdleID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "giofunc_" & $IdleID
  let procNameCdecl = "giofunc_cdecl_" & $IdleID
  #var fixedCond = "{IOCFlag.in}"
  var fixedCond = $(cond.toStrLit)
  #echo getTypeInst(cond)[0].toStrLit
  #echo getTypeInst(cond)[1].toStrLit
  fixedCond.insert($(getTypeInst(cond)[1].toStrLit) & ".", 1)

  var r1s = """

proc $1(self: ptr IOChannel00; cond: IOCondition; userData: pointer): gboolean {.cdecl.} =
  var ch1 {.global.}: glib.IOChannel
  if ch1.isNil:
    new ch1
    GC_ref(ch1) # never call destroy/finalizer on this global variable
    ch1.ignoreFinalizer = true
  ch1.impl = self
  $2(ch1, cond"""

  if not ignoreArg.boolVal:
    if getTypeInst(arg).typeKind == ntyRef:
      r1s.add(", cast[$3](userdata)")
    else:
      r1s.add(", cast[$3](userdata)")
  r1s.add(").gboolean\n")

  r1s = r1s % [$procNameCdecl, $p, ats]

  let r2s =
    if ignoreArg.boolVal:

      """
proc $1(self: IOChannel; pri: cint; cond: IOCondition): cuint {.discardable.} =
    g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, nil, nil)

$1($5, $3, $4)
""" % [$procName, ats, $pri, $cond, $procNameCdecl, $(arg.toStrLit), $(ch.toStrLit)]

    else:

      """
proc $1(self: IOChannel; pri: cint; cond: IOCondition; a: $2): cuint {.discardable.} =
  when (a is ref object):
    GC_ref(a)
    #discard g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](a), nil)
    return g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], a)
    ar[] = a
    GC_ref(ar)
    #discard g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](ar[]), nil)
    return g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](ar[]), nil)
$1($7, $3, $4, $6)
#$1($7, $3, $8.$4, $6)
""" % [$procName, ats, $(pri.toStrLit), fixedCond, $procNameCdecl, $(arg.toStrLit), $(ch.toStrLit), $(getTypeInst(cond).toStrLit)]
  #echo r1s
  #echo r2s
  result = parseStmt(r1s & r2s)

template addWatch*(ch: IOChannel; pri: int; cond: IOCondition; p: untyped; arg: typed): untyped =
  maddWatch(ch, pri.cint, cond, p, arg, false)

template addWatch*(ch: IOChannel; pri: int; cond: IOCondition; p: untyped): untyped =
  maddWatch(ch, pri.cint, cond, p, "", true)



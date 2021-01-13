import macros
from strutils import `%`

# mostly a copy of gimplglib.nim
##########################################################
#proc gst_bus_add_watch_full(self: ptr Bus00; priority: int32; `func`: BusFunc;
#    userData: pointer; notify: DestroyNotify): uint32 {.
#    importc, libprag.}

#guint gst_bus_add_watch (GstBus *bus, GstBusFunc func, gpointer user_data);
#guint gst_bus_add_watch_full (GstBus *bus, gint priority, GstBusFunc func, gpointer user_data, GDestroyNotify notify);

#BusFunc* = proc (bus: ptr Bus00; message: ptr Message00; userData: pointer): gboolean {.cdecl.}

macro mAddWatchFull(bus: gst.Bus; pri: cint; p: untyped; arg: typed; ignoreArg: bool): untyped =
  var IdleID {.compileTime, global.}: int
  inc(IdleID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "gstfunc_" & $IdleID
  let procNameCdecl = "gstfunc_cdecl_" & $IdleID

  var r1s = """

proc $1(self: ptr gst.Bus00; msg: ptr gst.Message00; userData: pointer): gboolean {.cdecl.} =
  var bus1 {.global.}: gst.Bus
  if bus1.isNil:
    new bus1
    GC_ref(bus1) # never call destroy/finalizer on this global variable
    bus1.ignoreFinalizer = true
  bus1.impl = self

  var msg1 {.global.}: gst.Message
  if msg1.isNil:
    new msg1
    GC_ref(msg1) # never call destroy/finalizer on this global variable
    msg1.ignoreFinalizer = true
  msg1.impl = msg

  $2(bus1, msg1"""

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
proc $1(self: gst.Bus; pri: cint): cuint {.discardable.} =
    gst_bus_add_watch_full(cast[ptr gst.Bus00](self.impl), pri, $5, nil, nil)

$1($5, $3, $4)
""" % [$procName, ats, $pri, "cond", $procNameCdecl, $(arg.toStrLit), $(bus.toStrLit)]

    else:

      """
proc $1(self: gst.Bus; pri: cint; a: $2): cuint {.discardable.} =
  when (a is ref object):
    GC_ref(a)
    return gst_bus_add_watch_full(cast[ptr gst.Bus00](self.impl), pri, $5, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], a)
    ar[] = a
    GC_ref(ar)
    return gst_bus_add_watch_full(cast[ptr gst.Bus00](self.impl), pri, $5, cast[pointer](ar[]), nil)
$1($7, $3, $6)
""" % [$procName, ats, $(pri.toStrLit), "fixedCond", $procNameCdecl, $(arg.toStrLit), $(bus.toStrLit)]

  #echo r1s
  #echo r2s
  result = parseStmt(r1s & r2s)

template addWatch*(bus: gst.Bus; pri: int; p: untyped; arg: typed): untyped =
  maddWatchFull(bus, pri.cint, p, arg, false)

template addWatch*(bus: gst.Bus; pri: int; p: untyped): untyped =
  maddWatchFull(bus, pri.cint, p, "", true)

const RecSep = "!" # Record separator for entries in gisup.nim, also defined in gen.nim

# caution: $$ due to string interpolation
let ct4nt = [
  "int32|int",
  "uint32|int",
  "gboolean|toBool",
  "cstring|$$"]

proc ct5nt(s: string): string =
  for i in ct4nt:
    if i.startsWith(s):
      return i[s.len + 1 .. ^1]

proc findSignal(name, obj: NimNode): string =
  let str = ($name).replace("-", "_") & RecSep
  var ipros: seq[string]
  for i in SCA:
    if i.startsWith(str):
      let h1 = i.split(RecSep)[3]
      let h2 = h1.split(": ")[1]
      let h = h2.split({';', ')'})[0]
      if h.contains("|"):
        ipros = h.split(" | ")
      else:
        ipros = @[h]
        assert(ipros[0] == i.split(RecSep, 2)[1])
      for t in ipros:
        var n = obj
        while true:
          if n.kind != nnkBracketExpr: break
          var h = $getType(n)[1].toStrLit
          if h.endsWith(":ObjectType"):
            h.setLen(h.len - 11)
          if h == t:
            return i
          n = getType(n)[1]
          n = getType(n)[1]

var ProcID: int
# from file gisup.nim we have:
# "remove_editable!CellArea!2!(self: CellArea; renderer: CellRenderer; editable: CellEditable | SpinButton | ComboBox | ...
# so for signal remove_editable third parameter of handler proc can be CellEditable OR SpinButton OR ComboBox OR ...
# This is because SpinButton, ComboBox provides the CellEditable interface!
# https://mail.gnome.org/archives/gtk-list/2017-July/msg00018.html
# This interface parameter is in most cases the second parameter of handler proc, but can be the third also.
macro mconnect(widget: gobject.Object; signal: string; p: typed; arg: typed; ignoreArg: bool): untyped =
  #echo p.symbol.getImpl().toStrLit
  #echo p.symbol.getImpl().params.toStrLit
  #echo p.symbol.getImpl().params[2][1].toStrLit

  var # position and actual type of interface provider, if any
    ipos = -1
    ipro: string = nil

  inc(ProcID)
  let wt = getType(widget)
  let at = getTypeInst(arg)
  let wts = ($(wt[1].toStrLit)).replace(":ObjectType")
  let ats = $at.toStrLit
  let signalName = ($signal).replace("-", "_") # maybe we should just use plain proc names
  let procNameCdecl = "connect_for_signal_cdecl_" & signalName & $ProcID
  let procName = "connect_for_signal_" & signalName & $ProcID
  var sn, wid, num, all, ahl: string
  let sci = findSignal(signal, wt)
  var r1s = """
proc $1$2 {.cdecl.} =
  let h: pointer = g_object_get_qdata(self, Quark)
"""
  if sci.isNil or sci == "": # the simple signals
    all = "(self: ptr gobject.Object00; xdata: pointer)"
    ahl = "(self: gobject.Object)"
    r1s.add("  $3(cast[$4](h)")
    if not ignoreArg.boolVal:
      r1s.add(", cast[$5](xdata)")
    r1s.add(")\n")
  else: # signals with multiple arguments and maybe using interface providers
    (sn, wid, num, ahl, all) = sci.split(RecSep)
    if ahl.contains("|"): # we have to handle interface providers
      var hargs = ahl.split(";") # handler arguments
      for i in 0 .. hargs.high: # find the position of the providers, should be second or third argument
        if hargs[i].contains("|"):
          ipos = i
          break
      assert(ipos >= 0)
      let ipronode = p.symbol.getImpl().params[ipos + 1][1] # the actual data type for interface providers
      if ipronode.isNil:
        quit("Error: Signal-Handler has too few parameters: " & $(p.symbol.getImpl().name.toStrLit) & $(p.symbol.getImpl().params.toStrLit))
      else:
        ipro = $(ipronode.toStrLit)
      var ipros = hargs[ipos].split(" | ")
      ipros[0] = ipros[0].split()[^1]
      ipros[^1] = ipros[^1].split({';', ')'})[0]
      if ipros.contains(ipro): # select actual provider -- otherwise handler parameter list does not match, so compile error
        let ret = hargs[ipos].split("):") # there may be a return value
        assert(ret.len < 3)
        hargs[ipos] = hargs[ipos].split(":")[0] & ": " & ipro
        if ret.len > 1: hargs[ipos].add("):" & ret[1])
        ahl = hargs.join(";")
    var resl: string
    if ahl.contains("): "):
      resl = all.rsplit("): ", 1)[1]
    var resu = "  $3(cast[$4](h)"
    
    if all.find(";") > 0: # more than one argument
      var largs = all.split("; ")
      largs.delete(0)
      largs[^1] = largs[^1].split(")")[0] 
      var names, types: array[10, string]
      for i in 0 .. largs.high:
        if largs[i].endsWith("00"):
          (names[i], types[i]) = largs[i].split(": ptr ")
          types[i].setLen(types[i].len - 2)
        else:
          types[i] = nil # plain arg, no object
          var a1, a2: string
          (a1, a2) = largs[i].split(": ")
          let h = ct5nt(a2)
          if h.len > 0:
            a1 = h & "(" & a1 & ")"
          names[i] = a1
 
      if ipos > 0:
        types[ipos - 1] = ipro

      for i in 0 .. largs.high:
        if types[i] == nil:
          resu.add(", " & names[i])
        else:
          resu.add(", " & names[i] & "1")
          r1s.add("  var " & names[i] & "1: " & types[i] & "\n")
          r1s.add("  new " & names[i] & "1" & "\n")
          r1s.add("  " & names[i] & "1.impl = " & names[i] & "\n")
    
    if not ignoreArg.boolVal:
      resu.add(", cast[$5](data)")
    resu.add(")")
    if resl == "gboolean":
      resu.add(".ord.gboolean")
    r1s.add(resu & "\n")
    all = all.replace(")", "; data: pointer)")
  r1s = r1s % [$procNameCdecl, all, $p, wts, ats]
  #echo r1s
  result = parseStmt(r1s)
  if not ignoreArg.boolVal:
    ahl = ahl.replace(")", "; arg: " & ats & ")")
  if ahl.find(";") > 0:
    ahl = "(self: " & wts & ";" & ahl.split(";", 1)[1]
  else:
    ahl = "(self: " & wts & ")" & ahl.split(")", 1)[1]

  let r2s =
    if ignoreArg.boolVal:
      """
proc $1(self: $2;  p: proc $3): culong {.discardable.} =
  sc$4(self, $5, nil)
$1($6, $7)
""" % [$procName, wts, ahl, signalName,  $procNameCdecl, $(widget.toStrLit), $p]
    else:
      """
proc $1(self: $2;  p: proc $3; a: $4): culong {.discardable.} =
  when a is RootRef:
    GC_ref(a)
    sc$5(self, $6, cast[pointer](a))
  else:
    var ar: ref $4
    new(ar)
    deepCopy(ar[], a)
    GC_ref(ar)
    sc$5(self, $6, cast[pointer](ar[]))
$1($7, $8, $9)
""" % [$procName, wts,  ahl, ats, signalName,  $procNameCdecl, $(widget.toStrLit), $p, $(arg.toStrLit)]
  #echo r2s
  result.add(parseStmt(r2s))

template connect*(widget: gobject.Object; signal: string; p: typed; arg: typed): untyped =
  mconnect(widget, signal, p, arg, false)

template connect*(widget: gobject.Object; signal: string; p: typed): untyped =
  mconnect(widget, signal, p, "", true)

var TimeoutID: int
#
macro timeoutAdd*(interval: Natural; p: untyped; arg: typed): untyped =
  inc(TimeoutID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "timeoutfunc_" & $TimeoutID
  let procNameCdecl = "timeoutfunc_cdecl_" & $TimeoutID
  var r1s = """
proc $1(p: pointer): gboolean {.cdecl.} =
  let a = cast[$3](p)
  result = $2(a).gboolean
  #when (a is ref object) or (a is seq):
  GC_unref(a)
""" % [$procNameCdecl, $p, ats]
 
  let r2s ="""
proc $1(a: $2): culong {.discardable.} =
  when (a is ref object) or (a is seq):
    GC_ref(a)
    return g_timeout_add_full(PRIORITY_DEFAULT, $3, $4, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    deepCopy(ar[], a)
    GC_ref(ar)
    return g_timeout_add_full(PRIORITY_DEFAULT, $3, $4, cast[pointer](ar), nil)
$1($5)
""" % [$procName, ats, $interval.toStrLit, $procNameCdecl, $arg]
  result = parseStmt(r1s & r2s)

var IdleID: int
#
macro idleAdd*(p: untyped; arg: typed): untyped =
  inc(IdleID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "idlefunc_" & $IdleID
  let procNameCdecl = "idlefunc_cdecl_" & $IdleID
  var r1s = """
proc $1(p: pointer): gboolean {.cdecl.} =
  let a = cast[$3](p)
  result = $2(a).gboolean
  #when (a is ref object) or (a is seq):
  GC_unref(a)
""" % [$procNameCdecl, $p, ats]
 
  let r2s ="""
proc $1(a: $2): culong {.discardable.} =
  when (a is ref object) or (a is seq):
    GC_ref(a)
    return g_idle_add_full(PRIORITY_DEFAULT_IDLE, $3, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    deepCopy(ar[], a)
    GC_ref(ar)
    return g_idle_add_full(PRIORITY_DEFAULT_IDLE, $3, cast[pointer](ar[]), nil)
$1($4)
""" % [$procName, ats, $procNameCdecl, $arg]
  result = parseStmt(r1s & r2s)


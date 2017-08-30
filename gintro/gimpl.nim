let ct4nt = [
  "int32|int",
  "uint32|int",
  "gboolean|toBool",
  "cstring|$"]

proc ct5nt(s: string): string =
  for i in ct4nt:
    if i.startsWith(s):
      return i[s.len + 1 .. ^1]

proc findSignal(name, obj: NimNode): string =
  let str = ($name).replace("-", "_") & "|"
  for i in SCA:
    if i.startsWith(str):
      let t = i.split("|", 2)[1]
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

macro mconnect(widget: gobject.Object; signal: string; p: untyped; arg: typed; ignoreArg: bool): typed =
  inc(ProcID)
  let wt = getType(widget)
  #echo "@@@", $(getTypeInst(widget).toStrLit)
  let at = getTypeInst(arg)
  let wts = ($(wt[1].toStrLit)).replace(":ObjectType")
  #echo wts
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
  if sci.isNil:
    all = "(self: ptr gobject.Object00; xdata: pointer)"
    ahl = "(self: gobject.Object)"
    r1s.add("  $3(cast[$4](h)")
    if not ignoreArg.boolVal:
      r1s.add(", cast[$5](xdata)")
    r1s.add(")\n")
  else:
    (sn, wid, num, ahl, all) = sci.split("|")
    #echo ahl, all
    var resl: string
    if ahl.contains("): "):
      resl = all.rsplit("): ", 1)[1]
    var resu = "  $3(cast[$4](h)"
    if all.find(";") > 0:
      var largs = all.split("; ")
      #if largs.len > 0:
      largs.delete(0)
      largs[^1] = largs[^1].split(")")[0] 
      var names, types: array[10, string]
      var plainArgs = newSeq[string]()
      for i in 0 .. largs.high:
        if largs[i].endsWith("00"):
          (names[i], types[i]) = largs[i].split(": ptr ")
          types[i].setLen(types[i].len - 2)
        else:
          var a1, a2: string
          (a1, a2) = largs[i].split(": ")
          let h = ct5nt(a2)
          if h.len > 0:
            a1 = h & "(" & a1 & ")"
          plainArgs.add(a1)
      #var resu = "  $3(cast[$4](h)"
      for i in 0 .. 9:
        if names[i].isNil: break
        resu.add(", " & names[i] & "1")
        r1s.add("  var " & names[i] & "1: " & types[i] & "\n")
        r1s.add("  new " & names[i] & "1" & "\n")
        r1s.add("  " & names[i] & "1.impl = " & names[i] & "\n")
      for i in plainArgs:
        resu.add(", " & i)
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
  #echo ahl
  if ahl.find(";") > 0:
    ahl = "(self: " & wts & ";" & ahl.split(";", 1)[1]
  else:
    ahl = "(self: " & wts & ")" & ahl.split(")", 1)[1]
    #ahl = "(self: " & wts & ")"

  let r2s =
    if ignoreArg.boolVal:
      """
proc $1(self: $2;  p: proc $3) =
  sc$4(self, $5, nil)
$1($6, $7)
""" % [$procName, wts, ahl, signalName,  $procNameCdecl, $(widget.toStrLit), $p]
    else:
      """
proc $1(self: $2;  p: proc $3; a: $4) =
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

template connect*(widget: gobject.Object; signal: string; p: untyped; arg: typed): typed =
  mconnect(widget, signal, p, arg, false)

template connect*(widget: gobject.Object; signal: string; p: untyped): typed =
  mconnect(widget, signal, p, "", true)



#from sequtils import keepItIf
import macros, sequtils
from strutils import startsWith, replace
const RecSep = "!" # Record separator for entries in gisup.nim, also defined in gen.nim

# caution: $$ due to string interpolation
const ct4nt = [
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
  #echo str
  if str.startsWith("notify::"):
    #return "notify!Object!1!(self: Object; paramSpec: ParamSpec)!(self: ptr Object00; paramSpec: ptr ParamSpec00)"
    return "notify!gobject.Object!1!(self: gobject.Object; paramSpec: gobject.ParamSpec)!(self: ptr gobject.Object00; paramSpec: ptr gobject.ParamSpec00)" # v0.9.7
    # "size_allocate!Widget!1!(self: Widget; allocation: gdk.Rectangle)!(self: ptr Widget00; allocation: gdk.Rectangle)"

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
          #var h = $getType(n)[1].toStrLit
          var h = n.getTypeInst.owner.strVal & '.' & $getType(n)[1].toStrLit # v0.9.7
          #echo n.getTypeInst.owner.strVal

          if h.endsWith(":ObjectType"):
            h.setLen(h.len - 11)
          if h == t:
            return i
          n = getType(n)[1]
          n = getType(n)[1]


# for v0.9.7 we use full qualified symbols -- in mconect() and in the gisup files
# from file gisup.nim we have:
# "remove_editable!CellArea!2!(self: CellArea; renderer: CellRenderer; editable: CellEditable | SpinButton | ComboBox | ...
# so for signal remove_editable third parameter of handler proc can be CellEditable OR SpinButton OR ComboBox OR ...
# This is because SpinButton, ComboBox provides the CellEditable interface!
# https://mail.gnome.org/archives/gtk-list/2017-July/msg00018.html
# This interface parameter is in most cases the second parameter of handler proc, but can be the third also.
macro mconnect(widget: gobject.Object; signal: string; p: typed; arg: typed; ignoreArg: bool; sf: static[gobject.ConnectFlags]): untyped =
  # echo $signal
  #echo p.symbol.getImpl().toStrLit
  #echo p.symbol.getImpl().params.toStrLit
  #echo p.symbol.getImpl().params[2][1].toStrLit

  var ProcID {.compileTime, global.}: int
  var # position and actual type of interface provider, if any
    ipos = -1
    ipro: string #= nil
    sfstr = $sf
  #if sfstr == "{after}":
  #  sfstr = "{gobject.ConnectFlag.after}"
  sfstr = sfstr.replace("after", "gobject.ConnectFlag.after")
  sfstr = sfstr.replace("swapped", "gobject.ConnectFlag.swapped")

  inc(ProcID)
  let wt = getType(widget)
  let at = getTypeInst(arg)

  # echo getType(widget)[0].strVal # ref
  # echo getType(widget)[1].strVal # Window:ObjectType
  # echo getTypeInst(widget).strVal # Window

  #echo at.repr
  #echo at.typeKind == ntyRef
  # let wts = getTypeInst(widget).strVal
  let wts = widget.getTypeInst.owner.strVal & '.' & widget.getTypeInst.strVal # new in v0.5.5

  var ats: string # v0.9.7
  
  #echo ">>>>>>>>", at.kind
  #echo at.toStrLit.strVal
  
  if at.kind == nnkTupleConstr or at.kind == nnkTupleTy:
    ats = at.toStrLit.strVal

  elif at.kind == nnkProcTy: # v0.9.8
    ats = at.toStrLit.strVal

  elif at.kind == nnkRefTy:
    ats = at.getType[0].strVal  & " " & at.getType[1].owner.strVal & '.' & at.getType[1].strVal
  else:
    ats = at.owner.strVal & '.' & at.toStrLit.strVal

  var signalName = ($signal).replace("-", "_") # maybe we should just use plain proc names
  var sigName: string # for the notify:: signals

  if signalName.startsWith("notify::"):
    #sfstr.add(", " & signalName)
    sigName = ", \"" & signalName.replace("_", "-") & "\"" # https://mail.gnome.org/archives/gtk-app-devel-list/2008-March/msg00197.html
    signalName = "notify" # https://discourse.gnome.org/t/notify-signal-and-underscore-vs-hyphen/6835

  let procNameCdecl = "connect_for_signal_cdecl_" & signalName & $ProcID
  let procName = "connect_for_signal_" & signalName & $ProcID
  var sn, wid, num, all, ahl: string
  let sci = findSignal(signal, wt)
  var r1s = """
proc $1$2 {.cdecl.} =
  let h: pointer = g_object_get_qdata(self, Quark)
"""
  if sci == "": # the simple signals
    all = "(self: ptr gobject.Object00; xdata: pointer)"
    ahl = "(self: gobject.Object)"
    r1s.add("  $3(cast[$4](h)")
    if not ignoreArg.boolVal:
      if getTypeInst(arg).typeKind == ntyRef:
        r1s.add(", cast[$5](xdata)")
      else:
        r1s.add(", cast[ptr $5](xdata)[]")
    r1s.add(")\n")
  else: # signals with multiple arguments and maybe using interface providers
    (sn, wid, num, ahl, all) = sci.split(RecSep)
    #echo "ttt ", ahl
    if ahl.contains("|"): # we have to handle interface providers
      var hargs = ahl.split(";") # handler arguments
      for i in 0 .. hargs.high: # find the position of the providers, should be second or third argument
        if hargs[i].contains("|"):
          ipos = i
          break
      assert(ipos >= 0)
      #let ipronode = p.symbol.getImpl().params[ipos + 1][1] # the actual data type for interface providers
      let ipronode = p.getImpl().params[ipos + 1][1]
      if ipronode.isNil:
        #quit("Error: Signal-Handler has too few parameters: " & $(p.symbol.getImpl().name.toStrLit) & $(p.symbol.getImpl().params.toStrLit))
        quit("Error: Signal-Handler has too few parameters: " & $(p.getImpl().name.toStrLit) & $(p.getImpl().params.toStrLit))
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
      #for i in 0 .. largs.high:
      var i = 0
      var largslen = largs.len
      while i < largslen:
        if largs[i].endsWith("00Array"):
          (names[i], types[i]) = largs[i].split(": ")
          let al = largs[i + 1].split(": ")[0]
          var h = types[i]
          # h[0] = h[0].toLowerAscii # before v0.9.7
          let xxx = h.find('.') + 1 # since v0.9.7
          h[xxx] = h[xxx].toLowerAscii
          h.add("2seq(" & names[i] & ", " & al & ")")
          names[i] = h
          types[i].setLen(0)
          #largs.del(i + 1) # bug, should be delete!
          largs.delete(i + 1)
          dec(largslen)
        elif largs[i].endsWith("00"):
          (names[i], types[i]) = largs[i].split(": ptr ")
          types[i].setLen(types[i].len - 2)
        else:
          types[i] = ""#nil # plain arg, no object
          var a1, a2: string
          (a1, a2) = largs[i].split(": ")
          let h = ct5nt(a2)
          if h.len > 0:
            a1 = h & "(" & a1 & ")"
          names[i] = a1
        inc(i)
 
      if ipos > 0:
        types[ipos - 1] = ipro

      for i in 0 .. largs.high:
        if types[i] == "":
          resu.add(", " & names[i])
        else:
          resu.add(", " & names[i] & "1")
          r1s.add("  var " & names[i] & "1 {.global.}: " & types[i] & "\n")
          r1s.add("  if " & names[i] & "1" & ".isNil:\n")
          r1s.add("    new " & names[i] & "1" & "\n")
          r1s.add("    GC_ref(" & names[i] & "1)" & "\n") # never call destroy/finalizer on this global variable
          r1s.add("    " & names[i] & "1.ignoreFinalizer = true" & "\n")
          r1s.add("  " & names[i] & "1.impl = " & names[i] & "\n")
    if not ignoreArg.boolVal:
      if getTypeInst(arg).typeKind == ntyRef:
        resu.add(", cast[$5](user_data)")
      else:
        resu.add(", cast[ptr $5](user_data)[]")
    resu.add(")")
    if resl == "gboolean":
      resu.add(".ord.gboolean")

    elif resl == "int32":
      resu.add(".int32")
      
    elif resl == "cstring":
      resu.add(".g_strdup")

    elif resl.len != 0: # result is heavy proxy object. Actually this is an ugly guess currently.
      r1s.add("  let tmp = " & resu[2 .. ^1] & "\n")
      r1s.add("  tmp.ignoreFinalizer = true\n")
      resu = "  cast[typeof(result)](tmp.impl)"
      #resu.add(".impl)")
      #resu = "  cast[typeof(result)](" & resu
      
    r1s.add(resu & "\n")
    all = all.replace(")", "; user_data: pointer)")

  #echo all

  if all.find("00Array") >= 0:
    var h = all.split(';')
    for el in mitems(h):
      var a, b: string
      (a, b) = el.split(": ")
      if b.find("Array") >= 0:
        b = "ptr " & b.replace("Array")
      el = a & ": " & b
    all = h.join(";")

  #echo all cdecl

  # https://forum.nim-lang.org/t/6775#42155
  const matcher = "Array" # is this good enough?
  var ra: string
  for (elem, isSep) in all.tokenize(Whitespace + {',', ';'}):
    if elem.endsWith(matcher):
      ra.add("ptr " & elem[0 .. ^(matcher.len + 1)])
    else:
      ra.add(elem)

  #echo ra
  #assert ra == all

  r1s = r1s % [$procNameCdecl, all, $p, wts, ats]
  #echo r1s

  result = parseStmt(r1s)

  if not ignoreArg.boolVal:
    ahl = ahl.replace(")", "; arg: " & ats & ")")
  if ahl.find(";") > 0:
    ahl = "(self: " & wts & ";" & ahl.split(";", 1)[1]
  else:
    ahl = "(self: " & wts & ")" & ahl.split(")", 1)[1]

  if ahl.find("00Array") >= 0:
    var hhh = ahl.split("; ")
    let l = hhh.len
    var i = 0
    while i < l:
      # files: seq[gio.File]
      if hhh[i] .find("00Array") >= 0:
        var a, b: string
        (a, b) = hhh[i].split(": ")
        b = b.replace("00Array", "]")
        #if b == "File]":
        #  b = "gio.File]"
        b = "seq[" & b
        hhh[i] = a & ": " & b
        hhh[i + 1].setLen(0)
      inc(i)
    hhh.keepItIf(it.len > 0)
    #echo ">>>>>>>>>> ", hhh.join("; ")
    ahl = hhh.join("; ")

  ahl = ahl.replace(": cstring", ": string")

  # maybe we write this better this way:
  let r2s =
    if ignoreArg.boolVal:
      """
proc $1(self: $2;  p: proc $3): culong {.discardable.} =
  sc$4(self, $5, nil, $8)
$1($6, $7)
""" % [$procName, wts, ahl, signalName,  $procNameCdecl, $(widget.toStrLit), $p, sfstr, sigName]
    elif getTypeInst(arg).typeKind == ntyRef:
      """
proc $1(self: $2;  p: proc $3; a: $4): culong {.discardable.} =
  GC_ref(a)
  sc$5(self, $6, cast[pointer](a), $10 $11)
$1($7, $8, $9)
""" % [$procName, wts,  ahl, ats, signalName,  $procNameCdecl, $(widget.toStrLit), $p, $(arg.toStrLit), sfstr, sigName]
    else:
      """
proc $1(self: $2;  p: proc $3; a: $4): culong {.discardable.} =
  var ar: ref $4
  new(ar)
  #deepCopy(ar[], a)
  ar[] = a
  GC_ref(ar)
  # sc$5(self, $6, cast[pointer](ar[]))
  sc$5(self, $6, cast[pointer](ar), $10 $11)
$1($7, $8, $9)
""" % [$procName, wts,  ahl, ats, signalName,  $procNameCdecl, $(widget.toStrLit), $p, $(arg.toStrLit), sfstr, sigName]
  #echo r2s

  result.add(parseStmt(r2s))

template connect*(widget: gobject.Object; signal: string; p: typed; arg: typed): untyped =
  mconnect(widget, signal, p, arg, false, {})

template connect*(widget: gobject.Object; signal: string; p: typed): untyped =
  mconnect(widget, signal, p, "", true, {})

template connectAfter*(widget: gobject.Object; signal: string; p: typed; arg: typed): untyped =
  mconnect(widget, signal, p, arg, false, {gobject.ConnectFlag.after})

template connectAfter*(widget: gobject.Object; signal: string; p: typed): untyped =
  mconnect(widget, signal, p, "", true, {gobject.ConnectFlag.after})

template connectSwapped*(widget: gobject.Object; signal: string; p: typed; arg: typed): untyped =
  mconnect(widget, signal, p, arg, false, {gobject.ConnectFlag.swapped})

template connectSwapped*(widget: gobject.Object; signal: string; p: typed): untyped =
  mconnect(widget, signal, p, "", true, {gobject.ConnectFlag.swapped})

macro timeoutAdd*(interval: Natural; p: untyped; arg: typed): untyped =
  var TimeoutID {.compileTime, global.}: int
  inc(TimeoutID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "timeoutfunc_" & $TimeoutID
  let procNameCdecl = "timeoutfunc_cdecl_" & $TimeoutID
  var r1s = """
proc $1(p: pointer): gboolean {.cdecl.} =
  let a = cast[$3](p)
  result = $2(a).gboolean
  #when (a is ref object) or (a is seq):
  #GC_unref(a)
""" % [$procNameCdecl, $p, ats]
 
  let r2s ="""
proc $1(a: $2): culong {.discardable.} =
  when (a is ref object) or (a is seq):
    GC_ref(a)
    return g_timeout_add_full(PRIORITY_DEFAULT, $3, $4, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], a)
    ar[] = a
    GC_ref(ar)
    return g_timeout_add_full(PRIORITY_DEFAULT, $3, $4, cast[pointer](ar), nil)
$1($5)
""" % [$procName, ats, $interval.toStrLit, $procNameCdecl, $arg]
  result = parseStmt(r1s & r2s)

macro idleAdd*(p: untyped; arg: typed): untyped =
  var IdleID {.compileTime, global.}: int
  inc(IdleID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "idlefunc_" & $IdleID
  let procNameCdecl = "idlefunc_cdecl_" & $IdleID
  var r1s = """
proc $1(p: pointer): gboolean {.cdecl.} =
  let a = cast[$3](p)
  result = $2(a).gboolean
  #when (a is ref object) or (a is seq):
  #GC_unref(a)
""" % [$procNameCdecl, $p, ats]
 
  let r2s ="""
proc $1(a: $2): culong {.discardable.} =
  when (a is ref object) or (a is seq):
    GC_ref(a)
    return g_idle_add_full(PRIORITY_DEFAULT_IDLE, $3, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], a)
    ar[] = a
    GC_ref(ar)
    return g_idle_add_full(PRIORITY_DEFAULT_IDLE, $3, cast[pointer](ar[]), nil)
$1($4)
""" % [$procName, ats, $procNameCdecl, $arg]
  result = parseStmt(r1s & r2s)

#####################################################

#[
void
(* GtkCallback) (
  GtkWidget* widget,
  gpointer data
)

void
gtk_container_foreach (
  GtkContainer* container,
  GtkCallback callback,
  gpointer callback_data
)
]#

when not declared(gtk4): # only for old gtk3, gtk4 has no gtk.Container widget.

  # https://docs.gtk.org/gtk3/method.Container.foreach.html
  macro foreach*(container: gtk.Container; p: untyped; arg: typed): untyped =
    var foreachID {.compileTime, global.}: int
    inc(foreachID)
    var ats = $getTypeInst(arg).toStrLit
    let procName = "foreach_" & $foreachID
    let procNameCdecl = "foreach_cdecl_" & $foreachID
    var r1s = """
  proc $1(c: ptr gtk.Widget00; p: pointer) {.cdecl.} =
    when $3 is ref:
      let a = cast[$3](p)
    else:
      let a = cast[ref $3](p)
    let h: pointer = g_object_get_qdata(c, Quark)
    assert(h != nil)
    let cn: gtk.Container = cast[gtk.Container](h)
    when $3 is ref:
      $2(cn, a)
    else:
      $2(cn, a[])
  """ % [$procNameCdecl, $p, ats]
   
    let r2s ="""
  proc $1(container: gtk.Container; a: $2) =
    when a is ref:
      GC_ref(a)
      gtk_container_foreach(cast[ptr gtk.Container00](container.impl), $3, cast[pointer](a))
    else:
      var ar: ref $2
      new(ar)
      ar[] = a
      GC_ref(ar)
      gtk_container_foreach(cast[ptr gtk.Container00](container.impl), $3, cast[pointer](ar))
  $1($5, $4)
  """ % [$procName, ats, $procNameCdecl, $arg, $container]
    #echo r1s
    #echo r2s
    result = parseStmt(r1s & r2s)

# 463 lines

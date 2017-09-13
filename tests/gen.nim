# High level gobject-introspection based GTK3 bindings for the Nim programming language
# v 0.2 2017-SEP-13
# (c) S. Salewski 2017

# https://wiki.gnome.org/Projects/GObjectIntrospection
# https://developer.gnome.org/gi/1.50/index.html
# https://mail.gnome.org/archives/gtk-devel-list/2005-April/msg00095.html
# /usr/share/gir-1.0/GLib-2.0.gir

# you may also compare the currently unmaintained work of
# https://github.com/jdmansour/nim-smartgi

# This module itself is still based on the low level GTK 3.20 wrappers at
# https://github.com/ngtk3

# Currently we intentionally do not free any resources!

# First goal is creating low level bindings similar to current ngtk3. #XXX  DONE
# Then we will add the high level wrapper similar as done in Nim's libui wrapper. #XXX Mostly DONE
# What remains is carefully inspecting the generated code, adding special like list/array results
# and of course a lot of testing.

# Known gobject-introspection related issues:
# - gFieldInfoGetSize() is always zero, so we have no bitfield support yet.
# - ParamSpec is reported as object, but has no parent
# - gBaseInfoGetName() is "" for g_iconv()
# - dirSep is wrong for unix -- that is an already reported gi bug
# - well there are more than 180 open issues about gobject introspection in gnome bugzilla :-(
# - 

# This module is really ugly currently  -- the first goal was to get a working gi solution

from os import `/`
import gir
import glib
import strutils
import sequtils
import streams
import sets
import bitops
import tables
import algorithm
from combinatorics import combinations

template isCallbackInfo(info: untyped): untyped =
      (gBaseInfoGetType(cast[GIBaseInfo](info)) == GIInfoType.Callback)

template isFunctionInfo(info: untyped): untyped =
      (gBaseInfoGetType(cast[GIBaseInfo](info)) == GIInfoType.Function)

const EM = "*"

# hope that will work reliable
proc cut(s: var StringStream; pos: int) =
  assert(pos >= 0 and pos <= s.getPosition)
  s.setPosition(pos)
  s.data.setLen(pos)
  s.setPosition(pos)

var moduleNamespace: string
let libprag: string = "libprag"

let keywords = """
addr and as asm atomic bind block break case cast concept const continue converter
defer discard distinct div do elif else end enum except export finally for from func
generic if import in include interface is isnot iterator let macro method mixin mod
nil not notin object of or out proc ptr raise ref return shl shr static template try tuple
type using var when while with without xor yield
"""

let nims = """
int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64 pointer false true string char bool
"""

proc mysnakeToCamel(s: cstring): string =
  var i, j: int
  result = newString(s.len)
  if s[i] == '_': inc(i)
  while true:
    if s[i] == '_' and (s[i + 1] == '\0' or s[i + 1] == '_'):
      inc(i)
    elif (s[i] == '_' or s[i] == '-') and s[i + 1].isLowerAscii and not s[i - 1].isUpperAscii:
      inc(i)
      result[j] = toUpperAscii(s[i])
      inc(i)
      inc(j)
    else:
      result[j] = s[i]
      inc(i)
      inc(j)
    if s[i] == '\0':
      result.setLen(j)
      break
  if result[0] == '\0': # this may result, so we emit a dummy name as marker
    result = "QQQ"
    #assert(false)

proc renumber(s: var string; i: int) =
  var h = ""
  if s[^1].isDigit:
    h.add(s[^1])
    setLen(s, s.len - 1)
  s.add($i)
  s.add(h)

var defaultParameters = newTable[string, string]()
var fixedProcNames = newTable[string, string]()
var mangledNames = newTable[string, string]()
var gdkKeys = newTable[string, seq[string]]()
var allSyms: HashSet[string]
var provInt = newTable[string, seq[string]]()
var interfaceProvider = newTable[string, seq[string]]()
var priList: seq[string]
var knownSyms: HashSet[string]
var suppressType = false
var suppressRaise = false
var droppedSyms = initSet[string]()
var callerAlloc = initSet[string]()
var callerAllocCollector = initSet[string]()
var privStr = initSet[string]()
var processedFunctions = initSet[string]()
var delayedMethods: seq[(GIBaseInfo, GIFunctionInfo)]
var classList: seq[GIBaseInfo]
var ct: CountTable[string] 

fixedProcNames.add("gtk_button_new_with_label", "newButton")
fixedProcNames.add("pango_font_description_from_string", "newFontDescription")
fixedProcNames.add("pango_language_from_string", "languageFromString")
fixedProcNames.add("gdk_event_get", "getEvent")
fixedProcNames.add("gdk_display_manager_get", "getDisplayManager")
fixedProcNames.add("gdk_display_get_default", "getDefaultDisplay")

defaultParameters.add("gtk_window_new", "`type` WindowType WindowType.toplevel")
defaultParameters.add("gtk_application_new", "flags gio.ApplicationFlags {}")
for i in keywords.split: mangledNames.add(i, '`' & i & '`')

mangledNames.add("CSET_A_2_Z", "CSET_A_2_Z_U")
mangledNames.add("CSET_a_2_z", "CSET_a_2_z_L")
mangledNames.add("2big", "tooBig")
mangledNames.add("2buttonPress", "twoButtonPress")
mangledNames.add("3buttonPress", "threeButtonPress")
mangledNames.add("result", "resu")

proc gBaseInfoGetName(info: GIBaseInfo): string =
  result = $(gir.gBaseInfoGetName(info))
  let h = $(gir.gBaseInfoGetNamespace(info))
  if h == "Gio" and result == "Application":
    result = "GApplication"

proc mangleName(s: cstring): string =
  result = mysnakeToCamel(s)
  if mangledNames.contains(result):
    result = mangledNames[result]
  if result == "``":
    # assert(false)
    result = "xxx" # XXX

var mangledTypes = newTable[string, string]()

mangledTypes.add("gint8", "int8")
mangledTypes.add("gint16", "int16")
mangledTypes.add("gint32", "int32")
mangledTypes.add("gint64", "int64")
mangledTypes.add("guint8", "uint8")
mangledTypes.add("guint16", "uint16")
mangledTypes.add("guint32", "uint32")
mangledTypes.add("guint64", "uint64")
mangledTypes.add("gfloat", "cfloat")
mangledTypes.add("gdouble", "cdouble")
mangledTypes.add("ptr void", "pointer")
mangledTypes.add("ptr filename", "ucstring") # WRONG, var deleted to make it compile!
mangledTypes.add("ptr error", "ptr Error00")
mangledTypes.add("ptr ghash", "ptr HashTable00")
mangledTypes.add("ptr glist", "ptr pointer")
mangledTypes.add("ptr gslist", "ptr pointer")
mangledTypes.add("ptr utf8", "cstring")

droppedSyms.incl("MININT8")
droppedSyms.incl("MININT16")
droppedSyms.incl("MININT32")
droppedSyms.incl("MININT64")

# we may have to add digits to avoid name conflicts due to inheritance
privStr.incl("privat")
privStr.incl("priv")
privStr.incl("padding")
privStr.incl("pad")
privStr.incl("unused")
privStr.incl("privateData")

callerAlloc.incl("atk.Rectangle") # ATK has TextRectangle and Rectangle!
callerAlloc.incl("pango.Color") # we have to add these manually -- maybe there are more plain structs to add

const CA_Items = """
pango.Style
pango.Stretch
glib.MarkupParser
glib.TimeVal
gtk.TextIter
pango.Weight
gdk.Rectangle
gtk.AccelKey
gtksource.RegionIter
gtk.TextAttributes
gobject.Value
gobject.SignalQuery
gobject.TypeQuery
gtk.TreeIter
gtk.StockItem
glib.String
gdk.Atom
rsvg.PositionData
rsvg.DimensionData
pango.Variant
gdk.Color
gtk.Border
atk.TextRectangle
gdk.RGBA
pango.Rectangle
gtk.Requisition
"""
for i in CA_Items.split:
  callerAlloc.incl(i)

type
  UndefEx = object of Exception

proc mangleType(s: cstring): string =
  result = mangleName(s)
  if mangledTypes.contains(result):
    result = mangledTypes[result]
  if allSyms.contains(result) and not knownSyms.contains(result):
    if not suppressRaise:
      pri_list.add(result)
      raise newException(UndefEx, "forward declaration")
    else:
      echo "!!!", result

var output: StringStream
var supmod: StringStream
var methodBuffer: StringStream

proc genP(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil): (string, string, TableRef[string, string])

proc isString(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  tag == GITypeTag.UTF8

# recursive investigate that type -- resolve Arrays and Interfaces
proc genRec(t: GITypeInfo; genProxy = false; fullQualified: bool = false): string =
  var rawmark = ""
  var proxyResult = false#callerAllocCollector
  let p = gTypeInfoIsPointer(t)
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.ARRAY:
    let toa = gTypeInfoGetArrayType(t) # type of array
    if toa == GIArrayType.ARRAY: result = "Array"
    elif toa == GIArrayType.PTR_ARRAY: result = "PtrArray"
    elif toa == GIArrayType.BYTE_ARRAY: result = "ByteArray00"
    elif toa == GIArrayType.C:
      let arrayType = gTypeInfoGetParamType(t, 0)
      let arrayTag = gTypeInfoGetTag(arrayType)
      let arrayFixedSize = gTypeInfoGetArrayFixedSize(t)
      let arrayLength = gTypeInfoGetArrayLength(t)
      let xxx = genRec(arrayType)
      let child = mangleType(mangleName(genRec(arrayType)))
      result = "array[$1, $2]" % [$arrayFixedSize, child]
      if arrayFixedSize == -1:
        result = child & "Array"
        return
  elif tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    if gBaseInfoGetType(iface) == GIInfoType.CALLBACK:
      if gBaseInfoGetName(iface)[0].isLowerAscii:
        result = "proc" & genP(iface)[0] & " {.cdecl.}"
      else:
        result = mangleName(gBaseInfoGetName(iface))
    else:
      var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
      result = mangleName($gBaseInfoGetName(iface))
      if ns == "cairo" and moduleNamespace == "pangocairo" and result == "FontType": return result # GI bug?
      if gBaseInfoGetType(iface) == GIInfoType.Object or gBaseInfoGetType(iface) == GIInfoType.STRUCT or gBaseInfoGetType(iface) == GIInfoType.UNION or gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
        proxyResult = genProxy
        if not (genProxy or callerAlloc.contains(ns & '.' & result)):
          rawmark = "00"
      if fullQualified or ns != moduleNamespace:
        result = ns & '.' & result
  else:
    result = $gTypeTagToString(tag)
  result = mangleType(result)
  if p and (not proxyResult):# or callerAlloc.contains(result)):
    result = "ptr " & result
  result = mangleType(result) & rawmark

proc isProxyCandidate(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
    if callerAlloc.contains(ns & '.' & $gBaseInfoGetName(iface)): return false
    if ns == "cairo" and moduleNamespace == "pangocairo" and $gBaseInfoGetName(iface) == "FontType": return false # GI bug?
    result = gBaseInfoGetType(iface) in {GIInfoType.Object, GIInfoType.STRUCT, GIInfoType.UNION, GIInfoType.INTERFACE}

proc needProxyProc(info: GICallableInfo): bool =
  result = gCallableInfoIsMethod(info)
  let m = gCallableInfoGetNArgs(info) - 1
  for j in 0 .. m:
    let arg = gCallableInfoGetArg(info, j)
    let t = gArgInfoGetType(arg)
    if isProxyCandidate(t): result = true
  var ret = gCallableInfoGetReturnType(info)
  assert(ret != nil)
  let tag = gTypeInfoGetTag(ret)
  if isFunctionInfo(info):
    if (gFunctionInfoGetFlags(info).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
      let h = gBaseInfoGetContainer(info)
      if gBaseInfoGetType(h) == GIInfoType.OBJECT:
        result = true
        return result
    if isProxyCandidate(ret): result = true

var ct2nt = newTable[string, string]()
ct2nt.add("uint32", "int")
ct2nt.add("int32", "int")
ct2nt.add("cstring", "string")
ct2nt.add("gboolean", "bool")

proc ct3nt(s: string): string =
  assert(ct2nt.contains(s))
  result =
    case s:
    of "cstring": "$"
    of "gboolean": "toBool"
    else: ct2nt[s] 

proc genP(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil): (string, string, TableRef[string, string]) =
  var cutat = 50
  var arglist: string
  var resul: string
  var replist = newTable[string, string]()
  let m = gCallableInfoGetNArgs(info) - 1
  var sym = ""
  if isFunctionInfo(info):
    sym = $gFunctionInfoGetSymbol(info)
  if binfo.isNil or not gCallableInfoIsMethod(info):
    resul = "("
    arglist = "("
  else:
    var ns = ($gBaseInfoGetNamespace(binfo)).toLowerAscii
    if callerAlloc.contains(ns & '.' & manglename(gBaseInfoGetName(binfo))):
      resul = "(self: " & manglename(gBaseInfoGetName(binfo))
      arglist = "(self"
    else:
      arglist = "(cast[ptr " & manglename(gBaseInfoGetName(binfo)) & "00](" & "self.impl)"
      if genProxy:
        var h = manglename(gBaseInfoGetName(binfo))
        if (sym.startsWith("gdk_events_get_") or sym.startsWith("gdk_event_get_")) and h == "Event":
          h = "SomeEvent"
        resul = "(self: " & h
      else:
        resul = "(self: ptr " & manglename(gBaseInfoGetName(binfo)) & "00"
    if m >= 0:
      resul.add("; ")
      arglist.add(", ")
  for j in 0 .. m:
    let arg = gCallableInfoGetArg(info, j)
    let t = gArgInfoGetType(arg)
    if gArgInfoIsCallerAllocates(arg):
      callerAllocCollector.incl(genRec(t, true, true))
    var str = genRec(t, genProxy and not gArgInfoIsCallerAllocates(arg))

    if (sym.startsWith("gtk_widget_set_events") or sym.startsWith("gtk_widget_add_events")) and str == "int32":
      str = "gdk.EventMask"

    if isSignalInfo(info) and isProxyCandidate(t) and not genProxy:
      str.insert("ptr ")
    var userAlloc: bool
    if  callerAlloc.contains(genRec(t, true, true)):
      userAlloc = true
      str = genRec(t, true)
    if genProxy:
      let tag = gTypeInfoGetTag(t)
      if tag == GITypeTag.INTERFACE:
        let iface = gTypeInfoGetInterface(t)
        if gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
          if interfaceProvider.contains(str):
            let provider = interfaceProvider[str]
            for i in provider: discard mangleType(i)
            str = str & " | " & provider.join(" | ")
    let name = mangleName(gBaseInfoGetName(arg))
    if isProxyCandidate(t) and not gArgInfoIsCallerAllocates(arg) and not userAlloc:
      arglist.add("cast[" & genRec(t, false) & "](" & name & ".impl)")
    else:
      if ct2nt.contains(str) and (gArgInfoGetDirection(arg) == GIDirection.OUT  or gArgInfoGetDirection(arg) == GIDirection.INOUT):
        let kk = if name[0] == '`': name[1 .. ^2] else: name
        arglist.add(kk & "_00")
      elif ct2nt.contains(str):
       arglist.add(str & '(' & name & ')')
      else:
        arglist.add(name)
    if not genProxy and ct2nt.contains(str) and str != "cstring":
       replist.add($name, $str)
    if genProxy and ct2nt.contains(str):
      if gArgInfoGetDirection(arg) == GIDirection.OUT or gArgInfoGetDirection(arg) == GIDirection.INOUT:
        replist.add($name, $str)
      str = ct2nt[str]
    if gArgInfoGetDirection(arg) == GIDirection.OUT or gArgInfoGetDirection(arg) == GIDirection.INOUT: # caution cstringArray
      str.insert("var ")
    if genProxy and defaultParameters.contains(sym):
      var h1, h2, h3: string
      (h1, h2, h3) = defaultParameters[sym].split
      if name == h1 and str == h2:
        str.add(" = " & h3)

    if (sym.startsWith("gdk_events_get_") or sym.startsWith("gdk_event_get_")) and str == "Event":
      str = "SomeEvent"

    resul.add(name & ": " & str)
    if j < m:
      resul.add("; ")
      arglist.add(", ")
      if resul.len  > cutat:
        cutat = 3 * cutat
        resul.add("\n    ")
  if not genProxy and gCallableInfoCanThrowGerror(info):
    if resul[^1] != '(': resul.add("; ")
    resul.add("error: ptr ptr Error00 = nil")
  resul.add(')')
  arglist.add(')')
  var ret = gCallableInfoGetReturnType(info)
  assert(ret != nil)
  let tag = gTypeInfoGetTag(ret)
  if isFunctionInfo(info):
    if (gFunctionInfoGetFlags(info).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
      let h = gBaseInfoGetContainer(info)
      if gBaseInfoGetType(h) == GIInfoType.OBJECT:
        if genProxy:
          resul.add(": " & mangleType(mangleName(gBaseInfoGetName(h))))
        else:
          resul.add(": ptr " & mangleType(mangleName(gBaseInfoGetName(h))) & "00")
        return (resul, arglist, replist)
  var r = genRec(ret, genProxy)
  if gTypeInfoIsPointer(ret) and callerAlloc.contains(genRec(ret, true, true)) and (not r.startsWith("ptr")):
    r = "ptr " & r
  if r != "void":
    if genProxy and ct2nt.contains(r):
      r = ct2nt[r]
    resul.add(": " & r)
  return (resul, arglist, replist)

proc writeMethod(info: GIBaseInfo; minfo: GIFunctionInfo; genProxy = false) =
  assert(isCallableInfo(mInfo))
  assert(isFunctionInfo(mInfo))
  var plist, arglist: string
  var replist: TableRef[string, string]
  let p = methodBuffer.getPosition
  let sym = $gFunctionInfoGetSymbol(mInfo)
  if sym[^1] == '_': return
  if sym.contains("__"): return
  if processedFunctions.contains(sym): return
  if sym == "gtk_text_iter_copy": return
  if sym == "gtk_widget_destroyed": return
  if sym == "g_error_new_literal": return
  for j in 0 ..< gCallableInfoGetNArgs(minfo):
    let arg = gCallableInfoGetArg(minfo, j)
    let t = gArgInfoGetType(arg)
    if isProxyCandidate(t) and gArgInfoGetDirection(arg) == GIDirection.OUT and not gArgInfoIsCallerAllocates(arg): return
  if sym == "g_iconv":
    return
  try:
    (plist, arglist, replist) = genP(mInfo, genProxy, info)
    methodBuffer.write("\nproc " & sym & EM & plist)
    methodBuffer.writeLine(" {.\n    importc: \"", sym, "\", ", libprag, ".}")
    processedFunctions.incl(sym)
    if sym.contains("g_param_spec_") or sym.contains("g_type_interface_")  or sym.contains("g_object_interface_") or sym.contains("g_value_"): return
    if sym.contains("gtk_widget_class_find_style_property") or sym.contains("gtk_container_class_find_child_property"): return
    if sym.contains("gtk_cell_area_class_find_cell_property"): return
    var asym = manglename(gBaseInfoGetName(mInfo))
    if keywords.split.contains(asym) or nims.split.contains(asym): asym.add('P')
    var ret2 = gCallableInfoGetReturnType(minfo)
    var ret22 = gCallableInfoGetReturnType(minfo)
    for run in 0 .. 1:
      if run == 1:
        if fixedProcNames.contains(sym): continue
        if not (asym.startsWith("get") or  asym.startsWith("set")) or asym == "getPlugin" or asym.len < 4: continue
        if asym.startsWith("get") and gTypeInfoGetTag(ret2) == GITypeTag.VOID: continue
        if asym.startsWith("set"):
          if gCallableInfoGetNArgs(minfo) > 2:
            continue
          if gCallableInfoIsMethod(minfo) and gCallableInfoGetNArgs(minfo) > 1:
            continue
        if asym.startsWith("get"):
          asym = asym[3 .. ^1]
          asym[0] = asym[0].toLowerAscii
        if asym.startsWith("set"):
          asym = asym[3 .. ^1]
          asym[0] = asym[0].toLowerAscii
          asym = '`' & asym & '=' & '`'
        if keywords.split.contains(asym) or nims.split.contains(asym): continue
      if needProxyProc(mInfo) or isString(ret2) or replist.len > 0:
        var isGObject = false
        let tag = gTypeInfoGetTag(ret2)
        if tag == GITypeTag.INTERFACE:
          let iface = gTypeInfoGetInterface(ret2)
          if gBaseInfoGetType(iface) == GIInfoType.Object:
            isGObject = true
        (plist, arglist, replist) = genP(mInfo, true, info)
        if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
          if info != nil:
            asym = asym.replace("new", "new" & manglename(gBaseInfoGetName(info)))
          if fixedProcNames.contains(sym):
            asym = fixedProcNames[sym]
          for i in 0 .. 1:
            var hhh = "\nproc " & asym & EM & plist
            if i > 0:
              let semi = if hhh.contains("()"): "" else: "; "
              let p = hhh.find("): ")
              hhh.setLen(p + 1)
              hhh = hhh.replace("new", "init")
              hhh = hhh.replace("*(", "*[T](result: var T" & semi)
            methodBuffer.writeLine(hhh & " =")
            if gCallableInfoCanThrowGerror(minfo):
              methodBuffer.writeLine("  var gerror: ptr Error00")
              if i == 0: arglist.insert(", addr gerror", arglist.high)
            if i > 0:
              methodBuffer.writeLine("  assert(result is $1)" % [manglename(gBaseInfoGetName(info))])
            assert(replist.len == 0)
            for k, v in replist:
              let kk = if k[0] == '`': k[1 .. ^2] else: k
              methodBuffer.writeLine("  var $1_00 = $2($3)" % [kk, v, k])
            #[
            if isGObject:
              methodBuffer.writeLine("  new(result, finalizeGObject)")
            else:
              methodBuffer.writeLine("  new(result)")
            methodBuffer.writeLine("  result.impl = " & sym & arglist)
            for k, v in replist:
              let kk = if k[0] == '`': k[1 .. ^2] else: k
              methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), kk]) 
            if isGObject:
              methodBuffer.writeLine("  GC_ref(result)")
              methodBuffer.writeLine("  discard g_object_ref_sink(result.impl)")
              methodBuffer.writeLine("  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))")
              methodBuffer.writeLine("  g_object_unref(result.impl)")
              methodBuffer.writeLine("  assert(g_object_get_qdata(result.impl, Quark) == nil)")
              methodBuffer.writeLine("  g_object_set_qdata(result.impl, Quark, addr(result[]))")
            ]#
            if isGObject:
              # CAUTION: some procs are advertised as constructor but do not construct new objects,
              # they just return existing ones as gdk_cursor_new_from_name()
              methodBuffer.writeLine("  let gobj = " & sym & arglist)
              methodBuffer.writeLine("  if g_object_get_qdata(gobj, Quark) != nil:")
              let h = gBaseInfoGetContainer(minfo)
              var rt: string
              if gBaseInfoGetType(h) == GIInfoType.OBJECT:
                rt = mangleType(mangleName(gBaseInfoGetName(h)))
              else:
                rt = genRec(ret2, true)
              #methodBuffer.writeLine("    result = cast[$1](g_object_get_qdata(gobj, Quark))" % [rt])
              methodBuffer.writeLine("    result = cast[type(result)](g_object_get_qdata(gobj, Quark))" % [rt])
              methodBuffer.writeLine("    assert(result.impl == gobj)")
              methodBuffer.writeLine("  else:") # I guess this will never get called...
              if sym == "g_object_ref" or sym == "g_object_ref_sink":
                methodBuffer.writeLine("    assert(false)")
              else:
                methodBuffer.writeLine("    new(result, finalizeGObject)")
                methodBuffer.writeLine("    result.impl = gobj")
                methodBuffer.writeLine("    GC_ref(result)")
                methodBuffer.writeLine("    discard g_object_ref_sink(result.impl)")
                methodBuffer.writeLine("    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))")
                methodBuffer.writeLine("    g_object_unref(result.impl)")
                methodBuffer.writeLine("    assert(g_object_get_qdata(result.impl, Quark) == nil)")
                methodBuffer.writeLine("    g_object_set_qdata(result.impl, Quark, addr(result[]))")
            elif gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              if sym == "g_closure_new_simple": 
                let nMethods = gStructInfoGetNMethods(info)
                for j in 0 .. <nMethods:
                  echo "yes there is unref method! ", $gBaseInfoGetName(gStructInfoGetMethod(info, j))
                #assert(gStructInfoFindMethod(info, "unref") != nil) # TODO GI bug?
              assert info != nil
              var freeMe: GIFunctionInfo
              if gBaseInfoGetType(info) == GIInfoType.UNION:
                freeMe = gUnionInfoFindMethod(info, "free")
                if freeMe.isNil:
                  freeMe = gUnionInfoFindMethod(info, "unref")
              else:
                assert gBaseInfoGetType(info) == GIInfoType.STRUCT
                freeMe = gStructInfoFindMethod(info, "free")
                if freeMe.isNil:
                  freeMe = gStructInfoFindMethod(info, "unref")
              var freeMeName: string
              if freeMe == nil:
                echo "Caution: No free/unref found for ", ' ', " (", sym, ')' # Mostly missing cairo functions...
              else:
                freeMeName = $gBaseInfoGetName(freeMe)
              if sym == "g_closure_new_simple" or sym == "g_closure_new_object": freeMeName = "unref" # TODO GI bug?
              assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
              if freeMeName.isNil:
                methodBuffer.writeLine("  new(result)")
              else:
                methodBuffer.writeLine("  new(result, $1)" % freeMeName)
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
            else:
              methodBuffer.writeLine("  new(result)")
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
            for k, v in replist:
              let kk = if k[0] == '`': k[1 .. ^2] else: k
              methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), kk]) 
        elif isProxyCandidate(ret2):
          if info != nil:
            asym = asym.replace("new", "new" & manglename(gBaseInfoGetName(info)))
          if fixedProcNames.contains(sym):
            asym = fixedProcNames[sym]
          methodBuffer.writeLine("\nproc " & asym & EM & plist & " =")
          if gCallableInfoCanThrowGerror(minfo):
            methodBuffer.writeLine("  var gerror: ptr Error00")
            arglist.insert(", addr gerror", arglist.high)
          for k, v in replist:
            let kk = if k[0] == '`': k[1 .. ^2] else: k
            methodBuffer.writeLine("  var $1_00 = $2($3)" % [kk, v, k])
          if isGObject:
            methodBuffer.writeLine("  let gobj = " & sym & arglist)
            methodBuffer.writeLine("  if g_object_get_qdata(gobj, Quark) != nil:")
            methodBuffer.writeLine("    result = cast[$1](g_object_get_qdata(gobj, Quark))" % [genRec(ret2, true)])
            methodBuffer.writeLine("    assert(result.impl == gobj)")
            methodBuffer.writeLine("  else:") # I guess this will never get called...
            if sym == "g_object_ref" or sym == "g_object_ref_sink":
              methodBuffer.writeLine("    assert(false)")
            else:
              methodBuffer.writeLine("    new(result, finalizeGObject)")
              methodBuffer.writeLine("    result.impl = gobj")
              methodBuffer.writeLine("    GC_ref(result)")
              methodBuffer.writeLine("    discard g_object_ref_sink(result.impl)")
              methodBuffer.writeLine("    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))")
              methodBuffer.writeLine("    g_object_unref(result.impl)")
              methodBuffer.writeLine("    assert(g_object_get_qdata(result.impl, Quark) == nil)")
              methodBuffer.writeLine("    g_object_set_qdata(result.impl, Quark, addr(result[]))")
          elif gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
            let tag = gTypeInfoGetTag(ret2)
            assert tag == GITypeTag.INTERFACE
            var iface = gTypeInfoGetInterface(ret2)
            if gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
              iface = gInterfaceInfoGetIfaceStruct(iface)
              methodBuffer.writeLine("  new(result, gobject.genericGObjectUnref)")
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
            else:
              #if gBaseInfoGetType(iface) == GIInfoType.Struct:
              let nMethods = gStructInfoGetNMethods(iface)
              var freeMeName: string
              for j in 0 .. <nMethods:
                let h = $gBaseInfoGetName(gStructInfoGetMethod(iface, j))
                if h.endsWith("free"):
                  freeMeName = "free"
                  break
                elif h.endsWith("unref"):
                  freeMeName = "unref"
                  break
              if freeMeName.isNil:
                # assert false # TODO we have to fix this case manually
                echo "Caution: No free/unref found for ", ' ', gBaseInfoGetName(iface), " (", sym, ')'
                methodBuffer.writeLine("  new(result)")
              else:
                methodBuffer.writeLine("  new(result, $1)" % freeMeName)
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
          else:
            methodBuffer.writeLine("  new(result)")
            methodBuffer.writeLine("  result.impl = " & sym & arglist)
          for k, v in replist:
            let kk = if k[0] == '`': k[1 .. ^2] else: k
            methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), kk]) 
        else:
          if asym == "newFromStreamAsync" and sym.contains("gdk_pixbuf_animation_new"):
            asym = "newAnimationFromStreamAsync"
          methodBuffer.writeLine("\nproc " & asym & EM & plist & " =")
          if gCallableInfoCanThrowGerror(minfo):
            methodBuffer.writeLine("  var gerror: ptr Error00")
            arglist.insert(", addr gerror", arglist.high)
          for k, v in replist:
            let kk = if k[0] == '`': k[1 .. ^2] else: k
            methodBuffer.writeLine("  var $1_00 = $2($3)" % [kk, v, k])
          if isString(ret2):
            methodBuffer.write("  let resul0 = ")
            methodBuffer.writeLine(sym & arglist)
            methodBuffer.writeLine("  result = $resul0")
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif (replist.len > 0 or gCallableInfoCanThrowGerror(minfo)) and genRec(ret2) != "void":
            methodBuffer.write("  result = ")
            if ct2nt.contains(genRec(ret2)):
              methodBuffer.writeLine(ct3nt(genRec(ret2)) & '('  & sym & arglist & ')')
            else:
              methodBuffer.writeLine(sym & arglist)
          elif ct2nt.contains(genRec(ret2)):
            methodBuffer.writeLine("  " & ct3nt(genRec(ret2)) & '('  & sym & arglist & ')')
          else:
            methodBuffer.writeLine("  " & sym & arglist)
          for k, v in replist:
            let kk = if k[0] == '`': k[1 .. ^2] else: k
            methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), kk])
        if gCallableInfoCanThrowGerror(minfo):
          methodBuffer.writeLine("  if gerror != nil:")
          methodBuffer.writeLine("    let msg = $gerror.message")
          methodBuffer.writeLine("    g_error_free(gerror)")
          methodBuffer.writeLine("    raise newException(GException, msg)")
      else:
        (plist, arglist, replist) = genP(mInfo, genProxy, info)
        if asym != "errorQuark" and asym != "getPlugin" and asym != "quark":
          methodBuffer.write("\nproc " & asym & EM & plist)
          methodBuffer.writeLine(" {.\n    importc: \"", sym, "\", ", libprag, ".}")
    if sym == "gtk_window_set_default_size":
      methodBuffer.writeLine("\nproc `defaultSize=`*(self: Window; dim: tuple[width: int; height: int]) =")
      methodBuffer.writeLine("  gtk_window_set_default_size(cast[ptr Window00](self.impl), int32(dim[0]), int32(dim[1]))")

    if sym == "g_object_unref":
      methodBuffer.writeLine("\nproc genericGObjectUnref*[T](self: T) =")
      methodBuffer.writeLine("  g_object_unref(cast[ptr Object00](self.impl))")

  except UndefEx:
    echo "delay ", sym#, delayedMethods.len
    processedFunctions.excl(sym)
    delayedMethods.add((info, minfo))
    methodBuffer.cut(p)

proc writeUnion(info: GIUnionInfo) =
  if not suppressType:
    output.writeLine("type")
  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM, " = object {.union.}")
  let n = info.gUnionInfoGetNFields()
  for j in 0 .. <n:
    let field = info.gUnionInfoGetField(j)
    let name = manglename(gBaseInfoGetName(field)) & EM
    let t = gFieldInfoGetType(field)
    output.writeLine("    ", name, ": ", genRec(t))
  output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object")
  output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")

  if mangleName(gBaseInfoGetName(info)) == "Event" and moduleNamespace == "gdk":
    output.writeLine("type")
    output.writeLine("  SomeEvent* = Event | EventButton | EventMotion | EventTouch | EventScroll | EventCrossing | EventTouchpadSwipe | EventTouchpadPinch")

  let nMethods = gUnionInfoGetNMethods(info)
  #for j in 0 .. <nMethods:
  #  let mInfo =  gUnionInfoGetMethod(info, j)
  #  writeMethod(info, minfo)

  var mseq = newSeq[GIFunctionInfo]()
  var freePos = -1
  for j in 0 .. <nMethods:
    mseq.add(gUnionInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gUnionInfoGetMethod(info, j)) == "free":
      freePos = j
    if freePos < 0 and gBaseInfoGetName(gUnionInfoGetMethod(info, j)) == "unref":
      freePos = j
  if freePos > 0: swap(mseq[0], mseq[freePos])
  for mInfo in mseq:
    writeMethod(info, minfo)

proc writeStruct(info: GIStructInfo) =
  if not suppressType:
    output.writeLine("type")
  if callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " {.pure, byRef.} = object")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " {.pure.} = object")
  let n = info.gStructInfoGetNFields()
  for j in 0 .. <n:
    let field = info.gStructInfoGetField(j)
    let name = manglename(gBaseInfoGetName(field)) & EM
    let t = gFieldInfoGetType(field)
    output.writeLine("    ", name, ": ", genRec(t))
    # let tag = gTypeInfoGetTag(t) # XXX: gFieldInfoGetSize() is always zero!
    #if typeTagIsBasic(tag):
    # echo "XXXXXXXXXXXXX",  gFieldInfoGetOffset(field)
    # echo "XXXXXXXXXXXXX",  gFieldInfoGetSize(field)
  #if mangleName(gBaseInfoGetName(info)) != "TextIter":
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object")
    output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
  let nMethods = gStructInfoGetNMethods(info)
  var mseq = newSeq[GIFunctionInfo]()
  var freePos = -1
  for j in 0 .. <nMethods:
    mseq.add(gStructInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gStructInfoGetMethod(info, j)) == "free":
      freePos = j
    if freePos < 0 and gBaseInfoGetName(gStructInfoGetMethod(info, j)) == "unref":
      freePos = j
  if freePos > 0: swap(mseq[0], mseq[freePos])
  for mInfo in mseq:
    writeMethod(info, minfo)

proc writeInterface(info: GIInterfaceInfo) =
  if not suppressType:
    output.writeLine("type")
  # we made interfaces a gobject now...
  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " = object of gobject.Object00")
  output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object of gobject.Object")
  #output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " {.pure.} = object")
  #output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object")
  #output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
  let nMethods = gInterfaceInfoGetNMethods(info)
  for j in 0 .. <nMethods:
    let mInfo =  gInterfaceInfoGetMethod(info, j)
    writeMethod(info, minfo)

# the EventMask enum is very special, so we use a separate proc for it
proc writeEventMask(info: GIEnumInfo) =
  type T = tuple[v: int64; n: string]
  var s = newSeq[T]()
  var alias = newSeq[string]()
  var flags = ($gBaseInfoGetName(info)).endsWith("Mask")
  output.writeLine("type")
  let n = info.gEnumInfoGetNValues()
  for j in 0 .. <n:
    let value = info.gEnumInfoGetValue(j)
    let name = ($mangleName(gBaseInfoGetName(value)))[0 .. ^5]
    let v = gValueInfoGetValue(value)
    if bitops.popCount(v) == 1:
      s.add((v, name))
  s.sort do (x, y: T) -> int:
    result = cmp(x.v, y.v)
    if result == 0:
      result = cmp(x.n, y.n)
  for j in 0 .. s.high:
    if s[j].v < 0: flags = false
    if j == 0 and s[j].v == 0: continue
    #if bitops.popCount(s[j].v) != 1:  flags = false
  if s.len <= 1:  flags = false
  var tname = mangleName(gBaseInfoGetName(info))
  if flags: tname = tname[0 .. ^5]
  if flags:
    #output.writeLine("  ", tname & "Flag" & EM, " {.size: sizeof(cint), pure.} = enum")
    output.writeLine("  ", tname & "Flag" & EM, " {.size: sizeof(cint), pure.} = enum")
    if s[0].v != 1 and s[1].v != 1:
      output.writeLine("    ignoreThisDummyValue = 0")
  else:
    output.writeLine("  ", tname & EM, " {.size: sizeof(cint), pure.} = enum")
  var k: T
  for j in 0 .. s.high:
    let i = s[j]
    var val = i.v
    if flags and j == 0 and val == 0: continue
    if j > 0 and i.v == k.v:
      if i.n != k.n:
        alias.add("  " & tname & i.n.capitalizeAscii  & EM & " = " & tname  & '.' & k.n)
      continue
    if flags: val = countTrailingZeroBits(val) # firstSetBit(val)
    output.writeLine("    ", i.n, " = ", val)
    k = i
  if alias.len > 0:
    output.writeLine("\nconst")
    for i in alias:
      output.writeLine(i)
  if flags:
    output.writeLine("\n  ", tname & "Mask" & EM, " {.size: sizeof(cint).} = set[$1Flag]" % [tname])
  let nMethods = gEnumInfoGetNMethods(info)
  ###assert(nMethods <= 0)
  assert(flags)
  for j in 0 .. <nMethods:
    let mInfo =  gEnumInfoGetMethod(info, j)
    writeMethod(info, minfo)

proc writeEnum(info: GIEnumInfo) =
  if mangleName(gBaseInfoGetName(info)) == "EventMask":
    writeEventMask(info)
    return
  type T = tuple[v: int64; n: string]
  var s = newSeq[T]()
  var alias = newSeq[string]()
  var flags = ($gBaseInfoGetName(info)).endsWith("Flags")
  output.writeLine("type")

  let n = info.gEnumInfoGetNValues()
  for j in 0 .. <n:
    let value = info.gEnumInfoGetValue(j)
    let name = mangleName(gBaseInfoGetName(value))
    let v = gValueInfoGetValue(value)
    s.add((v, name))
    ###output.writeLine("    ", name, " = ", v)
  # let m = info.gEnumInfoGetNMethods() # XXX this does not work!
  # if m > 0: echo "EnumM: ", m, gBaseInfoGetName(info)
  # for i in 0 .. <m:
  #   let x = gEnumInfoGetMethod(info, m)
  #   if x != nil:
  #    echo gFunctionInfoGetFlags(x)
  #    echo gCallableInfoGetNArgs(x)
  # genProc(gEnumInfoGetMethod(info, m))
  s.sort do (x, y: T) -> int:
    result = cmp(x.v, y.v)
    if result == 0:
      result = cmp(x.n, y.n)
  for j in 0 .. s.high:
    if s[j].v < 0: flags = false
    if j == 0 and s[j].v == 0: continue
    if bitops.popCount(s[j].v) != 1:  flags = false
  if s.len <= 1:  flags = false
  var tname = mangleName(gBaseInfoGetName(info))
  if flags: tname = tname[0 .. ^6]
  if flags:
    output.writeLine("  ", tname & "Flag" & EM, " {.size: sizeof(cint), pure.} = enum")
    if s[0].v != 1 and s[1].v != 1:
      output.writeLine("    ignoreThisDummyValue = 0")
  else:
    output.writeLine("  ", tname & EM, " {.size: sizeof(cint), pure.} = enum")
  var k: T
  for j in 0 .. s.high:
    let i = s[j]
    var val = i.v
    if flags and j == 0 and val == 0: continue
    if j > 0 and i.v == k.v:
      if i.n != k.n:
        alias.add("  " & tname & i.n.capitalizeAscii  & EM & " = " & tname  & '.' & k.n)
      continue
    if flags:
      val = countTrailingZeroBits(val) # firstSetBit(val)
    output.writeLine("    ", i.n, " = ", val)
    k = i
  if alias.len > 0:
    output.writeLine("\nconst")
    for i in alias:
      output.writeLine(i)
  if flags:
    output.writeLine("\n  ", tname & "Flags" & EM, " {.size: sizeof(cint).} = set[$1Flag]" % [tname])
  let nMethods = gEnumInfoGetNMethods(info)
  ###assert(nMethods <= 0)
  for j in 0 .. <nMethods:
    let mInfo =  gEnumInfoGetMethod(info, j)
    writeMethod(info, minfo)

proc writeObj(info: GIObjectInfo) =
  assert(gBaseInfoGetType(info) == GIInfoType.OBJECT)
  let ninterfaces = info.gObjectInfoGetNInterfaces
  let class = gObjectInfoGetClassStruct(info)
  let n = info.gObjectInfoGetNFields
  let parent = gObjectInfoGetParent(info) # nil for Object of module gobject!
  var pname: string
  var oof: string
  var ns: string
  var cnt: int
  if parent.isNil:
    assert(gBaseInfoGetName(info) == "Object" or gBaseInfoGetName(info) == "ParamSpec")
    oof = "{.inheritable, pure.} = object"
    ns = ""
    pname = ""
    cnt = 0
  else:
    cnt = 1
    oof = " = object of "
    pName = manglename(gBaseInfoGetName(parent))
    if ct.hasKey(pname):
      cnt = ct[pname]
    ns = ($gBaseInfoGetNamespace(parent)).toLowerAscii
    if ns == moduleNamespace: ns = "" else: ns.add('.')
    if ns == "gio." and gBaseInfoGetName(info) == "Application": # a few special cases for gtk.nim
      cnt = 9
    if ns == "gio." and gBaseInfoGetName(info) == "MountOperation":
      cnt = 9
    if ns == "gio." and gBaseInfoGetName(info) == "NumerableIcon":
      cnt = 9
    if moduleNamespace == "gtksource" and gBaseInfoGetName(info) == "Buffer":
      cnt = 9
    if moduleNamespace == "gtksource" and gBaseInfoGetName(info) == "Mark":
      cnt = 9
    if moduleNamespace == "gtksource" and gBaseInfoGetName(info) == "CompletionInfo":
      cnt = 9
    if moduleNamespace == "gtksource" and gBaseInfoGetName(info) == "View":
      cnt = 9
  if not suppressType:
    output.writeLine("type")
  if ns == "" and pname != "": # check forward exeption for parent name!
    discard mangleType(pname)
  if mangleName(gBaseInfoGetName(info)) == "Object" and moduleNamespace == "gobject":
    discard
  elif gBaseInfoGetName(info) == "ParamSpec":
    output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object of RootRef")
    output.writeLine("    impl*: ptr ParamSpec00")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & EM & " = ref object of " & ns & pname)
  if pname != "": pname.add("00")
  output.writeLine("  ", mangleName(gBaseInfoGetName(info))  & "00" & EM, oof, ns & $pname)
  if mangleName(gBaseInfoGetName(info)) != "InitiallyUnowned":
    for j in 0 .. <n:
      let field = info.gObjectInfoGetField(j)
      var name = mangleName(gBaseInfoGetName(field))
      if privStr.contains(name) and cnt > 0:
        renumber(name, cnt)
      else:
        name.add(EM)
      let t = gFieldInfoGetType(field)
      let h = genRec(t)
      if j == 0 and parent != nil:
        continue
      output.writeLine("    ", name, ": ", h)
  if mangleName(gBaseInfoGetName(info)) == "Object" and moduleNamespace == "gobject":
    output.writeLine("type")
    output.writeLine("  GToggleNotify* = proc (data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.}\n")
    output.writeLine("proc g_object_add_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.")
    output.writeLine("    importc: \"g_object_add_toggle_ref\", libprag.}")
    output.writeLine("proc g_object_remove_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.")
    output.writeLine("    importc: \"g_object_remove_toggle_ref\", libprag.}")
    output.writeLine("\nproc g_object_set_qdata*(self: ptr Object00; quark: uint32; p: pointer) {.")
    output.writeLine("    importc: \"g_object_set_qdata\", libprag.}")
    output.writeLine("proc toggleNotify*(data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.} =")
    output.writeLine("  if isLastRef.int == 0:")
    output.writeLine("    GC_ref(cast[RootRef](data))")
    ###output.writeLine("    echo \"GC_ref(cast[RootRef](data)\"")
    output.writeLine("  else:")
    output.writeLine("    GC_unref(cast[RootRef](data))")
    ###output.writeLine("    echo \"GC_unref(cast[RootRef](data)\"")
    ###output.writeLine("  echo \"toggleNotify\"")
    ###output.writeLine("  echo obj.ref_count")
    output.writeLine("\nproc finalizeGObject*[T](o: T) =")
    ###methodBuffer.writeLine("  echo(\"finalizeGObject\")")
    output.writeLine("  g_object_remove_toggle_ref(o.impl, toggleNotify, addr(o[]))")

  let numsig = info.gObjectInfoGetNSignals
  if numsig > 0: output.writeLine("")
  for j in 0 .. <numsig:
    let signalInfo = gObjectInfoGetSignal(info, j)
    let c = gSignalInfoGetClassClosure(signalInfo)
    if not c.isNil: echo "maybe we should process class closures!"
    if gBaseInfoGetName(signalInfo) == "notify":
      continue # XXX fix later
    var h = genP(signalInfo, false)[0][1..^1]
    let zzzu = gCallableInfoGetReturnType(signalinfo)
    if gCallableInfoGetNArgs(signalInfo) > 0 or gTypeInfoGetTag(zzzu) != GITypeTag.VOID:
      var memo = ""
      memo.add(gCallableInfoGetNArgs(signalInfo))
      memo.add('|')
      var plist, arglist: string
      var replist: TableRef[string, string]
      (plist, arglist, replist) = genP(signalInfo, true, info)
      memo.add(plist)
      memo.add('|')
      (plist, arglist, replist) = genP(signalInfo, false, info)
      memo.add(plist)
      memo = memo.replace("\n  ", "")
      supmod.writeLine("    \"" & ($gBaseInfoGetName(signalInfo)).replace("-", "_") & "|" & $gBaseInfoGetName(info) & "|" & memo & "\",")
    if gCallableInfoGetNArgs(signalInfo) > 0:
      var plist, arglist: string
      var replist: TableRef[string, string]
      (plist, arglist, replist) = genP(signalInfo, false, nil)
      echo plist
      echo arglist
      if replist.len > 0:
        for k, v in replist:
          stdout.write(k & "--" & v & " ")
        stdout.writeLine("")
      echo "PPP ", gBaseInfoGetName(signalInfo), gCallableInfoGetNArgs(signalInfo)
      h = h.replace(")", "; xdata: pointer)")
    else:
      h = h.replace(")", "xdata: pointer)")
    var xxx = mangleName(gBaseInfoGetName(info))
    output.write("proc " & mangleName("sc_" & $gBaseInfoGetName(signalInfo)) & EM & "(self: " & xxx & "; ")
    if gCallableInfoGetNArgs(signalInfo) > 0 or gTypeInfoGetTag(zzzu) != GITypeTag.VOID:
      output.writeLine(" p: proc (self: ptr " & xxx & "00; " & h & " {.cdecl.}, xdata: pointer = nil): culong =")
    else:
      output.writeLine(" p: proc (self: ptr gobject.Object00; " & h & " {.cdecl.}, xdata: pointer = nil): culong =")
    output.write("  g_signal_connect_data(self.impl, \"")
    output.write($gBaseInfoGetName(signalInfo))
    output.writeLine("\", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))")
  let nMethods = gObjectInfoGetNMethods(info)
  for j in 0 .. <nMethods:
    let mInfo =  gObjectInfoGetMethod(info, j)
    writeMethod(info, minfo)
  if class != nil and not allSyms.contains(mangleName(gBaseInfoGetName(class))):
    classList.add(class)
  ct.inc($gBaseInfoGetName(info), cnt + 1)
  if gBaseInfoGetName(info) == "Object" and moduleNamespace == "gobject":
    output.writeLine("type\n  Object* = ref object of RootRef")
    output.writeLine("    impl*: ptr Object00")

proc extractFromUnion(tag: GITypeTag; arg: GIArgumentObj): string =
  result =
    case tag:
    #of GITypeTag.VOID: $arg.
    of GITypeTag.BOOLEAN: $arg.vBoolean
    of GITypeTag.INT8: $arg.vInt8 & "'i8"
    of GITypeTag.UINT8: $arg.vUint8 & "'u8"
    of GITypeTag.INT16: $arg.vInt16 & "'i16"
    of GITypeTag.UINT16: $arg.vUint16 & "'u16"
    of GITypeTag.INT32: $arg.vInt32 & "'i32"
    of GITypeTag.UINT32: $arg.vUint32 & "'u32"
    of GITypeTag.INT64: $arg.vInt64 & "'i64"
    of GITypeTag.UINT64: $arg.vUint64 & "'u64"
    of GITypeTag.FLOAT: $arg.vFloat & "'f32"
    of GITypeTag.DOUBLE: $arg.vDouble & "'f64"
    #of GITypeTag.GTYPE: $arg.
    of GITypeTag.UTF8: '"' & $arg.vstring & '"'
    #of GITypeTag.FILENAME: $arg.
    #of GITypeTag.ARRAY: $arg.
    #of GITypeTag.INTERFACE: $arg.
    #of GITypeTag.GLIST: $arg.
    #of GITypeTag.GSLIST: $arg.
    #of GITypeTag.GHASH:  $arg.
    #of GITypeTag.ERROR: $arg.
    #of GITypeTag.UNICHAR: $arg.
    else: "XXX"

proc writeConst(info: GIConstantInfo) =
  var tg = ""
  var arg: GIArgumentObj
  let t = gConstantInfoGetType(info)
  let tag = gTypeInfoGetTag(t)
  let s = gConstantInfoGetValue(info, addr(arg)) # TODO: we should check the size s!
  var str = extractFromUnion(tag, arg)
  if str == """"\"""": str = """"\\""""
  var h = $gBaseInfoGetName(info)
  if h.replace("_", "").toLowerAscii == "keych":
    h.add(str[^5])
  if gdkKeys.contains(h.toLowerAscii):
    var s = gdkKeys[h.toLowerAscii]
    if s.len > 1:
      if s.len == 2:
        if h == s[0]:
          tg = "U"
        elif h == s[1]:
           discard
        else:
          assert(false)
      elif s.len == 3: # eth and thorn
        if h == s[0]:
          tg = "X"
        elif h == s[2]:
           discard
        elif h == s[1]:
          tg = "U"
        else:
          assert(false)
    output.writeLine("const ", tg,  h & EM, " = ", str)
  else:
    output.writeLine("const ",  mangleName(h) & EM, " = ", str)

proc processInfo(i: GIBaseInfo) =
  if not isFunctionInfo(i):
    output.write("\n")
  if isCallableInfo(i):
    if isFunctionInfo(i):
      let s = $gFunctionInfoGetSymbol(i)
      if s[^1] != '_' and not processedFunctions.contains(s) and not s.contains("__") and s != "g_type_add_interface_dynamic" and
        s != "g_type_get_plugin" and s != "g_type_register_dynamic":
        writeMethod(nil, i)
    else:
      assert(isCallbackInfo(i))
      if not suppressType:
        output.write("type\n")
      output.writeLine("  ", mangleName(gBaseInfoGetName(i)) & "* = proc " & genP(i)[0] & " {.cdecl.}")
  elif gBaseInfoGetType(i) == GIInfoType.OBJECT:
    writeObj(i)
  elif gBaseInfoGetType(i) == GIInfoType.UNION:
     writeUnion(i)
  elif gBaseInfoGetType(i) == GIInfoType.INTERFACE:
    let h = gInterfaceInfoGetIfaceStruct(i)
    if h != nil:
      writeInterface(i)
  elif gBaseInfoGetType(i) == GIInfoType.STRUCT:
    writeStruct(i)
  elif isEnumInfo(i):
    writeEnum(i)
  elif gBaseInfoGetType(i) == GIInfoType.CONSTANT:
    writeConst(i)
  else: assert(false)

const GDK_EPI = """

proc gdk_window_invalidate_nilrect(self: ptr Window00; rect: ptr Rectangle; invalidateChildren: gboolean) {.
    importc: "gdk_window_invalidate_rect", libprag.}

proc invalidateRect*(self: Window; rect: ptr Rectangle = nil; invalidateChildren: bool = false) =
  gdk_window_invalidate_nilrect(cast[ptr Window00](self.impl), rect, gboolean(invalidateChildren))

proc fixednewCursorFromName*(display: Display; name: string): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), cstring(name))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  #assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

"""

const GIO_EPI = """

proc run*(self: GApplication): int =
  int(g_application_run(cast[ptr GApplication00](self.impl), 0, nil))

"""

const GTK_EPI = """

proc init* =
  var argc: int32 = 0
  var argv: cstringArray = nil
  gtk_init(argc,  argv)

proc loadFromData*(self: CssProvider; data: cstring): bool =
  loadFromData(self, uint8Array(data), -1)

import macros, strutils

include gisup
include gimpl

"""

proc main(namespace: string) =
  priList = newSeq[string]()
  suppressType = false
  suppressRaise = false
  delayedMethods = newSeq[(GIBaseInfo, GIFunctionInfo)]()
  classList = newSeq[GIBaseInfo]()
  output = newStringStream()
  methodBuffer = newStringStream()
  var error: GError
  ct = initCountTable[string]()
  var delayedSyms = newSeq[GIBaseInfo]()
  allSyms = initSet[string]()
  provInt.clear
  interfaceProvider.clear
  var ig = initSet[string]()
  knownSyms = initSet[string]()
  let gi = gIrepositoryGetDefault()
  assert(gi != nil)
  moduleNamespace = namespace.toLowerAscii
  let version: cstring = nil # latest
  let typelib = gi.gIrepositoryRequire(namespace, version, cast[GIRepositoryLoadFlags](0), error)
  if typelib.isNil:
    echo error.message
  let dep: cstringArray = gi.gIrepositoryGetDependencies(namespace)
  output.writeLine("# dependencies:")
  var importedModules = ""
  for j in 0 .. 9:
    if dep[j].isNil: break
    if j == 0:
      importedModules = "import "
    output.writeLine("# ", dep[j])
    importedModules.add(($dep[j]).split('-',2)[0].toLowerAscii & ", ")
  importedModules.removeSuffix(", ")
  strfreev(dep)
  let idep: cstringArray = gi.gIrepositoryGetImmediateDependencies(namespace)
  output.writeLine("# immediate dependencies:")
  for j in 0 .. 9:
    if idep[j].isNil: break
    output.writeLine("# ", idep[j])
  strfreev(idep)
  let libs = gi.gIrepositoryGetSharedLibrary(namespace)

  output.writeLine("# libraries:")
  output.writeLine("# ", libs)
  output.writeLine("{.deadCodeElim: on.}")
  output.writeLine(importedModules)
  var Lib = if libs.isNil: "" else: ($libs).split(',', 2)[0]
  if namespace == "PangoCairo" and Lib.startsWith("libpango-"): Lib = Lib.replace("libpango-", "libpangocairo-") # GI bug?
  output.writeLine("const Lib* = \"$1\"" % Lib)
  output.writeLine("{.pragma: libprag, cdecl, dynlib: Lib.}")
  if namespace == "GObject": # declare array types to make it compile -- procs using these will need special care!
    output.writeLine("type\n  GCallback* = proc () {.cdecl.}")
    output.writeLine("type\n  Parameter00Array* = pointer")
    output.writeLine("type\n  Object00Array* = pointer")
    output.writeLine("type\n  Value00Array* = pointer")
    output.writeLine("type\n  GTypeArray* = pointer")
    output.writeLine("type\n  ParamSpec00Array* = pointer")
    output.writeLine("type\n  TypePlugin00Array* = pointer")
    output.writeLine("type\n  uint32Array* = pointer")
    output.writeLine("type\n  VaClosureMarshal* = pointer")
    output.writeLine("type\n  TypePlugin00* = object")
  elif namespace == "GLib":
    output.writeLine("type\n  GException* = object of Exception")
    output.writeLine("type\n  OptionEntry00Array* = pointer")
    output.writeLine("type\n  int8Array* = pointer")
    output.writeLine("type\n  uintArray* = pointer")
    output.writeLine("type\n  gbooleanArray* = pointer")
    output.writeLine("type\n  cdoubleArray* = pointer")
    output.writeLine("type\n  int32Array* = pointer")
    output.writeLine("type\n  PollFD00Array* = pointer")
    output.writeLine("type\n  Variant00Array* = pointer")
    output.writeLine("type\n  LogField00Array* = pointer")
    output.writeLine("type\n  VariantType00Array* = pointer")
    output.writeLine("type\n  DebugKey00Array* = pointer")
    output.writeLine("type\n  utf8Array* = pointer")
    output.writeLine("type\n  uint8Array* = pointer")
    output.writeLine("type\n  ucstringArray* = pointer")
    output.writeLine("type\n  ucstring* = distinct cstring")
    output.writeLine("type\n  gboolean* = distinct cint")
    output.writeLine("type\n  GType* = distinct cint")
    output.writeLine("type\n  gunichar* = uint32")
    output.writeLine("type\n  utf8* = char")
    output.writeLine("const GFalse = gboolean(0)")
    output.writeLine("const GTrue = gboolean(1)")
    output.writeLine("proc cogfree*(mem: pointer) {.importc: \"g_free\", libprag.}")
    output.writeLine("proc toBool*(g: gboolean): bool = g.int != 0")
  elif namespace == "Gdk":
    output.writeLine("type\n  AtomArray* = pointer")
    output.writeLine("type\n  KeymapKey00Array* = pointer")
    output.writeLine("type\n  VisualTypeArray* = pointer") # enums!
    output.writeLine("type\n  RGBAArray* = pointer")
    output.writeLine("type\n  ColorArray* = pointer")
    output.writeLine("type\n  Point00Array* = pointer")
  elif namespace == "Gtk":
    output.writeLine("type\n  TargetEntry00Array* = pointer")
    output.writeLine("type\n  AccelGroupEntry00Array* = pointer")
    output.writeLine("type\n  BindingArg00Array* = pointer")
    output.writeLine("type\n  StockItemArray* = pointer")
    output.writeLine("type\n  PageRange00Array* = pointer")
    output.writeLine("type\n  PadActionEntry00Array* = pointer")
    output.writeLine("type\n  Array* = pointer")
  elif namespace == "Atk":
    output.writeLine("type\n  StateTypeArray* = pointer") # enums!
    output.writeLine("type\n  TextRange00Array* = pointer")
    output.writeLine("type\n  PtrArray* = pointer")
  elif namespace == "Pango":
    output.writeLine("type\n  GlyphInfo00Array* = pointer")
    output.writeLine("type\n  LogAttr00Array* = pointer")
    output.writeLine("type\n  FontDescription00Array* = pointer")
    output.writeLine("type\n  FontFamily00Array* = pointer")
    output.writeLine("type\n  FontFace00Array* = pointer")
    output.writeLine("type\n  ScriptArray* = pointer") # array of enums!
  elif namespace == "Gio":
    output.writeLine("type\n  ActionEntry00Array* = pointer")
    output.writeLine("type\n  DBusAnnotationInfo00Array* = pointer")
    output.writeLine("type\n  DBusArgInfo00Array* = pointer")
    output.writeLine("type\n  DBusMethodInfo00Array* = pointer")
    output.writeLine("type\n  DBusSignalInfo00Array* = pointer")
    output.writeLine("type\n  DBusPropertyInfo00Array* = pointer")
    output.writeLine("type\n  DBusInterfaceInfo00Array* = pointer")
    output.writeLine("type\n  DBusNodeInfo00Array* = pointer")
    output.writeLine("type\n  InputVector00Array* = pointer")
    output.writeLine("type\n  SocketControlMessage00Array* = pointer")
    output.writeLine("type\n  InputMessage00Array* = pointer")
    output.writeLine("type\n  OutputMessage00Array* = pointer")
    output.writeLine("type\n  utf8ArrayArray* = pointer")
    output.writeLine("type\n  cstringArrayArray* = pointer")
    output.writeLine("type\n  File00Array* = pointer")
    output.writeLine("type\n  Array* = pointer")
    output.writeLine("type\n  OutputVector00Array* = pointer")
  elif namespace == "GtkSource":
    output.writeLine("import glib")
  if namespace == "GObject":
    output.writeLine("\nimport times")
    output.writeLine("var qt = \"NGIQ\" & $epochTime()")
    output.writeLine("if g_quark_try_string(qt) != 0:")
    output.writeLine("  qt = \"NGIQ\" & $epochTime()")
    output.writeLine("let Quark* = g_quark_from_static_string(qt)")
  var n = gi.gIrepositoryGetNInfos(namespace)
  var s = newSeq[GIBaseInfo]()
  for i in 0 ..< n:
    if not droppedSyms.contains(mangleName(gBaseInfoGetName(gi.gIrepositoryGetInfo(namespace, i)))):
      s.add(gi.gIrepositoryGetInfo(namespace, i))
  for i in s:
    if gBaseInfoGetType(i) == GIInfoType.OBJECT or gBaseInfoGetType(i) == GIInfoType.INTERFACE or gBaseInfoGetType(i) == GIInfoType.STRUCT or  gBaseInfoGetType(i) == GIInfoType.UNION or   isEnumInfo(i) or isCallbackInfo(i):
      allSyms.incl(mangleName(gBaseInfoGetName(i)))

  for i in 0 .. s.high:
    if namespace == "GLib" and gBaseInfoGetType(s[i]) == GIInfoType.STRUCT and gBaseInfoGetName(s[i]) == "Error":
      let h = s[i]
      s.delete(i, i)
      s.insert([h])
      break

  for info in s:
    if gBaseInfoGetType(info) == GIInfoType.OBJECT:
      let ninterfaces = info.gObjectInfoGetNInterfaces
      if ninterfaces > 0:
        var interf = newSeq[string]()
        let name = $gBaseInfoGetName(info)

        for i in 0 .. < ninterfaces:
          interf.add($gBaseInfoGetName(info.gObjectInfoGetInterface(i)))

        if provInt.contains(name):
          assert false
        else:
          provInt[name] = interf

  for obj, ifaces in provInt:
    for i in ifaces:
      if not interfaceProvider.contains(i):
        interfaceProvider[i] = @[obj]
      else:
        interfaceProvider[i].add(obj)

  if namespace == "Gdk": # special care for gdk keys due to nim's style insensitivity!
    for i in s:
      var h = $gBaseInfoGetName(i)
      if h.startsWith("KEY_"):
        if gdkKeys.contains(h.toLowerAscii):
          gdkKeys.mget(h.toLowerAscii).add(h)
        else:
          gdkKeys.add(h.toLowerAscii, @[h])
    for el in mvalues(gdkKeys):
      sort(el, system.cmp)
  var i: GIBaseInfo
  var unp = newSeq[GIBaseInfo]()
  reverse(s)
  while s.len > 0:
    if namespace == "GObject" and not knownSyms.contains("g_signal_connect_data"):
      if knownSyms.contains("ClosureNotify") and knownSyms.contains("ConnectFlags"):
        knownSyms.incl("g_signal_connect_data")
        output.writeLine("proc g_signal_connect_data*(instance: pointer; detailedSignal: cstring; cHandler: GCallback;")
        output.writeLine("    data: pointer; destroyData: ClosureNotify; connectFlags: ConnectFlags): culong {.")
        output.writeLine("    importc: \"g_signal_connect_data\", libprag.}")
    while priList.len > 0: # move missing symbols to top, but only once!
      let h = priList.pop
      if ig.contains(h): continue
      ig.incl(h)
      echo h
      var k = -1
      for p, el in s:
        if (gBaseInfoGetType(el) == GIInfoType.OBJECT or gBaseInfoGetType(el) == GIInfoType.INTERFACE or gBaseInfoGetType(el) == GIInfoType.STRUCT or isEnumInfo(el)) and gBaseInfoGetName(el) == h:
         k = p
      if k >= 0:
        echo "moved"
        s.add(s[k])
        s.delete(k)

    i = s.pop
    delayedSyms.insert(i)
    if classList.len > 0:
      delayedSyms.insert(classList.pop)
    unp.setLen(0)
    for k in delayedSyms:
      var pos = output.getPosition
      var supmodpos = supmod.getPosition
      try:
        knownSyms.incl(mangleName(gBaseInfoGetName(k)))
        methodBuffer = newStringStream()
        processInfo(k)
        output.write(methodBuffer.data)
        echo "----------", gBaseInfoGetName(k)
      except UndefEx:
        unp.add(k)
        knownSyms.excl(mangleName(gBaseInfoGetName(k)))
        output.cut(pos)
        supmod.cut(supmodpos)
    delayedSyms = unp
    block myb:
      for a in 1 .. 2: # process clustered symbols into one single type section
        if delayedSyms.len > a:
          suppressType = true
          methodBuffer = newStringStream()
          unp = delayedSyms
          for t in unp.combinations(a + 1):
            var pos = output.getPosition
            var supmodpos = supmod.getPosition
            methodBuffer = newStringStream()
            let x = delayedMethods.len
            try:
              var h = false
              for k in t:
                if gBaseInfoGetType(k) != GIInfoType.OBJECT and  gBaseInfoGetType(k) != GIInfoType.STRUCT and gBaseInfoGetType(k) != GIInfoType.UNION and not isCallbackInfo(k):
                  h = true
              if h: continue
              output.writeLine("type")
              for k in t:
                knownSyms.incl(mangleName(gBaseInfoGetName(k)))
              for k in t:
                processInfo(k)
              for k in t:
                delayedSyms.keepItIf(mangleName(gBaseInfoGetName(k)) != mangleName(gBaseInfoGetName(it)))
              suppressType = false
              output.write(methodBuffer.data)
              break myb
            except UndefEx:
              for k in t:
                knownSyms.excl(mangleName(gBaseInfoGetName(k)))
              output.setPosition(pos)
              supmod.cut(supmodpos)
              assert delayedMethods.len >= x
              delayedMethods.setLen(x)
          suppressType = false

    methodBuffer = newStringStream()
    var h = delayedMethods
    #delayedMethods.setLen(0)
    delayedMethods = newSeq[(GIBaseInfo, GIFunctionInfo)]()
    for el in h:
      writeMethod(el[0], el[1])
    output.write(methodBuffer.data)

  suppressRaise = true
  output.writeLine("# === remaining symbols:") # in best case there is nothing left
  for i in delayedSyms:
    processInfo(i)

  if namespace == "Gtk":
    output.write(GTK_EPI)

  if namespace == "Gio":
    output.write(GIO_EPI)

  if namespace == "Gdk":
    output.write(GDK_EPI)

  output.flush
  var o = open("nim_gi" / (namespace.toLowerAscii) & ".nim", fmWrite)
  o.write(output.data)
  o.close()
  output.close
  echo "Remaining delayed methods: ", delayedMethods.len
  for el in delayedMethods:
    echo gBaseInfoGetName(el[1])

# when isMainModule:
#scfilter = initSet[string]()
supmod = newStringStream()
supmod.writeLine("const\n  SCA = [")
main("fontconfig")
main("freetype2")
main("PangoCairo")
main("PangoFT2")
main("GLib")
main("GObject")
main("GModule")
main("xlib")
main("Gio")
main("Atk")
main("Pango")
## main("cairo") # that file is now hand crafted
main("GdkPixbuf")
main("Rsvg")
main("Gdk")
main("Gtk")
main("GtkSource")

supmod.writeLine("  ]")
supmod.flush
var o = open("nim_gi" / "gisup.nim", fmWrite)
o.write(supmod.data)
o.close()
supmod.close

#for i in callerAllocCollector: echo i
# 1530 lines

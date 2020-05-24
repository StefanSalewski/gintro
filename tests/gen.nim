# High level gobject-introspection based GTK3/GTK4 bindings for the Nim programming language
# nimpretty --maxLineLen:130 gen.nim
# v 0.7.6 2020-MAY-24
# (c) S. Salewski 2018

# https://wiki.gnome.org/Projects/GObjectIntrospection
# https://developer.gnome.org/gi/stable/
# https://mail.gnome.org/archives/gtk-devel-list/2005-April/msg00095.html
# https://ptomato.wordpress.com/2018/11/06/taking-out-the-garbage/
# /usr/share/gir-1.0/GLib-2.0.gir

# you may also compare the currently unmaintained work of
# https://github.com/jdmansour/nim-smartgi

# This module itself is still based on the low level GTK 3.22 wrappers at
# https://github.com/StefanSalewski/oldgtk3
# as those were created with c2nim and work for 32/64 bit and linux, windows and macos

# Currently we intentionally do not free any resources in this generator script!

# First goal was creating low level bindings similar to current oldgtk3. #XXX  DONE
# Then we added the high level wrapper similar as done in Nim's libui wrapper. #XXX Mostly DONE
# What remains is carefully inspecting the generated code, adding special like list/array results
# and of course a lot of testing.

# Known gobject-introspection related issues:
# - gFieldInfoGetSize() is always zero, so we have no bitfield support yet.
# - ParamSpec is reported as object, but has no parent # not really a bug, gst has more gobjects without parent
# - gBaseInfoGetName() is "" for g_iconv() #XXX fixed
# - dirSep is wrong for unix -- that is an already reported gi bug
# missing nullable flag for some functions, see https://discourse.gnome.org/t/missing-nullable-tag-as-in-gtk-css-section-get-file/2814
# - well there are more than 140 open issues about gobject introspection in gnome bugzilla :-(

# This module is really ugly currently  -- the first goal was to get a working gi solution

# NOTE: Currently we support subclassing only for constructor functions like gtk_button_new()

from os import `/`, paramCount
import gir, gobject, glib
import strutils
import sequtils
import streams
import sets
import bitops
import tables
import algorithm
from combinatorics import combinations

template isCallbackInfo(info: untyped): untyped =
  gBaseInfoGetType(info) == GIInfoType.Callback

template isFunctionInfo(info: untyped): untyped =
  gBaseInfoGetType(info) == GIInfoType.Function

template isTypeInfo(info: untyped): untyped =
  gBaseInfoGetType(info) == GIInfoType.Type

#define GI_IS_TYPE_INFO(info) \
#    (g_base_info_get_type((GIBaseInfo*)info) ==  GI_INFO_TYPE_TYPE)

const
  WriteFields = false          # starting with v0.5.3 we do not write the objectfields any more!
  libprag = "libprag"
  EM = "*"
  RecSep = "!"                 # Record separator for entries in gisup.nim, also defined in gimpl.nim
  UnnamedArrayCandidates = ["uint8", "int32", "uint32"]
  UnnamedArrays = UnnamedArrayCandidates.mapIt(it & "Array")
  NamedArrays = ["TargetEntry00Array", "PageRangeArray", "KeymapKeyArray"]
  #NamedArrayCandidates = NamedArrays.mapIt(it.replace("00Array").replace("Array"))
  StringArrayName = "fs469n23" # for seq -- cstringArray conversion
  StringArrayEntries = 16

  keywords = """
addr and as asm bind block break case cast concept const continue converter
defer discard distinct div do elif else end enum except export finally for from func
if import in include interface is isnot iterator let macro method mixin mod
nil not notin object of or out proc ptr raise ref return shl shr static
template try tuple type using var when while xor yield
""".split

  nims = """
int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64 pointer false true string char bool
""".split

proc unCap(s: var string) =
  s[0] = s[0].toLowerAscii

proc unCap(s: string): string =
  result = s
  result[0] = result[0].toLowerAscii

proc firstPart(s: var string) =
  while s.len > 0 and s[^1].isLowerAscii:
    s.setLen(s.len - 1)
  assert(s.len > 1)
  s.setLen(s.len - 1)

proc startsWith(s: string; x: varargs[string]): bool =
  for i in x:
    if s.startsWith(i):
      return true

proc isplit(s: string; start: int): string =
  result = newStringOfCap(s.len * 2)
  var j = start
  for c in s:
    inc(j)
    result.add(c)
    if j > 70 and c == ';':
      j = 0
      result.add("\n   ")

# hope that will work reliable
proc cut(s: var StringStream; pos: int) =
  assert(pos >= 0 and pos <= s.getPosition)
  s.setPosition(pos)
  s.data.setLen(pos)
  s.setPosition(pos)

proc myCamelToSnake(s: cstring): string =
  result.add(s[0].toLowerAscii)
  for i in 1 .. s.high:
    if s[i].isUpperAscii and not s[i - 1].isUpperAscii:
      result.add('_')
    result.add(s[i].toLowerAscii)

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

proc renumber(s: var string; i: int) = # only in use when WriteFields
  if s[^1].isDigit:
    s.insert($i, s.high)
  else:
    s.add($i)

var moduleNamespace: string

var defaultParameters: Table[string, string]
var fixedProcNames: Table[string, string]
var fixedDestroyNames: Table[string, string]
var mangledNames: Table[string, string]
var mangledTypes: Table[string, string]

var allSyms: HashSet[string]
var droppedSyms: HashSet[string]
var privStr: HashSet[string]
var processedFunctions: HashSet[string]
var useTempProcessedFunctions: bool
var tempProcessedFunctions: seq[string]
var knownSyms: HashSet[string]

var gdkKeys: Table[string, seq[string]]
var provInt: Table[string, seq[string]]
var interfaceProvider: Table[string, seq[string]]

var priList: seq[string]
var delayedMethods: seq[(GIBaseInfo, GIFunctionInfo)]
var classList: seq[GIBaseInfo]
var ct: CountTable[string]

var ISGTK3: bool
var suppressType = false
var suppressRaise = false

# fixedDestroyNames.add("gdk_window_create_similar_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_window_create_similar_image_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_cairo_region_create_from_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_cairo_surface_create_from_pixbuf", "cairo.destroy")

fixedProcNames.add("gtk_button_new_with_label", "newButton")
fixedProcNames.add("pango_font_description_from_string", "newFontDescription")
fixedProcNames.add("pango_language_from_string", "languageFromString")
fixedProcNames.add("atk_role_register", "registerAtkRole")
fixedProcNames.add("atk_state_type_register", "registerStateType")
fixedProcNames.add("atk_relation_type_register", "registerRelationType")
fixedProcNames.add("atk_text_attribute_register", "registerTextAttribute")
fixedProcNames.add("atk_role_for_name", "roleForName")
fixedProcNames.add("atk_state_type_for_name", "stateTypeForName")
fixedProcNames.add("atk_relation_type_for_name", "relationTypeForName")
fixedProcNames.add("atk_text_attribute_for_name", "textAttributeForName")
fixedProcNames.add("gtk_settings_get_for_screen", "getSettingsForScreen")
fixedProcNames.add("gtk_icon_theme_get_for_screen", "getIconThemeForScreen")
fixedProcNames.add("gtk_requisition_new", "newRequisition")
fixedProcNames.add("gtk_text_attributes_new", "newTextAttributes")
fixedProcNames.add("pango_script_for_unichar", "scriptForUnichar")
fixedProcNames.add("pango_bidi_type_for_unichar", "bidiTypeForUnichar")
fixedProcNames.add("gsk_shadow_node_get_child", "shadowNodeGetChild")
fixedProcNames.add("gsk_transform_node_get_child", "transformNodeGetChild")
fixedProcNames.add("gtk_settings_get_for_display", "getSettingsForDisplay")
fixedProcNames.add("gtk_icon_theme_get_for_display", "getIconThemeForDisplay")
fixedProcNames.add("gst_element_factory_find", "findElementFactory")

fixedProcNames.add("gtk_shortcut_action_parse_string", "shortcutActionParseString")
fixedProcNames.add("gtk_shortcut_trigger_parse_string", "shortcutTriggerParseString")
fixedProcNames.add("g_main_context_default", "defaultMainContext")

defaultParameters.add("gtk_window_new", "`type` WindowType WindowType.toplevel")
defaultParameters.add("gtk_application_new", "flags gio.ApplicationFlags {}")
defaultParameters.add("gtk_builder_new_from_string", "length int64 -1")
defaultParameters.add("gtk_box_new", "spacing int32 0")

for i in keywords: mangledNames.add(i, '`' & i & '`')

mangledNames.add("CSET_A_2_Z", "CSET_A_2_Z_U")
mangledNames.add("CSET_a_2_z", "CSET_a_2_z_L")
mangledNames.add("2big", "tooBig")
mangledNames.add("2buttonPress", "twoButtonPress")
mangledNames.add("3buttonPress", "threeButtonPress")
mangledNames.add("result", "resu")
mangledNames.add("3d", "d3")
mangledNames.add("2d", "d2")
mangledNames.add("2dAffine", "d2Affine")
mangledNames.add("2dTranslate", "d2Translate")
mangledNames.add("true", "true1")
mangledNames.add("false", "false0")

const someEvent: HashSet[string] = """"
  EventAny EventKey EventButton EventTouch EventScroll EventMotion EventExpose EventVisibility
  EventCrossing EventFocus EventConfigure EventProperty EventSelection EventDND EventProximity EventWindowState EventSetting
  EventOwnerChange EventGrabBroken EventTouchpadSwipe EventTouchpadPinch EventPadButton EventPadAxis EventPadGroupMode
  """.split.toHashSet

proc fixedModName(s: string): string =
  result = s
  if not ISGTK3 and (s == "gdk" or s == "gtk" or s == "gdkX11"):
    result &= "4"

proc gBaseInfoGetName(info: GIBaseInfo): string =
  result = $(gir.gBaseInfoGetName(info))
  let h = $(gir.gBaseInfoGetNamespace(info))
  if h == "Gio" and result == "Application":
    result = "GApplication"

proc mangleName(s: cstring): string =
  result = mysnakeToCamel(s)
  result = mangledNames.getOrDefault(result, result)
  if result == "``":
    # assert(false)
    result = "xxx" # XXX

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
mangledTypes.add("ptr filename", "cstring")
mangledTypes.add("ptr error", "ptr glib.Error")
mangledTypes.add("ptr ghash", "ptr HashTable00")
mangledTypes.add("ptr glist", "ptr pointer")
mangledTypes.add("ptr gslist", "ptr pointer")
mangledTypes.add("ptr utf8", "cstring")

#utf8StringArrays.incl("g_strv_length") # bugs in GIR files # TODO needs investigation
#utf8StringArrays.incl("g_strfreev")
#utf8StringArrays.incl("g_option_context_add_main_entries") # wrong, but not a string array
#utf8StringArrays.incl("g_option_group_add_entries")
#utf8StringArrays.incl("g_strjoinv") # two cstrings!
# utf8StringArrays.incl("g_strv_contains") # two cstrings!

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

# These objects are plain structs like GtkTextIter containing only findamental data types like uint32.
# They are generally allocated on the stack, so there is no alloc or free function offered by gtk.
# If all these conditions are met, then we do not need a proxy object. Caution, some objects like
# TextAttribute has bitfields, which is difficult to map to Nim. Watch for cstrings too!
# For these objects we have to always write the fields. These names are found manually!
const callerAlloc: HashSet[string] = """
gobject.Value
gobject.ValueDataUnion
atk.Rectangle
pango.Color
gtk.PageRange
gdk.KeymapKey
glib.Error
glib.MarkupParser
glib.TimeVal
gtk.TextIter
gdk.Rectangle
gobject.SignalQuery
gobject.TypeQuery
gtk.TreeIter
gtk.StockItem
glib.String
rsvg.PositionData
rsvg.DimensionData
gdk.Color
gdk.Geometry
gtk.Border
atk.TextRectangle
gdk.RGBA
pango.Rectangle
gtk.Requisition
graphene.Size
graphene.Point
graphene.Point3D
graphene.Rect
graphene.Box
graphene.Sphere
graphene.Vec2
graphene.Vec3
graphene.Vec4
graphene.Quaternion
graphene.Quad
graphene.Matrix
graphene.Plane
graphene.Ray
graphene.Euler
#cairo.Matrix
cairo.Rectangle
cairo.RectangleInt
gsk.RoundedRect
""".split.toHashSet

type
  UndefEx = object of CatchableError

proc mangleType(s: cstring): string =
  result = mangleName(s)
  result = mangledTypes.getOrDefault(result, result)
  if allSyms.contains(result) and not knownSyms.contains(result):
    if not suppressRaise:
      priList.add(result)
      raise newException(UndefEx, "forward declaration")
    else:
      echo "!!!", result

var output: StringStream
var supmod3: StringStream
var supmod4: StringStream
var methodBuffer: StringStream
var signalBuffer: StringStream

proc genPars(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil): (
    string, string, TableRef[string, string], string, string)

proc isString(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  tag == GITypeTag.UTF8 or tag == GITypeTag.FILENAME

type GenRecRes = enum none, cstrA, intA0

# recursive investigate that type -- resolve Arrays and Interfaces
proc genRec(t: GITypeInfo; genProxy = false; fullQualified: bool = false): (string, GenRecRes) =
  result[1] = GenRecRes.none
  var rawmark = ""
  var proxyResult = false
  let p = gTypeInfoIsPointer(t)
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.ARRAY:
    let toa = gTypeInfoGetArrayType(t) # type of array
    if toa == GIArrayType.ARRAY: result[0] = "GArray00"
    elif toa == GIArrayType.PTR_ARRAY: result[0] = "PtrArray00"
    elif toa == GIArrayType.BYTE_ARRAY: result[0] = "ByteArray00"
    elif toa == GIArrayType.C:
      let arrayType = gTypeInfoGetParamType(t, 0)
      let arrayFixedSize = gTypeInfoGetArrayFixedSize(t)
      var child = genRec(arrayType)[0]
      child = mangleType(mangleName(child))
      if arrayFixedSize != -1:
        result[0] = "array[$1, $2]" % [$arrayFixedSize, child]
      elif gTypeInfoIsZeroTerminated(t):
        result[0] = child & "Array"
        result[1] = intA0
        return
      else:
        if child in UnnamedArrayCandidates:
          result[1] = intA0 # yes we need this
          result[0] = child & "Array"
          return # we call it Array and return -- so we mark it for now, but it does not really help :-(
        else:
          result[0] = child & "Array"
          return # we call it Array and return -- so we mark it for now, but it does not really help :-(
  elif tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    if gBaseInfoGetType(iface) == GIInfoType.CALLBACK:
      if gBaseInfoGetName(iface)[0].isLowerAscii:
        result[0] = "proc" & genPars(iface)[0] & " {.cdecl.}"
      else:
        result[0] = mangleName(gBaseInfoGetName(iface))
    else:
      var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
      result[0] = mangleName($gBaseInfoGetName(iface))
      if gBaseInfoGetType(iface) in {GIInfoType.Object, GIInfoType.STRUCT, GIInfoType.UNION, GIInfoType.INTERFACE}:
        proxyResult = genProxy
        if not (genProxy or callerAlloc.contains(ns & '.' & result[0])):
          rawmark = "00"
      if fullQualified or ns != moduleNamespace:
        result[0] = fixedModName(ns) & '.' & result[0]
  else:
    result[0] = $gTypeTagToString(tag)
  result[0] = mangleType(result[0])
  if p and (not proxyResult):
    result[0] = "ptr " & result[0]
  result[0] = mangleType(result[0]) & rawmark

proc modPrefix(t: GITypeInfo; sym: string; full = true): string =
  if sym == "gtk_renderer_cell_accessible_new":
    return fixedModName("gtk") & "."
  if sym == "gtk_mount_operation_new":
    return fixedModName("gtk") & "."
  if sym == "gtk_notebook_page_accessible_new":
    return fixedModName("gtk") & "."
  if sym in ["gtk_source_view_new", "gtk_source_view_new_with_buffer", "gtk_source_map_new",
    "gtk_source_style_scheme_chooser_widget_new", "gtk_source_style_scheme_chooser_button_new",
    "gtk_source_tag_new"]:
    return fixedModName("gtksource") & "."
  if full:
    result = fixedModName(moduleNamespace) & "."
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    if gBaseInfoGetType(iface) == GIInfoType.CALLBACK:
      assert false # discard
    else:
      var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
      if ns != moduleNamespace:
        result = fixedModName(ns) & "."

proc isProxyCandidate(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    let ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
    if callerAlloc.contains(ns & '.' & $gBaseInfoGetName(iface)): return false
    result = gBaseInfoGetType(iface) in {GIInfoType.OBJECT, GIInfoType.STRUCT, GIInfoType.UNION, GIInfoType.INTERFACE}

proc needProxyProc(info: GICallableInfo): bool =
  if gCallableInfoIsMethod(info):
    return true
  if manglename(gBaseInfoGetName(info)) in ["free", "unref"]: # we need this for finalizerFree() currently
    return true
  let m = gCallableInfoGetNArgs(info) - 1
  for j in 0.cint .. m:
    let arg = gCallableInfoGetArg(info, j)
    let t = gArgInfoGetType(arg)
    if isProxyCandidate(t):
      return true
  var ret = gCallableInfoGetReturnType(info)
  assert(ret != nil)
  if isFunctionInfo(info):
    if (gFunctionInfoGetFlags(info).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
      let h = gBaseInfoGetContainer(info)
      if gBaseInfoGetType(h) == GIInfoType.OBJECT:
        return true
    return isProxyCandidate(ret)

# type replacements
var ct2nt: Table[string, string]
ct2nt.add("uint32", "int")
ct2nt.add("int32", "int")
ct2nt.add("cstring", "string")
ct2nt.add("gboolean", "bool")
ct2nt.add("cstringArray", "seq[string]")
ct2nt.add("int32Array", "seq[int32]")
ct2nt.add("uint32Array", "seq[uint32]")
ct2nt.add("uint8Array", "seq[uint8]")
ct2nt.add("TargetEntry00Array", "seq[TargetEntry]")
ct2nt.add("KeymapKeyArray", "seq[KeymapKey]")
ct2nt.add("PageRangeArray", "seq[PageRange]")

# converter procs
proc ct3nt(s: string): string =
  case s:
  of "cstring": "$"
  of "gboolean": "toBool"
  of "cstringArray": "cstringArrayToSeq"
  of "TargetEntry00Array": "targetEntryArrayToSeq"
  of "KeymapKeyArray": "keymapKeyArrayToSeq"
  of "PageRangeArray": "pageRangeArrayToSeq"
  else: ct2nt.getOrDefault(s, s)

proc genPars(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil): (
    string, string, TableRef[string, string], string, string) =

  proc makeResul(s: seq[(string, string)]; self, r: string): string =
    result = self
    for i in s:
      result.add(i[0] & ": " & i[1] & "; ")
    if result[^1] == ' ':
      result.setLen(result.len - 2)
    result.add(")")
    result.add(r)

  var arglist: string
  var resul: string
  var self: string = "("
  var resusres: string
  var resus: seq[(string, string)]
  var resusLen = -1
  var resusIn: bool
  var replist = newTable[string, string]()
  var arrLex, blex: string
  var lastName: string
  let m = gCallableInfoGetNArgs(info) - 1
  var sym = ""
  if isFunctionInfo(info):
    sym = $gFunctionInfoGetSymbol(info)
  if binfo.isNil or not gCallableInfoIsMethod(info):
    arglist = "("
  else:
    var ns = ($gBaseInfoGetNamespace(binfo)).toLowerAscii
    if callerAlloc.contains(ns & '.' & manglename(gBaseInfoGetName(binfo))):
      self = "(self: " & manglename(gBaseInfoGetName(binfo)) & "; "
      arglist = "(self"
    else:
      ## only for very few procs the instance variable itself can be NULL in GTK. We assume non NULL and may provide an overload.
      arglist = "(cast[ptr " & manglename(gBaseInfoGetName(binfo)) & "00](" &
          "self.impl)" # https://discourse.gnome.org/t/g-arg-info-may-be-null-for-the-instace-itself/3284/7
      # arglist = "(if self.isNil: nil else: cast[ptr " & manglename(gBaseInfoGetName(binfo)) & "00](" & "self.impl)"
      if genProxy:
        var h = manglename(gBaseInfoGetName(binfo))
        let provider = interfaceProvider.getOrDefault(h, @[])
        if provider.len > 0:
          for i in provider: discard mangleType(i)
          h = h & " | " & provider.join(" | ")
        self = "(self: " & h & "; "
      else:
        self = "(self: ptr " & manglename(gBaseInfoGetName(binfo)) & "00" & "; "
    if m >= 0:
      arglist.add(", ")
  var num = ""
  for j in 0 .. m:
    let arg = gCallableInfoGetArg(info, j)
    let t = gArgInfoGetType(arg)
    let mayBeNil = gArgInfoMayBeNull(arg)
    var str = genRec(t, genProxy and not gArgInfoIsCallerAllocates(arg))[0]
    if (str in UnnamedArrays or str in NamedArrays) and genProxy and not gTypeInfoIsZeroTerminated(t):
      resusLen = gTypeInfoGetArrayLength(t)
      if resusLen >= 0:
        resusIn = gArgInfoGetDirection(gCallableInfoGetArg(info, resusLen.cint)) == GIDirection.IN
      lastName = gBaseInfoGetName(arg)
    if (sym.startsWith("gtk_widget_set_events", "gtk_widget_add_events")) and str == "int32":
      str = fixedModName("gdk") & ".EventMask"
    if isSignalInfo(info) and isProxyCandidate(t) and not genProxy:
      str.insert("ptr ")
    var userAlloc: bool
    var hhh = genRec(t, true, true)[0]
    if hhh.startsWith("gtk4", "gdk4"):
      hhh.delete(3, 3)
    if callerAlloc.contains(hhh):
      userAlloc = true
      str = genRec(t, true)[0]
    if genProxy:
      let tag = gTypeInfoGetTag(t)
      if tag == GITypeTag.INTERFACE:
        let iface = gTypeInfoGetInterface(t)
        if gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
          if interfaceProvider.contains(str):
            let provider = interfaceProvider[str]
            for i in provider: discard mangleType(i)
            str = str & " | " & provider.join(" | ")
            if gArgInfoGetDirection(arg) in {GIDirection.OUT, GIDirection.INOUT}:
              str.insert("(")
              str.add(")")
    # if utf8StringArrays.contains(sym): # https://discourse.gnome.org/t/my-impression-is-that-some-entries-in-the-gir-files-are-just-wrong/1265
    if sym in ["g_strv_length", "g_strfreev"]:
      str = "cstringArray"
    let name = mangleName(gBaseInfoGetName(arg))
    if isProxyCandidate(t) and not gArgInfoIsCallerAllocates(arg) and not userAlloc:
      if mayBeNil and gArgInfoGetDirection(arg) != GIDirection.OUT:
        arglist.add("if " & name & ".isNil: nil else: cast[" & genRec(t, false)[0] & "](" & name & ".impl)")
      else:
        if gArgInfoGetDirection(arg) == GIDirection.OUT:
          arglist.add("cast[var " & genRec(t, false)[0] & "](addr " & name & ".impl)")
        else:
          arglist.add("cast[" & genRec(t, false)[0] & "](" & name & ".impl)")
    else:
      if str in UnnamedArrays and (gArgInfoGetDirection(arg) == GIDirection.IN or gArgInfoIsCallerAllocates(arg)):
        arglist.add("unsafeaddr($1[0])" % name)
      elif (str in NamedArrays or str == "cstringArray") and gArgInfoGetDirection(arg) == GIDirection.IN:
        arglist.add("seq2$1" % [str.replace("00").capitalizeAscii] & '(' & name & ", " & StringArrayName & "$1)" % [num])
        num = "2"
      elif ct2nt.contains(str) and gArgInfoGetDirection(arg) in {GIDirection.OUT, GIDirection.INOUT}:
        arglist.add(name.strip(chars = {'`'}) & "_00")
      elif ct2nt.contains(str):
        if str == "cstring" and mayBeNil:
          arglist.add("safeStringToCString" & '(' & name & ')')
        else:
          if str != "string" and str != "cstring":
            arglist.add(str & '(' & name & ')')
          else:
            arglist.add(name)
      else:
        arglist.add(name)
    if not genProxy and ct2nt.contains(str) and (str != "cstring" or gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT}):
      replist.add($name, $str)
    if genProxy and ct2nt.contains(str):
      if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} and (not gArgInfoIsCallerAllocates(arg) or (str in ["int32",
          "uint32", "cstringArray", "cstring"])):
        replist.add($name, $str)
      if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} or str != "cstring": # new in 0.4.11 -- allow passing cstring if not a var
        str = ct2nt[str]
    if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} and not (str in UnnamedArrays and gArgInfoIsCallerAllocates(arg)):
      str.insert("var ")
    if genProxy and defaultParameters.contains(sym):
      var h1, h2, h3: string
      (h1, h2, h3) = defaultParameters[sym].split
      if name == h1 and str == h2:
        str.add(" = " & h3)
    if genProxy and (str == "string" or str == "cstring") and mayBeNil:
      str.add(" = \"\"")
    if genProxy and m == 0:
      if sym.contains("_set_") and str == "bool":
        str.add(" = true")
    if genProxy and isProxyCandidate(t) and mayBeNil:
      if gArgInfoGetDirection(arg) notin {GIDirection.OUT, GIDirection.INOUT}:
        str.add(" = nil")
    if (genProxy or sym == "pango_extents_to_pixels") and isFunctionInfo(
        info) and (
        gFunctionInfoGetFlags(info).int and
            GIFunctionInfoFlags.WRAPS_VFUNC.ord) == 0:
      if userAlloc and mayBeNil:# or (sym == "gdk_window_set_geometry_hints" and str == "Geometry"): # gir bug!
        var h = str
        h.removePrefix("var ")
        str.add(" = cast[ptr " & h & "](nil)[]")
    if str == "seq[string]":
      if j == m:
        str = "varargs[string, `$`]"
      else:
        str = "openArray[string]"
    if str == "seq[uint8]": # allow to pass a string for a seq[uint8] argument too
      str = "seq[uint8] | string"
    resus.add((name, str))
    if j < m:
      arglist.add(", ")
  if not genProxy and gCallableInfoCanThrowGerror(info):
    resus.add(("error", "ptr ptr glib.Error = nil"))
  arglist.add(')')
  var ret = gCallableInfoGetReturnType(info)
  assert(ret != nil)
  if resusLen < 0 and not gTypeInfoIsZeroTerminated(ret):
    resusLen = gTypeInfoGetArrayLength(ret)
  if isFunctionInfo(info):
    if (gFunctionInfoGetFlags(info).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
      let h = gBaseInfoGetContainer(info)
      if gBaseInfoGetType(h) == GIInfoType.OBJECT:
        if genProxy:
          resusres = ": " & mangleType(mangleName(gBaseInfoGetName(h)))
        else:
          resusres = ": ptr " & mangleType(mangleName(gBaseInfoGetName(h))) & "00"
        if resusLen >= 0:
          blex = resus[resusLen][0]
          if resusIn:
            let h = resus[resusLen][1].replace("var ", "")
            arrLex = "  let $1 = $2($3.len)\n" % [resus[resusLen][0], h, lastName]
            resus.delete(resusLen)
          else:
            assert false
            arrLex = "" #"#??\n"
        resul = makeResul(resus, self, resusres).isplit(sym.len + "proc".len)
        return (resul, arglist, replist, arrLex, blex)
  var r = genRec(ret, genProxy)[0]
  var hhh = genRec(ret, true, true)[0]
  if hhh.startsWith("gtk4", "gdk4"):
    hhh.delete(3, 3)
  if gTypeInfoIsPointer(ret) and callerAlloc.contains(hhh) and (not r.startsWith("ptr")):
    r = "ptr " & r
  if r != "void":
    if genProxy:
      r = ct2nt.getOrDefault(r, r)
    resusres = ": " & r
  if resusLen >= 0:
    blex = resus[resusLen][0]
    if resusIn:
      let h = resus[resusLen][1].replace("var ", "")
      arrLex = "  let $1 = $2($3.len)\n" % [resus[resusLen][0], h, lastName]
      resus.delete(resusLen)
    else:
      arrLex = "" #"#??\n"
  resul = makeResul(resus, self, resusres).isplit(sym.len + "proc".len)
  return (resul, arglist, replist, arrLex, blex)

proc writeMethod(info: GIBaseInfo; minfo: GIFunctionInfo) =

  template gobjectTemp(): untyped =
    assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.NOTHING, EVERYTHING}) # both occur
    methodBuffer.writeLine("  let gobj = " & sym & arglist)
    if gCallableInfoMayReturnNull(minfo):
      methodBuffer.writeLine("  if gobj.isNil:")
      methodBuffer.writeLine("    return nil") # https://github.com/StefanSalewski/gintro/issues/63
    methodBuffer.writeLine("  let qdata = g_object_get_qdata(gobj, Quark)")
    methodBuffer.writeLine("  if qdata != nil:")
    methodBuffer.writeLine("    result = cast[type(result)](qdata)")
    methodBuffer.writeLine("    assert(result.impl == gobj)")
    methodBuffer.writeLine("  else:")
    if sym == "g_object_ref" or sym == "g_object_ref_sink":
      methodBuffer.writeLine("    assert(false)")
      assert false
    else:
      methodBuffer.writeLine("    fnew(result, $1finalizeGObject)" % [mprefix])
      methodBuffer.writeLine("    result.impl = gobj")
      methodBuffer.writeLine("    GC_ref(result)")
      methodBuffer.writeLine("    discard g_object_ref_sink(result.impl)")
      methodBuffer.writeLine("    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))")
      methodBuffer.writeLine("    g_object_unref(result.impl)")
      methodBuffer.writeLine("    assert(g_object_get_qdata(result.impl, Quark) == nil)")
      methodBuffer.writeLine("    g_object_set_qdata(result.impl, Quark, addr(result[]))")

  # prefer gboxed_free() but fall back for GVariant
  template findFreeProc(info: GIBaseInfo; noWarning: bool): untyped =
    if gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT:
      if gBaseInfoGetType(info) == GIInfoType.UNION:
        # assert false executed for gtk3
        freeMe = gUnionInfoFindMethod(info, "free")
        if freeMe.isNil:
          freeMe = gUnionInfoFindMethod(info, "unref")
      else:
        assert gBaseInfoGetType(info) == GIInfoType.STRUCT
        freeMe = gStructInfoFindMethod(info, "free")
        if freeMe.isNil:
          freeMe = gStructInfoFindMethod(info, "unref")
      if freeMe == nil:
        if fixedDestroyNames.contains(sym):
          assert false
          freeMeName = fixedDestroyNames[sym]
      else:
        assert (not fixedDestroyNames.contains(sym))
        freeMeName = "finalizer" & $gBaseInfoGetName(freeMe)
      if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE and gTypeFundamental(gRegisteredTypeInfoGetGType(info)) == G_TYPE_BOXED:
        boxedFreeMeName = "gBoxedFree" & $gRegisteredTypeInfoGetTypeName(info)
      else:
        boxedFreeMeName = ""
      if gBaseInfoGetName(info) == "VariantType": # there is no g_variant_get_type()
        boxedFreeMeName = ""
      if boxedFreeMeName == "" and not noWarning:
        if freeMeName == "":
          echo "Caution: No free/unref found for ", ' ', " (", sym, ')'
        else:
          if gBaseInfoGetName(info) notin ["Variant", "VariantType"]: # seems for glib.GVariant we have to guess -- or maybe just know
            echo "Caution: Do guess  free/unref for ", ' ', " (", sym, ')'
      if boxedFreeMeName == "gBoxedFreeGVariantType": # this does not work
        assert false

    if gBaseInfoGetType(info) == GIInfoType.Object:
      assert(gObjectInfoGetFundamental(info) == GTrue)
      var parent = info
      while true:
        let h = g_object_info_get_parent(parent)
        if h == nil:
          break
        parent = h
      boxedFreeMeName = ""
      freeMeName = "generic_" & $g_object_info_get_unref_function(parent)
      assert(freeMeName != "")

  # assert(info != nil) # why can it be nil?
  assert(isCallableInfo(mInfo))
  assert(isFunctionInfo(mInfo))
  var plist, arglist, arrLex, blex: string
  var replist: TableRef[string, string]
  let p = methodBuffer.getPosition
  let sym = $gFunctionInfoGetSymbol(mInfo)
  let symIsDeprecated = gBaseInfoIsDeprecated(mInfo).int != 0
  var depStr = ""
  if symIsDeprecated:
    depStr = " {.deprecated.} "
  if sym[^1] == '_': return
  if sym.contains("__"): return
  if processedFunctions.contains(sym): return

  # The following functions work with arrays, we should check each carefully -- some may not compile...
  #if sym == "g_io_channel_read_to_end": return # fix later
  if sym == "g_boxed_free": return # this is manually added at early position already
  if sym == "gst_param_spec_fraction": return # fix later
  if sym == "gst_param_spec_array": return # fix later
  if sym == "gst_message_new_state_changed": return # fix later
  if sym == "gst_mini_object_replace": return # fix later
  if sym == "gst_mini_object_take": return # fix later
  if sym == "gst_object_replace": return # fix later
  if sym == "g_base64_decode_inplace": return # fix later
  if sym == "g_base64_encode_close": return # fix later
  if sym == "g_base64_encode_step": return # fix later
  if sym == "g_compute_hmac_for_data": return # fix later
  if sym == "g_file_get_contents": return # fix later
  if sym == "g_spawn_command_line_sync": return # fix later
  if sym == "g_spawn_sync": return # fix later
  if sym == "g_file_load_contents": return # fix later
  #if sym == "g_file_load_contents_finish": return # fix later
  if sym == "g_file_load_partial_contents_finish": return # fix later
  if sym == "g_converter_convert": return # fix later
  if sym == "gdk_pixbuf_save_to_bufferv": return # fix later
  if sym == "pango_font_face_list_sizes": return # fix later
  #if sym == "pango_layout_line_get_x_ranges": return # fix later
  if sym == "pango_tab_array_get_tabs": return # too complicated!
  if sym == "pango_coverage_to_bytes": return # fix later
  if sym == "gdk_property_get": return # hard, length before array
  if sym == "gdk_query_depths": return # fix later
  if sym == "gtk_icon_set_get_sizes": return # fix later
  if sym == "gtk_list_store_insert_with_valuesv": return # fix later
  if sym == "gtk_list_store_set_valuesv": return # fix later
  if sym == "gtk_tree_store_insert_with_valuesv": return # fix later
  if sym == "gtk_tree_store_set_valuesv": return # fix later
  if sym == "gtk_accelerator_parse_with_keycode": return # zero terminated uint32Array
  if sym == "gdk_keymap_get_entries_for_keycode": return # var uint32Array
  if sym == "gtk_text_iter_copy": return
  if sym == "gtk_widget_destroyed": return
  if sym == "g_error_new_literal": return
  if sym == "gtk_selection_data_get_targets": return
  if sym == "g_strfreev": return
  if sym == "g_signal_emitv": return
  if sym == "g_object_ref": return # supress Hint: 'g_object_ref' is declared but not used

  try:
    (plist, arglist, replist, arrLex) = genPars(mInfo, false, info)
    processedFunctions.incl(sym)
    if not sym.startsWith("g_param_spec_uref"):
      if sym.startsWith("g_param_spec_", "g_type_interface_", "g_object_interface_"): return
    if sym in ["gtk_widget_class_find_style_property", "gtk_container_class_find_child_property",
      "gtk_cell_area_class_find_cell_property"]: return
    var asym = manglename(gBaseInfoGetName(mInfo))
    if asym == "errorQuark" or asym == "quark": return
    if (moduleNameSpace == "gst" and asym in ["appendAndTakeValue", "appendValue", "getSize", "getValue", "prependValue"]) or
      asym in ["get", "getDefault", "from", "fromString", "getInfo", "listFree", "register", "find", "getList"]:
      # or # maybe we should relax this later a bit for the case that first parameter type == gBaseInfoGetName(info)
      asym.add($manglename(gBaseInfoGetName(info)))
    if sym == "gtk_buildable_get_name": asym = "buildableGetName" # conflict with gtk_widget_get_name()
    if sym == "gtk_buildable_set_name": asym = "buildableSetName"
    if keywords.contains(asym) or nims.contains(asym):
      asym.add('P')
    var ret2 = gCallableInfoGetReturnType(minfo)
    let mprefix = modPrefix(ret2, sym)
    if moduleNameSpace == "graphene" and gCallableInfoGetNArgs(minfo) == 0 and not gCallableInfoIsMethod(minfo):
      asym.add($manglename(gBaseInfoGetName(info)))
    for run in 0 .. 1:
      if run == 1: # try without get prefix and replace set prefix with `=`
        if fixedProcNames.contains(sym): continue
        if not (asym.startsWith("get", "set")) or asym == "getPlugin" or asym.len < 4:
          continue
        if asym.startsWith("get") and gTypeInfoGetTag(ret2) == GITypeTag.VOID:
          continue
        if asym.startsWith("set"):
          if gCallableInfoGetNArgs(minfo) > 2:
            continue
          if gCallableInfoIsMethod(minfo) and gCallableInfoGetNArgs(minfo) > 1:
            continue
        if asym.startsWith("get"):
          asym = asym[3 .. ^1].unCap
        if asym.startsWith("set"):
          asym = asym[3 .. ^1].unCap
          asym = '`' & asym & '=' & '`'
        if keywords.contains(asym) or nims.contains(asym): continue
      # the large proxy block BLOCK7 {
      let b7 = needProxyProc(mInfo) or isString(ret2) or replist.len > 0 or ct2nt.contains(genRec(ret2)[0])
      # export only low level symbols that are needed internally -- maybe we should export only a private name for them
      if run == 0:
        if sym in ["g_quark_from_static_string", "g_error_free", "g_object_get_qdata", "g_object_ref_sink", "g_object_unref",
          "g_timeout_add_full",
          "g_type_from_name", "g_type_check_instance_is_a", "g_idle_add_full", "g_quark_try_string", "vte_regex_unref",
          "gtk_builder_get_object"]:
          methodBuffer.write("\nproc " & sym & EM & plist)
          methodBuffer.writeLine(" {.\n    importc, ", libprag, ".}")
          if sym.startsWith("vte_regex_unref"): # this function is special, as it returns the object
            methodBuffer.writeLine("\nproc unref*(self: Regex) =")
            methodBuffer.writeLine("  discard vte_regex_unref(cast[ptr Regex00](self.impl))")
            return
        elif b7:
          methodBuffer.write("\nproc " & sym & plist)
          methodBuffer.writeLine(" {.\n    importc, ", libprag, ".}")
        if sym in ["g_object_ref_sink", "g_object_ref"]:
          return
      if b7:
        var isGObject = false
        let tag = gTypeInfoGetTag(ret2)
        if tag == GITypeTag.INTERFACE:
          let iface = gTypeInfoGetInterface(ret2)
          #if gBaseInfoGetType(iface) == GIInfoType.Object and gBaseInfoGetName(iface) != "ParamSpec":
          if gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse:
            isGObject = true
        (plist, arglist, replist, arrLex, blex) = genPars(mInfo, true, info)
        var sss = ""
        let num = max([arglist.count("seq2CstringArray"), arglist.count("seq2TargetEntryArray"), arglist.count(
            "seq2PageRangeArray"), arglist.count("seq2KeymapKeyArray")])
        for i in 1 .. num:
          let h = if i == 1: "" else: $i
          sss &= "  var $1$3x: array[$2, pointer]\n" % [StringArrayName, $StringArrayEntries, h] &
                       "  var $1$2: cstringArray = cast[cstringArray](addr $1$2x)\n" % [StringArrayName, h]
        if asym.len > 2 and asym[^2] == '=':
          plist = plist.replace(": bool = true", ": bool")
        if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0 or isProxyCandidate(ret2):
          if info != nil:
            asym = asym.replace("new", "new" & manglename(gBaseInfoGetName(info)))
        asym = fixedProcNames.getOrDefault(sym, asym)
        # BLOCKMARK8 : 3 cases: constructor, isProxyCandidate(ret2), plain else
        if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
          assert replist.len == 0 # ok it's a fact for constructors, so we don't have to generate code for it
          for j in 0.cint ..< gCallableInfoGetNArgs(minfo):
            let arg = gCallableInfoGetArg(minfo, j)
            assert gArgInfoGetDirection(arg) notin {GIDirection.OUT, INOUT} # so we can ignore this case!
          for itt in 0 .. 2: # generate the new(), the new(typedesc) and the init() proc
            var hhh = "\nproc " & asym & EM & plist
            if itt == 1: # new(typedesc)
              let semi = if hhh.contains("()"): "" else: "; "
              let p = hhh.find("): ")
              hhh.setLen(p + 1)
              hhh = hhh.replace("*(", "*(tdesc: typedesc" & semi)
              hhh.add(": tdesc")
            if itt == 2: # init(), deprecated
              let semi = if hhh.contains("()"): "" else: "; "
              let p = hhh.find("): ")
              hhh.setLen(p + 1)
              hhh = hhh.replace("new", "init")
              hhh = hhh.replace("*(", "*[T](result: var T" & semi)
            if itt == 2:
              depStr = " {.deprecated.}"
            methodBuffer.writeLine(hhh & depStr & " =")
            methodBuffer.write(arrLex)
            methodBuffer.write(sss)
            if gCallableInfoCanThrowGerror(minfo):
              methodBuffer.writeLine("  var gerror: ptr glib.Error")
              if itt == 0: arglist.insert(", addr gerror", arglist.high)
            if itt == 1 or itt == 2:
              methodBuffer.writeLine("  assert(result is $1)" % [manglename(gBaseInfoGetName(info))])
            if isGObject:
              # CAUTION: some procs are advertised as constructor but do not construct new objects,
              # they just return existing ones as gdk_cursor_new_from_name()
              gobjectTemp()
              if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0 and
                gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING:
                methodBuffer.writeLine("  result.ignoreFinalizer = true") # as we have always to attach one with ARC.
            elif gCallableInfoGetCallerOwns(minfo) == GITransfer.CONTAINER:
              assert false
            elif gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING or #: ###################
              gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING: # and gBaseInfoGetName(info) == "Variant":
              if false: #sym == "g_closure_new_simple":
                let nMethods = gStructInfoGetNMethods(info)
                for j in 0.cint ..< nMethods:
                  echo "yes there is unref method! ", $gBaseInfoGetName(gStructInfoGetMethod(info, j))
                #assert(gStructInfoFindMethod(info, "unref") != nil) # TODO GI bug?
              assert info != nil
              var freeMe: GIFunctionInfo
              var freeMeName: string
              var boxedFreeMeName: string
              findFreeProc(info, gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING)
              #if sym == "g_closure_new_simple" or sym == "g_closure_new_object":
              #  freeMeName = "unref" # TODO GI bug?
              #assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
              if false: #i > 0: # with ARC we have no finalizer support for user defined subclasses, so we have to leak mem!
                methodBuffer.writeLine("  new(result)")
              elif boxedFreeMeName != "":
                methodBuffer.writeLine("  fnew(result, $1)" % boxedFreeMeName)
              elif freeMeName == "":
                assert false
                echo "????????", sym
                methodBuffer.writeLine("  new(result)")
              else:
                methodBuffer.writeLine("  fnew(result, $1)" % freeMeName)
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
              #if gBaseInfoGetName(info) == "Variant":
              #  methodBuffer.writeLine("  discard g_variant_ref_sink(result.impl)")
              if ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0 and
                gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING) or
                ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0 and
                gBaseInfoGetName(info) == "Variant"):
                methodBuffer.writeLine("  result.ignoreFinalizer = true") # as we have always to attach one with ARC.
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if result.impl.isNil:")
                methodBuffer.writeLine("    return nil")
            else:
              echo "skipped ", sym
              assert false
              #assert gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING
              #methodBuffer.writeLine("  new(result)")
              #methodBuffer.writeLine("  result.ignoreFinalizer = true")
              #methodBuffer.writeLine("  result.impl = " & sym & arglist)
            #if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0 and
            #  gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING:
            #  methodBuffer.writeLine("  result.ignoreFinalizer = true") # as we have always to attach one with ARC.
            for k, v in replist:
              assert false
              methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), k.strip(chars = {'`'})])
        elif isProxyCandidate(ret2): # BLOCKMARK8
          assert (gCallableInfoGetCallerOwns(minfo) in {GITransfer.NOTHING, GITransfer.EVERYTHING}) # both occur
          methodBuffer.writeLine("\nproc " & asym & EM & plist & " =")
          methodBuffer.write(arrLex)
          methodBuffer.write(sss)
          if gCallableInfoCanThrowGerror(minfo):
            methodBuffer.writeLine("  var gerror: ptr glib.Error")
            arglist.insert(", addr gerror", arglist.high)
          for k, v in replist:
            methodBuffer.writeLine("  var $1_00 = $2($3)" % [k.strip(chars = {'`'}), v, k])
          if isGObject:
            gobjectTemp()
          elif gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING or
            gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING: # for ARC we have always to use the same finalizer!
            let tag = gTypeInfoGetTag(ret2)
            assert tag == GITypeTag.INTERFACE
            var iface = gTypeInfoGetInterface(ret2)
            if gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
              #methodBuffer.writeLine("#GIInfoType.INTERFACE")
              gobjectTemp()
              #iface = gInterfaceInfoGetIfaceStruct(iface)
              #methodBuffer.writeLine("  fnew(result, $1genericGObjectUnref) # Interface" % [mprefix])
              #methodBuffer.writeLine("  result.impl = " & sym & arglist)
            elif false: #gBaseInfoGetType(iface) == GIInfoType.OBJECT: # rare, ParamSpec in gobject.nim
              #echo "XXXXXXXXXXXXXXXXX what shall we do? for ", sym
              methodBuffer.writeLine("  fnew(result, $1genericGObjectUnref) # Object" % [mprefix])
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
            else:
              assert(gBaseInfoGetType(iface) in {GIInfoType.STRUCT, GIInfoType.UNION, GIInfoType.OBJECT})
              var freeMeName: string
              var freeMe: GIFunctionInfo
              var boxedFreeMeName: string
              findFreeProc(iface, gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING)
              if boxedFreeMeName != "":
                methodBuffer.writeLine("  fnew(result, $1)" % boxedFreeMeName)
              elif freeMeName == "":
                # assert false # TODO we have to fix this case manually
                # echo "xCaution: No free/unref found for ", ' ', gBaseInfoGetName(iface), " (", sym, ')' # check this from time to time!
                methodBuffer.writeLine("  new(result)")
              else:
                methodBuffer.writeLine("  fnew(result, $1)" % freeMeName)
              methodBuffer.writeLine("  result.impl = " & sym & arglist)
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING:
              methodBuffer.writeLine("  result.ignoreFinalizer = true") # as we have always to attach one with ARC.
            if gCallableInfoMayReturnNull(minfo):
              methodBuffer.writeLine("  if result.impl.isNil:")
              methodBuffer.writeLine("    return nil")
          elif false: #else:
            assert gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING
            methodBuffer.writeLine("  new(result)")
            methodBuffer.writeLine("  result.impl = " & sym & arglist)
          for k, v in replist:
            methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), k.strip(chars = {'`'})])
        else: # BLOCKMARK8
          if asym == "newFromStreamAsync" and sym.startsWith("gdk_pixbuf_animation_new"):
            asym = "newAnimationFromStreamAsync"
          methodBuffer.writeLine("\nproc " & asym & EM & plist & " =")
          methodBuffer.write(arrLex)
          methodBuffer.write(sss)
          var freeMeName: string
          var boxedFreeMeName: string
          for j in 0.cint ..< gCallableInfoGetNArgs(minfo):
            freeMeName = ""
            boxedFreeMeName = ""
            let arg = gCallableInfoGetArg(minfo, j)
            let t = gArgInfoGetType(arg)
            if gArgInfoGetDirection(arg) == GIDirection.OUT and isProxyCandidate(t) and
              not callerAlloc.contains(genRec(t, true, true)[0]) and not gArgInfoIsCallerAllocates(arg):
              let tag = gTypeInfoGetTag(t)
              assert(tag == GITypeTag.INTERFACE)
              assert gArgInfoGetOwnershipTransfer(arg) != GITransfer.CONTAINER
              if gArgInfoGetOwnershipTransfer(arg) == GITransfer.EVERYTHING or
                gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING: # pass always the same finalizer for ARC
                let iface = gTypeInfoGetInterface(t)
                if gBaseInfoGetType(iface) == GIInfoType.OBJECT:
                  let ttt = gArgInfoGetType(arg)
                  freeMeName = modPrefix(ttt, sym) & "finalizeGObject" # TODO: investigate, we may need the full toggleRef stuff!
                else:
                  let info = iface
                  var freeMe: GIFunctionInfo
                  findFreeProc(info, gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING)
              let h2 = mangleName(gBaseInfoGetName(arg))
              if boxedFreeMeName != "":
                methodBuffer.writeLine("  fnew(" & h2 & ", " & boxedFreeMeName & ")")
              elif freeMeName == "":
                methodBuffer.writeLine("  new(" & h2 & ")")
                #############methodBuffer.writeLine("  $1.ignoreFinalizer = true" % [h2])
              else:
                methodBuffer.writeLine("  fnew(" & h2 & ", " & freeMeName & ")")
              #if gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING:
              if gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING:
                methodBuffer.writeLine("  " & h2 & ".ignoreFinalizer = true") # as we have always to attach one with ARC.
          if gCallableInfoCanThrowGerror(minfo):
            methodBuffer.writeLine("  var gerror: ptr glib.Error")
            arglist.insert(", addr gerror", arglist.high)
          var multi = ""
          for k, v in replist:
            if v == "cstringArray" or v in NamedArrays:
              methodBuffer.writeLine("  var $1x$2: array[$3, pointer]" % [StringArrayName, multi, $StringArrayEntries])
              methodBuffer.writeLine("  var $1$2: cstringArray = cast[cstringArray](addr $1x$2)" % [StringArrayName, multi])
              methodBuffer.writeLine("  var $1_00 = seq2$2($3, $4$5)" % [k, v.replace("00").capitalizeAscii, k, StringArrayName, multi])
              if multi == "":
                multi = "1"
            elif v in UnnamedArrays:
              methodBuffer.writeLine("  var $1_00: pointer" % [k])
            else:
              methodBuffer.writeLine("  var $1_00 = $2($3)" % [k.strip(chars = {'`'}), v, k])
          if (let (r0, r1) = genRec(ret2); r0 in UnnamedArrays and r1 == intA0):
            methodBuffer.writeLine("  let resul0 = " & sym & arglist)
            methodBuffer.writeLine("  result = $1ZT2seq(resul0)" % [uncap(r0)])
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING, GITransfer.CONTAINER})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif isString(ret2):
            methodBuffer.writeLine("  let resul0 = " & sym & arglist)
            methodBuffer.writeLine("  result = $resul0")
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif genRec(ret2)[0] in NamedArrays:
            let h = genRec(ret2)[0]
            methodBuffer.writeLine("  let resul0 = " & sym & arglist)
            methodBuffer.writeLine("  result = $1ToSeq(resul0, $2_00.int)" % [h.replace("00").unCap, blex])
          elif (replist.len > 0 or gCallableInfoCanThrowGerror(minfo)) and genRec(ret2)[0] != "void":
            methodBuffer.write("  result = ")
            if ct2nt.contains(genRec(ret2)[0]):
              methodBuffer.writeLine(ct3nt(genRec(ret2)[0]) & '(' & sym & arglist & ')')
            else:
              methodBuffer.writeLine(sym & arglist)
          elif ct2nt.contains(genRec(ret2)[0]):
            if genRec(ret2)[0] == "cstringArray" and gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & arglist)
              methodBuffer.writeLine("  result = cstringArrayToSeq(resul0)")
              methodBuffer.writeLine("  g_strfreev(resul0)")
            else:
              methodBuffer.writeLine("  " & ct3nt(genRec(ret2)[0]) & '(' & sym & arglist & ')')
          else:
            methodBuffer.writeLine("  " & sym & arglist)
          for k, v in replist:
            if v in UnnamedArrays:
              methodBuffer.writeLine("  $1.setLen($2)" % [k, blex])
              methodBuffer.writeLine("  copyMem(unsafeaddr $1[0], $1_00, $2.int * sizeof($1[0]))" % [k, blex])
              methodBuffer.writeLine("  cogfree($1_00)" % [k])
            elif v in NamedArrays:
              methodBuffer.writeLine("  $1 = $2($3_00, $4)" % [k, ct3nt(v), k.strip(chars = {'`'}), blex])
            else:
              methodBuffer.writeLine("  $1 = $2($3_00)" % [k, ct3nt(v), k.strip(chars = {'`'})])
        # BLOCKMARK8
        if gCallableInfoCanThrowGerror(minfo):
          methodBuffer.writeLine("  if gerror != nil:")
          methodBuffer.writeLine("    let msg = $gerror.message")
          methodBuffer.writeLine("    g_error_free(gerror[])")
          methodBuffer.writeLine("    raise newException(GException, msg)")
      else: # } end of large proxy block BLOCK7
        asym = fixedProcNames.getOrDefault(sym, asym)
        (plist, arglist, replist, arrLex) = genPars(mInfo, false, info)
        if asym != "errorQuark" and asym != "getPlugin" and asym != "quark":
          methodBuffer.write("\nproc " & asym & EM & plist)
          methodBuffer.writeLine(" {.\n    importc: \"", sym, "\", ", libprag, ".}")
    if info != nil and (gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT) and
      gCallableInfoGetNArgs(minfo) == (if gCallableInfoIsMethod(minfo): 0 else: 1):
      if not callerAlloc.contains(modulenamespace & '.' & $gBaseInfoGetName(info)) and (asym == "free" or asym == "unref"):
        methodBuffer.writeLine("\nproc finalizer" & asym & EM & "(self: $1) =" % [$gBaseInfoGetName(info)])
        methodBuffer.writeLine("  if not self.ignoreFinalizer:")
        methodBuffer.writeLine("    " & sym & "(self.impl)")
    if sym == "gtk_window_set_default_size":
      methodBuffer.writeLine("\nproc `defaultSize=`*(self: Window; dim: tuple[width: int; height: int]) =")
      methodBuffer.writeLine("  gtk_window_set_default_size(cast[ptr Window00](self.impl), int32(dim[0]), int32(dim[1]))")
    if sym == "g_object_unref":
      # methodBuffer.writeLine("\nproc genericGObjectUnref*[T](self: ref T) =") # we do not really need generics here
      methodBuffer.writeLine("\nproc genericGObjectUnref*(self: Object) =")
      methodBuffer.writeLine("  if not self.ignoreFinalizer:")
      methodBuffer.writeLine("    g_object_unref(cast[ptr Object00](self.impl))")

    #if gBaseInfoGetType(info) == GIInfoType.Object and isgobject
    if info != nil and gBaseInfoGetType(info) == GIInfoType.Object and gObjectInfoGetFundamental(info) == GTrue and sym.endsWith("unref"):
      when false: # we can not use baseName, we have to use generics.
        var parent = info
        while true:
          let h = g_object_info_get_parent(parent)
          if h == nil:
            break
          parent = h
        let baseName = $gBaseInfoGetName(parent)
      methodBuffer.writeLine("\nproc generic_$1*[T](self: ref T) =" % [sym])
      # methodBuffer.writeLine("\nproc generic_$1*(self: $2) =" % [sym, baseName]) # we can not avoid generics here
      methodBuffer.writeLine("  if not self.ignoreFinalizer:")
      # methodBuffer.writeLine("    $1(cast[ptr Object00](self.impl))" % [sym]) # we do not need that cast!
      methodBuffer.writeLine("    $1(self.impl)" % [sym])

    if useTempProcessedFunctions:
      tempProcessedFunctions.add(sym)
  except UndefEx:

    processedFunctions.excl(sym)
    delayedMethods.add((info, minfo))
    methodBuffer.cut(p)

template genBoxedFree =
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE and gTypeFundamental(gRegisteredTypeInfoGetGType(info)) ==
        G_TYPE_BOXED and
      gBaseInfoGetName(info) != "VariantType": # we have no g_variant_type_get_gtype
      # For example, GVariant has a GType but is not a boxed type
      #assert(g_type_fundamental(g_registered_type_info_get_g_type(info)) == G_TYPE_BOXED)
      if gTypeFundamental(gRegisteredTypeInfoGetGType(info)) != G_TYPE_BOXED:
        assert false
        if gBaseInfoGetName(info) != "Variant":
          #echo moduleNamespace, gBaseInfoGetName(info)
          assert false
      output.writeLine("\nproc gBoxedFree" & $gRegisteredTypeInfoGetTypeName(info) & "*(self: " & mangleName(gBaseInfoGetName(
          info)) & ") =")
      if moduleNameSpace == "cairo": # we may manually free cairo objects!
        output.writeLine("  if not self.ignoreFinalizer and  self.impl != nil:")
        output.writeLine("    boxedFree(", getTypeProc, "(), ", "cast[ptr " & mangleName(gBaseInfoGetName(info)) & "00](self.impl))")
        output.writeLine("    self.impl = nil")
      else:
        output.writeLine("  if not self.ignoreFinalizer:")
        output.writeLine("    boxedFree(", getTypeProc, "(), ", "cast[ptr " & mangleName(gBaseInfoGetName(info)) & "00](self.impl))")
      #output.writeLine("\nwhen compileOption(\"gc\", \"arc\"):") # the when is not really needed, currently default gc ignores destructor
      output.writeLine("\nwhen defined(gcDestructors):")
      output.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")
      output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
      output.writeLine("      boxedFree(", getTypeProc, "(), ", "cast[ptr " & mangleName(gBaseInfoGetName(info)) & "00](self.impl))")
      output.writeLine("      self.impl = nil")
    else:
      if gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT and
        gBaseInfoGetName(info) != "ObjectClass" and gBaseInfoGetName(info) != "TypeFind":
        var freeMe: GIFunctionInfo
        if gBaseInfoGetType(info) == GIInfoType.UNION:
          freeMe = gUnionInfoFindMethod(info, "free")
          if freeMe.isNil:
            freeMe = gUnionInfoFindMethod(info, "unref")
        else:
          #if gStructInfoIsGtypeStruct(info) and gBaseInfoGetName(info) != "ObjectClass":
          assert gBaseInfoGetType(info) == GIInfoType.STRUCT
          freeMe = gStructInfoFindMethod(info, "free")
          if freeMe.isNil:
            freeMe = gStructInfoFindMethod(info, "unref")

template genDestroyFreeUnref =
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    if gRegisteredTypeInfoGetGType(info) == G_TYPE_NONE or gTypeFundamental(gRegisteredTypeInfoGetGType(info)) != G_TYPE_BOXED or
      gBaseInfoGetName(info) == "VariantType": # we have no g_variant_type_get_gtype
      if gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT and
        gBaseInfoGetName(info) != "ObjectClass" and gBaseInfoGetName(info) != "TypeFind":
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
        if freeMe != nil and gCallableInfoGetNArgs(freeMe) == (if gCallableInfoIsMethod(freeMe): 0 else: 1):
          # methodBuffer.writeLine("\nwhen compileOption(\"gc\", \"arc\"):")
          methodBuffer.writeLine("\nwhen defined(gcDestructors):")
          methodBuffer.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")
          methodBuffer.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
          methodBuffer.writeLine("      $1(self.impl)" % [$gFunctionInfoGetSymbol(freeMe)])
          methodBuffer.writeLine("      self.impl = nil")

proc writeUnion(info: GIUnionInfo) =

  #if gStructInfoIsGtypeStruct(info) and gBaseInfoGetName(info) != "ObjectClass":
  #  return # we should not need the class and interface structs
  #if gBaseInfoGetName(info).endsWith("Private"): # since v0.5.3 we do not write private structs
  #  return
  #output.writeLine("")

  if not suppressType:
    output.writeLine("type")
  if callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " {.pure, byRef, union.} = object")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " {.pure, union.} = object")
  if WriteFields or callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    for j in 0.cint ..< info.gUnionInfoGetNFields():
      let field = info.gUnionInfoGetField(j)
      let name = manglename(gBaseInfoGetName(field)) & EM
      let t = gFieldInfoGetType(field)
      output.writeLine("    ", name, ": ", genRec(t)[0])
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object")
    output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
    output.writeLine("    ignoreFinalizer*: bool")

  var getTypeProc: string
  if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE:
    #assert false executed for gtk3
    getTypeProc = $gRegisteredTypeInfoGetTypeInit(info)
    if getTypeProc notin ["intern", "g_gstring_get_type"]:
      output.write("\nproc " & getTypeProc & "*(): GType ")
      output.writeLine("{.importc, " & libprag & ".}")
  genBoxedFree()

  var mseq: seq[GIFunctionInfo]
  var freePos = -1
  for j in 0.cint ..< gUnionInfoGetNMethods(info):
    mseq.add(gUnionInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gUnionInfoGetMethod(info, j)) in ["free", "unref"]:
      #assert false executed for gtk3
      freePos = j
  if freePos > 0: swap(mseq[0], mseq[freePos])
  for i, mInfo in mseq:
    writeMethod(info, minfo)
    if i == 0:
      genDestroyFreeUnref()

const TargetEntryProx = """

proc seq2TargetEntryArray(s: openarray[TargetEntry]; a: var cstringArray):  TargetEntry00Array =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr TargetEntry00]](a)
  for i, o in s:
    x[i] = o.impl
  return x

proc newTargetEntry*(target: cstring; flags: int; info: int): TargetEntry

proc priv_target_table_free(targets: TargetEntry00Array; nTargets: int32) {.importc: "gtk_target_table_free", libprag.}

proc targetEntryArrayToSeq(s: TargetEntry00Array; n: int):  seq[TargetEntry] =
  let a = cast[ptr UncheckedArray[ptr TargetEntry00]](s)
  for i in 0 ..< n:
    result.add(newTargetEntry(a[i].target,  a[i].flags.int, a[i].info.int))
  priv_target_table_free(s, n.int32)

""" % [$StringArrayEntries]

const PageRangeProx = """

proc seq2PageRangeArray(s: openarray[PageRange]; a: var cstringArray):  PageRangeArray =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr PageRange]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return x

proc pageRangeArrayToSeq(s: PageRangeArray; n: int):  seq[PageRange] =
  let a = cast[ptr UncheckedArray[ptr PageRange]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)

""" % [$StringArrayEntries]

const KeymapKeyProx = """

proc seq2KeymapKeyArray(s: openarray[KeymapKey]; a: var cstringArray):  KeymapKeyArray =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr KeymapKey]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return x

proc keymapKeyArrayToSeq(s: KeymapKeyArray; n: int):  seq[KeymapKey] =
  let a = cast[ptr UncheckedArray[ptr KeymapKey]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)

""" % [$StringArrayEntries]

proc writeStruct(info: GIStructInfo) =
  if gStructInfoIsGtypeStruct(info) and gBaseInfoGetName(info) != "ObjectClass":
    return # we should not need the class and interface structs
  if gBaseInfoGetName(info).endsWith("Private"): # since v0.5.3 we do not write private structs
    return
  output.writeLine("")
  if not suppressType:
    output.writeLine("type")
  if mangleName(gBaseInfoGetName(info)) in someEvent:
    output.writeLine("  " & mangleName(gBaseInfoGetName(info)) & "00" & EM & " = Event00")
    output.writeLine("  " & mangleName(gBaseInfoGetName(info)) & EM & " = Event")
    return
  if callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " {.pure, byRef.} = object")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " {.pure.} = object")
  if WriteFields or callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(
      info))) or
    mangleName(gBaseInfoGetName(info)) == "TargetEntry" or
      ["gst.Message", "gst.MiniObject"].contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    for j in 0.cint ..< info.gStructInfoGetNFields():
      let field = info.gStructInfoGetField(j)
      let name = manglename(gBaseInfoGetName(field)) & EM
      let t = gFieldInfoGetType(field)
      output.writeLine("    ", name, ": ", genRec(t)[0])
      # let tag = gTypeInfoGetTag(t) # XXX: gFieldInfoGetSize() is always zero!
      #if typeTagIsBasic(tag):
      # echo "XXXXXXXXXXXXX",  gFieldInfoGetOffset(field)
      # echo "XXXXXXXXXXXXX",  gFieldInfoGetSize(field)
    #if mangleName(gBaseInfoGetName(info)) != "TextIter":
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object")
    output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
    output.writeLine("    ignoreFinalizer*: bool")
  var getTypeProc: string
  if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE:
    getTypeProc = $gRegisteredTypeInfoGetTypeInit(info)
    if getTypeProc notin ["intern", "g_gstring_get_type"]:
      output.write("\nproc " & getTypeProc & "*(): GType ")
      output.writeLine("{.importc, " & libprag & ".}")
  #if gBaseInfoGetName(info) == "Variant":
  #  output.writeLine("\nproc g_variant_ref_sink(self: ptr Variant00): ptr Variant00 {.importc, libprag.}\n")
  genBoxedFree()

  var mseq: seq[GIFunctionInfo]
  var freePos = -1
  for j in 0.cint ..< gStructInfoGetNMethods(info):
    mseq.add(gStructInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gStructInfoGetMethod(info, j)) in ["free", "unref"]:
      freePos = j
  if freePos > 0: swap(mseq[0], mseq[freePos])
  if mangleName(gBaseInfoGetName(info)) == "TargetEntry":
    # assert false executed for gtk3
    output.writeLine(TargetEntryProx)
  if mangleName(gBaseInfoGetName(info)) == "KeymapKey":
    output.writeLine(KeymapKeyProx)
  if mangleName(gBaseInfoGetName(info)) == "PageRange":
    output.writeLine(PageRangeProx)
  for i, mInfo in mseq:
    writeMethod(info, minfo)
    if i == 0:
      genDestroyFreeUnref()

template writeSignal() =
  if gCallableInfoGetNArgs(signalInfo) > 0 or gTypeInfoGetTag(zzzu) != GITypeTag.VOID:
    var memo = ""
    memo.addInt(gCallableInfoGetNArgs(signalInfo))
    memo.add(RecSep)
    var plist, arglist: string
    var replist: TableRef[string, string]
    (plist, arglist, replist) = genPars(signalInfo, true, info)
    memo.add(plist)
    memo.add(RecSep)
    (plist, arglist, replist) = genPars(signalInfo, false, info)
    memo.add(plist)
    memo = memo.replace("\n    ", " ")
    memo = memo.replace("\"", "\\\"")
    if moduleNamespace == "gtk" or moduleNamespace == "gdk" or moduleNamespace == "gdkX11":
      if ISGTK3:
        supmod3.writeLine("    \"" & ($gBaseInfoGetName(signalInfo)).replace("-", "_") & RecSep & $gBaseInfoGetName(info) &
            RecSep & memo & "\",")
      else:
        supmod4.writeLine("    \"" & ($gBaseInfoGetName(signalInfo)).replace("-", "_") & RecSep & $gBaseInfoGetName(info) &
            RecSep & memo & "\",")
    else:
      supmod3.writeLine("    \"" & ($gBaseInfoGetName(signalInfo)).replace("-", "_") & RecSep & $gBaseInfoGetName(info) & RecSep &
          memo & "\",")
      supmod4.writeLine("    \"" & ($gBaseInfoGetName(signalInfo)).replace("-", "_") & RecSep & $gBaseInfoGetName(info) & RecSep &
          memo & "\",")
  if gCallableInfoGetNArgs(signalInfo) > 0:
    h = h.replace(")", "; xdata: pointer)")
  else:
    h = h.replace(")", "xdata: pointer)")
  var xxx = mangleName(gBaseInfoGetName(info))
  let yyy = xxx
  if interfaceProvider.contains(xxx):
    let provider = interfaceProvider[xxx]
    for i in provider: discard mangleType(i)
    xxx = xxx & " | " & provider.join(" | ")
  signalbuffer.write("\nproc " & mangleName("sc_" & $gBaseInfoGetName(signalInfo)) & EM & "(self: " & xxx & "; ")
  if gCallableInfoGetNArgs(signalInfo) > 0 or gTypeInfoGetTag(zzzu) != GITypeTag.VOID:
    #signalbuffer.writeLine(" p: proc (self: ptr " & yyy & "00; " & h & " {.cdecl.}, xdata: pointer = nil, cf: gobject.ConnectFlags = {}): culong =")
    signalbuffer.writeLine(" p: proc (self: ptr " & yyy & "00; " & h & " {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =")
  else:
    #signalbuffer.writeLine(" p: proc (self: ptr gobject.Object00; " & h & " {.cdecl.}, xdata: pointer = nil, cf: gobject.ConnectFlags = {}): culong =")
    signalbuffer.writeLine(" p: proc (self: ptr gobject.Object00; " & h & " {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =")
  signalbuffer.write("  g_signal_connect_data(self.impl, \"")
  signalbuffer.write($gBaseInfoGetName(signalInfo))
  signalbuffer.writeLine("\", cast[GCallback](p), xdata, nil, cf)")

proc writeInterface(info: GIInterfaceInfo) =
  if not suppressType:
    output.writeLine("type")
  # we made interfaces a gobject now...
  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " = object of gobject.Object00")
  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object of gobject.Object")
  let numsig = info.gInterfaceInfoGetNSignals
  #if numsig > 0: signalbuffer.writeLine("")
  for j in 0.cint ..< numsig:
    let signalInfo = gInterfaceInfoGetSignal(info, j)
      #let c = gSignalInfoGetClassClosure(signalInfo)
      #if not c.isNil: echo "maybe we should process class closures!"
      #if gBaseInfoGetName(signalInfo) == "notify":
      #  continue # XXX fix later
    var h = genPars(signalInfo, false)[0][1..^1]
    let zzzu = gCallableInfoGetReturnType(signalinfo)
    writeSignal()
  for j in 0.cint ..< gInterfaceInfoGetNMethods(info):
    let mInfo = gInterfaceInfoGetMethod(info, j)
    writeMethod(info, minfo)

# write a few of the strange enum sets
proc writeModifierType(info: GIEnumInfo) =
  let we = gBaseInfoGetName(info)
  assert(we in ["ModifierType", "EventMask", "AccelFlags", "AttachOptions", "MessageType", "WindowHints"])
  type T = tuple[v: int64; n: string]
  var s: seq[T]
  var alias: seq[string]
  output.writeLine("type")
  for j in 0.cint ..< info.gEnumInfoGetNValues():
    let value = info.gEnumInfoGetValue(j)
    var name = mangleName(gBaseInfoGetName(value))
    name.removeSuffix("Mask")
    let v = gValueInfoGetValue(value)
    if bitops.popCount(v) == 1:
      s.add((v, name))
  s.sort do (x, y: T) -> int:
    result = cmp(x.v, y.v)
    if result == 0:
      result = cmp(x.n, y.n)
  var tname = mangleName(gBaseInfoGetName(info))
  if tname != "WindowHints":
    firstPart(tname)
  output.writeLine("  ", tname & "Flag" & EM, " {.size: sizeof(cint), pure.} = enum")
  if s[0].v != 0 and s[0].v != 1: # flags may start with none = 0 or with flag1 = 1
    output.writeLine("    ignoreThisDummyValue = 0") # Nim needs start with 0 for these low level sets
  var k: T
  for j in 0 .. s.high:
    let i = s[j]
    var val = i.v
    if j == 0 and val == 0: continue
    if j > 0 and i.v == k.v:
      assert false
      if i.n != k.n:
        alias.add("  " & tname & i.n.capitalizeAscii & EM & " = " & tname & '.' & k.n)
      continue
    val = countTrailingZeroBits(val)
    output.writeLine("    ", i.n, " = ", val)
    k = i
  if alias.len > 0:
    assert false
    output.writeLine("\nconst")
    for i in alias:
      output.writeLine(i)
  output.writeLine("\n  ", we & EM, " {.size: sizeof(cint).} = set[$1Flag]" % [tname])
  if we == "ModifierType":
    output.writeLine("\nconst ModifierMask* = {ModifierFlag.shift .. ModifierFlag.button5, ModifierFlag.super .. ModifierFlag.meta}") #, ModifierFlag.release}")
  elif we == "EventMask":
    output.writeLine("\nconst AllEventsMask* = {EventFlag.exposure .. EventFlag.smoothScroll}")
  for j in 0.cint ..< gEnumInfoGetNMethods(info):
    let mInfo = gEnumInfoGetMethod(info, j)
    writeMethod(info, minfo)

proc writeEnum(info: GIEnumInfo) =
  if mangleName(gBaseInfoGetName(info)) in ["ModifierType", "EventMask", "AccelFlags", "AttachOptions", "WindowHints"] or
    (moduleNameSpace == "gst" and mangleName(gBaseInfoGetName(info)) == "MessageType"):
    writeModifierType(info)
    return
  type T = tuple[v: int64; n: string]
  var s: seq[T]
  var alias: seq[string]
  var flags = ($gBaseInfoGetName(info)).endsWith("Flags")# or $gBaseInfoGetName(info) == "WindowHints"
  output.writeLine("type")
  let n = info.gEnumInfoGetNValues()
  for j in 0.cint ..< n:
    let value = info.gEnumInfoGetValue(j)
    let name = mangleName(gBaseInfoGetName(value))
    let v = gValueInfoGetValue(value)
    s.add((v, name))
  s.sort do (x, y: T) -> int:
    result = cmp(x.v, y.v)
    if result == 0:
      result = cmp(x.n, y.n)
  for j in 0 .. s.high:
    if s[j].v < 0:
      flags = false
    if j == 0 and s[j].v == 0: continue
    if bitops.popCount(s[j].v) != 1: flags = false
  if s.len <= 1: flags = false
  var tname = mangleName(gBaseInfoGetName(info))
  if flags: tname = tname[0 .. ^6]
  if flags:
    output.writeLine("  ", tname & "Flag" & EM, " {.size: sizeof(cint), pure.} = enum")
    if s[0].v != 0 and s[0].v != 1: # flags may start with none = 0 or with flag1 = 1
      output.writeLine("    ignoreThisDummyValue = 0") # Nim needs start with 0 for these low level sets
  else:
    output.writeLine("  ", tname & EM, " {.size: sizeof(cint), pure.} = enum")
  var k: T
  for j in 0 .. s.high:
    let i = s[j]
    var val = i.v
    if flags and j == 0 and val == 0: continue
    if j > 0 and i.v == k.v:
      if i.n != k.n:
        let h = if flags: "Flag" else: ""
        alias.add("  " & tname & i.n.capitalizeAscii & EM & " = " & tname & h & '.' & k.n)
      continue
    if flags:
      val = countTrailingZeroBits(val) # firstSetBit(val)
    output.writeLine("    ", i.n, " = ", val)
    k = i

  if flags:
    output.writeLine("\n  ", tname & "Flags" & EM, " {.size: sizeof(cint).} = set[$1Flag]" % [tname])

  if alias.len > 0:
    output.writeLine("\nconst")
    for i in alias:
      output.writeLine(i)

  for j in 0.cint ..< gEnumInfoGetNMethods(info):
    let mInfo = gEnumInfoGetMethod(info, j)
    writeMethod(info, minfo)

proc writeObj(info: GIObjectInfo) =
  if gBaseInfoGetName(info).endsWith("Private"):
    assert false
    return
  assert(gBaseInfoGetType(info) == GIInfoType.OBJECT)
  let class = gObjectInfoGetClassStruct(info)
  let parent = gObjectInfoGetParent(info) # nil for Object of module gobject!
  var pname: string
  var oof: string
  var ns: string
  var cnt: int
  if parent.isNil:
    #assert(gBaseInfoGetName(info) == "Object" or gBaseInfoGetName(info) == "ParamSpec")
    #echo "??? ", gBaseInfoGetName(info)
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
    if ns == moduleNamespace: ns = "" else: ns = fixedModName(ns) & '.'
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
    if moduleNamespace == "gtksource" and gBaseInfoGetName(
        info) == "CompletionInfo":
      cnt = 9
    if moduleNamespace == "gtksource" and gBaseInfoGetName(info) == "View":
      cnt = 9
  if not suppressType:
    output.writeLine("type")
  if ns == "" and pname != "": # check forward exeption for parent name!
    discard mangleType(pname)
  if mangleName(gBaseInfoGetName(info)) == "Object" and moduleNamespace == "gobject":
    discard
  elif parent.isNil: # this is new for v0.6.0 with gstreamer support
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object of RootRef")
    output.write("    impl*: ptr ")
    output.write(gBaseInfoGetName(info))
    output.writeLine("00")
    output.writeLine("    ignoreFinalizer*: bool")
  #elif gBaseInfoGetName(info) == "ParamSpec":
  #  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object of RootRef")
  #  output.writeLine("    impl*: ptr ParamSpec00")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object of " & ns & pname)
  if pname != "": pname.add("00")
  output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM, oof, ns & $pname)
  assert not callerAlloc.contains(ns & '.' & manglename(gBaseInfoGetName(info)))
  assert not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info)))
  when WriteFields:
    if mangleName(gBaseInfoGetName(info)) != "InitiallyUnowned":
      for j in 0.cint ..< info.gObjectInfoGetNFields():
        let field = info.gObjectInfoGetField(j)
        var name = mangleName(gBaseInfoGetName(field))
        if privStr.contains(name) and cnt > 0:
          renumber(name, cnt)
        else:
          name.add(EM)
        let t = gFieldInfoGetType(field)
        let h = genRec(t)[0]
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
    output.writeLine("  else:")
    output.writeLine("    GC_unref(cast[RootRef](data))")
    output.writeLine("\nproc finalizeGObject*[T](o: ref T) =")
    output.writeLine("\n  if not o.ignoreFinalizer:")
    output.writeLine("    g_object_remove_toggle_ref(o.impl, toggleNotify, addr(o[]))")

  var getTypeProc: string
  if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE:
    getTypeProc = $gRegisteredTypeInfoGetTypeInit(info)
    if getTypeProc notin ["intern", "g_gstring_get_type"]:
      output.write("\nproc " & getTypeProc & "*(): GType ")
      output.writeLine("{.importc, " & libprag & ".}")

  let numsig = info.gObjectInfoGetNSignals
  #if numsig > 0: signalbuffer.writeLine("")
  for j in 0.cint ..< numsig:
    let signalInfo = gObjectInfoGetSignal(info, j)
    let c = gSignalInfoGetClassClosure(signalInfo)
    if not c.isNil: echo "maybe we should process class closures!"
    if gBaseInfoGetName(signalInfo) == "notify":
      continue # XXX fix later
    var h = genPars(signalInfo, false)[0][1..^1]
    let zzzu = gCallableInfoGetReturnType(signalinfo)
    writeSignal()
  #for j in 0.cint ..< gObjectInfoGetNMethods(info):
  #  let mInfo = gObjectInfoGetMethod(info, j)
  #  writeMethod(info, minfo)

  var mseq: seq[GIFunctionInfo]
  var freePos = -1
  for j in 0.cint ..< gObjectInfoGetNMethods(info):
    mseq.add(gObjectInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gObjectInfoGetMethod(info, j)) in ["free", "unref"]:
      #assert false executed for gtk3
      freePos = j
  if freePos > 0: swap(mseq[0], mseq[freePos])
  for i, mInfo in mseq:
    writeMethod(info, minfo)
    #if i == 0:
    #  genDestroyFreeUnref()

  if class != nil and not allSyms.contains(mangleName(gBaseInfoGetName(class))):
    assert false
    classList.add(class)
  ct.inc($gBaseInfoGetName(info), cnt + 1)
  if gBaseInfoGetName(info) == "Object" and moduleNamespace == "gobject":
    output.writeLine("type\n  Object* = ref object of RootRef")
    output.writeLine("    impl*: ptr Object00")
    output.writeLine("    ignoreFinalizer*: bool")
  if gObjectInfoGetFundamental(info) == GFalse: # guess work, ignore fake GObjects like GParamSpec and such
    #output.writeLine("\nwhen compileOption(\"gc\", \"arc\"):")
    output.writeLine("\nwhen defined(gcDestructors):")
    output.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")
    output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
    output.writeLine("      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))")
    output.writeLine("      self.impl = nil")

  if gBaseInfoGetName(info) == "ParamSpec" and moduleNamespace == "gobject":
    ## for ParamSpec no unref proc is provided by gobject-introspection, and it asks for uref!
    output.writeLine("\nproc g_param_spec_unref(self: ptr ParamSpec00) {.")
    output.writeLine("    importc, libprag.}")

    output.writeLine("\nproc g_param_spec_uref(self: ptr ParamSpec00) {.")
    output.writeLine("    importc: \"g_param_spec_unref\", libprag.}")

    output.writeLine("\nproc unref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

    output.writeLine("\nproc uref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

    output.writeLine("\nproc generic_g_param_spec_uref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

  if gBaseInfoGetType(info) == GIInfoType.Object and gObjectInfoGetFundamental(info) == GTrue:
    ## generate the destroy() for the non gobject objects
    assert(gObjectInfoGetFundamental(info) == GTrue)
    var parent = info
    while true:
      let h = g_object_info_get_parent(parent)
      if h == nil:
        break
      parent = h
    let freeMeName = $g_object_info_get_unref_function(parent)
    if freeMeName != "":
      output.writeLine("\nwhen defined(gcDestructors):")
      let n = mangleName(gBaseInfoGetName(info))
      output.writeLine("  proc destroy_" & freeMeName & "(self: ptr " & n & "00) {.importc: \"" & freeMeName & "\", libprag.}\n")
      output.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")
      output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
      if n in ["ParamArray", "ParamFraction"]:
        output.writeLine("      destroy_$#(cast[ptr $#00](self.impl))" % [freeMeName, n])
      else:
        output.writeLine("      destroy_$1(self.impl)" % [freeMeName])
      output.writeLine("      self.impl = nil")

proc extractFromUnion(tag: GITypeTag; arg: GIArgumentObj): string =
  result =
    case tag:
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
    of GITypeTag.UTF8: '"' & $arg.vstring & '"'
    #of GITypeTag.FILENAME: $arg.
    #of GITypeTag.ARRAY: $arg.
    of GITypeTag.INTERFACE: """"INTERFCE (unsuported)""""
    #of GITypeTag.GLIST: $arg.
    #of GITypeTag.GSLIST: $arg.
    #of GITypeTag.GHASH:  $arg.
    #of GITypeTag.ERROR: $arg.
    #of GITypeTag.UNICHAR: $arg.
    else: "XXX" & $tag

proc writeConst(info: GIConstantInfo) =
  var tg = ""
  var arg: GIArgumentObj
  let t = gConstantInfoGetType(info)
  let tag = gTypeInfoGetTag(t)
  discard gConstantInfoGetValue(info, addr(arg)) # TODO: we should check the size s!
  var str = extractFromUnion(tag, arg)
  if str == """"\"""": str = """"\\""""
  var h = $gBaseInfoGetName(info)
  if h == "MODIFIER_MASK":
    return
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
    output.writeLine("const ", tg, h & EM, " = ", str)
  else:
    output.writeLine("const ", mangleName(h) & EM, " = ", str)

proc processInfo(i: GIBaseInfo) =
  if not (isFunctionInfo(i) or gBaseInfoGetType(i) == GIInfoType.STRUCT):
    output.write("\n")
  if isCallableInfo(i):
    if isFunctionInfo(i):
      let s = $gFunctionInfoGetSymbol(i)
      if s[^1] != '_' and not processedFunctions.contains(s) and not s.contains("__") and s !=
              "g_type_add_interface_dynamic" and
        s != "g_type_get_plugin" and s != "g_type_register_dynamic":
        writeMethod(nil, i)
    else:
      assert(isCallbackInfo(i))
      if not suppressType:
        output.write("type\n")
      output.writeLine("  ", mangleName(gBaseInfoGetName(i)) & "* = proc " & genPars(i)[0] & " {.cdecl.}")
  elif gBaseInfoGetType(i) == GIInfoType.OBJECT:
    writeObj(i)
  elif gBaseInfoGetType(i) == GIInfoType.UNION:
    writeUnion(i)
  elif gBaseInfoGetType(i) == GIInfoType.INTERFACE:
    writeInterface(i)
  elif gBaseInfoGetType(i) == GIInfoType.STRUCT:
    writeStruct(i)
  elif isEnumInfo(i):
    writeEnum(i)
  elif gBaseInfoGetType(i) == GIInfoType.CONSTANT:
    writeConst(i)
  elif gBaseInfoGetType(i) == GIInfoType.Boxed:
    echo "gBaseInfoGetType(i) == GIInfoType.Boxed: ", gBaseInfoGetName(i)
    # echo "++++++++ ", g_registered_type_info_get_g_type(i), g_registered_type_info_get_type_name(i)
    # assert false executed for gtk4
  else:
    assert(false)

const PRO = """

proc seq2cstringArray*(s: openarray[string]; a: var cstringArray): cstringArray =
  assert s.high < $1 - 1
  let x = cast[ptr UncheckedArray[string]](s)
  for i in 0 .. s.high:
    a[i] = addr(x[i][0])
  a[s.len] = nil
  return a
    
""" % [$StringArrayEntries]

const GTK_SOURCE_EPI = """

proc getView*(builder: Builder; name: string): View =
  #let gt = g_type_from_name("Gtk$1") # this worked also!
  #let gt = $2
  let gt = g_type_from_name("GSource")
  assert(gt != g_type_invalid_get_type())
  let gobj = gtk_builder_get_object(cast[ptr Builder00](builder.impl), name)
  assert(gobj != nil)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, gtksource.finalizeGObject)
    result.impl = gobj
    result.ignoreFinalizer = true
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))
"""

const GDK3_EPI = """

proc getButton*(self: SomeEvent): int =
  var button: uint32
  if not toBool(gdk_event_get_button(cast[ptr Event00](self.impl), button)):
    raise newException(Defect, "Event don't has a button field.")
  return int(button)

proc getClickCount*(self: SomeEvent): int =
  var clickCount_00: uint32
  if not toBool(gdk_event_get_click_count(cast[ptr Event00](self.impl), clickCount_00)):
    raise newException(Defect, "Event does not support getClickCount().")
  return int(clickCount_00)

proc getCoords*(self: SomeEvent): (cdouble, cdouble) =
  if not toBool(gdk_event_get_coords(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a coordinate field.")

proc getKeyval*(self: SomeEvent): int =
  var keyval_00: uint32
  if not toBool(gdk_event_get_keyval(cast[ptr Event00](self.impl), keyval_00)):
    raise newException(Defect, "This event don't has a keyval field.")
  return int(keyval_00)

# not available in GTK4
proc getRootCoords*(self: SomeEvent): (cdouble, cdouble) =
  if not toBool(gdk_event_get_root_coords(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a rootCoordinate field.")

proc getScrollDeltas*(self: SomeEvent): (cdouble, cdouble) =
  if not toBool(gdk_event_get_scroll_deltas(cast[ptr Event00](self.impl), result[0], result[1])):
    raise newException(Defect, "This event don't has a scrollDeltas field.")

proc getScrollDirection*(self: SomeEvent): ScrollDirection =
  if not toBool(gdk_event_get_scroll_direction(cast[ptr Event00](self.impl), result)):
    raise newException(Defect, "Event don't has a scrollDirection field.")

proc getState*(self: SomeEvent): ModifierType =
  if not toBool(gdk_event_get_state(cast[ptr Event00](self.impl), result)):
    raise newException(Defect, "Event don't has a state field.")

proc gdk_window_invalidate_nilrect(self: ptr Window00; rect: ptr Rectangle; invalidateChildren: gboolean) {.
    importc: "gdk_window_invalidate_rect", libprag.}

proc invalidateRect*(self: Window; rect: ptr Rectangle = nil; invalidateChildren: bool = false) =
  gdk_window_invalidate_nilrect(cast[ptr Window00](self.impl), rect, gboolean(invalidateChildren))

proc fixednewCursorFromName*(display: Display; name: string): Cursor =
  fnew(result, gdk.finalizeGObject)
  result.impl = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), cstring(name))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  #assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))
"""

const GDK_EPI = """

proc getAngle*(self: SomeEvent; event2: SomeEvent): cdouble =
  if not toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getAngle().")

proc getCenter*(self: SomeEvent; event2: SomeEvent): (cdouble, cdouble) =
  if not toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result[0], result[1])):
    raise newException(Defect, "Events do not support getCenter().")

proc getDistance*(self: SomeEvent; event2: SomeEvent): cdouble =
  if not toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), result)):
    raise newException(Defect, "Events do not support getDistance().")

proc getAxis*(self: SomeEvent; axisUse: AxisUse): cdouble =
  if not toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, result)):
    raise newException(Defect, "Event does not support getAxis().")

"""

const GIO_EPI = """

proc run*(self: GApplication): int =
  int(g_application_run(cast[ptr GApplication00](self.impl), 0, nil))

"""

const GTK3_EPI = """

proc mainQuit*(w: Window) = mainQuit()

"""

const GTK_EPI = """

#proc loadFromData*(self: CssProvider; data: cstring): bool =
#  loadFromData(self, uint8Array(data), -1)

proc gtk_file_chooser_dialog_new*(title: cstring; parent: ptr Window00; action: FileChooserAction; 
    firstButtonText: cstring = nil): ptr FileChooserDialog00 {.varargs,
    importc: "gtk_file_chooser_dialog_new", libprag.}

proc newFileChooserDialog*(title: string = ""; parent: Window = nil; action: FileChooserAction): FileChooserDialog =
  let gobj = gtk_file_chooser_dialog_new(safeStringToCString(title), if parent.isNil: nil else: cast[ptr Window00](parent.impl), action)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, $1.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileChooserDialog*[T](result: var T; title: string = ""; parent: Window = nil; action: FileChooserAction) =
  assert(result is FileChooserDialog)
  let gobj = gtk_file_chooser_dialog_new(safeStringToCString(title), if parent.isNil: nil else: cast[ptr Window00](parent.impl), action)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, $1.finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

import macros, strutils

#include gisup
#include gimpl

"""

proc main(namespace: string; version: cstring = nil) =
  priList = newSeq[string]()
  var buildableList: seq[string]
  suppressType = false
  suppressRaise = false
  delayedMethods = newSeq[(GIBaseInfo, GIFunctionInfo)]()
  classList = newSeq[GIBaseInfo]()
  output = newStringStream()
  methodBuffer = newStringStream()
  var externInterfaces: seq[string]
  var error: GError
  ct = initCountTable[string]()
  var delayedSyms: seq[GIBaseInfo]
  allSyms = initHashSet[string]()
  provInt.clear
  interfaceProvider.clear
  var ig: HashSet[string]
  knownSyms = initHashSet[string]()
  let gi = gIrepositoryGetDefault()
  assert(gi != nil)
  moduleNamespace = namespace.toLowerAscii
  #let version: cstring = nil # latest
  # export GI_TYPELIB_PATH=/opt/gtk/lib64/girepository-1.0
  # echo $XDG_DATA_DIRS
  # man g-ir-scanner
  #g_irepository_prepend_search_path("/opt/gtk/lib64/girepository-1.0")
  # ISGTK3 = not (((namespace == "Gtk") or (namespace == "Gdk") or (namespace == "GdkX11")) and version == "4.0")
  # ISGTK3 = parmCount() == 0 # we have to launch the generator two times, as typelibs can not be unloaded!
  let typelib = gi.gIrepositoryRequire(namespace, version, cast[GIRepositoryLoadFlags](0), error)
  #let typelib = gIrepositoryRequirePrivate(nil, namespace, "/usr/lib/girepository-1.0", version, cast[GIRepositoryLoadFlags](0), error)
  if typelib.isNil:
    echo "Failed to load ", namespace
    echo error.message
    echo "Maybe for your OS you have to install additional GTK related packages?"
    echo "We continue with the remaining packages..."
    return
  #let loadedVersion = g_irepository_get_version(gi, namespace)
  let dep: cstringArray = gi.gIrepositoryGetDependencies(namespace)
  output.writeLine("# dependencies:")
  var importedModules = ""
  for j in 0 .. 12:
    if dep[j].isNil: break
    if j == 0:
      importedModules = "import "
    output.writeLine("# ", dep[j])
    importedModules.add(fixedModName(($dep[j]).split('-', 2)[0].toLowerAscii) & ", ")
  importedModules.removeSuffix(", ")
  strfreev(dep)
  let idep: cstringArray = gi.gIrepositoryGetImmediateDependencies(namespace)
  output.writeLine("# immediate dependencies:")
  for j in 0 .. 12:
    if idep[j].isNil: break
    output.writeLine("# ", idep[j])
  strfreev(idep)
  let libs = gi.gIrepositoryGetSharedLibrary(namespace)
  output.writeLine("# libraries:")
  output.writeLine("# ", libs)
  #output.writeLine("{.deadCodeElim: on, warning[UnusedImport]: off.}") # gmodule, xlib, cairo
  output.writeLine("{.warning[UnusedImport]: off.}") # gmodule, xlib, cairo
  output.writeLine(importedModules)
  var Lib = if libs.isNil: "" else: ($libs).split(',', 2)[0]
  if namespace == "PangoCairo" and Lib.startsWith("libpango-"):
    Lib = Lib.replace("libpango-", "libpangocairo-") # GI bug?
  output.writeLine("const Lib = \"$1\"" % Lib)
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

    output.writeLine("\nproc boxedFree*(boxedType: GType; boxed: pointer) {.")
    output.writeLine("    importc: \"g_boxed_free\", libprag.}")

  elif namespace == "GLib":
    # we need gobject.
    let gobjectlibs = gi.gIrepositoryGetSharedLibrary("GObject")
    var GobjectLib = if gobjectlibs.isNil: "" else: ($gobjectlibs).split(',', 2)[0]
    output.writeLine("const GobjectLib* = \"$1\"" % GobjectLib)
    output.writeLine("{.pragma: gobjectlibprag, cdecl, dynlib: GobjectLib.}")

    output.writeLine("type\n  GException* = object of Exception")
    output.writeLine("type\n  OptionEntry00Array* = pointer")
    output.writeLine("type\n  GArray00* = pointer")
    output.writeLine("type\n  int8Array* = pointer")
    output.writeLine("type\n  uintArray* = pointer")
    output.writeLine("type\n  gbooleanArray* = pointer")
    output.writeLine("type\n  cdoubleArray* = pointer")
    output.writeLine("type\n  int32Array* = pointer")
    output.writeLine("type\n  PollFD00Array* = pointer")
    output.writeLine("type\n  Variant00Array* = pointer")
    output.writeLine("type\n  Regex00Array* = pointer")
    output.writeLine("type\n  LogField00Array* = pointer")
    output.writeLine("type\n  VariantType00Array* = pointer")
    output.writeLine("type\n  DebugKey00Array* = pointer")
    output.writeLine("type\n  utf8Array* = pointer")
    output.writeLine("type\n  uint8Array* = pointer")
    output.writeLine("type\n  ucstringArray* = pointer")
    output.writeLine("type\n  ucstring* = distinct cstring")
    output.writeLine("type\n  gboolean* = distinct cint")
    output.writeLine("const\n  GLIB_SIZEOF_VOID_P = sizeof(pointer)")
    output.writeLine("const\n  GLIB_SIZEOF_SIZE_T* = GLIB_SIZEOF_VOID_P")
    output.writeLine("const\n  GLIB_SIZEOF_LONG* = sizeof(clong)")
    output.writeLine("type\n  Gssize* = int # csize") # https://forum.nim-lang.org/t/5637#35015
    output.writeLine("type\n  Gsize* = uint # csize # note: csize is signed in Nim!")
    #output.writeLine("type\n  GType* = distinct cint") # wrong
    #stefan@nuc ~/Downloads/glib-2.53.3/gobject $ grep -A5 GLIB_SIZEOF_S *.h
    #gtype.h:#if     GLIB_SIZEOF_SIZE_T != GLIB_SIZEOF_LONG || !defined __cplusplus
    #gtype.h-typedef gsize                           GType;
    #gtype.h-#else   /* for historic reasons, C++ links against gulong GTypes */
    #gtype.h-typedef gulong                          GType;
    #gtype.h-#endif
    output.writeLine("when GLIB_SIZEOF_SIZE_T != GLIB_SIZEOF_LONG or not defined(cpp):")
    output.writeLine("  type\n    GType* = Gsize")
    output.writeLine("else:")
    output.writeLine("  type\n    GType* = culong")
    output.writeLine("type\n  gunichar* = uint32")
    output.writeLine("type\n  utf8* = char")
    output.writeLine("const GFalse* = gboolean(0)")
    output.writeLine("const GTrue* = gboolean(1)")

    output.writeLine("\nproc boxedFree(boxedType: GType; boxed: pointer) {.")
    output.writeLine("    importc: \"g_boxed_free\", gobjectlibprag.}")

    output.writeLine("""
#proc fnew*[T](a: var ref T; finalizer: proc (x: ref T)) =
template fnew*(a: untyped; finalizer: untyped) =
  when defined(gcDestructors):
    new(a)
  else:
    new(a, finalizer)
""")

    output.writeLine("""
proc int32ArrayZT2seq*(p: pointer): seq[int32] =
  let a = cast[ptr UncheckedArray[int32]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)
""")

    output.writeLine("""
proc uint32ArrayZT2seq*(p: pointer): seq[uint32] =
  let a = cast[ptr UncheckedArray[uint32]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)
""")

    output.writeLine("""
proc uint8ArrayZT2seq*(p: pointer): seq[uint8] =
  let a = cast[ptr UncheckedArray[uint8]](p)
  var i: int
  while true:
    if a[i] == 0:
      break
    result.add(a[i])
    inc(i)
""")

    output.writeLine("proc cogfree*(mem: pointer) {.importc: \"g_free\", libprag.}")
    output.writeLine("proc g_strfreev*(strArray: cstringArray) {.importc: \"g_strfreev\", libprag.}")
    output.writeLine("proc toBool*(g: gboolean): bool = g.int != 0")
    output.writeLine("proc safeStringToCString*(s: cstring): cstring = (if s.len == 0: nil else: s)")
    output.writeLine(PRO)
  elif namespace == "Gdk":
    output.writeLine("type\n  ContentProvider00Array* = pointer")
    output.writeLine("type\n  Atom00Array* = pointer")
    output.writeLine("type\n  KeymapKeyArray* = pointer")
    output.writeLine("type\n  VisualTypeArray* = pointer") # enums!
    output.writeLine("type\n  RGBAArray* = pointer")
    output.writeLine("type\n  AxisUseArray* = pointer")
    output.writeLine("type\n  ColorArray* = pointer")
    output.writeLine("type\n  Point00Array* = pointer")
    output.writeLine("type\n  TimeCoord00Array* = pointer")
  elif namespace == "Gtk":
    #output.writeLine(
    #    "# https://developer.gnome.org/gtk3/stable/GtkWidget.html#GtkWidget-draw")
    #output.writeLine(
    #    "# TRUE to stop other handlers from being invoked for the event. FALSE to propagate the event further.")
    #output.writeLine("const\n  SignalEventStopPropagation* = true")
    #output.writeLine("const\n  SignalEventContinuePropagation* = false")
    output.writeLine("type\n  TargetEntry00Array* = pointer")
    output.writeLine("type\n  AccelGroupEntry00Array* = pointer")
    output.writeLine("type\n  BindingArg00Array* = pointer")
    output.writeLine("type\n  StockItemArray* = pointer")
    output.writeLine("type\n  PageRangeArray* = pointer")
    output.writeLine("type\n  PadActionEntry00Array* = pointer")
    output.writeLine("type\n  Widget00Array* = pointer")
    output.writeLine("type\n  Array* = pointer")
  elif namespace == "Atk":
    output.writeLine("type\n  StateTypeArray* = pointer") # enums!
    output.writeLine("type\n  TextRange00Array* = pointer")
  elif namespace == "cairo":
    output.writeLine("\nfrom gobject import boxedFree")
    output.writeLine("from glib import GType")
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
    output.writeLine("type\n  DBusErrorEntry00Array* = pointer")
    output.writeLine("type\n  InputVector00Array* = pointer")
    output.writeLine("type\n  SocketControlMessage00Array* = pointer")
    output.writeLine("type\n  InputMessage00Array* = pointer")
    output.writeLine("type\n  OutputMessage00Array* = pointer")
    output.writeLine("type\n  utf8ArrayArray* = pointer")
    output.writeLine("type\n  cstringArrayArray* = pointer")
    output.writeLine("type\n  File00Array* = pointer")
    output.writeLine("type\n  Array* = pointer")
    output.writeLine("type\n  OutputVector00Array* = pointer")
  elif namespace == "Graphene":
    output.writeLine("type\n  Vec3Array* = pointer")
    output.writeLine("type\n  Point3DArray* = pointer")
  elif namespace == "Gsk":
    output.writeLine("type\n  Shadow00Array* = pointer")
    output.writeLine("type\n  RenderNode00Array* = pointer")
    output.writeLine("type\n  ColorStop00Array* = pointer")
  elif namespace == "GtkSource":
    output.writeLine("import glib")
  elif namespace == "Vte":
    output.writeLine("import glib\n")
    output.writeLine("type\n  Regex00Array* = pointer")
  elif namespace == "Gst":
    output.writeLine("type\n  FormatArray* = pointer")
  if namespace == "GObject":
    output.writeLine("\nimport times")
    output.writeLine("var qt = \"NGIQ\" & $epochTime()")
    output.writeLine("if g_quark_try_string(qt) != 0:")
    output.writeLine("  qt = \"NGIQ\" & $epochTime()")
    output.writeLine("let Quark* = g_quark_from_static_string(qt)")

  if namespace notin ["GObject", "GLib", "xlib", "GModule"]:
    output.writeLine("\nproc finalizeGObject*[T](o: ref T) =")
    output.writeLine("  if not o.ignoreFinalizer:")
    output.writeLine("    gobject.g_object_remove_toggle_ref(o.impl, gobject.toggleNotify, addr(o[]))")
    #output.writeLine("\nproc genericGObjectUnref*[T](self: ref T) =")
    #output.writeLine("  if not self.ignoreFinalizer:")
    #output.writeLine("    gobject.g_object_unref(cast[ptr gobject.Object00](self.impl))")

  var n = gi.gIrepositoryGetNInfos(namespace)
  var s: seq[GIBaseInfo]
  for i in 0.cint ..< n:
    if not droppedSyms.contains(mangleName(gBaseInfoGetName(gi.gIrepositoryGetInfo(namespace, i)))):
      s.add(gi.gIrepositoryGetInfo(namespace, i))
  for i in s:
    if gBaseInfoGetType(i) in {GIInfoType.OBJECT, GIInfoType.INTERFACE, GIInfoType.STRUCT, GIInfoType.UNION} or isEnumInfo(i) or
        isCallbackInfo(i):
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
        var interf: seq[string]
        let name = $gBaseInfoGetName(info)
        for i in 0.cint ..< ninterfaces:
          var ns = ($gBaseInfoGetNamespace(info.gObjectInfoGetInterface(i))).toLowerAscii
          if ns != moduleNamespace:
            var iname = $gBaseInfoGetName(info.gObjectInfoGetInterface(i))
            var fname = iname; fname.unCap
            iname = fixedModName(ns) & "." & iname
            let tname = fixedModName(moduleNamespace) & "." & $gBaseInfoGetName(info)
            externInterfaces.add("proc " & fname & "*(x: " & tname & "): " & iname & " = cast[" & iname & "](x)")
          interf.add($gBaseInfoGetName(info.gObjectInfoGetInterface(i)))
          let builderinter = info.gObjectInfoGetInterface(i)
          if gBaseInfoGetName(builderinter) == "Buildable":
            buildableList.add($gBaseInfoGetName(info))
        if provInt.contains(name):
          assert false
        else:
          provInt[name] = interf

  # Cross module interfaces -- maybe only a few, so we add it manually
  # GSimpleActionGroup implements GActionGroup and GActionMap.
  if namespace == "Gtk":
    provInt["gio.SimpleActionGroup"] = @["gio.ActionGroup", "gio.ActionMap", "ActionGroup", "ActionMap"]
    #provInt["gio.SimpleActionGroup"] = @["ActionGroup", "ActionMap"]
  # The next two do not work, as gio does not import gtk! So we have to use converter proc.
  # GtkApplication implements GActionGroup and GActionMap.
  # provInt["Application"] = @["ActionGroup", "ActionMap"]
  # GtkApplicationWindow implements AtkImplementorIface, GtkBuildable, GActionGroup and GActionMap.
  # provInt["ApplicationWindow"] = @["ImplementorIface", "Buildable", "ActionGroup", "ActionMap"]

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
          gdkKeys[h.toLowerAscii].add(h)
        else:
          gdkKeys.add(h.toLowerAscii, @[h])
    for el in mvalues(gdkKeys):
      sort(el, system.cmp)
  var i: GIBaseInfo
  var unp: seq[GIBaseInfo]
  reverse(s)
  var more_runs = 50
  while s.len > 0 or more_runs > 0:
    if s.len == 0: dec(more_runs)
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
      var k = -1
      for p, el in s:
        if (gBaseInfoGetType(el) in {GIInfoType.OBJECT, GIInfoType.INTERFACE, GIInfoType.STRUCT} or isEnumInfo(el)) and
            gBaseInfoGetName(el) == h:
          k = p
      if k >= 0:
        s.add(s[k])
        s.delete(k)
    if s.len > 0:
      i = s.pop
      delayedSyms.insert(i)
    if classList.len > 0:
      assert false
      delayedSyms.insert(classList.pop)
    unp.setLen(0)
    for k in delayedSyms:
      var pos = output.getPosition
      var supmodpos3 = supmod3.getPosition
      var supmodpos4 = supmod4.getPosition
      try:
        knownSyms.incl(mangleName(gBaseInfoGetName(k)))
        methodBuffer = newStringStream()
        signalBuffer = newStringStream()
        processInfo(k)
        output.write(signalBuffer.data)
        output.write(methodBuffer.data)
      except UndefEx:
        unp.add(k)
        knownSyms.excl(mangleName(gBaseInfoGetName(k)))
        output.cut(pos)
        supmod3.cut(supmodpos3)
        supmod4.cut(supmodpos4)
    delayedSyms = unp
    block myb:
      for a in 1 .. 2: # process clustered symbols into one single type section
        if delayedSyms.len > a:
          suppressType = true
          methodBuffer = newStringStream()
          signalBuffer = newStringStream()
          unp = delayedSyms
          #for t in unp.combinations(a + 1): # works fine with default GC
          var hhh = toSeq(unp.combinations(a + 1)) # nedded for --gc:arc
          for t in hhh:
            var pos = output.getPosition
            var supmodpos3 = supmod3.getPosition
            var supmodpos4 = supmod4.getPosition
            methodBuffer = newStringStream()
            signalBuffer = newStringStream()
            let x = delayedMethods.len
            #var processedFunctionsBack = processedFunctions # var due to https://forum.nim-lang.org/t/6312
            tempProcessedFunctions.setLen(0)
            useTempProcessedFunctions = true
            try:
              var h = false
              for k in t:
                if gBaseInfoGetType(k) notin {GIInfoType.INTERFACE, GIInfoType.OBJECT, GIInfoType.STRUCT, GIInfoType.UNION} and
                    not isCallbackInfo(k):
                  h = true
                  assert false
              if h: continue
              output.writeLine("type")
              for k in t:
                knownSyms.incl(mangleName(gBaseInfoGetName(k)))
              for k in t:
                processInfo(k)
              for k in t:
                delayedSyms.keepItIf(mangleName(gBaseInfoGetName(k)) != mangleName(gBaseInfoGetName(it)))
              suppressType = false
              output.write(signalBuffer.data)
              output.write(methodBuffer.data)
              break myb
            except UndefEx:
              for k in t:
                knownSyms.excl(mangleName(gBaseInfoGetName(k)))
              output.setPosition(pos)
              supmod3.cut(supmodpos3)
              supmod4.cut(supmodpos4)
              #processedFunctions = processedFunctionsBack #
              for el in tempProcessedFunctions:
                processedFunctions.excl(el)
              useTempProcessedFunctions = false
              assert delayedMethods.len >= x
              delayedMethods.setLen(x)
          suppressType = false
    methodBuffer = newStringStream()
    var h = delayedMethods
    delayedMethods = newSeq[(GIBaseInfo, GIFunctionInfo)]()
    for el in h:
      writeMethod(el[0], el[1])
    output.write(methodBuffer.data)
  suppressRaise = true
  output.writeLine("# === remaining symbols:") # in best case there is nothing left
  for i in delayedSyms:
    assert false
    processInfo(i)
  if externInterfaces.len > 0:
    output.writeLine("\n# Extern interfaces: (we don't use converters, but explicit procs for now.)")
  for i in externInterfaces:
    output.writeLine("")
    output.writeLine(i)

  if namespace == "Gst":
    output.write(
          """
proc init* =
  var argc: int32 = 0
  var argv: cstringArray = nil
  gst_init(argc,  argv)

proc getType*(m: gst.Message): gst.MessageType =
  m.impl.type
""")

  if namespace == "Gtk":
    if ISGTK3:
      output.write(GTK3_EPI)
      output.write(
          """
proc init* =
  var argc: int32 = 0
  var argv: cstringArray = nil
  gtk_init(argc,  argv)
""")

    output.write(GTK_EPI % fixedModName("gtk"))
    if ISGTK3:
      output.write("include gisup3\n")
      output.write("include gimpl\n")
    else:
      output.write("include gisup4\n")
      output.write("include gimpl\n")
    buildableList.add("MenuModel")
    for i in buildableList:
      var prefix = "gtk"
      var modname = fixedModName(moduleNamespace)
      if i == "MenuModel":
        prefix = "g"
        modname = "gio"
      if i == "": continue
      output.write(
          """
proc get$1*(builder: Builder; name: string): $1 =
  let gt = $2
  assert(gt != g_type_invalid_get_type())
  let gobj = gtk_builder_get_object(cast[ptr Builder00](builder.impl), name)
  assert(gobj != nil)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, $3.finalizeGObject)
    result.impl = gobj
    result.ignoreFinalizer = true
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))

""" % [i, prefix & "_" & myCamelToSnake(i) & "_get_type()", modname])
    output.write("")

  if namespace == "Gio":
    output.write(GIO_EPI)

  if namespace == "cairo":
    output.write("include cairoimpl\n")

  if namespace == "GObject":
    output.writeLine("\nproc g_type_invalid_get_type*(): GType = g_type_from_name(\"(null)\")")
    output.writeLine("\nproc g_type_none_get_type*(): GType = g_type_from_name(\"void\")")
    output.writeLine("\nproc g_interface_get_type*(): GType = g_type_from_name(\"GInterface\")")
    output.writeLine("\nproc g_char_get_type*(): GType = g_type_from_name(\"gchar\")")
    output.writeLine("\nproc g_uchar_get_type*(): GType = g_type_from_name(\"guchar\")")
    output.writeLine("\nproc g_boolean_get_type*(): GType = g_type_from_name(\"gboolean\")")
    output.writeLine("\nproc g_int_get_type*(): GType = g_type_from_name(\"gint\")")
    output.writeLine("\nproc g_uint_get_type*(): GType = g_type_from_name(\"guint\")")
    output.writeLine("\nproc g_long_get_type*(): GType = g_type_from_name(\"glong\")")
    output.writeLine("\nproc g_ulong_get_type*(): GType = g_type_from_name(\"gulong\")")
    output.writeLine("\nproc g_int64_get_type*(): GType = g_type_from_name(\"gint64\")")
    output.writeLine("\nproc g_uint64_get_type*(): GType = g_type_from_name(\"guint64\")")
    output.writeLine("\nproc g_enum_get_type*(): GType = g_type_from_name(\"GEnum\")")
    output.writeLine("\nproc g_flags_get_type*(): GType = g_type_from_name(\"GFlags\")")
    output.writeLine("\nproc g_float_get_type*(): GType = g_type_from_name(\"gfloat\")")
    output.writeLine("\nproc g_double_get_type*(): GType = g_type_from_name(\"gdouble\")")
    output.writeLine("\nproc g_string_get_type*(): GType = g_type_from_name(\"gchararray\")")
    output.writeLine("\nproc g_pointer_get_type*(): GType = g_type_from_name(\"gpointer\")")
    output.writeLine("\nproc g_boxed_get_type*(): GType = g_type_from_name(\"GBoxed\")")
    output.writeLine("\nproc g_param_get_type*(): GType = g_type_from_name(\"GParam\")")
    #output.writeLine("\nproc g_object_get_type*(): GType = g_type_from_name(\"GObject\")")
    #output.writeLine("\nproc g_type_get_type*(): GType = g_type_from_name(\"GType\")")
    output.writeLine("\nproc g_variant_get_type*(): GType = g_type_from_name(\"GVariant\")")

  if namespace == "Gdk":
    if ISGTK3:
      output.write(GDK3_EPI.replace("SomeEvent", "Event"))
    output.write(GDK_EPI.replace("SomeEvent", "Event"))
  if namespace == "GtkSource":
    output.write(GTK_SOURCE_EPI)
  output.flush
  var suff = ""
  if version == "4.0":
    suff = "4"
  var o = open("nim_gi" / (namespace.toLowerAscii) & suff & ".nim", fmWrite)
  o.write(output.data)
  o.close()
  output.close
  stdout.write("Remaining delayed methods: ", delayedMethods.len)
  if delayedMethods.len == 0:
    echo " (Fine!)"
  else:
    echo " delayed:"
  for el in delayedMethods:
    echo gBaseInfoGetName(el[1])

proc launch() =
  when defined(gcDestructors):
    echo "defined(gcDestructors)"
    echo "maybe GC is arc"
  #when compileOption("gc", "arc"):
  #  echo "GC is arc"
  #when compileOption("gc", "refc"):
  #  echo "GC is refc"

  ISGTK3 = paramCount() == 0 # we have to launch the generator two times, as typelibs can not be unloaded!
  supmod3 = newStringStream()
  supmod3.writeLine("const\n  SCA = [")
  supmod4 = newStringStream()
  supmod4.writeLine("const\n  SCA = [")

  # as typelib does not support reloading, we have to generate all libs twice
  # note cairo is handcrafted!

  if ISGTK3:
    echo "Generating bindings for GTK3..."
    main("Gtk", "3.0") # the 3 new 4.0 releases in old version
    main("Gdk", "3.0")
    main("GdkX11", "3.0")
    # main("Gsk") # not available for GTK3
    main("Graphene")
    main("GLib") # and the old common onces
    main("GObject")
    main("Gio")
    main("GdkPixbuf")
    main("GModule")
    main("GtkSource")
    main("Atk")
    main("Pango")
    main("PangoCairo")
    main("PangoFT2")
    main("fontconfig")
    main("freetype2")
    main("Rsvg")
    main("xlib")
    main("Vte")
    main("Notify")
    main("Gst")
    main("cairo")
  else:
    echo "First we try generating bindings for GTK4, this may fail when GTK4 is not properly installed"
    echo "on your computer. But don't worry, you can still use GTK3"
    main("Gtk", "4.0") # the 3 new 4.0 releases
    main("Gdk", "4.0")
    main("GdkX11", "4.0")
    main("Gsk") # and two new ones for gtk4
    main("Graphene")
    main("GLib") # and the old common onces
    main("GObject")
    main("Gio")
    main("GdkPixbuf")
    main("GModule")
    # main("GtkSource") # not yet available for GTK4
    main("Atk")
    main("Pango")
    main("PangoCairo")
    main("PangoFT2")
    main("fontconfig")
    main("freetype2")
    main("Rsvg")
    main("xlib")
    # main("Vte") # not yet available for GTK4
    main("Notify")
    main("Gst")
    main("cairo")

  if ISGTK3:
    supmod3.writeLine("  ]")
    supmod3.flush
    var o = open("nim_gi" / "gisup3.nim", fmWrite)
    o.write(supmod3.data)
    o.close()
    supmod3.close
  else:
    supmod4.writeLine("  ]")
    supmod4.flush
    var o = open("nim_gi" / "gisup4.nim", fmWrite)
    o.write(supmod4.data)
    o.close()
    supmod4.close

launch()
# 2712 lines

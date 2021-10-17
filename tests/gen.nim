# High level gobject-introspection based GTK4/GTK3 bindings for the Nim programming language
# nimpretty --maxLineLen:130 gen.nim
# v 0.9.5 2021-OCT-01
# (c) S. Salewski 2018, 2019, 2020, 2021

# usefull for finding death code:
# https://forum.nim-lang.org/t/5898

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

             # CAUTION: some procs are advertised as constructor but do not construct new objects,
              # they just return existing ones as gdk_cursor_new_from_name()

# {.warning[CStringConv]: off.} # does not work with older compilers

# isRegisteredTypeInfo(info) was never used before v0.9.5, but may be useful!

from os import `/`, paramCount
import gir, gobject, glib
import strutils
import sequtils
import streams
import sets
import bitops
import tables
import algorithm
import std/editdistance
import maxby
from parseutils import skipUntil
#from sugar import dup
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
  #UnnamedArrays = UnnamedArrayCandidates.mapIt(it & "Array")
  #NamedArrays = ["TargetEntry00Array", "PageRangeArray", "KeymapKeyArray"]
  #NamedArrayCandidates = NamedArrays.mapIt(it.replace("00Array").replace("Array"))
  StringArrayName = "fs469n23" # for seq -- cstringArray conversion
  StringArrayEntries = 256 # initial 16, but that was too small for VTE environGetenv(). Stack allocated pointer array -- replace by heap or global?

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

import dynlib

type
  AdwInit = proc (argc: ptr cint; argv: ptr ptr cstring) {.cdecl.}

proc tryInitAdw(): LibHandle =
  # echo "Try to init gst"
  when defined(windows):
    const AdwLibName = "adwaita-1-0.dll"
  elif defined(macosx):
    const AdwLibName = "libadwaita-1.dylib"
  else:
    const AdwLibName = "libadwaita-1.so(|.0)"
  let adwLib = loadLibPattern(AdwLibName) # dlopen
  if adwLib != nil:
    let adwInit = cast[AdwInit](adwLib.symAddr("adw_init"))
    if adwInit != nil:
      adwInit(nil, nil)
    else:
      echo "Can't init adw library!"
  else:
    echo "Can't load adw library!"
  return adwLib
  # unloadLib(adwLib)

type
  GstInit = proc (argc: ptr cint; argv: ptr ptr cstring) {.cdecl.}

proc tryInitGst(): LibHandle =
  # echo "Try to init gst"
  when defined(windows):
    const GstLibName = "gstreamer-1.0-0.dll"
  elif defined(macosx):
    const GstLibName = "libgstreamer-1.0.dylib"
  else:
    const GstLibName = "libgstreamer-1.0.so(|.0)"
  let gstLib = loadLibPattern(GstLibName) # dlopen
  if gstLib != nil:
    let gstInit = cast[GstInit](gstLib.symAddr("gst_init"))
    if gstInit != nil:
      gstInit(nil, nil)
    else:
      echo "Can't init gst library!"
  else:
    echo "Can't load gst library!"
  return gstLib
  # unloadLib(gstLib)

type
  Gtk3Init = proc (argc: ptr cint; argv: ptr ptr cstring) {.cdecl.}

proc tryInitGtk3(): LibHandle =
  # echo "Try to init gtk3"
  when defined(windows):
    const Gtk3LibName = "libgtk-3-0.dll"
  elif defined(macosx):
    const Gtk3LibName = "libgtk-3.dylib"
  else:
    const Gtk3LibName = "libgtk-3.so(|.0)"
  let gtk3Lib = loadLibPattern(Gtk3LibName) # dlopen
  if gtk3Lib != nil:
    let gtk3Init = cast[Gtk3Init](gtk3Lib.symAddr("gtk_init"))
    if gtk3Init != nil:
      gtk3Init(nil, nil)
    else:
      echo "Can't init gtk3 library!"
  else:
    echo "Can't load gtk3 library!"
  return gtk3Lib

type
  Gtk4Init = proc () {.cdecl.}

proc tryInitGtk4(): LibHandle =
  # echo "Try to init gtk4"
  when defined(windows):
    const Gtk4LibName = "libgtk-4-0.dll"
  elif defined(macosx):
    const Gtk4LibName = "libgtk-4.dylib"
  else:
    const Gtk4LibName = "libgtk-4.so(|.0)"
  let gtk4Lib = loadLibPattern(Gtk4LibName) # dlopen
  if gtk4Lib != nil:
    let gtk4Init = cast[Gtk4Init](gtk4Lib.symAddr("gtk_init"))
    if gtk4Init != nil:
      gtk4Init()
    else:
      echo "Can't init gtk4 library!"
  else:
    echo "Can't load gtk4 library!"
  return gtk4Lib

proc unCap(s: var string) =
  s[0] = s[0].toLowerAscii

proc unCap(s: string): string =
  result = s
  result[0] = result[0].toLowerAscii

proc unCaped(s: string): string =
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

proc endsWith(s: string; x: varargs[string]): bool =
  for i in x:
    if s.endsWith(i):
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

#var callerAlloc: HashSet[string]
var xcallerAlloc: HashSet[string]
var ISGTK3: bool
var suppressType = false
var suppressRaise = false

var cairoProvidesRectangle = false # ugly fix for legacy Debian Buster, CairoRectangle was missing

# fixedDestroyNames.add("gdk_window_create_similar_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_window_create_similar_image_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_cairo_region_create_from_surface", "cairo.destroy")
# fixedDestroyNames.add("gdk_cairo_surface_create_from_pixbuf", "cairo.destroy")

fixedProcNames["gst_video_color_matrix_from_iso"] = "colorMatrixFromIso"
fixedProcNames["gst_video_color_primaries_from_iso"] = "colorPrimariesFromIso"
fixedProcNames["gst_video_transfer_function_from_iso"] = "transferFunctionFromIso"

fixedProcNames["gtk_popover_menu_new_from_model"] = "newPopoverMenu" # FromModel"

fixedProcNames["gtk_button_new_with_label"] = "newButton"
fixedProcNames["gtk_check_button_new_with_label"] = "newCheckButton"
fixedProcNames["gtk_toggle_button_new_with_label"] = "newToggleButton"
fixedProcNames["gtk_link_button_new_with_label"] = "newLinkButton"

fixedProcNames["pango_font_description_from_string"] = "newFontDescription"
fixedProcNames["pango_language_from_string"] = "languageFromString"
fixedProcNames["atk_role_register"] = "registerAtkRole"
fixedProcNames["atk_state_type_register"] = "registerStateType"
fixedProcNames["atk_relation_type_register"] = "registerRelationType"
fixedProcNames["atk_text_attribute_register"] = "registerTextAttribute"
fixedProcNames["atk_role_for_name"] = "roleForName"
fixedProcNames["atk_state_type_for_name"] = "stateTypeForName"
fixedProcNames["atk_relation_type_for_name"] = "relationTypeForName"
fixedProcNames["atk_text_attribute_for_name"] = "textAttributeForName"
fixedProcNames["gtk_settings_get_for_screen"] = "getSettingsForScreen"
fixedProcNames["gtk_icon_theme_get_for_screen"] = "getIconThemeForScreen"
fixedProcNames["gtk_requisition_new"] = "newRequisition"
fixedProcNames["gtk_text_attributes_new"] = "newTextAttributes"
fixedProcNames["pango_script_for_unichar"] = "scriptForUnichar"
fixedProcNames["pango_bidi_type_for_unichar"] = "bidiTypeForUnichar"
fixedProcNames["gsk_shadow_node_get_child"] = "shadowNodeGetChild"
fixedProcNames["gsk_transform_node_get_child"] = "transformNodeGetChild"
fixedProcNames["gtk_settings_get_for_display"] = "getSettingsForDisplay"
fixedProcNames["gtk_icon_theme_get_for_display"] = "getIconThemeForDisplay"
fixedProcNames["gst_element_factory_find"] = "findElementFactory"

fixedProcNames["gtk_shortcut_action_parse_string"] = "shortcutActionParseString"
fixedProcNames["gtk_shortcut_trigger_parse_string"] = "shortcutTriggerParseString"
fixedProcNames["g_main_context_default"] = "defaultMainContext"

fixedProcNames["gst_value_list_init"] = "listInit" # or initList ?
fixedProcNames["gst_value_array_init"] = "arrayInit" # or initArray ?

fixedProcNames["gdk_gl_context_get_current"] = "getCurrentGLContext"
fixedProcNames["gdk_visual_get_best"] = "getBestVisual"
fixedProcNames["gdk_visual_get_best_depth"] = "getBestDepth"
fixedProcNames["gdk_visual_get_system"] = "getSystemVisual"
fixedProcNames["gdk_visual_get_best_type"] = "getBestType"
fixedProcNames["gdk_pixbuf_get_formats"] = "getPixbufFormats"

fixedProcNames["gst_gl_base_memory_init_once"] = "baseMemoryInitOnce"
fixedProcNames["gst_gl_renderbuffer_init_once"] = "renderbufferInitOnce"
fixedProcNames["gst_gl_buffer_init_once"] = "bufferInitOnce"
fixedProcNames["gst_gl_memory_init_once"] = "memoryInitOnce"
fixedProcNames["gst_gl_memory_pbo_init_once"] = "memoryPboInitOnce"

fixedProcNames["g_memory_monitor_dup_default"] = "dupDefaultMemoryMonitor"
fixedProcNames["g_power_profile_monitor_dup_default"] = "dupDefaultPowerProfileMonitor"

defaultParameters["gtk_window_new"] = "`type` WindowType WindowType.toplevel"
defaultParameters["gtk_application_new"] = "flags gio.ApplicationFlags {}"
defaultParameters["gtk_builder_new_from_string"] = "length int64 -1"
defaultParameters["gtk_box_new"] = "spacing int 0"
defaultParameters["gtk_grid_attach"] = "width int 1|height int 1"
defaultParameters["gtk_adjustment_new"] = "pageSize cdouble 1.0"
defaultParameters["pango_layout_set_text"] = "length int -1"
# proc pango_layout_set_text(self: ptr Layout00; text: cstring; length: int32)

for i in keywords: mangledNames[i] = '`' & i & '`'

mangledNames["CSET_A_2_Z"] = "CSET_A_2_Z_U"
mangledNames["CSET_a_2_z"] = "CSET_a_2_z_L"
mangledNames["2big"] = "tooBig"
mangledNames["2buttonPress"] = "twoButtonPress"
mangledNames["3buttonPress"] = "threeButtonPress"
mangledNames["result"] = "resu"
mangledNames["3d"] = "d3"
mangledNames["2d"] = "d2"
mangledNames["2dAffine"] = "d2Affine"
mangledNames["2dTranslate"] = "d2Translate"
mangledNames["true"] = "true1"
mangledNames["false"] = "false0"

const someEvent: HashSet[string] = """"
  EventAny EventKey EventButton EventTouch EventScroll EventMotion EventExpose EventVisibility
  EventCrossing EventFocus EventConfigure EventProperty EventSelection EventDND EventProximity EventWindowState EventSetting
  EventOwnerChange EventGrabBroken EventTouchpadSwipe EventTouchpadPinch EventPadButton EventPadAxis EventPadGroupMode
  """.split.toHashSet

proc fixedModName(s: string): string =
  result = s
  if not ISGTK3 and (s == "gdk" or s == "gtk" or s == "gdkx11"):
    result &= "4"
  if not ISGTK3 and (s == "javascriptcore" or s == "webkit2" or s == "webkit2webextension"):
    result &= "5"
  if not ISGTK3 and (s == "gtksource"):
    result &= "5"

proc gBaseInfoGetName(info: GIBaseInfo): string =
  result = $(gir.gBaseInfoGetName(info))
  let h = $(gir.gBaseInfoGetNamespace(info))
  if h == "Gio" and result == "Application":
    result = "GApplication"
  if h == "Gio" and result == "File":
    result = "GFile"

proc mangleName(s: cstring): string =
  result = mysnakeToCamel(s)
  result = mangledNames.getOrDefault(result, result)
  if result == "``":
    # assert(false)
    result = "xxx" # XXX

mangledTypes["gint8"] = "int8"
mangledTypes["gint16"] = "int16"
mangledTypes["gint32"] = "int32"
mangledTypes["gint64"] = "int64"
mangledTypes["guint8"] = "uint8"
mangledTypes["guint16"] = "uint16"
mangledTypes["guint32"] = "uint32"
mangledTypes["guint64"] = "uint64"
mangledTypes["gfloat"] = "cfloat"
mangledTypes["gdouble"] = "cdouble"
mangledTypes["ptr void"] = "pointer"
mangledTypes["ptr filename"] = "cstring"
mangledTypes["ptr error"] = "ptr glib.Error"
mangledTypes["ptr ghash"] = "ptr HashTable00"
mangledTypes["ptr glist"] = "ptr pointer"
mangledTypes["ptr gslist"] = "ptr pointer"
mangledTypes["ptr utf8"] = "cstring"

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

# These objects are plain structs like GtkTextIter containing only fundamental data types like uint32.
# They are generally allocated on the stack, so there is no alloc or free function offered by gtk.
# If all these conditions are met, then we do not need a proxy object. Caution, some objects like
# TextAttribute has bitfields, which is difficult to map to Nim. Watch for cstrings too!
# For these objects we have to always write the fields. These names are found manually!
const manCallerAlloc = """
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
cairo.Rectangle
cairo.RectangleInt
gsk.RoundedRect
glib.Mutex
glib.Cond
gdk.ToplevelSize
pango.GlyphInfo
pango.GlyphVisAttr
pango.GlyphGeometry
pango.AttrIterator
gsk.ColorStop
gsk.Shadow
gtk.BitsetIter
gdk.TimeCoord
gtk.IMContextInfo
glib.StatBuf
glib.Once
graphene.Simd4X4F
glib.RecMutex
gdk.Point
gst.PollFD
gtksource.RegionIter
gio.OutputVector
gst.TimedValue
glib.DebugKey
glib.DoubleIEEE754
gtk.BindingArg
gtk.PadActionEntry
glib.FloatIEEE754
gst.StaticCaps
gobject.WeakRef
glib.SequenceIter
rsvg.Length
gtk.TargetPair
gtk.RequestedSize
gdk.Atom
gtk.TableChild
glib.Dir
glib.LogField
glib.Data
glib.OptionEntry
gobject.EnumValue
glib.PollFD
gobject.FlagsClass
gtk.RecentFilterInfo
gobject.TypeInfo
gtk.FileFilterInfo
rsvg.Rectangle
gtk.BindingSignal
gtk.RcProperty
glib.RWLock
gio.DBusErrorEntry
gio.IOSchedulerJob
gio.FileAttributeInfo
glib.HashTableIter
gtk.AccelKey
gobject.ObjectConstructParam
gio.StaticResource
gobject.TypeCValue
gtk.SettingsValue
gobject.FlagsValue
gobject.EnumClass
gtk.RecentData
glib.SList
glib.List
nice.Address
gst.MapInfo
gstvideo.VideoAlignment
gstvideo.VideoRectangle
gstrtsp.RTSPRange
gstrtsp.RTSPTimeRange
gstrtsp.RTSPTime
gstrtsp.RTSPTime2
gtk.CssLocation
gstvideo.VideoFrame
gstvideo.VideoMeta
gstvideo.VideoFormatInfo
gstvideo.VideoMasteringDisplayInfo
gstvideo.VideoCaptionMeta
gstvideo.VideoCropMeta
gstvideo.VideoTimeCodeConfig
gstvideo.VideoContentLightLevel
gstvideo.VideoAncillary
gstvideo.VideoColorimetry
gstvideo.VideoMetaTransform
gstvideo.VideoResampler
gstsdp.MIKEYEncryptInfo
gstsdp.MIKEYPayloadKEMAC
gstsdp.SDPAttribute
gstsdp.MIKEYPayloadSP
gstsdp.MIKEYPayloadRAND
gstsdp.MIKEYPayloadKeyData
gstsdp.MIKEYPayloadPKE
gstrtp.RTCPPacket
gstrtp.RTCPBuffer
gstrtp.RTPBuffer
gstcheck.StreamConsistency
gstcheck.HarnessThread
gstcheck.CheckABIStruct
gstcheck.Harness
"""



const autoCallerAlloc = """
"""

const noCallerAlloc = """
glib.SourceCallbackFuncs
xlib.XEvent
glib.TokenValue
gobject.ObjectClass
xlib.Display
gst.ReferenceTimestampMeta
gst.BufferPoolAcquireParams
glib.IOFuncs
glib.MemVTable
gst.ParamSpecArray
gst.MetaTransformCopy
gst.PluginDesc
gio.InputVector
pango.Analysis
gio.IOExtensionPoint
gst.CustomMeta
gio.ActionEntry
gtk.ActionEntry
xlib.XConfigureEvent
gst.PadProbeInfo
glib.HookList
gobject.TypeValueTable
glib.Node
gst.DebugMessage
gst.ParentBufferMeta
fontconfig.CharSet
freetype2.Library
gtk.TextBTree
xlib.Screen
gst.ProtectionMeta
gobject.ClosureNotifyData
gmodule.Module
xlib.XFontStruct
xlib.Visual
graphene.Simd4F
glib.Scanner
gtk.ThemeEngine
xlib.XVisualInfo
glib.Array
gtk.BindingSet
xlib.XTrapezoid
gtk.LabelSelectionInfo
xlib.XImage
gtk.TableRowCol
freetype2.Face
atk.Attribute
gst.ValueTable
glib.TestSuite
gtk.TextAppearance
gtk.RadioActionEntry
gtk.BindingEntry
gobject.Parameter
glib.SourceFuncs
gst.TypeFind
atk.Implementor
glib.TestCase
glib.Timer
fontconfig.Pattern
freetype2.Bitmap
gobject.TypePluginClass
atk.KeyEventStruct
glib.TrashStack
gobject.TypeFundamentalInfo
gobject.InterfaceInfo
gobject.CClosure
gtk.WindowGeometryInfo
gtk.AccelGroupEntry
gtk.FixedChild
xlib.XEvent
atk.PropertyValues
gobject.TypeInterface
atk.ObjectClass
glib.TokenValue
gst.ParamSpecFraction
atk.TextRange
xlib.XWindowAttributes
gtk.RcContext
gtk.ToggleActionEntry
gst.FormatDefinition
gdk.WindowRedirect
gobject.SignalInvocationHint
gdk.WindowAttr
glib.TestConfig
gst.StaticPadTemplate
glib.ScannerConfig
gobject.ParamSpecTypeInfo
gobject.ParamSpecPool
gtk.BuildableParseContext
gtk.CssStyleChange
gtk.BuildableParser
gst.ClockEntry
gio.IOExtension
gio.IOStreamAdapter
gio.DBusSubtreeVTable
gio.DBusInterfaceVTable
vte.CharAttributes
gst.MetaInfo
gtk.Clipboard
gdk.DrawingContext
gio.UnixMountEntry
pango.AttrClass
glib.PtrArray
gobject.TypeInstance
nice.PseudoTcpCallbacks
gst.ObjectClass
pango.AttrColor
pango.AttrSize
pango.AttrShape
pango.AttrFontFeatures
pango.AttrFontDesc
pango.AttrFloat
pango.Attribute
pango.AttrString
pango.AttrLanguage
pango.AttrInt
pango.LogAttr
pango.Language
pango.Map
pango.MapEntry
pango.IncludedModule
pango.EngineInfo
pango.EngineScriptInfo
nice.InputMessage
nice.OutputMessage
gio.InputMessage
gio.OutputMessage
gstvideo.VideoTimeCodeMeta
gstvideo.VideoGLTextureUploadMeta
gstvideo.VideoAFDMeta
gstvideo.VideoOverlayCompositionMeta
gstvideo.VideoRegionOfInterestMeta
gstvideo.VideoAffineTransformationMeta
gstvideo.VideoColorPrimariesInfo
gstmpegts.T2DeliverySystemCellExtension
gstmpegts.SatelliteDeliverySystemDescriptor
gstmpegts.AtscEITEvent
gstmpegts.AtscStringSegment
gstmpegts.AtscETT
gstmpegts.BAT
gstmpegts.EIT
gstmpegts.DvbMultilingualNetworkNameItem
gstmpegts.ISO639LanguageDescriptor
gstmpegts.LogicalChannelDescriptor
gstmpegts.BATStream
gstmpegts.AtscVCT
gstmpegts.DVBLinkageEvent
gstmpegts.T2DeliverySystemCell
gstmpegts.TOT
gstmpegts.ExtendedEventItem
gstmpegts.ComponentDescriptor
gstmpegts.AtscMultString
gstmpegts.DVBLinkageMobileHandOver
gstmpegts.TerrestrialDeliverySystemDescriptor
gstsdp.SDPBandwidth
gstsdp.SDPAttribute
gstsdp.SDPConnection
gstsdp.MIKEYPayloadSPParam
gstsdp.SDPZone
gstsdp.SDPTime
gstsdp.MIKEYMapSRTP
gstsdp.SDPOrigin
gstsdp.SDPKey
gstrtp.RTPPayloadInfo
gstrtp.RTPSourceMeta
soup.MessageHeadersIter
soup.Range
soup.Connection
soup.MessageQueueItem
soup.MessageQueue
gstgl.GLMemory
gstgl.GLFuncs
gstgl.GLRenderbuffer
gstgl.GLSyncMeta
gstgl.GLBuffer
gstgl.GLMemoryPBO
gstsdp.MIKEYDecryptInfo
gstsdp.MIKEYPayloadT
javascriptcore.ClassVTable
gstaudio.AudioRingBufferSpec
gstaudio.AudioDownmixMeta
gstaudio.AudioCdSrcTrack
gstaudio.AudioClippingMeta
gstaudio.AudioMeta
gstaudio.AudioBuffer
gstaudio.AudioSinkClassExtension
gstaudio.AudioFormatInfo
gdkpixbuf.PixbufModulePattern
gdkpixbuf.PixbufModule
glib.TreeNode
glib.UriParamsIter
gstvideo.VideoBarMeta
gstvideo.VideoMasteringDisplayInfoCoordinates
gstnet.NetControlMessageMeta
gstnet.NetAddressMeta
gstbase.CollectData
gstrtsp.RTSPWatchFuncs
gstcheck.CheckLogFilter
gtk.PrintBackend
gsk.ParseLocation
""""
# some structs like glib.TreeNode are hard, as some functions returns pointers to that struct, and still we need field access!
# same for gtk.PrintBackend

var callerAlloc = (manCallerAlloc & autoCallerAlloc).split.toHashSet
#var callerAlloc = (autoCallerAlloc).split.toHashSet

for s in noCallerAlloc.split:
  callerAlloc.excl(s)

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

proc isString(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  tag == GITypeTag.UTF8 or tag == GITypeTag.FILENAME

type
  GenRecRes = enum
    none
    cstrA
    intA0
    glist
    gslist
    namedAX
    intAX

type
  RecResFlag = enum
    array
    zeroTerminated
    namedA
    unamedA
    cstringA

  RecResFlags = set[RecResFlag]

type
  RecRes = tuple
    name: string
    res: GenRecRes
    childName: string
    infoType: GIInfoType
    namePlain: string
    namePlainNS: string
    name00: string
    flags: RecResFlags
    optOut: bool

type
  GPars = tuple
    plist: string
    arglist: string
    replist: TableRef[string, (string, RecRes)]
    arrLex: string
    blex: string
    tempRes: string
    tempResFree: string
    implRef: string
    tmpoutgobjectarg: string
    outgobjectargname: string 
    outgobjectargisoptional: bool
    outgobjectargmaybenull: bool

proc genPars(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil; genArrayMark = false; tryOut2Ret: bool = false): GPars

# recursive investigate that type -- resolve Arrays and Interfaces
proc newGenRec(t: GITypeInfo; genProxy = false): RecRes =
  result[1] = GenRecRes.none
  result[3] = GIInfoType.INVALID
  var rawmark = ""
  var cAlloc = false
  var newrawmark = ""
  var proxyResult = false
  let p = gTypeInfoIsPointer(t)
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.GLIST:
    let arrayType = gTypeInfoGetParamType(t, 0)
    let atag = gTypeInfoGetTag(arrayType) #  INTERFACE or UTF8
    if atag == GITypeTag.INTERFACE:
      let aface = gTypeInfoGetInterface(arrayType)
      result[3] = gBaseInfoGetType(aface)
    var child = newGenRec(arrayType, genProxy = true).namePlain # [0]
    child = mangleType(mangleName(child))
    result[0] = "ptr glib.List"
    result[1] = glist
    result[2] = child
    result.namePlain = result[0]
    result.namePlainNS = result[0]
    result.name00 = result[0]
    return

  if tag == GITypeTag.GSLIST:
    let arrayType = gTypeInfoGetParamType(t, 0)
    let atag = gTypeInfoGetTag(arrayType) #  INTERFACE or UTF8
    if atag == GITypeTag.INTERFACE:
      let aface = gTypeInfoGetInterface(arrayType)
      result[3] = gBaseInfoGetType(aface)
    var child = newGenRec(arrayType, genProxy = true).namePlain # [0]
    child = mangleType(mangleName(child))
    result[0] = "ptr glib.SList"
    result[1] = gslist
    result[2] = child
    result.namePlain = result[0]
    result.namePlainNS = result[0]
    result.name00 = result[0]
    return

  if tag == GITypeTag.ARRAY:
    result.flags.incl(RecResFlag.array)
    let toa = gTypeInfoGetArrayType(t) # type of array
    if toa == GIArrayType.ARRAY: result[0] = "GArray00"
    elif toa == GIArrayType.PTR_ARRAY: result[0] = "PtrArray00"
    elif toa == GIArrayType.BYTE_ARRAY: result[0] = "ByteArray00"
    elif toa == GIArrayType.C:
      let arrayType = gTypeInfoGetParamType(t, 0)
      let arrayFixedSize = gTypeInfoGetArrayFixedSize(t)
      var child = newGenRec(arrayType).name00 # [0]
      child = mangleType(mangleName(child))
      if arrayFixedSize != -1:
        result[0] = "array[$1, $2]" % [$arrayFixedSize, child]
      else:
        result[0] = "ptr " & child
        result.namePlain = result[0]
        result.namePlainNS = result[0]
        result.name00 = result[0]
        if gTypeInfoIsZeroTerminated(t):
          result.flags.incl(RecResFlag.zeroTerminated)
          result[1] = intA0
        if child in UnnamedArrayCandidates:
          result[1] = intA0 # yes we need this # but is wrong, see g_base64_decode
          if not gTypeInfoIsZeroTerminated(t):
            result[1] = intAX
          result.flags.incl(RecResFlag.unamedA)
        if child in ["TargetEntry00", "PageRange", "KeymapKey"]:
          result.flags.incl(RecResFlag.namedA)
        if result[0] == "ptr cstring":
          result.flags.incl(RecResFlag.cstringA)
        return
  elif tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
    if gBaseInfoGetType(iface) == GIInfoType.CALLBACK:
      if gBaseInfoGetName(iface)[0].isLowerAscii:
        result[0] = "proc" & genPars(iface)[0] & " {.cdecl.}"
      else:
        result[0] = mangleName(gBaseInfoGetName(iface))
    else:
      result[0] = mangleName($gBaseInfoGetName(iface))
      cAlloc = callerAlloc.contains(ns & '.' & result[0])
      if gBaseInfoGetType(iface) in {GIInfoType.INTERFACE, Object, STRUCT, UNION} and not callerAlloc.contains(ns & '.' & result[0]):
        newrawmark = "00"
      if gBaseInfoGetType(iface) in {GIInfoType.INTERFACE, Object, STRUCT, UNION}:
        proxyResult = genProxy
        if not (genProxy or callerAlloc.contains(ns & '.' & result[0])):
          rawmark = "00"
      result.namePlainNS = fixedModName(ns) & '.' & result[0]
      if ns != moduleNamespace: #fullQualified or ns != moduleNamespace:
        result[0] = fixedModName(ns) & '.' & result[0]
  else:
    result[0] = $gTypeTagToString(tag)
  result[0] = mangleType(result[0])
  result.namePlain = result[0]
  if result.namePlainNS.len == 0:
    result.namePlainNS = result.namePlain
  if p and newrawmark.len == 0 and not cAlloc:
    result.namePlain = "ptr " & result.namePlain
    result.namePlainNS = "ptr " & result.namePlainNS
  result.namePlain = mangleType(result.namePlain)
  result.namePlainNS = mangleType(result.namePlainNS)
  result.name00 = result[0] # & newrawmark
  if p:
    result.name00 = "ptr " & result.name00
  result.name00 = mangleType(result.name00)
  result.name00 = result.name00 & newrawmark
  if p and (not proxyResult):
    result[0] = "ptr " & result[0]
  result[0] = mangleType(result[0]) & rawmark

proc modPrefix(t: GITypeInfo; sym: string; full = true): string =
  if sym in ["gtk_renderer_cell_accessible_new", "gtk_mount_operation_new", "gtk_notebook_page_accessible_new"]:
  #  return fixedModName("gtk") & "."
  #if sym == "gtk_mount_operation_new":
  #  return fixedModName("gtk") & "."
  #if sym == "gtk_notebook_page_accessible_new":
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
    assert(gBaseInfoGetType(iface) != GIInfoType.CALLBACK)
    var ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
    if ns != moduleNamespace:
      result = fixedModName(ns) & "."

proc isProxyCandidate(t: GITypeInfo): bool =
  let tag = gTypeInfoGetTag(t)
  if tag == GITypeTag.INTERFACE:
    let iface = gTypeInfoGetInterface(t)
    let ns = ($gBaseInfoGetNamespace(iface)).toLowerAscii
    if callerAlloc.contains(ns & '.' & $gBaseInfoGetName(iface)): return false
    result = gBaseInfoGetType(iface) in {GIInfoType.INTERFACE, OBJECT, STRUCT, UNION}

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

proc needTypeConv(str: string; r: RecRes): bool =
  if str in "uint32 int32 cstring gboolean".split:
    return true
  if RecResFlag.array in r.flags:
    var s = str
    s.removeSuffix("Array")
    s.removePrefix("ptr ")
    if s in "uint32 int32 cstring uint8 TargetEntry00 KeymapKey PageRange".split:
      return true

proc doTypeConv(str: string; r: RecRes): string =
  if RecResFlag.array in r.flags:
    var s = str
    s.removePrefix("ptr ")
    s.removeSuffix("Array")
    result =
      case s
      of "cstring": "seq[string]"
      of "int32": "seq[int32]"
      of "uint32": "seq[uint32]"
      of "uint8": "seq[uint8]"
      of "TargetEntry00": "seq[TargetEntry]"
      of "KeymapKey": "seq[KeymapKey]"
      of "PageRange": "seq[PageRange]"
      else: ""
  else:
    result =
      case str
      of "uint32": "int"
      of "int32": "int"
      of "cstring": "string"
      of "gboolean": "bool"
      else: ""

proc doCt3nt(str: string; r: RecRes): string =
  if RecResFlag.array in r.flags:
    var s = str
    s.removeSuffix("Array")
    s.removePrefix("ptr ")
    result =
      case s
      of "cstring": "cstringArrayToSeq"
      of "TargetEntry00": "targetEntryArrayToSeq"
      of "KeymapKey": "keymapKeyArrayToSeq"
      of "PageRange": "pageRangeArrayToSeq"
      else: ""
  else:
    result =
      case str
      of "cstring": "$"
      of "gboolean": "toBool"
      else: ""
  if result.len == 0:
    result = doTypeConv(str, r)
    if result.len == 0:
      result = str

proc fixedName(s: string): string =
  if s.startsWith("Ptr "):
    result = s.replace("Ptr ")
    result = result.capitalizeAscii & "Array"
  else:
    return s

proc fixedName2(s: string): string =
  if s.startsWith("ptr "):
    result = s.replace("ptr ")
    result = result & "Array"
  else:
    return s

proc genPars(info: GICallableInfo; genProxy = false; binfo: GIBaseInfo = nil; genArrayMark = false; tryOut2Ret: bool = false): GPars =

  proc makePList(s: seq[(string, string)]; self, r: string): string =
    result = self
    for i in s:
      result.add(i[0] & ": " & i[1] & "; ")
    if result[^1] == ' ':
      result.setLen(result.len - 2)
    result.add(")")
    result.add(r)

  var self: string = "("
  var resusres: string
  var resus: seq[(string, string)]
  var resusLen = -1
  var resusIn: bool
  result.replist = newTable[string, (string, RecRes)]()
  var lastName: string
  let m = gCallableInfoGetNArgs(info) - 1
  var sym = ""
  if isFunctionInfo(info):
    sym = $gFunctionInfoGetSymbol(info)
  if binfo.isNil or not gCallableInfoIsMethod(info):
    result.arglist = "("
  else:
    var ns = ($gBaseInfoGetNamespace(binfo)).toLowerAscii
    if callerAlloc.contains(ns & '.' & manglename(gBaseInfoGetName(binfo))):
      self = "(self: " & manglename(gBaseInfoGetName(binfo)) & "; "
      result.arglist = "(self"
    else:
      var refFunc: string = "" # default
      if genProxy and gCallableInfoGetInstanceOwnershipTransfer(info) == GITransfer.EVERYTHING:
        if callerAlloc.contains(($gBaseInfoGetNamespace(binfo)).toLowerAscii & "." & $gBaseInfoGetName(binfo)):
          discard
        elif false: # r == "gobject.Value":
          discard
        elif gBaseInfoGetType(binfo) in [GIInfoType.Enum, GIInfoType.Flags]:
          discard
        elif gBaseInfoGetType(binfo) == GIInfoType.Object:
          if gObjectInfoGetFundamental(binfo) == GFalse:
            refFunc = "g_object_ref("
          else:
            refFunc = $gObjectInfoGetRefFunction(binfo) & '('
        elif gRegisteredTypeInfoGetGType(binfo) == G_TYPE_NONE:
          assert(gBaseInfoGetType(binfo) == GIInfoType.Struct)
          # result.implRef = "  result.ignoreFinalizer = true # !!!"
          # echo "aaa", sym # g_strv_builder_unref or g_strv_builder_unref, we ignore that for now
        elif gRegisteredTypeInfoGetGType(binfo) != G_TYPE_NONE:
          if gTypeFundamental(gRegisteredTypeInfoGetGType(binfo)) == G_TYPE_INTERF:
            refFunc = "g_object_ref("
          elif gTypeFundamental(gRegisteredTypeInfoGetGType(binfo)) == G_TYPE_BOXED:
            var getTypeProc = $gRegisteredTypeInfoGetTypeInit(binfo)
            refFunc = "g_boxed_copy(" & getTypeProc & "(), "
          else:
            # echo "bbb"
            discard#result.implRef = "  result.ignoreFinalizer = true # GVariant"

      ## only for very few procs the instance variable itself can be NULL in GTK. We assume non NULL and may provide an overload.
      var arg0: string
      if refFunc != "":
        arg0 = refFunc & "self.impl))"
      else:
        arg0 = "self.impl)"
      result.arglist = "(cast[ptr " & manglename(gBaseInfoGetName(binfo)) & "00](" &
          arg0 # "self.impl)" # https://discourse.gnome.org/t/g-arg-info-may-be-null-for-the-instace-itself/3284/7
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
      result.arglist.add(", ")
  var num = ""
  for j in 0 .. m:
    let arg = gCallableInfoGetArg(info, j)
    var  argName = mangleName(gBaseInfoGetName(arg))

    var isGObject = false
    let tt = gArgInfoGetType(arg)
    let tag = gTypeInfoGetTag(tt)
    if tag == GITypeTag.INTERFACE:
      let iface = gTypeInfoGetInterface(tt)
      if gBaseInfoGetType(iface) == GIInfoType.INTERFACE or (gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse): # v0.9.4
      # https://github.com/StefanSalewski/gintro/issues/172
      #if gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse: # does not work for gtk_tree_selection_get_selected()
        if gArgInfoGetDirection(arg) == GIDirection.OUT:
          isGObject = true

    var refFunc: string = "" # default
    var nameimpl: string
    if genProxy and tag == GITypeTag.INTERFACE and
    ((gArgInfoGetOwnershipTransfer(arg) == GITransfer.EVERYTHING and gArgInfoGetDirection(arg) == GIDirection.IN) or
    (gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING and gArgInfoGetDirection(arg) == GIDirection.OUT)):
      let iface = gTypeInfoGetInterface(tt)
      if callerAlloc.contains(($gBaseInfoGetNamespace(iface)).toLowerAscii & "." & $gBaseInfoGetName(iface)):
        discard
      elif gBaseInfoGetType(iface) in [GIInfoType.Enum, GIInfoType.Flags]:
        discard
      elif gBaseInfoGetType(iface) == GIInfoType.Object:
        if gObjectInfoGetFundamental(iface) == GFalse:
          refFunc = "g_object_ref("
        else:
          refFunc = $gObjectInfoGetRefFunction(iface) & '('
      elif gRegisteredTypeInfoGetGType(iface) == G_TYPE_NONE:
        assert(gBaseInfoGetType(iface) == GIInfoType.Struct)
        # echo "xxx", sym #result.implRef = "  result.ignoreFinalizer = true # !!!"
      elif gRegisteredTypeInfoGetGType(iface) != G_TYPE_NONE:
        if gTypeFundamental(gRegisteredTypeInfoGetGType(iface)) == G_TYPE_INTERF:
          refFunc = "g_object_ref("
        elif gTypeFundamental(gRegisteredTypeInfoGetGType(iface)) == G_TYPE_BOXED:
          var getTypeProc = $gRegisteredTypeInfoGetTypeInit(iface)
          refFunc = "g_boxed_copy(" & getTypeProc & "(), "
        else:
          discard # echo "yyy", sym#result.implRef = "  result.ignoreFinalizer = true # GVariant"
    if refFunc.len > 0:
      nameimpl = refFunc & "$1.impl)"
    else:
      nameimpl = "$1.impl"
    var out2Ret = false
    if tryOut2Ret:
      let match = if gCallableInfoIsMethod(info): 1 else: 0
      out2ret = (gCallableInfoGetNArgs(info) + match) == 2 and (j + match) == 1 and gTypeInfoGetTag(gCallableInfoGetReturnType(info)) == GITypeTag.VOID and gArgInfoGetDirection(arg) == GIDirection.OUT
      if out2ret:# and genProxy:
        argName = "result"
    let t = gArgInfoGetType(arg)
    let mayBeNil = gArgInfoMayBeNull(arg)
    var ngr = newGenRec(t, true)
    var str: string
    if genProxy and not gArgInfoIsCallerAllocates(arg):
      str = ngr.namePlain
    else:
      str = ngr.name00
    if genProxy and ngr.res == glist:
      result.tempRes = "  var tempResGL = seq2GList($1)\n" % [argname]
      if gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING:
        result.tempResFree = "  g_list_free(tempResGL)\n"
      if str.startsWith("var "):
        str = "var seq[$1]" % [ngr.childname]
      else:
        str = "seq[$1]" % [ngr.childname]

    if genProxy and ngr.res == gslist:
      result.tempRes = "  var tempResGL = seq2GSList($1)\n" % [argName]
      if gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING:
        result.tempResFree = "  g_slist_free(tempResGL)\n"
      if str.startsWith("var "):
        str = "var seq[$1]" % [ngr.childname]
      else:
        str = "seq[$1]" % [ngr.childname]

    if (ngr.flags * {RecResFlag.unamedA, namedA} != {}) and genProxy and not gTypeInfoIsZeroTerminated(t):
      assert ngr.flags.contains(RecResFlag.array)
      assert not (ngr.flags.contains(RecResFlag.zeroTerminated))
      resusLen = gTypeInfoGetArrayLength(t)
      if resusLen >= 0:
        resusIn = gArgInfoGetDirection(gCallableInfoGetArg(info, resusLen.cint)) == GIDirection.IN
      lastName = argName
    if (sym.startsWith("gtk_widget_set_events", "gtk_widget_add_events")) and str == "int32":
      str = fixedModName("gdk") & ".EventMask"
    if isSignalInfo(info) and isProxyCandidate(t) and not genProxy:
      str.insert("ptr ")
    var userAlloc: bool
    var hhh = ngr.namePlainNS
    if hhh.startsWith("gtk4", "gdk4"):
      hhh.delete(3, 3)
    if callerAlloc.contains(hhh):
      userAlloc = true
      str = ngr.namePlain
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
    if sym in ["g_strv_length", "g_strfreev"]: # wrong but we don't fix it, as with fix str would not match flags
      discard #echo str, " xxxxxxxxxxxxxxxxx"
      #str = "cstringArray"

    var name = argName#mangleName(gBaseInfoGetName(arg))

    if isProxyCandidate(t) and not gArgInfoIsCallerAllocates(arg) and not userAlloc:

      if mayBeNil and gArgInfoGetDirection(arg) != GIDirection.OUT:
        # result.arglist.add("if " & name & ".isNil: nil else: cast[" & ngr.name00 & "](" & name & ".impl)")
        result.arglist.add("if " & name & ".isNil: nil else: cast[" & ngr.name00 & "](" & (nameimpl % [name]) & ")")
      else:
        if isGobject:
          if gArgInfoIsOptional(arg):
            result.arglist.add("cast[var " & ngr.name00 & "](if addr(" & name & ") == nil: nil else: addr tmpoutgobjectarg)")
          else:
            result.arglist.add("tmpoutgobjectarg")
          result.tmpoutgobjectarg = "  var tmpoutgobjectarg: " & ngr.name00 & "\n"
          result.outgobjectargname = argName
          result.outgobjectargisoptional = gArgInfoIsOptional(arg)
          result.outgobjectargmaybenull = gArgInfoMayBeNull(arg)
        elif gArgInfoGetDirection(arg) == GIDirection.OUT and gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING:
          if gArgInfoIsOptional(arg): # INOUT i.e. for gst_gl_ensure_element_data
            result.arglist.add("cast[var " & ngr.name00 & "](if addr(" & name & ") == nil: nil else: addr " & name & ".impl)")
          else:
            result.arglist.add("cast[var " & ngr.name00 & "](addr " & name & ".impl)")
          result.tempResFree.add("  " & name & ".impl = cast[" & ngr.name00 & "](" & (nameimpl % [name]) & ")\n")
        elif gArgInfoGetDirection(arg) == GIDirection.OUT or gArgInfoGetDirection(arg) == GIDirection.INOUT:
          if gArgInfoIsOptional(arg): # INOUT i.e. for gst_gl_ensure_element_data
            result.arglist.add("cast[var " & ngr.name00 & "](if addr(" & name & ") == nil: nil else: addr " & name & ".impl)")
          else:
            result.arglist.add("cast[var " & ngr.name00 & "](addr " & name & ".impl)")
        else:
          #assert false
          # result.arglist.add("cast[" & ngr.name00 & "](" & name & ".impl)")
          result.arglist.add("cast[" & ngr.name00 & "](" & (nameimpl % [name]) & ")")
    else:
      if ngr.res == glist:
        result.arglist.add("tempResGL")
      elif ngr.res == gslist:
        result.arglist.add("tempResGL")

      elif ngr.flags.contains(RecResFlag.unamedA) and (gArgInfoGetDirection(arg) == GIDirection.IN or gArgInfoIsCallerAllocates(arg)):
        assert ngr.flags.contains(RecResFlag.array)
        result.arglist.add("cast[" & ngr.name00 & "](unsafeaddr($1[0]))" % name)
      elif (ngr.flags * {RecResFlag.namedA, cstringA} != {}) and gArgInfoGetDirection(arg) == GIDirection.IN:
        assert ngr.flags.contains(RecResFlag.array)
        result.arglist.add("seq2$1" % [str.replace("00").capitalizeAscii.fixedName] & '(' & name & ", " & StringArrayName &
            "$1)" % [num])
        num = "2"
      elif needTypeConv(str, ngr) and gArgInfoGetDirection(arg) in {GIDirection.OUT, GIDirection.INOUT}:
        result.arglist.add(name.strip(chars = {'`'}) & "_00")
      elif needTypeConv(str, ngr):
        if str == "cstring" and mayBeNil:
          # result.arglist.add("safeStringToCString" & '(' & name & ')')
          result.arglist.add(name) # v0.9.4
        else:
          if str != "string" and str != "cstring":
            result.arglist.add(str & '(' & name & ')')
          else:
            result.arglist.add(name)
      else:
        result.arglist.add(name)
    if not genProxy and needTypeConv(str, ngr) and (str != "cstring" or gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT}):
      result.replist[$name] = (fixedName2($str), ngr)
    var needVar = true
    if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} and not (ngr.flags.contains(RecResFlag.unamedA) and
        gArgInfoIsCallerAllocates(arg)):
      needVar = true

    if sym in ["nice_agent_recv", "nice_agent_recv_nonblocking"] and name == "bufLen": # https://discourse.gnome.org/t/nice-agent-recv/5747/2
      needVar = false

    if genProxy and needTypeConv(str, ngr):
      if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} and (not gArgInfoIsCallerAllocates(arg) or (str in ["int32",
          "uint32", "ptr cstring", "cstring"])):
        if gArgInfoGetDirection(arg) in {GIDirection.OUT}:
          ngr.optOut = true
        result.replist[$name] = (fixedName2($str), ngr)
      if gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} or str != "cstring": # new in 0.4.11 -- allow passing cstring if not a var
        str = doTypeConv(str, ngr)
        if ngr.flags.contains(RecResFlag.unamedA) and gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT}:
          str.insert("var ")
          needVar = false
    if needVar and gArgInfoGetDirection(arg) in {GIDirection.OUT, INOUT} and not (ngr.flags.contains(RecResFlag.unamedA) and
        gArgInfoIsCallerAllocates(arg)):
      str.insert("var ")
    if genProxy and defaultParameters.contains(sym):
      for hhh in defaultParameters[sym].split('|'):
        var h1, h2, h3: string
        (h1, h2, h3) = hhh.split
        if name == h1 and str == h2:
          str.add(" = " & h3)

    #if genProxy and (str == "string" or str == "cstring") and mayBeNil and not sym.contains("_button_new_with_label"):
    #  str.add(" = \"\"")
    # v0.9.4
    if genProxy and (str == "string") and mayBeNil and not sym.contains("_button_new_with_label"):
      str.add(" = \"\"")
    if genProxy and (str == "cstring") and mayBeNil and not sym.contains("_button_new_with_label"):
      str.add(" = nil")

    if genProxy and m == 0:
      if sym.contains("_set_") and str == "bool":
        str.add(" = true")
    if genProxy and isProxyCandidate(t) and mayBeNil and gArgInfoGetDirection(arg) notin {GIDirection.OUT, INOUT}:
      str.add(" = nil")
    when false:
      if genProxy and gArgInfoIsOptional(arg) and gArgInfoGetDirection(arg) == GIDirection.INOUT:
        # very few like argc and argv -- we ignore them for now
        echo ">>>", sym, " ", mangleName(gBaseInfoGetName(arg))
    if genProxy and gArgInfoIsOptional(arg) and gArgInfoGetDirection(arg) in {GIDirection.OUT} and not sym.startsWith("gdk_event_get"):
      # https://github.com/nim-lang/Nim/issues/15895
      assert(str.startsWith("var "))
      var h = str[4 .. ^1]
      let l = h.find('|')
      if l > 0:
        h.setlen(l - 1)
        h = h[1 .. ^1]
      # str.add(" = cast[ptr $1](nil)[]" % [h])
      str.add(" = cast[var $1](nil)" % [h]) # same, see https://forum.nim-lang.org/t/7117
    if (genProxy or sym == "pango_extents_to_pixels") and isFunctionInfo(info) and (gFunctionInfoGetFlags(info).int and
            GIFunctionInfoFlags.WRAPS_VFUNC.ord) == 0:
      if userAlloc and mayBeNil: # or (sym == "gdk_window_set_geometry_hints" and str == "Geometry"): # gir bug!
        var h = str
        h.removePrefix("var ")
        # str.add(" = cast[ptr " & h & "](nil)[]")
        str.add(" = cast[var " & h & "](nil)") # the same as above
    #if str == "var seq[string]": no var varargs support!
    if str == "seq[string]":
      if j == m:
        str = "varargs[string, `$`]"
      else:
        str = "openArray[string]"
    if str == "seq[uint8]": # allow to pass a string for a seq[uint8] argument too
      # str = "seq[uint8] | openArray[char]" # maybe also seq[int8] and seq[char] ? # https://github.com/nim-lang/Nim/issues/15128
      str = "seq[uint8] | string"
    if str == "var seq[uint8]": # allow to pass a string for a seq[uint8] argument too
      str = "var (seq[uint8] | string)"
      # str = "var (seq[uint8] | openArray[char])" # https://github.com/nim-lang/Nim/issues/15128
    if genArrayMark and ngr.flags.contains(RecResFlag.array) and str.startsWith("ptr "):
      str.removePrefix("ptr ")
      str.add("Array")
    if not out2Ret:#(out2ret and genProxy):
      resus.add((name, str))
    else:
      var h = str
      let i = h.find('=')
      if i > 0:
        h.setLen(i) # well i - 1 , try find(" =")
      h.removePrefix("var ")
      resusres = ": " & h#str.dup(removePrefix("var "))
    if j < m:
      result.arglist.add(", ")

  if not genProxy and gCallableInfoCanThrowGerror(info):
    resus.add(("error", "ptr ptr glib.Error = nil"))
  result.arglist.add(')')
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
          result.blex = resus[resusLen][0]
          assert(resusIn)
          let h = resus[resusLen][1].replace("var ", "")
          result.arrLex = "  let $1 = $2($3.len)\n" % [resus[resusLen][0], h, lastName]
          resus.delete(resusLen)
        result.plist = makePList(resus, self, resusres).isplit(sym.len + "proc".len)
        return result

  var ngrRet = newGenRec(ret, true)
  var r: string
  if genProxy:
    r = ngrRet.namePlain
  else:
    r = ngrRet.name00
  if genProxy and ngrRet.res == glist:
    r = "seq[$1]" % [ngrRet.childname]
  if genProxy and ngrRet.res == gslist:
    r = "seq[$1]" % [ngrRet.childname]

  var hhh = ngrRet.namePlainNS

  var refFunc: string = "" # default
  if genProxy and gTypeInfoGetTag(ret) != GITypeTag.VOID:
    var tag = gTypeInfoGetTag(ret)
    if genProxy and tag == GITypeTag.INTERFACE:
      let iface = gTypeInfoGetInterface(ret)
      if callerAlloc.contains(($gBaseInfoGetNamespace(iface)).toLowerAscii & "." & $gBaseInfoGetName(iface)):
        discard
      elif r == "gobject.Value":
        discard
      elif gBaseInfoGetType(iface) in [GIInfoType.Enum, GIInfoType.Flags]:
        discard
      elif gBaseInfoGetType(iface) == GIInfoType.Object:
        if gObjectInfoGetFundamental(iface) == GFalse:
          refFunc = "g_object_ref("
        else:
          refFunc = $gObjectInfoGetRefFunction(iface) & '('
      elif gRegisteredTypeInfoGetGType(iface) == G_TYPE_NONE:
        assert(gBaseInfoGetType(iface) == GIInfoType.Struct)
        result.implRef = "  result.ignoreFinalizer = true"
      elif gRegisteredTypeInfoGetGType(iface) != G_TYPE_NONE:
        if gTypeFundamental(gRegisteredTypeInfoGetGType(iface)) == G_TYPE_INTERF:
          refFunc = "g_object_ref("
        elif gTypeFundamental(gRegisteredTypeInfoGetGType(iface)) == G_TYPE_BOXED:
          var getTypeProc = $gRegisteredTypeInfoGetTypeInit(iface)
          refFunc = "g_boxed_copy(" & getTypeProc & "(), "
        else:
          result.implRef = "  result.ignoreFinalizer = true # GVariant"
    if refFunc.len > 0:
      result.implRef = ("  result.impl = cast[typeof(result.impl)](" & refFunc & "result.impl))")

  if hhh.startsWith("gtk4", "gdk4"):
    hhh.delete(3, 3)
  if gTypeInfoIsPointer(ret) and callerAlloc.contains(hhh) and (not r.startsWith("ptr")):
    r = "ptr " & r
  if r != "void":
    if genProxy:
      let h = doTypeConv(r, ngrRet)
      if h.len > 0:
        r = h
    resusres = ": " & r
  if resusLen >= 0:
    result.blex = resus[resusLen][0]
    if resusIn:
      let h = resus[resusLen][1].replace("var ", "")
      result.arrLex = "  let $1 = $2($3.len)\n" % [resus[resusLen][0], h, lastName]
      resus.delete(resusLen)
    else:
      result.arrLex = ""
  result.plist = makePList(resus, self, resusres).isplit(sym.len + "proc".len)

# see also template findFreeProc()
# g_object_unref
proc findFreeObject(info: GIBaseInfo): string =
  assert(gBaseInfoGetType(info) == GIInfoType.Object or gBaseInfoGetType(info) == GIInfoType.INTERFACE)
  #assert(gObjectInfoGetFundamental(info) == GTrue)
  var parent = info
  while true:
    let h = g_object_info_get_parent(parent)
    if h == nil:
      break
    parent = h
  var f = $g_object_info_get_unref_function(parent)
  return f # empty string for all true gobjects, only not empty for GParamSpec and a few more, see grep "unref-func" /usr/share/gir-1.0/*

proc writeMethod(info: GIBaseInfo; minfo: GIFunctionInfo) =

  template checkForGerror(): untyped =
    methodBuffer.write(pars.tempResFree)
    if gCallableInfoCanThrowGerror(minfo):
      methodBuffer.writeLine("  if gerror != nil:")
      methodBuffer.writeLine("    let msg = $gerror.message")
      methodBuffer.writeLine("    g_error_free(gerror[])")
      methodBuffer.writeLine("    raise newException(GException, msg)")

  # new for v0.8.8
  template dothegobjectargmagic(): untyped =
    if pars.outgobjectargisoptional:
      methodBuffer.writeLine("""
  if addr($1) != nil:
    $1 = nil
""" % [pars.outgobjectargname])
    elif pars.outgobjectargmaybenull:
      methodBuffer.writeLine("  $1 = nil" % [pars.outgobjectargname])
    if pars.outgobjectargisoptional or pars.outgobjectargmaybenull:
      methodBuffer.writeLine("""
  if tmpoutgobjectarg != nil:
    let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
    if argqdata != nil:
      $1 = cast[type($1)](argqdata)
      assert($1.impl == tmpoutgobjectarg)
    else:
      fnew($1, $2.finalizeGObject)
      $1.impl = tmpoutgobjectarg
      GC_ref($1)
      if g_object_is_floating($1.impl).int != 0:
        discard g_object_ref_sink($1.impl)
      g_object_add_toggle_ref($1.impl, toggleNotify, addr($1[]))
      g_object_unref($1.impl)
      assert(g_object_get_qdata($1.impl, Quark) == nil)
      g_object_set_qdata($1.impl, Quark, addr($1[]))
""" % [pars.outgobjectargname, fixedModName(moduleNamespace)])
    else:
      methodBuffer.writeLine("""
  let argqdata = g_object_get_qdata(tmpoutgobjectarg, Quark)
  if argqdata != nil:
    $1 = cast[type($1)](argqdata)
    assert($1.impl == tmpoutgobjectarg)
  else:
    fnew($1, $2.finalizeGObject)
    $1.impl = tmpoutgobjectarg
    GC_ref($1)
    if g_object_is_floating($1.impl).int != 0:
      discard g_object_ref_sink($1.impl)
    g_object_add_toggle_ref($1.impl, toggleNotify, addr($1[]))
    g_object_unref($1.impl)
    assert(g_object_get_qdata($1.impl, Quark) == nil)
    g_object_set_qdata($1.impl, Quark, addr($1[]))
""" % [pars.outgobjectargname, fixedModName(moduleNamespace)])

  # new for v0.7.8: we ref all gobjects now, even if transfer is none. So result.ignoreFinalizer = false always for gobjects!
  template gobjectTemp(): untyped =
    assert sym notin ["g_object_ref_sink", "g_object_ref"]
    assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.NOTHING, EVERYTHING}) # both occur
    methodBuffer.write(pars.tempRes)
    methodBuffer.writeLine("  let gobj = " & sym & pars.arglist)
    checkForGerror()
    if gCallableInfoMayReturnNull(minfo):
      methodBuffer.writeLine("  if gobj.isNil:")
      methodBuffer.writeLine("    return nil") # https://github.com/StefanSalewski/gintro/issues/63
    methodBuffer.writeLine("  let qdata = g_object_get_qdata(gobj, Quark)")
    methodBuffer.writeLine("  if qdata != nil:") # gtk_widget_get_toplevel, gdk_display_get_default, gtk_widget_get_window
    #if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
    #  methodBuffer.writeLine("    assert false") # constructors should always allocate new objects -- lets verify that
    # no, will fail i.e. for gdk_cursor_new_from_name()
    methodBuffer.writeLine("    result = cast[type(result)](qdata)")
    methodBuffer.writeLine("    assert(result.impl == gobj)")
    methodBuffer.writeLine("  else:")
    #assert((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0 or
    #  gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING)
    methodBuffer.writeLine("    fnew(result, $1finalizeGObject)" % [mprefix])
    methodBuffer.writeLine("    result.impl = gobj")
    methodBuffer.writeLine("    GC_ref(result)")
    if sym in ["gtk_window_new", "gtk_application_window_new"]: # GC_ref() so we never free the main window!
      methodBuffer.writeLine("    GC_ref(result)")
      methodBuffer.writeLine("    result.ignoreFinalizer = true")
    elif gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING:
      methodBuffer.writeLine("    discard g_object_ref_sink(result.impl)")
    else:
      methodBuffer.writeLine("    if g_object_is_floating(result.impl).int != 0:")
      methodBuffer.writeLine("      discard g_object_ref_sink(result.impl)")
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
          if sym notin ["g_enum_complete_type_info", "g_flags_complete_type_info"]:
            # see https://discourse.gnome.org/t/what-is-wrong-with-g-enum-complete-type-info-and/4489
            echo "Caution: No free/unref found for ", ' ', " (", sym, ')'
        else:
          #if gBaseInfoGetName(info) notin ["Variant", "VariantType"]: # seems for glib.GVariant we have to guess -- or maybe just know

          if gBaseInfoGetName(info) notin ["Variant", "VariantType"] and # looks ugly, so hide for v0.8.7, investigate later...
            sym notin ["soup_xmlrpc_parse_request", "gst_audio_resampler_new", "gst_rtsp_connection_accept", "gst_rtsp_connection_create_from_socket", "gst_rtsp_connection_create", "gst_sdp_media_copy", "gst_sdp_media_new"]:

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

  template block8(prochead: string; errorcheckadd: bool; tryOut2Ret: bool): untyped =
    if isProxyCandidateret2:
      assert (gCallableInfoGetCallerOwns(minfo) in {GITransfer.NOTHING, GITransfer.EVERYTHING}) # both occur
    if asym == "newFromStreamAsync" and sym.startsWith("gdk_pixbuf_animation_new"):
      asym = "newAnimationFromStreamAsync"
    if prochead.len == 0:
      methodBuffer.writeLine("\nproc " & asym & EM & pars.plist & " =")
    else:
      methodBuffer.writeLine(prochead)
    if not isProxyCandidateret2:
      methodBuffer.write(pars.tempRes)
    methodBuffer.write(pars.arrLex)
    methodBuffer.write(sss)
    var freeMeName{.inject.}: string
    var boxedFreeMeName{.inject.}: string
    for j in 0.cint ..< gCallableInfoGetNArgs(minfo):
      freeMeName = ""
      boxedFreeMeName = ""
      let arg = gCallableInfoGetArg(minfo, j)
      let t = gArgInfoGetType(arg)
      var ngrt = newGenRec(t)

      var isGObject = false
      let tt = gArgInfoGetType(arg)
      let tag = gTypeInfoGetTag(tt)
      if tag == GITypeTag.INTERFACE:
        let iface = gTypeInfoGetInterface(tt)
        #if gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse: # before v0.9.4
        if gBaseInfoGetType(iface) == GIInfoType.INTERFACE or (gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse):
          if gArgInfoGetDirection(arg) == GIDirection.OUT:
            isGObject = true

      if false: # for v0.9.3 we use g_object_ref(), g_boxed_copy and such, see https://discourse.gnome.org/t/get-ref-function-for-none-gobject-classes-like-gtkexpression/6696/15
      #if true: # https://discourse.gnome.org/t/gtk-no-selection-new/6576
      #if ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0):
        if gArgInfoGetDirection(arg) == GIDirection.IN and gArgInfoGetOwnershipTransfer(arg) == GITransfer.EVERYTHING and
          isProxyCandidate(t) and not callerAlloc.contains(ngrt.namePlainNS):
          # like gtk_widget_add_controller()
          let n = mangleName(gBaseInfoGetName(arg))
          if gArgInfoMayBeNull(arg): # and prochead.len != 0: # wrong to be compatible with 0.8.6
            methodBuffer.writeLine("  if " & n & " != nil:")
            methodBuffer.writeLine("    " & n & ".ignoreFinalizer = true")
          else:
            methodBuffer.writeLine("  " & n & ".ignoreFinalizer = true")

      if isGobject:
        discard

      elif gArgInfoGetDirection(arg) == GIDirection.OUT and isProxyCandidate(t) and
        not callerAlloc.contains(ngrt.namePlainNS) and not gArgInfoIsCallerAllocates(arg):
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
            var freeMe{.inject.}: GIFunctionInfo
            findFreeProc(info, gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING)
        var h2 = mangleName(gBaseInfoGetName(arg))

        if tryOut2Ret:
          let match = if gCallableInfoIsMethod(minfo): 1 else: 0
          let out2ret = (gCallableInfoGetNArgs(minfo) + match) == 2 and (j + match) == 1 and gTypeInfoGetTag(gCallableInfoGetReturnType(minfo)) == GITypeTag.VOID and gArgInfoGetDirection(arg) == GIDirection.OUT
          if out2ret:# and genProxy:
            h2 = "result"

        if gArgInfoMayBeNull(arg):
          nilArgFix.add(h2)
        if gArgInfoIsOptional(arg):
          methodBuffer.writeLine("  if addr($2) != nil:" % [ngrt.namePlain, h2])
          if boxedFreeMeName != "":
            methodBuffer.writeLine("    fnew(" & h2 & ", " & boxedFreeMeName & ")")
          elif freeMeName == "":
            # never executed
            methodBuffer.writeLine("    new(" & h2 & ")")
          else:
            methodBuffer.writeLine("    fnew(" & h2 & ", " & freeMeName & ")")
        else:
          if boxedFreeMeName != "":
            methodBuffer.writeLine("  fnew(" & h2 & ", " & boxedFreeMeName & ")")
          elif freeMeName == "":
            # never executed
            methodBuffer.writeLine("  new(" & h2 & ")")
          else:
            methodBuffer.writeLine("  fnew(" & h2 & ", " & freeMeName & ")")
        if false: # for v0.9.3 we use g_object_ref(), g_boxed_copy and such, see https://discourse.gnome.org/t/get-ref-function-for-none-gobject-classes-like-gtkexpression/6696/15
        # if gArgInfoGetOwnershipTransfer(arg) == GITransfer.NOTHING:
          if gArgInfoIsOptional(arg):
            methodBuffer.writeLine("  if addr($2) != nil:" % [ngrt.namePlain, h2])
            methodBuffer.writeLine("    " & h2 & ".ignoreFinalizer = true")
          else:
            methodBuffer.writeLine("  " & h2 & ".ignoreFinalizer = true") # as we have always to attach one with ARC.
    if gCallableInfoCanThrowGerror(minfo):
      methodBuffer.writeLine("  var gerror: ptr glib.Error")
      if errorcheckadd:
        pars.arglist.insert(", addr gerror", pars.arglist.high)
    var multi = ""
    for k, v in pars.replist:
      if v[1].flags * {RecResFlag.namedA, cstringA} != {}:
        assert v[1].flags.contains(RecResFlag.array)
        methodBuffer.writeLine("  var $1x$2: array[$3, pointer]" % [StringArrayName, multi, $StringArrayEntries])
        methodBuffer.writeLine("  var $1$2: cstringArray = cast[cstringArray](addr $1x$2)" % [StringArrayName, multi])
        methodBuffer.writeLine("  var $1_00 = seq2$2($3, $4$5)" % [k.strip(chars = {'`'}), v[0].replace("00").capitalizeAscii, k,
            StringArrayName, multi])
        if multi == "":
          multi = "1"
      elif v[1].flags.contains(RecResFlag.unamedA):
        assert v[1].flags.contains(RecResFlag.array)
        methodBuffer.writeLine("  var $1_00: $2" % [k.strip(chars = {'`'}), v[1].name00])
      else:
        if v[1].optOut:
          methodBuffer.writeLine("  var $1_00: $2" % [k.strip(chars = {'`'}), v[0], k])
        else:
          methodBuffer.writeLine("  var $1_00 = $2($3)" % [k.strip(chars = {'`'}), v[0], k])

  # assert(info != nil) # why can it be nil?
  # if Lib.len == 0: # xlib, fontconfig, freetype2 # but Lib is local to main(), so let it crash
  #   return

  assert(isCallableInfo(mInfo))
  assert(isFunctionInfo(mInfo))

  let sym = $gFunctionInfoGetSymbol(mInfo)

  #if info != nil and callerAlloc.contains(moduleNamespace & '.' & $gBaseInfoGetName(info)) and sym.endsWith(["_copy", "_assign", "_free", "_alloc"]):
  #  echo sym
  #  return

  var nilArgFix: seq[string]
  var pars: GPars
  let p = methodBuffer.getPosition
  let symIsDeprecated = gBaseInfoIsDeprecated(mInfo).int != 0
  var depStr = ""
  if symIsDeprecated:
    depStr = " {.deprecated.} "
  if sym[^1] == '_': return
  if sym.contains("__"): return
  if processedFunctions.contains(sym): return

  if gBaseInfoGetName(mInfo).len == 0: # <method name="" c:identifier="gst_video_chroma_resample" moved-to="video_chroma_resample">
    return

  # The following functions work with arrays, we should check each carefully -- some may not compile...
  #if sym == "g_io_channel_read_to_end": return # fix later

  if sym == "g_file_enumerator_iterate": return # two gobject var out parameters, hard to support

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
  ###if sym == "g_file_load_contents": return # fix later
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
  #if sym == "g_object_ref": return # supress Hint: 'g_object_ref' is declared but not used

  if sym == "gtk_container_get_focus_chain": return # GList transfer CONTAINER, hard, deprecated

  if sym == "gst_structure_from_string": return # constructor with out param, not supported yet.
  if sym == "gst_structure_take": return # first parameter is var but can be nil? See trouble at the bottom of this file.

  if sym == "gst_bit_writer_free_and_get_data": return # see https://discourse.gnome.org/t/gst-bit-writer-free-and-get-data/5304/2
  if sym == "gst_bit_writer_reset_and_get_data": return
  if sym == "gst_byte_reader_dup_string_utf32": return
  if sym == "gst_byte_writer_reset_and_get_data": return

  if sym == "gst_gl_filter_add_rgba_pad_templates": return

  if sym == "nice_agent_get_selected_pair": return #  was very wrong, fixed manually
  if sym == "g_hash_table_destroy": return

  if sym == "g_variant_ref_sink": return # we need this early, so add manually early

  try:

    for tryOut2Ret in [false, true]:

      if tryOut2Ret:
        var ret2 = gCallableInfoGetReturnType(minfo)
        let match = if gCallableInfoIsMethod(minfo): 1 else: 0
        let arg = gCallableInfoGetArg(minfo, (1 - match).cint)
        let out2ret = (gCallableInfoGetNArgs(minfo) + match) == 2 and  gTypeInfoGetTag(ret2) == GITypeTag.VOID and gArgInfoGetDirection(arg) == GIDirection.OUT
        if not out2Ret:
          break

      pars = genPars(mInfo, false, info)#, tryOut2Ret = tryOut2Ret)
      processedFunctions.incl(sym)
      if not sym.startsWith("g_param_spec_uref"):
        if sym.startsWith("g_param_spec_", "g_type_interface_", "g_object_interface_"): return
      if sym in ["gtk_widget_class_find_style_property", "gtk_container_class_find_child_property",
        "gtk_cell_area_class_find_cell_property"]: return
      var asym = manglename(gBaseInfoGetName(mInfo))

      # this does not really help, we have to fix some names manually
      if not gCallableInfoIsMethod(minfo) and gCallableInfoGetNArgs(minfo) == 0 and
        (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0:
        var h = sym
        if h.find('_') > 0:
          h = h.split('_', 1)[1]
        if h.endsWith("_get"):
          h.removeSuffix("_get")
          h = "get_" & h
        h = h.mysnakeToCamel
        #asym = h

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
      var ngrRet = newGenRec(ret2)
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
          if asym.startsWith("get"):
            let match = if gCallableInfoIsMethod(minfo): 0 else: 1
            if gCallableInfoGetNArgs(minfo) != match:
              continue
          if asym.startsWith("set"):
            let match = if gCallableInfoIsMethod(minfo): 1 else: 2
            if gCallableInfoGetNArgs(minfo) != match:
              continue
            if gTypeInfoGetTag(ret2) != GITypeTag.VOID:
              continue

            #plist.replace("", "") we should remove default value from plist for assignments like width =

          if asym.startsWith("get"):
            asym = asym[3 .. ^1].unCap
          if asym.startsWith("set"):
            asym = asym[3 .. ^1].unCap
            asym = '`' & asym & '=' & '`'
          if keywords.contains(asym) or nims.contains(asym): continue
          if asym == "`tings=`": continue # result of get_settings
        # the large proxy block BLOCK7 {
        let b7 = needProxyProc(mInfo) or isString(ret2) or pars.replist.len > 0 or needTypeConv(ngrRet.name00, ngrRet) or
            gTypeInfoGetTag(ret2) == GITypeTag.GLIST
        # export only low level symbols that are needed internally -- maybe we should export only a private name for them
        if run == 0 and not tryOut2Ret:
          if sym in ["g_quark_from_static_string", "g_error_free", "g_object_get_qdata", "g_object_ref_sink", "g_object_unref", "g_param_spec_ref_sink",
            "g_timeout_add_full", "g_object_is_floating", "gst_bus_add_watch_full", "g_object_ref", "g_date_time_format", "gdk_event_ref", "g_strdup",  
            "g_type_from_name", "g_type_check_instance_is_a", "g_idle_add_full", "g_quark_try_string", "vte_regex_unref", "gtk_expression_ref",
            "gtk_builder_get_object", "g_action_map_add_action", "gtk_drawing_area_set_draw_func", "g_io_add_watch_full"]:
            methodBuffer.write("\nproc " & sym & EM & pars.plist)
            methodBuffer.writeLine(" {.\n    importc, ", libprag, ".}")
            if sym.startsWith("vte_regex_unref"): # this function is special, as it returns the object
              methodBuffer.writeLine("\nproc unref*(self: Regex) =")
              methodBuffer.writeLine("  discard vte_regex_unref(cast[ptr Regex00](self.impl))")
              return
          elif b7:
            methodBuffer.write("\nproc " & sym & pars.plist)
            methodBuffer.writeLine(" {.\n    importc, ", libprag, ".}")
          if sym in ["g_object_ref_sink", "g_object_ref"]:
            return

        if b7:
          var isGObject = false
          let tag = gTypeInfoGetTag(ret2)
          if tag == GITypeTag.INTERFACE:
            let iface = gTypeInfoGetInterface(ret2)
            #if gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse: # the same here!
            if gBaseInfoGetType(iface) == GIInfoType.INTERFACE or (gBaseInfoGetType(iface) == GIInfoType.Object and gObjectInfoGetFundamental(iface) == GFalse):
              isGObject = true
          pars = genPars(mInfo, true, info, tryOut2Ret = tryOut2Ret)

          var sss = ""

          sss = pars.tmpoutgobjectarg

          let num = max([pars.arglist.count("seq2CstringArray"), pars.arglist.count("seq2TargetEntryArray"), pars.arglist.count(
              "seq2PageRangeArray"), pars.arglist.count("seq2KeymapKeyArray")])
          for i in 1 .. num:
            let h = if i == 1: "" else: $i
            sss &= "  var $1$3x: array[$2, pointer]\n" % [StringArrayName, $StringArrayEntries, h] &
                         "  var $1$2: cstringArray = cast[cstringArray](addr $1$2x)\n" % [StringArrayName, h]
          if asym.len > 2 and asym[^2] == '=':
            pars.plist = pars.plist.replace(": bool = true", ": bool")
          if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0 or isProxyCandidate(ret2):
            if info != nil:
              asym = asym.replace("new", "new" & manglename(gBaseInfoGetName(info)))
            else: # i.e. "pango_attr_background_new"
              if asym.endsWith("New"):
                asym.setLen(asym.len - 3)
                asym[0] = asym[0].toUpperAscii
                asym = "new" & asym
                #discard #asym =
              #if sym == "pango_attr_background_new": echo "sss", info != nil, asym
          asym = fixedProcNames.getOrDefault(sym, asym)
          # BLOCKMARK8 : 3 cases: constructor, isProxyCandidate(ret2), plain else
          let isProxyCandidateret2 = isProxyCandidate(ret2)

          #else: # BLOCKMARK8 assert gerror
          if not (isProxyCandidateret2 or isGObject):
            block8("", true, tryOut2Ret)
          if isProxyCandidateret2 or isGObject: # BLOCKMARK8
            for itt in 0 .. 2: # generate the new(), the new(typedesc) and the init() proc
              var hhh = "\nproc " & asym & EM & pars.plist
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
                hhh = hhh.replace("proc new", "proc init") # v0.8.2
                hhh = hhh.replace("*(", "*[T](result: var T" & semi)
              if itt == 2 and ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0):
                depStr = " {.deprecated.}"
              if itt == 2 or ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0):
                hhh = hhh & depStr & " ="
              else:
                hhh = hhh & " ="
              block8(hhh, itt == 0, tryOut2Ret)
              if not isGObject:
                methodBuffer.write(pars.tempRes) # caution, gobjectTemp() may write tempRes too.
              if itt == 1 or itt == 2:
                methodBuffer.writeLine("  assert(result is $1)" % [manglename(gBaseInfoGetName(info))])
              if isGObject:
                gobjectTemp()
              elif gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING or
                gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING: # for ARC we have always to use the same finalizer!
                let tag = gTypeInfoGetTag(ret2)
                assert tag == GITypeTag.INTERFACE
                var iface = gTypeInfoGetInterface(ret2)
                if gBaseInfoGetType(iface) == GIInfoType.INTERFACE:
                  gobjectTemp()
                else:
                  assert(gBaseInfoGetType(iface) in {GIInfoType.STRUCT, GIInfoType.UNION, GIInfoType.OBJECT})
                  var freeMeName: string
                  var freeMe: GIFunctionInfo
                  var boxedFreeMeName: string
                  findFreeProc(iface, gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING)
                  if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo):
                    methodBuffer.writeLine("  let impl0 = " & sym & pars.arglist) # fast return in case of error
                    checkForGerror()
                    if gCallableInfoMayReturnNull(minfo):
                      methodBuffer.writeLine("  if impl0.isNil:")
                      methodBuffer.writeLine("    return nil")
                  if boxedFreeMeName != "":
                    methodBuffer.writeLine("  fnew(result, $1)" % boxedFreeMeName)
                  elif freeMeName == "":
                    # assert false # TODO we have to fix this case manually
                    # echo "xCaution: No free/unref found for ", ' ', gBaseInfoGetName(iface), " (", sym, ')' # check this from time to time!
                    methodBuffer.writeLine("  new(result)")
                  else:
                    methodBuffer.writeLine("  fnew(result, $1)" % freeMeName)
                  var weAppliedThatUglyFix = false
                  if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo):
                    if pars.implRef.startsWith("  result.impl = cast[typeof(result.impl)](") and pars.implRef.endsWith("result.impl))") and
                    gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING and
                    ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0): # if we really write pars.implRef
                      # tiny, ugly fix to save some lines of code
                      var parsimplRef = pars.implRef.replace("result.impl))", "impl0))")
                      weAppliedThatUglyFix = true
                      methodBuffer.writeLine(parsimplRef)
                    else:
                      methodBuffer.writeLine("  result.impl = impl0")
                  else:
                    methodBuffer.writeLine("  result.impl = " & sym & pars.arglist)
                  if gCallableInfoGetCallerOwns(minfo) == GITransfer.NOTHING: # for the none gobjects
                    if ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0):
                      if not weAppliedThatUglyFix:
                        methodBuffer.writeLine(pars.implRef)
                      ### methodBuffer.writeLine("  result.ignoreFinalizer = true") # as we have always to attach one with ARC.
              else: assert false
              if ((gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0 and gBaseInfoGetName(info) == "Variant"):
                # methodBuffer.writeLine("  result.ignoreFinalizer = true") # before v0.9.5
                methodBuffer.writeLine("  discard g_variant_ref_sink(result.impl)")
              if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) == 0:
                break
          elif ngrRet.res == glist:
            var elTransferFull = gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) !=
                GITransfer.NOTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              if ngrRet.infoType == GIInfoType.OBJECT or ngrRet.infoType == GIInfoType.INTERFACE:
                methodBuffer.writeLine("  result = glistObjects2seq($1, resul0, $2)" % [ngrRet.childName, $elTransferFull])
              if ngrRet.infoType == GIInfoType.STRUCT:
                if gBaseInfoGetName(gTypeInfoGetInterface(gTypeInfoGetParamType(ret2, 0))) notin ["Atom", "Variant", "TimedValue"]: # care later
                  methodBuffer.writeLine("  result = glistStructs2seq[$1](resul0, $2)" % [ngrRet.childName, $(
                      gCallableInfoGetCallerOwns(minfo) != GITransfer.EVERYTHING)])
                  # caution TimedValue is a "light" entity, so we need a different glistStructs2seq() for that!
              if gCallableInfoGetCallerOwns(minfo) != GITransfer.NOTHING:
                methodBuffer.writeLine("  g_list_free(resul0)") # only free the list itself, the elements are moved to the seq
            else:
              if ngrRet.infoType == GIInfoType.OBJECT or ngrRet.infoType == GIInfoType.INTERFACE:
                if ngrRet.infoType != GIInfoType.INTERFACE:
                  assert findFreeObject(gTypeInfoGetInterface(gTypeInfoGetParamType(ret2, 0))).len == 0
                methodBuffer.writeLine("  result = glistObjects2seq($1, $2, $3)" % [ngrRet.childName, sym & pars.arglist,
                    $elTransferFull])
              else:
                methodBuffer.writeLine("  discard")
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING, GITransfer.CONTAINER})
          elif ngrRet.res == gslist:
            var elTransferFull = gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) !=
                GITransfer.NOTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              if ngrRet.infoType == GIInfoType.OBJECT or ngrRet.infoType == GIInfoType.INTERFACE:
                methodBuffer.writeLine("  result = gslistObjects2seq($1, resul0, $2)" % [ngrRet.childName, $elTransferFull])
              if ngrRet.infoType == GIInfoType.STRUCT:
                if gBaseInfoGetName(gTypeInfoGetInterface(gTypeInfoGetParamType(ret2, 0))) notin ["Atom", "Variant"]: # care later
                  methodBuffer.writeLine("  result = gslistStructs2seq[$1](resul0, $2)" % [ngrRet.childName, $(
                      gCallableInfoGetCallerOwns(minfo) != GITransfer.EVERYTHING)])
              if gCallableInfoGetCallerOwns(minfo) != GITransfer.NOTHING:
                methodBuffer.writeLine("  g_slist_free(resul0)") # only free the list itself, the elements are moved to the seq
            else:
              if ngrRet.infoType == GIInfoType.OBJECT or ngrRet.infoType == GIInfoType.INTERFACE:
                if ngrRet.infoType != GIInfoType.INTERFACE:
                  assert findFreeObject(gTypeInfoGetInterface(gTypeInfoGetParamType(ret2, 0))).len == 0
                methodBuffer.writeLine("  result = gslistObjects2seq($1, $2, $3)" % [ngrRet.childName, sym & pars.arglist,
                    $elTransferFull])
              else:
                methodBuffer.writeLine("  discard")
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING, GITransfer.CONTAINER})
          elif ngrRet.flags.contains(RecResFlag.unamedA) and ngrRet.res == intAX:
            # https://discourse.gnome.org/t/g-key-file-get-integer-list-transfer-container/4729
            # for fundamental types GITransfer.EVERYTHING and GITransfer.CONTAINER are equivalent
            var co = gCallableInfoGetCallerOwns(minfo)
            assert ngrRet.flags.contains(RecResFlag.array)
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or co in {GITransfer.EVERYTHING, CONTAINER}:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              methodBuffer.writeLine("  result = $1ToSeq(resul0, $2.int)" % [fixedName2(ngrRet.name00), pars.blex])
            else:
              methodBuffer.writeLine("  result = $1ToSeq($3, $2.int)" % [fixedName2(ngrRet.name00), pars.blex, sym & pars.arglist])
            assert(co in {GITransfer.EVERYTHING, CONTAINER, NOTHING})
            if co in {GITransfer.EVERYTHING, CONTAINER}:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif ngrRet.flags.contains(RecResFlag.unamedA) and ngrRet.res == intA0:
            assert ngrRet.flags.contains(RecResFlag.array)
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) ==
                GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              methodBuffer.writeLine("  result = $1ZT2seq(resul0)" % [unCaped(fixedName2(ngrRet.name))])
            else:
              methodBuffer.writeLine("  result = $1ZT2seq($2)" % [unCaped(fixedName2(ngrRet.name)), sym & pars.arglist])
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING, GITransfer.CONTAINER})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif isString(ret2):
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) ==
                GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              methodBuffer.writeLine("  result = $resul0")
            else:
              methodBuffer.writeLine("  result = $" & sym & pars.arglist)
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          elif RecResFlag.namedA in ngrRet.flags:
            assert ngrRet.flags.contains(RecResFlag.array)
            let h = ngrRet.name00
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) ==
                GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              methodBuffer.writeLine("  result = $1ToSeq(resul0, $2_00.int)" % [fixedName2(h.replace("00")).unCap, pars.blex])
            else:
              methodBuffer.writeLine("  result = $1ToSeq($3, $2_00.int)" % [fixedName2(h.replace("00")).unCap, pars.blex, sym & pars.arglist])
            assert(gCallableInfoGetCallerOwns(minfo) in {GITransfer.EVERYTHING, GITransfer.NOTHING})
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              methodBuffer.writeLine("  cogfree(resul0)")
          #elif (pars.replist.len > 0 or gCallableInfoCanThrowGerror(minfo)) and ngrRet.name != "void" or pars.tmpoutgobjectarg.len != 0:
          elif (pars.replist.len > 0 or gCallableInfoCanThrowGerror(minfo) or pars.tmpoutgobjectarg.len != 0) and ngrRet.name != "void":
            # caution dragons like g_key_file_get_locale_string_list()
            if gCallableInfoGetCallerOwns(minfo) == GITransfer.EVERYTHING:
              discard # echo "Untamed dragon: ", sym
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) ==
                GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              methodBuffer.write("  result = ")
              if needTypeConv(ngrRet.name, ngrRet):
                methodBuffer.writeLine(doCt3nt(ngrRet.name, ngrRet) & '(' & "resul0" & ')')
              else:
                methodBuffer.writeLine("resul0")
            else:
              methodBuffer.write("  result = ")
              if needTypeConv(ngrRet.name, ngrRet):
                methodBuffer.writeLine(doCt3nt(ngrRet.name, ngrRet) & '(' & sym & pars.arglist & ')')
              else:
                methodBuffer.writeLine(sym & pars.arglist)
          elif needTypeConv(ngrRet.name, ngrRet):
            if gCallableInfoCanThrowGerror(minfo) or gCallableInfoMayReturnNull(minfo) or gCallableInfoGetCallerOwns(minfo) ==
                GITransfer.EVERYTHING:
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
              checkForGerror()
              if gCallableInfoMayReturnNull(minfo):
                methodBuffer.writeLine("  if resul0.isNil:")
                methodBuffer.writeLine("    return")
              if ngrRet.name == "ptr cstring" and ngrRet.flags.contains(RecResFlag.array) and gCallableInfoGetCallerOwns(minfo) ==
                  GITransfer.EVERYTHING:
                methodBuffer.writeLine("  result = cstringArrayToSeq(resul0)")
                methodBuffer.writeLine("  g_strfreev(resul0)")
              else:
                methodBuffer.writeLine("  " & doCt3nt(ngrRet.name, ngrRet) & '(' & "resul0" & ')')
            else:
              if nilArgFix.len > 0 or pars.tempResFree != "": # ugly, do we have a better test for this case
              #if ngrRet.name != "void":
                methodBuffer.writeLine("  result = " & doCt3nt(ngrRet.name, ngrRet) & '(' & sym & pars.arglist & ')')
              else:
                methodBuffer.writeLine("  " & doCt3nt(ngrRet.name, ngrRet) & '(' & sym & pars.arglist & ')')
              checkForGerror() # i.e. for nice_agent_set_remote_candidates, free GSList
          else:
            if gCallableInfoCanThrowGerror(minfo) and ngrRet.name != "void":
              assert false
              methodBuffer.writeLine("  let resul0 = " & sym & pars.arglist)
            elif pars.tempResFree.len > 0 and ngrRet.name != "void":
              methodBuffer.writeLine("  result = " & sym & pars.arglist) # aha
            else:
              methodBuffer.writeLine("  " & sym & pars.arglist) # aha
            checkForGerror()
            if gCallableInfoCanThrowGerror(minfo) and ngrRet.name != "void":
              assert false
              methodBuffer.writeLine("  resul0 #####")
          for k, v in pars.replist:
            if v[1].flags.contains(RecResFlag.unamedA):
              assert v[1].flags.contains(RecResFlag.array)
              methodBuffer.writeLine("  $1.setLen($2)" % [k, pars.blex])
              methodBuffer.writeLine("  copyMem(unsafeaddr $1[0], $1_00, $2.int * sizeof($1[0]))" % [k.strip(chars = {'`'}), pars.blex])
              methodBuffer.writeLine("  cogfree($1_00)" % [k.strip(chars = {'`'})])
            elif RecResFlag.namedA in v[1].flags:
              assert v[1].flags.contains(RecResFlag.array)
              methodBuffer.writeLine("  $1 = $2($3_00, $4)" % [k, doCt3nt(v[0], v[1]), k.strip(chars = {'`'}), pars.blex])
            else:
              if v[1].optOut:
                methodBuffer.writeLine("  if $1.addr != nil:" % [k, doCt3nt(v[0], v[1]), k.strip(chars = {'`'})])
                methodBuffer.writeLine("    $1 = $2($3_00)" % [k, doCt3nt(v[0], v[1]), k.strip(chars = {'`'})])
              else:
                methodBuffer.writeLine("  $1 = $2($3_00)" % [k, doCt3nt(v[0], v[1]), k.strip(chars = {'`'})])
        # BLOCKMARK8
        else: # } end of large proxy block BLOCK7
          asym = fixedProcNames.getOrDefault(sym, asym)
          pars = genPars(mInfo, false, info, tryOut2Ret = tryOut2Ret)
          if asym != "errorQuark" and asym != "getPlugin" and asym != "quark":
            methodBuffer.write("\nproc " & asym & EM & pars.plist)
            methodBuffer.writeLine(" {.\n    importc: \"", sym, "\", ", libprag, ".}")

      for n in nilArgFix: # https://github.com/StefanSalewski/gintro/issues/158
        methodBuffer.writeLine("  if $1 != nil and $1.impl == nil:" % n)
        methodBuffer.writeLine("    $1.ignoreFinalizer = true" % n)
        methodBuffer.writeLine("    $1 = nil" % n)

      if pars.tmpoutgobjectarg.len != 0:
        methodBuffer.writeLine("#  dothemagic(" & pars.outgobjectargname)
        dothegobjectargmagic()

      if info != nil and (gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT) and
        gCallableInfoGetNArgs(minfo) == (if gCallableInfoIsMethod(minfo): 0 else: 1):
        #if not callerAlloc.contains(modulenamespace & '.' & $gBaseInfoGetName(info)) and (asym == "free" or asym == "unref"):
        if not callerAlloc.contains(modulenamespace & '.' & $gBaseInfoGetName(info)) and (asym == "free" or asym == "unref" or
            asym == "destroy"): # v0.8.6
          methodBuffer.writeLine("\nproc finalizer" & asym & EM & "(self: $1) =" % [$gBaseInfoGetName(info)])
          methodBuffer.writeLine("  if not self.ignoreFinalizer:")
          if gTypeInfoGetTag(ret2) != GITypeTag.VOID: # i.e. gst_sdp_media_free()
            methodBuffer.writeLine("    discard " & sym & "(self.impl)")
          else: #"(cast[ptr " & manglename(gBaseInfoGetName(binfo)) & "00]("
            #methodBuffer.writeLine("    " & sym & "(self.impl)")
            methodBuffer.writeLine("    " & sym & "(cast[ptr " & manglename(gBaseInfoGetName(info)) & "00](self.impl))")
      if sym == "gtk_window_set_default_size":
        methodBuffer.writeLine("\nproc `defaultSize=`*(self: Window; dim: tuple[width: int; height: int]) =")
        methodBuffer.writeLine("  gtk_window_set_default_size(cast[ptr Window00](self.impl), int32(dim[0]), int32(dim[1]))")
      if sym == "g_object_unref":
        # methodBuffer.writeLine("\nproc genericGObjectUnref*[T](self: ref T) =") # we do not really need generics here
        methodBuffer.writeLine("\nproc genericGObjectUnref*(self: Object) =")
        methodBuffer.writeLine("  if not self.ignoreFinalizer:")
        methodBuffer.writeLine("    g_object_unref(cast[ptr Object00](self.impl))")
      if info != nil and gBaseInfoGetType(info) == GIInfoType.Object and gObjectInfoGetFundamental(info) == GTrue and sym.endsWith("unref"):
        assert false
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

      output.writeLine("    when defined(gintroDebug):")
      output.writeLine("      echo \"destroy \", $typeof(self), ' ', cast[int](unsafeaddr self)")

      output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
      output.writeLine("      boxedFree(", getTypeProc, "(), ", "cast[ptr " & mangleName(gBaseInfoGetName(info)) & "00](self.impl))")
      output.writeLine("      self.impl = nil")

      # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
      output.writeLine("\nproc newWithFinalizer*(x: var " & mangleName(gBaseInfoGetName(info)) & ") =")
      output.writeLine("  when defined(gcDestructors):")
      output.writeLine("    new(x)")
      output.writeLine("  else:")
      output.writeLine("    new(x, gBoxedFree" & $gRegisteredTypeInfoGetTypeName(info) & ")")

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
          if freeMe.isNil:
            freeMe = gStructInfoFindMethod(info, "destroy") # pango, new in v0.8.5
        if freeMe != nil and gCallableInfoGetNArgs(freeMe) == (if gCallableInfoIsMethod(freeMe): 0 else: 1):
          # methodBuffer.writeLine("\nwhen compileOption(\"gc\", \"arc\"):")
          methodBuffer.writeLine("\nwhen defined(gcDestructors):")
          methodBuffer.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")

          methodBuffer.writeLine("    when defined(gintroDebug):")
          methodBuffer.writeLine("      echo \"destroy \", $typeof(self), ' ', cast[int](unsafeaddr self)")

          methodBuffer.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
          if gTypeInfoGetTag(xret2) == GITypeTag.VOID:
            methodBuffer.writeLine("      $1(self.impl)" % [$gFunctionInfoGetSymbol(freeMe)])
          else:
            methodBuffer.writeLine("      discard $1(self.impl)" % [$gFunctionInfoGetSymbol(freeMe)])
          methodBuffer.writeLine("      self.impl = nil")

          # new in v0.8.5 # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
          methodBuffer.writeLine("\nproc newWithFinalizer*(x: var " & mangleName(gBaseInfoGetName(info)) & ") =")
          methodBuffer.writeLine("  when defined(gcDestructors):")
          methodBuffer.writeLine("    new(x)")
          methodBuffer.writeLine("  else:")
          # methodBuffer.writeLine("    new(x, $1)" % [$gBaseInfoGetName(freeMe)])
          methodBuffer.writeLine("    new(x, finalizer$1)" % [$gBaseInfoGetName(freeMe)]) # for v0.8.6

template writeGetTypeProc =
  var getTypeProc {.inject.}: string
  if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE:
    getTypeProc = $gRegisteredTypeInfoGetTypeInit(info)
    if getTypeProc notin ["intern", "g_gstring_get_type"]:
      var lp = "libprag"
      if moduleNamespace == "glib": # and getTypeProc != "g_variant_get_type":
        lp = "gobjectlibprag"
      output.write("\nproc " & getTypeProc & "*(): GType ")
      output.writeLine("{.importc, $1.}" % [lp])

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
      output.writeLine("    ", name, ": ", newGenRec(t).name)
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object")
    output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
    output.writeLine("    ignoreFinalizer*: bool")
  writeGetTypeProc()
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
      let xret2 = gCallableInfoGetReturnType(minfo)
      genDestroyFreeUnref()

const TargetEntryProx = """

proc seq2TargetEntryArray(s: openarray[TargetEntry]; a: var cstringArray):  ptr TargetEntry00 =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr TargetEntry00]](a)
  for i, o in s:
    x[i] = o.impl
  return cast[ptr TargetEntry00](x)

proc newTargetEntry*(target: cstring; flags: int; info: int): TargetEntry

proc priv_target_table_free(targets: ptr TargetEntry00; nTargets: int32) {.importc: "gtk_target_table_free", libprag.}

proc targetEntryArrayToSeq(s: ptr TargetEntry00; n: int):  seq[TargetEntry] =
  let a = cast[ptr UncheckedArray[ptr TargetEntry00]](s)
  for i in 0 ..< n:
    result.add(newTargetEntry(a[i].target,  a[i].flags.int, a[i].info.int))
  priv_target_table_free(s, n.int32)

""" % [$StringArrayEntries]

const PageRangeProx = """

proc seq2PageRangeArray(s: openarray[PageRange]; a: var cstringArray):  ptr PageRange =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr PageRange]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return cast[ptr PageRange](x)

proc pageRangeArrayToSeq(s: ptr PageRange; n: int):  seq[PageRange] =
  let a = cast[ptr UncheckedArray[ptr PageRange]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)

""" % [$StringArrayEntries]

const KeymapKeyProx = """

proc seq2KeymapKeyArray(s: openarray[KeymapKey]; a: var cstringArray):  ptr KeymapKey =
  assert s.high < $1
  let x = cast[ptr UncheckedArray[ptr KeymapKey]](a)
  for i in 0 .. s.high:
    x[i] = unsafeaddr(s[i])
  return cast[ptr KeymapKey](x)

proc keymapKeyArrayToSeq(s: ptr KeymapKey; n: int):  seq[KeymapKey] =
  let a = cast[ptr UncheckedArray[ptr KeymapKey]](s)
  for i in 0 ..< n:
    result.add(a[i][])
  cogfree(s)

""" % [$StringArrayEntries]

proc writeStruct(info: GIStructInfo) =

  if gBaseInfoGetName(info) in ["_ContextMenu", "_ContextMenuItem"]:
    return # WebKit2WebExtension-4.0.gir bug

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

  # https://github.com/StefanSalewski/gintro/issues/176
  if gBaseInfoGetName(info) == "Rectangle" and moduleNamespace == "cairo":
    cairoProvidesRectangle = true

  if gBaseInfoGetName(info) == "Address" and moduleNamespace == "nice":
    #import nativesockets
    # See https://gitlab.freedesktop.org/libnice/libnice/-/blob/master/agent/address.h
    output.writeLine("  Address* {.pure, byRef, union.} = object")
    output.writeLine("    `addr`*: SockAddr")
    output.writeLine("    ip4*: Sockaddr_in")
    output.writeLine("    ip6*: Sockaddr_in6")

  elif callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " {.pure, byRef.} = object")
  else:
    output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & "00" & EM & " {.pure.} = object")
  if WriteFields or callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(
      info))) or
    mangleName(gBaseInfoGetName(info)) == "TargetEntry" or
      ["gst.Message", "gst.MiniObject", "glib.List", "pango.Attribute", "nice.Address", "nice.Candidate"].contains((
          $gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    #if gBaseInfoGetName(info) == "Address":
    #  echo "kkk", info.gStructInfoGetNFields()
    for j in 0.cint ..< info.gStructInfoGetNFields():
      let field = info.gStructInfoGetField(j)
      let name = manglename(gBaseInfoGetName(field)) & EM
      let t = gFieldInfoGetType(field)
      output.writeLine("    ", name, ": ", newGenRec(t).name)
      # let tag = gTypeInfoGetTag(t) # XXX: gFieldInfoGetSize() is always zero!
      #if typeTagIsBasic(tag):
      # echo "XXXXXXXXXXXXX",  gFieldInfoGetOffset(field)
      # echo "XXXXXXXXXXXXX",  gFieldInfoGetSize(field)
    #if mangleName(gBaseInfoGetName(info)) != "TextIter":
  if not callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    if moduleNameSpace == "cairo": # see https://forum.nim-lang.org/t/8309
      output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object of RootRef")
    else:
      output.writeLine("  ", mangleName(gBaseInfoGetName(info)) & EM & " = ref object")
    output.writeLine("    impl*: ptr " & mangleName(gBaseInfoGetName(info)) & "00")
    output.writeLine("    ignoreFinalizer*: bool")
  writeGetTypeProc()
  genBoxedFree()

  var mseq: seq[GIFunctionInfo]
  var freePos = -1
  for j in 0.cint ..< gStructInfoGetNMethods(info):
    mseq.add(gStructInfoGetMethod(info, j))
    if freePos < 0 and gBaseInfoGetName(gStructInfoGetMethod(info, j)) in ["free", "unref"]:
      freePos = j

  if freePos < 0:
    for j in 0.cint ..< gStructInfoGetNMethods(info):
      if freePos < 0 and gBaseInfoGetName(gStructInfoGetMethod(info, j)) in ["destroy"]: # add destroy for v0.8.5
        freePos = j

  if freePos > 0: swap(mseq[0], mseq[freePos])
  if mangleName(gBaseInfoGetName(info)) == "List" and moduleNamespace == "glib":
    output.writeLine("\nproc g_list_free*(list: ptr glib.List) {.importc: \"g_list_free\", libprag.}")
    output.writeLine("\nproc g_list_prepend*(list: ptr glib.List; data: pointer): ptr glib.List  {.importc:  \"g_list_prepend\", libprag.}")

  if mangleName(gBaseInfoGetName(info)) == "SList" and moduleNamespace == "glib":
    output.writeLine("\nproc g_slist_free*(list: ptr glib.SList) {.importc: \"g_slist_free\", libprag.}")
    output.writeLine("\nproc g_slist_prepend*(list: ptr glib.SList; data: pointer): ptr glib.SList  {.importc:  \"g_slist_prepend\", libprag.}")

  if mangleName(gBaseInfoGetName(info)) == "TargetEntry":
    # assert false executed for gtk3
    output.writeLine(TargetEntryProx)
  if mangleName(gBaseInfoGetName(info)) == "KeymapKey":
    output.writeLine(KeymapKeyProx)
  if mangleName(gBaseInfoGetName(info)) == "PageRange":
    output.writeLine(PageRangeProx)

  if gBaseInfoGetName(info) == "Variant" and moduleNamespace == "glib": # make it available early
    output.writeLine("\nproc g_variant_ref_sink(self: ptr Variant00): ptr Variant00 {.importc, libprag.}")


  for i, mInfo in mseq:
    writeMethod(info, minfo)
    if i == 0:
      let xret2 = gCallableInfoGetReturnType(minfo)
      genDestroyFreeUnref()

template writeSignal() =
  #echo gBaseInfoGetName(signalInfo), gCallableInfoGetNArgs(signalInfo), gTypeInfoGetTag(zzzu)
  if gCallableInfoGetNArgs(signalInfo) > 0 or gTypeInfoGetTag(zzzu) != GITypeTag.VOID:
    #echo "aaa", gBaseInfoGetName(signalInfo)
    var memo = ""
    memo.addInt(gCallableInfoGetNArgs(signalInfo))
    memo.add(RecSep)
    var plist, arglist: string
    var replist: TableRef[string, (string, RecRes)]
    (plist, arglist, replist) = genPars(signalInfo, true, info, genArrayMark = true)
    memo.add(plist)
    memo.add(RecSep)
    (plist, arglist, replist) = genPars(signalInfo, false, info, genArrayMark = true)
    memo.add(plist)
    memo = memo.replace("\n    ", " ")
    memo = memo.replace("\"", "\\\"")
    if moduleNamespace == "gtk" or moduleNamespace == "gdk" or moduleNamespace == "gdkX11" or moduleNamespace == "gtksource":
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
    signalbuffer.writeLine(" p: proc (self: ptr " & yyy & "00; " & h & " {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags): culong =")
  else:
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
  assert(we in ["ModifierType", "EventMask", "AccelFlags", "AttachOptions", "MessageType", "WindowHints", "IOCondition"])
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
  if we == "IOCondition":
    tname = "IOC" # as glib already has an IOFlags enum type
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
    output.writeLine("\nconst ModifierMask* = {ModifierFlag.shift .. ModifierFlag.button5, ModifierFlag.super .. ModifierFlag.meta}")
  elif we == "EventMask":
    output.writeLine("\nconst AllEventsMask* = {EventFlag.exposure .. EventFlag.smoothScroll}")
  for j in 0.cint ..< gEnumInfoGetNMethods(info):
    let mInfo = gEnumInfoGetMethod(info, j)
    writeMethod(info, minfo)

proc writeEnum(info: GIEnumInfo) =
  if mangleName(gBaseInfoGetName(info)) in ["ModifierType", "EventMask", "AccelFlags", "AttachOptions", "WindowHints",
      "IOCondition"] or
    (moduleNameSpace == "gst" and mangleName(gBaseInfoGetName(info)) == "MessageType"):
    writeModifierType(info)
    return
  type T = tuple[v: int64; n: string]
  var s: seq[T]
  var alias: HashSet[string] # double entry in gstvideo, see https://discourse.gnome.org/t/gstvideo-1-0-gir-double-entries/5442
  var flags = ($gBaseInfoGetName(info)).endsWith("Flags")
  var flagDefault: string 
  output.writeLine("type")
  let n = info.gEnumInfoGetNValues()
  for j in 0.cint ..< n:
    let value = info.gEnumInfoGetValue(j)
    var name = mangleName(gBaseInfoGetName(value))
    if name[0].isDigit:
      name = "enum" & name # gstvideo, see https://discourse.gnome.org/t/gstvideo-1-0-gir-double-entries/5442
    let v = gValueInfoGetValue(value)
    s.add((v, name))
  s.sort do (x, y: T) -> int:
    result = cmp(x.v, y.v)
    if result == 0:
      result = cmp(x.n, y.n)
  for j in 0 .. s.high:
    if s[j].v < 0:
      flags = false
    if j == 0 and s[j].v == 0:
      continue
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
    if flags and j == 0 and val == 0:
      # proc c(t: typedesc[B]): B ={}
      flagDefault = ("  " & tname & "Flags" & i.n.capitalizeAscii & EM & " = " & tname & "Flags" & "({})")
      flagDefault.add("\nproc " & i.n & "*(t: typedesc[" & tname & "Flags]): " & tname & "Flags = " & tname & "Flags" & "({})")
      #echo flagDefault
      continue
    if j > 0 and i.v == k.v:
      if i.n != k.n:
        let h = if flags: "Flag" else: ""
        alias.incl("  " & tname & i.n.capitalizeAscii & EM & " = " & tname & h & '.' & k.n)
      continue
    if flags:
      val = countTrailingZeroBits(val) # firstSetBit(val)
    output.writeLine("    ", i.n, " = ", val)
    k = i

  if flags:
    output.writeLine("\n  ", tname & "Flags" & EM, " {.size: sizeof(cint).} = set[$1Flag]" % [tname])

  if alias.len > 0 or flagDefault.len > 0:
    output.writeLine("\nconst")
    for i in alias:
      output.writeLine(i)
    if flagDefault.len > 0:
      output.writeLine(flagDefault)

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

  if callerAlloc.contains(($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))):
    assert false
    # echo ($gBaseInfoGetNamespace(info)).toLowerAscii & '.' & mangleName(gBaseInfoGetName(info))

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
        let h = newGenRec(t).name
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
    output.writeLine("  g_object_set_qdata(o.impl, Quark, nil)")
    output.writeLine("\n  if not o.ignoreFinalizer:")
    output.writeLine("    g_object_remove_toggle_ref(o.impl, toggleNotify, addr(o[]))")
  writeGetTypeProc()
  let numsig = info.gObjectInfoGetNSignals
  for j in 0.cint ..< numsig:
    let signalInfo = gObjectInfoGetSignal(info, j)
    let c = gSignalInfoGetClassClosure(signalInfo)
    if not c.isNil: echo "maybe we should process class closures!"
    if gBaseInfoGetName(signalInfo) == "notify":
      continue # XXX fix later
    var h = genPars(signalInfo, false)[0][1..^1]
    let zzzu = gCallableInfoGetReturnType(signalinfo)
    writeSignal()

  if class != nil and not allSyms.contains(mangleName(gBaseInfoGetName(class))):
    assert false
    classList.add(class)
  ct.inc($gBaseInfoGetName(info), cnt + 1)
  if gBaseInfoGetName(info) == "Object" and moduleNamespace == "gobject":
    output.writeLine("type\n  Object* = ref object of RootRef")
    output.writeLine("    impl*: ptr Object00")
    output.writeLine("    ignoreFinalizer*: bool")

    output.writeLine("\nproc refCount*(o: gobject.Object): int =")
    output.writeLine("  let p = cast[ptr cuint](cast[int](o.impl) + sizeof(pointer))")
    output.writeLine("  return p[].int")

  if gObjectInfoGetFundamental(info) == GFalse: # guess work, ignore fake GObjects like GParamSpec and such
    #output.writeLine("\nwhen compileOption(\"gc\", \"arc\"):")
    #if not (mangleName(gBaseInfoGetName(info)) == "Window" and moduleNamespace == "gtk"):
    if not (mangleName(gBaseInfoGetName(info)) in ["Window", "ApplicationWindow"] and moduleNamespace == "gtk"):
      output.writeLine("\nwhen defined(gcDestructors):")
      output.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")
      output.writeLine("    when defined(gintroDebug):")
      output.writeLine("      echo \"destroy \", $typeof(self), ' ', cast[int](unsafeaddr self)")
      output.writeLine("    g_object_set_qdata(self.impl, Quark, nil)")
      output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
      output.writeLine("      g_object_remove_toggle_ref(self.impl, toggleNotify, addr(self))")
      output.writeLine("      self.impl = nil")

  if gBaseInfoGetName(info) == "ParamSpec" and moduleNamespace == "gobject":
    ## for ParamSpec no unref proc is provided by gobject-introspection, and it asks for uref!
    output.writeLine("\nproc g_param_spec_unref*(self: ptr ParamSpec00) {.")
    output.writeLine("    importc, libprag.}")

    output.writeLine("\nproc g_param_spec_uref*(self: ptr ParamSpec00) {.")
    output.writeLine("    importc: \"g_param_spec_unref\", libprag.}")

    output.writeLine("\nproc unref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

    output.writeLine("\nproc uref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

    output.writeLine("\nproc generic_g_param_spec_uref*(self: ParamSpec) =")
    output.writeLine("  g_param_spec_unref(cast[ptr ParamSpec00](self.impl))")

    output.writeLine("\nproc g_param_spec_ref_sink*(self: ptr ParamSpec00): ptr ParamSpec00 {.")
    output.writeLine("    importc, libprag.}")

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
      let n = mangleName(gBaseInfoGetName(info))
      if freeMeName != "g_param_spec_uref":
        output.writeLine("\nproc " & freeMeName & "*(self: ptr " & n & "00) {.importc, libprag.}")
        output.writeLine("\nproc generic_$1*(self: $2) =" % [freeMeName, n])
        output.writeLine("  if not self.ignoreFinalizer:")
        output.writeLine("    $1(self.impl)" % [freeMeName])
      output.writeLine("\nwhen defined(gcDestructors):")
      output.writeLine("  proc `=destroy`*(self: var typeof(" & mangleName(gBaseInfoGetName(info)) & "()[])) =")

      output.writeLine("    when defined(gintroDebug):")
      output.writeLine("      echo \"destroy \", $typeof(self), ' ', cast[int](unsafeaddr self)")

      output.writeLine("    if not self.ignoreFinalizer and self.impl != nil:")
      if n in ["ParamArray", "ParamFraction"]:
        output.writeLine("      $#(cast[ptr $#00](self.impl))" % [freeMeName, n])
      else:
        output.writeLine("      $1(self.impl)" % [freeMeName])
      output.writeLine("      self.impl = nil")

    for j in 0.cint ..< gObjectInfoGetNMethods(info):
      if gFunctionInfoGetSymbol(gObjectInfoGetMethod(info, j)) != freeMeName:
        writeMethod(info, gObjectInfoGetMethod(info, j))
  else:
    for j in 0.cint ..< gObjectInfoGetNMethods(info):
      #if  gFunctionInfoGetSymbol(gObjectInfoGetMethod(info, j)) != freeMeName:
      writeMethod(info, gObjectInfoGetMethod(info, j))

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

  if h == "ATTR_INDEX_FROM_TEXT_BEGINNING":
    return # gint in gir, but should be guint

  if gBaseInfoGetNamespace(info) == "Soup":
    h.add("_STR") # too many name conflicts with enums!

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
    if $gBaseInfoGetName(i) notin ["TreeRowData", "ByteArray", "FileList"]: # hide ugly output for v0.8.7, investgate later
      echo "gBaseInfoGetType(i) == GIInfoType.Boxed: ", gBaseInfoGetName(i)
    # echo "++++++++ ", g_registered_type_info_get_g_type(i), g_registered_type_info_get_type_name(i)
    # assert false executed for gtk4
  else:
    assert(false)

const PRO = """

proc seq2cstringArray*(s: openarray[string]; a: var cstringArray): ptr cstring =
  assert s.high < $1 - 1
  let x = cast[ptr UncheckedArray[string]](s)
  for i in 0 .. s.high:
    a[i] = addr(x[i][0])
  a[s.len] = nil
  return cast[ptr cstring](a)
    
""" % [$StringArrayEntries]

const GTK_SOURCE_EPI = """

proc getView*(builder: Builder; name: string): View =
  let gt = g_type_from_name("GSource")
  assert(gt != g_type_invalid_get_type())
  let gobj = gtk_builder_get_object(cast[ptr Builder00](builder.impl), name)
  assert(gobj != nil)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[type(result)](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    fnew(result, $1.finalizeGObject)
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

#proc gFile00Array2seq*(p: GFile00Array; l: int32): seq[gio.GFile] =
proc gFile00Array2seq*(p: ptr GFile00; l: int32): seq[gio.GFile] =
  let a = cast[ptr UncheckedArray[ptr GFile00]](p)
  result = newSeq[gio.GFile]()
  var i: int
  while i < l:
    let f = new gio.GFile
    f.impl = a[i]
    f.ignoreFinalizer = true
    result.add(f)
    inc(i)

"""

const GObject_EPI = """

#proc refCount*(o: gobject.Object): int =
#  let p = cast[ptr cuint](cast[int](o.impl) + sizeof(pointer))
#  return p[].int

proc scNotify*(self: Object;  p: proc (self: ptr Object00; paramSpec: ptr ParamSpec00; xdata: pointer) {.cdecl.}, xdata: pointer, cf: gobject.ConnectFlags; sigName: cstring): culong =
  # g_signal_connect_data(self.impl, "notify::cursor-position", cast[GCallback](p), xdata, nil, cf)
  g_signal_connect_data(self.impl, sigName, cast[GCallback](p), xdata, nil, cf)

proc typeCheckInstanceIsA*(instance: Object; ifaceType: GType): bool =
  toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](instance.impl), ifaceType))

# similar to gobjectTemp()
proc glistObjects2seq*[T](t: typedesc[T]; l: ptr glib.List; elTransferFull: bool): seq[T] =
  var r: T
  var obj: ptr Object00
  var el = l
  while el != nil:
    obj = cast[ptr Object00](el.data)
    if obj == nil:
      continue
    let qdata = g_object_get_qdata(obj, Quark)
    if qdata != nil:
      r = cast[T](qdata)
      assert(r.impl == obj)
      result.add(r)
    else:
      fnew(r, finalizeGObject)#" % [mprefix])
      r.impl = obj
      GC_ref(r)
      if elTransferFull:
        if g_object_is_floating(r.impl).int != 0:
          discard g_object_ref_sink(r.impl)
      else:
        discard g_object_ref_sink(r.impl)
      g_object_add_toggle_ref(r.impl, toggleNotify, addr(r[]))
      g_object_unref(r.impl)
      assert(g_object_get_qdata(r.impl, Quark) == nil)
      g_object_set_qdata(r.impl, Quark, addr(r[]))
    el = el.next

proc gslistObjects2seq*[T](t: typedesc[T]; l: ptr glib.SList; elTransferFull: bool): seq[T] =
  var r: T
  var obj: ptr Object00
  var el = l
  while el != nil:
    obj = cast[ptr Object00](el.data)
    if obj == nil:
      continue
    let qdata = g_object_get_qdata(obj, Quark)
    if qdata != nil:
      r = cast[T](qdata)
      assert(r.impl == obj)
      result.add(r)
    else:
      fnew(r, finalizeGObject)#" % [mprefix])
      r.impl = obj
      GC_ref(r)
      if elTransferFull:
        if g_object_is_floating(r.impl).int != 0:
          discard g_object_ref_sink(r.impl)
      else:
        discard g_object_ref_sink(r.impl)
      g_object_add_toggle_ref(r.impl, toggleNotify, addr(r[]))
      g_object_unref(r.impl)
      assert(g_object_get_qdata(r.impl, Quark) == nil)
      g_object_set_qdata(r.impl, Quark, addr(r[]))
    el = el.next

proc glistStructs2seq*[T](l: ptr glib.List; igFin: bool): seq[T] =
  var r: T
  var el = l
  while el != nil:
    if el.data == nil:
      continue
    newWithFinalizer(r) # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
    r.impl = cast[typeof(r.impl)](el.data)
    r.ignoreFinalizer = igFin
    result.add(r)
    el = el.next

proc gslistStructs2seq*[T](l: ptr glib.SList; igFin: bool): seq[T] =
  var r: T
  var el = l
  while el != nil:
    if el.data == nil:
      continue
    newWithFinalizer(r) # CAUTION: newWithFinalizer() seems to be rarely used, can we remove it fully?
    r.impl = cast[typeof(r.impl)](el.data)
    r.ignoreFinalizer = igFin
    result.add(r)
    el = el.next

# Not much tested, but in use for libnice simple_example.nim
# Some other modules may need a similar local proc, ie for pango.Item
proc seq2GList*[T](s: seq[T]): ptr glib.List =
  var l: ptr glib.List
  var i = s.len
  while i > 0:
    dec(i)
    when T is gobject.Object or compiles(T.impl): # https://github.com/StefanSalewski/gintro/issues/99#issuecomment-739435944
    # when compiles(s[i].impl == nil):
    # when T is gobject.Object: # or T is pango.Item:
      l = g_list_prepend(l, s[i].impl)
    elif T is cstring:
      l = g_list_prepend(l, s[i]) # cstring
    else:
      # {.error: "seq2GList was called with unsupported type".} # that would break compiling the modules currently
      discard # make it compile for these cases, of course will not work
  return l

proc seq2GSList*[T](s: seq[T]): ptr glib.SList =
  var l: ptr glib.SList
  var i = s.len
  while i > 0:
    dec(i)
    when T is gobject.Object or compiles(T.impl):
    # when compiles(s[i].impl == nil): # NiceCandidate
    # when T is gobject.Object: # or T is pango.Item:
      l = g_slist_prepend(l, s[i].impl)
    elif T is cstring:
      l = g_slist_prepend(l, s[i]) # cstring
    else:
      # {.error: "seq2GSList was called with unsupported type".}
      discard # make it compile for these cases, of course will not work
  return l

#include gimplgobj
include gimplglib
export glib.g_strdup

"""

# for v0.8.2 we create this manually, as gst_structure_from_string() is a constructor
# since gst 1.18 and constructor with out parameter is currently not supported by gintro
# the code is taken from v0.8.1 with gst 1.16
const Gst_EPI = """

proc gst_structure_from_string(string: cstring; `end`: var cstring): ptr Structure00 {.
    importc, libprag.}

proc fromStringStructure*(string: cstring; `end`: var string): Structure =
  var end_00 = cstring(`end`)
  let impl0 = gst_structure_from_string(string, end_00)
  if impl0.isNil:
    return nil
  fnew(result, gBoxedFreeGstStructure)
  result.impl = impl0
  `end` = $(end_00)

# https://discourse.gnome.org/t/gst-buffer-copy-is-missing-in-gir-file/5327
# GstMiniObject * gst_mini_object_copy (const GstMiniObject *mini_object);
proc gst_buffer_copy(self: ptr Buffer00): ptr Buffer00 {.
    importc: "gst_mini_object_copy", libprag.}

proc copy*(self: Buffer): Buffer =
  fnew(result, gBoxedFreeGstBuffer)
  result.impl = gst_buffer_copy(cast[ptr Buffer00](self.impl))

include gimplgst

"""

const Pango_EPI = """

when not declared(ATTR_INDEX_TO_TEXT_END):
  const ATTR_INDEX_TO_TEXT_END* = uint32.high

when not declared(ATTR_INDEX_FROM_TEXT_BEGINNING):
  const ATTR_INDEX_FROM_TEXT_BEGINNING* = uint32.low

proc setStartIndex*(a: Attribute; i: uint32) =
  a.impl.startIndex = i

proc setEndIndex*(a: Attribute; i: uint32) =
  a.impl.endIndex = i

proc setIndices*(a: Attribute; s, e: uint32) =
  a.impl.startIndex = s
  a.impl.endIndex = e

proc `startIndex=`*(a: Attribute; i: uint32) =
  a.impl.startIndex = i

proc `endIndex=`*(a: Attribute; i: uint32) =
  a.impl.endIndex = i

#proc `indices=`*(a: Attribute; s, e: uint32) =
proc `indices=`*(a: Attribute; se: tuple[start: uint32; `end`: uint32]) =
  a.impl.startIndex = se[0]
  a.impl.endIndex = se[1]

"""

const Nice_EPI = """

proc nice_agent_get_selected_pair(self: ptr Agent00; streamId: uint32; componentId: uint32;
    local: var ptr Candidate00; remote: var ptr Candidate00): gboolean {.importc, libprag.}

proc getSelectedPair*(self: Agent; streamId: int; componentId: int; local: var Candidate; remote: var Candidate): bool =
  fnew(local, gBoxedFreeNiceCandidate)
  local.ignoreFinalizer = true
  fnew(remote, gBoxedFreeNiceCandidate)
  remote.ignoreFinalizer = true
  toBool(nice_agent_get_selected_pair(cast[ptr Agent00](self.impl), uint32(streamId), uint32(componentId), local.impl, remote.impl))

include gimplnice

"""

const GLib_EPI = """

when not declared(g_thread_new):
  proc g_thread_new(name: cstring; fn: ThreadFunc; data:pointer): ptr Thread00 {.importc, libprag.}

  proc newThread*(name: string; fn: ThreadFunc; data:pointer): Thread =
    fnew(result, finalizerunref)
    result.impl = g_thread_new(name, fn, data)

#include gimplglib will not work as glib does not import gobject

"""

const GTK3_EPI = """

proc mainQuit*(w: Window) = mainQuit()

"""

const GTK4_EPI = """

proc getRootWidget*(self: Widget): Widget =
  let h = self.getRoot
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](h.impl), gtk_widget_get_type())))
  #g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))
  cast[Widget](h)

proc stringObject*(self: gobject.Object): StringObject =
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](self.impl), gtk_string_object_get_type())))
  cast[StringObject](self)

proc fileInfo*(self: gobject.Object): gio.FileInfo =
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](self.impl), g_file_info_get_type())))
  cast[gio.FileInfo](self)

proc gtk_constant_expression_new(value_type: GType): ptr Expression00 {.varargs, importc, libprag.}

proc newConstantExpression*(gtype: GType; obj: gobject.Object): Expression =
  fnew(result, generic_gtk_expression_unref)
  result.impl = gtk_constant_expression_new(gtype, obj.impl)


"""

const GDK4_EPI = """

proc getPosition*(self: Event): (float, float) =
  assert toBool(gdk_event_get_position(cast[ptr Event00](self.impl), result[0].float, result[1].float))

"""

const GTK_EPI = """

proc setMargin*(w: Widget; m: int) =
  setMarginStart(w, m)
  setMarginEnd(w, m)
  setMarginTop(w, m)
  setMarginBottom(w, m)


# allow connecting GtkText and GtkEntry to "changed" signal of GtkEditable!
proc editable*(x: Text): Editable = cast[Editable](x)

proc editable*(x: Entry): Editable = cast[Editable](x)

#proc loadFromData*(self: CssProvider; data: cstring): bool =
#  loadFromData(self, uint8Array(data), -1)

proc addAction*(self: ApplicationWindow; action: Action | PropertyAction | SimpleAction) =
  g_action_map_add_action(cast[ptr ActionMap00](self.impl), cast[ptr Action00](action.impl))

proc gtk_file_chooser_dialog_new*(title: cstring; parent: ptr Window00; action: FileChooserAction; 
    firstButtonText: cstring = nil): ptr FileChooserDialog00 {.varargs,
    importc: "gtk_file_chooser_dialog_new", libprag.}

proc newFileChooserDialog*(title: cstring = nil; parent: Window = nil; action: FileChooserAction): FileChooserDialog =
  let gobj = gtk_file_chooser_dialog_new(title, if parent.isNil: nil else: cast[ptr Window00](parent.impl), action)
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

proc initFileChooserDialog*[T](result: var T; title: cstring = nil; parent: Window = nil; action: FileChooserAction) =
  assert(result is FileChooserDialog)
  let gobj = gtk_file_chooser_dialog_new(title, if parent.isNil: nil else: cast[ptr Window00](parent.impl), action)
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

var
  gstLib: LibHandle
  adwLib: LibHandle
  gtk3Lib: LibHandle
  gtk4Lib: LibHandle

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
  #echo fixedModName(moduleNameSpace)
  #let version: cstring = nil # latest
  # export GI_TYPELIB_PATH=/opt/gtk/lib64/girepository-1.0
  # echo $XDG_DATA_DIRS
  # man g-ir-scanner
  #g_irepository_prepend_search_path("/opt/gtk/lib64/girepository-1.0")
  # ISGTK3 = not (((namespace == "Gtk") or (namespace == "Gdk") or (namespace == "GdkX11")) and version == "4.0")
  # ISGTK3 = parmCount() == 0 # we have to launch the generator two times, as typelibs can not be unloaded!


  if namespace == "Gst" and gstLib == nil:
    gstLib = tryInitGst()

  if namespace == "Adw" and adwLib == nil:
    adwLib = tryInitAdw()

  if namespace == "Gtk" and version == "3.0" and gtk3Lib == nil:
    gtk3Lib = tryInitGtk3()

  if namespace == "Gtk" and version == "4.0" and gtk4Lib == nil:
    gtk4Lib = tryInitGtk4()

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
  var weImportGObject = false
  output.writeLine("# dependencies:")
  var importedModules = ""
  for j in 0 .. 18: # stupid restriction!
    if dep[j].isNil: break
    if j == 0:
      importedModules = "import "
    output.writeLine("# ", dep[j])
    let h = fixedModName(($dep[j]).split('-', 2)[0].toLowerAscii) & ", "
    importedModules.add(h)
    if h == "gobject, ":
      weImportGObject = true
  importedModules.removeSuffix(", ")
  strfreev(dep)
  let idep: cstringArray = gi.gIrepositoryGetImmediateDependencies(namespace)
  output.writeLine("# immediate dependencies:")
  for j in 0 .. 12:
    if idep[j].isNil: break
    output.writeLine("# ", idep[j])
  strfreev(idep)
  let libs = $gi.gIrepositoryGetSharedLibrary(namespace)
  output.writeLine("# libraries:")
  output.writeLine("# ", libs)
  #output.writeLine("{.deadCodeElim: on, warning[UnusedImport]: off.}") # gmodule, xlib, cairo
  output.writeLine("{.warning[UnusedImport]: off.}") # gmodule, xlib, cairo
  output.writeLine(importedModules)
  #var Lib = if libs.isNil: "" else: ($libs).split(',', 2)[0]
  var hlibs = libs.split(',') # maybe we can simplify this later, editDistance() is not the optimal algorithm here
  var hhlibs = hlibs
  for el in mitems(hlibs):
    let p = skipUntil(el, {'0' .. '9', '.'})
    el.setLen(p)
  var Lib = hhlibs[maxby.minIndexByIt(hlibs, editDistanceAscii(it.toLowerAscii, moduleNamespace))]
  # see https://discourse.gnome.org/t/title-in-text-due-to-discourse-bug/4477
  if namespace == "PangoCairo" and Lib.startsWith("libpango-"):
    echo moduleNamespace
    echo Lib
    echo libs
    assert false
    Lib = Lib.replace("libpango-", "libpangocairo-") # GI bug?
  output.writeLine("const Lib = \"$1\"" % Lib)
  output.writeLine("{.pragma: libprag, cdecl, dynlib: Lib.}")

  if namespace == "GObject":
    output.writeLine("type\n  GCallback* = proc () {.cdecl.}")
    #output.writeLine("type\n  Object00Array* = pointer")
    output.writeLine("type\n  VaClosureMarshal* = pointer")
    output.writeLine("\nproc boxedFree*(boxedType: GType; boxed: pointer) {.")
    output.writeLine("    importc: \"g_boxed_free\", libprag.}")
    output.writeLine("\nproc g_boxed_copy*(boxedType: GType; boxed: pointer): pointer {.")
    output.writeLine("    importc , libprag.}")

  elif namespace == "GLib":
    # we need gobject.
    #let gobjectlibs = gi.gIrepositoryGetSharedLibrary("GObject")
    #var GobjectLib = if gobjectlibs.isNil: "" else: ($gobjectlibs).split(',', 2)[0]
    var GobjectLib = maxby.minValueByIt(libs.split(','), editDistanceAscii(it.toLowerAscii, "gobject"))
    output.writeLine("const GobjectLib* = \"$1\"" % GobjectLib)
    output.writeLine("{.pragma: gobjectlibprag, cdecl, dynlib: GobjectLib.}")

    output.writeLine("type\n  GException* = object of CatchableError")
    output.writeLine("type\n  GArray00* = pointer")
    #output.writeLine("type\n  Regex00Array* = pointer")
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

    output.writeLine("\nproc g_boxed_copy(boxedType: GType; boxed: pointer): pointer {.")
    output.writeLine("    importc , gobjectlibprag.}")

    output.writeLine("""
#proc fnew*[T](a: var ref T; finalizer: proc (x: ref T)) =
template fnew*(a: untyped; finalizer: untyped) =
  when defined(gcDestructors):
    system.new(a)
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

    output.writeLine("""
proc uint8ArrayToSeq*(s: ptr uint8; n: int): seq[uint8] =
  let a = cast[ptr UncheckedArray[uint8]](s)
  for i in 0 ..< n:
    result.add(a[i])
""")

    output.writeLine("""
proc uint32ArrayToSeq*(s: ptr uint32; n: int): seq[uint32] =
  let a = cast[ptr UncheckedArray[uint32]](s)
  for i in 0 ..< n:
    result.add(a[i])
""")

    output.writeLine("""
proc int32ArrayToSeq*(s: ptr int32; n: int): seq[int32] =
  let a = cast[ptr UncheckedArray[int32]](s)
  for i in 0 ..< n:
    result.add(a[i])
""")

    output.writeLine("""
proc cstringArrayToSeq*(s: ptr cstring): seq[string] =
  system.cstringArrayToSeq(cast[cstringArray](s))
""")

    output.writeLine("proc cogfree*(mem: pointer) {.importc: \"g_free\", libprag.}")
    output.writeLine("proc g_strfreev*(strArray: ptr cstring) {.importc: \"g_strfreev\", libprag.}")
    output.writeLine("proc toBool*(g: gboolean): bool = g.int != 0")
    # output.writeLine("proc safeStringToCString*(s: cstring): cstring = (if s.len == 0: nil else: s)")
    output.writeLine(PRO)
  elif namespace == "Gdk":
    discard
  elif namespace == "Gtk":
    discard
    #output.writeLine(
    #    "# https://developer.gnome.org/gtk3/stable/GtkWidget.html#GtkWidget-draw")
    #output.writeLine(
    #    "# TRUE to stop other handlers from being invoked for the event. FALSE to propagate the event further.")
    #output.writeLine("const\n  SignalEventStopPropagation* = true")
    #output.writeLine("const\n  SignalEventContinuePropagation* = false")
  elif namespace == "Atk":
    discard
  elif namespace == "cairo":
    output.writeLine("\nfrom gobject import boxedFree")
    output.writeLine("from glib import GType")
  elif namespace == "Pango":
    discard
  elif namespace == "Gio":
    discard
  elif namespace == "Graphene":
    discard
  elif namespace == "Gsk":
    discard
  elif namespace == "GtkSource":
    output.writeLine("import glib")
  elif namespace == "Vte":
    output.writeLine("import glib\n")
  elif namespace == "Gst":
    discard
  elif namespace == "WebKit2":
    output.writeLine("from atk import ImplementorIface\n") # Extern interfaces support
  elif namespace == "Nice":
    output.writeLine("import macros, nativesockets\n")
    output.writeLine("from strutils import `%`\n")
    discard
  if namespace == "GObject":
    output.writeLine("\nimport times")
    output.writeLine("var qt = \"NGIQ\" & $epochTime()")
    output.writeLine("if g_quark_try_string(qt) != 0:")
    output.writeLine("  qt = \"NGIQ\" & $epochTime()")
    output.writeLine("let Quark* = g_quark_from_static_string(qt)")

  #if namespace notin ["GObject", "GLib", "xlib", "GModule"]: #
  if weImportGObject:
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

  for i in 0 .. s.high:
    if namespace == "GstRtsp" and gBaseInfoGetType(s[i]) == GIInfoType.ENUM and gBaseInfoGetName(s[i]) == "RTSPResult":
      let h = s[i]
      s.delete(i, i)
      s.insert([h])
      break

  # NOTE: We may? remove all structs from xcallerAlloc when that struct ever is returned by a function! # v0.9.5
  # And we may remove all structs with a GType!
  # https://discourse.gnome.org/t/what-is-the-difference-between-gmutex-and-gchecksum/4542
  if namespace notin ["HarfBuzz", "cairo"]: # auto-detecting the "light" entities is too hard, but here we get some candidates
    for info in s:
      #if gBaseInfoGetType(info) == GIInfoType.UNION or gBaseInfoGetType(info) == GIInfoType.STRUCT:
      #  if gRegisteredTypeInfoGetGType(info) != G_TYPE_NONE and gTypeFundamental(gRegisteredTypeInfoGetGType(info)) == G_TYPE_BOXED:
      #    echo gBaseInfoGetName(info)#gRegisteredTypeInfoGetGType(info)
      let n = gBaseInfoGetName(info)
      if n[0] != '_' and not n.endsWith("Private") and not (namespace == "Gdk" and n.startsWith("Event")) and not (namespace ==
          "Pango" and n.startsWith("Attribute")):

        if not isRegisteredTypeInfo(info) or gRegisteredTypeInfoGetGType(info) == G_TYPE_NONE: # v0.9.5

          if gBaseInfoGetType(info) == GIInfoType.STRUCT:
            # if not ((gStructInfoIsGtypeStruct(info) and n != "ObjectClass")): # v0.9.4 with Debian Buster crash
            # if (not gStructInfoIsGtypeStruct(info) or (n == "ObjectClass")): # equivalent to above
            if (not gStructInfoIsGtypeStruct(info) and (n != "ObjectClass")): # this may work -- the same as suggested by Mr. 1jss 
              var lightObj = true
              for n in "free unref  get_qdata".split:
                if gStructInfoFindMethod(info, n) != nil: # crash for legacy Debian Buster
                  lightObj = false
              if lightObj:
                for j in 0.cint ..< gStructInfoGetNMethods(info):
                  let minfo = gStructInfoGetMethod(info, j)
                  if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
                    lightObj = false
              if lightObj:
                let el = moduleNamespace & '.' & $n
                if not manCallerAlloc.contains(el) and not noCallerAlloc.contains(el):
                  xcallerAlloc.incl(el)

          if gBaseInfoGetType(info) == GIInfoType.UNION:
            var lightObj = true
            for n in "free unref  get_qdata".split:
              if gUnionInfoFindMethod(info, n) != nil:
                lightObj = false
            if lightObj:
              for j in 0.cint ..< gUnionInfoGetNMethods(info):
                let minfo = gUnionInfoGetMethod(info, j)
                if (gFunctionInfoGetFlags(mInfo).int and GIFunctionInfoFlags.IS_CONSTRUCTOR.int) != 0:
                  lightObj = false
            if lightObj:
              let el = moduleNamespace & '.' & $n
              if not manCallerAlloc.contains(el) and not noCallerAlloc.contains(el):
                xcallerAlloc.incl(el)

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
          gdkKeys[h.toLowerAscii] = @[h]
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
      for a in 1 .. 3: # process clustered symbols into one single type section
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
  #var argv: cstringArray = nil
  var argv: ptr cstring = nil
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
  #var argv: cstringArray = nil
  var argv: ptr cstring = nil
  gtk_init(argc,  argv)
""")

    output.write(GTK_EPI % fixedModName("gtk"))
    if ISGTK3:
      output.write("include gisup3\n")
      output.write("include gimplgobj\n")
      output.write("include gimplgtk\n")
    else:
      output.write(GTK4_EPI)
      output.write("include gisup4\n")
      output.write("include gimplgobj\n")
      output.write("include gimplgtk\n")
    buildableList.add("MenuModel")
    buildableList.add("FileChooserNative")
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
    GC_ref(result) # as following g_object_unref() call will also  execute a GC_unref(result) call
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[])) # do toggle_refs make sense at all for builder objects?
    g_object_unref(result.impl) # new for v0.8.4 and GTK4, make close main windows working
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))
  assert(toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](result.impl), gt)))

""" % [i, prefix & "_" & myCamelToSnake(i) & "_get_type()", modname])
    output.write("")

  if namespace == "Gio":
    output.write(GIO_EPI)

  if namespace == "GObject":
    output.write(GObject_EPI)

  if namespace == "Gst":
    output.write(Gst_EPI)

  if namespace == "Pango":
    output.write(Pango_EPI)

  if namespace == "GLib":
    output.write(GLib_EPI)

  if namespace == "Nice":
    output.write(Nice_EPI)

  if namespace == "cairo":
    if not cairoProvidesRectangle:
      output.writeLine("""
type
  Rectangle* {.pure, byRef.} = object
    x*: cdouble
    y*: cdouble
    width*: cdouble
    height*: cdouble

proc cairo_gobject_rectangle_get_type*(): GType {.importc, libprag.}
""")
    output.write("\ninclude cairoimpl\n")

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

  output.setPosition(output.data.len)

  if namespace == "Gdk":
    if ISGTK3:
      output.write(GDK3_EPI.replace("SomeEvent", "Event"))
    output.write(GDK_EPI.replace("SomeEvent", "Event"))
    if not ISGTK3:
      output.write(GDK4_EPI)

  if namespace == "GtkSource":
    output.write(GTK_SOURCE_EPI % fixedModName("gtksource"))
  output.flush
  var suff = ""
  if version == "4.0":
    suff = "4"
  if namespace == "GtkSource" and version == nil:
    suff = "5"

  if namespace in ["JavaScriptCore", "WebKit2", "WebKit2WebExtension"]:
    if version == "4.0":
      suff = ""
    if version == "5.0":
      suff = "5"

  var o = open("nim_gi" / (namespace.toLowerAscii) & suff & ".nim", fmWrite)
  o.write(output.data)
  o.close()
  output.close
  var hs = fixedModName(moduleNameSpace) & "............................"
  hs.setLen(24)
  stdout.write(hs, ": Remaining delayed methods: ", delayedMethods.len)
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
    main("GObject") # and the old common onces. GObject before Glib!
    main("GLib")
    main("Gio")
    main("GdkPixbuf")
    main("GModule")
    main("GtkSource", "4")
    main("Atk")
    main("Pango")
    main("PangoCairo")
    main("PangoFT2")
    main("fontconfig")
    main("freetype2")
    main("HarfBuzz")
    main("Rsvg")
    main("xlib")
    main("Vte")
    main("Notify")
    main("Handy")
    main("Nice")
    main("cairo")
    main("WebKit2", "4.0")
    main("JavaScriptCore", "4.0")
    main("Soup")
    main("WebKit2WebExtension", "4.0")
    main("Gst")
    main("GstBase")
    main("GstAllocators")
    main("GstApp")
    main("GstAudio")
    main("GstCheck")
    main("GstController")
    main("GstGL")
    main("GstInsertBin")
    main("GstMpegts")
    main("GstNet")
    main("GstPlayer")
    main("GstRtp")
    main("GstRtsp")
    main("GstSdp")
    main("GstTag")
    main("GstVideo")
    main("GstWebRTC")
    main("GstApp")
    main("GstPbutils")
    main("GtkLayerShell")
  else:
    echo "First we try generating bindings for GTK4, this may fail when GTK4 is not properly installed"
    echo "on your computer. But don't worry, you can still use GTK3"
    main("Gtk", "4.0") # the 3 new 4.0 releases
    main("Gdk", "4.0")
    main("GdkX11", "4.0")
    main("Gsk") # and two new ones for gtk4
    main("Graphene")
    main("GObject") # and the old common onces. GObject before Glib!
    main("GLib")
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
    main("HarfBuzz")
    main("Rsvg")
    main("xlib")
    # main("Vte") # not yet available for GTK4
    main("Notify")
    # main("Handy") # not yet available for GTK4
    main("Adw") # replaces libhandy for GTK4
    main("Nice")
    main("cairo")
    main("WebKit2", "4.0")
    main("JavaScriptCore", "4.0")
    main("Soup")
    main("WebKit2WebExtension", "4.0")
    main("Gst")
    main("GstBase")
    main("GstAllocators")
    main("GstApp")
    main("GstAudio")
    main("GstCheck")
    main("GstController")
    main("GstGL")
    main("GstInsertBin")
    main("GstMpegts")
    main("GstNet")
    main("GstPlayer")
    main("GstRtp")
    main("GstRtsp")
    main("GstSdp")
    main("GstTag")
    main("GstVideo")
    main("GstWebRTC")
    main("GstApp")
    main("GstPbutils")

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
  if gstLib != nil:
    unloadLib(gstLib)
  if adwLib != nil:
    unloadLib(adwLib)
  if gtk3Lib != nil:
    unloadLib(gtk3Lib)
  if gtk4Lib != nil:
    unloadLib(gtk4Lib)

launch()

#for el in xcallerAlloc:
#  if not callerAlloc.contains(el):
#    echo "maybe add: ", el

#for el in xcallerAlloc:
#  if not callerAlloc.contains(el):
#    echo "maybe add: ", el

#echo "---"
#for el in oldcallerAlloc:
#  if not xcallerAlloc.contains(el):
#    echo el

# 4467 lines
# gtk_icon_view_get_tooltip_context bug Candidate
# gtk_tree_view_get_cursor bug
#
# troubles: gTypeFundamental(gRegisteredTypeInfoGetGType(info)) == G_TYPE_BOXED:
#[

salewski@nuc ~/gintrotest/tests $ grep -A6 "listTargets\*" nim_gi/*
nim_gi/gdk.nim:proc listTargets*(self: DragContext): seq[Atom] =
nim_gi/gdk.nim-  discard

proc gst_structure_take(oldstrPtr: var ptr Structure00; newstr: ptr Structure00): gboolean {.
  importc, libprag.}

proc take*(oldstrPtr: var Structure; newstr: Structure = nil): bool =
  toBool(gst_structure_take(if oldstrPtr.isNil: nil else: cast[ptr Structure00](oldstrPtr.impl), if newstr.isNil: nil else: cast[ptr Structure00](newstr.impl)))

gtk4 CssLocation may be userAlloc ! 

]#

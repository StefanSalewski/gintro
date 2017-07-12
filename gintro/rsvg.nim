# dependencies:
# cairo-1.0
# GLib-2.0
# Gio-2.0
# GObject-2.0
# GModule-2.0
# GdkPixbuf-2.0
# immediate dependencies:
# cairo-1.0
# Gio-2.0
# GdkPixbuf-2.0
# GObject-2.0
# GLib-2.0
# libraries:
# librsvg-2.so.2
{.deadCodeElim: on.}
import cairo, glib, gio, gobject, gmodule, gdkpixbuf
const Lib* = "librsvg-2.so.2"
{.pragma: libprag, cdecl, dynlib: Lib.}
let Quark = g_quark_from_static_string("NimGIQuark")

type
  DimensionData00* {.pure.} = object
    width*: int32
    height*: int32
    em*: cdouble
    ex*: cdouble
  DimensionData* = ref object
    impl*: ptr DimensionData00

type
  Error* {.size: sizeof(cint), pure.} = enum
    errorFailed = 0

type
  HandlePrivate00* {.pure.} = object
  HandlePrivate* = ref object
    impl*: ptr HandlePrivate00

type
  Handle* = ref object of gobject.Object
  Handle00* = object of gobject.Object00
    priv1: ptr HandlePrivate00
    abiPadding*: array[15, pointer]

proc rsvg_handle_new*(): ptr Handle00 {.
    importc: "rsvg_handle_new", libprag.}

proc newHandle*(): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandle*[T](result: var T) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_data*(data: uint8Array; dataLen: uint64): ptr Handle00 {.
    importc: "rsvg_handle_new_from_data", libprag.}

proc newHandleFromData*(data: uint8Array; dataLen: uint64): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_data(data, dataLen)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromData*[T](result: var T; data: uint8Array; dataLen: uint64) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_data(data, dataLen)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_file*(fileName: cstring): ptr Handle00 {.
    importc: "rsvg_handle_new_from_file", libprag.}

proc newHandleFromFile*(fileName: string): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_file(cstring(fileName))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromFile*[T](result: var T; fileName: string) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_file(cstring(fileName))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_close*(self: ptr Handle00): gboolean {.
    importc: "rsvg_handle_close", libprag.}

proc close*(self: Handle): bool =
  toBool(rsvg_handle_close(cast[ptr Handle00](self.impl)))

proc rsvg_handle_get_base_uri*(self: ptr Handle00): cstring {.
    importc: "rsvg_handle_get_base_uri", libprag.}

proc getBaseUri*(self: Handle): string =
  let resul0 = rsvg_handle_get_base_uri(cast[ptr Handle00](self.impl))
  result = $resul0

proc baseUri*(self: Handle): string =
  let resul0 = rsvg_handle_get_base_uri(cast[ptr Handle00](self.impl))
  result = $resul0

proc rsvg_handle_get_dimensions*(self: ptr Handle00; dimensionData: var DimensionData00) {.
    importc: "rsvg_handle_get_dimensions", libprag.}

proc getDimensions*(self: ptr Handle00; dimensionData: var DimensionData00) {.
    importc: "rsvg_handle_get_dimensions", libprag.}

proc dimensions*(self: ptr Handle00; dimensionData: var DimensionData00) {.
    importc: "rsvg_handle_get_dimensions", libprag.}

proc rsvg_handle_get_dimensions_sub*(self: ptr Handle00; dimensionData: var DimensionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_dimensions_sub", libprag.}

proc getDimensionsSub*(self: ptr Handle00; dimensionData: var DimensionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_dimensions_sub", libprag.}

proc dimensionsSub*(self: ptr Handle00; dimensionData: var DimensionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_dimensions_sub", libprag.}

proc rsvg_handle_get_pixbuf*(self: ptr Handle00): ptr gdkpixbuf.Pixbuf00 {.
    importc: "rsvg_handle_get_pixbuf", libprag.}

proc getPixbuf*(self: Handle): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf(cast[ptr Handle00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[gdkpixbuf.Pixbuf](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbuf*(self: Handle): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf(cast[ptr Handle00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[gdkpixbuf.Pixbuf](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_get_pixbuf_sub*(self: ptr Handle00; id: cstring): ptr gdkpixbuf.Pixbuf00 {.
    importc: "rsvg_handle_get_pixbuf_sub", libprag.}

proc getPixbufSub*(self: Handle; id: string): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf_sub(cast[ptr Handle00](self.impl), cstring(id))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[gdkpixbuf.Pixbuf](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pixbufSub*(self: Handle; id: string): gdkpixbuf.Pixbuf =
  let gobj = rsvg_handle_get_pixbuf_sub(cast[ptr Handle00](self.impl), cstring(id))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[gdkpixbuf.Pixbuf](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_has_sub*(self: ptr Handle00; id: cstring): gboolean {.
    importc: "rsvg_handle_has_sub", libprag.}

proc hasSub*(self: Handle; id: string): bool =
  toBool(rsvg_handle_has_sub(cast[ptr Handle00](self.impl), cstring(id)))

proc rsvg_handle_read_stream_sync*(self: ptr Handle00; stream: ptr gio.InputStream00; 
    cancellable: ptr gio.Cancellable00): gboolean {.
    importc: "rsvg_handle_read_stream_sync", libprag.}

proc readStreamSync*(self: Handle; stream: gio.InputStream; cancellable: gio.Cancellable): bool =
  toBool(rsvg_handle_read_stream_sync(cast[ptr Handle00](self.impl), cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl)))

proc rsvg_handle_render_cairo*(self: ptr Handle00; cr: ptr cairo.Context00): gboolean {.
    importc: "rsvg_handle_render_cairo", libprag.}

proc renderCairo*(self: Handle; cr: cairo.Context): bool =
  toBool(rsvg_handle_render_cairo(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl)))

proc rsvg_handle_render_cairo_sub*(self: ptr Handle00; cr: ptr cairo.Context00; id: cstring): gboolean {.
    importc: "rsvg_handle_render_cairo_sub", libprag.}

proc renderCairoSub*(self: Handle; cr: cairo.Context; id: string): bool =
  toBool(rsvg_handle_render_cairo_sub(cast[ptr Handle00](self.impl), cast[ptr cairo.Context00](cr.impl), cstring(id)))

proc rsvg_handle_set_base_gfile*(self: ptr Handle00; baseFile: ptr gio.File00) {.
    importc: "rsvg_handle_set_base_gfile", libprag.}

proc setBaseGfile*(self: Handle; baseFile: gio.File) =
  rsvg_handle_set_base_gfile(cast[ptr Handle00](self.impl), cast[ptr gio.File00](baseFile.impl))

proc `baseGfile=`*(self: Handle; baseFile: gio.File) =
  rsvg_handle_set_base_gfile(cast[ptr Handle00](self.impl), cast[ptr gio.File00](baseFile.impl))

proc rsvg_handle_set_base_uri*(self: ptr Handle00; baseUri: cstring) {.
    importc: "rsvg_handle_set_base_uri", libprag.}

proc setBaseUri*(self: Handle; baseUri: string) =
  rsvg_handle_set_base_uri(cast[ptr Handle00](self.impl), cstring(baseUri))

proc `baseUri=`*(self: Handle; baseUri: string) =
  rsvg_handle_set_base_uri(cast[ptr Handle00](self.impl), cstring(baseUri))

proc rsvg_handle_set_dpi*(self: ptr Handle00; dpi: cdouble) {.
    importc: "rsvg_handle_set_dpi", libprag.}

proc setDpi*(self: Handle; dpi: cdouble) =
  rsvg_handle_set_dpi(cast[ptr Handle00](self.impl), dpi)

proc `dpi=`*(self: Handle; dpi: cdouble) =
  rsvg_handle_set_dpi(cast[ptr Handle00](self.impl), dpi)

proc rsvg_handle_set_dpi_x_y*(self: ptr Handle00; dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_handle_set_dpi_x_y", libprag.}

proc setDpiXY*(self: Handle; dpiX: cdouble; dpiY: cdouble) =
  rsvg_handle_set_dpi_x_y(cast[ptr Handle00](self.impl), dpiX, dpiY)

proc rsvg_handle_write*(self: ptr Handle00; buf: uint8Array; count: uint64): gboolean {.
    importc: "rsvg_handle_write", libprag.}

proc write*(self: Handle; buf: uint8Array; count: uint64): bool =
  toBool(rsvg_handle_write(cast[ptr Handle00](self.impl), buf, count))

type
  HandleFlag* {.size: sizeof(cint), pure.} = enum
    flagUnlimited = 1
    flagKeepImageData = 2

  HandleFlags* {.size: sizeof(cint).} = set[HandleFlag]

proc rsvg_handle_new_from_gfile_sync*(file: ptr gio.File00; flags: HandleFlags; cancellable: ptr gio.Cancellable00): ptr Handle00 {.
    importc: "rsvg_handle_new_from_gfile_sync", libprag.}

proc newHandleFromGfileSync*(file: gio.File; flags: HandleFlags; cancellable: gio.Cancellable): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_gfile_sync(cast[ptr gio.File00](file.impl), flags, cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromGfileSync*[T](result: var T; file: gio.File; flags: HandleFlags; cancellable: gio.Cancellable) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_gfile_sync(cast[ptr gio.File00](file.impl), flags, cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_from_stream_sync*(inputStream: ptr gio.InputStream00; baseFile: ptr gio.File00; 
    flags: HandleFlags; cancellable: ptr gio.Cancellable00): ptr Handle00 {.
    importc: "rsvg_handle_new_from_stream_sync", libprag.}

proc newHandleFromStreamSync*(inputStream: gio.InputStream; baseFile: gio.File; 
    flags: HandleFlags; cancellable: gio.Cancellable): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_stream_sync(cast[ptr gio.InputStream00](inputStream.impl), cast[ptr gio.File00](baseFile.impl), flags, cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleFromStreamSync*[T](result: var T; inputStream: gio.InputStream; baseFile: gio.File; 
    flags: HandleFlags; cancellable: gio.Cancellable) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_from_stream_sync(cast[ptr gio.InputStream00](inputStream.impl), cast[ptr gio.File00](baseFile.impl), flags, cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc rsvg_handle_new_with_flags*(flags: HandleFlags): ptr Handle00 {.
    importc: "rsvg_handle_new_with_flags", libprag.}

proc newHandleWithFlags*(flags: HandleFlags): Handle =
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_with_flags(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initHandleWithFlags*[T](result: var T; flags: HandleFlags) =
  assert(result is Handle)
  new(result, finalizeGObject)
  result.impl = rsvg_handle_new_with_flags(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PositionData00* {.pure.} = object
    x*: int32
    y*: int32
  PositionData* = ref object
    impl*: ptr PositionData00

proc rsvg_handle_get_position_sub*(self: ptr Handle00; positionData: var PositionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_position_sub", libprag.}

proc getPositionSub*(self: ptr Handle00; positionData: var PositionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_position_sub", libprag.}

proc positionSub*(self: ptr Handle00; positionData: var PositionData00; 
    id: cstring): gboolean {.
    importc: "rsvg_handle_get_position_sub", libprag.}

type
  HandleClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    abiPadding*: array[15, pointer]
  HandleClass* = ref object
    impl*: ptr HandleClass00

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 17'i32

const MINOR_VERSION* = 40'i32

const VERSION* = "2.40.17"

proc rsvg_cleanup*() {.
    importc: "rsvg_cleanup", libprag.}

proc cleanup*() {.
    importc: "rsvg_cleanup", libprag.}

proc rsvg_error_quark*(): uint32 {.
    importc: "rsvg_error_quark", libprag.}

proc rsvg_set_default_dpi*(dpi: cdouble) {.
    importc: "rsvg_set_default_dpi", libprag.}

proc setDefaultDpi*(dpi: cdouble) {.
    importc: "rsvg_set_default_dpi", libprag.}

proc `defaultDpi=`*(dpi: cdouble) {.
    importc: "rsvg_set_default_dpi", libprag.}

proc rsvg_set_default_dpi_x_y*(dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_set_default_dpi_x_y", libprag.}

proc setDefaultDpiXY*(dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_set_default_dpi_x_y", libprag.}

proc `defaultDpiXY=`*(dpiX: cdouble; dpiY: cdouble) {.
    importc: "rsvg_set_default_dpi_x_y", libprag.}
# === remaining symbols:

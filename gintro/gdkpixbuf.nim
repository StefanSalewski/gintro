# dependencies:
# GLib-2.0
# Gio-2.0
# GObject-2.0
# GModule-2.0
# immediate dependencies:
# Gio-2.0
# GModule-2.0
# libraries:
# libgdk_pixbuf-2.0.so.0
{.deadCodeElim: on.}
import glib, gio, gobject, gmodule
const Lib* = "libgdk_pixbuf-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
let Quark = g_quark_from_static_string("NimGIQuark")

type
  Colorspace* {.size: sizeof(cint), pure.} = enum
    rgb = 0

type
  InterpType* {.size: sizeof(cint), pure.} = enum
    nearest = 0
    tiles = 1
    bilinear = 2
    hyper = 3

const PIXBUF_FEATURES_H* = 1'i32

const PIXBUF_MAGIC_NUMBER* = 1197763408'i32

const PIXBUF_MAJOR* = 2'i32

const PIXBUF_MICRO* = 6'i32

const PIXBUF_MINOR* = 36'i32

const PIXBUF_VERSION* = "2.36.6"

const PIXDATA_HEADER_LENGTH* = 24'i32

type
  Pixbuf* = ref object of gobject.Object
  Pixbuf00* = object of gobject.Object00

proc gdk_pixbuf_new*(colorspace: Colorspace; hasAlpha: gboolean; bitsPerSample: int32; 
    width: int32; height: int32): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new", libprag.}

proc newPixbuf*(colorspace: Colorspace; hasAlpha: bool; bitsPerSample: int; 
    width: int; height: int): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbuf*[T](result: var T; colorspace: Colorspace; hasAlpha: bool; bitsPerSample: int; 
    width: int; height: int) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new(colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_bytes*(data: ptr glib.Bytes00; colorspace: Colorspace; hasAlpha: gboolean; 
    bitsPerSample: int32; width: int32; height: int32; rowstride: int32): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_bytes", libprag.}

proc newPixbufFromBytes*(data: glib.Bytes; colorspace: Colorspace; hasAlpha: bool; 
    bitsPerSample: int; width: int; height: int; rowstride: int): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_bytes(cast[ptr glib.Bytes00](data.impl), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromBytes*[T](result: var T; data: glib.Bytes; colorspace: Colorspace; hasAlpha: bool; 
    bitsPerSample: int; width: int; height: int; rowstride: int) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_bytes(cast[ptr glib.Bytes00](data.impl), colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_file*(filename: cstring): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_file", libprag.}

proc newPixbufFromFile*(filename: string): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file(cstring(filename))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromFile*[T](result: var T; filename: string) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file(cstring(filename))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_file_at_scale*(filename: cstring; width: int32; height: int32; preserveAspectRatio: gboolean): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_file_at_scale", libprag.}

proc newPixbufFromFileAtScale*(filename: string; width: int; height: int; preserveAspectRatio: bool): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file_at_scale(cstring(filename), int32(width), int32(height), gboolean(preserveAspectRatio))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromFileAtScale*[T](result: var T; filename: string; width: int; height: int; preserveAspectRatio: bool) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file_at_scale(cstring(filename), int32(width), int32(height), gboolean(preserveAspectRatio))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_file_at_size*(filename: cstring; width: int32; height: int32): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_file_at_size", libprag.}

proc newPixbufFromFileAtSize*(filename: string; width: int; height: int): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file_at_size(cstring(filename), int32(width), int32(height))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromFileAtSize*[T](result: var T; filename: string; width: int; height: int) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_file_at_size(cstring(filename), int32(width), int32(height))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_inline*(dataLength: int32; data: uint8Array; copyPixels: gboolean): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_inline", libprag.}

proc newPixbufFromInline*(dataLength: int; data: uint8Array; copyPixels: bool): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_inline(int32(dataLength), data, gboolean(copyPixels))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromInline*[T](result: var T; dataLength: int; data: uint8Array; copyPixels: bool) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_inline(int32(dataLength), data, gboolean(copyPixels))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_resource*(resourcePath: cstring): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_resource", libprag.}

proc newPixbufFromResource*(resourcePath: string): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_resource(cstring(resourcePath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromResource*[T](result: var T; resourcePath: string) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_resource(cstring(resourcePath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_resource_at_scale*(resourcePath: cstring; width: int32; height: int32; 
    preserveAspectRatio: gboolean): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_resource_at_scale", libprag.}

proc newPixbufFromResourceAtScale*(resourcePath: string; width: int; height: int; preserveAspectRatio: bool): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_resource_at_scale(cstring(resourcePath), int32(width), int32(height), gboolean(preserveAspectRatio))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromResourceAtScale*[T](result: var T; resourcePath: string; width: int; height: int; preserveAspectRatio: bool) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_resource_at_scale(cstring(resourcePath), int32(width), int32(height), gboolean(preserveAspectRatio))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_stream*(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_stream", libprag.}

proc newPixbufFromStream*(stream: gio.InputStream; cancellable: gio.Cancellable): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromStream*[T](result: var T; stream: gio.InputStream; cancellable: gio.Cancellable) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_stream_at_scale*(stream: ptr gio.InputStream00; width: int32; height: int32; 
    preserveAspectRatio: gboolean; cancellable: ptr gio.Cancellable00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_stream_at_scale", libprag.}

proc newPixbufFromStreamAtScale*(stream: gio.InputStream; width: int; height: int; 
    preserveAspectRatio: bool; cancellable: gio.Cancellable): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream_at_scale(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromStreamAtScale*[T](result: var T; stream: gio.InputStream; width: int; height: int; 
    preserveAspectRatio: bool; cancellable: gio.Cancellable) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream_at_scale(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_stream_finish*(asyncResult: ptr gio.AsyncResult00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_stream_finish", libprag.}

proc newPixbufFromStreamFinish*(asyncResult: gio.AsyncResult): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromStreamFinish*[T](result: var T; asyncResult: gio.AsyncResult) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_new_from_xpm_data*(data: cstringArray): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_xpm_data", libprag.}

proc newPixbufFromXpmData*(data: cstringArray): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_xpm_data(data)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromXpmData*[T](result: var T; data: cstringArray) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_xpm_data(data)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_get_file_info_async*(filename: cstring; cancellable: ptr gio.Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "gdk_pixbuf_get_file_info_async", libprag.}

proc getFileInfoAsync*(filename: string; cancellable: gio.Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  gdk_pixbuf_get_file_info_async(cstring(filename), cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc fileInfoAsync*(filename: string; cancellable: gio.Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  gdk_pixbuf_get_file_info_async(cstring(filename), cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_get_formats*(): ptr pointer {.
    importc: "gdk_pixbuf_get_formats", libprag.}

proc getFormats*(): ptr pointer {.
    importc: "gdk_pixbuf_get_formats", libprag.}

proc formats*(): ptr pointer {.
    importc: "gdk_pixbuf_get_formats", libprag.}

proc gdk_pixbuf_new_from_stream_async*(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "gdk_pixbuf_new_from_stream_async", libprag.}

proc newFromStreamAsync*(stream: gio.InputStream; cancellable: gio.Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_new_from_stream_async(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_new_from_stream_at_scale_async*(stream: ptr gio.InputStream00; width: int32; height: int32; 
    preserveAspectRatio: gboolean; cancellable: ptr gio.Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "gdk_pixbuf_new_from_stream_at_scale_async", libprag.}

proc newFromStreamAtScaleAsync*(stream: gio.InputStream; width: int; height: int; 
    preserveAspectRatio: bool; cancellable: gio.Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_new_from_stream_at_scale_async(cast[ptr gio.InputStream00](stream.impl), int32(width), int32(height), gboolean(preserveAspectRatio), cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_save_to_stream_finish*(asyncResult: ptr gio.AsyncResult00): gboolean {.
    importc: "gdk_pixbuf_save_to_stream_finish", libprag.}

proc saveToStreamFinish*(asyncResult: gio.AsyncResult): bool =
  toBool(gdk_pixbuf_save_to_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl)))

proc gdk_pixbuf_add_alpha*(self: ptr Pixbuf00; substituteColor: gboolean; r: uint8; 
    g: uint8; b: uint8): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_add_alpha", libprag.}

proc addAlpha*(self: Pixbuf; substituteColor: bool; r: uint8; g: uint8; 
    b: uint8): Pixbuf =
  let gobj = gdk_pixbuf_add_alpha(cast[ptr Pixbuf00](self.impl), gboolean(substituteColor), r, g, b)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_apply_embedded_orientation*(self: ptr Pixbuf00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_apply_embedded_orientation", libprag.}

proc applyEmbeddedOrientation*(self: Pixbuf): Pixbuf =
  let gobj = gdk_pixbuf_apply_embedded_orientation(cast[ptr Pixbuf00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_composite*(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32; 
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; 
    scaleY: cdouble; interpType: InterpType; overallAlpha: int32) {.
    importc: "gdk_pixbuf_composite", libprag.}

proc composite*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int; 
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; scaleY: cdouble; 
    interpType: InterpType; overallAlpha: int) =
  gdk_pixbuf_composite(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType, int32(overallAlpha))

proc gdk_pixbuf_composite_color*(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32; 
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; 
    scaleY: cdouble; interpType: InterpType; overallAlpha: int32; checkX: int32; checkY: int32; checkSize: int32; color1: uint32; color2: uint32) {.
    importc: "gdk_pixbuf_composite_color", libprag.}

proc compositeColor*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int; 
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; scaleY: cdouble; 
    interpType: InterpType; overallAlpha: int; checkX: int; checkY: int; checkSize: int; color1: int; color2: int) =
  gdk_pixbuf_composite_color(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType, int32(overallAlpha), int32(checkX), int32(checkY), int32(checkSize), uint32(color1), uint32(color2))

proc gdk_pixbuf_composite_color_simple*(self: ptr Pixbuf00; destWidth: int32; destHeight: int32; 
    interpType: InterpType; overallAlpha: int32; checkSize: int32; color1: uint32; color2: uint32): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_composite_color_simple", libprag.}

proc compositeColorSimple*(self: Pixbuf; destWidth: int; destHeight: int; interpType: InterpType; 
    overallAlpha: int; checkSize: int; color1: int; color2: int): Pixbuf =
  let gobj = gdk_pixbuf_composite_color_simple(cast[ptr Pixbuf00](self.impl), int32(destWidth), int32(destHeight), interpType, int32(overallAlpha), int32(checkSize), uint32(color1), uint32(color2))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_copy*(self: ptr Pixbuf00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_copy", libprag.}

proc copy*(self: Pixbuf): Pixbuf =
  let gobj = gdk_pixbuf_copy(cast[ptr Pixbuf00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_copy_area*(self: ptr Pixbuf00; srcX: int32; srcY: int32; width: int32; 
    height: int32; destPixbuf: ptr Pixbuf00; destX: int32; destY: int32) {.
    importc: "gdk_pixbuf_copy_area", libprag.}

proc copyArea*(self: Pixbuf; srcX: int; srcY: int; width: int; height: int; 
    destPixbuf: Pixbuf; destX: int; destY: int) =
  gdk_pixbuf_copy_area(cast[ptr Pixbuf00](self.impl), int32(srcX), int32(srcY), int32(width), int32(height), cast[ptr Pixbuf00](destPixbuf.impl), int32(destX), int32(destY))

proc gdk_pixbuf_copy_options*(self: ptr Pixbuf00; destPixbuf: ptr Pixbuf00): gboolean {.
    importc: "gdk_pixbuf_copy_options", libprag.}

proc copyOptions*(self: Pixbuf; destPixbuf: Pixbuf): bool =
  toBool(gdk_pixbuf_copy_options(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](destPixbuf.impl)))

proc gdk_pixbuf_fill*(self: ptr Pixbuf00; pixel: uint32) {.
    importc: "gdk_pixbuf_fill", libprag.}

proc fill*(self: Pixbuf; pixel: int) =
  gdk_pixbuf_fill(cast[ptr Pixbuf00](self.impl), uint32(pixel))

proc gdk_pixbuf_flip*(self: ptr Pixbuf00; horizontal: gboolean): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_flip", libprag.}

proc flip*(self: Pixbuf; horizontal: bool): Pixbuf =
  let gobj = gdk_pixbuf_flip(cast[ptr Pixbuf00](self.impl), gboolean(horizontal))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_get_bits_per_sample*(self: ptr Pixbuf00): int32 {.
    importc: "gdk_pixbuf_get_bits_per_sample", libprag.}

proc getBitsPerSample*(self: Pixbuf): int =
  int(gdk_pixbuf_get_bits_per_sample(cast[ptr Pixbuf00](self.impl)))

proc bitsPerSample*(self: Pixbuf): int =
  int(gdk_pixbuf_get_bits_per_sample(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_byte_length*(self: ptr Pixbuf00): uint64 {.
    importc: "gdk_pixbuf_get_byte_length", libprag.}

proc getByteLength*(self: Pixbuf): uint64 =
  gdk_pixbuf_get_byte_length(cast[ptr Pixbuf00](self.impl))

proc byteLength*(self: Pixbuf): uint64 =
  gdk_pixbuf_get_byte_length(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_colorspace*(self: ptr Pixbuf00): Colorspace {.
    importc: "gdk_pixbuf_get_colorspace", libprag.}

proc getColorspace*(self: Pixbuf): Colorspace =
  gdk_pixbuf_get_colorspace(cast[ptr Pixbuf00](self.impl))

proc colorspace*(self: Pixbuf): Colorspace =
  gdk_pixbuf_get_colorspace(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_has_alpha*(self: ptr Pixbuf00): gboolean {.
    importc: "gdk_pixbuf_get_has_alpha", libprag.}

proc getHasAlpha*(self: Pixbuf): bool =
  toBool(gdk_pixbuf_get_has_alpha(cast[ptr Pixbuf00](self.impl)))

proc hasAlpha*(self: Pixbuf): bool =
  toBool(gdk_pixbuf_get_has_alpha(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_height*(self: ptr Pixbuf00): int32 {.
    importc: "gdk_pixbuf_get_height", libprag.}

proc getHeight*(self: Pixbuf): int =
  int(gdk_pixbuf_get_height(cast[ptr Pixbuf00](self.impl)))

proc height*(self: Pixbuf): int =
  int(gdk_pixbuf_get_height(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_n_channels*(self: ptr Pixbuf00): int32 {.
    importc: "gdk_pixbuf_get_n_channels", libprag.}

proc getNChannels*(self: Pixbuf): int =
  int(gdk_pixbuf_get_n_channels(cast[ptr Pixbuf00](self.impl)))

proc nChannels*(self: Pixbuf): int =
  int(gdk_pixbuf_get_n_channels(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_option*(self: ptr Pixbuf00; key: cstring): cstring {.
    importc: "gdk_pixbuf_get_option", libprag.}

proc getOption*(self: Pixbuf; key: string): string =
  let resul0 = gdk_pixbuf_get_option(cast[ptr Pixbuf00](self.impl), cstring(key))
  result = $resul0

proc option*(self: Pixbuf; key: string): string =
  let resul0 = gdk_pixbuf_get_option(cast[ptr Pixbuf00](self.impl), cstring(key))
  result = $resul0

proc gdk_pixbuf_get_options*(self: ptr Pixbuf00): ptr HashTable00 {.
    importc: "gdk_pixbuf_get_options", libprag.}

proc getOptions*(self: Pixbuf): ptr HashTable00 =
  gdk_pixbuf_get_options(cast[ptr Pixbuf00](self.impl))

proc options*(self: Pixbuf): ptr HashTable00 =
  gdk_pixbuf_get_options(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_get_pixels_with_length*(self: ptr Pixbuf00; length: var uint32): uint8Array {.
    importc: "gdk_pixbuf_get_pixels_with_length", libprag.}

proc getPixels*(self: Pixbuf; length: var int): uint8Array =
  var length_00 = uint32(length)
  result = gdk_pixbuf_get_pixels_with_length(cast[ptr Pixbuf00](self.impl), length_00)
  length = int(length_00)

proc pixels*(self: Pixbuf; length: var int): uint8Array =
  var length_00 = uint32(length)
  result = gdk_pixbuf_get_pixels_with_length(cast[ptr Pixbuf00](self.impl), length_00)
  length = int(length_00)

proc gdk_pixbuf_get_rowstride*(self: ptr Pixbuf00): int32 {.
    importc: "gdk_pixbuf_get_rowstride", libprag.}

proc getRowstride*(self: Pixbuf): int =
  int(gdk_pixbuf_get_rowstride(cast[ptr Pixbuf00](self.impl)))

proc rowstride*(self: Pixbuf): int =
  int(gdk_pixbuf_get_rowstride(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_get_width*(self: ptr Pixbuf00): int32 {.
    importc: "gdk_pixbuf_get_width", libprag.}

proc getWidth*(self: Pixbuf): int =
  int(gdk_pixbuf_get_width(cast[ptr Pixbuf00](self.impl)))

proc width*(self: Pixbuf): int =
  int(gdk_pixbuf_get_width(cast[ptr Pixbuf00](self.impl)))

proc gdk_pixbuf_new_subpixbuf*(self: ptr Pixbuf00; srcX: int32; srcY: int32; width: int32; 
    height: int32): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_subpixbuf", libprag.}

proc newPixbufSubpixbuf*(self: Pixbuf; srcX: int; srcY: int; width: int; height: int): Pixbuf =
  let gobj = gdk_pixbuf_new_subpixbuf(cast[ptr Pixbuf00](self.impl), int32(srcX), int32(srcY), int32(width), int32(height))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_read_pixel_bytes*(self: ptr Pixbuf00): ptr glib.Bytes00 {.
    importc: "gdk_pixbuf_read_pixel_bytes", libprag.}

proc readPixelBytes*(self: Pixbuf): glib.Bytes =
  new(result)
  result.impl = gdk_pixbuf_read_pixel_bytes(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_read_pixels*(self: ptr Pixbuf00): ptr uint8 {.
    importc: "gdk_pixbuf_read_pixels", libprag.}

proc readPixels*(self: Pixbuf): ptr uint8 =
  gdk_pixbuf_read_pixels(cast[ptr Pixbuf00](self.impl))

proc gdk_pixbuf_remove_option*(self: ptr Pixbuf00; key: cstring): gboolean {.
    importc: "gdk_pixbuf_remove_option", libprag.}

proc removeOption*(self: Pixbuf; key: string): bool =
  toBool(gdk_pixbuf_remove_option(cast[ptr Pixbuf00](self.impl), cstring(key)))

proc gdk_pixbuf_saturate_and_pixelate*(self: ptr Pixbuf00; dest: ptr Pixbuf00; saturation: cfloat; 
    pixelate: gboolean) {.
    importc: "gdk_pixbuf_saturate_and_pixelate", libprag.}

proc saturateAndPixelate*(self: Pixbuf; dest: Pixbuf; saturation: cfloat; pixelate: bool) =
  gdk_pixbuf_saturate_and_pixelate(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), saturation, gboolean(pixelate))

proc gdk_pixbuf_save_to_bufferv*(self: ptr Pixbuf00; buffer: var uint8Array; bufferSize: var uint64; 
    `type`: cstring; optionKeys: cstringArray; optionValues: cstringArray): gboolean {.
    importc: "gdk_pixbuf_save_to_bufferv", libprag.}

proc saveToBufferv*(self: Pixbuf; buffer: var uint8Array; bufferSize: var uint64; 
    `type`: string; optionKeys: cstringArray; optionValues: cstringArray): bool =
  toBool(gdk_pixbuf_save_to_bufferv(cast[ptr Pixbuf00](self.impl), buffer, bufferSize, cstring(`type`), optionKeys, optionValues))

proc gdk_pixbuf_save_to_streamv*(self: ptr Pixbuf00; stream: ptr gio.OutputStream00; 
    `type`: cstring; optionKeys: cstringArray; optionValues: cstringArray; cancellable: ptr gio.Cancellable00): gboolean {.
    importc: "gdk_pixbuf_save_to_streamv", libprag.}

proc saveToStreamv*(self: Pixbuf; stream: gio.OutputStream; `type`: string; 
    optionKeys: cstringArray; optionValues: cstringArray; cancellable: gio.Cancellable): bool =
  toBool(gdk_pixbuf_save_to_streamv(cast[ptr Pixbuf00](self.impl), cast[ptr gio.OutputStream00](stream.impl), cstring(`type`), optionKeys, optionValues, cast[ptr gio.Cancellable00](cancellable.impl)))

proc gdk_pixbuf_save_to_streamv_async*(self: ptr Pixbuf00; stream: ptr gio.OutputStream00; 
    `type`: cstring; optionKeys: cstringArray; optionValues: cstringArray; cancellable: ptr gio.Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "gdk_pixbuf_save_to_streamv_async", libprag.}

proc saveToStreamvAsync*(self: Pixbuf; stream: gio.OutputStream; `type`: string; 
    optionKeys: cstringArray; optionValues: cstringArray; cancellable: gio.Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  gdk_pixbuf_save_to_streamv_async(cast[ptr Pixbuf00](self.impl), cast[ptr gio.OutputStream00](stream.impl), cstring(`type`), optionKeys, optionValues, cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_savev*(self: ptr Pixbuf00; filename: cstring; `type`: cstring; 
    optionKeys: cstringArray; optionValues: cstringArray): gboolean {.
    importc: "gdk_pixbuf_savev", libprag.}

proc savev*(self: Pixbuf; filename: string; `type`: string; optionKeys: cstringArray; 
    optionValues: cstringArray): bool =
  toBool(gdk_pixbuf_savev(cast[ptr Pixbuf00](self.impl), cstring(filename), cstring(`type`), optionKeys, optionValues))

proc gdk_pixbuf_scale*(self: ptr Pixbuf00; dest: ptr Pixbuf00; destX: int32; 
    destY: int32; destWidth: int32; destHeight: int32; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; 
    scaleY: cdouble; interpType: InterpType) {.
    importc: "gdk_pixbuf_scale", libprag.}

proc scale*(self: Pixbuf; dest: Pixbuf; destX: int; destY: int; 
    destWidth: int; destHeight: int; offsetX: cdouble; offsetY: cdouble; scaleX: cdouble; scaleY: cdouble; 
    interpType: InterpType) =
  gdk_pixbuf_scale(cast[ptr Pixbuf00](self.impl), cast[ptr Pixbuf00](dest.impl), int32(destX), int32(destY), int32(destWidth), int32(destHeight), offsetX, offsetY, scaleX, scaleY, interpType)

proc gdk_pixbuf_scale_simple*(self: ptr Pixbuf00; destWidth: int32; destHeight: int32; 
    interpType: InterpType): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_scale_simple", libprag.}

proc scaleSimple*(self: Pixbuf; destWidth: int; destHeight: int; interpType: InterpType): Pixbuf =
  let gobj = gdk_pixbuf_scale_simple(cast[ptr Pixbuf00](self.impl), int32(destWidth), int32(destHeight), interpType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_set_option*(self: ptr Pixbuf00; key: cstring; value: cstring): gboolean {.
    importc: "gdk_pixbuf_set_option", libprag.}

proc setOption*(self: Pixbuf; key: string; value: string): bool =
  toBool(gdk_pixbuf_set_option(cast[ptr Pixbuf00](self.impl), cstring(key), cstring(value)))

type
  Pixdata00* {.pure.} = object
    magic*: uint32
    length*: int32
    pixdataType*: uint32
    rowstride*: uint32
    width*: uint32
    height*: uint32
    pixelData*: uint8Array
  Pixdata* = ref object
    impl*: ptr Pixdata00

proc gdk_pixdata_deserialize*(self: ptr Pixdata00; streamLength: uint32; stream: uint8Array): gboolean {.
    importc: "gdk_pixdata_deserialize", libprag.}

proc deserialize*(self: Pixdata; streamLength: int; stream: uint8Array): bool =
  toBool(gdk_pixdata_deserialize(cast[ptr Pixdata00](self.impl), uint32(streamLength), stream))

proc gdk_pixdata_serialize*(self: ptr Pixdata00; streamLengthP: var uint32): uint8Array {.
    importc: "gdk_pixdata_serialize", libprag.}

proc serialize*(self: Pixdata; streamLengthP: var int): uint8Array =
  var streamLengthP_00 = uint32(streamLengthP)
  result = gdk_pixdata_serialize(cast[ptr Pixdata00](self.impl), streamLengthP_00)
  streamLengthP = int(streamLengthP_00)

proc gdk_pixbuf_from_pixdata*(pixdata: ptr Pixdata00; copyPixels: gboolean): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_from_pixdata", libprag.}

proc fromPixdata*(pixdata: Pixdata; copyPixels: bool): Pixbuf =
  let gobj = gdk_pixbuf_from_pixdata(cast[ptr Pixdata00](pixdata.impl), gboolean(copyPixels))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

type
  PixdataDumpType* {.size: sizeof(cint), pure.} = enum
    gtypes = 0
    pixdataStruct = 1
    macros = 2
    ctypes = 256
    `static` = 512
    `const` = 1024
    rleDecoder = 65536

const
  PixdataDumpTypePixdataStream* = PixdataDumpType.gtypes

proc gdk_pixdata_to_csource*(self: ptr Pixdata00; name: cstring; dumpType: PixdataDumpType): ptr glib.String00 {.
    importc: "gdk_pixdata_to_csource", libprag.}

proc toCsource*(self: Pixdata; name: string; dumpType: PixdataDumpType): glib.String =
  new(result)
  result.impl = gdk_pixdata_to_csource(cast[ptr Pixdata00](self.impl), cstring(name), dumpType)

type
  PixbufFormat00* {.pure.} = object
  PixbufFormat* = ref object
    impl*: ptr PixbufFormat00

proc gdk_pixbuf_format_copy*(self: ptr PixbufFormat00): ptr PixbufFormat00 {.
    importc: "gdk_pixbuf_format_copy", libprag.}

proc copy*(self: PixbufFormat): PixbufFormat =
  new(result)
  result.impl = gdk_pixbuf_format_copy(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_free*(self: ptr PixbufFormat00) {.
    importc: "gdk_pixbuf_format_free", libprag.}

proc free*(self: PixbufFormat) =
  gdk_pixbuf_format_free(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_get_description*(self: ptr PixbufFormat00): cstring {.
    importc: "gdk_pixbuf_format_get_description", libprag.}

proc getDescription*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_description(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc description*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_description(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_get_extensions*(self: ptr PixbufFormat00): cstringArray {.
    importc: "gdk_pixbuf_format_get_extensions", libprag.}

proc getExtensions*(self: PixbufFormat): cstringArray =
  gdk_pixbuf_format_get_extensions(cast[ptr PixbufFormat00](self.impl))

proc extensions*(self: PixbufFormat): cstringArray =
  gdk_pixbuf_format_get_extensions(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_get_license*(self: ptr PixbufFormat00): cstring {.
    importc: "gdk_pixbuf_format_get_license", libprag.}

proc getLicense*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_license(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc license*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_license(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_get_mime_types*(self: ptr PixbufFormat00): cstringArray {.
    importc: "gdk_pixbuf_format_get_mime_types", libprag.}

proc getMimeTypes*(self: PixbufFormat): cstringArray =
  gdk_pixbuf_format_get_mime_types(cast[ptr PixbufFormat00](self.impl))

proc mimeTypes*(self: PixbufFormat): cstringArray =
  gdk_pixbuf_format_get_mime_types(cast[ptr PixbufFormat00](self.impl))

proc gdk_pixbuf_format_get_name*(self: ptr PixbufFormat00): cstring {.
    importc: "gdk_pixbuf_format_get_name", libprag.}

proc getName*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_name(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: PixbufFormat): string =
  let resul0 = gdk_pixbuf_format_get_name(cast[ptr PixbufFormat00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_pixbuf_format_is_disabled*(self: ptr PixbufFormat00): gboolean {.
    importc: "gdk_pixbuf_format_is_disabled", libprag.}

proc isDisabled*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_disabled(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_is_save_option_supported*(self: ptr PixbufFormat00; optionKey: cstring): gboolean {.
    importc: "gdk_pixbuf_format_is_save_option_supported", libprag.}

proc isSaveOptionSupported*(self: PixbufFormat; optionKey: string): bool =
  toBool(gdk_pixbuf_format_is_save_option_supported(cast[ptr PixbufFormat00](self.impl), cstring(optionKey)))

proc gdk_pixbuf_format_is_scalable*(self: ptr PixbufFormat00): gboolean {.
    importc: "gdk_pixbuf_format_is_scalable", libprag.}

proc isScalable*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_scalable(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_is_writable*(self: ptr PixbufFormat00): gboolean {.
    importc: "gdk_pixbuf_format_is_writable", libprag.}

proc isWritable*(self: PixbufFormat): bool =
  toBool(gdk_pixbuf_format_is_writable(cast[ptr PixbufFormat00](self.impl)))

proc gdk_pixbuf_format_set_disabled*(self: ptr PixbufFormat00; disabled: gboolean) {.
    importc: "gdk_pixbuf_format_set_disabled", libprag.}

proc setDisabled*(self: PixbufFormat; disabled: bool) =
  gdk_pixbuf_format_set_disabled(cast[ptr PixbufFormat00](self.impl), gboolean(disabled))

proc `disabled=`*(self: PixbufFormat; disabled: bool) =
  gdk_pixbuf_format_set_disabled(cast[ptr PixbufFormat00](self.impl), gboolean(disabled))

proc gdk_pixbuf_get_file_info*(filename: cstring; width: var int32; height: var int32): ptr PixbufFormat00 {.
    importc: "gdk_pixbuf_get_file_info", libprag.}

proc getFileInfo*(filename: string; width: var int; height: var int): PixbufFormat =
  var height_00 = int32(height)
  var width_00 = int32(width)
  new(result)
  result.impl = gdk_pixbuf_get_file_info(cstring(filename), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc fileInfo*(filename: string; width: var int; height: var int): PixbufFormat =
  var height_00 = int32(height)
  var width_00 = int32(width)
  new(result)
  result.impl = gdk_pixbuf_get_file_info(cstring(filename), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc gdk_pixbuf_get_file_info_finish*(asyncResult: ptr gio.AsyncResult00; width: var int32; 
    height: var int32): ptr PixbufFormat00 {.
    importc: "gdk_pixbuf_get_file_info_finish", libprag.}

proc getFileInfoFinish*(asyncResult: gio.AsyncResult; width: var int; height: var int): PixbufFormat =
  var height_00 = int32(height)
  var width_00 = int32(width)
  new(result)
  result.impl = gdk_pixbuf_get_file_info_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc fileInfoFinish*(asyncResult: gio.AsyncResult; width: var int; height: var int): PixbufFormat =
  var height_00 = int32(height)
  var width_00 = int32(width)
  new(result)
  result.impl = gdk_pixbuf_get_file_info_finish(cast[ptr gio.AsyncResult00](asyncResult.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

type
  PixbufRotation* {.size: sizeof(cint), pure.} = enum
    none = 0
    counterclockwise = 90
    upsidedown = 180
    clockwise = 270

proc gdk_pixbuf_rotate_simple*(self: ptr Pixbuf00; angle: PixbufRotation): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_rotate_simple", libprag.}

proc rotateSimple*(self: Pixbuf; angle: PixbufRotation): Pixbuf =
  let gobj = gdk_pixbuf_rotate_simple(cast[ptr Pixbuf00](self.impl), angle)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

type
  PixbufAlphaMode* {.size: sizeof(cint), pure.} = enum
    bilevel = 0
    full = 1

type
  PixbufAnimation* = ref object of gobject.Object
  PixbufAnimation00* = object of gobject.Object00

proc gdk_pixbuf_animation_new_from_file*(filename: cstring): ptr PixbufAnimation00 {.
    importc: "gdk_pixbuf_animation_new_from_file", libprag.}

proc newPixbufAnimationFromFile*(filename: string): PixbufAnimation =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_file(cstring(filename))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufAnimationFromFile*[T](result: var T; filename: string) =
  assert(result is PixbufAnimation)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_file(cstring(filename))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_new_from_resource*(resourcePath: cstring): ptr PixbufAnimation00 {.
    importc: "gdk_pixbuf_animation_new_from_resource", libprag.}

proc newPixbufAnimationFromResource*(resourcePath: string): PixbufAnimation =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_resource(cstring(resourcePath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufAnimationFromResource*[T](result: var T; resourcePath: string) =
  assert(result is PixbufAnimation)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_resource(cstring(resourcePath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_new_from_stream*(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00): ptr PixbufAnimation00 {.
    importc: "gdk_pixbuf_animation_new_from_stream", libprag.}

proc newPixbufAnimationFromStream*(stream: gio.InputStream; cancellable: gio.Cancellable): PixbufAnimation =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_stream(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufAnimationFromStream*[T](result: var T; stream: gio.InputStream; cancellable: gio.Cancellable) =
  assert(result is PixbufAnimation)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_stream(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_new_from_stream_finish*(asyncResult: ptr gio.AsyncResult00): ptr PixbufAnimation00 {.
    importc: "gdk_pixbuf_animation_new_from_stream_finish", libprag.}

proc newPixbufAnimationFromStreamFinish*(asyncResult: gio.AsyncResult): PixbufAnimation =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufAnimationFromStreamFinish*[T](result: var T; asyncResult: gio.AsyncResult) =
  assert(result is PixbufAnimation)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_animation_new_from_stream_finish(cast[ptr gio.AsyncResult00](asyncResult.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_animation_new_from_stream_async*(stream: ptr gio.InputStream00; cancellable: ptr gio.Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "gdk_pixbuf_animation_new_from_stream_async", libprag.}

proc newAnimationFromStreamAsync*(stream: gio.InputStream; cancellable: gio.Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  gdk_pixbuf_animation_new_from_stream_async(cast[ptr gio.InputStream00](stream.impl), cast[ptr gio.Cancellable00](cancellable.impl), callback, userData)

proc gdk_pixbuf_animation_get_height*(self: ptr PixbufAnimation00): int32 {.
    importc: "gdk_pixbuf_animation_get_height", libprag.}

proc getHeight*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_height(cast[ptr PixbufAnimation00](self.impl)))

proc height*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_height(cast[ptr PixbufAnimation00](self.impl)))

proc gdk_pixbuf_animation_get_static_image*(self: ptr PixbufAnimation00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_animation_get_static_image", libprag.}

proc getStaticImage*(self: PixbufAnimation): Pixbuf =
  let gobj = gdk_pixbuf_animation_get_static_image(cast[ptr PixbufAnimation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc staticImage*(self: PixbufAnimation): Pixbuf =
  let gobj = gdk_pixbuf_animation_get_static_image(cast[ptr PixbufAnimation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_animation_get_width*(self: ptr PixbufAnimation00): int32 {.
    importc: "gdk_pixbuf_animation_get_width", libprag.}

proc getWidth*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_width(cast[ptr PixbufAnimation00](self.impl)))

proc width*(self: PixbufAnimation): int =
  int(gdk_pixbuf_animation_get_width(cast[ptr PixbufAnimation00](self.impl)))

proc gdk_pixbuf_animation_is_static_image*(self: ptr PixbufAnimation00): gboolean {.
    importc: "gdk_pixbuf_animation_is_static_image", libprag.}

proc isStaticImage*(self: PixbufAnimation): bool =
  toBool(gdk_pixbuf_animation_is_static_image(cast[ptr PixbufAnimation00](self.impl)))

type
  PixbufAnimationIter* = ref object of gobject.Object
  PixbufAnimationIter00* = object of gobject.Object00

proc gdk_pixbuf_animation_iter_advance*(self: ptr PixbufAnimationIter00; currentTime: ptr glib.TimeVal00): gboolean {.
    importc: "gdk_pixbuf_animation_iter_advance", libprag.}

proc advance*(self: PixbufAnimationIter; currentTime: glib.TimeVal): bool =
  toBool(gdk_pixbuf_animation_iter_advance(cast[ptr PixbufAnimationIter00](self.impl), cast[ptr glib.TimeVal00](currentTime.impl)))

proc gdk_pixbuf_animation_iter_get_delay_time*(self: ptr PixbufAnimationIter00): int32 {.
    importc: "gdk_pixbuf_animation_iter_get_delay_time", libprag.}

proc getDelayTime*(self: PixbufAnimationIter): int =
  int(gdk_pixbuf_animation_iter_get_delay_time(cast[ptr PixbufAnimationIter00](self.impl)))

proc delayTime*(self: PixbufAnimationIter): int =
  int(gdk_pixbuf_animation_iter_get_delay_time(cast[ptr PixbufAnimationIter00](self.impl)))

proc gdk_pixbuf_animation_iter_get_pixbuf*(self: ptr PixbufAnimationIter00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_animation_iter_get_pixbuf", libprag.}

proc getPixbuf*(self: PixbufAnimationIter): Pixbuf =
  let gobj = gdk_pixbuf_animation_iter_get_pixbuf(cast[ptr PixbufAnimationIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc pixbuf*(self: PixbufAnimationIter): Pixbuf =
  let gobj = gdk_pixbuf_animation_iter_get_pixbuf(cast[ptr PixbufAnimationIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_animation_iter_on_currently_loading_frame*(self: ptr PixbufAnimationIter00): gboolean {.
    importc: "gdk_pixbuf_animation_iter_on_currently_loading_frame", libprag.}

proc onCurrentlyLoadingFrame*(self: PixbufAnimationIter): bool =
  toBool(gdk_pixbuf_animation_iter_on_currently_loading_frame(cast[ptr PixbufAnimationIter00](self.impl)))

proc gdk_pixbuf_animation_get_iter*(self: ptr PixbufAnimation00; startTime: ptr glib.TimeVal00): ptr PixbufAnimationIter00 {.
    importc: "gdk_pixbuf_animation_get_iter", libprag.}

proc getIter*(self: PixbufAnimation; startTime: glib.TimeVal): PixbufAnimationIter =
  let gobj = gdk_pixbuf_animation_get_iter(cast[ptr PixbufAnimation00](self.impl), cast[ptr glib.TimeVal00](startTime.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[PixbufAnimationIter](g_object_get_qdata(gobj, Quark))
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

proc iter*(self: PixbufAnimation; startTime: glib.TimeVal): PixbufAnimationIter =
  let gobj = gdk_pixbuf_animation_get_iter(cast[ptr PixbufAnimation00](self.impl), cast[ptr glib.TimeVal00](startTime.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[PixbufAnimationIter](g_object_get_qdata(gobj, Quark))
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

type
  PixbufDestroyNotify* = proc (pixels: uint8Array; data: pointer) {.cdecl.}

proc gdk_pixbuf_new_from_data*(data: uint8Array; colorspace: Colorspace; hasAlpha: gboolean; 
    bitsPerSample: int32; width: int32; height: int32; rowstride: int32; destroyFn: PixbufDestroyNotify; 
    destroyFnData: pointer): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_new_from_data", libprag.}

proc newPixbufFromData*(data: uint8Array; colorspace: Colorspace; hasAlpha: bool; 
    bitsPerSample: int; width: int; height: int; rowstride: int; destroyFn: PixbufDestroyNotify; 
    destroyFnData: pointer): Pixbuf =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_data(data, colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride), destroyFn, destroyFnData)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufFromData*[T](result: var T; data: uint8Array; colorspace: Colorspace; hasAlpha: bool; 
    bitsPerSample: int; width: int; height: int; rowstride: int; destroyFn: PixbufDestroyNotify; 
    destroyFnData: pointer) =
  assert(result is Pixbuf)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_new_from_data(data, colorspace, gboolean(hasAlpha), int32(bitsPerSample), int32(width), int32(height), int32(rowstride), destroyFn, destroyFnData)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  PixbufError* {.size: sizeof(cint), pure.} = enum
    corruptImage = 0
    insufficientMemory = 1
    badOption = 2
    unknownType = 3
    unsupportedOperation = 4
    failed = 5
    incompleteAnimation = 6

proc gdk_pixbuf_error_quark*(): uint32 {.
    importc: "gdk_pixbuf_error_quark", libprag.}

type
  PixbufLoader* = ref object of gobject.Object
  PixbufLoader00* = object of gobject.Object00
    priv1: pointer

proc scAreaPrepared*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "area-prepared", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scAreaUpdated*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; x: int32; y: int32; width: int32; height: int32; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "area-updated", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scClosed*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scSizePrepared*(self: PixbufLoader;  p: proc (self: ptr gobject.Object00; width: int32; height: int32; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "size-prepared", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_pixbuf_loader_new*(): ptr PixbufLoader00 {.
    importc: "gdk_pixbuf_loader_new", libprag.}

proc newPixbufLoader*(): PixbufLoader =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufLoader*[T](result: var T) =
  assert(result is PixbufLoader)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_loader_new_with_mime_type*(mimeType: cstring): ptr PixbufLoader00 {.
    importc: "gdk_pixbuf_loader_new_with_mime_type", libprag.}

proc newPixbufLoaderWithMimeType*(mimeType: string): PixbufLoader =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new_with_mime_type(cstring(mimeType))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufLoaderWithMimeType*[T](result: var T; mimeType: string) =
  assert(result is PixbufLoader)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new_with_mime_type(cstring(mimeType))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_loader_new_with_type*(imageType: cstring): ptr PixbufLoader00 {.
    importc: "gdk_pixbuf_loader_new_with_type", libprag.}

proc newPixbufLoaderWithType*(imageType: string): PixbufLoader =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new_with_type(cstring(imageType))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufLoaderWithType*[T](result: var T; imageType: string) =
  assert(result is PixbufLoader)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_loader_new_with_type(cstring(imageType))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_loader_close*(self: ptr PixbufLoader00): gboolean {.
    importc: "gdk_pixbuf_loader_close", libprag.}

proc close*(self: PixbufLoader): bool =
  toBool(gdk_pixbuf_loader_close(cast[ptr PixbufLoader00](self.impl)))

proc gdk_pixbuf_loader_get_animation*(self: ptr PixbufLoader00): ptr PixbufAnimation00 {.
    importc: "gdk_pixbuf_loader_get_animation", libprag.}

proc getAnimation*(self: PixbufLoader): PixbufAnimation =
  let gobj = gdk_pixbuf_loader_get_animation(cast[ptr PixbufLoader00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[PixbufAnimation](g_object_get_qdata(gobj, Quark))
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

proc animation*(self: PixbufLoader): PixbufAnimation =
  let gobj = gdk_pixbuf_loader_get_animation(cast[ptr PixbufLoader00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[PixbufAnimation](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_loader_get_format*(self: ptr PixbufLoader00): ptr PixbufFormat00 {.
    importc: "gdk_pixbuf_loader_get_format", libprag.}

proc getFormat*(self: PixbufLoader): PixbufFormat =
  new(result)
  result.impl = gdk_pixbuf_loader_get_format(cast[ptr PixbufLoader00](self.impl))

proc format*(self: PixbufLoader): PixbufFormat =
  new(result)
  result.impl = gdk_pixbuf_loader_get_format(cast[ptr PixbufLoader00](self.impl))

proc gdk_pixbuf_loader_get_pixbuf*(self: ptr PixbufLoader00): ptr Pixbuf00 {.
    importc: "gdk_pixbuf_loader_get_pixbuf", libprag.}

proc getPixbuf*(self: PixbufLoader): Pixbuf =
  let gobj = gdk_pixbuf_loader_get_pixbuf(cast[ptr PixbufLoader00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc pixbuf*(self: PixbufLoader): Pixbuf =
  let gobj = gdk_pixbuf_loader_get_pixbuf(cast[ptr PixbufLoader00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Pixbuf](g_object_get_qdata(gobj, Quark))
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

proc gdk_pixbuf_loader_set_size*(self: ptr PixbufLoader00; width: int32; height: int32) {.
    importc: "gdk_pixbuf_loader_set_size", libprag.}

proc setSize*(self: PixbufLoader; width: int; height: int) =
  gdk_pixbuf_loader_set_size(cast[ptr PixbufLoader00](self.impl), int32(width), int32(height))

proc gdk_pixbuf_loader_write*(self: ptr PixbufLoader00; buf: uint8Array; count: uint64): gboolean {.
    importc: "gdk_pixbuf_loader_write", libprag.}

proc write*(self: PixbufLoader; buf: uint8Array; count: uint64): bool =
  toBool(gdk_pixbuf_loader_write(cast[ptr PixbufLoader00](self.impl), buf, count))

proc gdk_pixbuf_loader_write_bytes*(self: ptr PixbufLoader00; buffer: ptr glib.Bytes00): gboolean {.
    importc: "gdk_pixbuf_loader_write_bytes", libprag.}

proc writeBytes*(self: PixbufLoader; buffer: glib.Bytes): bool =
  toBool(gdk_pixbuf_loader_write_bytes(cast[ptr PixbufLoader00](self.impl), cast[ptr glib.Bytes00](buffer.impl)))

type
  PixbufLoaderClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    sizePrepared*: proc(loader: ptr PixbufLoader00; width: int32; height: int32) {.cdecl.}
    areaPrepared*: proc(loader: ptr PixbufLoader00) {.cdecl.}
    areaUpdated*: proc(loader: ptr PixbufLoader00; x: int32; y: int32; width: int32; 
    height: int32) {.cdecl.}
    closed*: proc(loader: ptr PixbufLoader00) {.cdecl.}
  PixbufLoaderClass* = ref object
    impl*: ptr PixbufLoaderClass00

type
  PixbufSaveFunc* = proc (buf: uint8Array; count: uint64; error: var ptr Error00; 
    data: pointer): gboolean {.cdecl.}

proc gdk_pixbuf_save_to_callbackv*(self: ptr Pixbuf00; saveFunc: PixbufSaveFunc; userData: pointer; 
    `type`: cstring; optionKeys: cstringArray; optionValues: cstringArray): gboolean {.
    importc: "gdk_pixbuf_save_to_callbackv", libprag.}

proc saveToCallbackv*(self: Pixbuf; saveFunc: PixbufSaveFunc; userData: pointer; 
    `type`: string; optionKeys: cstringArray; optionValues: cstringArray): bool =
  toBool(gdk_pixbuf_save_to_callbackv(cast[ptr Pixbuf00](self.impl), saveFunc, userData, cstring(`type`), optionKeys, optionValues))

type
  PixbufSimpleAnim* = ref object of PixbufAnimation
  PixbufSimpleAnim00* = object of PixbufAnimation00

proc gdk_pixbuf_simple_anim_new*(width: int32; height: int32; rate: cfloat): ptr PixbufSimpleAnim00 {.
    importc: "gdk_pixbuf_simple_anim_new", libprag.}

proc newPixbufSimpleAnim*(width: int; height: int; rate: cfloat): PixbufSimpleAnim =
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_simple_anim_new(int32(width), int32(height), rate)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPixbufSimpleAnim*[T](result: var T; width: int; height: int; rate: cfloat) =
  assert(result is PixbufSimpleAnim)
  new(result, finalizeGObject)
  result.impl = gdk_pixbuf_simple_anim_new(int32(width), int32(height), rate)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_pixbuf_simple_anim_add_frame*(self: ptr PixbufSimpleAnim00; pixbuf: ptr Pixbuf00) {.
    importc: "gdk_pixbuf_simple_anim_add_frame", libprag.}

proc addFrame*(self: PixbufSimpleAnim; pixbuf: Pixbuf) =
  gdk_pixbuf_simple_anim_add_frame(cast[ptr PixbufSimpleAnim00](self.impl), cast[ptr Pixbuf00](pixbuf.impl))

proc gdk_pixbuf_simple_anim_get_loop*(self: ptr PixbufSimpleAnim00): gboolean {.
    importc: "gdk_pixbuf_simple_anim_get_loop", libprag.}

proc getLoop*(self: PixbufSimpleAnim): bool =
  toBool(gdk_pixbuf_simple_anim_get_loop(cast[ptr PixbufSimpleAnim00](self.impl)))

proc loop*(self: PixbufSimpleAnim): bool =
  toBool(gdk_pixbuf_simple_anim_get_loop(cast[ptr PixbufSimpleAnim00](self.impl)))

proc gdk_pixbuf_simple_anim_set_loop*(self: ptr PixbufSimpleAnim00; loop: gboolean) {.
    importc: "gdk_pixbuf_simple_anim_set_loop", libprag.}

proc setLoop*(self: PixbufSimpleAnim; loop: bool) =
  gdk_pixbuf_simple_anim_set_loop(cast[ptr PixbufSimpleAnim00](self.impl), gboolean(loop))

proc `loop=`*(self: PixbufSimpleAnim; loop: bool) =
  gdk_pixbuf_simple_anim_set_loop(cast[ptr PixbufSimpleAnim00](self.impl), gboolean(loop))

type
  PixbufSimpleAnimClass00* {.pure.} = object
  PixbufSimpleAnimClass* = ref object
    impl*: ptr PixbufSimpleAnimClass00

type
  PixbufSimpleAnimIter* = ref object of PixbufAnimationIter
  PixbufSimpleAnimIter00* = object of PixbufAnimationIter00

type
  PixdataType* {.size: sizeof(cint), pure.} = enum
    colorTypeRgb = 1
    colorTypeRgba = 2
    colorTypeMask = 255
    sampleWidth_8 = 65536
    sampleWidthMask = 983040
    encodingRaw = 16777216
    encodingRle = 33554432
    encodingMask = 251658240
# === remaining symbols:

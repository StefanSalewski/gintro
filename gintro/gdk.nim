# dependencies:
# cairo-1.0
# Pango-1.0
# GObject-2.0
# Gio-2.0
# GLib-2.0
# GdkPixbuf-2.0
# GModule-2.0
# immediate dependencies:
# cairo-1.0
# Pango-1.0
# Gio-2.0
# GdkPixbuf-2.0
# libraries:
# libgdk-3.so.0
{.deadCodeElim: on.}
import cairo, pango, gobject, gio, glib, gdkpixbuf, gmodule
const Lib* = "libgdk-3.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  Atom00Array* = pointer
type
  KeymapKey00Array* = pointer
type
  VisualTypeArray* = pointer
type
  RGBA00Array* = pointer
type
  Color00Array* = pointer
type
  Point00Array* = pointer
let Quark = g_quark_from_static_string("NimGIQuark")

type
  AnchorHints* {.size: sizeof(cint), pure.} = enum
    flipX = 1
    flipY = 2
    flip = 3
    slideX = 4
    slideY = 8
    slide = 12
    resizeX = 16
    resizeY = 32
    resize = 48

type
  AppLaunchContext* = ref object of gio.AppLaunchContext
  AppLaunchContext00* = object of gio.AppLaunchContext00

proc gdk_app_launch_context_new*(): ptr AppLaunchContext00 {.
    importc: "gdk_app_launch_context_new", libprag.}

proc newAppLaunchContext*(): AppLaunchContext =
  new(result, finalizeGObject)
  result.impl = gdk_app_launch_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAppLaunchContext*[T](result: var T) =
  assert(result is AppLaunchContext)
  new(result, finalizeGObject)
  result.impl = gdk_app_launch_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_app_launch_context_set_desktop*(self: ptr AppLaunchContext00; desktop: int32) {.
    importc: "gdk_app_launch_context_set_desktop", libprag.}

proc setDesktop*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc `desktop=`*(self: AppLaunchContext; desktop: int) =
  gdk_app_launch_context_set_desktop(cast[ptr AppLaunchContext00](self.impl), int32(desktop))

proc gdk_app_launch_context_set_icon*(self: ptr AppLaunchContext00; icon: ptr gio.Icon00) {.
    importc: "gdk_app_launch_context_set_icon", libprag.}

proc setIcon*(self: AppLaunchContext; icon: gio.Icon) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), cast[ptr gio.Icon00](icon.impl))

proc `icon=`*(self: AppLaunchContext; icon: gio.Icon) =
  gdk_app_launch_context_set_icon(cast[ptr AppLaunchContext00](self.impl), cast[ptr gio.Icon00](icon.impl))

proc gdk_app_launch_context_set_icon_name*(self: ptr AppLaunchContext00; iconName: cstring) {.
    importc: "gdk_app_launch_context_set_icon_name", libprag.}

proc setIconName*(self: AppLaunchContext; iconName: string) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), cstring(iconName))

proc `iconName=`*(self: AppLaunchContext; iconName: string) =
  gdk_app_launch_context_set_icon_name(cast[ptr AppLaunchContext00](self.impl), cstring(iconName))

proc gdk_app_launch_context_set_timestamp*(self: ptr AppLaunchContext00; timestamp: uint32) {.
    importc: "gdk_app_launch_context_set_timestamp", libprag.}

proc setTimestamp*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

proc `timestamp=`*(self: AppLaunchContext; timestamp: int) =
  gdk_app_launch_context_set_timestamp(cast[ptr AppLaunchContext00](self.impl), uint32(timestamp))

type
  Monitor* = ref object of gobject.Object
  Monitor00* = object of gobject.Object00

proc scInvalidate*(self: Monitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "invalidate", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_monitor_get_height_mm*(self: ptr Monitor00): int32 {.
    importc: "gdk_monitor_get_height_mm", libprag.}

proc getHeightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc heightMm*(self: Monitor): int =
  int(gdk_monitor_get_height_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_manufacturer*(self: ptr Monitor00): cstring {.
    importc: "gdk_monitor_get_manufacturer", libprag.}

proc getManufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  result = $resul0

proc manufacturer*(self: Monitor): string =
  let resul0 = gdk_monitor_get_manufacturer(cast[ptr Monitor00](self.impl))
  result = $resul0

proc gdk_monitor_get_model*(self: ptr Monitor00): cstring {.
    importc: "gdk_monitor_get_model", libprag.}

proc getModel*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  result = $resul0

proc model*(self: Monitor): string =
  let resul0 = gdk_monitor_get_model(cast[ptr Monitor00](self.impl))
  result = $resul0

proc gdk_monitor_get_refresh_rate*(self: ptr Monitor00): int32 {.
    importc: "gdk_monitor_get_refresh_rate", libprag.}

proc getRefreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc refreshRate*(self: Monitor): int =
  int(gdk_monitor_get_refresh_rate(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_scale_factor*(self: ptr Monitor00): int32 {.
    importc: "gdk_monitor_get_scale_factor", libprag.}

proc getScaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc scaleFactor*(self: Monitor): int =
  int(gdk_monitor_get_scale_factor(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_get_width_mm*(self: ptr Monitor00): int32 {.
    importc: "gdk_monitor_get_width_mm", libprag.}

proc getWidthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc widthMm*(self: Monitor): int =
  int(gdk_monitor_get_width_mm(cast[ptr Monitor00](self.impl)))

proc gdk_monitor_is_primary*(self: ptr Monitor00): gboolean {.
    importc: "gdk_monitor_is_primary", libprag.}

proc isPrimary*(self: Monitor): bool =
  toBool(gdk_monitor_is_primary(cast[ptr Monitor00](self.impl)))

type
  DeviceTool* = ref object of gobject.Object
  DeviceTool00* = object of gobject.Object00

proc gdk_device_tool_get_hardware_id*(self: ptr DeviceTool00): uint64 {.
    importc: "gdk_device_tool_get_hardware_id", libprag.}

proc getHardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc hardwareId*(self: DeviceTool): uint64 =
  gdk_device_tool_get_hardware_id(cast[ptr DeviceTool00](self.impl))

proc gdk_device_tool_get_serial*(self: ptr DeviceTool00): uint64 {.
    importc: "gdk_device_tool_get_serial", libprag.}

proc getSerial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

proc serial*(self: DeviceTool): uint64 =
  gdk_device_tool_get_serial(cast[ptr DeviceTool00](self.impl))

type
  Device* = ref object of gobject.Object
  Device00* = object of gobject.Object00

proc scChanged*(self: Device;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scToolChanged*(self: Device;  p: proc (self: ptr gobject.Object00; tool: DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "tool-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_device_get_associated_device*(self: ptr Device00): ptr Device00 {.
    importc: "gdk_device_get_associated_device", libprag.}

proc getAssociatedDevice*(self: Device): Device =
  let gobj = gdk_device_get_associated_device(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc associatedDevice*(self: Device): Device =
  let gobj = gdk_device_get_associated_device(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_get_has_cursor*(self: ptr Device00): gboolean {.
    importc: "gdk_device_get_has_cursor", libprag.}

proc getHasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc hasCursor*(self: Device): bool =
  toBool(gdk_device_get_has_cursor(cast[ptr Device00](self.impl)))

proc gdk_device_get_n_axes*(self: ptr Device00): int32 {.
    importc: "gdk_device_get_n_axes", libprag.}

proc getNAxes*(self: Device): int =
  int(gdk_device_get_n_axes(cast[ptr Device00](self.impl)))

proc nAxes*(self: Device): int =
  int(gdk_device_get_n_axes(cast[ptr Device00](self.impl)))

proc gdk_device_get_n_keys*(self: ptr Device00): int32 {.
    importc: "gdk_device_get_n_keys", libprag.}

proc getNKeys*(self: Device): int =
  int(gdk_device_get_n_keys(cast[ptr Device00](self.impl)))

proc nKeys*(self: Device): int =
  int(gdk_device_get_n_keys(cast[ptr Device00](self.impl)))

proc gdk_device_get_name*(self: ptr Device00): cstring {.
    importc: "gdk_device_get_name", libprag.}

proc getName*(self: Device): string =
  let resul0 = gdk_device_get_name(cast[ptr Device00](self.impl))
  result = $resul0

proc name*(self: Device): string =
  let resul0 = gdk_device_get_name(cast[ptr Device00](self.impl))
  result = $resul0

proc gdk_device_get_product_id*(self: ptr Device00): cstring {.
    importc: "gdk_device_get_product_id", libprag.}

proc getProductId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  result = $resul0

proc productId*(self: Device): string =
  let resul0 = gdk_device_get_product_id(cast[ptr Device00](self.impl))
  result = $resul0

proc gdk_device_get_vendor_id*(self: ptr Device00): cstring {.
    importc: "gdk_device_get_vendor_id", libprag.}

proc getVendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  result = $resul0

proc vendorId*(self: Device): string =
  let resul0 = gdk_device_get_vendor_id(cast[ptr Device00](self.impl))
  result = $resul0

proc gdk_device_list_axes*(self: ptr Device00): ptr pointer {.
    importc: "gdk_device_list_axes", libprag.}

proc listAxes*(self: Device): ptr pointer =
  gdk_device_list_axes(cast[ptr Device00](self.impl))

proc gdk_device_list_slave_devices*(self: ptr Device00): ptr pointer {.
    importc: "gdk_device_list_slave_devices", libprag.}

proc listSlaveDevices*(self: Device): ptr pointer =
  gdk_device_list_slave_devices(cast[ptr Device00](self.impl))

proc gdk_device_ungrab*(self: ptr Device00; time: uint32) {.
    importc: "gdk_device_ungrab", libprag.}

proc ungrab*(self: Device; time: int) =
  gdk_device_ungrab(cast[ptr Device00](self.impl), uint32(time))

type
  Seat* = ref object of gobject.Object
  Seat00* = object of gobject.Object00

proc scDeviceAdded*(self: Seat;  p: proc (self: ptr gobject.Object00; device: Device00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "device-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDeviceRemoved*(self: Seat;  p: proc (self: ptr gobject.Object00; device: Device00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "device-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scToolAdded*(self: Seat;  p: proc (self: ptr gobject.Object00; tool: DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "tool-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scToolRemoved*(self: Seat;  p: proc (self: ptr gobject.Object00; tool: DeviceTool00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "tool-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_seat_get_keyboard*(self: ptr Seat00): ptr Device00 {.
    importc: "gdk_seat_get_keyboard", libprag.}

proc getKeyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc keyboard*(self: Seat): Device =
  let gobj = gdk_seat_get_keyboard(cast[ptr Seat00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_seat_get_pointer*(self: ptr Seat00): ptr Device00 {.
    importc: "gdk_seat_get_pointer", libprag.}

proc getPointer*(self: Seat): Device =
  let gobj = gdk_seat_get_pointer(cast[ptr Seat00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_seat_ungrab*(self: ptr Seat00) {.
    importc: "gdk_seat_ungrab", libprag.}

proc ungrab*(self: Seat) =
  gdk_seat_ungrab(cast[ptr Seat00](self.impl))

type
  Display* = ref object of gobject.Object
  Display00* = object of gobject.Object00

proc scClosed*(self: Display;  p: proc (self: ptr gobject.Object00; isError: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMonitorAdded*(self: Display;  p: proc (self: ptr gobject.Object00; monitor: Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "monitor-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMonitorRemoved*(self: Display;  p: proc (self: ptr gobject.Object00; monitor: Monitor00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "monitor-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scOpened*(self: Display;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "opened", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scSeatAdded*(self: Display;  p: proc (self: ptr gobject.Object00; seat: Seat00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "seat-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scSeatRemoved*(self: Display;  p: proc (self: ptr gobject.Object00; seat: Seat00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "seat-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_display_get_default*(): ptr Display00 {.
    importc: "gdk_display_get_default", libprag.}

proc getDefault*(): Display =
  let gobj = gdk_display_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc default*(): Display =
  let gobj = gdk_display_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_open*(displayName: cstring): ptr Display00 {.
    importc: "gdk_display_open", libprag.}

proc open*(displayName: string): Display =
  let gobj = gdk_display_open(cstring(displayName))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_open_default_libgtk_only*(): ptr Display00 {.
    importc: "gdk_display_open_default_libgtk_only", libprag.}

proc openDefaultLibgtkOnly*(): Display =
  let gobj = gdk_display_open_default_libgtk_only()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_beep*(self: ptr Display00) {.
    importc: "gdk_display_beep", libprag.}

proc beep*(self: Display) =
  gdk_display_beep(cast[ptr Display00](self.impl))

proc gdk_display_close*(self: ptr Display00) {.
    importc: "gdk_display_close", libprag.}

proc close*(self: Display) =
  gdk_display_close(cast[ptr Display00](self.impl))

proc gdk_display_device_is_grabbed*(self: ptr Display00; device: ptr Device00): gboolean {.
    importc: "gdk_display_device_is_grabbed", libprag.}

proc deviceIsGrabbed*(self: Display; device: Device): bool =
  toBool(gdk_display_device_is_grabbed(cast[ptr Display00](self.impl), cast[ptr Device00](device.impl)))

proc gdk_display_flush*(self: ptr Display00) {.
    importc: "gdk_display_flush", libprag.}

proc flush*(self: Display) =
  gdk_display_flush(cast[ptr Display00](self.impl))

proc gdk_display_get_app_launch_context*(self: ptr Display00): ptr AppLaunchContext00 {.
    importc: "gdk_display_get_app_launch_context", libprag.}

proc getAppLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[AppLaunchContext](g_object_get_qdata(gobj, Quark))
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

proc appLaunchContext*(self: Display): AppLaunchContext =
  let gobj = gdk_display_get_app_launch_context(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[AppLaunchContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_default_cursor_size*(self: ptr Display00): uint32 {.
    importc: "gdk_display_get_default_cursor_size", libprag.}

proc getDefaultCursorSize*(self: Display): int =
  int(gdk_display_get_default_cursor_size(cast[ptr Display00](self.impl)))

proc defaultCursorSize*(self: Display): int =
  int(gdk_display_get_default_cursor_size(cast[ptr Display00](self.impl)))

proc gdk_display_get_default_seat*(self: ptr Display00): ptr Seat00 {.
    importc: "gdk_display_get_default_seat", libprag.}

proc getDefaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc defaultSeat*(self: Display): Seat =
  let gobj = gdk_display_get_default_seat(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_maximal_cursor_size*(self: ptr Display00; width: var uint32; height: var uint32) {.
    importc: "gdk_display_get_maximal_cursor_size", libprag.}

proc getMaximalCursorSize*(self: Display; width: var int; height: var int) =
  var height_00 = uint32(height)
  var width_00 = uint32(width)
  gdk_display_get_maximal_cursor_size(cast[ptr Display00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc maximalCursorSize*(self: Display; width: var int; height: var int) =
  var height_00 = uint32(height)
  var width_00 = uint32(width)
  gdk_display_get_maximal_cursor_size(cast[ptr Display00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc gdk_display_get_monitor*(self: ptr Display00; monitorNum: int32): ptr Monitor00 {.
    importc: "gdk_display_get_monitor", libprag.}

proc getMonitor*(self: Display; monitorNum: int): Monitor =
  let gobj = gdk_display_get_monitor(cast[ptr Display00](self.impl), int32(monitorNum))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc monitor*(self: Display; monitorNum: int): Monitor =
  let gobj = gdk_display_get_monitor(cast[ptr Display00](self.impl), int32(monitorNum))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_monitor_at_point*(self: ptr Display00; x: int32; y: int32): ptr Monitor00 {.
    importc: "gdk_display_get_monitor_at_point", libprag.}

proc getMonitorAtPoint*(self: Display; x: int; y: int): Monitor =
  let gobj = gdk_display_get_monitor_at_point(cast[ptr Display00](self.impl), int32(x), int32(y))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc monitorAtPoint*(self: Display; x: int; y: int): Monitor =
  let gobj = gdk_display_get_monitor_at_point(cast[ptr Display00](self.impl), int32(x), int32(y))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_n_monitors*(self: ptr Display00): int32 {.
    importc: "gdk_display_get_n_monitors", libprag.}

proc getNMonitors*(self: Display): int =
  int(gdk_display_get_n_monitors(cast[ptr Display00](self.impl)))

proc nMonitors*(self: Display): int =
  int(gdk_display_get_n_monitors(cast[ptr Display00](self.impl)))

proc gdk_display_get_n_screens*(self: ptr Display00): int32 {.
    importc: "gdk_display_get_n_screens", libprag.}

proc getNScreens*(self: Display): int =
  int(gdk_display_get_n_screens(cast[ptr Display00](self.impl)))

proc nScreens*(self: Display): int =
  int(gdk_display_get_n_screens(cast[ptr Display00](self.impl)))

proc gdk_display_get_name*(self: ptr Display00): cstring {.
    importc: "gdk_display_get_name", libprag.}

proc getName*(self: Display): string =
  let resul0 = gdk_display_get_name(cast[ptr Display00](self.impl))
  result = $resul0

proc name*(self: Display): string =
  let resul0 = gdk_display_get_name(cast[ptr Display00](self.impl))
  result = $resul0

proc gdk_display_get_primary_monitor*(self: ptr Display00): ptr Monitor00 {.
    importc: "gdk_display_get_primary_monitor", libprag.}

proc getPrimaryMonitor*(self: Display): Monitor =
  let gobj = gdk_display_get_primary_monitor(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc primaryMonitor*(self: Display): Monitor =
  let gobj = gdk_display_get_primary_monitor(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_has_pending*(self: ptr Display00): gboolean {.
    importc: "gdk_display_has_pending", libprag.}

proc hasPending*(self: Display): bool =
  toBool(gdk_display_has_pending(cast[ptr Display00](self.impl)))

proc gdk_display_is_closed*(self: ptr Display00): gboolean {.
    importc: "gdk_display_is_closed", libprag.}

proc isClosed*(self: Display): bool =
  toBool(gdk_display_is_closed(cast[ptr Display00](self.impl)))

proc gdk_display_keyboard_ungrab*(self: ptr Display00; time: uint32) {.
    importc: "gdk_display_keyboard_ungrab", libprag.}

proc keyboardUngrab*(self: Display; time: int) =
  gdk_display_keyboard_ungrab(cast[ptr Display00](self.impl), uint32(time))

proc gdk_display_list_devices*(self: ptr Display00): ptr pointer {.
    importc: "gdk_display_list_devices", libprag.}

proc listDevices*(self: Display): ptr pointer =
  gdk_display_list_devices(cast[ptr Display00](self.impl))

proc gdk_display_list_seats*(self: ptr Display00): ptr pointer {.
    importc: "gdk_display_list_seats", libprag.}

proc listSeats*(self: Display): ptr pointer =
  gdk_display_list_seats(cast[ptr Display00](self.impl))

proc gdk_display_notify_startup_complete*(self: ptr Display00; startupId: cstring) {.
    importc: "gdk_display_notify_startup_complete", libprag.}

proc notifyStartupComplete*(self: Display; startupId: string) =
  gdk_display_notify_startup_complete(cast[ptr Display00](self.impl), cstring(startupId))

proc gdk_display_pointer_is_grabbed*(self: ptr Display00): gboolean {.
    importc: "gdk_display_pointer_is_grabbed", libprag.}

proc pointerIsGrabbed*(self: Display): bool =
  toBool(gdk_display_pointer_is_grabbed(cast[ptr Display00](self.impl)))

proc gdk_display_pointer_ungrab*(self: ptr Display00; time: uint32) {.
    importc: "gdk_display_pointer_ungrab", libprag.}

proc pointerUngrab*(self: Display; time: int) =
  gdk_display_pointer_ungrab(cast[ptr Display00](self.impl), uint32(time))

proc gdk_display_set_double_click_distance*(self: ptr Display00; distance: uint32) {.
    importc: "gdk_display_set_double_click_distance", libprag.}

proc setDoubleClickDistance*(self: Display; distance: int) =
  gdk_display_set_double_click_distance(cast[ptr Display00](self.impl), uint32(distance))

proc `doubleClickDistance=`*(self: Display; distance: int) =
  gdk_display_set_double_click_distance(cast[ptr Display00](self.impl), uint32(distance))

proc gdk_display_set_double_click_time*(self: ptr Display00; msec: uint32) {.
    importc: "gdk_display_set_double_click_time", libprag.}

proc setDoubleClickTime*(self: Display; msec: int) =
  gdk_display_set_double_click_time(cast[ptr Display00](self.impl), uint32(msec))

proc `doubleClickTime=`*(self: Display; msec: int) =
  gdk_display_set_double_click_time(cast[ptr Display00](self.impl), uint32(msec))

proc gdk_display_supports_clipboard_persistence*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_clipboard_persistence", libprag.}

proc supportsClipboardPersistence*(self: Display): bool =
  toBool(gdk_display_supports_clipboard_persistence(cast[ptr Display00](self.impl)))

proc gdk_display_supports_composite*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_composite", libprag.}

proc supportsComposite*(self: Display): bool =
  toBool(gdk_display_supports_composite(cast[ptr Display00](self.impl)))

proc gdk_display_supports_cursor_alpha*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_cursor_alpha", libprag.}

proc supportsCursorAlpha*(self: Display): bool =
  toBool(gdk_display_supports_cursor_alpha(cast[ptr Display00](self.impl)))

proc gdk_display_supports_cursor_color*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_cursor_color", libprag.}

proc supportsCursorColor*(self: Display): bool =
  toBool(gdk_display_supports_cursor_color(cast[ptr Display00](self.impl)))

proc gdk_display_supports_input_shapes*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_input_shapes", libprag.}

proc supportsInputShapes*(self: Display): bool =
  toBool(gdk_display_supports_input_shapes(cast[ptr Display00](self.impl)))

proc gdk_display_supports_selection_notification*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_selection_notification", libprag.}

proc supportsSelectionNotification*(self: Display): bool =
  toBool(gdk_display_supports_selection_notification(cast[ptr Display00](self.impl)))

proc gdk_display_supports_shapes*(self: ptr Display00): gboolean {.
    importc: "gdk_display_supports_shapes", libprag.}

proc supportsShapes*(self: Display): bool =
  toBool(gdk_display_supports_shapes(cast[ptr Display00](self.impl)))

proc gdk_display_sync*(self: ptr Display00) {.
    importc: "gdk_display_sync", libprag.}

proc sync*(self: Display) =
  gdk_display_sync(cast[ptr Display00](self.impl))

proc gdk_app_launch_context_set_display*(self: ptr AppLaunchContext00; display: ptr Display00) {.
    importc: "gdk_app_launch_context_set_display", libprag.}

proc setDisplay*(self: AppLaunchContext; display: Display) =
  gdk_app_launch_context_set_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr Display00](display.impl))

proc `display=`*(self: AppLaunchContext; display: Display) =
  gdk_app_launch_context_set_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr Display00](display.impl))

proc gdk_monitor_get_display*(self: ptr Monitor00): ptr Display00 {.
    importc: "gdk_monitor_get_display", libprag.}

proc getDisplay*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Monitor): Display =
  let gobj = gdk_monitor_get_display(cast[ptr Monitor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_get_display*(self: ptr Device00): ptr Display00 {.
    importc: "gdk_device_get_display", libprag.}

proc getDisplay*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Device): Display =
  let gobj = gdk_device_get_display(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_get_seat*(self: ptr Device00): ptr Seat00 {.
    importc: "gdk_device_get_seat", libprag.}

proc getSeat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc seat*(self: Device): Seat =
  let gobj = gdk_device_get_seat(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc gdk_seat_get_display*(self: ptr Seat00): ptr Display00 {.
    importc: "gdk_seat_get_display", libprag.}

proc getDisplay*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Seat): Display =
  let gobj = gdk_seat_get_display(cast[ptr Seat00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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
  DeviceToolType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    pen = 1
    eraser = 2
    brush = 3
    pencil = 4
    airbrush = 5
    mouse = 6
    lens = 7

proc gdk_device_tool_get_tool_type*(self: ptr DeviceTool00): DeviceToolType {.
    importc: "gdk_device_tool_get_tool_type", libprag.}

proc getToolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

proc toolType*(self: DeviceTool): DeviceToolType =
  gdk_device_tool_get_tool_type(cast[ptr DeviceTool00](self.impl))

type
  AxisFlag* {.size: sizeof(cint), pure.} = enum
    x = 2
    y = 3
    pressure = 4
    xtilt = 5
    ytilt = 6
    wheel = 7
    distance = 8
    rotation = 9
    slider = 10

  AxisFlags* {.size: sizeof(cint).} = set[AxisFlag]

proc gdk_device_get_axes*(self: ptr Device00): AxisFlags {.
    importc: "gdk_device_get_axes", libprag.}

proc getAxes*(self: Device): AxisFlags =
  gdk_device_get_axes(cast[ptr Device00](self.impl))

proc axes*(self: Device): AxisFlags =
  gdk_device_get_axes(cast[ptr Device00](self.impl))

type
  DeviceType* {.size: sizeof(cint), pure.} = enum
    master = 0
    slave = 1
    floating = 2

proc gdk_device_get_device_type*(self: ptr Device00): DeviceType {.
    importc: "gdk_device_get_device_type", libprag.}

proc getDeviceType*(self: Device): DeviceType =
  gdk_device_get_device_type(cast[ptr Device00](self.impl))

proc deviceType*(self: Device): DeviceType =
  gdk_device_get_device_type(cast[ptr Device00](self.impl))

type
  InputSource* {.size: sizeof(cint), pure.} = enum
    mouse = 0
    pen = 1
    eraser = 2
    cursor = 3
    keyboard = 4
    touchscreen = 5
    touchpad = 6
    trackpoint = 7
    tabletPad = 8

proc gdk_device_get_source*(self: ptr Device00): InputSource {.
    importc: "gdk_device_get_source", libprag.}

proc getSource*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

proc source*(self: Device): InputSource =
  gdk_device_get_source(cast[ptr Device00](self.impl))

type
  AxisUse* {.size: sizeof(cint), pure.} = enum
    ignore = 0
    x = 1
    y = 2
    pressure = 3
    xtilt = 4
    ytilt = 5
    wheel = 6
    distance = 7
    rotation = 8
    slider = 9
    last = 10

proc gdk_device_get_axis_use*(self: ptr Device00; index: uint32): AxisUse {.
    importc: "gdk_device_get_axis_use", libprag.}

proc getAxisUse*(self: Device; index: int): AxisUse =
  gdk_device_get_axis_use(cast[ptr Device00](self.impl), uint32(index))

proc axisUse*(self: Device; index: int): AxisUse =
  gdk_device_get_axis_use(cast[ptr Device00](self.impl), uint32(index))

proc gdk_device_set_axis_use*(self: ptr Device00; index: uint32; use: AxisUse) {.
    importc: "gdk_device_set_axis_use", libprag.}

proc setAxisUse*(self: Device; index: int; use: AxisUse) =
  gdk_device_set_axis_use(cast[ptr Device00](self.impl), uint32(index), use)

type
  ModifierType* {.size: sizeof(cint), pure.} = enum
    shiftMask = 1
    lockMask = 2
    controlMask = 4
    mod1Mask = 8
    mod2Mask = 16
    mod3Mask = 32
    mod4Mask = 64
    mod5Mask = 128
    button1Mask = 256
    button2Mask = 512
    button3Mask = 1024
    button4Mask = 2048
    button5Mask = 4096
    modifierReserved_13Mask = 8192
    modifierReserved_14Mask = 16384
    modifierReserved_15Mask = 32768
    modifierReserved_16Mask = 65536
    modifierReserved_17Mask = 131072
    modifierReserved_18Mask = 262144
    modifierReserved_19Mask = 524288
    modifierReserved_20Mask = 1048576
    modifierReserved_21Mask = 2097152
    modifierReserved_22Mask = 4194304
    modifierReserved_23Mask = 8388608
    modifierReserved_24Mask = 16777216
    modifierReserved_25Mask = 33554432
    superMask = 67108864
    hyperMask = 134217728
    metaMask = 268435456
    modifierReserved_29Mask = 536870912
    releaseMask = 1073741824
    modifierMask = 1543512063

proc gdk_device_get_key*(self: ptr Device00; index: uint32; keyval: var uint32; 
    modifiers: var ModifierType): gboolean {.
    importc: "gdk_device_get_key", libprag.}

proc getKey*(self: Device; index: int; keyval: var int; modifiers: var ModifierType): bool =
  var keyval_00 = uint32(keyval)
  result = toBool(gdk_device_get_key(cast[ptr Device00](self.impl), uint32(index), keyval_00, modifiers))
  keyval = int(keyval_00)

proc key*(self: Device; index: int; keyval: var int; modifiers: var ModifierType): bool =
  var keyval_00 = uint32(keyval)
  result = toBool(gdk_device_get_key(cast[ptr Device00](self.impl), uint32(index), keyval_00, modifiers))
  keyval = int(keyval_00)

proc gdk_device_set_key*(self: ptr Device00; index: uint32; keyval: uint32; 
    modifiers: ModifierType) {.
    importc: "gdk_device_set_key", libprag.}

proc setKey*(self: Device; index: int; keyval: int; modifiers: ModifierType) =
  gdk_device_set_key(cast[ptr Device00](self.impl), uint32(index), uint32(keyval), modifiers)

type
  InputMode* {.size: sizeof(cint), pure.} = enum
    disabled = 0
    screen = 1
    window = 2

proc gdk_device_get_mode*(self: ptr Device00): InputMode {.
    importc: "gdk_device_get_mode", libprag.}

proc getMode*(self: Device): InputMode =
  gdk_device_get_mode(cast[ptr Device00](self.impl))

proc mode*(self: Device): InputMode =
  gdk_device_get_mode(cast[ptr Device00](self.impl))

proc gdk_device_set_mode*(self: ptr Device00; mode: InputMode): gboolean {.
    importc: "gdk_device_set_mode", libprag.}

proc setMode*(self: Device; mode: InputMode): bool =
  toBool(gdk_device_set_mode(cast[ptr Device00](self.impl), mode))

proc `mode=`*(self: Device; mode: InputMode): bool =
  toBool(gdk_device_set_mode(cast[ptr Device00](self.impl), mode))

type
  SeatCapabilities* {.size: sizeof(cint), pure.} = enum
    none = 0
    pointer = 1
    touch = 2
    tabletStylus = 4
    allPointing = 7
    keyboard = 8
    all = 15

proc gdk_seat_get_capabilities*(self: ptr Seat00): SeatCapabilities {.
    importc: "gdk_seat_get_capabilities", libprag.}

proc getCapabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc capabilities*(self: Seat): SeatCapabilities =
  gdk_seat_get_capabilities(cast[ptr Seat00](self.impl))

proc gdk_seat_get_slaves*(self: ptr Seat00; capabilities: SeatCapabilities): ptr pointer {.
    importc: "gdk_seat_get_slaves", libprag.}

proc getSlaves*(self: Seat; capabilities: SeatCapabilities): ptr pointer =
  gdk_seat_get_slaves(cast[ptr Seat00](self.impl), capabilities)

proc slaves*(self: Seat; capabilities: SeatCapabilities): ptr pointer =
  gdk_seat_get_slaves(cast[ptr Seat00](self.impl), capabilities)

type
  DeviceManager* = ref object of gobject.Object
  DeviceManager00* = object of gobject.Object00

proc scDeviceAdded*(self: DeviceManager;  p: proc (self: ptr gobject.Object00; device: Device00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "device-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDeviceChanged*(self: DeviceManager;  p: proc (self: ptr gobject.Object00; device: Device00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "device-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDeviceRemoved*(self: DeviceManager;  p: proc (self: ptr gobject.Object00; device: Device00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "device-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_device_manager_get_client_pointer*(self: ptr DeviceManager00): ptr Device00 {.
    importc: "gdk_device_manager_get_client_pointer", libprag.}

proc getClientPointer*(self: DeviceManager): Device =
  let gobj = gdk_device_manager_get_client_pointer(cast[ptr DeviceManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc clientPointer*(self: DeviceManager): Device =
  let gobj = gdk_device_manager_get_client_pointer(cast[ptr DeviceManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_manager_get_display*(self: ptr DeviceManager00): ptr Display00 {.
    importc: "gdk_device_manager_get_display", libprag.}

proc getDisplay*(self: DeviceManager): Display =
  let gobj = gdk_device_manager_get_display(cast[ptr DeviceManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: DeviceManager): Display =
  let gobj = gdk_device_manager_get_display(cast[ptr DeviceManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_manager_list_devices*(self: ptr DeviceManager00; `type`: DeviceType): ptr pointer {.
    importc: "gdk_device_manager_list_devices", libprag.}

proc listDevices*(self: DeviceManager; `type`: DeviceType): ptr pointer =
  gdk_device_manager_list_devices(cast[ptr DeviceManager00](self.impl), `type`)

proc gdk_display_get_device_manager*(self: ptr Display00): ptr DeviceManager00 {.
    importc: "gdk_display_get_device_manager", libprag.}

proc getDeviceManager*(self: Display): DeviceManager =
  let gobj = gdk_display_get_device_manager(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DeviceManager](g_object_get_qdata(gobj, Quark))
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

proc deviceManager*(self: Display): DeviceManager =
  let gobj = gdk_display_get_device_manager(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DeviceManager](g_object_get_qdata(gobj, Quark))
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
  Atom00* {.pure.} = object
  Atom* = ref object
    impl*: ptr Atom00

proc gdk_atom_name*(self: ptr Atom00): cstring {.
    importc: "gdk_atom_name", libprag.}

proc name*(self: Atom): string =
  let resul0 = gdk_atom_name(cast[ptr Atom00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_atom_intern*(atomName: cstring; onlyIfExists: gboolean): ptr Atom00 {.
    importc: "gdk_atom_intern", libprag.}

proc intern*(atomName: string; onlyIfExists: bool): Atom =
  new(result)
  result.impl = gdk_atom_intern(cstring(atomName), gboolean(onlyIfExists))

proc gdk_atom_intern_static_string*(atomName: cstring): ptr Atom00 {.
    importc: "gdk_atom_intern_static_string", libprag.}

proc internStaticString*(atomName: string): Atom =
  new(result)
  result.impl = gdk_atom_intern_static_string(cstring(atomName))

proc gdk_display_request_selection_notification*(self: ptr Display00; selection: ptr Atom00): gboolean {.
    importc: "gdk_display_request_selection_notification", libprag.}

proc requestSelectionNotification*(self: Display; selection: Atom): bool =
  toBool(gdk_display_request_selection_notification(cast[ptr Display00](self.impl), cast[ptr Atom00](selection.impl)))

type
  Window* = ref object of gobject.Object
  Window00* = object of gobject.Object00

proc scCreateSurface*(self: Window;  p: proc (self: ptr gobject.Object00; width: int32; height: int32; xdata: pointer): cairo.Surface00 {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "create-surface", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scFromEmbedder*(self: Window;  p: proc (self: ptr gobject.Object00; embedderX: cdouble; embedderY: cdouble; offscreenX: var cdouble; 
    offscreenY: var cdouble; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "from-embedder", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMovedToRect*(self: Window;  p: proc (self: ptr gobject.Object00; flippedRect: pointer; finalRect: pointer; flippedX: gboolean; 
    flippedY: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "moved-to-rect", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scPickEmbeddedChild*(self: Window;  p: proc (self: ptr gobject.Object00; x: cdouble; y: cdouble; xdata: pointer): Window00 {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "pick-embedded-child", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scToEmbedder*(self: Window;  p: proc (self: ptr gobject.Object00; offscreenX: cdouble; offscreenY: cdouble; embedderX: var cdouble; 
    embedderY: var cdouble; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "to-embedder", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_window_at_pointer*(winX: var int32; winY: var int32): ptr Window00 {.
    importc: "gdk_window_at_pointer", libprag.}

proc atPointer*(winX: var int; winY: var int): Window =
  var winX_00 = int32(winX)
  var winY_00 = int32(winY)
  let gobj = gdk_window_at_pointer(winX_00, winY_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  winX = int(winX_00)
  winY = int(winY_00)

proc gdk_window_process_all_updates*() {.
    importc: "gdk_window_process_all_updates", libprag.}

proc processAllUpdates*() {.
    importc: "gdk_window_process_all_updates", libprag.}

proc gdk_window_set_debug_updates*(setting: gboolean) {.
    importc: "gdk_window_set_debug_updates", libprag.}

proc setDebugUpdates*(setting: gboolean) {.
    importc: "gdk_window_set_debug_updates", libprag.}

proc `debugUpdates=`*(setting: gboolean) {.
    importc: "gdk_window_set_debug_updates", libprag.}

proc gdk_window_beep*(self: ptr Window00) {.
    importc: "gdk_window_beep", libprag.}

proc beep*(self: Window) =
  gdk_window_beep(cast[ptr Window00](self.impl))

proc gdk_window_begin_move_drag*(self: ptr Window00; button: int32; rootX: int32; rootY: int32; 
    timestamp: uint32) {.
    importc: "gdk_window_begin_move_drag", libprag.}

proc beginMoveDrag*(self: Window; button: int; rootX: int; rootY: int; 
    timestamp: int) =
  gdk_window_begin_move_drag(cast[ptr Window00](self.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_move_drag_for_device*(self: ptr Window00; device: ptr Device00; button: int32; 
    rootX: int32; rootY: int32; timestamp: uint32) {.
    importc: "gdk_window_begin_move_drag_for_device", libprag.}

proc beginMoveDragForDevice*(self: Window; device: Device; button: int; rootX: int; 
    rootY: int; timestamp: int) =
  gdk_window_begin_move_drag_for_device(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_paint_region*(self: ptr Window00; region: ptr cairo.Region00) {.
    importc: "gdk_window_begin_paint_region", libprag.}

proc beginPaintRegion*(self: Window; region: cairo.Region) =
  gdk_window_begin_paint_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_window_configure_finished*(self: ptr Window00) {.
    importc: "gdk_window_configure_finished", libprag.}

proc configureFinished*(self: Window) =
  gdk_window_configure_finished(cast[ptr Window00](self.impl))

proc gdk_window_coords_from_parent*(self: ptr Window00; parentX: cdouble; parentY: cdouble; 
    x: var cdouble; y: var cdouble) {.
    importc: "gdk_window_coords_from_parent", libprag.}

proc coordsFromParent*(self: Window; parentX: cdouble; parentY: cdouble; 
    x: var cdouble; y: var cdouble) =
  gdk_window_coords_from_parent(cast[ptr Window00](self.impl), parentX, parentY, x, y)

proc gdk_window_coords_to_parent*(self: ptr Window00; x: cdouble; y: cdouble; parentX: var cdouble; 
    parentY: var cdouble) {.
    importc: "gdk_window_coords_to_parent", libprag.}

proc coordsToParent*(self: Window; x: cdouble; y: cdouble; parentX: var cdouble; 
    parentY: var cdouble) =
  gdk_window_coords_to_parent(cast[ptr Window00](self.impl), x, y, parentX, parentY)

proc gdk_window_create_similar_image_surface*(self: ptr Window00; format: int32; width: int32; height: int32; 
    scale: int32): ptr cairo.Surface00 {.
    importc: "gdk_window_create_similar_image_surface", libprag.}

proc createSimilarImageSurface*(self: Window; format: int; width: int; height: int; 
    scale: int): cairo.Surface =
  new(result)
  result.impl = gdk_window_create_similar_image_surface(cast[ptr Window00](self.impl), int32(format), int32(width), int32(height), int32(scale))

proc gdk_window_create_similar_surface*(self: ptr Window00; content: cairo.Content; width: int32; 
    height: int32): ptr cairo.Surface00 {.
    importc: "gdk_window_create_similar_surface", libprag.}

proc createSimilarSurface*(self: Window; content: cairo.Content; width: int; 
    height: int): cairo.Surface =
  new(result)
  result.impl = gdk_window_create_similar_surface(cast[ptr Window00](self.impl), content, int32(width), int32(height))

proc gdk_window_deiconify*(self: ptr Window00) {.
    importc: "gdk_window_deiconify", libprag.}

proc deiconify*(self: Window) =
  gdk_window_deiconify(cast[ptr Window00](self.impl))

proc gdk_window_destroy*(self: ptr Window00) {.
    importc: "gdk_window_destroy", libprag.}

proc destroy*(self: Window) =
  gdk_window_destroy(cast[ptr Window00](self.impl))

proc gdk_window_destroy_notify*(self: ptr Window00) {.
    importc: "gdk_window_destroy_notify", libprag.}

proc destroyNotify*(self: Window) =
  gdk_window_destroy_notify(cast[ptr Window00](self.impl))

proc gdk_window_enable_synchronized_configure*(self: ptr Window00) {.
    importc: "gdk_window_enable_synchronized_configure", libprag.}

proc enableSynchronizedConfigure*(self: Window) =
  gdk_window_enable_synchronized_configure(cast[ptr Window00](self.impl))

proc gdk_window_end_paint*(self: ptr Window00) {.
    importc: "gdk_window_end_paint", libprag.}

proc endPaint*(self: Window) =
  gdk_window_end_paint(cast[ptr Window00](self.impl))

proc gdk_window_ensure_native*(self: ptr Window00): gboolean {.
    importc: "gdk_window_ensure_native", libprag.}

proc ensureNative*(self: Window): bool =
  toBool(gdk_window_ensure_native(cast[ptr Window00](self.impl)))

proc gdk_window_flush*(self: ptr Window00) {.
    importc: "gdk_window_flush", libprag.}

proc flush*(self: Window) =
  gdk_window_flush(cast[ptr Window00](self.impl))

proc gdk_window_focus*(self: ptr Window00; timestamp: uint32) {.
    importc: "gdk_window_focus", libprag.}

proc focus*(self: Window; timestamp: int) =
  gdk_window_focus(cast[ptr Window00](self.impl), uint32(timestamp))

proc gdk_window_freeze_toplevel_updates_libgtk_only*(self: ptr Window00) {.
    importc: "gdk_window_freeze_toplevel_updates_libgtk_only", libprag.}

proc freezeToplevelUpdatesLibgtkOnly*(self: Window) =
  gdk_window_freeze_toplevel_updates_libgtk_only(cast[ptr Window00](self.impl))

proc gdk_window_freeze_updates*(self: ptr Window00) {.
    importc: "gdk_window_freeze_updates", libprag.}

proc freezeUpdates*(self: Window) =
  gdk_window_freeze_updates(cast[ptr Window00](self.impl))

proc gdk_window_fullscreen*(self: ptr Window00) {.
    importc: "gdk_window_fullscreen", libprag.}

proc fullscreen*(self: Window) =
  gdk_window_fullscreen(cast[ptr Window00](self.impl))

proc gdk_window_fullscreen_on_monitor*(self: ptr Window00; monitor: int32) {.
    importc: "gdk_window_fullscreen_on_monitor", libprag.}

proc fullscreenOnMonitor*(self: Window; monitor: int) =
  gdk_window_fullscreen_on_monitor(cast[ptr Window00](self.impl), int32(monitor))

proc gdk_window_geometry_changed*(self: ptr Window00) {.
    importc: "gdk_window_geometry_changed", libprag.}

proc geometryChanged*(self: Window) =
  gdk_window_geometry_changed(cast[ptr Window00](self.impl))

proc gdk_window_get_accept_focus*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_accept_focus", libprag.}

proc getAcceptFocus*(self: Window): bool =
  toBool(gdk_window_get_accept_focus(cast[ptr Window00](self.impl)))

proc acceptFocus*(self: Window): bool =
  toBool(gdk_window_get_accept_focus(cast[ptr Window00](self.impl)))

proc gdk_window_get_background_pattern*(self: ptr Window00): ptr cairo.Pattern00 {.
    importc: "gdk_window_get_background_pattern", libprag.}

proc getBackgroundPattern*(self: Window): cairo.Pattern =
  new(result)
  result.impl = gdk_window_get_background_pattern(cast[ptr Window00](self.impl))

proc backgroundPattern*(self: Window): cairo.Pattern =
  new(result)
  result.impl = gdk_window_get_background_pattern(cast[ptr Window00](self.impl))

proc gdk_window_get_children*(self: ptr Window00): ptr pointer {.
    importc: "gdk_window_get_children", libprag.}

proc getChildren*(self: Window): ptr pointer =
  gdk_window_get_children(cast[ptr Window00](self.impl))

proc children*(self: Window): ptr pointer =
  gdk_window_get_children(cast[ptr Window00](self.impl))

proc gdk_window_get_children_with_user_data*(self: ptr Window00; userData: pointer): ptr pointer {.
    importc: "gdk_window_get_children_with_user_data", libprag.}

proc getChildrenWithUserData*(self: Window; userData: pointer): ptr pointer =
  gdk_window_get_children_with_user_data(cast[ptr Window00](self.impl), userData)

proc childrenWithUserData*(self: Window; userData: pointer): ptr pointer =
  gdk_window_get_children_with_user_data(cast[ptr Window00](self.impl), userData)

proc gdk_window_get_clip_region*(self: ptr Window00): ptr cairo.Region00 {.
    importc: "gdk_window_get_clip_region", libprag.}

proc getClipRegion*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_clip_region(cast[ptr Window00](self.impl))

proc clipRegion*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_clip_region(cast[ptr Window00](self.impl))

proc gdk_window_get_composited*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_composited", libprag.}

proc getComposited*(self: Window): bool =
  toBool(gdk_window_get_composited(cast[ptr Window00](self.impl)))

proc composited*(self: Window): bool =
  toBool(gdk_window_get_composited(cast[ptr Window00](self.impl)))

proc gdk_window_get_device_position*(self: ptr Window00; device: ptr Device00; x: var int32; 
    y: var int32; mask: var ModifierType): ptr Window00 {.
    importc: "gdk_window_get_device_position", libprag.}

proc getDevicePosition*(self: Window; device: Device; x: var int; y: var int; 
    mask: var ModifierType): Window =
  var y_00 = int32(y)
  var x_00 = int32(x)
  let gobj = gdk_window_get_device_position(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x_00, y_00, mask)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  y = int(y_00)
  x = int(x_00)

proc devicePosition*(self: Window; device: Device; x: var int; y: var int; 
    mask: var ModifierType): Window =
  var y_00 = int32(y)
  var x_00 = int32(x)
  let gobj = gdk_window_get_device_position(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x_00, y_00, mask)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  y = int(y_00)
  x = int(x_00)

proc gdk_window_get_device_position_double*(self: ptr Window00; device: ptr Device00; x: var cdouble; 
    y: var cdouble; mask: var ModifierType): ptr Window00 {.
    importc: "gdk_window_get_device_position_double", libprag.}

proc getDevicePositionDouble*(self: Window; device: Device; x: var cdouble; y: var cdouble; 
    mask: var ModifierType): Window =
  let gobj = gdk_window_get_device_position_double(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x, y, mask)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc devicePositionDouble*(self: Window; device: Device; x: var cdouble; y: var cdouble; 
    mask: var ModifierType): Window =
  let gobj = gdk_window_get_device_position_double(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), x, y, mask)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_display*(self: ptr Window00): ptr Display00 {.
    importc: "gdk_window_get_display", libprag.}

proc getDisplay*(self: Window): Display =
  let gobj = gdk_window_get_display(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Window): Display =
  let gobj = gdk_window_get_display(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_effective_parent*(self: ptr Window00): ptr Window00 {.
    importc: "gdk_window_get_effective_parent", libprag.}

proc getEffectiveParent*(self: Window): Window =
  let gobj = gdk_window_get_effective_parent(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc effectiveParent*(self: Window): Window =
  let gobj = gdk_window_get_effective_parent(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_effective_toplevel*(self: ptr Window00): ptr Window00 {.
    importc: "gdk_window_get_effective_toplevel", libprag.}

proc getEffectiveToplevel*(self: Window): Window =
  let gobj = gdk_window_get_effective_toplevel(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc effectiveToplevel*(self: Window): Window =
  let gobj = gdk_window_get_effective_toplevel(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_event_compression*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_event_compression", libprag.}

proc getEventCompression*(self: Window): bool =
  toBool(gdk_window_get_event_compression(cast[ptr Window00](self.impl)))

proc eventCompression*(self: Window): bool =
  toBool(gdk_window_get_event_compression(cast[ptr Window00](self.impl)))

proc gdk_window_get_focus_on_map*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_focus_on_map", libprag.}

proc getFocusOnMap*(self: Window): bool =
  toBool(gdk_window_get_focus_on_map(cast[ptr Window00](self.impl)))

proc focusOnMap*(self: Window): bool =
  toBool(gdk_window_get_focus_on_map(cast[ptr Window00](self.impl)))

proc gdk_window_get_geometry*(self: ptr Window00; x: var int32; y: var int32; width: var int32; 
    height: var int32) {.
    importc: "gdk_window_get_geometry", libprag.}

proc getGeometry*(self: Window; x: var int; y: var int; width: var int; 
    height: var int) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  gdk_window_get_geometry(cast[ptr Window00](self.impl), x_00, y_00, width_00, height_00)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc geometry*(self: Window; x: var int; y: var int; width: var int; 
    height: var int) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  gdk_window_get_geometry(cast[ptr Window00](self.impl), x_00, y_00, width_00, height_00)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc gdk_window_get_group*(self: ptr Window00): ptr Window00 {.
    importc: "gdk_window_get_group", libprag.}

proc getGroup*(self: Window): Window =
  let gobj = gdk_window_get_group(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc group*(self: Window): Window =
  let gobj = gdk_window_get_group(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_height*(self: ptr Window00): int32 {.
    importc: "gdk_window_get_height", libprag.}

proc getHeight*(self: Window): int =
  int(gdk_window_get_height(cast[ptr Window00](self.impl)))

proc height*(self: Window): int =
  int(gdk_window_get_height(cast[ptr Window00](self.impl)))

proc gdk_window_get_modal_hint*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_modal_hint", libprag.}

proc getModalHint*(self: Window): bool =
  toBool(gdk_window_get_modal_hint(cast[ptr Window00](self.impl)))

proc modalHint*(self: Window): bool =
  toBool(gdk_window_get_modal_hint(cast[ptr Window00](self.impl)))

proc gdk_window_get_origin*(self: ptr Window00; x: var int32; y: var int32): int32 {.
    importc: "gdk_window_get_origin", libprag.}

proc getOrigin*(self: Window; x: var int; y: var int): int =
  var y_00 = int32(y)
  var x_00 = int32(x)
  result = int(gdk_window_get_origin(cast[ptr Window00](self.impl), x_00, y_00))
  y = int(y_00)
  x = int(x_00)

proc origin*(self: Window; x: var int; y: var int): int =
  var y_00 = int32(y)
  var x_00 = int32(x)
  result = int(gdk_window_get_origin(cast[ptr Window00](self.impl), x_00, y_00))
  y = int(y_00)
  x = int(x_00)

proc gdk_window_get_parent*(self: ptr Window00): ptr Window00 {.
    importc: "gdk_window_get_parent", libprag.}

proc getParent*(self: Window): Window =
  let gobj = gdk_window_get_parent(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc parent*(self: Window): Window =
  let gobj = gdk_window_get_parent(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_pass_through*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_pass_through", libprag.}

proc getPassThrough*(self: Window): bool =
  toBool(gdk_window_get_pass_through(cast[ptr Window00](self.impl)))

proc passThrough*(self: Window): bool =
  toBool(gdk_window_get_pass_through(cast[ptr Window00](self.impl)))

proc gdk_window_get_pointer*(self: ptr Window00; x: var int32; y: var int32; mask: var ModifierType): ptr Window00 {.
    importc: "gdk_window_get_pointer", libprag.}

proc getPointer*(self: Window; x: var int; y: var int; mask: var ModifierType): Window =
  var y_00 = int32(y)
  var x_00 = int32(x)
  let gobj = gdk_window_get_pointer(cast[ptr Window00](self.impl), x_00, y_00, mask)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  y = int(y_00)
  x = int(x_00)

proc gdk_window_get_position*(self: ptr Window00; x: var int32; y: var int32) {.
    importc: "gdk_window_get_position", libprag.}

proc getPosition*(self: Window; x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  gdk_window_get_position(cast[ptr Window00](self.impl), x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc position*(self: Window; x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  gdk_window_get_position(cast[ptr Window00](self.impl), x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc gdk_window_get_root_coords*(self: ptr Window00; x: int32; y: int32; rootX: var int32; 
    rootY: var int32) {.
    importc: "gdk_window_get_root_coords", libprag.}

proc getRootCoords*(self: Window; x: int; y: int; rootX: var int; rootY: var int) =
  var rootY_00 = int32(rootY)
  var rootX_00 = int32(rootX)
  gdk_window_get_root_coords(cast[ptr Window00](self.impl), int32(x), int32(y), rootX_00, rootY_00)
  rootY = int(rootY_00)
  rootX = int(rootX_00)

proc rootCoords*(self: Window; x: int; y: int; rootX: var int; rootY: var int) =
  var rootY_00 = int32(rootY)
  var rootX_00 = int32(rootX)
  gdk_window_get_root_coords(cast[ptr Window00](self.impl), int32(x), int32(y), rootX_00, rootY_00)
  rootY = int(rootY_00)
  rootX = int(rootX_00)

proc gdk_window_get_root_origin*(self: ptr Window00; x: var int32; y: var int32) {.
    importc: "gdk_window_get_root_origin", libprag.}

proc getRootOrigin*(self: Window; x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  gdk_window_get_root_origin(cast[ptr Window00](self.impl), x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc rootOrigin*(self: Window; x: var int; y: var int) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  gdk_window_get_root_origin(cast[ptr Window00](self.impl), x_00, y_00)
  y = int(y_00)
  x = int(x_00)

proc gdk_window_get_scale_factor*(self: ptr Window00): int32 {.
    importc: "gdk_window_get_scale_factor", libprag.}

proc getScaleFactor*(self: Window): int =
  int(gdk_window_get_scale_factor(cast[ptr Window00](self.impl)))

proc scaleFactor*(self: Window): int =
  int(gdk_window_get_scale_factor(cast[ptr Window00](self.impl)))

proc gdk_window_get_support_multidevice*(self: ptr Window00): gboolean {.
    importc: "gdk_window_get_support_multidevice", libprag.}

proc getSupportMultidevice*(self: Window): bool =
  toBool(gdk_window_get_support_multidevice(cast[ptr Window00](self.impl)))

proc supportMultidevice*(self: Window): bool =
  toBool(gdk_window_get_support_multidevice(cast[ptr Window00](self.impl)))

proc gdk_window_get_toplevel*(self: ptr Window00): ptr Window00 {.
    importc: "gdk_window_get_toplevel", libprag.}

proc getToplevel*(self: Window): Window =
  let gobj = gdk_window_get_toplevel(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc toplevel*(self: Window): Window =
  let gobj = gdk_window_get_toplevel(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_update_area*(self: ptr Window00): ptr cairo.Region00 {.
    importc: "gdk_window_get_update_area", libprag.}

proc getUpdateArea*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_update_area(cast[ptr Window00](self.impl))

proc updateArea*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_update_area(cast[ptr Window00](self.impl))

proc gdk_window_get_user_data*(self: ptr Window00; data: var pointer) {.
    importc: "gdk_window_get_user_data", libprag.}

proc getUserData*(self: Window; data: var pointer) =
  gdk_window_get_user_data(cast[ptr Window00](self.impl), data)

proc userData*(self: Window; data: var pointer) =
  gdk_window_get_user_data(cast[ptr Window00](self.impl), data)

proc gdk_window_get_visible_region*(self: ptr Window00): ptr cairo.Region00 {.
    importc: "gdk_window_get_visible_region", libprag.}

proc getVisibleRegion*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_visible_region(cast[ptr Window00](self.impl))

proc visibleRegion*(self: Window): cairo.Region =
  new(result)
  result.impl = gdk_window_get_visible_region(cast[ptr Window00](self.impl))

proc gdk_window_get_width*(self: ptr Window00): int32 {.
    importc: "gdk_window_get_width", libprag.}

proc getWidth*(self: Window): int =
  int(gdk_window_get_width(cast[ptr Window00](self.impl)))

proc width*(self: Window): int =
  int(gdk_window_get_width(cast[ptr Window00](self.impl)))

proc gdk_window_has_native*(self: ptr Window00): gboolean {.
    importc: "gdk_window_has_native", libprag.}

proc hasNative*(self: Window): bool =
  toBool(gdk_window_has_native(cast[ptr Window00](self.impl)))

proc gdk_window_hide*(self: ptr Window00) {.
    importc: "gdk_window_hide", libprag.}

proc hide*(self: Window) =
  gdk_window_hide(cast[ptr Window00](self.impl))

proc gdk_window_iconify*(self: ptr Window00) {.
    importc: "gdk_window_iconify", libprag.}

proc iconify*(self: Window) =
  gdk_window_iconify(cast[ptr Window00](self.impl))

proc gdk_window_input_shape_combine_region*(self: ptr Window00; shapeRegion: ptr cairo.Region00; 
    offsetX: int32; offsetY: int32) {.
    importc: "gdk_window_input_shape_combine_region", libprag.}

proc inputShapeCombineRegion*(self: Window; shapeRegion: cairo.Region; offsetX: int; 
    offsetY: int) =
  gdk_window_input_shape_combine_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](shapeRegion.impl), int32(offsetX), int32(offsetY))

proc gdk_window_invalidate_region*(self: ptr Window00; region: ptr cairo.Region00; invalidateChildren: gboolean) {.
    importc: "gdk_window_invalidate_region", libprag.}

proc invalidateRegion*(self: Window; region: cairo.Region; invalidateChildren: bool) =
  gdk_window_invalidate_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), gboolean(invalidateChildren))

proc gdk_window_is_destroyed*(self: ptr Window00): gboolean {.
    importc: "gdk_window_is_destroyed", libprag.}

proc isDestroyed*(self: Window): bool =
  toBool(gdk_window_is_destroyed(cast[ptr Window00](self.impl)))

proc gdk_window_is_input_only*(self: ptr Window00): gboolean {.
    importc: "gdk_window_is_input_only", libprag.}

proc isInputOnly*(self: Window): bool =
  toBool(gdk_window_is_input_only(cast[ptr Window00](self.impl)))

proc gdk_window_is_shaped*(self: ptr Window00): gboolean {.
    importc: "gdk_window_is_shaped", libprag.}

proc isShaped*(self: Window): bool =
  toBool(gdk_window_is_shaped(cast[ptr Window00](self.impl)))

proc gdk_window_is_viewable*(self: ptr Window00): gboolean {.
    importc: "gdk_window_is_viewable", libprag.}

proc isViewable*(self: Window): bool =
  toBool(gdk_window_is_viewable(cast[ptr Window00](self.impl)))

proc gdk_window_is_visible*(self: ptr Window00): gboolean {.
    importc: "gdk_window_is_visible", libprag.}

proc isVisible*(self: Window): bool =
  toBool(gdk_window_is_visible(cast[ptr Window00](self.impl)))

proc gdk_window_lower*(self: ptr Window00) {.
    importc: "gdk_window_lower", libprag.}

proc lower*(self: Window) =
  gdk_window_lower(cast[ptr Window00](self.impl))

proc gdk_window_mark_paint_from_clip*(self: ptr Window00; cr: ptr cairo.Context00) {.
    importc: "gdk_window_mark_paint_from_clip", libprag.}

proc markPaintFromClip*(self: Window; cr: cairo.Context) =
  gdk_window_mark_paint_from_clip(cast[ptr Window00](self.impl), cast[ptr cairo.Context00](cr.impl))

proc gdk_window_maximize*(self: ptr Window00) {.
    importc: "gdk_window_maximize", libprag.}

proc maximize*(self: Window) =
  gdk_window_maximize(cast[ptr Window00](self.impl))

proc gdk_window_merge_child_input_shapes*(self: ptr Window00) {.
    importc: "gdk_window_merge_child_input_shapes", libprag.}

proc mergeChildInputShapes*(self: Window) =
  gdk_window_merge_child_input_shapes(cast[ptr Window00](self.impl))

proc gdk_window_merge_child_shapes*(self: ptr Window00) {.
    importc: "gdk_window_merge_child_shapes", libprag.}

proc mergeChildShapes*(self: Window) =
  gdk_window_merge_child_shapes(cast[ptr Window00](self.impl))

proc gdk_window_move*(self: ptr Window00; x: int32; y: int32) {.
    importc: "gdk_window_move", libprag.}

proc move*(self: Window; x: int; y: int) =
  gdk_window_move(cast[ptr Window00](self.impl), int32(x), int32(y))

proc gdk_window_move_region*(self: ptr Window00; region: ptr cairo.Region00; dx: int32; 
    dy: int32) {.
    importc: "gdk_window_move_region", libprag.}

proc moveRegion*(self: Window; region: cairo.Region; dx: int; dy: int) =
  gdk_window_move_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), int32(dx), int32(dy))

proc gdk_window_move_resize*(self: ptr Window00; x: int32; y: int32; width: int32; 
    height: int32) {.
    importc: "gdk_window_move_resize", libprag.}

proc moveResize*(self: Window; x: int; y: int; width: int; height: int) =
  gdk_window_move_resize(cast[ptr Window00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc gdk_window_peek_children*(self: ptr Window00): ptr pointer {.
    importc: "gdk_window_peek_children", libprag.}

proc peekChildren*(self: Window): ptr pointer =
  gdk_window_peek_children(cast[ptr Window00](self.impl))

proc gdk_window_process_updates*(self: ptr Window00; updateChildren: gboolean) {.
    importc: "gdk_window_process_updates", libprag.}

proc processUpdates*(self: Window; updateChildren: bool) =
  gdk_window_process_updates(cast[ptr Window00](self.impl), gboolean(updateChildren))

proc gdk_window_raise*(self: ptr Window00) {.
    importc: "gdk_window_raise", libprag.}

proc `raise`*(self: Window) =
  gdk_window_raise(cast[ptr Window00](self.impl))

proc gdk_window_register_dnd*(self: ptr Window00) {.
    importc: "gdk_window_register_dnd", libprag.}

proc registerDnd*(self: Window) =
  gdk_window_register_dnd(cast[ptr Window00](self.impl))

proc gdk_window_reparent*(self: ptr Window00; newParent: ptr Window00; x: int32; 
    y: int32) {.
    importc: "gdk_window_reparent", libprag.}

proc reparent*(self: Window; newParent: Window; x: int; y: int) =
  gdk_window_reparent(cast[ptr Window00](self.impl), cast[ptr Window00](newParent.impl), int32(x), int32(y))

proc gdk_window_resize*(self: ptr Window00; width: int32; height: int32) {.
    importc: "gdk_window_resize", libprag.}

proc resize*(self: Window; width: int; height: int) =
  gdk_window_resize(cast[ptr Window00](self.impl), int32(width), int32(height))

proc gdk_window_restack*(self: ptr Window00; sibling: ptr Window00; above: gboolean) {.
    importc: "gdk_window_restack", libprag.}

proc restack*(self: Window; sibling: Window; above: bool) =
  gdk_window_restack(cast[ptr Window00](self.impl), cast[ptr Window00](sibling.impl), gboolean(above))

proc gdk_window_scroll*(self: ptr Window00; dx: int32; dy: int32) {.
    importc: "gdk_window_scroll", libprag.}

proc scroll*(self: Window; dx: int; dy: int) =
  gdk_window_scroll(cast[ptr Window00](self.impl), int32(dx), int32(dy))

proc gdk_window_set_accept_focus*(self: ptr Window00; acceptFocus: gboolean) {.
    importc: "gdk_window_set_accept_focus", libprag.}

proc setAcceptFocus*(self: Window; acceptFocus: bool) =
  gdk_window_set_accept_focus(cast[ptr Window00](self.impl), gboolean(acceptFocus))

proc `acceptFocus=`*(self: Window; acceptFocus: bool) =
  gdk_window_set_accept_focus(cast[ptr Window00](self.impl), gboolean(acceptFocus))

proc gdk_window_set_background_pattern*(self: ptr Window00; pattern: ptr cairo.Pattern00) {.
    importc: "gdk_window_set_background_pattern", libprag.}

proc setBackgroundPattern*(self: Window; pattern: cairo.Pattern) =
  gdk_window_set_background_pattern(cast[ptr Window00](self.impl), cast[ptr cairo.Pattern00](pattern.impl))

proc `backgroundPattern=`*(self: Window; pattern: cairo.Pattern) =
  gdk_window_set_background_pattern(cast[ptr Window00](self.impl), cast[ptr cairo.Pattern00](pattern.impl))

proc gdk_window_set_child_input_shapes*(self: ptr Window00) {.
    importc: "gdk_window_set_child_input_shapes", libprag.}

proc setChildInputShapes*(self: Window) =
  gdk_window_set_child_input_shapes(cast[ptr Window00](self.impl))

proc `childInputShapes=`*(self: Window) =
  gdk_window_set_child_input_shapes(cast[ptr Window00](self.impl))

proc gdk_window_set_child_shapes*(self: ptr Window00) {.
    importc: "gdk_window_set_child_shapes", libprag.}

proc setChildShapes*(self: Window) =
  gdk_window_set_child_shapes(cast[ptr Window00](self.impl))

proc `childShapes=`*(self: Window) =
  gdk_window_set_child_shapes(cast[ptr Window00](self.impl))

proc gdk_window_set_composited*(self: ptr Window00; composited: gboolean) {.
    importc: "gdk_window_set_composited", libprag.}

proc setComposited*(self: Window; composited: bool) =
  gdk_window_set_composited(cast[ptr Window00](self.impl), gboolean(composited))

proc `composited=`*(self: Window; composited: bool) =
  gdk_window_set_composited(cast[ptr Window00](self.impl), gboolean(composited))

proc gdk_window_set_event_compression*(self: ptr Window00; eventCompression: gboolean) {.
    importc: "gdk_window_set_event_compression", libprag.}

proc setEventCompression*(self: Window; eventCompression: bool) =
  gdk_window_set_event_compression(cast[ptr Window00](self.impl), gboolean(eventCompression))

proc `eventCompression=`*(self: Window; eventCompression: bool) =
  gdk_window_set_event_compression(cast[ptr Window00](self.impl), gboolean(eventCompression))

proc gdk_window_set_focus_on_map*(self: ptr Window00; focusOnMap: gboolean) {.
    importc: "gdk_window_set_focus_on_map", libprag.}

proc setFocusOnMap*(self: Window; focusOnMap: bool) =
  gdk_window_set_focus_on_map(cast[ptr Window00](self.impl), gboolean(focusOnMap))

proc `focusOnMap=`*(self: Window; focusOnMap: bool) =
  gdk_window_set_focus_on_map(cast[ptr Window00](self.impl), gboolean(focusOnMap))

proc gdk_window_set_group*(self: ptr Window00; leader: ptr Window00) {.
    importc: "gdk_window_set_group", libprag.}

proc setGroup*(self: Window; leader: Window) =
  gdk_window_set_group(cast[ptr Window00](self.impl), cast[ptr Window00](leader.impl))

proc `group=`*(self: Window; leader: Window) =
  gdk_window_set_group(cast[ptr Window00](self.impl), cast[ptr Window00](leader.impl))

proc gdk_window_set_icon_list*(self: ptr Window00; pixbufs: ptr pointer) {.
    importc: "gdk_window_set_icon_list", libprag.}

proc setIconList*(self: Window; pixbufs: ptr pointer) =
  gdk_window_set_icon_list(cast[ptr Window00](self.impl), pixbufs)

proc `iconList=`*(self: Window; pixbufs: ptr pointer) =
  gdk_window_set_icon_list(cast[ptr Window00](self.impl), pixbufs)

proc gdk_window_set_icon_name*(self: ptr Window00; name: cstring) {.
    importc: "gdk_window_set_icon_name", libprag.}

proc setIconName*(self: Window; name: string) =
  gdk_window_set_icon_name(cast[ptr Window00](self.impl), cstring(name))

proc `iconName=`*(self: Window; name: string) =
  gdk_window_set_icon_name(cast[ptr Window00](self.impl), cstring(name))

proc gdk_window_set_keep_above*(self: ptr Window00; setting: gboolean) {.
    importc: "gdk_window_set_keep_above", libprag.}

proc setKeepAbove*(self: Window; setting: bool) =
  gdk_window_set_keep_above(cast[ptr Window00](self.impl), gboolean(setting))

proc `keepAbove=`*(self: Window; setting: bool) =
  gdk_window_set_keep_above(cast[ptr Window00](self.impl), gboolean(setting))

proc gdk_window_set_keep_below*(self: ptr Window00; setting: gboolean) {.
    importc: "gdk_window_set_keep_below", libprag.}

proc setKeepBelow*(self: Window; setting: bool) =
  gdk_window_set_keep_below(cast[ptr Window00](self.impl), gboolean(setting))

proc `keepBelow=`*(self: Window; setting: bool) =
  gdk_window_set_keep_below(cast[ptr Window00](self.impl), gboolean(setting))

proc gdk_window_set_modal_hint*(self: ptr Window00; modal: gboolean) {.
    importc: "gdk_window_set_modal_hint", libprag.}

proc setModalHint*(self: Window; modal: bool) =
  gdk_window_set_modal_hint(cast[ptr Window00](self.impl), gboolean(modal))

proc `modalHint=`*(self: Window; modal: bool) =
  gdk_window_set_modal_hint(cast[ptr Window00](self.impl), gboolean(modal))

proc gdk_window_set_opacity*(self: ptr Window00; opacity: cdouble) {.
    importc: "gdk_window_set_opacity", libprag.}

proc setOpacity*(self: Window; opacity: cdouble) =
  gdk_window_set_opacity(cast[ptr Window00](self.impl), opacity)

proc `opacity=`*(self: Window; opacity: cdouble) =
  gdk_window_set_opacity(cast[ptr Window00](self.impl), opacity)

proc gdk_window_set_opaque_region*(self: ptr Window00; region: ptr cairo.Region00) {.
    importc: "gdk_window_set_opaque_region", libprag.}

proc setOpaqueRegion*(self: Window; region: cairo.Region) =
  gdk_window_set_opaque_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))

proc `opaqueRegion=`*(self: Window; region: cairo.Region) =
  gdk_window_set_opaque_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_window_set_override_redirect*(self: ptr Window00; overrideRedirect: gboolean) {.
    importc: "gdk_window_set_override_redirect", libprag.}

proc setOverrideRedirect*(self: Window; overrideRedirect: bool) =
  gdk_window_set_override_redirect(cast[ptr Window00](self.impl), gboolean(overrideRedirect))

proc `overrideRedirect=`*(self: Window; overrideRedirect: bool) =
  gdk_window_set_override_redirect(cast[ptr Window00](self.impl), gboolean(overrideRedirect))

proc gdk_window_set_pass_through*(self: ptr Window00; passThrough: gboolean) {.
    importc: "gdk_window_set_pass_through", libprag.}

proc setPassThrough*(self: Window; passThrough: bool) =
  gdk_window_set_pass_through(cast[ptr Window00](self.impl), gboolean(passThrough))

proc `passThrough=`*(self: Window; passThrough: bool) =
  gdk_window_set_pass_through(cast[ptr Window00](self.impl), gboolean(passThrough))

proc gdk_window_set_role*(self: ptr Window00; role: cstring) {.
    importc: "gdk_window_set_role", libprag.}

proc setRole*(self: Window; role: string) =
  gdk_window_set_role(cast[ptr Window00](self.impl), cstring(role))

proc `role=`*(self: Window; role: string) =
  gdk_window_set_role(cast[ptr Window00](self.impl), cstring(role))

proc gdk_window_set_shadow_width*(self: ptr Window00; left: int32; right: int32; top: int32; 
    bottom: int32) {.
    importc: "gdk_window_set_shadow_width", libprag.}

proc setShadowWidth*(self: Window; left: int; right: int; top: int; bottom: int) =
  gdk_window_set_shadow_width(cast[ptr Window00](self.impl), int32(left), int32(right), int32(top), int32(bottom))

proc gdk_window_set_skip_pager_hint*(self: ptr Window00; skipsPager: gboolean) {.
    importc: "gdk_window_set_skip_pager_hint", libprag.}

proc setSkipPagerHint*(self: Window; skipsPager: bool) =
  gdk_window_set_skip_pager_hint(cast[ptr Window00](self.impl), gboolean(skipsPager))

proc `skipPagerHint=`*(self: Window; skipsPager: bool) =
  gdk_window_set_skip_pager_hint(cast[ptr Window00](self.impl), gboolean(skipsPager))

proc gdk_window_set_skip_taskbar_hint*(self: ptr Window00; skipsTaskbar: gboolean) {.
    importc: "gdk_window_set_skip_taskbar_hint", libprag.}

proc setSkipTaskbarHint*(self: Window; skipsTaskbar: bool) =
  gdk_window_set_skip_taskbar_hint(cast[ptr Window00](self.impl), gboolean(skipsTaskbar))

proc `skipTaskbarHint=`*(self: Window; skipsTaskbar: bool) =
  gdk_window_set_skip_taskbar_hint(cast[ptr Window00](self.impl), gboolean(skipsTaskbar))

proc gdk_window_set_startup_id*(self: ptr Window00; startupId: cstring) {.
    importc: "gdk_window_set_startup_id", libprag.}

proc setStartupId*(self: Window; startupId: string) =
  gdk_window_set_startup_id(cast[ptr Window00](self.impl), cstring(startupId))

proc `startupId=`*(self: Window; startupId: string) =
  gdk_window_set_startup_id(cast[ptr Window00](self.impl), cstring(startupId))

proc gdk_window_set_static_gravities*(self: ptr Window00; useStatic: gboolean): gboolean {.
    importc: "gdk_window_set_static_gravities", libprag.}

proc setStaticGravities*(self: Window; useStatic: bool): bool =
  toBool(gdk_window_set_static_gravities(cast[ptr Window00](self.impl), gboolean(useStatic)))

proc `staticGravities=`*(self: Window; useStatic: bool): bool =
  toBool(gdk_window_set_static_gravities(cast[ptr Window00](self.impl), gboolean(useStatic)))

proc gdk_window_set_support_multidevice*(self: ptr Window00; supportMultidevice: gboolean) {.
    importc: "gdk_window_set_support_multidevice", libprag.}

proc setSupportMultidevice*(self: Window; supportMultidevice: bool) =
  gdk_window_set_support_multidevice(cast[ptr Window00](self.impl), gboolean(supportMultidevice))

proc `supportMultidevice=`*(self: Window; supportMultidevice: bool) =
  gdk_window_set_support_multidevice(cast[ptr Window00](self.impl), gboolean(supportMultidevice))

proc gdk_window_set_title*(self: ptr Window00; title: cstring) {.
    importc: "gdk_window_set_title", libprag.}

proc setTitle*(self: Window; title: string) =
  gdk_window_set_title(cast[ptr Window00](self.impl), cstring(title))

proc `title=`*(self: Window; title: string) =
  gdk_window_set_title(cast[ptr Window00](self.impl), cstring(title))

proc gdk_window_set_transient_for*(self: ptr Window00; parent: ptr Window00) {.
    importc: "gdk_window_set_transient_for", libprag.}

proc setTransientFor*(self: Window; parent: Window) =
  gdk_window_set_transient_for(cast[ptr Window00](self.impl), cast[ptr Window00](parent.impl))

proc `transientFor=`*(self: Window; parent: Window) =
  gdk_window_set_transient_for(cast[ptr Window00](self.impl), cast[ptr Window00](parent.impl))

proc gdk_window_set_urgency_hint*(self: ptr Window00; urgent: gboolean) {.
    importc: "gdk_window_set_urgency_hint", libprag.}

proc setUrgencyHint*(self: Window; urgent: bool) =
  gdk_window_set_urgency_hint(cast[ptr Window00](self.impl), gboolean(urgent))

proc `urgencyHint=`*(self: Window; urgent: bool) =
  gdk_window_set_urgency_hint(cast[ptr Window00](self.impl), gboolean(urgent))

proc gdk_window_set_user_data*(self: ptr Window00; userData: ptr gobject.Object00) {.
    importc: "gdk_window_set_user_data", libprag.}

proc setUserData*(self: Window; userData: gobject.Object) =
  gdk_window_set_user_data(cast[ptr Window00](self.impl), cast[ptr gobject.Object00](userData.impl))

proc `userData=`*(self: Window; userData: gobject.Object) =
  gdk_window_set_user_data(cast[ptr Window00](self.impl), cast[ptr gobject.Object00](userData.impl))

proc gdk_window_shape_combine_region*(self: ptr Window00; shapeRegion: ptr cairo.Region00; 
    offsetX: int32; offsetY: int32) {.
    importc: "gdk_window_shape_combine_region", libprag.}

proc shapeCombineRegion*(self: Window; shapeRegion: cairo.Region; offsetX: int; 
    offsetY: int) =
  gdk_window_shape_combine_region(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](shapeRegion.impl), int32(offsetX), int32(offsetY))

proc gdk_window_show*(self: ptr Window00) {.
    importc: "gdk_window_show", libprag.}

proc show*(self: Window) =
  gdk_window_show(cast[ptr Window00](self.impl))

proc gdk_window_show_unraised*(self: ptr Window00) {.
    importc: "gdk_window_show_unraised", libprag.}

proc showUnraised*(self: Window) =
  gdk_window_show_unraised(cast[ptr Window00](self.impl))

proc gdk_window_stick*(self: ptr Window00) {.
    importc: "gdk_window_stick", libprag.}

proc stick*(self: Window) =
  gdk_window_stick(cast[ptr Window00](self.impl))

proc gdk_window_thaw_toplevel_updates_libgtk_only*(self: ptr Window00) {.
    importc: "gdk_window_thaw_toplevel_updates_libgtk_only", libprag.}

proc thawToplevelUpdatesLibgtkOnly*(self: Window) =
  gdk_window_thaw_toplevel_updates_libgtk_only(cast[ptr Window00](self.impl))

proc gdk_window_thaw_updates*(self: ptr Window00) {.
    importc: "gdk_window_thaw_updates", libprag.}

proc thawUpdates*(self: Window) =
  gdk_window_thaw_updates(cast[ptr Window00](self.impl))

proc gdk_window_unfullscreen*(self: ptr Window00) {.
    importc: "gdk_window_unfullscreen", libprag.}

proc unfullscreen*(self: Window) =
  gdk_window_unfullscreen(cast[ptr Window00](self.impl))

proc gdk_window_unmaximize*(self: ptr Window00) {.
    importc: "gdk_window_unmaximize", libprag.}

proc unmaximize*(self: Window) =
  gdk_window_unmaximize(cast[ptr Window00](self.impl))

proc gdk_window_unstick*(self: ptr Window00) {.
    importc: "gdk_window_unstick", libprag.}

proc unstick*(self: Window) =
  gdk_window_unstick(cast[ptr Window00](self.impl))

proc gdk_window_withdraw*(self: ptr Window00) {.
    importc: "gdk_window_withdraw", libprag.}

proc withdraw*(self: Window) =
  gdk_window_withdraw(cast[ptr Window00](self.impl))

proc gdk_device_grab_info_libgtk_only*(display: ptr Display00; device: ptr Device00; grabWindow: var ptr Window00; 
    ownerEvents: var gboolean): gboolean {.
    importc: "gdk_device_grab_info_libgtk_only", libprag.}

proc grabInfoLibgtkOnly*(display: ptr Display00; device: ptr Device00; grabWindow: var ptr Window00; 
    ownerEvents: var gboolean): gboolean {.
    importc: "gdk_device_grab_info_libgtk_only", libprag.}

proc gdk_device_get_last_event_window*(self: ptr Device00): ptr Window00 {.
    importc: "gdk_device_get_last_event_window", libprag.}

proc getLastEventWindow*(self: Device): Window =
  let gobj = gdk_device_get_last_event_window(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc lastEventWindow*(self: Device): Window =
  let gobj = gdk_device_get_last_event_window(cast[ptr Device00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_device_get_window_at_position*(self: ptr Device00; winX: var int32; winY: var int32): ptr Window00 {.
    importc: "gdk_device_get_window_at_position", libprag.}

proc getWindowAtPosition*(self: Device; winX: var int; winY: var int): Window =
  var winX_00 = int32(winX)
  var winY_00 = int32(winY)
  let gobj = gdk_device_get_window_at_position(cast[ptr Device00](self.impl), winX_00, winY_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  winX = int(winX_00)
  winY = int(winY_00)

proc windowAtPosition*(self: Device; winX: var int; winY: var int): Window =
  var winX_00 = int32(winX)
  var winY_00 = int32(winY)
  let gobj = gdk_device_get_window_at_position(cast[ptr Device00](self.impl), winX_00, winY_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  winX = int(winX_00)
  winY = int(winY_00)

proc gdk_device_get_window_at_position_double*(self: ptr Device00; winX: var cdouble; winY: var cdouble): ptr Window00 {.
    importc: "gdk_device_get_window_at_position_double", libprag.}

proc getWindowAtPositionDouble*(self: Device; winX: var cdouble; winY: var cdouble): Window =
  let gobj = gdk_device_get_window_at_position_double(cast[ptr Device00](self.impl), winX, winY)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc windowAtPositionDouble*(self: Device; winX: var cdouble; winY: var cdouble): Window =
  let gobj = gdk_device_get_window_at_position_double(cast[ptr Device00](self.impl), winX, winY)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_default_group*(self: ptr Display00): ptr Window00 {.
    importc: "gdk_display_get_default_group", libprag.}

proc getDefaultGroup*(self: Display): Window =
  let gobj = gdk_display_get_default_group(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc defaultGroup*(self: Display): Window =
  let gobj = gdk_display_get_default_group(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_monitor_at_window*(self: ptr Display00; window: ptr Window00): ptr Monitor00 {.
    importc: "gdk_display_get_monitor_at_window", libprag.}

proc getMonitorAtWindow*(self: Display; window: Window): Monitor =
  let gobj = gdk_display_get_monitor_at_window(cast[ptr Display00](self.impl), cast[ptr Window00](window.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc monitorAtWindow*(self: Display; window: Window): Monitor =
  let gobj = gdk_display_get_monitor_at_window(cast[ptr Display00](self.impl), cast[ptr Window00](window.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Monitor](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_window_at_pointer*(self: ptr Display00; winX: var int32; winY: var int32): ptr Window00 {.
    importc: "gdk_display_get_window_at_pointer", libprag.}

proc getWindowAtPointer*(self: Display; winX: var int; winY: var int): Window =
  var winX_00 = int32(winX)
  var winY_00 = int32(winY)
  let gobj = gdk_display_get_window_at_pointer(cast[ptr Display00](self.impl), winX_00, winY_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  winX = int(winX_00)
  winY = int(winY_00)

proc windowAtPointer*(self: Display; winX: var int; winY: var int): Window =
  var winX_00 = int32(winX)
  var winY_00 = int32(winY)
  let gobj = gdk_display_get_window_at_pointer(cast[ptr Display00](self.impl), winX_00, winY_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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
  winX = int(winX_00)
  winY = int(winY_00)

proc gdk_display_store_clipboard*(self: ptr Display00; clipboardWindow: ptr Window00; 
    time: uint32; targets: ptr Atom00Array; nTargets: int32) {.
    importc: "gdk_display_store_clipboard", libprag.}

proc storeClipboard*(self: Display; clipboardWindow: Window; time: int; 
    targets: ptr Atom00Array; nTargets: int) =
  gdk_display_store_clipboard(cast[ptr Display00](self.impl), cast[ptr Window00](clipboardWindow.impl), uint32(time), targets, int32(nTargets))

type
  GrabOwnership* {.size: sizeof(cint), pure.} = enum
    none = 0
    window = 1
    application = 2

type
  WindowWindowClass* {.size: sizeof(cint), pure.} = enum
    inputOutput = 0
    inputOnly = 1

type
  WindowEdge* {.size: sizeof(cint), pure.} = enum
    northWest = 0
    north = 1
    northEast = 2
    west = 3
    east = 4
    southWest = 5
    south = 6
    southEast = 7

proc gdk_window_begin_resize_drag*(self: ptr Window00; edge: WindowEdge; button: int32; 
    rootX: int32; rootY: int32; timestamp: uint32) {.
    importc: "gdk_window_begin_resize_drag", libprag.}

proc beginResizeDrag*(self: Window; edge: WindowEdge; button: int; rootX: int; 
    rootY: int; timestamp: int) =
  gdk_window_begin_resize_drag(cast[ptr Window00](self.impl), edge, int32(button), int32(rootX), int32(rootY), uint32(timestamp))

proc gdk_window_begin_resize_drag_for_device*(self: ptr Window00; edge: WindowEdge; device: ptr Device00; 
    button: int32; rootX: int32; rootY: int32; timestamp: uint32) {.
    importc: "gdk_window_begin_resize_drag_for_device", libprag.}

proc beginResizeDragForDevice*(self: Window; edge: WindowEdge; device: Device; button: int; 
    rootX: int; rootY: int; timestamp: int) =
  gdk_window_begin_resize_drag_for_device(cast[ptr Window00](self.impl), edge, cast[ptr Device00](device.impl), int32(button), int32(rootX), int32(rootY), uint32(timestamp))

type
  GLContext* = ref object of gobject.Object
  GLContext00* = object of gobject.Object00

proc gdk_gl_context_clear_current*() {.
    importc: "gdk_gl_context_clear_current", libprag.}

proc clearCurrent*() {.
    importc: "gdk_gl_context_clear_current", libprag.}

proc gdk_gl_context_get_current*(): ptr GLContext00 {.
    importc: "gdk_gl_context_get_current", libprag.}

proc getCurrent*(): GLContext =
  let gobj = gdk_gl_context_get_current()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[GLContext](g_object_get_qdata(gobj, Quark))
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

proc current*(): GLContext =
  let gobj = gdk_gl_context_get_current()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[GLContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_gl_context_get_debug_enabled*(self: ptr GLContext00): gboolean {.
    importc: "gdk_gl_context_get_debug_enabled", libprag.}

proc getDebugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc debugEnabled*(self: GLContext): bool =
  toBool(gdk_gl_context_get_debug_enabled(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_display*(self: ptr GLContext00): ptr Display00 {.
    importc: "gdk_gl_context_get_display", libprag.}

proc getDisplay*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: GLContext): Display =
  let gobj = gdk_gl_context_get_display(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_gl_context_get_forward_compatible*(self: ptr GLContext00): gboolean {.
    importc: "gdk_gl_context_get_forward_compatible", libprag.}

proc getForwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc forwardCompatible*(self: GLContext): bool =
  toBool(gdk_gl_context_get_forward_compatible(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_required_version*(self: ptr GLContext00; major: var int32; minor: var int32) {.
    importc: "gdk_gl_context_get_required_version", libprag.}

proc getRequiredVersion*(self: GLContext; major: var int; minor: var int) =
  var minor_00 = int32(minor)
  var major_00 = int32(major)
  gdk_gl_context_get_required_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  minor = int(minor_00)
  major = int(major_00)

proc requiredVersion*(self: GLContext; major: var int; minor: var int) =
  var minor_00 = int32(minor)
  var major_00 = int32(major)
  gdk_gl_context_get_required_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  minor = int(minor_00)
  major = int(major_00)

proc gdk_gl_context_get_shared_context*(self: ptr GLContext00): ptr GLContext00 {.
    importc: "gdk_gl_context_get_shared_context", libprag.}

proc getSharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[GLContext](g_object_get_qdata(gobj, Quark))
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

proc sharedContext*(self: GLContext): GLContext =
  let gobj = gdk_gl_context_get_shared_context(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[GLContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_gl_context_get_use_es*(self: ptr GLContext00): gboolean {.
    importc: "gdk_gl_context_get_use_es", libprag.}

proc getUseEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc useEs*(self: GLContext): bool =
  toBool(gdk_gl_context_get_use_es(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_get_version*(self: ptr GLContext00; major: var int32; minor: var int32) {.
    importc: "gdk_gl_context_get_version", libprag.}

proc getVersion*(self: GLContext; major: var int; minor: var int) =
  var minor_00 = int32(minor)
  var major_00 = int32(major)
  gdk_gl_context_get_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  minor = int(minor_00)
  major = int(major_00)

proc version*(self: GLContext; major: var int; minor: var int) =
  var minor_00 = int32(minor)
  var major_00 = int32(major)
  gdk_gl_context_get_version(cast[ptr GLContext00](self.impl), major_00, minor_00)
  minor = int(minor_00)
  major = int(major_00)

proc gdk_gl_context_get_window*(self: ptr GLContext00): ptr Window00 {.
    importc: "gdk_gl_context_get_window", libprag.}

proc getWindow*(self: GLContext): Window =
  let gobj = gdk_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc window*(self: GLContext): Window =
  let gobj = gdk_gl_context_get_window(cast[ptr GLContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_gl_context_is_legacy*(self: ptr GLContext00): gboolean {.
    importc: "gdk_gl_context_is_legacy", libprag.}

proc isLegacy*(self: GLContext): bool =
  toBool(gdk_gl_context_is_legacy(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_make_current*(self: ptr GLContext00) {.
    importc: "gdk_gl_context_make_current", libprag.}

proc makeCurrent*(self: GLContext) =
  gdk_gl_context_make_current(cast[ptr GLContext00](self.impl))

proc gdk_gl_context_realize*(self: ptr GLContext00): gboolean {.
    importc: "gdk_gl_context_realize", libprag.}

proc realize*(self: GLContext): bool =
  toBool(gdk_gl_context_realize(cast[ptr GLContext00](self.impl)))

proc gdk_gl_context_set_debug_enabled*(self: ptr GLContext00; enabled: gboolean) {.
    importc: "gdk_gl_context_set_debug_enabled", libprag.}

proc setDebugEnabled*(self: GLContext; enabled: bool) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc `debugEnabled=`*(self: GLContext; enabled: bool) =
  gdk_gl_context_set_debug_enabled(cast[ptr GLContext00](self.impl), gboolean(enabled))

proc gdk_gl_context_set_forward_compatible*(self: ptr GLContext00; compatible: gboolean) {.
    importc: "gdk_gl_context_set_forward_compatible", libprag.}

proc setForwardCompatible*(self: GLContext; compatible: bool) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc `forwardCompatible=`*(self: GLContext; compatible: bool) =
  gdk_gl_context_set_forward_compatible(cast[ptr GLContext00](self.impl), gboolean(compatible))

proc gdk_gl_context_set_required_version*(self: ptr GLContext00; major: int32; minor: int32) {.
    importc: "gdk_gl_context_set_required_version", libprag.}

proc setRequiredVersion*(self: GLContext; major: int; minor: int) =
  gdk_gl_context_set_required_version(cast[ptr GLContext00](self.impl), int32(major), int32(minor))

proc gdk_gl_context_set_use_es*(self: ptr GLContext00; useEs: int32) {.
    importc: "gdk_gl_context_set_use_es", libprag.}

proc setUseEs*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc `useEs=`*(self: GLContext; useEs: int) =
  gdk_gl_context_set_use_es(cast[ptr GLContext00](self.impl), int32(useEs))

proc gdk_window_create_gl_context*(self: ptr Window00): ptr GLContext00 {.
    importc: "gdk_window_create_gl_context", libprag.}

proc createGlContext*(self: Window): GLContext =
  let gobj = gdk_window_create_gl_context(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[GLContext](g_object_get_qdata(gobj, Quark))
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
  DrawingContext* = ref object of gobject.Object
  DrawingContext00* = object of gobject.Object00

proc gdk_drawing_context_get_cairo_context*(self: ptr DrawingContext00): ptr cairo.Context00 {.
    importc: "gdk_drawing_context_get_cairo_context", libprag.}

proc getCairoContext*(self: DrawingContext): cairo.Context =
  new(result)
  result.impl = gdk_drawing_context_get_cairo_context(cast[ptr DrawingContext00](self.impl))

proc cairoContext*(self: DrawingContext): cairo.Context =
  new(result)
  result.impl = gdk_drawing_context_get_cairo_context(cast[ptr DrawingContext00](self.impl))

proc gdk_drawing_context_get_clip*(self: ptr DrawingContext00): ptr cairo.Region00 {.
    importc: "gdk_drawing_context_get_clip", libprag.}

proc getClip*(self: DrawingContext): cairo.Region =
  new(result)
  result.impl = gdk_drawing_context_get_clip(cast[ptr DrawingContext00](self.impl))

proc clip*(self: DrawingContext): cairo.Region =
  new(result)
  result.impl = gdk_drawing_context_get_clip(cast[ptr DrawingContext00](self.impl))

proc gdk_drawing_context_get_window*(self: ptr DrawingContext00): ptr Window00 {.
    importc: "gdk_drawing_context_get_window", libprag.}

proc getWindow*(self: DrawingContext): Window =
  let gobj = gdk_drawing_context_get_window(cast[ptr DrawingContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc window*(self: DrawingContext): Window =
  let gobj = gdk_drawing_context_get_window(cast[ptr DrawingContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_drawing_context_is_valid*(self: ptr DrawingContext00): gboolean {.
    importc: "gdk_drawing_context_is_valid", libprag.}

proc isValid*(self: DrawingContext): bool =
  toBool(gdk_drawing_context_is_valid(cast[ptr DrawingContext00](self.impl)))

proc gdk_window_begin_draw_frame*(self: ptr Window00; region: ptr cairo.Region00): ptr DrawingContext00 {.
    importc: "gdk_window_begin_draw_frame", libprag.}

proc beginDrawFrame*(self: Window; region: cairo.Region): DrawingContext =
  let gobj = gdk_window_begin_draw_frame(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DrawingContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_end_draw_frame*(self: ptr Window00; context: ptr DrawingContext00) {.
    importc: "gdk_window_end_draw_frame", libprag.}

proc endDrawFrame*(self: Window; context: DrawingContext) =
  gdk_window_end_draw_frame(cast[ptr Window00](self.impl), cast[ptr DrawingContext00](context.impl))

type
  DragProtocol* {.size: sizeof(cint), pure.} = enum
    none = 0
    motif = 1
    xdnd = 2
    rootwin = 3
    win32Dropfiles = 4
    ole2 = 5
    local = 6
    wayland = 7

proc gdk_window_get_drag_protocol*(self: ptr Window00; target: var ptr Window00): DragProtocol {.
    importc: "gdk_window_get_drag_protocol", libprag.}

proc getDragProtocol*(self: ptr Window00; target: var ptr Window00): DragProtocol {.
    importc: "gdk_window_get_drag_protocol", libprag.}

proc dragProtocol*(self: ptr Window00; target: var ptr Window00): DragProtocol {.
    importc: "gdk_window_get_drag_protocol", libprag.}

type
  FrameClock* = ref object of gobject.Object
  FrameClock00* = object of gobject.Object00

proc scAfterPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "after-paint", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scBeforePaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "before-paint", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scFlushEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "flush-events", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scLayout*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "layout", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scPaint*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "paint", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scResumeEvents*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "resume-events", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scUpdate*(self: FrameClock;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "update", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_frame_clock_begin_updating*(self: ptr FrameClock00) {.
    importc: "gdk_frame_clock_begin_updating", libprag.}

proc beginUpdating*(self: FrameClock) =
  gdk_frame_clock_begin_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_end_updating*(self: ptr FrameClock00) {.
    importc: "gdk_frame_clock_end_updating", libprag.}

proc endUpdating*(self: FrameClock) =
  gdk_frame_clock_end_updating(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_counter*(self: ptr FrameClock00): int64 {.
    importc: "gdk_frame_clock_get_frame_counter", libprag.}

proc getFrameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc frameCounter*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_counter(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_frame_time*(self: ptr FrameClock00): int64 {.
    importc: "gdk_frame_clock_get_frame_time", libprag.}

proc getFrameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc frameTime*(self: FrameClock): int64 =
  gdk_frame_clock_get_frame_time(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_history_start*(self: ptr FrameClock00): int64 {.
    importc: "gdk_frame_clock_get_history_start", libprag.}

proc getHistoryStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc historyStart*(self: FrameClock): int64 =
  gdk_frame_clock_get_history_start(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_refresh_info*(self: ptr FrameClock00; baseTime: int64; refreshIntervalReturn: ptr int64; 
    presentationTimeReturn: ptr int64) {.
    importc: "gdk_frame_clock_get_refresh_info", libprag.}

proc getRefreshInfo*(self: FrameClock; baseTime: int64; refreshIntervalReturn: ptr int64; 
    presentationTimeReturn: ptr int64) =
  gdk_frame_clock_get_refresh_info(cast[ptr FrameClock00](self.impl), baseTime, refreshIntervalReturn, presentationTimeReturn)

proc refreshInfo*(self: FrameClock; baseTime: int64; refreshIntervalReturn: ptr int64; 
    presentationTimeReturn: ptr int64) =
  gdk_frame_clock_get_refresh_info(cast[ptr FrameClock00](self.impl), baseTime, refreshIntervalReturn, presentationTimeReturn)

proc gdk_window_get_frame_clock*(self: ptr Window00): ptr FrameClock00 {.
    importc: "gdk_window_get_frame_clock", libprag.}

proc getFrameClock*(self: Window): FrameClock =
  let gobj = gdk_window_get_frame_clock(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FrameClock](g_object_get_qdata(gobj, Quark))
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

proc frameClock*(self: Window): FrameClock =
  let gobj = gdk_window_get_frame_clock(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FrameClock](g_object_get_qdata(gobj, Quark))
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
  FrameTimings00* {.pure.} = object
  FrameTimings* = ref object
    impl*: ptr FrameTimings00

proc gdk_frame_timings_get_complete*(self: ptr FrameTimings00): gboolean {.
    importc: "gdk_frame_timings_get_complete", libprag.}

proc getComplete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc complete*(self: FrameTimings): bool =
  toBool(gdk_frame_timings_get_complete(cast[ptr FrameTimings00](self.impl)))

proc gdk_frame_timings_get_frame_counter*(self: ptr FrameTimings00): int64 {.
    importc: "gdk_frame_timings_get_frame_counter", libprag.}

proc getFrameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc frameCounter*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_counter(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_frame_time*(self: ptr FrameTimings00): int64 {.
    importc: "gdk_frame_timings_get_frame_time", libprag.}

proc getFrameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc frameTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_frame_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_predicted_presentation_time*(self: ptr FrameTimings00): int64 {.
    importc: "gdk_frame_timings_get_predicted_presentation_time", libprag.}

proc getPredictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc predictedPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_predicted_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_presentation_time*(self: ptr FrameTimings00): int64 {.
    importc: "gdk_frame_timings_get_presentation_time", libprag.}

proc getPresentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc presentationTime*(self: FrameTimings): int64 =
  gdk_frame_timings_get_presentation_time(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_get_refresh_interval*(self: ptr FrameTimings00): int64 {.
    importc: "gdk_frame_timings_get_refresh_interval", libprag.}

proc getRefreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc refreshInterval*(self: FrameTimings): int64 =
  gdk_frame_timings_get_refresh_interval(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_ref*(self: ptr FrameTimings00): ptr FrameTimings00 {.
    importc: "gdk_frame_timings_ref", libprag.}

proc `ref`*(self: FrameTimings): FrameTimings =
  new(result)
  result.impl = gdk_frame_timings_ref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_timings_unref*(self: ptr FrameTimings00) {.
    importc: "gdk_frame_timings_unref", libprag.}

proc unref*(self: FrameTimings) =
  gdk_frame_timings_unref(cast[ptr FrameTimings00](self.impl))

proc gdk_frame_clock_get_current_timings*(self: ptr FrameClock00): ptr FrameTimings00 {.
    importc: "gdk_frame_clock_get_current_timings", libprag.}

proc getCurrentTimings*(self: FrameClock): FrameTimings =
  new(result)
  result.impl = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))

proc currentTimings*(self: FrameClock): FrameTimings =
  new(result)
  result.impl = gdk_frame_clock_get_current_timings(cast[ptr FrameClock00](self.impl))

proc gdk_frame_clock_get_timings*(self: ptr FrameClock00; frameCounter: int64): ptr FrameTimings00 {.
    importc: "gdk_frame_clock_get_timings", libprag.}

proc getTimings*(self: FrameClock; frameCounter: int64): FrameTimings =
  new(result)
  result.impl = gdk_frame_clock_get_timings(cast[ptr FrameClock00](self.impl), frameCounter)

proc timings*(self: FrameClock; frameCounter: int64): FrameTimings =
  new(result)
  result.impl = gdk_frame_clock_get_timings(cast[ptr FrameClock00](self.impl), frameCounter)

type
  FrameClockPhase* {.size: sizeof(cint), pure.} = enum
    none = 0
    flushEvents = 1
    beforePaint = 2
    update = 4
    layout = 8
    paint = 16
    resumeEvents = 32
    afterPaint = 64

proc gdk_frame_clock_request_phase*(self: ptr FrameClock00; phase: FrameClockPhase) {.
    importc: "gdk_frame_clock_request_phase", libprag.}

proc requestPhase*(self: FrameClock; phase: FrameClockPhase) =
  gdk_frame_clock_request_phase(cast[ptr FrameClock00](self.impl), phase)

type
  WindowState* {.size: sizeof(cint), pure.} = enum
    withdrawn = 1
    iconified = 2
    maximized = 4
    sticky = 8
    fullscreen = 16
    above = 32
    below = 64
    focused = 128
    tiled = 256

proc gdk_window_get_state*(self: ptr Window00): WindowState {.
    importc: "gdk_window_get_state", libprag.}

proc getState*(self: Window): WindowState =
  gdk_window_get_state(cast[ptr Window00](self.impl))

proc state*(self: Window): WindowState =
  gdk_window_get_state(cast[ptr Window00](self.impl))

type
  Visual* = ref object of gobject.Object
  Visual00* = object of gobject.Object00

proc gdk_visual_get_best*(): ptr Visual00 {.
    importc: "gdk_visual_get_best", libprag.}

proc getBest*(): Visual =
  let gobj = gdk_visual_get_best()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc best*(): Visual =
  let gobj = gdk_visual_get_best()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_best_depth*(): int32 {.
    importc: "gdk_visual_get_best_depth", libprag.}

proc getBestDepth*(): int32 {.
    importc: "gdk_visual_get_best_depth", libprag.}

proc bestDepth*(): int32 {.
    importc: "gdk_visual_get_best_depth", libprag.}

proc gdk_visual_get_best_with_depth*(depth: int32): ptr Visual00 {.
    importc: "gdk_visual_get_best_with_depth", libprag.}

proc getBestWithDepth*(depth: int): Visual =
  let gobj = gdk_visual_get_best_with_depth(int32(depth))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc bestWithDepth*(depth: int): Visual =
  let gobj = gdk_visual_get_best_with_depth(int32(depth))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_system*(): ptr Visual00 {.
    importc: "gdk_visual_get_system", libprag.}

proc getSystem*(): Visual =
  let gobj = gdk_visual_get_system()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc system*(): Visual =
  let gobj = gdk_visual_get_system()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_bits_per_rgb*(self: ptr Visual00): int32 {.
    importc: "gdk_visual_get_bits_per_rgb", libprag.}

proc getBitsPerRgb*(self: Visual): int =
  int(gdk_visual_get_bits_per_rgb(cast[ptr Visual00](self.impl)))

proc bitsPerRgb*(self: Visual): int =
  int(gdk_visual_get_bits_per_rgb(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_blue_pixel_details*(self: ptr Visual00; mask: var uint32; shift: var int32; 
    precision: var int32) {.
    importc: "gdk_visual_get_blue_pixel_details", libprag.}

proc getBluePixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_blue_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc bluePixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_blue_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc gdk_visual_get_colormap_size*(self: ptr Visual00): int32 {.
    importc: "gdk_visual_get_colormap_size", libprag.}

proc getColormapSize*(self: Visual): int =
  int(gdk_visual_get_colormap_size(cast[ptr Visual00](self.impl)))

proc colormapSize*(self: Visual): int =
  int(gdk_visual_get_colormap_size(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_depth*(self: ptr Visual00): int32 {.
    importc: "gdk_visual_get_depth", libprag.}

proc getDepth*(self: Visual): int =
  int(gdk_visual_get_depth(cast[ptr Visual00](self.impl)))

proc depth*(self: Visual): int =
  int(gdk_visual_get_depth(cast[ptr Visual00](self.impl)))

proc gdk_visual_get_green_pixel_details*(self: ptr Visual00; mask: var uint32; shift: var int32; 
    precision: var int32) {.
    importc: "gdk_visual_get_green_pixel_details", libprag.}

proc getGreenPixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_green_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc greenPixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_green_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc gdk_visual_get_red_pixel_details*(self: ptr Visual00; mask: var uint32; shift: var int32; 
    precision: var int32) {.
    importc: "gdk_visual_get_red_pixel_details", libprag.}

proc getRedPixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_red_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc redPixelDetails*(self: Visual; mask: var int; shift: var int; precision: var int) =
  var precision_00 = int32(precision)
  var mask_00 = uint32(mask)
  var shift_00 = int32(shift)
  gdk_visual_get_red_pixel_details(cast[ptr Visual00](self.impl), mask_00, shift_00, precision_00)
  precision = int(precision_00)
  mask = int(mask_00)
  shift = int(shift_00)

proc gdk_window_get_visual*(self: ptr Window00): ptr Visual00 {.
    importc: "gdk_window_get_visual", libprag.}

proc getVisual*(self: Window): Visual =
  let gobj = gdk_window_get_visual(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc visual*(self: Window): Visual =
  let gobj = gdk_window_get_visual(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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
  ByteOrder* {.size: sizeof(cint), pure.} = enum
    lsbFirst = 0
    msbFirst = 1

proc gdk_visual_get_byte_order*(self: ptr Visual00): ByteOrder {.
    importc: "gdk_visual_get_byte_order", libprag.}

proc getByteOrder*(self: Visual): ByteOrder =
  gdk_visual_get_byte_order(cast[ptr Visual00](self.impl))

proc byteOrder*(self: Visual): ByteOrder =
  gdk_visual_get_byte_order(cast[ptr Visual00](self.impl))

type
  VisualType* {.size: sizeof(cint), pure.} = enum
    staticGray = 0
    grayscale = 1
    staticColor = 2
    pseudoColor = 3
    trueColor = 4
    directColor = 5

proc gdk_visual_get_best_type*(): VisualType {.
    importc: "gdk_visual_get_best_type", libprag.}

proc getBestType*(): VisualType {.
    importc: "gdk_visual_get_best_type", libprag.}

proc bestType*(): VisualType {.
    importc: "gdk_visual_get_best_type", libprag.}

proc gdk_visual_get_best_with_both*(depth: int32; visualType: VisualType): ptr Visual00 {.
    importc: "gdk_visual_get_best_with_both", libprag.}

proc getBestWithBoth*(depth: int; visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_both(int32(depth), visualType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc bestWithBoth*(depth: int; visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_both(int32(depth), visualType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_best_with_type*(visualType: VisualType): ptr Visual00 {.
    importc: "gdk_visual_get_best_with_type", libprag.}

proc getBestWithType*(visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_type(visualType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc bestWithType*(visualType: VisualType): Visual =
  let gobj = gdk_visual_get_best_with_type(visualType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_visual_type*(self: ptr Visual00): VisualType {.
    importc: "gdk_visual_get_visual_type", libprag.}

proc getVisualType*(self: Visual): VisualType =
  gdk_visual_get_visual_type(cast[ptr Visual00](self.impl))

proc visualType*(self: Visual): VisualType =
  gdk_visual_get_visual_type(cast[ptr Visual00](self.impl))

type
  WindowType* {.size: sizeof(cint), pure.} = enum
    root = 0
    toplevel = 1
    child = 2
    temp = 3
    foreign = 4
    offscreen = 5
    subsurface = 6

proc gdk_window_get_window_type*(self: ptr Window00): WindowType {.
    importc: "gdk_window_get_window_type", libprag.}

proc getWindowType*(self: Window): WindowType =
  gdk_window_get_window_type(cast[ptr Window00](self.impl))

proc windowType*(self: Window): WindowType =
  gdk_window_get_window_type(cast[ptr Window00](self.impl))

type
  Color00* {.pure.} = object
    pixel*: uint32
    red*: uint16
    green*: uint16
    blue*: uint16
  Color* = ref object
    impl*: ptr Color00

proc gdk_color_copy*(self: ptr Color00): ptr Color00 {.
    importc: "gdk_color_copy", libprag.}

proc copy*(self: Color): Color =
  new(result)
  result.impl = gdk_color_copy(cast[ptr Color00](self.impl))

proc gdk_color_equal*(self: ptr Color00; colorb: ptr Color00): gboolean {.
    importc: "gdk_color_equal", libprag.}

proc equal*(self: Color; colorb: Color): bool =
  toBool(gdk_color_equal(cast[ptr Color00](self.impl), cast[ptr Color00](colorb.impl)))

proc gdk_color_free*(self: ptr Color00) {.
    importc: "gdk_color_free", libprag.}

proc free*(self: Color) =
  gdk_color_free(cast[ptr Color00](self.impl))

proc gdk_color_hash*(self: ptr Color00): uint32 {.
    importc: "gdk_color_hash", libprag.}

proc hash*(self: Color): int =
  int(gdk_color_hash(cast[ptr Color00](self.impl)))

proc gdk_color_to_string*(self: ptr Color00): cstring {.
    importc: "gdk_color_to_string", libprag.}

proc toString*(self: Color): string =
  let resul0 = gdk_color_to_string(cast[ptr Color00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_color_parse*(spec: cstring; color: var Color00): gboolean {.
    importc: "gdk_color_parse", libprag.}

proc parse*(spec: cstring; color: var Color00): gboolean {.
    importc: "gdk_color_parse", libprag.}

proc gdk_window_set_background*(self: ptr Window00; color: ptr Color00) {.
    importc: "gdk_window_set_background", libprag.}

proc setBackground*(self: Window; color: Color) =
  gdk_window_set_background(cast[ptr Window00](self.impl), cast[ptr Color00](color.impl))

proc `background=`*(self: Window; color: Color) =
  gdk_window_set_background(cast[ptr Window00](self.impl), cast[ptr Color00](color.impl))

type
  RGBA00* {.pure.} = object
    red*: cdouble
    green*: cdouble
    blue*: cdouble
    alpha*: cdouble
  RGBA* = ref object
    impl*: ptr RGBA00

proc gdk_rgba_copy*(self: ptr RGBA00): ptr RGBA00 {.
    importc: "gdk_rgba_copy", libprag.}

proc copy*(self: RGBA): RGBA =
  new(result)
  result.impl = gdk_rgba_copy(cast[ptr RGBA00](self.impl))

proc gdk_rgba_equal*(self: ptr RGBA00; p2: ptr RGBA00): gboolean {.
    importc: "gdk_rgba_equal", libprag.}

proc equal*(self: RGBA; p2: RGBA): bool =
  toBool(gdk_rgba_equal(cast[ptr RGBA00](self.impl), cast[ptr RGBA00](p2.impl)))

proc gdk_rgba_free*(self: ptr RGBA00) {.
    importc: "gdk_rgba_free", libprag.}

proc free*(self: RGBA) =
  gdk_rgba_free(cast[ptr RGBA00](self.impl))

proc gdk_rgba_hash*(self: ptr RGBA00): uint32 {.
    importc: "gdk_rgba_hash", libprag.}

proc hash*(self: RGBA): int =
  int(gdk_rgba_hash(cast[ptr RGBA00](self.impl)))

proc gdk_rgba_parse*(self: ptr RGBA00; spec: cstring): gboolean {.
    importc: "gdk_rgba_parse", libprag.}

proc parse*(self: RGBA; spec: string): bool =
  toBool(gdk_rgba_parse(cast[ptr RGBA00](self.impl), cstring(spec)))

proc gdk_rgba_to_string*(self: ptr RGBA00): cstring {.
    importc: "gdk_rgba_to_string", libprag.}

proc toString*(self: RGBA): string =
  let resul0 = gdk_rgba_to_string(cast[ptr RGBA00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_window_set_background_rgba*(self: ptr Window00; rgba: ptr RGBA00) {.
    importc: "gdk_window_set_background_rgba", libprag.}

proc setBackgroundRgba*(self: Window; rgba: RGBA) =
  gdk_window_set_background_rgba(cast[ptr Window00](self.impl), cast[ptr RGBA00](rgba.impl))

proc `backgroundRgba=`*(self: Window; rgba: RGBA) =
  gdk_window_set_background_rgba(cast[ptr Window00](self.impl), cast[ptr RGBA00](rgba.impl))

type
  WMDecoration* {.size: sizeof(cint), pure.} = enum
    all = 1
    border = 2
    resizeh = 4
    title = 8
    menu = 16
    minimize = 32
    maximize = 64

proc gdk_window_get_decorations*(self: ptr Window00; decorations: var WMDecoration): gboolean {.
    importc: "gdk_window_get_decorations", libprag.}

proc getDecorations*(self: Window; decorations: var WMDecoration): bool =
  toBool(gdk_window_get_decorations(cast[ptr Window00](self.impl), decorations))

proc decorations*(self: Window; decorations: var WMDecoration): bool =
  toBool(gdk_window_get_decorations(cast[ptr Window00](self.impl), decorations))

proc gdk_window_set_decorations*(self: ptr Window00; decorations: WMDecoration) {.
    importc: "gdk_window_set_decorations", libprag.}

proc setDecorations*(self: Window; decorations: WMDecoration) =
  gdk_window_set_decorations(cast[ptr Window00](self.impl), decorations)

proc `decorations=`*(self: Window; decorations: WMDecoration) =
  gdk_window_set_decorations(cast[ptr Window00](self.impl), decorations)

type
  Cursor* = ref object of gobject.Object
  Cursor00* = object of gobject.Object00

proc gdk_cursor_new_from_name*(display: ptr Display00; name: cstring): ptr Cursor00 {.
    importc: "gdk_cursor_new_from_name", libprag.}

proc newCursorFromName*(display: Display; name: string): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), cstring(name))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCursorFromName*[T](result: var T; display: Display; name: string) =
  assert(result is Cursor)
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_name(cast[ptr Display00](display.impl), cstring(name))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_new_from_pixbuf*(display: ptr Display00; pixbuf: ptr gdkpixbuf.Pixbuf00; 
    x: int32; y: int32): ptr Cursor00 {.
    importc: "gdk_cursor_new_from_pixbuf", libprag.}

proc newCursorFromPixbuf*(display: Display; pixbuf: gdkpixbuf.Pixbuf; x: int; 
    y: int): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_pixbuf(cast[ptr Display00](display.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(x), int32(y))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCursorFromPixbuf*[T](result: var T; display: Display; pixbuf: gdkpixbuf.Pixbuf; x: int; 
    y: int) =
  assert(result is Cursor)
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_pixbuf(cast[ptr Display00](display.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(x), int32(y))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_new_from_surface*(display: ptr Display00; surface: ptr cairo.Surface00; 
    x: cdouble; y: cdouble): ptr Cursor00 {.
    importc: "gdk_cursor_new_from_surface", libprag.}

proc newCursorFromSurface*(display: Display; surface: cairo.Surface; x: cdouble; 
    y: cdouble): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_surface(cast[ptr Display00](display.impl), cast[ptr cairo.Surface00](surface.impl), x, y)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCursorFromSurface*[T](result: var T; display: Display; surface: cairo.Surface; x: cdouble; 
    y: cdouble) =
  assert(result is Cursor)
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_from_surface(cast[ptr Display00](display.impl), cast[ptr cairo.Surface00](surface.impl), x, y)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_get_display*(self: ptr Cursor00): ptr Display00 {.
    importc: "gdk_cursor_get_display", libprag.}

proc getDisplay*(self: Cursor): Display =
  let gobj = gdk_cursor_get_display(cast[ptr Cursor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Cursor): Display =
  let gobj = gdk_cursor_get_display(cast[ptr Cursor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_cursor_get_image*(self: ptr Cursor00): ptr gdkpixbuf.Pixbuf00 {.
    importc: "gdk_cursor_get_image", libprag.}

proc getImage*(self: Cursor): gdkpixbuf.Pixbuf =
  let gobj = gdk_cursor_get_image(cast[ptr Cursor00](self.impl))
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

proc image*(self: Cursor): gdkpixbuf.Pixbuf =
  let gobj = gdk_cursor_get_image(cast[ptr Cursor00](self.impl))
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

proc gdk_cursor_get_surface*(self: ptr Cursor00; xHot: var cdouble; yHot: var cdouble): ptr cairo.Surface00 {.
    importc: "gdk_cursor_get_surface", libprag.}

proc getSurface*(self: Cursor; xHot: var cdouble; yHot: var cdouble): cairo.Surface =
  new(result)
  result.impl = gdk_cursor_get_surface(cast[ptr Cursor00](self.impl), xHot, yHot)

proc surface*(self: Cursor; xHot: var cdouble; yHot: var cdouble): cairo.Surface =
  new(result)
  result.impl = gdk_cursor_get_surface(cast[ptr Cursor00](self.impl), xHot, yHot)

proc gdk_cursor_ref*(self: ptr Cursor00): ptr Cursor00 {.
    importc: "gdk_cursor_ref", libprag.}

proc `ref`*(self: Cursor): Cursor =
  let gobj = gdk_cursor_ref(cast[ptr Cursor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cursor](g_object_get_qdata(gobj, Quark))
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

proc gdk_cursor_unref*(self: ptr Cursor00) {.
    importc: "gdk_cursor_unref", libprag.}

proc unref*(self: Cursor) =
  gdk_cursor_unref(cast[ptr Cursor00](self.impl))

proc gdk_window_get_cursor*(self: ptr Window00): ptr Cursor00 {.
    importc: "gdk_window_get_cursor", libprag.}

proc getCursor*(self: Window): Cursor =
  let gobj = gdk_window_get_cursor(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cursor](g_object_get_qdata(gobj, Quark))
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

proc cursor*(self: Window): Cursor =
  let gobj = gdk_window_get_cursor(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cursor](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_get_device_cursor*(self: ptr Window00; device: ptr Device00): ptr Cursor00 {.
    importc: "gdk_window_get_device_cursor", libprag.}

proc getDeviceCursor*(self: Window; device: Device): Cursor =
  let gobj = gdk_window_get_device_cursor(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cursor](g_object_get_qdata(gobj, Quark))
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

proc deviceCursor*(self: Window; device: Device): Cursor =
  let gobj = gdk_window_get_device_cursor(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cursor](g_object_get_qdata(gobj, Quark))
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

proc gdk_window_set_cursor*(self: ptr Window00; cursor: ptr Cursor00) {.
    importc: "gdk_window_set_cursor", libprag.}

proc setCursor*(self: Window; cursor: Cursor) =
  gdk_window_set_cursor(cast[ptr Window00](self.impl), cast[ptr Cursor00](cursor.impl))

proc `cursor=`*(self: Window; cursor: Cursor) =
  gdk_window_set_cursor(cast[ptr Window00](self.impl), cast[ptr Cursor00](cursor.impl))

proc gdk_window_set_device_cursor*(self: ptr Window00; device: ptr Device00; cursor: ptr Cursor00) {.
    importc: "gdk_window_set_device_cursor", libprag.}

proc setDeviceCursor*(self: Window; device: Device; cursor: Cursor) =
  gdk_window_set_device_cursor(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), cast[ptr Cursor00](cursor.impl))

type
  CursorType* {.size: sizeof(cint), pure.} = enum
    blankCursor = -2
    cursorIsPixmap = -1
    xCursor = 0
    arrow = 2
    basedArrowDown = 4
    basedArrowUp = 6
    boat = 8
    bogosity = 10
    bottomLeftCorner = 12
    bottomRightCorner = 14
    bottomSide = 16
    bottomTee = 18
    boxSpiral = 20
    centerPtr = 22
    circle = 24
    clock = 26
    coffeeMug = 28
    cross = 30
    crossReverse = 32
    crosshair = 34
    diamondCross = 36
    dot = 38
    dotbox = 40
    doubleArrow = 42
    draftLarge = 44
    draftSmall = 46
    drapedBox = 48
    exchange = 50
    fleur = 52
    gobbler = 54
    gumby = 56
    hand1 = 58
    hand2 = 60
    heart = 62
    icon = 64
    ironCross = 66
    leftPtr = 68
    leftSide = 70
    leftTee = 72
    leftbutton = 74
    llAngle = 76
    lrAngle = 78
    man = 80
    middlebutton = 82
    mouse = 84
    pencil = 86
    pirate = 88
    plus = 90
    questionArrow = 92
    rightPtr = 94
    rightSide = 96
    rightTee = 98
    rightbutton = 100
    rtlLogo = 102
    sailboat = 104
    sbDownArrow = 106
    sbHDoubleArrow = 108
    sbLeftArrow = 110
    sbRightArrow = 112
    sbUpArrow = 114
    sbVDoubleArrow = 116
    shuttle = 118
    sizing = 120
    spider = 122
    spraycan = 124
    star = 126
    target = 128
    tcross = 130
    topLeftArrow = 132
    topLeftCorner = 134
    topRightCorner = 136
    topSide = 138
    topTee = 140
    trek = 142
    ulAngle = 144
    umbrella = 146
    urAngle = 148
    watch = 150
    xterm = 152
    lastCursor = 153

proc gdk_cursor_new*(cursorType: CursorType): ptr Cursor00 {.
    importc: "gdk_cursor_new", libprag.}

proc newCursor*(cursorType: CursorType): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new(cursorType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCursor*[T](result: var T; cursorType: CursorType) =
  assert(result is Cursor)
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new(cursorType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_new_for_display*(display: ptr Display00; cursorType: CursorType): ptr Cursor00 {.
    importc: "gdk_cursor_new_for_display", libprag.}

proc newCursorForDisplay*(display: Display; cursorType: CursorType): Cursor =
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_for_display(cast[ptr Display00](display.impl), cursorType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCursorForDisplay*[T](result: var T; display: Display; cursorType: CursorType) =
  assert(result is Cursor)
  new(result, finalizeGObject)
  result.impl = gdk_cursor_new_for_display(cast[ptr Display00](display.impl), cursorType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc gdk_cursor_get_cursor_type*(self: ptr Cursor00): CursorType {.
    importc: "gdk_cursor_get_cursor_type", libprag.}

proc getCursorType*(self: Cursor): CursorType =
  gdk_cursor_get_cursor_type(cast[ptr Cursor00](self.impl))

proc cursorType*(self: Cursor): CursorType =
  gdk_cursor_get_cursor_type(cast[ptr Cursor00](self.impl))

type
  FullscreenMode* {.size: sizeof(cint), pure.} = enum
    currentMonitor = 0
    allMonitors = 1

proc gdk_window_get_fullscreen_mode*(self: ptr Window00): FullscreenMode {.
    importc: "gdk_window_get_fullscreen_mode", libprag.}

proc getFullscreenMode*(self: Window): FullscreenMode =
  gdk_window_get_fullscreen_mode(cast[ptr Window00](self.impl))

proc fullscreenMode*(self: Window): FullscreenMode =
  gdk_window_get_fullscreen_mode(cast[ptr Window00](self.impl))

proc gdk_window_set_fullscreen_mode*(self: ptr Window00; mode: FullscreenMode) {.
    importc: "gdk_window_set_fullscreen_mode", libprag.}

proc setFullscreenMode*(self: Window; mode: FullscreenMode) =
  gdk_window_set_fullscreen_mode(cast[ptr Window00](self.impl), mode)

proc `fullscreenMode=`*(self: Window; mode: FullscreenMode) =
  gdk_window_set_fullscreen_mode(cast[ptr Window00](self.impl), mode)

type
  WMFunction* {.size: sizeof(cint), pure.} = enum
    all = 1
    resize = 2
    move = 4
    minimize = 8
    maximize = 16
    close = 32

proc gdk_window_set_functions*(self: ptr Window00; functions: WMFunction) {.
    importc: "gdk_window_set_functions", libprag.}

proc setFunctions*(self: Window; functions: WMFunction) =
  gdk_window_set_functions(cast[ptr Window00](self.impl), functions)

proc `functions=`*(self: Window; functions: WMFunction) =
  gdk_window_set_functions(cast[ptr Window00](self.impl), functions)

type
  Gravity* {.size: sizeof(cint), pure.} = enum
    northWest = 1
    north = 2
    northEast = 3
    west = 4
    center = 5
    east = 6
    southWest = 7
    south = 8
    southEast = 9
    `static` = 10

type
  Geometry00* {.pure.} = object
    minWidth*: int32
    minHeight*: int32
    maxWidth*: int32
    maxHeight*: int32
    baseWidth*: int32
    baseHeight*: int32
    widthInc*: int32
    heightInc*: int32
    minAspect*: cdouble
    maxAspect*: cdouble
    winGravity*: Gravity
  Geometry* = ref object
    impl*: ptr Geometry00

type
  WindowHints* {.size: sizeof(cint), pure.} = enum
    pos = 1
    minSize = 2
    maxSize = 4
    baseSize = 8
    aspect = 16
    resizeInc = 32
    winGravity = 64
    userPos = 128
    userSize = 256

proc gdk_window_constrain_size*(geometry: ptr Geometry00; flags: WindowHints; width: int32; 
    height: int32; newWidth: var int32; newHeight: var int32) {.
    importc: "gdk_window_constrain_size", libprag.}

proc constrainSize*(geometry: Geometry; flags: WindowHints; width: int; 
    height: int; newWidth: var int; newHeight: var int) =
  var newHeight_00 = int32(newHeight)
  var newWidth_00 = int32(newWidth)
  gdk_window_constrain_size(cast[ptr Geometry00](geometry.impl), flags, int32(width), int32(height), newWidth_00, newHeight_00)
  newHeight = int(newHeight_00)
  newWidth = int(newWidth_00)

proc gdk_window_set_geometry_hints*(self: ptr Window00; geometry: ptr Geometry00; geomMask: WindowHints) {.
    importc: "gdk_window_set_geometry_hints", libprag.}

proc setGeometryHints*(self: Window; geometry: Geometry; geomMask: WindowHints) =
  gdk_window_set_geometry_hints(cast[ptr Window00](self.impl), cast[ptr Geometry00](geometry.impl), geomMask)

type
  EventMask* {.size: sizeof(cint), pure.} = enum
    exposureMask = 2
    pointerMotionMask = 4
    pointerMotionHintMask = 8
    buttonMotionMask = 16
    button1MotionMask = 32
    button2MotionMask = 64
    button3MotionMask = 128
    buttonPressMask = 256
    buttonReleaseMask = 512
    keyPressMask = 1024
    keyReleaseMask = 2048
    enterNotifyMask = 4096
    leaveNotifyMask = 8192
    focusChangeMask = 16384
    structureMask = 32768
    propertyChangeMask = 65536
    visibilityNotifyMask = 131072
    proximityInMask = 262144
    proximityOutMask = 524288
    substructureMask = 1048576
    scrollMask = 2097152
    touchMask = 4194304
    smoothScrollMask = 8388608
    allEventsMask = 16777214
    touchpadGestureMask = 16777216
    tabletPadMask = 33554432

proc gdk_window_get_device_events*(self: ptr Window00; device: ptr Device00): EventMask {.
    importc: "gdk_window_get_device_events", libprag.}

proc getDeviceEvents*(self: Window; device: Device): EventMask =
  gdk_window_get_device_events(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))

proc deviceEvents*(self: Window; device: Device): EventMask =
  gdk_window_get_device_events(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl))

proc gdk_window_get_events*(self: ptr Window00): EventMask {.
    importc: "gdk_window_get_events", libprag.}

proc getEvents*(self: Window): EventMask =
  gdk_window_get_events(cast[ptr Window00](self.impl))

proc events*(self: Window): EventMask =
  gdk_window_get_events(cast[ptr Window00](self.impl))

proc gdk_window_get_source_events*(self: ptr Window00; source: InputSource): EventMask {.
    importc: "gdk_window_get_source_events", libprag.}

proc getSourceEvents*(self: Window; source: InputSource): EventMask =
  gdk_window_get_source_events(cast[ptr Window00](self.impl), source)

proc sourceEvents*(self: Window; source: InputSource): EventMask =
  gdk_window_get_source_events(cast[ptr Window00](self.impl), source)

proc gdk_window_set_device_events*(self: ptr Window00; device: ptr Device00; eventMask: EventMask) {.
    importc: "gdk_window_set_device_events", libprag.}

proc setDeviceEvents*(self: Window; device: Device; eventMask: EventMask) =
  gdk_window_set_device_events(cast[ptr Window00](self.impl), cast[ptr Device00](device.impl), eventMask)

proc gdk_window_set_events*(self: ptr Window00; eventMask: EventMask) {.
    importc: "gdk_window_set_events", libprag.}

proc setEvents*(self: Window; eventMask: EventMask) =
  gdk_window_set_events(cast[ptr Window00](self.impl), eventMask)

proc `events=`*(self: Window; eventMask: EventMask) =
  gdk_window_set_events(cast[ptr Window00](self.impl), eventMask)

proc gdk_window_set_source_events*(self: ptr Window00; source: InputSource; eventMask: EventMask) {.
    importc: "gdk_window_set_source_events", libprag.}

proc setSourceEvents*(self: Window; source: InputSource; eventMask: EventMask) =
  gdk_window_set_source_events(cast[ptr Window00](self.impl), source, eventMask)

type
  GrabStatus* {.size: sizeof(cint), pure.} = enum
    success = 0
    alreadyGrabbed = 1
    invalidTime = 2
    notViewable = 3
    frozen = 4
    failed = 5

proc gdk_device_grab*(self: ptr Device00; window: ptr Window00; grabOwnership: GrabOwnership; 
    ownerEvents: gboolean; eventMask: EventMask; cursor: ptr Cursor00; time: uint32): GrabStatus {.
    importc: "gdk_device_grab", libprag.}

proc grab*(self: Device; window: Window; grabOwnership: GrabOwnership; 
    ownerEvents: bool; eventMask: EventMask; cursor: Cursor; time: int): GrabStatus =
  gdk_device_grab(cast[ptr Device00](self.impl), cast[ptr Window00](window.impl), grabOwnership, gboolean(ownerEvents), eventMask, cast[ptr Cursor00](cursor.impl), uint32(time))

type
  WindowTypeHint* {.size: sizeof(cint), pure.} = enum
    normal = 0
    dialog = 1
    menu = 2
    toolbar = 3
    splashscreen = 4
    utility = 5
    dock = 6
    desktop = 7
    dropdownMenu = 8
    popupMenu = 9
    tooltip = 10
    notification = 11
    combo = 12
    dnd = 13

type
  WindowAttr00* {.pure.} = object
    title*: cstring
    eventMask*: int32
    x*: int32
    y*: int32
    width*: int32
    height*: int32
    wclass*: WindowWindowClass
    visual*: ptr Visual00
    windowType*: WindowType
    cursor*: ptr Cursor00
    wmclassName*: cstring
    wmclassClass*: cstring
    overrideRedirect*: gboolean
    typeHint*: WindowTypeHint
  WindowAttr* = ref object
    impl*: ptr WindowAttr00

proc gdk_window_get_type_hint*(self: ptr Window00): WindowTypeHint {.
    importc: "gdk_window_get_type_hint", libprag.}

proc getTypeHint*(self: Window): WindowTypeHint =
  gdk_window_get_type_hint(cast[ptr Window00](self.impl))

proc typeHint*(self: Window): WindowTypeHint =
  gdk_window_get_type_hint(cast[ptr Window00](self.impl))

proc gdk_window_set_type_hint*(self: ptr Window00; hint: WindowTypeHint) {.
    importc: "gdk_window_set_type_hint", libprag.}

proc setTypeHint*(self: Window; hint: WindowTypeHint) =
  gdk_window_set_type_hint(cast[ptr Window00](self.impl), hint)

proc `typeHint=`*(self: Window; hint: WindowTypeHint) =
  gdk_window_set_type_hint(cast[ptr Window00](self.impl), hint)

type
  WindowAttributesType* {.size: sizeof(cint), pure.} = enum
    title = 2
    x = 4
    y = 8
    cursor = 16
    visual = 32
    wmclass = 64
    noredir = 128
    typeHint = 256

proc gdk_window_new*(parent: ptr Window00; attributes: ptr WindowAttr00; 
    attributesMask: WindowAttributesType): ptr Window00 {.
    importc: "gdk_window_new", libprag.}

proc newWindow*(parent: Window; attributes: WindowAttr; attributesMask: WindowAttributesType): Window =
  new(result, finalizeGObject)
  result.impl = gdk_window_new(cast[ptr Window00](parent.impl), cast[ptr WindowAttr00](attributes.impl), attributesMask)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initWindow*[T](result: var T; parent: Window; attributes: WindowAttr; attributesMask: WindowAttributesType) =
  assert(result is Window)
  new(result, finalizeGObject)
  result.impl = gdk_window_new(cast[ptr Window00](parent.impl), cast[ptr WindowAttr00](attributes.impl), attributesMask)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SubpixelLayout* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    none = 1
    horizontalRgb = 2
    horizontalBgr = 3
    verticalRgb = 4
    verticalBgr = 5

proc gdk_monitor_get_subpixel_layout*(self: ptr Monitor00): SubpixelLayout {.
    importc: "gdk_monitor_get_subpixel_layout", libprag.}

proc getSubpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

proc subpixelLayout*(self: Monitor): SubpixelLayout =
  gdk_monitor_get_subpixel_layout(cast[ptr Monitor00](self.impl))

type
  Rectangle00* {.pure.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  Rectangle* = ref object
    impl*: ptr Rectangle00

proc gdk_rectangle_equal*(self: ptr Rectangle00; rect2: ptr Rectangle00): gboolean {.
    importc: "gdk_rectangle_equal", libprag.}

proc equal*(self: Rectangle; rect2: Rectangle): bool =
  toBool(gdk_rectangle_equal(cast[ptr Rectangle00](self.impl), cast[ptr Rectangle00](rect2.impl)))

proc gdk_rectangle_intersect*(self: ptr Rectangle00; src2: ptr Rectangle00; dest: var Rectangle00): gboolean {.
    importc: "gdk_rectangle_intersect", libprag.}

proc intersect*(self: ptr Rectangle00; src2: ptr Rectangle00; dest: var Rectangle00): gboolean {.
    importc: "gdk_rectangle_intersect", libprag.}

proc gdk_rectangle_union*(self: ptr Rectangle00; src2: ptr Rectangle00; dest: var Rectangle00) {.
    importc: "gdk_rectangle_union", libprag.}

proc union*(self: ptr Rectangle00; src2: ptr Rectangle00; dest: var Rectangle00) {.
    importc: "gdk_rectangle_union", libprag.}

proc gdk_monitor_get_geometry*(self: ptr Monitor00; geometry: var Rectangle00) {.
    importc: "gdk_monitor_get_geometry", libprag.}

proc getGeometry*(self: ptr Monitor00; geometry: var Rectangle00) {.
    importc: "gdk_monitor_get_geometry", libprag.}

proc geometry*(self: ptr Monitor00; geometry: var Rectangle00) {.
    importc: "gdk_monitor_get_geometry", libprag.}

proc gdk_monitor_get_workarea*(self: ptr Monitor00; workarea: var Rectangle00) {.
    importc: "gdk_monitor_get_workarea", libprag.}

proc getWorkarea*(self: ptr Monitor00; workarea: var Rectangle00) {.
    importc: "gdk_monitor_get_workarea", libprag.}

proc workarea*(self: ptr Monitor00; workarea: var Rectangle00) {.
    importc: "gdk_monitor_get_workarea", libprag.}

proc gdk_window_begin_paint_rect*(self: ptr Window00; rectangle: ptr Rectangle00) {.
    importc: "gdk_window_begin_paint_rect", libprag.}

proc beginPaintRect*(self: Window; rectangle: Rectangle) =
  gdk_window_begin_paint_rect(cast[ptr Window00](self.impl), cast[ptr Rectangle00](rectangle.impl))

proc gdk_window_get_frame_extents*(self: ptr Window00; rect: var Rectangle00) {.
    importc: "gdk_window_get_frame_extents", libprag.}

proc getFrameExtents*(self: ptr Window00; rect: var Rectangle00) {.
    importc: "gdk_window_get_frame_extents", libprag.}

proc frameExtents*(self: ptr Window00; rect: var Rectangle00) {.
    importc: "gdk_window_get_frame_extents", libprag.}

proc gdk_window_invalidate_rect*(self: ptr Window00; rect: ptr Rectangle00; invalidateChildren: gboolean) {.
    importc: "gdk_window_invalidate_rect", libprag.}

proc invalidateRect*(self: Window; rect: Rectangle; invalidateChildren: bool) =
  gdk_window_invalidate_rect(cast[ptr Window00](self.impl), cast[ptr Rectangle00](rect.impl), gboolean(invalidateChildren))

type
  Screen* = ref object of gobject.Object
  Screen00* = object of gobject.Object00

proc scCompositedChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "composited-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMonitorsChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "monitors-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scSizeChanged*(self: Screen;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "size-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_screen_get_default*(): ptr Screen00 {.
    importc: "gdk_screen_get_default", libprag.}

proc getDefault*(): Screen =
  let gobj = gdk_screen_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc default*(): Screen =
  let gobj = gdk_screen_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_height*(): int32 {.
    importc: "gdk_screen_height", libprag.}

proc height*(): int32 {.
    importc: "gdk_screen_height", libprag.}

proc gdk_screen_height_mm*(): int32 {.
    importc: "gdk_screen_height_mm", libprag.}

proc heightMm*(): int32 {.
    importc: "gdk_screen_height_mm", libprag.}

proc gdk_screen_width*(): int32 {.
    importc: "gdk_screen_width", libprag.}

proc width*(): int32 {.
    importc: "gdk_screen_width", libprag.}

proc gdk_screen_width_mm*(): int32 {.
    importc: "gdk_screen_width_mm", libprag.}

proc widthMm*(): int32 {.
    importc: "gdk_screen_width_mm", libprag.}

proc gdk_screen_get_active_window*(self: ptr Screen00): ptr Window00 {.
    importc: "gdk_screen_get_active_window", libprag.}

proc getActiveWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_active_window(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc activeWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_active_window(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_get_display*(self: ptr Screen00): ptr Display00 {.
    importc: "gdk_screen_get_display", libprag.}

proc getDisplay*(self: Screen): Display =
  let gobj = gdk_screen_get_display(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc display*(self: Screen): Display =
  let gobj = gdk_screen_get_display(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_get_font_options*(self: ptr Screen00): ptr cairo.FontOptions00 {.
    importc: "gdk_screen_get_font_options", libprag.}

proc getFontOptions*(self: Screen): cairo.FontOptions =
  new(result)
  result.impl = gdk_screen_get_font_options(cast[ptr Screen00](self.impl))

proc fontOptions*(self: Screen): cairo.FontOptions =
  new(result)
  result.impl = gdk_screen_get_font_options(cast[ptr Screen00](self.impl))

proc gdk_screen_get_height*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_height", libprag.}

proc getHeight*(self: Screen): int =
  int(gdk_screen_get_height(cast[ptr Screen00](self.impl)))

proc height*(self: Screen): int =
  int(gdk_screen_get_height(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_height_mm*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_height_mm", libprag.}

proc getHeightMm*(self: Screen): int =
  int(gdk_screen_get_height_mm(cast[ptr Screen00](self.impl)))

proc heightMm*(self: Screen): int =
  int(gdk_screen_get_height_mm(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_monitor_at_point*(self: ptr Screen00; x: int32; y: int32): int32 {.
    importc: "gdk_screen_get_monitor_at_point", libprag.}

proc getMonitorAtPoint*(self: Screen; x: int; y: int): int =
  int(gdk_screen_get_monitor_at_point(cast[ptr Screen00](self.impl), int32(x), int32(y)))

proc monitorAtPoint*(self: Screen; x: int; y: int): int =
  int(gdk_screen_get_monitor_at_point(cast[ptr Screen00](self.impl), int32(x), int32(y)))

proc gdk_screen_get_monitor_at_window*(self: ptr Screen00; window: ptr Window00): int32 {.
    importc: "gdk_screen_get_monitor_at_window", libprag.}

proc getMonitorAtWindow*(self: Screen; window: Window): int =
  int(gdk_screen_get_monitor_at_window(cast[ptr Screen00](self.impl), cast[ptr Window00](window.impl)))

proc monitorAtWindow*(self: Screen; window: Window): int =
  int(gdk_screen_get_monitor_at_window(cast[ptr Screen00](self.impl), cast[ptr Window00](window.impl)))

proc gdk_screen_get_monitor_geometry*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_geometry", libprag.}

proc getMonitorGeometry*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_geometry", libprag.}

proc monitorGeometry*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_geometry", libprag.}

proc gdk_screen_get_monitor_height_mm*(self: ptr Screen00; monitorNum: int32): int32 {.
    importc: "gdk_screen_get_monitor_height_mm", libprag.}

proc getMonitorHeightMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_height_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc monitorHeightMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_height_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_plug_name*(self: ptr Screen00; monitorNum: int32): cstring {.
    importc: "gdk_screen_get_monitor_plug_name", libprag.}

proc getMonitorPlugName*(self: Screen; monitorNum: int): string =
  let resul0 = gdk_screen_get_monitor_plug_name(cast[ptr Screen00](self.impl), int32(monitorNum))
  result = $resul0
  cogfree(resul0)

proc monitorPlugName*(self: Screen; monitorNum: int): string =
  let resul0 = gdk_screen_get_monitor_plug_name(cast[ptr Screen00](self.impl), int32(monitorNum))
  result = $resul0
  cogfree(resul0)

proc gdk_screen_get_monitor_scale_factor*(self: ptr Screen00; monitorNum: int32): int32 {.
    importc: "gdk_screen_get_monitor_scale_factor", libprag.}

proc getMonitorScaleFactor*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_scale_factor(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc monitorScaleFactor*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_scale_factor(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_width_mm*(self: ptr Screen00; monitorNum: int32): int32 {.
    importc: "gdk_screen_get_monitor_width_mm", libprag.}

proc getMonitorWidthMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_width_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc monitorWidthMm*(self: Screen; monitorNum: int): int =
  int(gdk_screen_get_monitor_width_mm(cast[ptr Screen00](self.impl), int32(monitorNum)))

proc gdk_screen_get_monitor_workarea*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_workarea", libprag.}

proc getMonitorWorkarea*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_workarea", libprag.}

proc monitorWorkarea*(self: ptr Screen00; monitorNum: int32; dest: var Rectangle00) {.
    importc: "gdk_screen_get_monitor_workarea", libprag.}

proc gdk_screen_get_n_monitors*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_n_monitors", libprag.}

proc getNMonitors*(self: Screen): int =
  int(gdk_screen_get_n_monitors(cast[ptr Screen00](self.impl)))

proc nMonitors*(self: Screen): int =
  int(gdk_screen_get_n_monitors(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_number*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_number", libprag.}

proc getNumber*(self: Screen): int =
  int(gdk_screen_get_number(cast[ptr Screen00](self.impl)))

proc number*(self: Screen): int =
  int(gdk_screen_get_number(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_primary_monitor*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_primary_monitor", libprag.}

proc getPrimaryMonitor*(self: Screen): int =
  int(gdk_screen_get_primary_monitor(cast[ptr Screen00](self.impl)))

proc primaryMonitor*(self: Screen): int =
  int(gdk_screen_get_primary_monitor(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_resolution*(self: ptr Screen00): cdouble {.
    importc: "gdk_screen_get_resolution", libprag.}

proc getResolution*(self: Screen): cdouble =
  gdk_screen_get_resolution(cast[ptr Screen00](self.impl))

proc resolution*(self: Screen): cdouble =
  gdk_screen_get_resolution(cast[ptr Screen00](self.impl))

proc gdk_screen_get_rgba_visual*(self: ptr Screen00): ptr Visual00 {.
    importc: "gdk_screen_get_rgba_visual", libprag.}

proc getRgbaVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_rgba_visual(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc rgbaVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_rgba_visual(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_get_root_window*(self: ptr Screen00): ptr Window00 {.
    importc: "gdk_screen_get_root_window", libprag.}

proc getRootWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_root_window(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc rootWindow*(self: Screen): Window =
  let gobj = gdk_screen_get_root_window(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_get_setting*(self: ptr Screen00; name: cstring; value: ptr gobject.Value00): gboolean {.
    importc: "gdk_screen_get_setting", libprag.}

proc getSetting*(self: Screen; name: string; value: gobject.Value): bool =
  toBool(gdk_screen_get_setting(cast[ptr Screen00](self.impl), cstring(name), cast[ptr gobject.Value00](value.impl)))

proc `ting=`*(self: Screen; name: string; value: gobject.Value): bool =
  toBool(gdk_screen_get_setting(cast[ptr Screen00](self.impl), cstring(name), cast[ptr gobject.Value00](value.impl)))

proc gdk_screen_get_system_visual*(self: ptr Screen00): ptr Visual00 {.
    importc: "gdk_screen_get_system_visual", libprag.}

proc getSystemVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_system_visual(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc systemVisual*(self: Screen): Visual =
  let gobj = gdk_screen_get_system_visual(cast[ptr Screen00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Visual](g_object_get_qdata(gobj, Quark))
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

proc gdk_screen_get_toplevel_windows*(self: ptr Screen00): ptr pointer {.
    importc: "gdk_screen_get_toplevel_windows", libprag.}

proc getToplevelWindows*(self: Screen): ptr pointer =
  gdk_screen_get_toplevel_windows(cast[ptr Screen00](self.impl))

proc toplevelWindows*(self: Screen): ptr pointer =
  gdk_screen_get_toplevel_windows(cast[ptr Screen00](self.impl))

proc gdk_screen_get_width*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_width", libprag.}

proc getWidth*(self: Screen): int =
  int(gdk_screen_get_width(cast[ptr Screen00](self.impl)))

proc width*(self: Screen): int =
  int(gdk_screen_get_width(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_width_mm*(self: ptr Screen00): int32 {.
    importc: "gdk_screen_get_width_mm", libprag.}

proc getWidthMm*(self: Screen): int =
  int(gdk_screen_get_width_mm(cast[ptr Screen00](self.impl)))

proc widthMm*(self: Screen): int =
  int(gdk_screen_get_width_mm(cast[ptr Screen00](self.impl)))

proc gdk_screen_get_window_stack*(self: ptr Screen00): ptr pointer {.
    importc: "gdk_screen_get_window_stack", libprag.}

proc getWindowStack*(self: Screen): ptr pointer =
  gdk_screen_get_window_stack(cast[ptr Screen00](self.impl))

proc windowStack*(self: Screen): ptr pointer =
  gdk_screen_get_window_stack(cast[ptr Screen00](self.impl))

proc gdk_screen_is_composited*(self: ptr Screen00): gboolean {.
    importc: "gdk_screen_is_composited", libprag.}

proc isComposited*(self: Screen): bool =
  toBool(gdk_screen_is_composited(cast[ptr Screen00](self.impl)))

proc gdk_screen_list_visuals*(self: ptr Screen00): ptr pointer {.
    importc: "gdk_screen_list_visuals", libprag.}

proc listVisuals*(self: Screen): ptr pointer =
  gdk_screen_list_visuals(cast[ptr Screen00](self.impl))

proc gdk_screen_make_display_name*(self: ptr Screen00): cstring {.
    importc: "gdk_screen_make_display_name", libprag.}

proc makeDisplayName*(self: Screen): string =
  let resul0 = gdk_screen_make_display_name(cast[ptr Screen00](self.impl))
  result = $resul0
  cogfree(resul0)

proc gdk_screen_set_font_options*(self: ptr Screen00; options: ptr cairo.FontOptions00) {.
    importc: "gdk_screen_set_font_options", libprag.}

proc setFontOptions*(self: Screen; options: cairo.FontOptions) =
  gdk_screen_set_font_options(cast[ptr Screen00](self.impl), cast[ptr cairo.FontOptions00](options.impl))

proc `fontOptions=`*(self: Screen; options: cairo.FontOptions) =
  gdk_screen_set_font_options(cast[ptr Screen00](self.impl), cast[ptr cairo.FontOptions00](options.impl))

proc gdk_screen_set_resolution*(self: ptr Screen00; dpi: cdouble) {.
    importc: "gdk_screen_set_resolution", libprag.}

proc setResolution*(self: Screen; dpi: cdouble) =
  gdk_screen_set_resolution(cast[ptr Screen00](self.impl), dpi)

proc `resolution=`*(self: Screen; dpi: cdouble) =
  gdk_screen_set_resolution(cast[ptr Screen00](self.impl), dpi)

proc gdk_app_launch_context_set_screen*(self: ptr AppLaunchContext00; screen: ptr Screen00) {.
    importc: "gdk_app_launch_context_set_screen", libprag.}

proc setScreen*(self: AppLaunchContext; screen: Screen) =
  gdk_app_launch_context_set_screen(cast[ptr AppLaunchContext00](self.impl), cast[ptr Screen00](screen.impl))

proc `screen=`*(self: AppLaunchContext; screen: Screen) =
  gdk_app_launch_context_set_screen(cast[ptr AppLaunchContext00](self.impl), cast[ptr Screen00](screen.impl))

proc gdk_device_get_position*(self: ptr Device00; screen: var ptr Screen00; x: var int32; 
    y: var int32) {.
    importc: "gdk_device_get_position", libprag.}

proc getPosition*(self: ptr Device00; screen: var ptr Screen00; x: var int32; 
    y: var int32) {.
    importc: "gdk_device_get_position", libprag.}

proc position*(self: ptr Device00; screen: var ptr Screen00; x: var int32; 
    y: var int32) {.
    importc: "gdk_device_get_position", libprag.}

proc gdk_device_get_position_double*(self: ptr Device00; screen: var ptr Screen00; x: var cdouble; 
    y: var cdouble) {.
    importc: "gdk_device_get_position_double", libprag.}

proc getPositionDouble*(self: ptr Device00; screen: var ptr Screen00; x: var cdouble; 
    y: var cdouble) {.
    importc: "gdk_device_get_position_double", libprag.}

proc positionDouble*(self: ptr Device00; screen: var ptr Screen00; x: var cdouble; 
    y: var cdouble) {.
    importc: "gdk_device_get_position_double", libprag.}

proc gdk_device_warp*(self: ptr Device00; screen: ptr Screen00; x: int32; 
    y: int32) {.
    importc: "gdk_device_warp", libprag.}

proc warp*(self: Device; screen: Screen; x: int; y: int) =
  gdk_device_warp(cast[ptr Device00](self.impl), cast[ptr Screen00](screen.impl), int32(x), int32(y))

proc gdk_display_get_default_screen*(self: ptr Display00): ptr Screen00 {.
    importc: "gdk_display_get_default_screen", libprag.}

proc getDefaultScreen*(self: Display): Screen =
  let gobj = gdk_display_get_default_screen(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc defaultScreen*(self: Display): Screen =
  let gobj = gdk_display_get_default_screen(cast[ptr Display00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_get_pointer*(self: ptr Display00; screen: var ptr Screen00; x: var int32; 
    y: var int32; mask: var ModifierType) {.
    importc: "gdk_display_get_pointer", libprag.}

proc getPointer*(self: ptr Display00; screen: var ptr Screen00; x: var int32; 
    y: var int32; mask: var ModifierType) {.
    importc: "gdk_display_get_pointer", libprag.}

proc gdk_display_get_screen*(self: ptr Display00; screenNum: int32): ptr Screen00 {.
    importc: "gdk_display_get_screen", libprag.}

proc getScreen*(self: Display; screenNum: int): Screen =
  let gobj = gdk_display_get_screen(cast[ptr Display00](self.impl), int32(screenNum))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc screen*(self: Display; screenNum: int): Screen =
  let gobj = gdk_display_get_screen(cast[ptr Display00](self.impl), int32(screenNum))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_warp_pointer*(self: ptr Display00; screen: ptr Screen00; x: int32; 
    y: int32) {.
    importc: "gdk_display_warp_pointer", libprag.}

proc warpPointer*(self: Display; screen: Screen; x: int; y: int) =
  gdk_display_warp_pointer(cast[ptr Display00](self.impl), cast[ptr Screen00](screen.impl), int32(x), int32(y))

proc gdk_window_get_screen*(self: ptr Window00): ptr Screen00 {.
    importc: "gdk_window_get_screen", libprag.}

proc getScreen*(self: Window): Screen =
  let gobj = gdk_window_get_screen(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc screen*(self: Window): Screen =
  let gobj = gdk_window_get_screen(cast[ptr Window00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc gdk_visual_get_screen*(self: ptr Visual00): ptr Screen00 {.
    importc: "gdk_visual_get_screen", libprag.}

proc getScreen*(self: Visual): Screen =
  let gobj = gdk_visual_get_screen(cast[ptr Visual00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc screen*(self: Visual): Screen =
  let gobj = gdk_visual_get_screen(cast[ptr Visual00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

const BUTTON_MIDDLE* = 2'i32

const BUTTON_PRIMARY* = 1'i32

const BUTTON_SECONDARY* = 3'i32

const CURRENT_TIME* = 0'i32

type
  CrossingMode* {.size: sizeof(cint), pure.} = enum
    normal = 0
    grab = 1
    ungrab = 2
    gtkGrab = 3
    gtkUngrab = 4
    stateChanged = 5
    touchBegin = 6
    touchEnd = 7
    deviceSwitch = 8

type
  DevicePad00* {.pure.} = object
  DevicePad* = ref object
    impl*: ptr DevicePad00

proc gdk_device_pad_get_group_n_modes*(self: ptr DevicePad00; groupIdx: int32): int32 {.
    importc: "gdk_device_pad_get_group_n_modes", libprag.}

proc getGroupNModes*(self: DevicePad; groupIdx: int): int =
  int(gdk_device_pad_get_group_n_modes(cast[ptr DevicePad00](self.impl), int32(groupIdx)))

proc groupNModes*(self: DevicePad; groupIdx: int): int =
  int(gdk_device_pad_get_group_n_modes(cast[ptr DevicePad00](self.impl), int32(groupIdx)))

proc gdk_device_pad_get_n_groups*(self: ptr DevicePad00): int32 {.
    importc: "gdk_device_pad_get_n_groups", libprag.}

proc getNGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

proc nGroups*(self: DevicePad): int =
  int(gdk_device_pad_get_n_groups(cast[ptr DevicePad00](self.impl)))

type
  DevicePadFeature* {.size: sizeof(cint), pure.} = enum
    button = 0
    ring = 1
    strip = 2

proc gdk_device_pad_get_feature_group*(self: ptr DevicePad00; feature: DevicePadFeature; 
    featureIdx: int32): int32 {.
    importc: "gdk_device_pad_get_feature_group", libprag.}

proc getFeatureGroup*(self: DevicePad; feature: DevicePadFeature; featureIdx: int): int =
  int(gdk_device_pad_get_feature_group(cast[ptr DevicePad00](self.impl), feature, int32(featureIdx)))

proc featureGroup*(self: DevicePad; feature: DevicePadFeature; featureIdx: int): int =
  int(gdk_device_pad_get_feature_group(cast[ptr DevicePad00](self.impl), feature, int32(featureIdx)))

proc gdk_device_pad_get_n_features*(self: ptr DevicePad00; feature: DevicePadFeature): int32 {.
    importc: "gdk_device_pad_get_n_features", libprag.}

proc getNFeatures*(self: DevicePad; feature: DevicePadFeature): int =
  int(gdk_device_pad_get_n_features(cast[ptr DevicePad00](self.impl), feature))

proc nFeatures*(self: DevicePad; feature: DevicePadFeature): int =
  int(gdk_device_pad_get_n_features(cast[ptr DevicePad00](self.impl), feature))

type
  DevicePadInterface00* {.pure.} = object
  DevicePadInterface* = ref object
    impl*: ptr DevicePadInterface00

type
  DisplayManager* = ref object of gobject.Object
  DisplayManager00* = object of gobject.Object00

proc scDisplayOpened*(self: DisplayManager;  p: proc (self: ptr gobject.Object00; display: Display00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "display-opened", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_display_manager_get*(): ptr DisplayManager00 {.
    importc: "gdk_display_manager_get", libprag.}

proc get*(): DisplayManager =
  let gobj = gdk_display_manager_get()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DisplayManager](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_manager_get_default_display*(self: ptr DisplayManager00): ptr Display00 {.
    importc: "gdk_display_manager_get_default_display", libprag.}

proc getDefaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc defaultDisplay*(self: DisplayManager): Display =
  let gobj = gdk_display_manager_get_default_display(cast[ptr DisplayManager00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_manager_list_displays*(self: ptr DisplayManager00): ptr pointer {.
    importc: "gdk_display_manager_list_displays", libprag.}

proc listDisplays*(self: DisplayManager): ptr pointer =
  gdk_display_manager_list_displays(cast[ptr DisplayManager00](self.impl))

proc gdk_display_manager_open_display*(self: ptr DisplayManager00; name: cstring): ptr Display00 {.
    importc: "gdk_display_manager_open_display", libprag.}

proc openDisplay*(self: DisplayManager; name: string): Display =
  let gobj = gdk_display_manager_open_display(cast[ptr DisplayManager00](self.impl), cstring(name))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Display](g_object_get_qdata(gobj, Quark))
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

proc gdk_display_manager_set_default_display*(self: ptr DisplayManager00; display: ptr Display00) {.
    importc: "gdk_display_manager_set_default_display", libprag.}

proc setDefaultDisplay*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

proc `defaultDisplay=`*(self: DisplayManager; display: Display) =
  gdk_display_manager_set_default_display(cast[ptr DisplayManager00](self.impl), cast[ptr Display00](display.impl))

type
  DragAction* {.size: sizeof(cint), pure.} = enum
    default = 1
    copy = 2
    move = 4
    link = 8
    private = 16
    ask = 32

type
  DragCancelReason* {.size: sizeof(cint), pure.} = enum
    noTarget = 0
    userCancelled = 1
    error = 2

type
  DragContext* = ref object of gobject.Object
  DragContext00* = object of gobject.Object00

proc scActionChanged*(self: DragContext;  p: proc (self: ptr gobject.Object00; action: DragAction; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "action-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scCancel*(self: DragContext;  p: proc (self: ptr gobject.Object00; reason: DragCancelReason; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "cancel", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDndFinished*(self: DragContext;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "dnd-finished", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDropPerformed*(self: DragContext;  p: proc (self: ptr gobject.Object00; time: int32; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drop-performed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_drag_context_get_actions*(self: ptr DragContext00): DragAction {.
    importc: "gdk_drag_context_get_actions", libprag.}

proc getActions*(self: DragContext): DragAction =
  gdk_drag_context_get_actions(cast[ptr DragContext00](self.impl))

proc actions*(self: DragContext): DragAction =
  gdk_drag_context_get_actions(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_dest_window*(self: ptr DragContext00): ptr Window00 {.
    importc: "gdk_drag_context_get_dest_window", libprag.}

proc getDestWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_dest_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc destWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_dest_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_context_get_device*(self: ptr DragContext00): ptr Device00 {.
    importc: "gdk_drag_context_get_device", libprag.}

proc getDevice*(self: DragContext): Device =
  let gobj = gdk_drag_context_get_device(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc device*(self: DragContext): Device =
  let gobj = gdk_drag_context_get_device(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_context_get_drag_window*(self: ptr DragContext00): ptr Window00 {.
    importc: "gdk_drag_context_get_drag_window", libprag.}

proc getDragWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_drag_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc dragWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_drag_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_context_get_protocol*(self: ptr DragContext00): DragProtocol {.
    importc: "gdk_drag_context_get_protocol", libprag.}

proc getProtocol*(self: DragContext): DragProtocol =
  gdk_drag_context_get_protocol(cast[ptr DragContext00](self.impl))

proc protocol*(self: DragContext): DragProtocol =
  gdk_drag_context_get_protocol(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_selected_action*(self: ptr DragContext00): DragAction {.
    importc: "gdk_drag_context_get_selected_action", libprag.}

proc getSelectedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_selected_action(cast[ptr DragContext00](self.impl))

proc selectedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_selected_action(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_get_source_window*(self: ptr DragContext00): ptr Window00 {.
    importc: "gdk_drag_context_get_source_window", libprag.}

proc getSourceWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_source_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc sourceWindow*(self: DragContext): Window =
  let gobj = gdk_drag_context_get_source_window(cast[ptr DragContext00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_context_get_suggested_action*(self: ptr DragContext00): DragAction {.
    importc: "gdk_drag_context_get_suggested_action", libprag.}

proc getSuggestedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_suggested_action(cast[ptr DragContext00](self.impl))

proc suggestedAction*(self: DragContext): DragAction =
  gdk_drag_context_get_suggested_action(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_list_targets*(self: ptr DragContext00): ptr pointer {.
    importc: "gdk_drag_context_list_targets", libprag.}

proc listTargets*(self: DragContext): ptr pointer =
  gdk_drag_context_list_targets(cast[ptr DragContext00](self.impl))

proc gdk_drag_context_manage_dnd*(self: ptr DragContext00; ipcWindow: ptr Window00; 
    actions: DragAction): gboolean {.
    importc: "gdk_drag_context_manage_dnd", libprag.}

proc manageDnd*(self: DragContext; ipcWindow: Window; actions: DragAction): bool =
  toBool(gdk_drag_context_manage_dnd(cast[ptr DragContext00](self.impl), cast[ptr Window00](ipcWindow.impl), actions))

proc gdk_drag_context_set_device*(self: ptr DragContext00; device: ptr Device00) {.
    importc: "gdk_drag_context_set_device", libprag.}

proc setDevice*(self: DragContext; device: Device) =
  gdk_drag_context_set_device(cast[ptr DragContext00](self.impl), cast[ptr Device00](device.impl))

proc `device=`*(self: DragContext; device: Device) =
  gdk_drag_context_set_device(cast[ptr DragContext00](self.impl), cast[ptr Device00](device.impl))

proc gdk_drag_context_set_hotspot*(self: ptr DragContext00; hotX: int32; hotY: int32) {.
    importc: "gdk_drag_context_set_hotspot", libprag.}

proc setHotspot*(self: DragContext; hotX: int; hotY: int) =
  gdk_drag_context_set_hotspot(cast[ptr DragContext00](self.impl), int32(hotX), int32(hotY))

type
  DrawingContextClass00* {.pure.} = object
  DrawingContextClass* = ref object
    impl*: ptr DrawingContextClass00

const EVENT_PROPAGATE* = false

const EVENT_STOP* = true

type
  EventType* {.size: sizeof(cint), pure.} = enum
    nothing = -1
    delete = 0
    destroy = 1
    expose = 2
    motionNotify = 3
    buttonPress = 4
    doubleButtonPress = 5
    threeButtonPress = 6
    buttonRelease = 7
    keyPress = 8
    keyRelease = 9
    enterNotify = 10
    leaveNotify = 11
    focusChange = 12
    configure = 13
    map = 14
    unmap = 15
    propertyNotify = 16
    selectionClear = 17
    selectionRequest = 18
    selectionNotify = 19
    proximityIn = 20
    proximityOut = 21
    dragEnter = 22
    dragLeave = 23
    dragMotion = 24
    dragStatus = 25
    dropStart = 26
    dropFinished = 27
    clientEvent = 28
    visibilityNotify = 29
    scroll = 31
    windowState = 32
    setting = 33
    ownerChange = 34
    grabBroken = 35
    damage = 36
    touchBegin = 37
    touchUpdate = 38
    touchEnd = 39
    touchCancel = 40
    touchpadSwipe = 41
    touchpadPinch = 42
    padButtonPress = 43
    padButtonRelease = 44
    padRing = 45
    padStrip = 46
    padGroupMode = 47
    eventLast = 48

const
  EventTypeTwoButtonPress* = EventType.doubleButtonPress
  EventTypeTripleButtonPress* = EventType.threeButtonPress

type
  EventAny00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
  EventAny* = ref object
    impl*: ptr EventAny00

type
  EventExpose00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    area*: Rectangle00
    region*: ptr cairo.Region00
    count*: int32
  EventExpose* = ref object
    impl*: ptr EventExpose00

type
  VisibilityState* {.size: sizeof(cint), pure.} = enum
    unobscured = 0
    partial = 1
    fullyObscured = 2

type
  EventVisibility00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    state*: VisibilityState
  EventVisibility* = ref object
    impl*: ptr EventVisibility00

type
  EventMotion00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    axes*: ptr cdouble
    state*: ModifierType
    isHint*: int16
    device*: ptr Device00
    xRoot*: cdouble
    yRoot*: cdouble
  EventMotion* = ref object
    impl*: ptr EventMotion00

type
  EventButton00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    axes*: ptr cdouble
    state*: ModifierType
    button*: uint32
    device*: ptr Device00
    xRoot*: cdouble
    yRoot*: cdouble
  EventButton* = ref object
    impl*: ptr EventButton00

type
  EventSequence00* {.pure.} = object
  EventSequence* = ref object
    impl*: ptr EventSequence00

type
  EventTouch00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    axes*: ptr cdouble
    state*: ModifierType
    sequence*: ptr EventSequence00
    emulatingPointer*: gboolean
    device*: ptr Device00
    xRoot*: cdouble
    yRoot*: cdouble
  EventTouch* = ref object
    impl*: ptr EventTouch00

type
  ScrollDirection* {.size: sizeof(cint), pure.} = enum
    up = 0
    down = 1
    left = 2
    right = 3
    smooth = 4

type
  EventScroll00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    state*: ModifierType
    direction*: ScrollDirection
    device*: ptr Device00
    xRoot*: cdouble
    yRoot*: cdouble
    deltaX*: cdouble
    deltaY*: cdouble
    isStop*: uint32
  EventScroll* = ref object
    impl*: ptr EventScroll00

type
  EventKey00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    state*: ModifierType
    keyval*: uint32
    length*: int32
    string*: cstring
    hardwareKeycode*: uint16
    group*: uint8
    isModifier*: uint32
  EventKey* = ref object
    impl*: ptr EventKey00

type
  NotifyType* {.size: sizeof(cint), pure.} = enum
    ancestor = 0
    virtual = 1
    inferior = 2
    nonlinear = 3
    nonlinearVirtual = 4
    unknown = 5

type
  EventCrossing00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    subwindow*: ptr Window00
    time*: uint32
    x*: cdouble
    y*: cdouble
    xRoot*: cdouble
    yRoot*: cdouble
    mode*: CrossingMode
    detail*: NotifyType
    focus*: gboolean
    state*: ModifierType
  EventCrossing* = ref object
    impl*: ptr EventCrossing00

type
  EventFocus00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    `in`*: int16
  EventFocus* = ref object
    impl*: ptr EventFocus00

type
  EventConfigure00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  EventConfigure* = ref object
    impl*: ptr EventConfigure00

type
  PropertyState* {.size: sizeof(cint), pure.} = enum
    newValue = 0
    delete = 1

type
  EventProperty00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    atom*: ptr Atom00
    time*: uint32
    state*: PropertyState
  EventProperty* = ref object
    impl*: ptr EventProperty00

type
  EventSelection00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    selection*: ptr Atom00
    target*: ptr Atom00
    property*: ptr Atom00
    time*: uint32
    requestor*: ptr Window00
  EventSelection* = ref object
    impl*: ptr EventSelection00

type
  OwnerChange* {.size: sizeof(cint), pure.} = enum
    newOwner = 0
    destroy = 1
    close = 2

type
  EventOwnerChange00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    owner*: ptr Window00
    reason*: OwnerChange
    selection*: ptr Atom00
    time*: uint32
    selectionTime*: uint32
  EventOwnerChange* = ref object
    impl*: ptr EventOwnerChange00

type
  EventProximity00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    device*: ptr Device00
  EventProximity* = ref object
    impl*: ptr EventProximity00

type
  EventDND00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    context*: ptr DragContext00
    time*: uint32
    xRoot*: int16
    yRoot*: int16
  EventDND* = ref object
    impl*: ptr EventDND00

type
  EventWindowState00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    changedMask*: WindowState
    newWindowState*: WindowState
  EventWindowState* = ref object
    impl*: ptr EventWindowState00

type
  SettingAction* {.size: sizeof(cint), pure.} = enum
    new = 0
    changed = 1
    deleted = 2

type
  EventSetting00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    action*: SettingAction
    name*: cstring
  EventSetting* = ref object
    impl*: ptr EventSetting00

type
  EventGrabBroken00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    keyboard*: gboolean
    implicit*: gboolean
    grabWindow*: ptr Window00
  EventGrabBroken* = ref object
    impl*: ptr EventGrabBroken00

type
  TouchpadGesturePhase* {.size: sizeof(cint), pure.} = enum
    begin = 0
    update = 1
    `end` = 2
    cancel = 3

type
  EventTouchpadSwipe00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    phase*: TouchpadGesturePhase
    nFingers*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    dx*: cdouble
    dy*: cdouble
    xRoot*: cdouble
    yRoot*: cdouble
    state*: ModifierType
  EventTouchpadSwipe* = ref object
    impl*: ptr EventTouchpadSwipe00

type
  EventTouchpadPinch00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    phase*: TouchpadGesturePhase
    nFingers*: int8
    time*: uint32
    x*: cdouble
    y*: cdouble
    dx*: cdouble
    dy*: cdouble
    angleDelta*: cdouble
    scale*: cdouble
    xRoot*: cdouble
    yRoot*: cdouble
    state*: ModifierType
  EventTouchpadPinch* = ref object
    impl*: ptr EventTouchpadPinch00

type
  EventPadButton00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    group*: uint32
    button*: uint32
    mode*: uint32
  EventPadButton* = ref object
    impl*: ptr EventPadButton00

type
  EventPadAxis00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    group*: uint32
    index*: uint32
    mode*: uint32
    value*: cdouble
  EventPadAxis* = ref object
    impl*: ptr EventPadAxis00

type
  EventPadGroupMode00* {.pure.} = object
    `type`*: EventType
    window*: ptr Window00
    sendEvent*: int8
    time*: uint32
    group*: uint32
    mode*: uint32
  EventPadGroupMode* = ref object
    impl*: ptr EventPadGroupMode00

type
  Event00* = object {.union.}
    `type`*: EventType
    any*: EventAny00
    expose*: EventExpose00
    visibility*: EventVisibility00
    motion*: EventMotion00
    button*: EventButton00
    touch*: EventTouch00
    scroll*: EventScroll00
    key*: EventKey00
    crossing*: EventCrossing00
    focusChange*: EventFocus00
    configure*: EventConfigure00
    property*: EventProperty00
    selection*: EventSelection00
    ownerChange*: EventOwnerChange00
    proximity*: EventProximity00
    dnd*: EventDND00
    windowState*: EventWindowState00
    setting*: EventSetting00
    grabBroken*: EventGrabBroken00
    touchpadSwipe*: EventTouchpadSwipe00
    touchpadPinch*: EventTouchpadPinch00
    padButton*: EventPadButton00
    padAxis*: EventPadAxis00
    padGroupMode*: EventPadGroupMode00
  Event* = ref object
    impl*: ptr Event00

proc gdk_event_new*(`type`: EventType): ptr Event00 {.
    importc: "gdk_event_new", libprag.}

proc newEvent*(`type`: EventType): Event =
  new(result)
  result.impl = gdk_event_new(`type`)

proc initEvent*[T](result: var T; `type`: EventType) =
  assert(result is Event)
  new(result)
  result.impl = gdk_event_new(`type`)

proc gdk_events_get_angle*(self: ptr Event00; event2: ptr Event00; angle: var cdouble): gboolean {.
    importc: "gdk_events_get_angle", libprag.}

proc getAngle*(self: Event; event2: Event; angle: var cdouble): bool =
  toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), angle))

proc angle*(self: Event; event2: Event; angle: var cdouble): bool =
  toBool(gdk_events_get_angle(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), angle))

proc gdk_events_get_center*(self: ptr Event00; event2: ptr Event00; x: var cdouble; 
    y: var cdouble): gboolean {.
    importc: "gdk_events_get_center", libprag.}

proc getCenter*(self: Event; event2: Event; x: var cdouble; y: var cdouble): bool =
  toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), x, y))

proc center*(self: Event; event2: Event; x: var cdouble; y: var cdouble): bool =
  toBool(gdk_events_get_center(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), x, y))

proc gdk_events_get_distance*(self: ptr Event00; event2: ptr Event00; distance: var cdouble): gboolean {.
    importc: "gdk_events_get_distance", libprag.}

proc getDistance*(self: Event; event2: Event; distance: var cdouble): bool =
  toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), distance))

proc distance*(self: Event; event2: Event; distance: var cdouble): bool =
  toBool(gdk_events_get_distance(cast[ptr Event00](self.impl), cast[ptr Event00](event2.impl), distance))

proc gdk_event_copy*(self: ptr Event00): ptr Event00 {.
    importc: "gdk_event_copy", libprag.}

proc copy*(self: Event): Event =
  new(result)
  result.impl = gdk_event_copy(cast[ptr Event00](self.impl))

proc gdk_event_free*(self: ptr Event00) {.
    importc: "gdk_event_free", libprag.}

proc free*(self: Event) =
  gdk_event_free(cast[ptr Event00](self.impl))

proc gdk_event_get_axis*(self: ptr Event00; axisUse: AxisUse; value: var cdouble): gboolean {.
    importc: "gdk_event_get_axis", libprag.}

proc getAxis*(self: Event; axisUse: AxisUse; value: var cdouble): bool =
  toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, value))

proc axis*(self: Event; axisUse: AxisUse; value: var cdouble): bool =
  toBool(gdk_event_get_axis(cast[ptr Event00](self.impl), axisUse, value))

proc gdk_event_get_button*(self: ptr Event00; button: var uint32): gboolean {.
    importc: "gdk_event_get_button", libprag.}

proc getButton*(self: Event; button: var int): bool =
  var button_00 = uint32(button)
  result = toBool(gdk_event_get_button(cast[ptr Event00](self.impl), button_00))
  button = int(button_00)

proc button*(self: Event; button: var int): bool =
  var button_00 = uint32(button)
  result = toBool(gdk_event_get_button(cast[ptr Event00](self.impl), button_00))
  button = int(button_00)

proc gdk_event_get_click_count*(self: ptr Event00; clickCount: var uint32): gboolean {.
    importc: "gdk_event_get_click_count", libprag.}

proc getClickCount*(self: Event; clickCount: var int): bool =
  var clickCount_00 = uint32(clickCount)
  result = toBool(gdk_event_get_click_count(cast[ptr Event00](self.impl), clickCount_00))
  clickCount = int(clickCount_00)

proc clickCount*(self: Event; clickCount: var int): bool =
  var clickCount_00 = uint32(clickCount)
  result = toBool(gdk_event_get_click_count(cast[ptr Event00](self.impl), clickCount_00))
  clickCount = int(clickCount_00)

proc gdk_event_get_coords*(self: ptr Event00; xWin: var cdouble; yWin: var cdouble): gboolean {.
    importc: "gdk_event_get_coords", libprag.}

proc getCoords*(self: Event; xWin: var cdouble; yWin: var cdouble): bool =
  toBool(gdk_event_get_coords(cast[ptr Event00](self.impl), xWin, yWin))

proc coords*(self: Event; xWin: var cdouble; yWin: var cdouble): bool =
  toBool(gdk_event_get_coords(cast[ptr Event00](self.impl), xWin, yWin))

proc gdk_event_get_device*(self: ptr Event00): ptr Device00 {.
    importc: "gdk_event_get_device", libprag.}

proc getDevice*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc device*(self: Event): Device =
  let gobj = gdk_event_get_device(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_get_device_tool*(self: ptr Event00): ptr DeviceTool00 {.
    importc: "gdk_event_get_device_tool", libprag.}

proc getDeviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DeviceTool](g_object_get_qdata(gobj, Quark))
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

proc deviceTool*(self: Event): DeviceTool =
  let gobj = gdk_event_get_device_tool(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DeviceTool](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_get_event_sequence*(self: ptr Event00): ptr EventSequence00 {.
    importc: "gdk_event_get_event_sequence", libprag.}

proc getEventSequence*(self: Event): EventSequence =
  new(result)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))

proc eventSequence*(self: Event): EventSequence =
  new(result)
  result.impl = gdk_event_get_event_sequence(cast[ptr Event00](self.impl))

proc gdk_event_get_event_type*(self: ptr Event00): EventType {.
    importc: "gdk_event_get_event_type", libprag.}

proc getEventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

proc eventType*(self: Event): EventType =
  gdk_event_get_event_type(cast[ptr Event00](self.impl))

proc gdk_event_get_keycode*(self: ptr Event00; keycode: var uint16): gboolean {.
    importc: "gdk_event_get_keycode", libprag.}

proc getKeycode*(self: Event; keycode: var uint16): bool =
  toBool(gdk_event_get_keycode(cast[ptr Event00](self.impl), keycode))

proc keycode*(self: Event; keycode: var uint16): bool =
  toBool(gdk_event_get_keycode(cast[ptr Event00](self.impl), keycode))

proc gdk_event_get_keyval*(self: ptr Event00; keyval: var uint32): gboolean {.
    importc: "gdk_event_get_keyval", libprag.}

proc getKeyval*(self: Event; keyval: var int): bool =
  var keyval_00 = uint32(keyval)
  result = toBool(gdk_event_get_keyval(cast[ptr Event00](self.impl), keyval_00))
  keyval = int(keyval_00)

proc keyval*(self: Event; keyval: var int): bool =
  var keyval_00 = uint32(keyval)
  result = toBool(gdk_event_get_keyval(cast[ptr Event00](self.impl), keyval_00))
  keyval = int(keyval_00)

proc gdk_event_get_pointer_emulated*(self: ptr Event00): gboolean {.
    importc: "gdk_event_get_pointer_emulated", libprag.}

proc getPointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc pointerEmulated*(self: Event): bool =
  toBool(gdk_event_get_pointer_emulated(cast[ptr Event00](self.impl)))

proc gdk_event_get_root_coords*(self: ptr Event00; xRoot: var cdouble; yRoot: var cdouble): gboolean {.
    importc: "gdk_event_get_root_coords", libprag.}

proc getRootCoords*(self: Event; xRoot: var cdouble; yRoot: var cdouble): bool =
  toBool(gdk_event_get_root_coords(cast[ptr Event00](self.impl), xRoot, yRoot))

proc rootCoords*(self: Event; xRoot: var cdouble; yRoot: var cdouble): bool =
  toBool(gdk_event_get_root_coords(cast[ptr Event00](self.impl), xRoot, yRoot))

proc gdk_event_get_scancode*(self: ptr Event00): int32 {.
    importc: "gdk_event_get_scancode", libprag.}

proc getScancode*(self: Event): int =
  int(gdk_event_get_scancode(cast[ptr Event00](self.impl)))

proc scancode*(self: Event): int =
  int(gdk_event_get_scancode(cast[ptr Event00](self.impl)))

proc gdk_event_get_screen*(self: ptr Event00): ptr Screen00 {.
    importc: "gdk_event_get_screen", libprag.}

proc getScreen*(self: Event): Screen =
  let gobj = gdk_event_get_screen(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc screen*(self: Event): Screen =
  let gobj = gdk_event_get_screen(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Screen](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_get_scroll_deltas*(self: ptr Event00; deltaX: var cdouble; deltaY: var cdouble): gboolean {.
    importc: "gdk_event_get_scroll_deltas", libprag.}

proc getScrollDeltas*(self: Event; deltaX: var cdouble; deltaY: var cdouble): bool =
  toBool(gdk_event_get_scroll_deltas(cast[ptr Event00](self.impl), deltaX, deltaY))

proc scrollDeltas*(self: Event; deltaX: var cdouble; deltaY: var cdouble): bool =
  toBool(gdk_event_get_scroll_deltas(cast[ptr Event00](self.impl), deltaX, deltaY))

proc gdk_event_get_scroll_direction*(self: ptr Event00; direction: var ScrollDirection): gboolean {.
    importc: "gdk_event_get_scroll_direction", libprag.}

proc getScrollDirection*(self: Event; direction: var ScrollDirection): bool =
  toBool(gdk_event_get_scroll_direction(cast[ptr Event00](self.impl), direction))

proc scrollDirection*(self: Event; direction: var ScrollDirection): bool =
  toBool(gdk_event_get_scroll_direction(cast[ptr Event00](self.impl), direction))

proc gdk_event_get_seat*(self: ptr Event00): ptr Seat00 {.
    importc: "gdk_event_get_seat", libprag.}

proc getSeat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc seat*(self: Event): Seat =
  let gobj = gdk_event_get_seat(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Seat](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_get_source_device*(self: ptr Event00): ptr Device00 {.
    importc: "gdk_event_get_source_device", libprag.}

proc getSourceDevice*(self: Event): Device =
  let gobj = gdk_event_get_source_device(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc sourceDevice*(self: Event): Device =
  let gobj = gdk_event_get_source_device(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Device](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_get_state*(self: ptr Event00; state: var ModifierType): gboolean {.
    importc: "gdk_event_get_state", libprag.}

proc getState*(self: Event; state: var ModifierType): bool =
  toBool(gdk_event_get_state(cast[ptr Event00](self.impl), state))

proc state*(self: Event; state: var ModifierType): bool =
  toBool(gdk_event_get_state(cast[ptr Event00](self.impl), state))

proc gdk_event_get_time*(self: ptr Event00): uint32 {.
    importc: "gdk_event_get_time", libprag.}

proc getTime*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc time*(self: Event): int =
  int(gdk_event_get_time(cast[ptr Event00](self.impl)))

proc gdk_event_get_window*(self: ptr Event00): ptr Window00 {.
    importc: "gdk_event_get_window", libprag.}

proc getWindow*(self: Event): Window =
  let gobj = gdk_event_get_window(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc window*(self: Event): Window =
  let gobj = gdk_event_get_window(cast[ptr Event00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_event_is_scroll_stop_event*(self: ptr Event00): gboolean {.
    importc: "gdk_event_is_scroll_stop_event", libprag.}

proc isScrollStopEvent*(self: Event): bool =
  toBool(gdk_event_is_scroll_stop_event(cast[ptr Event00](self.impl)))

proc gdk_event_put*(self: ptr Event00) {.
    importc: "gdk_event_put", libprag.}

proc put*(self: Event) =
  gdk_event_put(cast[ptr Event00](self.impl))

proc gdk_event_set_device*(self: ptr Event00; device: ptr Device00) {.
    importc: "gdk_event_set_device", libprag.}

proc setDevice*(self: Event; device: Device) =
  gdk_event_set_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc `device=`*(self: Event; device: Device) =
  gdk_event_set_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc gdk_event_set_device_tool*(self: ptr Event00; tool: ptr DeviceTool00) {.
    importc: "gdk_event_set_device_tool", libprag.}

proc setDeviceTool*(self: Event; tool: DeviceTool) =
  gdk_event_set_device_tool(cast[ptr Event00](self.impl), cast[ptr DeviceTool00](tool.impl))

proc `deviceTool=`*(self: Event; tool: DeviceTool) =
  gdk_event_set_device_tool(cast[ptr Event00](self.impl), cast[ptr DeviceTool00](tool.impl))

proc gdk_event_set_screen*(self: ptr Event00; screen: ptr Screen00) {.
    importc: "gdk_event_set_screen", libprag.}

proc setScreen*(self: Event; screen: Screen) =
  gdk_event_set_screen(cast[ptr Event00](self.impl), cast[ptr Screen00](screen.impl))

proc `screen=`*(self: Event; screen: Screen) =
  gdk_event_set_screen(cast[ptr Event00](self.impl), cast[ptr Screen00](screen.impl))

proc gdk_event_set_source_device*(self: ptr Event00; device: ptr Device00) {.
    importc: "gdk_event_set_source_device", libprag.}

proc setSourceDevice*(self: Event; device: Device) =
  gdk_event_set_source_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc `sourceDevice=`*(self: Event; device: Device) =
  gdk_event_set_source_device(cast[ptr Event00](self.impl), cast[ptr Device00](device.impl))

proc gdk_event_triggers_context_menu*(self: ptr Event00): gboolean {.
    importc: "gdk_event_triggers_context_menu", libprag.}

proc triggersContextMenu*(self: Event): bool =
  toBool(gdk_event_triggers_context_menu(cast[ptr Event00](self.impl)))

proc gdk_event_get*(): ptr Event00 {.
    importc: "gdk_event_get", libprag.}

proc get*(): Event =
  new(result)
  result.impl = gdk_event_get()

proc gdk_event_peek*(): ptr Event00 {.
    importc: "gdk_event_peek", libprag.}

proc peek*(): Event =
  new(result)
  result.impl = gdk_event_peek()

proc gdk_event_request_motions*(event: ptr EventMotion00) {.
    importc: "gdk_event_request_motions", libprag.}

proc requestMotions*(event: EventMotion) =
  gdk_event_request_motions(cast[ptr EventMotion00](event.impl))

proc gdk_display_get_event*(self: ptr Display00): ptr Event00 {.
    importc: "gdk_display_get_event", libprag.}

proc getEvent*(self: Display): Event =
  new(result)
  result.impl = gdk_display_get_event(cast[ptr Display00](self.impl))

proc event*(self: Display): Event =
  new(result)
  result.impl = gdk_display_get_event(cast[ptr Display00](self.impl))

proc gdk_display_peek_event*(self: ptr Display00): ptr Event00 {.
    importc: "gdk_display_peek_event", libprag.}

proc peekEvent*(self: Display): Event =
  new(result)
  result.impl = gdk_display_peek_event(cast[ptr Display00](self.impl))

proc gdk_display_put_event*(self: ptr Display00; event: ptr Event00) {.
    importc: "gdk_display_put_event", libprag.}

proc putEvent*(self: Display; event: Event) =
  gdk_display_put_event(cast[ptr Display00](self.impl), cast[ptr Event00](event.impl))

proc gdk_window_show_window_menu*(self: ptr Window00; event: ptr Event00): gboolean {.
    importc: "gdk_window_show_window_menu", libprag.}

proc showWindowMenu*(self: Window; event: Event): bool =
  toBool(gdk_window_show_window_menu(cast[ptr Window00](self.impl), cast[ptr Event00](event.impl)))

type
  EventFunc* = proc (event: ptr Event00; data: pointer) {.cdecl.}

proc gdk_event_handler_set*(`func`: EventFunc; data: pointer; notify: DestroyNotify) {.
    importc: "gdk_event_handler_set", libprag.}

proc handlerSet*(`func`: EventFunc; data: pointer; notify: DestroyNotify) {.
    importc: "gdk_event_handler_set", libprag.}

type
  FilterReturn* {.size: sizeof(cint), pure.} = enum
    `continue` = 0
    translate = 1
    remove = 2

type
  FilterFunc* = proc (xevent: pointer; event: ptr Event00; data: pointer): FilterReturn {.cdecl.}

type
  FrameClockClass00* {.pure.} = object
  FrameClockClass* = ref object
    impl*: ptr FrameClockClass00

type
  FrameClockPrivate00* {.pure.} = object
  FrameClockPrivate* = ref object
    impl*: ptr FrameClockPrivate00

type
  GLError* {.size: sizeof(cint), pure.} = enum
    notAvailable = 0
    unsupportedFormat = 1
    unsupportedProfile = 2

proc gdk_gl_error_quark*(): uint32 {.
    importc: "gdk_gl_error_quark", libprag.}

const KEY_0* = 48'i32

const KEY_1* = 49'i32

const KEY_2* = 50'i32

const KEY_3* = 51'i32

const KEY_3270_AltCursor* = 64784'i32

const KEY_3270_Attn* = 64782'i32

const KEY_3270_BackTab* = 64773'i32

const KEY_3270_ChangeScreen* = 64793'i32

const KEY_3270_Copy* = 64789'i32

const KEY_3270_CursorBlink* = 64783'i32

const KEY_3270_CursorSelect* = 64796'i32

const KEY_3270_DeleteWord* = 64794'i32

const KEY_3270_Duplicate* = 64769'i32

const KEY_3270_Enter* = 64798'i32

const KEY_3270_EraseEOF* = 64774'i32

const KEY_3270_EraseInput* = 64775'i32

const KEY_3270_ExSelect* = 64795'i32

const KEY_3270_FieldMark* = 64770'i32

const KEY_3270_Ident* = 64787'i32

const KEY_3270_Jump* = 64786'i32

const KEY_3270_KeyClick* = 64785'i32

const KEY_3270_Left2* = 64772'i32

const KEY_3270_PA1* = 64778'i32

const KEY_3270_PA2* = 64779'i32

const KEY_3270_PA3* = 64780'i32

const KEY_3270_Play* = 64790'i32

const KEY_3270_PrintScreen* = 64797'i32

const KEY_3270_Quit* = 64777'i32

const KEY_3270_Record* = 64792'i32

const KEY_3270_Reset* = 64776'i32

const KEY_3270_Right2* = 64771'i32

const KEY_3270_Rule* = 64788'i32

const KEY_3270_Setup* = 64791'i32

const KEY_3270_Test* = 64781'i32

const KEY_4* = 52'i32

const KEY_5* = 53'i32

const KEY_6* = 54'i32

const KEY_7* = 55'i32

const KEY_8* = 56'i32

const KEY_9* = 57'i32

const UKEY_A* = 65'i32

const UKEY_AE* = 198'i32

const UKEY_Aacute* = 193'i32

const UKEY_Abelowdot* = 16785056'i32

const UKEY_Abreve* = 451'i32

const UKEY_Abreveacute* = 16785070'i32

const UKEY_Abrevebelowdot* = 16785078'i32

const UKEY_Abrevegrave* = 16785072'i32

const UKEY_Abrevehook* = 16785074'i32

const UKEY_Abrevetilde* = 16785076'i32

const KEY_AccessX_Enable* = 65136'i32

const KEY_AccessX_Feedback_Enable* = 65137'i32

const UKEY_Acircumflex* = 194'i32

const UKEY_Acircumflexacute* = 16785060'i32

const UKEY_Acircumflexbelowdot* = 16785068'i32

const UKEY_Acircumflexgrave* = 16785062'i32

const UKEY_Acircumflexhook* = 16785064'i32

const UKEY_Acircumflextilde* = 16785066'i32

const KEY_AddFavorite* = 269025081'i32

const UKEY_Adiaeresis* = 196'i32

const UKEY_Agrave* = 192'i32

const UKEY_Ahook* = 16785058'i32

const KEY_Alt_L* = 65513'i32

const KEY_Alt_R* = 65514'i32

const UKEY_Amacron* = 960'i32

const UKEY_Aogonek* = 417'i32

const KEY_ApplicationLeft* = 269025104'i32

const KEY_ApplicationRight* = 269025105'i32

const KEY_Arabic_0* = 16778848'i32

const KEY_Arabic_1* = 16778849'i32

const KEY_Arabic_2* = 16778850'i32

const KEY_Arabic_3* = 16778851'i32

const KEY_Arabic_4* = 16778852'i32

const KEY_Arabic_5* = 16778853'i32

const KEY_Arabic_6* = 16778854'i32

const KEY_Arabic_7* = 16778855'i32

const KEY_Arabic_8* = 16778856'i32

const KEY_Arabic_9* = 16778857'i32

const KEY_Arabic_ain* = 1497'i32

const KEY_Arabic_alef* = 1479'i32

const KEY_Arabic_alefmaksura* = 1513'i32

const KEY_Arabic_beh* = 1480'i32

const KEY_Arabic_comma* = 1452'i32

const KEY_Arabic_dad* = 1494'i32

const KEY_Arabic_dal* = 1487'i32

const KEY_Arabic_damma* = 1519'i32

const KEY_Arabic_dammatan* = 1516'i32

const KEY_Arabic_ddal* = 16778888'i32

const KEY_Arabic_farsi_yeh* = 16778956'i32

const KEY_Arabic_fatha* = 1518'i32

const KEY_Arabic_fathatan* = 1515'i32

const KEY_Arabic_feh* = 1505'i32

const KEY_Arabic_fullstop* = 16778964'i32

const KEY_Arabic_gaf* = 16778927'i32

const KEY_Arabic_ghain* = 1498'i32

const KEY_Arabic_ha* = 1511'i32

const KEY_Arabic_hah* = 1485'i32

const KEY_Arabic_hamza* = 1473'i32

const KEY_Arabic_hamza_above* = 16778836'i32

const KEY_Arabic_hamza_below* = 16778837'i32

const KEY_Arabic_hamzaonalef* = 1475'i32

const KEY_Arabic_hamzaonwaw* = 1476'i32

const KEY_Arabic_hamzaonyeh* = 1478'i32

const KEY_Arabic_hamzaunderalef* = 1477'i32

const KEY_Arabic_heh* = 1511'i32

const KEY_Arabic_heh_doachashmee* = 16778942'i32

const KEY_Arabic_heh_goal* = 16778945'i32

const KEY_Arabic_jeem* = 1484'i32

const KEY_Arabic_jeh* = 16778904'i32

const KEY_Arabic_kaf* = 1507'i32

const KEY_Arabic_kasra* = 1520'i32

const KEY_Arabic_kasratan* = 1517'i32

const KEY_Arabic_keheh* = 16778921'i32

const KEY_Arabic_khah* = 1486'i32

const KEY_Arabic_lam* = 1508'i32

const KEY_Arabic_madda_above* = 16778835'i32

const KEY_Arabic_maddaonalef* = 1474'i32

const KEY_Arabic_meem* = 1509'i32

const KEY_Arabic_noon* = 1510'i32

const KEY_Arabic_noon_ghunna* = 16778938'i32

const KEY_Arabic_peh* = 16778878'i32

const KEY_Arabic_percent* = 16778858'i32

const KEY_Arabic_qaf* = 1506'i32

const KEY_Arabic_question_mark* = 1471'i32

const KEY_Arabic_ra* = 1489'i32

const KEY_Arabic_rreh* = 16778897'i32

const KEY_Arabic_sad* = 1493'i32

const KEY_Arabic_seen* = 1491'i32

const KEY_Arabic_semicolon* = 1467'i32

const KEY_Arabic_shadda* = 1521'i32

const KEY_Arabic_sheen* = 1492'i32

const KEY_Arabic_sukun* = 1522'i32

const KEY_Arabic_superscript_alef* = 16778864'i32

const KEY_Arabic_switch* = 65406'i32

const KEY_Arabic_tah* = 1495'i32

const KEY_Arabic_tatweel* = 1504'i32

const KEY_Arabic_tcheh* = 16778886'i32

const KEY_Arabic_teh* = 1482'i32

const KEY_Arabic_tehmarbuta* = 1481'i32

const KEY_Arabic_thal* = 1488'i32

const KEY_Arabic_theh* = 1483'i32

const KEY_Arabic_tteh* = 16778873'i32

const KEY_Arabic_veh* = 16778916'i32

const KEY_Arabic_waw* = 1512'i32

const KEY_Arabic_yeh* = 1514'i32

const KEY_Arabic_yeh_baree* = 16778962'i32

const KEY_Arabic_zah* = 1496'i32

const KEY_Arabic_zain* = 1490'i32

const UKEY_Aring* = 197'i32

const UKEY_Armenian_AT* = 16778552'i32

const UKEY_Armenian_AYB* = 16778545'i32

const UKEY_Armenian_BEN* = 16778546'i32

const UKEY_Armenian_CHA* = 16778569'i32

const UKEY_Armenian_DA* = 16778548'i32

const UKEY_Armenian_DZA* = 16778561'i32

const UKEY_Armenian_E* = 16778551'i32

const UKEY_Armenian_FE* = 16778582'i32

const UKEY_Armenian_GHAT* = 16778562'i32

const UKEY_Armenian_GIM* = 16778547'i32

const UKEY_Armenian_HI* = 16778565'i32

const UKEY_Armenian_HO* = 16778560'i32

const UKEY_Armenian_INI* = 16778555'i32

const UKEY_Armenian_JE* = 16778571'i32

const UKEY_Armenian_KE* = 16778580'i32

const UKEY_Armenian_KEN* = 16778559'i32

const UKEY_Armenian_KHE* = 16778557'i32

const UKEY_Armenian_LYUN* = 16778556'i32

const UKEY_Armenian_MEN* = 16778564'i32

const UKEY_Armenian_NU* = 16778566'i32

const UKEY_Armenian_O* = 16778581'i32

const UKEY_Armenian_PE* = 16778570'i32

const UKEY_Armenian_PYUR* = 16778579'i32

const UKEY_Armenian_RA* = 16778572'i32

const UKEY_Armenian_RE* = 16778576'i32

const UKEY_Armenian_SE* = 16778573'i32

const UKEY_Armenian_SHA* = 16778567'i32

const UKEY_Armenian_TCHE* = 16778563'i32

const UKEY_Armenian_TO* = 16778553'i32

const UKEY_Armenian_TSA* = 16778558'i32

const UKEY_Armenian_TSO* = 16778577'i32

const UKEY_Armenian_TYUN* = 16778575'i32

const UKEY_Armenian_VEV* = 16778574'i32

const UKEY_Armenian_VO* = 16778568'i32

const UKEY_Armenian_VYUN* = 16778578'i32

const UKEY_Armenian_YECH* = 16778549'i32

const UKEY_Armenian_ZA* = 16778550'i32

const UKEY_Armenian_ZHE* = 16778554'i32

const KEY_Armenian_accent* = 16778587'i32

const KEY_Armenian_amanak* = 16778588'i32

const KEY_Armenian_apostrophe* = 16778586'i32

const KEY_Armenian_at* = 16778600'i32

const KEY_Armenian_ayb* = 16778593'i32

const KEY_Armenian_ben* = 16778594'i32

const KEY_Armenian_but* = 16778589'i32

const KEY_Armenian_cha* = 16778617'i32

const KEY_Armenian_da* = 16778596'i32

const KEY_Armenian_dza* = 16778609'i32

const KEY_Armenian_e* = 16778599'i32

const KEY_Armenian_exclam* = 16778588'i32

const KEY_Armenian_fe* = 16778630'i32

const KEY_Armenian_full_stop* = 16778633'i32

const KEY_Armenian_ghat* = 16778610'i32

const KEY_Armenian_gim* = 16778595'i32

const KEY_Armenian_hi* = 16778613'i32

const KEY_Armenian_ho* = 16778608'i32

const KEY_Armenian_hyphen* = 16778634'i32

const KEY_Armenian_ini* = 16778603'i32

const KEY_Armenian_je* = 16778619'i32

const KEY_Armenian_ke* = 16778628'i32

const KEY_Armenian_ken* = 16778607'i32

const KEY_Armenian_khe* = 16778605'i32

const KEY_Armenian_ligature_ew* = 16778631'i32

const KEY_Armenian_lyun* = 16778604'i32

const KEY_Armenian_men* = 16778612'i32

const KEY_Armenian_nu* = 16778614'i32

const KEY_Armenian_o* = 16778629'i32

const KEY_Armenian_paruyk* = 16778590'i32

const KEY_Armenian_pe* = 16778618'i32

const KEY_Armenian_pyur* = 16778627'i32

const KEY_Armenian_question* = 16778590'i32

const KEY_Armenian_ra* = 16778620'i32

const KEY_Armenian_re* = 16778624'i32

const KEY_Armenian_se* = 16778621'i32

const KEY_Armenian_separation_mark* = 16778589'i32

const KEY_Armenian_sha* = 16778615'i32

const KEY_Armenian_shesht* = 16778587'i32

const KEY_Armenian_tche* = 16778611'i32

const KEY_Armenian_to* = 16778601'i32

const KEY_Armenian_tsa* = 16778606'i32

const KEY_Armenian_tso* = 16778625'i32

const KEY_Armenian_tyun* = 16778623'i32

const KEY_Armenian_verjaket* = 16778633'i32

const KEY_Armenian_vev* = 16778622'i32

const KEY_Armenian_vo* = 16778616'i32

const KEY_Armenian_vyun* = 16778626'i32

const KEY_Armenian_yech* = 16778597'i32

const KEY_Armenian_yentamna* = 16778634'i32

const KEY_Armenian_za* = 16778598'i32

const KEY_Armenian_zhe* = 16778602'i32

const UKEY_Atilde* = 195'i32

const KEY_AudibleBell_Enable* = 65146'i32

const KEY_AudioCycleTrack* = 269025179'i32

const KEY_AudioForward* = 269025175'i32

const KEY_AudioLowerVolume* = 269025041'i32

const KEY_AudioMedia* = 269025074'i32

const KEY_AudioMicMute* = 269025202'i32

const KEY_AudioMute* = 269025042'i32

const KEY_AudioNext* = 269025047'i32

const KEY_AudioPause* = 269025073'i32

const KEY_AudioPlay* = 269025044'i32

const KEY_AudioPrev* = 269025046'i32

const KEY_AudioRaiseVolume* = 269025043'i32

const KEY_AudioRandomPlay* = 269025177'i32

const KEY_AudioRecord* = 269025052'i32

const KEY_AudioRepeat* = 269025176'i32

const KEY_AudioRewind* = 269025086'i32

const KEY_AudioStop* = 269025045'i32

const KEY_Away* = 269025165'i32

const UKEY_B* = 66'i32

const UKEY_Babovedot* = 16784898'i32

const KEY_Back* = 269025062'i32

const KEY_BackForward* = 269025087'i32

const KEY_BackSpace* = 65288'i32

const KEY_Battery* = 269025171'i32

const KEY_Begin* = 65368'i32

const KEY_Blue* = 269025190'i32

const KEY_Bluetooth* = 269025172'i32

const KEY_Book* = 269025106'i32

const KEY_BounceKeys_Enable* = 65140'i32

const KEY_Break* = 65387'i32

const KEY_BrightnessAdjust* = 269025083'i32

const UKEY_Byelorussian_SHORTU* = 1726'i32

const KEY_Byelorussian_shortu* = 1710'i32

const UKEY_C* = 67'i32

const KEY_CD* = 269025107'i32

const KEY_CH6* = 65186'i32

const KEY_C_H9* = 65189'i32

const KEY_C_h8* = 65188'i32

const UKEY_Cabovedot* = 709'i32

const UKEY_Cacute* = 454'i32

const KEY_Calculator* = 269025053'i32

const KEY_Calendar* = 269025056'i32

const KEY_Cancel* = 65385'i32

const KEY_Caps_Lock* = 65509'i32

const UKEY_Ccaron* = 456'i32

const UKEY_Ccedilla* = 199'i32

const UKEY_Ccircumflex* = 710'i32

const KEY_Ch5* = 65185'i32

const KEY_Clear* = 65291'i32

const KEY_ClearGrab* = 269024801'i32

const KEY_Close* = 269025110'i32

const KEY_Codeinput* = 65335'i32

const KEY_ColonSign* = 16785569'i32

const KEY_Community* = 269025085'i32

const KEY_ContrastAdjust* = 269025058'i32

const KEY_Control_L* = 65507'i32

const KEY_Control_R* = 65508'i32

const KEY_Copy* = 269025111'i32

const KEY_CruzeiroSign* = 16785570'i32

const KEY_Cut* = 269025112'i32

const KEY_CycleAngle* = 269025180'i32

const UKEY_Cyrillic_A* = 1761'i32

const UKEY_Cyrillic_BE* = 1762'i32

const UKEY_Cyrillic_CHE* = 1790'i32

const UKEY_Cyrillic_CHE_descender* = 16778422'i32

const UKEY_Cyrillic_CHE_vertstroke* = 16778424'i32

const UKEY_Cyrillic_DE* = 1764'i32

const UKEY_Cyrillic_DZHE* = 1727'i32

const UKEY_Cyrillic_E* = 1788'i32

const UKEY_Cyrillic_EF* = 1766'i32

const UKEY_Cyrillic_EL* = 1772'i32

const UKEY_Cyrillic_EM* = 1773'i32

const UKEY_Cyrillic_EN* = 1774'i32

const UKEY_Cyrillic_EN_descender* = 16778402'i32

const UKEY_Cyrillic_ER* = 1778'i32

const UKEY_Cyrillic_ES* = 1779'i32

const UKEY_Cyrillic_GHE* = 1767'i32

const UKEY_Cyrillic_GHE_bar* = 16778386'i32

const UKEY_Cyrillic_HA* = 1768'i32

const UKEY_Cyrillic_HARDSIGN* = 1791'i32

const UKEY_Cyrillic_HA_descender* = 16778418'i32

const UKEY_Cyrillic_I* = 1769'i32

const UKEY_Cyrillic_IE* = 1765'i32

const UKEY_Cyrillic_IO* = 1715'i32

const UKEY_Cyrillic_I_macron* = 16778466'i32

const UKEY_Cyrillic_JE* = 1720'i32

const UKEY_Cyrillic_KA* = 1771'i32

const UKEY_Cyrillic_KA_descender* = 16778394'i32

const UKEY_Cyrillic_KA_vertstroke* = 16778396'i32

const UKEY_Cyrillic_LJE* = 1721'i32

const UKEY_Cyrillic_NJE* = 1722'i32

const UKEY_Cyrillic_O* = 1775'i32

const UKEY_Cyrillic_O_bar* = 16778472'i32

const UKEY_Cyrillic_PE* = 1776'i32

const UKEY_Cyrillic_SCHWA* = 16778456'i32

const UKEY_Cyrillic_SHA* = 1787'i32

const UKEY_Cyrillic_SHCHA* = 1789'i32

const UKEY_Cyrillic_SHHA* = 16778426'i32

const UKEY_Cyrillic_SHORTI* = 1770'i32

const UKEY_Cyrillic_SOFTSIGN* = 1784'i32

const UKEY_Cyrillic_TE* = 1780'i32

const UKEY_Cyrillic_TSE* = 1763'i32

const UKEY_Cyrillic_U* = 1781'i32

const UKEY_Cyrillic_U_macron* = 16778478'i32

const UKEY_Cyrillic_U_straight* = 16778414'i32

const UKEY_Cyrillic_U_straight_bar* = 16778416'i32

const UKEY_Cyrillic_VE* = 1783'i32

const UKEY_Cyrillic_YA* = 1777'i32

const UKEY_Cyrillic_YERU* = 1785'i32

const UKEY_Cyrillic_YU* = 1760'i32

const UKEY_Cyrillic_ZE* = 1786'i32

const UKEY_Cyrillic_ZHE* = 1782'i32

const UKEY_Cyrillic_ZHE_descender* = 16778390'i32

const KEY_Cyrillic_a* = 1729'i32

const KEY_Cyrillic_be* = 1730'i32

const KEY_Cyrillic_che* = 1758'i32

const KEY_Cyrillic_che_descender* = 16778423'i32

const KEY_Cyrillic_che_vertstroke* = 16778425'i32

const KEY_Cyrillic_de* = 1732'i32

const KEY_Cyrillic_dzhe* = 1711'i32

const KEY_Cyrillic_e* = 1756'i32

const KEY_Cyrillic_ef* = 1734'i32

const KEY_Cyrillic_el* = 1740'i32

const KEY_Cyrillic_em* = 1741'i32

const KEY_Cyrillic_en* = 1742'i32

const KEY_Cyrillic_en_descender* = 16778403'i32

const KEY_Cyrillic_er* = 1746'i32

const KEY_Cyrillic_es* = 1747'i32

const KEY_Cyrillic_ghe* = 1735'i32

const KEY_Cyrillic_ghe_bar* = 16778387'i32

const KEY_Cyrillic_ha* = 1736'i32

const KEY_Cyrillic_ha_descender* = 16778419'i32

const KEY_Cyrillic_hardsign* = 1759'i32

const KEY_Cyrillic_i* = 1737'i32

const KEY_Cyrillic_i_macron* = 16778467'i32

const KEY_Cyrillic_ie* = 1733'i32

const KEY_Cyrillic_io* = 1699'i32

const KEY_Cyrillic_je* = 1704'i32

const KEY_Cyrillic_ka* = 1739'i32

const KEY_Cyrillic_ka_descender* = 16778395'i32

const KEY_Cyrillic_ka_vertstroke* = 16778397'i32

const KEY_Cyrillic_lje* = 1705'i32

const KEY_Cyrillic_nje* = 1706'i32

const KEY_Cyrillic_o* = 1743'i32

const KEY_Cyrillic_o_bar* = 16778473'i32

const KEY_Cyrillic_pe* = 1744'i32

const KEY_Cyrillic_schwa* = 16778457'i32

const KEY_Cyrillic_sha* = 1755'i32

const KEY_Cyrillic_shcha* = 1757'i32

const KEY_Cyrillic_shha* = 16778427'i32

const KEY_Cyrillic_shorti* = 1738'i32

const KEY_Cyrillic_softsign* = 1752'i32

const KEY_Cyrillic_te* = 1748'i32

const KEY_Cyrillic_tse* = 1731'i32

const KEY_Cyrillic_u* = 1749'i32

const KEY_Cyrillic_u_macron* = 16778479'i32

const KEY_Cyrillic_u_straight* = 16778415'i32

const KEY_Cyrillic_u_straight_bar* = 16778417'i32

const KEY_Cyrillic_ve* = 1751'i32

const KEY_Cyrillic_ya* = 1745'i32

const KEY_Cyrillic_yeru* = 1753'i32

const KEY_Cyrillic_yu* = 1728'i32

const KEY_Cyrillic_ze* = 1754'i32

const KEY_Cyrillic_zhe* = 1750'i32

const KEY_Cyrillic_zhe_descender* = 16778391'i32

const UKEY_D* = 68'i32

const KEY_DOS* = 269025114'i32

const UKEY_Dabovedot* = 16784906'i32

const UKEY_Dcaron* = 463'i32

const KEY_Delete* = 65535'i32

const KEY_Display* = 269025113'i32

const KEY_Documents* = 269025115'i32

const KEY_DongSign* = 16785579'i32

const KEY_Down* = 65364'i32

const UKEY_Dstroke* = 464'i32

const UKEY_E* = 69'i32

const UKEY_ENG* = 957'i32

const XKEY_ETH* = 208'i32

const UKEY_EZH* = 16777655'i32

const UKEY_Eabovedot* = 972'i32

const UKEY_Eacute* = 201'i32

const UKEY_Ebelowdot* = 16785080'i32

const UKEY_Ecaron* = 460'i32

const UKEY_Ecircumflex* = 202'i32

const UKEY_Ecircumflexacute* = 16785086'i32

const UKEY_Ecircumflexbelowdot* = 16785094'i32

const UKEY_Ecircumflexgrave* = 16785088'i32

const UKEY_Ecircumflexhook* = 16785090'i32

const UKEY_Ecircumflextilde* = 16785092'i32

const KEY_EcuSign* = 16785568'i32

const UKEY_Ediaeresis* = 203'i32

const UKEY_Egrave* = 200'i32

const UKEY_Ehook* = 16785082'i32

const KEY_Eisu_Shift* = 65327'i32

const KEY_Eisu_toggle* = 65328'i32

const KEY_Eject* = 269025068'i32

const UKEY_Emacron* = 938'i32

const KEY_End* = 65367'i32

const UKEY_Eogonek* = 458'i32

const KEY_Escape* = 65307'i32

const UKEY_Eth* = 208'i32

const UKEY_Etilde* = 16785084'i32

const KEY_EuroSign* = 8364'i32

const KEY_Excel* = 269025116'i32

const KEY_Execute* = 65378'i32

const KEY_Explorer* = 269025117'i32

const UKEY_F* = 70'i32

const KEY_F1* = 65470'i32

const KEY_F10* = 65479'i32

const KEY_F11* = 65480'i32

const KEY_F12* = 65481'i32

const KEY_F13* = 65482'i32

const KEY_F14* = 65483'i32

const KEY_F15* = 65484'i32

const KEY_F16* = 65485'i32

const KEY_F17* = 65486'i32

const KEY_F18* = 65487'i32

const KEY_F19* = 65488'i32

const KEY_F2* = 65471'i32

const KEY_F20* = 65489'i32

const KEY_F21* = 65490'i32

const KEY_F22* = 65491'i32

const KEY_F23* = 65492'i32

const KEY_F24* = 65493'i32

const KEY_F25* = 65494'i32

const KEY_F26* = 65495'i32

const KEY_F27* = 65496'i32

const KEY_F28* = 65497'i32

const KEY_F29* = 65498'i32

const KEY_F3* = 65472'i32

const KEY_F30* = 65499'i32

const KEY_F31* = 65500'i32

const KEY_F32* = 65501'i32

const KEY_F33* = 65502'i32

const KEY_F34* = 65503'i32

const KEY_F35* = 65504'i32

const KEY_F4* = 65473'i32

const KEY_F5* = 65474'i32

const KEY_F6* = 65475'i32

const KEY_F7* = 65476'i32

const KEY_F8* = 65477'i32

const KEY_F9* = 65478'i32

const KEY_FFrancSign* = 16785571'i32

const UKEY_Fabovedot* = 16784926'i32

const KEY_Farsi_0* = 16778992'i32

const KEY_Farsi_1* = 16778993'i32

const KEY_Farsi_2* = 16778994'i32

const KEY_Farsi_3* = 16778995'i32

const KEY_Farsi_4* = 16778996'i32

const KEY_Farsi_5* = 16778997'i32

const KEY_Farsi_6* = 16778998'i32

const KEY_Farsi_7* = 16778999'i32

const KEY_Farsi_8* = 16779000'i32

const KEY_Farsi_9* = 16779001'i32

const KEY_Farsi_yeh* = 16778956'i32

const KEY_Favorites* = 269025072'i32

const KEY_Finance* = 269025084'i32

const KEY_Find* = 65384'i32

const KEY_First_Virtual_Screen* = 65232'i32

const KEY_Forward* = 269025063'i32

const KEY_FrameBack* = 269025181'i32

const KEY_FrameForward* = 269025182'i32

const UKEY_G* = 71'i32

const UKEY_Gabovedot* = 725'i32

const KEY_Game* = 269025118'i32

const UKEY_Gbreve* = 683'i32

const UKEY_Gcaron* = 16777702'i32

const UKEY_Gcedilla* = 939'i32

const UKEY_Gcircumflex* = 728'i32

const KEY_Georgian_an* = 16781520'i32

const KEY_Georgian_ban* = 16781521'i32

const KEY_Georgian_can* = 16781546'i32

const KEY_Georgian_char* = 16781549'i32

const KEY_Georgian_chin* = 16781545'i32

const KEY_Georgian_cil* = 16781548'i32

const KEY_Georgian_don* = 16781523'i32

const KEY_Georgian_en* = 16781524'i32

const KEY_Georgian_fi* = 16781558'i32

const KEY_Georgian_gan* = 16781522'i32

const KEY_Georgian_ghan* = 16781542'i32

const KEY_Georgian_hae* = 16781552'i32

const KEY_Georgian_har* = 16781556'i32

const KEY_Georgian_he* = 16781553'i32

const KEY_Georgian_hie* = 16781554'i32

const KEY_Georgian_hoe* = 16781557'i32

const KEY_Georgian_in* = 16781528'i32

const KEY_Georgian_jhan* = 16781551'i32

const KEY_Georgian_jil* = 16781547'i32

const KEY_Georgian_kan* = 16781529'i32

const KEY_Georgian_khar* = 16781541'i32

const KEY_Georgian_las* = 16781530'i32

const KEY_Georgian_man* = 16781531'i32

const KEY_Georgian_nar* = 16781532'i32

const KEY_Georgian_on* = 16781533'i32

const KEY_Georgian_par* = 16781534'i32

const KEY_Georgian_phar* = 16781540'i32

const KEY_Georgian_qar* = 16781543'i32

const KEY_Georgian_rae* = 16781536'i32

const KEY_Georgian_san* = 16781537'i32

const KEY_Georgian_shin* = 16781544'i32

const KEY_Georgian_tan* = 16781527'i32

const KEY_Georgian_tar* = 16781538'i32

const KEY_Georgian_un* = 16781539'i32

const KEY_Georgian_vin* = 16781525'i32

const KEY_Georgian_we* = 16781555'i32

const KEY_Georgian_xan* = 16781550'i32

const KEY_Georgian_zen* = 16781526'i32

const KEY_Georgian_zhar* = 16781535'i32

const KEY_Go* = 269025119'i32

const UKEY_Greek_ALPHA* = 1985'i32

const UKEY_Greek_ALPHAaccent* = 1953'i32

const UKEY_Greek_BETA* = 1986'i32

const UKEY_Greek_CHI* = 2007'i32

const UKEY_Greek_DELTA* = 1988'i32

const UKEY_Greek_EPSILON* = 1989'i32

const UKEY_Greek_EPSILONaccent* = 1954'i32

const UKEY_Greek_ETA* = 1991'i32

const UKEY_Greek_ETAaccent* = 1955'i32

const UKEY_Greek_GAMMA* = 1987'i32

const UKEY_Greek_IOTA* = 1993'i32

const UKEY_Greek_IOTAaccent* = 1956'i32

const KEY_Greek_IOTAdiaeresis* = 1957'i32

const UKEY_Greek_IOTAdieresis* = 1957'i32

const UKEY_Greek_KAPPA* = 1994'i32

const UKEY_Greek_LAMBDA* = 1995'i32

const UKEY_Greek_LAMDA* = 1995'i32

const UKEY_Greek_MU* = 1996'i32

const UKEY_Greek_NU* = 1997'i32

const UKEY_Greek_OMEGA* = 2009'i32

const UKEY_Greek_OMEGAaccent* = 1963'i32

const UKEY_Greek_OMICRON* = 1999'i32

const UKEY_Greek_OMICRONaccent* = 1959'i32

const UKEY_Greek_PHI* = 2006'i32

const UKEY_Greek_PI* = 2000'i32

const UKEY_Greek_PSI* = 2008'i32

const UKEY_Greek_RHO* = 2001'i32

const UKEY_Greek_SIGMA* = 2002'i32

const UKEY_Greek_TAU* = 2004'i32

const UKEY_Greek_THETA* = 1992'i32

const UKEY_Greek_UPSILON* = 2005'i32

const UKEY_Greek_UPSILONaccent* = 1960'i32

const UKEY_Greek_UPSILONdieresis* = 1961'i32

const UKEY_Greek_XI* = 1998'i32

const UKEY_Greek_ZETA* = 1990'i32

const KEY_Greek_accentdieresis* = 1966'i32

const KEY_Greek_alpha* = 2017'i32

const KEY_Greek_alphaaccent* = 1969'i32

const KEY_Greek_beta* = 2018'i32

const KEY_Greek_chi* = 2039'i32

const KEY_Greek_delta* = 2020'i32

const KEY_Greek_epsilon* = 2021'i32

const KEY_Greek_epsilonaccent* = 1970'i32

const KEY_Greek_eta* = 2023'i32

const KEY_Greek_etaaccent* = 1971'i32

const KEY_Greek_finalsmallsigma* = 2035'i32

const KEY_Greek_gamma* = 2019'i32

const KEY_Greek_horizbar* = 1967'i32

const KEY_Greek_iota* = 2025'i32

const KEY_Greek_iotaaccent* = 1972'i32

const KEY_Greek_iotaaccentdieresis* = 1974'i32

const KEY_Greek_iotadieresis* = 1973'i32

const KEY_Greek_kappa* = 2026'i32

const KEY_Greek_lambda* = 2027'i32

const KEY_Greek_lamda* = 2027'i32

const KEY_Greek_mu* = 2028'i32

const KEY_Greek_nu* = 2029'i32

const KEY_Greek_omega* = 2041'i32

const KEY_Greek_omegaaccent* = 1979'i32

const KEY_Greek_omicron* = 2031'i32

const KEY_Greek_omicronaccent* = 1975'i32

const KEY_Greek_phi* = 2038'i32

const KEY_Greek_pi* = 2032'i32

const KEY_Greek_psi* = 2040'i32

const KEY_Greek_rho* = 2033'i32

const KEY_Greek_sigma* = 2034'i32

const KEY_Greek_switch* = 65406'i32

const KEY_Greek_tau* = 2036'i32

const KEY_Greek_theta* = 2024'i32

const KEY_Greek_upsilon* = 2037'i32

const KEY_Greek_upsilonaccent* = 1976'i32

const KEY_Greek_upsilonaccentdieresis* = 1978'i32

const KEY_Greek_upsilondieresis* = 1977'i32

const KEY_Greek_xi* = 2030'i32

const KEY_Greek_zeta* = 2022'i32

const KEY_Green* = 269025188'i32

const UKEY_H* = 72'i32

const KEY_Hangul* = 65329'i32

const KEY_Hangul_A* = 3775'i32

const KEY_Hangul_AE* = 3776'i32

const KEY_Hangul_AraeA* = 3830'i32

const KEY_Hangul_AraeAE* = 3831'i32

const KEY_Hangul_Banja* = 65337'i32

const KEY_Hangul_Cieuc* = 3770'i32

const KEY_Hangul_Codeinput* = 65335'i32

const KEY_Hangul_Dikeud* = 3751'i32

const KEY_Hangul_E* = 3780'i32

const KEY_Hangul_EO* = 3779'i32

const KEY_Hangul_EU* = 3793'i32

const KEY_Hangul_End* = 65331'i32

const KEY_Hangul_Hanja* = 65332'i32

const KEY_Hangul_Hieuh* = 3774'i32

const KEY_Hangul_I* = 3795'i32

const KEY_Hangul_Ieung* = 3767'i32

const KEY_Hangul_J_Cieuc* = 3818'i32

const KEY_Hangul_J_Dikeud* = 3802'i32

const KEY_Hangul_J_Hieuh* = 3822'i32

const KEY_Hangul_J_Ieung* = 3816'i32

const KEY_Hangul_J_Jieuj* = 3817'i32

const KEY_Hangul_J_Khieuq* = 3819'i32

const KEY_Hangul_J_Kiyeog* = 3796'i32

const KEY_Hangul_J_KiyeogSios* = 3798'i32

const KEY_Hangul_J_KkogjiDalrinIeung* = 3833'i32

const KEY_Hangul_J_Mieum* = 3811'i32

const KEY_Hangul_J_Nieun* = 3799'i32

const KEY_Hangul_J_NieunHieuh* = 3801'i32

const KEY_Hangul_J_NieunJieuj* = 3800'i32

const KEY_Hangul_J_PanSios* = 3832'i32

const KEY_Hangul_J_Phieuf* = 3821'i32

const KEY_Hangul_J_Pieub* = 3812'i32

const KEY_Hangul_J_PieubSios* = 3813'i32

const KEY_Hangul_J_Rieul* = 3803'i32

const KEY_Hangul_J_RieulHieuh* = 3810'i32

const KEY_Hangul_J_RieulKiyeog* = 3804'i32

const KEY_Hangul_J_RieulMieum* = 3805'i32

const KEY_Hangul_J_RieulPhieuf* = 3809'i32

const KEY_Hangul_J_RieulPieub* = 3806'i32

const KEY_Hangul_J_RieulSios* = 3807'i32

const KEY_Hangul_J_RieulTieut* = 3808'i32

const KEY_Hangul_J_Sios* = 3814'i32

const KEY_Hangul_J_SsangKiyeog* = 3797'i32

const KEY_Hangul_J_SsangSios* = 3815'i32

const KEY_Hangul_J_Tieut* = 3820'i32

const KEY_Hangul_J_YeorinHieuh* = 3834'i32

const KEY_Hangul_Jamo* = 65333'i32

const KEY_Hangul_Jeonja* = 65336'i32

const KEY_Hangul_Jieuj* = 3768'i32

const KEY_Hangul_Khieuq* = 3771'i32

const KEY_Hangul_Kiyeog* = 3745'i32

const KEY_Hangul_KiyeogSios* = 3747'i32

const KEY_Hangul_KkogjiDalrinIeung* = 3827'i32

const KEY_Hangul_Mieum* = 3761'i32

const KEY_Hangul_MultipleCandidate* = 65341'i32

const KEY_Hangul_Nieun* = 3748'i32

const KEY_Hangul_NieunHieuh* = 3750'i32

const KEY_Hangul_NieunJieuj* = 3749'i32

const KEY_Hangul_O* = 3783'i32

const KEY_Hangul_OE* = 3786'i32

const KEY_Hangul_PanSios* = 3826'i32

const KEY_Hangul_Phieuf* = 3773'i32

const KEY_Hangul_Pieub* = 3762'i32

const KEY_Hangul_PieubSios* = 3764'i32

const KEY_Hangul_PostHanja* = 65339'i32

const KEY_Hangul_PreHanja* = 65338'i32

const KEY_Hangul_PreviousCandidate* = 65342'i32

const KEY_Hangul_Rieul* = 3753'i32

const KEY_Hangul_RieulHieuh* = 3760'i32

const KEY_Hangul_RieulKiyeog* = 3754'i32

const KEY_Hangul_RieulMieum* = 3755'i32

const KEY_Hangul_RieulPhieuf* = 3759'i32

const KEY_Hangul_RieulPieub* = 3756'i32

const KEY_Hangul_RieulSios* = 3757'i32

const KEY_Hangul_RieulTieut* = 3758'i32

const KEY_Hangul_RieulYeorinHieuh* = 3823'i32

const KEY_Hangul_Romaja* = 65334'i32

const KEY_Hangul_SingleCandidate* = 65340'i32

const KEY_Hangul_Sios* = 3765'i32

const KEY_Hangul_Special* = 65343'i32

const KEY_Hangul_SsangDikeud* = 3752'i32

const KEY_Hangul_SsangJieuj* = 3769'i32

const KEY_Hangul_SsangKiyeog* = 3746'i32

const KEY_Hangul_SsangPieub* = 3763'i32

const KEY_Hangul_SsangSios* = 3766'i32

const KEY_Hangul_Start* = 65330'i32

const KEY_Hangul_SunkyeongeumMieum* = 3824'i32

const KEY_Hangul_SunkyeongeumPhieuf* = 3828'i32

const KEY_Hangul_SunkyeongeumPieub* = 3825'i32

const KEY_Hangul_Tieut* = 3772'i32

const KEY_Hangul_U* = 3788'i32

const KEY_Hangul_WA* = 3784'i32

const KEY_Hangul_WAE* = 3785'i32

const KEY_Hangul_WE* = 3790'i32

const KEY_Hangul_WEO* = 3789'i32

const KEY_Hangul_WI* = 3791'i32

const KEY_Hangul_YA* = 3777'i32

const KEY_Hangul_YAE* = 3778'i32

const KEY_Hangul_YE* = 3782'i32

const KEY_Hangul_YEO* = 3781'i32

const KEY_Hangul_YI* = 3794'i32

const KEY_Hangul_YO* = 3787'i32

const KEY_Hangul_YU* = 3792'i32

const KEY_Hangul_YeorinHieuh* = 3829'i32

const KEY_Hangul_switch* = 65406'i32

const KEY_Hankaku* = 65321'i32

const UKEY_Hcircumflex* = 678'i32

const KEY_Hebrew_switch* = 65406'i32

const KEY_Help* = 65386'i32

const KEY_Henkan* = 65315'i32

const KEY_Henkan_Mode* = 65315'i32

const KEY_Hibernate* = 269025192'i32

const KEY_Hiragana* = 65317'i32

const KEY_Hiragana_Katakana* = 65319'i32

const KEY_History* = 269025079'i32

const KEY_Home* = 65360'i32

const KEY_HomePage* = 269025048'i32

const KEY_HotLinks* = 269025082'i32

const UKEY_Hstroke* = 673'i32

const KEY_Hyper_L* = 65517'i32

const KEY_Hyper_R* = 65518'i32

const UKEY_I* = 73'i32

const KEY_ISO_Center_Object* = 65075'i32

const KEY_ISO_Continuous_Underline* = 65072'i32

const KEY_ISO_Discontinuous_Underline* = 65073'i32

const KEY_ISO_Emphasize* = 65074'i32

const KEY_ISO_Enter* = 65076'i32

const KEY_ISO_Fast_Cursor_Down* = 65071'i32

const KEY_ISO_Fast_Cursor_Left* = 65068'i32

const KEY_ISO_Fast_Cursor_Right* = 65069'i32

const KEY_ISO_Fast_Cursor_Up* = 65070'i32

const KEY_ISO_First_Group* = 65036'i32

const KEY_ISO_First_Group_Lock* = 65037'i32

const KEY_ISO_Group_Latch* = 65030'i32

const KEY_ISO_Group_Lock* = 65031'i32

const KEY_ISO_Group_Shift* = 65406'i32

const KEY_ISO_Last_Group* = 65038'i32

const KEY_ISO_Last_Group_Lock* = 65039'i32

const KEY_ISO_Left_Tab* = 65056'i32

const KEY_ISO_Level2_Latch* = 65026'i32

const KEY_ISO_Level3_Latch* = 65028'i32

const KEY_ISO_Level3_Lock* = 65029'i32

const KEY_ISO_Level3_Shift* = 65027'i32

const KEY_ISO_Level5_Latch* = 65042'i32

const KEY_ISO_Level5_Lock* = 65043'i32

const KEY_ISO_Level5_Shift* = 65041'i32

const KEY_ISO_Lock* = 65025'i32

const KEY_ISO_Move_Line_Down* = 65058'i32

const KEY_ISO_Move_Line_Up* = 65057'i32

const KEY_ISO_Next_Group* = 65032'i32

const KEY_ISO_Next_Group_Lock* = 65033'i32

const KEY_ISO_Partial_Line_Down* = 65060'i32

const KEY_ISO_Partial_Line_Up* = 65059'i32

const KEY_ISO_Partial_Space_Left* = 65061'i32

const KEY_ISO_Partial_Space_Right* = 65062'i32

const KEY_ISO_Prev_Group* = 65034'i32

const KEY_ISO_Prev_Group_Lock* = 65035'i32

const KEY_ISO_Release_Both_Margins* = 65067'i32

const KEY_ISO_Release_Margin_Left* = 65065'i32

const KEY_ISO_Release_Margin_Right* = 65066'i32

const KEY_ISO_Set_Margin_Left* = 65063'i32

const KEY_ISO_Set_Margin_Right* = 65064'i32

const KEY_Iabovedot* = 681'i32

const UKEY_Iacute* = 205'i32

const UKEY_Ibelowdot* = 16785098'i32

const UKEY_Ibreve* = 16777516'i32

const UKEY_Icircumflex* = 206'i32

const UKEY_Idiaeresis* = 207'i32

const UKEY_Igrave* = 204'i32

const UKEY_Ihook* = 16785096'i32

const UKEY_Imacron* = 975'i32

const KEY_Insert* = 65379'i32

const UKEY_Iogonek* = 967'i32

const UKEY_Itilde* = 933'i32

const UKEY_J* = 74'i32

const UKEY_Jcircumflex* = 684'i32

const UKEY_K* = 75'i32

const KEY_KP_0* = 65456'i32

const KEY_KP_1* = 65457'i32

const KEY_KP_2* = 65458'i32

const KEY_KP_3* = 65459'i32

const KEY_KP_4* = 65460'i32

const KEY_KP_5* = 65461'i32

const KEY_KP_6* = 65462'i32

const KEY_KP_7* = 65463'i32

const KEY_KP_8* = 65464'i32

const KEY_KP_9* = 65465'i32

const KEY_KP_Add* = 65451'i32

const KEY_KP_Begin* = 65437'i32

const KEY_KP_Decimal* = 65454'i32

const KEY_KP_Delete* = 65439'i32

const KEY_KP_Divide* = 65455'i32

const KEY_KP_Down* = 65433'i32

const KEY_KP_End* = 65436'i32

const KEY_KP_Enter* = 65421'i32

const KEY_KP_Equal* = 65469'i32

const KEY_KP_F1* = 65425'i32

const KEY_KP_F2* = 65426'i32

const KEY_KP_F3* = 65427'i32

const KEY_KP_F4* = 65428'i32

const KEY_KP_Home* = 65429'i32

const KEY_KP_Insert* = 65438'i32

const KEY_KP_Left* = 65430'i32

const KEY_KP_Multiply* = 65450'i32

const KEY_KP_Next* = 65435'i32

const KEY_KP_Page_Down* = 65435'i32

const KEY_KP_Page_Up* = 65434'i32

const KEY_KP_Prior* = 65434'i32

const KEY_KP_Right* = 65432'i32

const KEY_KP_Separator* = 65452'i32

const KEY_KP_Space* = 65408'i32

const KEY_KP_Subtract* = 65453'i32

const KEY_KP_Tab* = 65417'i32

const KEY_KP_Up* = 65431'i32

const KEY_Kana_Lock* = 65325'i32

const KEY_Kana_Shift* = 65326'i32

const KEY_Kanji* = 65313'i32

const KEY_Kanji_Bangou* = 65335'i32

const KEY_Katakana* = 65318'i32

const KEY_KbdBrightnessDown* = 269025030'i32

const KEY_KbdBrightnessUp* = 269025029'i32

const KEY_KbdLightOnOff* = 269025028'i32

const UKEY_Kcedilla* = 979'i32

const KEY_Korean_Won* = 3839'i32

const UKEY_L* = 76'i32

const KEY_L1* = 65480'i32

const KEY_L10* = 65489'i32

const KEY_L2* = 65481'i32

const KEY_L3* = 65482'i32

const KEY_L4* = 65483'i32

const KEY_L5* = 65484'i32

const KEY_L6* = 65485'i32

const KEY_L7* = 65486'i32

const KEY_L8* = 65487'i32

const KEY_L9* = 65488'i32

const UKEY_Lacute* = 453'i32

const KEY_Last_Virtual_Screen* = 65236'i32

const KEY_Launch0* = 269025088'i32

const KEY_Launch1* = 269025089'i32

const KEY_Launch2* = 269025090'i32

const KEY_Launch3* = 269025091'i32

const KEY_Launch4* = 269025092'i32

const KEY_Launch5* = 269025093'i32

const KEY_Launch6* = 269025094'i32

const KEY_Launch7* = 269025095'i32

const KEY_Launch8* = 269025096'i32

const KEY_Launch9* = 269025097'i32

const KEY_LaunchA* = 269025098'i32

const KEY_LaunchB* = 269025099'i32

const KEY_LaunchC* = 269025100'i32

const KEY_LaunchD* = 269025101'i32

const KEY_LaunchE* = 269025102'i32

const KEY_LaunchF* = 269025103'i32

const UKEY_Lbelowdot* = 16784950'i32

const UKEY_Lcaron* = 421'i32

const UKEY_Lcedilla* = 934'i32

const KEY_Left* = 65361'i32

const KEY_LightBulb* = 269025077'i32

const KEY_Linefeed* = 65290'i32

const KEY_LiraSign* = 16785572'i32

const KEY_LogGrabInfo* = 269024805'i32

const KEY_LogOff* = 269025121'i32

const KEY_LogWindowTree* = 269024804'i32

const UKEY_Lstroke* = 419'i32

const UKEY_M* = 77'i32

const UKEY_Mabovedot* = 16784960'i32

const UKEY_Macedonia_DSE* = 1717'i32

const UKEY_Macedonia_GJE* = 1714'i32

const UKEY_Macedonia_KJE* = 1724'i32

const KEY_Macedonia_dse* = 1701'i32

const KEY_Macedonia_gje* = 1698'i32

const KEY_Macedonia_kje* = 1708'i32

const KEY_Mae_Koho* = 65342'i32

const KEY_Mail* = 269025049'i32

const KEY_MailForward* = 269025168'i32

const KEY_Market* = 269025122'i32

const KEY_Massyo* = 65324'i32

const KEY_Meeting* = 269025123'i32

const KEY_Memo* = 269025054'i32

const KEY_Menu* = 65383'i32

const KEY_MenuKB* = 269025125'i32

const KEY_MenuPB* = 269025126'i32

const KEY_Messenger* = 269025166'i32

const KEY_Meta_L* = 65511'i32

const KEY_Meta_R* = 65512'i32

const KEY_MillSign* = 16785573'i32

const KEY_ModeLock* = 269025025'i32

const KEY_Mode_switch* = 65406'i32

const KEY_MonBrightnessDown* = 269025027'i32

const KEY_MonBrightnessUp* = 269025026'i32

const KEY_MouseKeys_Accel_Enable* = 65143'i32

const KEY_MouseKeys_Enable* = 65142'i32

const KEY_Muhenkan* = 65314'i32

const KEY_Multi_key* = 65312'i32

const KEY_MultipleCandidate* = 65341'i32

const KEY_Music* = 269025170'i32

const KEY_MyComputer* = 269025075'i32

const KEY_MySites* = 269025127'i32

const UKEY_N* = 78'i32

const UKEY_Nacute* = 465'i32

const KEY_NairaSign* = 16785574'i32

const UKEY_Ncaron* = 466'i32

const UKEY_Ncedilla* = 977'i32

const KEY_New* = 269025128'i32

const KEY_NewSheqelSign* = 16785578'i32

const KEY_News* = 269025129'i32

const KEY_Next* = 65366'i32

const KEY_Next_VMode* = 269024802'i32

const KEY_Next_Virtual_Screen* = 65234'i32

const UKEY_Ntilde* = 209'i32

const KEY_Num_Lock* = 65407'i32

const UKEY_O* = 79'i32

const UKEY_OE* = 5052'i32

const UKEY_Oacute* = 211'i32

const UKEY_Obarred* = 16777631'i32

const UKEY_Obelowdot* = 16785100'i32

const UKEY_Ocaron* = 16777681'i32

const UKEY_Ocircumflex* = 212'i32

const UKEY_Ocircumflexacute* = 16785104'i32

const UKEY_Ocircumflexbelowdot* = 16785112'i32

const UKEY_Ocircumflexgrave* = 16785106'i32

const UKEY_Ocircumflexhook* = 16785108'i32

const UKEY_Ocircumflextilde* = 16785110'i32

const UKEY_Odiaeresis* = 214'i32

const UKEY_Odoubleacute* = 469'i32

const KEY_OfficeHome* = 269025130'i32

const UKEY_Ograve* = 210'i32

const UKEY_Ohook* = 16785102'i32

const UKEY_Ohorn* = 16777632'i32

const UKEY_Ohornacute* = 16785114'i32

const UKEY_Ohornbelowdot* = 16785122'i32

const UKEY_Ohorngrave* = 16785116'i32

const UKEY_Ohornhook* = 16785118'i32

const UKEY_Ohorntilde* = 16785120'i32

const UKEY_Omacron* = 978'i32

const UKEY_Ooblique* = 216'i32

const KEY_Open* = 269025131'i32

const KEY_OpenURL* = 269025080'i32

const KEY_Option* = 269025132'i32

const UKEY_Oslash* = 216'i32

const UKEY_Otilde* = 213'i32

const KEY_Overlay1_Enable* = 65144'i32

const KEY_Overlay2_Enable* = 65145'i32

const UKEY_P* = 80'i32

const UKEY_Pabovedot* = 16784982'i32

const KEY_Page_Down* = 65366'i32

const KEY_Page_Up* = 65365'i32

const KEY_Paste* = 269025133'i32

const KEY_Pause* = 65299'i32

const KEY_PesetaSign* = 16785575'i32

const KEY_Phone* = 269025134'i32

const KEY_Pictures* = 269025169'i32

const KEY_Pointer_Accelerate* = 65274'i32

const KEY_Pointer_Button1* = 65257'i32

const KEY_Pointer_Button2* = 65258'i32

const KEY_Pointer_Button3* = 65259'i32

const KEY_Pointer_Button4* = 65260'i32

const KEY_Pointer_Button5* = 65261'i32

const KEY_Pointer_Button_Dflt* = 65256'i32

const KEY_Pointer_DblClick1* = 65263'i32

const KEY_Pointer_DblClick2* = 65264'i32

const KEY_Pointer_DblClick3* = 65265'i32

const KEY_Pointer_DblClick4* = 65266'i32

const KEY_Pointer_DblClick5* = 65267'i32

const KEY_Pointer_DblClick_Dflt* = 65262'i32

const KEY_Pointer_DfltBtnNext* = 65275'i32

const KEY_Pointer_DfltBtnPrev* = 65276'i32

const KEY_Pointer_Down* = 65251'i32

const KEY_Pointer_DownLeft* = 65254'i32

const KEY_Pointer_DownRight* = 65255'i32

const KEY_Pointer_Drag1* = 65269'i32

const KEY_Pointer_Drag2* = 65270'i32

const KEY_Pointer_Drag3* = 65271'i32

const KEY_Pointer_Drag4* = 65272'i32

const KEY_Pointer_Drag5* = 65277'i32

const KEY_Pointer_Drag_Dflt* = 65268'i32

const KEY_Pointer_EnableKeys* = 65273'i32

const KEY_Pointer_Left* = 65248'i32

const KEY_Pointer_Right* = 65249'i32

const KEY_Pointer_Up* = 65250'i32

const KEY_Pointer_UpLeft* = 65252'i32

const KEY_Pointer_UpRight* = 65253'i32

const KEY_PowerDown* = 269025057'i32

const KEY_PowerOff* = 269025066'i32

const KEY_Prev_VMode* = 269024803'i32

const KEY_Prev_Virtual_Screen* = 65233'i32

const KEY_PreviousCandidate* = 65342'i32

const KEY_Print* = 65377'i32

const KEY_Prior* = 65365'i32

const UKEY_Q* = 81'i32

const UKEY_R* = 82'i32

const KEY_R1* = 65490'i32

const KEY_R10* = 65499'i32

const KEY_R11* = 65500'i32

const KEY_R12* = 65501'i32

const KEY_R13* = 65502'i32

const KEY_R14* = 65503'i32

const KEY_R15* = 65504'i32

const KEY_R2* = 65491'i32

const KEY_R3* = 65492'i32

const KEY_R4* = 65493'i32

const KEY_R5* = 65494'i32

const KEY_R6* = 65495'i32

const KEY_R7* = 65496'i32

const KEY_R8* = 65497'i32

const KEY_R9* = 65498'i32

const UKEY_Racute* = 448'i32

const UKEY_Rcaron* = 472'i32

const UKEY_Rcedilla* = 931'i32

const KEY_Red* = 269025187'i32

const KEY_Redo* = 65382'i32

const KEY_Refresh* = 269025065'i32

const KEY_Reload* = 269025139'i32

const KEY_RepeatKeys_Enable* = 65138'i32

const KEY_Reply* = 269025138'i32

const KEY_Return* = 65293'i32

const KEY_Right* = 65363'i32

const KEY_RockerDown* = 269025060'i32

const KEY_RockerEnter* = 269025061'i32

const KEY_RockerUp* = 269025059'i32

const KEY_Romaji* = 65316'i32

const KEY_RotateWindows* = 269025140'i32

const KEY_RotationKB* = 269025142'i32

const KEY_RotationPB* = 269025141'i32

const KEY_RupeeSign* = 16785576'i32

const UKEY_S* = 83'i32

const UKEY_SCHWA* = 16777615'i32

const UKEY_Sabovedot* = 16784992'i32

const UKEY_Sacute* = 422'i32

const KEY_Save* = 269025143'i32

const UKEY_Scaron* = 425'i32

const UKEY_Scedilla* = 426'i32

const UKEY_Scircumflex* = 734'i32

const KEY_ScreenSaver* = 269025069'i32

const KEY_ScrollClick* = 269025146'i32

const KEY_ScrollDown* = 269025145'i32

const KEY_ScrollUp* = 269025144'i32

const KEY_Scroll_Lock* = 65300'i32

const KEY_Search* = 269025051'i32

const KEY_Select* = 65376'i32

const KEY_SelectButton* = 269025184'i32

const KEY_Send* = 269025147'i32

const UKEY_Serbian_DJE* = 1713'i32

const UKEY_Serbian_DZE* = 1727'i32

const UKEY_Serbian_JE* = 1720'i32

const UKEY_Serbian_LJE* = 1721'i32

const UKEY_Serbian_NJE* = 1722'i32

const UKEY_Serbian_TSHE* = 1723'i32

const KEY_Serbian_dje* = 1697'i32

const KEY_Serbian_dze* = 1711'i32

const KEY_Serbian_je* = 1704'i32

const KEY_Serbian_lje* = 1705'i32

const KEY_Serbian_nje* = 1706'i32

const KEY_Serbian_tshe* = 1707'i32

const KEY_Shift_L* = 65505'i32

const KEY_Shift_Lock* = 65510'i32

const KEY_Shift_R* = 65506'i32

const KEY_Shop* = 269025078'i32

const KEY_SingleCandidate* = 65340'i32

const KEY_Sinh_a* = 16780677'i32

const KEY_Sinh_aa* = 16780678'i32

const KEY_Sinh_aa2* = 16780751'i32

const KEY_Sinh_ae* = 16780679'i32

const KEY_Sinh_ae2* = 16780752'i32

const KEY_Sinh_aee* = 16780680'i32

const KEY_Sinh_aee2* = 16780753'i32

const KEY_Sinh_ai* = 16780691'i32

const KEY_Sinh_ai2* = 16780763'i32

const KEY_Sinh_al* = 16780746'i32

const KEY_Sinh_au* = 16780694'i32

const KEY_Sinh_au2* = 16780766'i32

const KEY_Sinh_ba* = 16780726'i32

const KEY_Sinh_bha* = 16780727'i32

const KEY_Sinh_ca* = 16780704'i32

const KEY_Sinh_cha* = 16780705'i32

const KEY_Sinh_dda* = 16780713'i32

const KEY_Sinh_ddha* = 16780714'i32

const KEY_Sinh_dha* = 16780719'i32

const KEY_Sinh_dhha* = 16780720'i32

const KEY_Sinh_e* = 16780689'i32

const KEY_Sinh_e2* = 16780761'i32

const KEY_Sinh_ee* = 16780690'i32

const KEY_Sinh_ee2* = 16780762'i32

const KEY_Sinh_fa* = 16780742'i32

const KEY_Sinh_ga* = 16780700'i32

const KEY_Sinh_gha* = 16780701'i32

const KEY_Sinh_h2* = 16780675'i32

const KEY_Sinh_ha* = 16780740'i32

const KEY_Sinh_i* = 16780681'i32

const KEY_Sinh_i2* = 16780754'i32

const KEY_Sinh_ii* = 16780682'i32

const KEY_Sinh_ii2* = 16780755'i32

const KEY_Sinh_ja* = 16780706'i32

const KEY_Sinh_jha* = 16780707'i32

const KEY_Sinh_jnya* = 16780709'i32

const KEY_Sinh_ka* = 16780698'i32

const KEY_Sinh_kha* = 16780699'i32

const KEY_Sinh_kunddaliya* = 16780788'i32

const KEY_Sinh_la* = 16780733'i32

const KEY_Sinh_lla* = 16780741'i32

const KEY_Sinh_lu* = 16780687'i32

const KEY_Sinh_lu2* = 16780767'i32

const KEY_Sinh_luu* = 16780688'i32

const KEY_Sinh_luu2* = 16780787'i32

const KEY_Sinh_ma* = 16780728'i32

const KEY_Sinh_mba* = 16780729'i32

const KEY_Sinh_na* = 16780721'i32

const KEY_Sinh_ndda* = 16780716'i32

const KEY_Sinh_ndha* = 16780723'i32

const KEY_Sinh_ng* = 16780674'i32

const KEY_Sinh_ng2* = 16780702'i32

const KEY_Sinh_nga* = 16780703'i32

const KEY_Sinh_nja* = 16780710'i32

const KEY_Sinh_nna* = 16780715'i32

const KEY_Sinh_nya* = 16780708'i32

const KEY_Sinh_o* = 16780692'i32

const KEY_Sinh_o2* = 16780764'i32

const KEY_Sinh_oo* = 16780693'i32

const KEY_Sinh_oo2* = 16780765'i32

const KEY_Sinh_pa* = 16780724'i32

const KEY_Sinh_pha* = 16780725'i32

const KEY_Sinh_ra* = 16780731'i32

const KEY_Sinh_ri* = 16780685'i32

const KEY_Sinh_rii* = 16780686'i32

const KEY_Sinh_ru2* = 16780760'i32

const KEY_Sinh_ruu2* = 16780786'i32

const KEY_Sinh_sa* = 16780739'i32

const KEY_Sinh_sha* = 16780737'i32

const KEY_Sinh_ssha* = 16780738'i32

const KEY_Sinh_tha* = 16780717'i32

const KEY_Sinh_thha* = 16780718'i32

const KEY_Sinh_tta* = 16780711'i32

const KEY_Sinh_ttha* = 16780712'i32

const KEY_Sinh_u* = 16780683'i32

const KEY_Sinh_u2* = 16780756'i32

const KEY_Sinh_uu* = 16780684'i32

const KEY_Sinh_uu2* = 16780758'i32

const KEY_Sinh_va* = 16780736'i32

const KEY_Sinh_ya* = 16780730'i32

const KEY_Sleep* = 269025071'i32

const KEY_SlowKeys_Enable* = 65139'i32

const KEY_Spell* = 269025148'i32

const KEY_SplitScreen* = 269025149'i32

const KEY_Standby* = 269025040'i32

const KEY_Start* = 269025050'i32

const KEY_StickyKeys_Enable* = 65141'i32

const KEY_Stop* = 269025064'i32

const KEY_Subtitle* = 269025178'i32

const KEY_Super_L* = 65515'i32

const KEY_Super_R* = 65516'i32

const KEY_Support* = 269025150'i32

const KEY_Suspend* = 269025191'i32

const KEY_Switch_VT_1* = 269024769'i32

const KEY_Switch_VT_10* = 269024778'i32

const KEY_Switch_VT_11* = 269024779'i32

const KEY_Switch_VT_12* = 269024780'i32

const KEY_Switch_VT_2* = 269024770'i32

const KEY_Switch_VT_3* = 269024771'i32

const KEY_Switch_VT_4* = 269024772'i32

const KEY_Switch_VT_5* = 269024773'i32

const KEY_Switch_VT_6* = 269024774'i32

const KEY_Switch_VT_7* = 269024775'i32

const KEY_Switch_VT_8* = 269024776'i32

const KEY_Switch_VT_9* = 269024777'i32

const KEY_Sys_Req* = 65301'i32

const UKEY_T* = 84'i32

const XKEY_THORN* = 222'i32

const KEY_Tab* = 65289'i32

const UKEY_Tabovedot* = 16785002'i32

const KEY_TaskPane* = 269025151'i32

const UKEY_Tcaron* = 427'i32

const UKEY_Tcedilla* = 478'i32

const KEY_Terminal* = 269025152'i32

const KEY_Terminate_Server* = 65237'i32

const KEY_Thai_baht* = 3551'i32

const KEY_Thai_bobaimai* = 3514'i32

const KEY_Thai_chochan* = 3496'i32

const KEY_Thai_chochang* = 3498'i32

const KEY_Thai_choching* = 3497'i32

const KEY_Thai_chochoe* = 3500'i32

const KEY_Thai_dochada* = 3502'i32

const KEY_Thai_dodek* = 3508'i32

const KEY_Thai_fofa* = 3517'i32

const KEY_Thai_fofan* = 3519'i32

const KEY_Thai_hohip* = 3531'i32

const KEY_Thai_honokhuk* = 3534'i32

const KEY_Thai_khokhai* = 3490'i32

const KEY_Thai_khokhon* = 3493'i32

const KEY_Thai_khokhuat* = 3491'i32

const KEY_Thai_khokhwai* = 3492'i32

const KEY_Thai_khorakhang* = 3494'i32

const KEY_Thai_kokai* = 3489'i32

const KEY_Thai_lakkhangyao* = 3557'i32

const KEY_Thai_lekchet* = 3575'i32

const KEY_Thai_lekha* = 3573'i32

const KEY_Thai_lekhok* = 3574'i32

const KEY_Thai_lekkao* = 3577'i32

const KEY_Thai_leknung* = 3569'i32

const KEY_Thai_lekpaet* = 3576'i32

const KEY_Thai_leksam* = 3571'i32

const KEY_Thai_leksi* = 3572'i32

const KEY_Thai_leksong* = 3570'i32

const KEY_Thai_leksun* = 3568'i32

const KEY_Thai_lochula* = 3532'i32

const KEY_Thai_loling* = 3525'i32

const KEY_Thai_lu* = 3526'i32

const KEY_Thai_maichattawa* = 3563'i32

const KEY_Thai_maiek* = 3560'i32

const KEY_Thai_maihanakat* = 3537'i32

const KEY_Thai_maihanakat_maitho* = 3550'i32

const KEY_Thai_maitaikhu* = 3559'i32

const KEY_Thai_maitho* = 3561'i32

const KEY_Thai_maitri* = 3562'i32

const KEY_Thai_maiyamok* = 3558'i32

const KEY_Thai_moma* = 3521'i32

const KEY_Thai_ngongu* = 3495'i32

const KEY_Thai_nikhahit* = 3565'i32

const KEY_Thai_nonen* = 3507'i32

const KEY_Thai_nonu* = 3513'i32

const KEY_Thai_oang* = 3533'i32

const KEY_Thai_paiyannoi* = 3535'i32

const KEY_Thai_phinthu* = 3546'i32

const KEY_Thai_phophan* = 3518'i32

const KEY_Thai_phophung* = 3516'i32

const KEY_Thai_phosamphao* = 3520'i32

const KEY_Thai_popla* = 3515'i32

const KEY_Thai_rorua* = 3523'i32

const KEY_Thai_ru* = 3524'i32

const KEY_Thai_saraa* = 3536'i32

const KEY_Thai_saraaa* = 3538'i32

const KEY_Thai_saraae* = 3553'i32

const KEY_Thai_saraaimaimalai* = 3556'i32

const KEY_Thai_saraaimaimuan* = 3555'i32

const KEY_Thai_saraam* = 3539'i32

const KEY_Thai_sarae* = 3552'i32

const KEY_Thai_sarai* = 3540'i32

const KEY_Thai_saraii* = 3541'i32

const KEY_Thai_sarao* = 3554'i32

const KEY_Thai_sarau* = 3544'i32

const KEY_Thai_saraue* = 3542'i32

const KEY_Thai_sarauee* = 3543'i32

const KEY_Thai_sarauu* = 3545'i32

const KEY_Thai_sorusi* = 3529'i32

const KEY_Thai_sosala* = 3528'i32

const KEY_Thai_soso* = 3499'i32

const KEY_Thai_sosua* = 3530'i32

const KEY_Thai_thanthakhat* = 3564'i32

const KEY_Thai_thonangmontho* = 3505'i32

const KEY_Thai_thophuthao* = 3506'i32

const KEY_Thai_thothahan* = 3511'i32

const KEY_Thai_thothan* = 3504'i32

const KEY_Thai_thothong* = 3512'i32

const KEY_Thai_thothung* = 3510'i32

const KEY_Thai_topatak* = 3503'i32

const KEY_Thai_totao* = 3509'i32

const KEY_Thai_wowaen* = 3527'i32

const KEY_Thai_yoyak* = 3522'i32

const KEY_Thai_yoying* = 3501'i32

const UKEY_Thorn* = 222'i32

const KEY_Time* = 269025183'i32

const KEY_ToDoList* = 269025055'i32

const KEY_Tools* = 269025153'i32

const KEY_TopMenu* = 269025186'i32

const KEY_TouchpadOff* = 269025201'i32

const KEY_TouchpadOn* = 269025200'i32

const KEY_TouchpadToggle* = 269025193'i32

const KEY_Touroku* = 65323'i32

const KEY_Travel* = 269025154'i32

const UKEY_Tslash* = 940'i32

const UKEY_U* = 85'i32

const KEY_UWB* = 269025174'i32

const UKEY_Uacute* = 218'i32

const UKEY_Ubelowdot* = 16785124'i32

const UKEY_Ubreve* = 733'i32

const UKEY_Ucircumflex* = 219'i32

const UKEY_Udiaeresis* = 220'i32

const UKEY_Udoubleacute* = 475'i32

const UKEY_Ugrave* = 217'i32

const UKEY_Uhook* = 16785126'i32

const UKEY_Uhorn* = 16777647'i32

const UKEY_Uhornacute* = 16785128'i32

const UKEY_Uhornbelowdot* = 16785136'i32

const UKEY_Uhorngrave* = 16785130'i32

const UKEY_Uhornhook* = 16785132'i32

const UKEY_Uhorntilde* = 16785134'i32

const UKEY_Ukrainian_GHE_WITH_UPTURN* = 1725'i32

const UKEY_Ukrainian_I* = 1718'i32

const UKEY_Ukrainian_IE* = 1716'i32

const UKEY_Ukrainian_YI* = 1719'i32

const KEY_Ukrainian_ghe_with_upturn* = 1709'i32

const KEY_Ukrainian_i* = 1702'i32

const KEY_Ukrainian_ie* = 1700'i32

const KEY_Ukrainian_yi* = 1703'i32

const UKEY_Ukranian_I* = 1718'i32

const UKEY_Ukranian_JE* = 1716'i32

const UKEY_Ukranian_YI* = 1719'i32

const KEY_Ukranian_i* = 1702'i32

const KEY_Ukranian_je* = 1700'i32

const KEY_Ukranian_yi* = 1703'i32

const UKEY_Umacron* = 990'i32

const KEY_Undo* = 65381'i32

const KEY_Ungrab* = 269024800'i32

const UKEY_Uogonek* = 985'i32

const KEY_Up* = 65362'i32

const UKEY_Uring* = 473'i32

const KEY_User1KB* = 269025157'i32

const KEY_User2KB* = 269025158'i32

const KEY_UserPB* = 269025156'i32

const UKEY_Utilde* = 989'i32

const UKEY_V* = 86'i32

const KEY_VendorHome* = 269025076'i32

const KEY_Video* = 269025159'i32

const KEY_View* = 269025185'i32

const KEY_VoidSymbol* = 16777215'i32

const UKEY_W* = 87'i32

const KEY_WLAN* = 269025173'i32

const KEY_WWW* = 269025070'i32

const UKEY_Wacute* = 16785026'i32

const KEY_WakeUp* = 269025067'i32

const UKEY_Wcircumflex* = 16777588'i32

const UKEY_Wdiaeresis* = 16785028'i32

const KEY_WebCam* = 269025167'i32

const UKEY_Wgrave* = 16785024'i32

const KEY_WheelButton* = 269025160'i32

const KEY_WindowClear* = 269025109'i32

const KEY_WonSign* = 16785577'i32

const KEY_Word* = 269025161'i32

const UKEY_X* = 88'i32

const UKEY_Xabovedot* = 16785034'i32

const KEY_Xfer* = 269025162'i32

const UKEY_Y* = 89'i32

const UKEY_Yacute* = 221'i32

const UKEY_Ybelowdot* = 16785140'i32

const UKEY_Ycircumflex* = 16777590'i32

const UKEY_Ydiaeresis* = 5054'i32

const KEY_Yellow* = 269025189'i32

const UKEY_Ygrave* = 16785138'i32

const UKEY_Yhook* = 16785142'i32

const UKEY_Ytilde* = 16785144'i32

const UKEY_Z* = 90'i32

const UKEY_Zabovedot* = 431'i32

const UKEY_Zacute* = 428'i32

const UKEY_Zcaron* = 430'i32

const KEY_Zen_Koho* = 65341'i32

const KEY_Zenkaku* = 65320'i32

const KEY_Zenkaku_Hankaku* = 65322'i32

const KEY_ZoomIn* = 269025163'i32

const KEY_ZoomOut* = 269025164'i32

const UKEY_Zstroke* = 16777653'i32

const KEY_a* = 97'i32

const KEY_aacute* = 225'i32

const KEY_abelowdot* = 16785057'i32

const KEY_abovedot* = 511'i32

const KEY_abreve* = 483'i32

const KEY_abreveacute* = 16785071'i32

const KEY_abrevebelowdot* = 16785079'i32

const KEY_abrevegrave* = 16785073'i32

const KEY_abrevehook* = 16785075'i32

const KEY_abrevetilde* = 16785077'i32

const KEY_acircumflex* = 226'i32

const KEY_acircumflexacute* = 16785061'i32

const KEY_acircumflexbelowdot* = 16785069'i32

const KEY_acircumflexgrave* = 16785063'i32

const KEY_acircumflexhook* = 16785065'i32

const KEY_acircumflextilde* = 16785067'i32

const KEY_acute* = 180'i32

const KEY_adiaeresis* = 228'i32

const KEY_ae* = 230'i32

const KEY_agrave* = 224'i32

const KEY_ahook* = 16785059'i32

const KEY_amacron* = 992'i32

const KEY_ampersand* = 38'i32

const KEY_aogonek* = 433'i32

const KEY_apostrophe* = 39'i32

const KEY_approxeq* = 16785992'i32

const KEY_approximate* = 2248'i32

const KEY_aring* = 229'i32

const KEY_asciicircum* = 94'i32

const KEY_asciitilde* = 126'i32

const KEY_asterisk* = 42'i32

const KEY_at* = 64'i32

const KEY_atilde* = 227'i32

const KEY_b* = 98'i32

const KEY_babovedot* = 16784899'i32

const KEY_backslash* = 92'i32

const KEY_ballotcross* = 2804'i32

const KEY_bar* = 124'i32

const KEY_because* = 16785973'i32

const KEY_blank* = 2527'i32

const KEY_botintegral* = 2213'i32

const KEY_botleftparens* = 2220'i32

const KEY_botleftsqbracket* = 2216'i32

const KEY_botleftsummation* = 2226'i32

const KEY_botrightparens* = 2222'i32

const KEY_botrightsqbracket* = 2218'i32

const KEY_botrightsummation* = 2230'i32

const KEY_bott* = 2550'i32

const KEY_botvertsummationconnector* = 2228'i32

const KEY_braceleft* = 123'i32

const KEY_braceright* = 125'i32

const KEY_bracketleft* = 91'i32

const KEY_bracketright* = 93'i32

const KEY_braille_blank* = 16787456'i32

const KEY_braille_dot_1* = 65521'i32

const KEY_braille_dot_10* = 65530'i32

const KEY_braille_dot_2* = 65522'i32

const KEY_braille_dot_3* = 65523'i32

const KEY_braille_dot_4* = 65524'i32

const KEY_braille_dot_5* = 65525'i32

const KEY_braille_dot_6* = 65526'i32

const KEY_braille_dot_7* = 65527'i32

const KEY_braille_dot_8* = 65528'i32

const KEY_braille_dot_9* = 65529'i32

const KEY_braille_dots_1* = 16787457'i32

const KEY_braille_dots_12* = 16787459'i32

const KEY_braille_dots_123* = 16787463'i32

const KEY_braille_dots_1234* = 16787471'i32

const KEY_braille_dots_12345* = 16787487'i32

const KEY_braille_dots_123456* = 16787519'i32

const KEY_braille_dots_1234567* = 16787583'i32

const KEY_braille_dots_12345678* = 16787711'i32

const KEY_braille_dots_1234568* = 16787647'i32

const KEY_braille_dots_123457* = 16787551'i32

const KEY_braille_dots_1234578* = 16787679'i32

const KEY_braille_dots_123458* = 16787615'i32

const KEY_braille_dots_12346* = 16787503'i32

const KEY_braille_dots_123467* = 16787567'i32

const KEY_braille_dots_1234678* = 16787695'i32

const KEY_braille_dots_123468* = 16787631'i32

const KEY_braille_dots_12347* = 16787535'i32

const KEY_braille_dots_123478* = 16787663'i32

const KEY_braille_dots_12348* = 16787599'i32

const KEY_braille_dots_1235* = 16787479'i32

const KEY_braille_dots_12356* = 16787511'i32

const KEY_braille_dots_123567* = 16787575'i32

const KEY_braille_dots_1235678* = 16787703'i32

const KEY_braille_dots_123568* = 16787639'i32

const KEY_braille_dots_12357* = 16787543'i32

const KEY_braille_dots_123578* = 16787671'i32

const KEY_braille_dots_12358* = 16787607'i32

const KEY_braille_dots_1236* = 16787495'i32

const KEY_braille_dots_12367* = 16787559'i32

const KEY_braille_dots_123678* = 16787687'i32

const KEY_braille_dots_12368* = 16787623'i32

const KEY_braille_dots_1237* = 16787527'i32

const KEY_braille_dots_12378* = 16787655'i32

const KEY_braille_dots_1238* = 16787591'i32

const KEY_braille_dots_124* = 16787467'i32

const KEY_braille_dots_1245* = 16787483'i32

const KEY_braille_dots_12456* = 16787515'i32

const KEY_braille_dots_124567* = 16787579'i32

const KEY_braille_dots_1245678* = 16787707'i32

const KEY_braille_dots_124568* = 16787643'i32

const KEY_braille_dots_12457* = 16787547'i32

const KEY_braille_dots_124578* = 16787675'i32

const KEY_braille_dots_12458* = 16787611'i32

const KEY_braille_dots_1246* = 16787499'i32

const KEY_braille_dots_12467* = 16787563'i32

const KEY_braille_dots_124678* = 16787691'i32

const KEY_braille_dots_12468* = 16787627'i32

const KEY_braille_dots_1247* = 16787531'i32

const KEY_braille_dots_12478* = 16787659'i32

const KEY_braille_dots_1248* = 16787595'i32

const KEY_braille_dots_125* = 16787475'i32

const KEY_braille_dots_1256* = 16787507'i32

const KEY_braille_dots_12567* = 16787571'i32

const KEY_braille_dots_125678* = 16787699'i32

const KEY_braille_dots_12568* = 16787635'i32

const KEY_braille_dots_1257* = 16787539'i32

const KEY_braille_dots_12578* = 16787667'i32

const KEY_braille_dots_1258* = 16787603'i32

const KEY_braille_dots_126* = 16787491'i32

const KEY_braille_dots_1267* = 16787555'i32

const KEY_braille_dots_12678* = 16787683'i32

const KEY_braille_dots_1268* = 16787619'i32

const KEY_braille_dots_127* = 16787523'i32

const KEY_braille_dots_1278* = 16787651'i32

const KEY_braille_dots_128* = 16787587'i32

const KEY_braille_dots_13* = 16787461'i32

const KEY_braille_dots_134* = 16787469'i32

const KEY_braille_dots_1345* = 16787485'i32

const KEY_braille_dots_13456* = 16787517'i32

const KEY_braille_dots_134567* = 16787581'i32

const KEY_braille_dots_1345678* = 16787709'i32

const KEY_braille_dots_134568* = 16787645'i32

const KEY_braille_dots_13457* = 16787549'i32

const KEY_braille_dots_134578* = 16787677'i32

const KEY_braille_dots_13458* = 16787613'i32

const KEY_braille_dots_1346* = 16787501'i32

const KEY_braille_dots_13467* = 16787565'i32

const KEY_braille_dots_134678* = 16787693'i32

const KEY_braille_dots_13468* = 16787629'i32

const KEY_braille_dots_1347* = 16787533'i32

const KEY_braille_dots_13478* = 16787661'i32

const KEY_braille_dots_1348* = 16787597'i32

const KEY_braille_dots_135* = 16787477'i32

const KEY_braille_dots_1356* = 16787509'i32

const KEY_braille_dots_13567* = 16787573'i32

const KEY_braille_dots_135678* = 16787701'i32

const KEY_braille_dots_13568* = 16787637'i32

const KEY_braille_dots_1357* = 16787541'i32

const KEY_braille_dots_13578* = 16787669'i32

const KEY_braille_dots_1358* = 16787605'i32

const KEY_braille_dots_136* = 16787493'i32

const KEY_braille_dots_1367* = 16787557'i32

const KEY_braille_dots_13678* = 16787685'i32

const KEY_braille_dots_1368* = 16787621'i32

const KEY_braille_dots_137* = 16787525'i32

const KEY_braille_dots_1378* = 16787653'i32

const KEY_braille_dots_138* = 16787589'i32

const KEY_braille_dots_14* = 16787465'i32

const KEY_braille_dots_145* = 16787481'i32

const KEY_braille_dots_1456* = 16787513'i32

const KEY_braille_dots_14567* = 16787577'i32

const KEY_braille_dots_145678* = 16787705'i32

const KEY_braille_dots_14568* = 16787641'i32

const KEY_braille_dots_1457* = 16787545'i32

const KEY_braille_dots_14578* = 16787673'i32

const KEY_braille_dots_1458* = 16787609'i32

const KEY_braille_dots_146* = 16787497'i32

const KEY_braille_dots_1467* = 16787561'i32

const KEY_braille_dots_14678* = 16787689'i32

const KEY_braille_dots_1468* = 16787625'i32

const KEY_braille_dots_147* = 16787529'i32

const KEY_braille_dots_1478* = 16787657'i32

const KEY_braille_dots_148* = 16787593'i32

const KEY_braille_dots_15* = 16787473'i32

const KEY_braille_dots_156* = 16787505'i32

const KEY_braille_dots_1567* = 16787569'i32

const KEY_braille_dots_15678* = 16787697'i32

const KEY_braille_dots_1568* = 16787633'i32

const KEY_braille_dots_157* = 16787537'i32

const KEY_braille_dots_1578* = 16787665'i32

const KEY_braille_dots_158* = 16787601'i32

const KEY_braille_dots_16* = 16787489'i32

const KEY_braille_dots_167* = 16787553'i32

const KEY_braille_dots_1678* = 16787681'i32

const KEY_braille_dots_168* = 16787617'i32

const KEY_braille_dots_17* = 16787521'i32

const KEY_braille_dots_178* = 16787649'i32

const KEY_braille_dots_18* = 16787585'i32

const KEY_braille_dots_2* = 16787458'i32

const KEY_braille_dots_23* = 16787462'i32

const KEY_braille_dots_234* = 16787470'i32

const KEY_braille_dots_2345* = 16787486'i32

const KEY_braille_dots_23456* = 16787518'i32

const KEY_braille_dots_234567* = 16787582'i32

const KEY_braille_dots_2345678* = 16787710'i32

const KEY_braille_dots_234568* = 16787646'i32

const KEY_braille_dots_23457* = 16787550'i32

const KEY_braille_dots_234578* = 16787678'i32

const KEY_braille_dots_23458* = 16787614'i32

const KEY_braille_dots_2346* = 16787502'i32

const KEY_braille_dots_23467* = 16787566'i32

const KEY_braille_dots_234678* = 16787694'i32

const KEY_braille_dots_23468* = 16787630'i32

const KEY_braille_dots_2347* = 16787534'i32

const KEY_braille_dots_23478* = 16787662'i32

const KEY_braille_dots_2348* = 16787598'i32

const KEY_braille_dots_235* = 16787478'i32

const KEY_braille_dots_2356* = 16787510'i32

const KEY_braille_dots_23567* = 16787574'i32

const KEY_braille_dots_235678* = 16787702'i32

const KEY_braille_dots_23568* = 16787638'i32

const KEY_braille_dots_2357* = 16787542'i32

const KEY_braille_dots_23578* = 16787670'i32

const KEY_braille_dots_2358* = 16787606'i32

const KEY_braille_dots_236* = 16787494'i32

const KEY_braille_dots_2367* = 16787558'i32

const KEY_braille_dots_23678* = 16787686'i32

const KEY_braille_dots_2368* = 16787622'i32

const KEY_braille_dots_237* = 16787526'i32

const KEY_braille_dots_2378* = 16787654'i32

const KEY_braille_dots_238* = 16787590'i32

const KEY_braille_dots_24* = 16787466'i32

const KEY_braille_dots_245* = 16787482'i32

const KEY_braille_dots_2456* = 16787514'i32

const KEY_braille_dots_24567* = 16787578'i32

const KEY_braille_dots_245678* = 16787706'i32

const KEY_braille_dots_24568* = 16787642'i32

const KEY_braille_dots_2457* = 16787546'i32

const KEY_braille_dots_24578* = 16787674'i32

const KEY_braille_dots_2458* = 16787610'i32

const KEY_braille_dots_246* = 16787498'i32

const KEY_braille_dots_2467* = 16787562'i32

const KEY_braille_dots_24678* = 16787690'i32

const KEY_braille_dots_2468* = 16787626'i32

const KEY_braille_dots_247* = 16787530'i32

const KEY_braille_dots_2478* = 16787658'i32

const KEY_braille_dots_248* = 16787594'i32

const KEY_braille_dots_25* = 16787474'i32

const KEY_braille_dots_256* = 16787506'i32

const KEY_braille_dots_2567* = 16787570'i32

const KEY_braille_dots_25678* = 16787698'i32

const KEY_braille_dots_2568* = 16787634'i32

const KEY_braille_dots_257* = 16787538'i32

const KEY_braille_dots_2578* = 16787666'i32

const KEY_braille_dots_258* = 16787602'i32

const KEY_braille_dots_26* = 16787490'i32

const KEY_braille_dots_267* = 16787554'i32

const KEY_braille_dots_2678* = 16787682'i32

const KEY_braille_dots_268* = 16787618'i32

const KEY_braille_dots_27* = 16787522'i32

const KEY_braille_dots_278* = 16787650'i32

const KEY_braille_dots_28* = 16787586'i32

const KEY_braille_dots_3* = 16787460'i32

const KEY_braille_dots_34* = 16787468'i32

const KEY_braille_dots_345* = 16787484'i32

const KEY_braille_dots_3456* = 16787516'i32

const KEY_braille_dots_34567* = 16787580'i32

const KEY_braille_dots_345678* = 16787708'i32

const KEY_braille_dots_34568* = 16787644'i32

const KEY_braille_dots_3457* = 16787548'i32

const KEY_braille_dots_34578* = 16787676'i32

const KEY_braille_dots_3458* = 16787612'i32

const KEY_braille_dots_346* = 16787500'i32

const KEY_braille_dots_3467* = 16787564'i32

const KEY_braille_dots_34678* = 16787692'i32

const KEY_braille_dots_3468* = 16787628'i32

const KEY_braille_dots_347* = 16787532'i32

const KEY_braille_dots_3478* = 16787660'i32

const KEY_braille_dots_348* = 16787596'i32

const KEY_braille_dots_35* = 16787476'i32

const KEY_braille_dots_356* = 16787508'i32

const KEY_braille_dots_3567* = 16787572'i32

const KEY_braille_dots_35678* = 16787700'i32

const KEY_braille_dots_3568* = 16787636'i32

const KEY_braille_dots_357* = 16787540'i32

const KEY_braille_dots_3578* = 16787668'i32

const KEY_braille_dots_358* = 16787604'i32

const KEY_braille_dots_36* = 16787492'i32

const KEY_braille_dots_367* = 16787556'i32

const KEY_braille_dots_3678* = 16787684'i32

const KEY_braille_dots_368* = 16787620'i32

const KEY_braille_dots_37* = 16787524'i32

const KEY_braille_dots_378* = 16787652'i32

const KEY_braille_dots_38* = 16787588'i32

const KEY_braille_dots_4* = 16787464'i32

const KEY_braille_dots_45* = 16787480'i32

const KEY_braille_dots_456* = 16787512'i32

const KEY_braille_dots_4567* = 16787576'i32

const KEY_braille_dots_45678* = 16787704'i32

const KEY_braille_dots_4568* = 16787640'i32

const KEY_braille_dots_457* = 16787544'i32

const KEY_braille_dots_4578* = 16787672'i32

const KEY_braille_dots_458* = 16787608'i32

const KEY_braille_dots_46* = 16787496'i32

const KEY_braille_dots_467* = 16787560'i32

const KEY_braille_dots_4678* = 16787688'i32

const KEY_braille_dots_468* = 16787624'i32

const KEY_braille_dots_47* = 16787528'i32

const KEY_braille_dots_478* = 16787656'i32

const KEY_braille_dots_48* = 16787592'i32

const KEY_braille_dots_5* = 16787472'i32

const KEY_braille_dots_56* = 16787504'i32

const KEY_braille_dots_567* = 16787568'i32

const KEY_braille_dots_5678* = 16787696'i32

const KEY_braille_dots_568* = 16787632'i32

const KEY_braille_dots_57* = 16787536'i32

const KEY_braille_dots_578* = 16787664'i32

const KEY_braille_dots_58* = 16787600'i32

const KEY_braille_dots_6* = 16787488'i32

const KEY_braille_dots_67* = 16787552'i32

const KEY_braille_dots_678* = 16787680'i32

const KEY_braille_dots_68* = 16787616'i32

const KEY_braille_dots_7* = 16787520'i32

const KEY_braille_dots_78* = 16787648'i32

const KEY_braille_dots_8* = 16787584'i32

const KEY_breve* = 418'i32

const KEY_brokenbar* = 166'i32

const KEY_c* = 99'i32

const KEY_cH7* = 65187'i32

const KEY_cabovedot* = 741'i32

const KEY_cacute* = 486'i32

const KEY_careof* = 2744'i32

const KEY_caret* = 2812'i32

const KEY_caron* = 439'i32

const KEY_ccaron* = 488'i32

const KEY_ccedilla* = 231'i32

const KEY_ccircumflex* = 742'i32

const KEY_cedilla* = 184'i32

const KEY_cent* = 162'i32

const KEY_ch4* = 65184'i32

const KEY_checkerboard* = 2529'i32

const KEY_checkmark* = 2803'i32

const KEY_circle* = 3023'i32

const KEY_club* = 2796'i32

const KEY_colon* = 58'i32

const KEY_comma* = 44'i32

const KEY_containsas* = 16785931'i32

const KEY_copyright* = 169'i32

const KEY_cr* = 2532'i32

const KEY_crossinglines* = 2542'i32

const KEY_cuberoot* = 16785947'i32

const KEY_currency* = 164'i32

const KEY_cursor* = 2815'i32

const KEY_d* = 100'i32

const KEY_dabovedot* = 16784907'i32

const KEY_dagger* = 2801'i32

const KEY_dcaron* = 495'i32

const UKEY_dead_A* = 65153'i32

const UKEY_dead_E* = 65155'i32

const UKEY_dead_I* = 65157'i32

const UKEY_dead_O* = 65159'i32

const UKEY_dead_U* = 65161'i32

const KEY_dead_a* = 65152'i32

const KEY_dead_abovecomma* = 65124'i32

const KEY_dead_abovedot* = 65110'i32

const KEY_dead_abovereversedcomma* = 65125'i32

const KEY_dead_abovering* = 65112'i32

const KEY_dead_acute* = 65105'i32

const KEY_dead_belowbreve* = 65131'i32

const KEY_dead_belowcircumflex* = 65129'i32

const KEY_dead_belowcomma* = 65134'i32

const KEY_dead_belowdiaeresis* = 65132'i32

const KEY_dead_belowdot* = 65120'i32

const KEY_dead_belowmacron* = 65128'i32

const KEY_dead_belowring* = 65127'i32

const KEY_dead_belowtilde* = 65130'i32

const KEY_dead_breve* = 65109'i32

const KEY_dead_capital_schwa* = 65163'i32

const KEY_dead_caron* = 65114'i32

const KEY_dead_cedilla* = 65115'i32

const KEY_dead_circumflex* = 65106'i32

const KEY_dead_currency* = 65135'i32

const KEY_dead_dasia* = 65125'i32

const KEY_dead_diaeresis* = 65111'i32

const KEY_dead_doubleacute* = 65113'i32

const KEY_dead_doublegrave* = 65126'i32

const KEY_dead_e* = 65154'i32

const KEY_dead_grave* = 65104'i32

const KEY_dead_greek* = 65164'i32

const KEY_dead_hook* = 65121'i32

const KEY_dead_horn* = 65122'i32

const KEY_dead_i* = 65156'i32

const KEY_dead_invertedbreve* = 65133'i32

const KEY_dead_iota* = 65117'i32

const KEY_dead_macron* = 65108'i32

const KEY_dead_o* = 65158'i32

const KEY_dead_ogonek* = 65116'i32

const KEY_dead_perispomeni* = 65107'i32

const KEY_dead_psili* = 65124'i32

const KEY_dead_semivoiced_sound* = 65119'i32

const KEY_dead_small_schwa* = 65162'i32

const KEY_dead_stroke* = 65123'i32

const KEY_dead_tilde* = 65107'i32

const KEY_dead_u* = 65160'i32

const KEY_dead_voiced_sound* = 65118'i32

const KEY_decimalpoint* = 2749'i32

const KEY_degree* = 176'i32

const KEY_diaeresis* = 168'i32

const KEY_diamond* = 2797'i32

const KEY_digitspace* = 2725'i32

const KEY_dintegral* = 16785964'i32

const KEY_division* = 247'i32

const KEY_dollar* = 36'i32

const KEY_doubbaselinedot* = 2735'i32

const KEY_doubleacute* = 445'i32

const KEY_doubledagger* = 2802'i32

const KEY_doublelowquotemark* = 2814'i32

const KEY_downarrow* = 2302'i32

const KEY_downcaret* = 2984'i32

const KEY_downshoe* = 3030'i32

const KEY_downstile* = 3012'i32

const KEY_downtack* = 3010'i32

const KEY_dstroke* = 496'i32

const KEY_e* = 101'i32

const KEY_eabovedot* = 1004'i32

const KEY_eacute* = 233'i32

const KEY_ebelowdot* = 16785081'i32

const KEY_ecaron* = 492'i32

const KEY_ecircumflex* = 234'i32

const KEY_ecircumflexacute* = 16785087'i32

const KEY_ecircumflexbelowdot* = 16785095'i32

const KEY_ecircumflexgrave* = 16785089'i32

const KEY_ecircumflexhook* = 16785091'i32

const KEY_ecircumflextilde* = 16785093'i32

const KEY_ediaeresis* = 235'i32

const KEY_egrave* = 232'i32

const KEY_ehook* = 16785083'i32

const KEY_eightsubscript* = 16785544'i32

const KEY_eightsuperior* = 16785528'i32

const KEY_elementof* = 16785928'i32

const KEY_ellipsis* = 2734'i32

const KEY_em3space* = 2723'i32

const KEY_em4space* = 2724'i32

const KEY_emacron* = 954'i32

const KEY_emdash* = 2729'i32

const KEY_emfilledcircle* = 2782'i32

const KEY_emfilledrect* = 2783'i32

const KEY_emopencircle* = 2766'i32

const KEY_emopenrectangle* = 2767'i32

const KEY_emptyset* = 16785925'i32

const KEY_emspace* = 2721'i32

const KEY_endash* = 2730'i32

const KEY_enfilledcircbullet* = 2790'i32

const KEY_enfilledsqbullet* = 2791'i32

const KEY_eng* = 959'i32

const KEY_enopencircbullet* = 2784'i32

const KEY_enopensquarebullet* = 2785'i32

const KEY_enspace* = 2722'i32

const KEY_eogonek* = 490'i32

const KEY_equal* = 61'i32

const KEY_eth* = 240'i32

const KEY_etilde* = 16785085'i32

const KEY_exclam* = 33'i32

const KEY_exclamdown* = 161'i32

const KEY_ezh* = 16777874'i32

const KEY_f* = 102'i32

const KEY_fabovedot* = 16784927'i32

const KEY_femalesymbol* = 2808'i32

const KEY_ff* = 2531'i32

const KEY_figdash* = 2747'i32

const KEY_filledlefttribullet* = 2780'i32

const KEY_filledrectbullet* = 2779'i32

const KEY_filledrighttribullet* = 2781'i32

const KEY_filledtribulletdown* = 2793'i32

const KEY_filledtribulletup* = 2792'i32

const KEY_fiveeighths* = 2757'i32

const KEY_fivesixths* = 2743'i32

const KEY_fivesubscript* = 16785541'i32

const KEY_fivesuperior* = 16785525'i32

const KEY_fourfifths* = 2741'i32

const KEY_foursubscript* = 16785540'i32

const KEY_foursuperior* = 16785524'i32

const KEY_fourthroot* = 16785948'i32

const KEY_function* = 2294'i32

const KEY_g* = 103'i32

const KEY_gabovedot* = 757'i32

const KEY_gbreve* = 699'i32

const KEY_gcaron* = 16777703'i32

const KEY_gcedilla* = 955'i32

const KEY_gcircumflex* = 760'i32

const KEY_grave* = 96'i32

const KEY_greater* = 62'i32

const KEY_greaterthanequal* = 2238'i32

const KEY_guillemotleft* = 171'i32

const KEY_guillemotright* = 187'i32

const KEY_h* = 104'i32

const KEY_hairspace* = 2728'i32

const KEY_hcircumflex* = 694'i32

const KEY_heart* = 2798'i32

const KEY_hebrew_aleph* = 3296'i32

const KEY_hebrew_ayin* = 3314'i32

const KEY_hebrew_bet* = 3297'i32

const KEY_hebrew_beth* = 3297'i32

const KEY_hebrew_chet* = 3303'i32

const KEY_hebrew_dalet* = 3299'i32

const KEY_hebrew_daleth* = 3299'i32

const KEY_hebrew_doublelowline* = 3295'i32

const KEY_hebrew_finalkaph* = 3306'i32

const KEY_hebrew_finalmem* = 3309'i32

const KEY_hebrew_finalnun* = 3311'i32

const KEY_hebrew_finalpe* = 3315'i32

const KEY_hebrew_finalzade* = 3317'i32

const KEY_hebrew_finalzadi* = 3317'i32

const KEY_hebrew_gimel* = 3298'i32

const KEY_hebrew_gimmel* = 3298'i32

const KEY_hebrew_he* = 3300'i32

const KEY_hebrew_het* = 3303'i32

const KEY_hebrew_kaph* = 3307'i32

const KEY_hebrew_kuf* = 3319'i32

const KEY_hebrew_lamed* = 3308'i32

const KEY_hebrew_mem* = 3310'i32

const KEY_hebrew_nun* = 3312'i32

const KEY_hebrew_pe* = 3316'i32

const KEY_hebrew_qoph* = 3319'i32

const KEY_hebrew_resh* = 3320'i32

const KEY_hebrew_samech* = 3313'i32

const KEY_hebrew_samekh* = 3313'i32

const KEY_hebrew_shin* = 3321'i32

const KEY_hebrew_taf* = 3322'i32

const KEY_hebrew_taw* = 3322'i32

const KEY_hebrew_tet* = 3304'i32

const KEY_hebrew_teth* = 3304'i32

const KEY_hebrew_waw* = 3301'i32

const KEY_hebrew_yod* = 3305'i32

const KEY_hebrew_zade* = 3318'i32

const KEY_hebrew_zadi* = 3318'i32

const KEY_hebrew_zain* = 3302'i32

const KEY_hebrew_zayin* = 3302'i32

const KEY_hexagram* = 2778'i32

const KEY_horizconnector* = 2211'i32

const KEY_horizlinescan1* = 2543'i32

const KEY_horizlinescan3* = 2544'i32

const KEY_horizlinescan5* = 2545'i32

const KEY_horizlinescan7* = 2546'i32

const KEY_horizlinescan9* = 2547'i32

const KEY_hstroke* = 689'i32

const KEY_ht* = 2530'i32

const KEY_hyphen* = 173'i32

const KEY_i* = 105'i32

const KEY_iTouch* = 269025120'i32

const KEY_iacute* = 237'i32

const KEY_ibelowdot* = 16785099'i32

const KEY_ibreve* = 16777517'i32

const KEY_icircumflex* = 238'i32

const KEY_identical* = 2255'i32

const KEY_idiaeresis* = 239'i32

const KEY_idotless* = 697'i32

const KEY_ifonlyif* = 2253'i32

const KEY_igrave* = 236'i32

const KEY_ihook* = 16785097'i32

const KEY_imacron* = 1007'i32

const KEY_implies* = 2254'i32

const KEY_includedin* = 2266'i32

const KEY_includes* = 2267'i32

const KEY_infinity* = 2242'i32

const KEY_integral* = 2239'i32

const KEY_intersection* = 2268'i32

const KEY_iogonek* = 999'i32

const KEY_itilde* = 949'i32

const KEY_j* = 106'i32

const KEY_jcircumflex* = 700'i32

const KEY_jot* = 3018'i32

const KEY_k* = 107'i32

const UKEY_kana_A* = 1201'i32

const KEY_kana_CHI* = 1217'i32

const UKEY_kana_E* = 1204'i32

const KEY_kana_FU* = 1228'i32

const KEY_kana_HA* = 1226'i32

const KEY_kana_HE* = 1229'i32

const KEY_kana_HI* = 1227'i32

const KEY_kana_HO* = 1230'i32

const KEY_kana_HU* = 1228'i32

const UKEY_kana_I* = 1202'i32

const KEY_kana_KA* = 1206'i32

const KEY_kana_KE* = 1209'i32

const KEY_kana_KI* = 1207'i32

const KEY_kana_KO* = 1210'i32

const KEY_kana_KU* = 1208'i32

const KEY_kana_MA* = 1231'i32

const KEY_kana_ME* = 1234'i32

const KEY_kana_MI* = 1232'i32

const KEY_kana_MO* = 1235'i32

const KEY_kana_MU* = 1233'i32

const KEY_kana_N* = 1245'i32

const KEY_kana_NA* = 1221'i32

const KEY_kana_NE* = 1224'i32

const KEY_kana_NI* = 1222'i32

const KEY_kana_NO* = 1225'i32

const KEY_kana_NU* = 1223'i32

const UKEY_kana_O* = 1205'i32

const KEY_kana_RA* = 1239'i32

const KEY_kana_RE* = 1242'i32

const KEY_kana_RI* = 1240'i32

const KEY_kana_RO* = 1243'i32

const KEY_kana_RU* = 1241'i32

const KEY_kana_SA* = 1211'i32

const KEY_kana_SE* = 1214'i32

const KEY_kana_SHI* = 1212'i32

const KEY_kana_SO* = 1215'i32

const KEY_kana_SU* = 1213'i32

const KEY_kana_TA* = 1216'i32

const KEY_kana_TE* = 1219'i32

const KEY_kana_TI* = 1217'i32

const KEY_kana_TO* = 1220'i32

const UKEY_kana_TSU* = 1218'i32

const UKEY_kana_TU* = 1218'i32

const UKEY_kana_U* = 1203'i32

const KEY_kana_WA* = 1244'i32

const KEY_kana_WO* = 1190'i32

const UKEY_kana_YA* = 1236'i32

const UKEY_kana_YO* = 1238'i32

const UKEY_kana_YU* = 1237'i32

const KEY_kana_a* = 1191'i32

const KEY_kana_closingbracket* = 1187'i32

const KEY_kana_comma* = 1188'i32

const KEY_kana_conjunctive* = 1189'i32

const KEY_kana_e* = 1194'i32

const KEY_kana_fullstop* = 1185'i32

const KEY_kana_i* = 1192'i32

const KEY_kana_middledot* = 1189'i32

const KEY_kana_o* = 1195'i32

const KEY_kana_openingbracket* = 1186'i32

const KEY_kana_switch* = 65406'i32

const KEY_kana_tsu* = 1199'i32

const KEY_kana_tu* = 1199'i32

const KEY_kana_u* = 1193'i32

const KEY_kana_ya* = 1196'i32

const KEY_kana_yo* = 1198'i32

const KEY_kana_yu* = 1197'i32

const KEY_kappa* = 930'i32

const KEY_kcedilla* = 1011'i32

const KEY_kra* = 930'i32

const KEY_l* = 108'i32

const KEY_lacute* = 485'i32

const KEY_latincross* = 2777'i32

const KEY_lbelowdot* = 16784951'i32

const KEY_lcaron* = 437'i32

const KEY_lcedilla* = 950'i32

const KEY_leftanglebracket* = 2748'i32

const KEY_leftarrow* = 2299'i32

const KEY_leftcaret* = 2979'i32

const KEY_leftdoublequotemark* = 2770'i32

const KEY_leftmiddlecurlybrace* = 2223'i32

const KEY_leftopentriangle* = 2764'i32

const KEY_leftpointer* = 2794'i32

const KEY_leftradical* = 2209'i32

const KEY_leftshoe* = 3034'i32

const KEY_leftsinglequotemark* = 2768'i32

const KEY_leftt* = 2548'i32

const KEY_lefttack* = 3036'i32

const KEY_less* = 60'i32

const KEY_lessthanequal* = 2236'i32

const KEY_lf* = 2533'i32

const KEY_logicaland* = 2270'i32

const KEY_logicalor* = 2271'i32

const KEY_lowleftcorner* = 2541'i32

const KEY_lowrightcorner* = 2538'i32

const KEY_lstroke* = 435'i32

const KEY_m* = 109'i32

const KEY_mabovedot* = 16784961'i32

const KEY_macron* = 175'i32

const KEY_malesymbol* = 2807'i32

const KEY_maltesecross* = 2800'i32

const KEY_marker* = 2751'i32

const KEY_masculine* = 186'i32

const KEY_minus* = 45'i32

const KEY_minutes* = 2774'i32

const KEY_mu* = 181'i32

const KEY_multiply* = 215'i32

const KEY_musicalflat* = 2806'i32

const KEY_musicalsharp* = 2805'i32

const KEY_n* = 110'i32

const KEY_nabla* = 2245'i32

const KEY_nacute* = 497'i32

const KEY_ncaron* = 498'i32

const KEY_ncedilla* = 1009'i32

const KEY_ninesubscript* = 16785545'i32

const KEY_ninesuperior* = 16785529'i32

const KEY_nl* = 2536'i32

const KEY_nobreakspace* = 160'i32

const KEY_notapproxeq* = 16785991'i32

const KEY_notelementof* = 16785929'i32

const KEY_notequal* = 2237'i32

const KEY_notidentical* = 16786018'i32

const KEY_notsign* = 172'i32

const KEY_ntilde* = 241'i32

const KEY_numbersign* = 35'i32

const KEY_numerosign* = 1712'i32

const KEY_o* = 111'i32

const KEY_oacute* = 243'i32

const KEY_obarred* = 16777845'i32

const KEY_obelowdot* = 16785101'i32

const KEY_ocaron* = 16777682'i32

const KEY_ocircumflex* = 244'i32

const KEY_ocircumflexacute* = 16785105'i32

const KEY_ocircumflexbelowdot* = 16785113'i32

const KEY_ocircumflexgrave* = 16785107'i32

const KEY_ocircumflexhook* = 16785109'i32

const KEY_ocircumflextilde* = 16785111'i32

const KEY_odiaeresis* = 246'i32

const KEY_odoubleacute* = 501'i32

const KEY_oe* = 5053'i32

const KEY_ogonek* = 434'i32

const KEY_ograve* = 242'i32

const KEY_ohook* = 16785103'i32

const KEY_ohorn* = 16777633'i32

const KEY_ohornacute* = 16785115'i32

const KEY_ohornbelowdot* = 16785123'i32

const KEY_ohorngrave* = 16785117'i32

const KEY_ohornhook* = 16785119'i32

const KEY_ohorntilde* = 16785121'i32

const KEY_omacron* = 1010'i32

const KEY_oneeighth* = 2755'i32

const KEY_onefifth* = 2738'i32

const KEY_onehalf* = 189'i32

const KEY_onequarter* = 188'i32

const KEY_onesixth* = 2742'i32

const KEY_onesubscript* = 16785537'i32

const KEY_onesuperior* = 185'i32

const KEY_onethird* = 2736'i32

const KEY_ooblique* = 248'i32

const KEY_openrectbullet* = 2786'i32

const KEY_openstar* = 2789'i32

const KEY_opentribulletdown* = 2788'i32

const KEY_opentribulletup* = 2787'i32

const KEY_ordfeminine* = 170'i32

const KEY_oslash* = 248'i32

const KEY_otilde* = 245'i32

const KEY_overbar* = 3008'i32

const KEY_overline* = 1150'i32

const KEY_p* = 112'i32

const KEY_pabovedot* = 16784983'i32

const KEY_paragraph* = 182'i32

const KEY_parenleft* = 40'i32

const KEY_parenright* = 41'i32

const KEY_partdifferential* = 16785922'i32

const KEY_partialderivative* = 2287'i32

const KEY_percent* = 37'i32

const KEY_period* = 46'i32

const KEY_periodcentered* = 183'i32

const KEY_permille* = 2773'i32

const KEY_phonographcopyright* = 2811'i32

const KEY_plus* = 43'i32

const KEY_plusminus* = 177'i32

const KEY_prescription* = 2772'i32

const KEY_prolongedsound* = 1200'i32

const KEY_punctspace* = 2726'i32

const KEY_q* = 113'i32

const KEY_quad* = 3020'i32

const KEY_question* = 63'i32

const KEY_questiondown* = 191'i32

const KEY_quotedbl* = 34'i32

const KEY_quoteleft* = 96'i32

const KEY_quoteright* = 39'i32

const KEY_r* = 114'i32

const KEY_racute* = 480'i32

const KEY_radical* = 2262'i32

const KEY_rcaron* = 504'i32

const KEY_rcedilla* = 947'i32

const KEY_registered* = 174'i32

const KEY_rightanglebracket* = 2750'i32

const KEY_rightarrow* = 2301'i32

const KEY_rightcaret* = 2982'i32

const KEY_rightdoublequotemark* = 2771'i32

const KEY_rightmiddlecurlybrace* = 2224'i32

const KEY_rightmiddlesummation* = 2231'i32

const KEY_rightopentriangle* = 2765'i32

const KEY_rightpointer* = 2795'i32

const KEY_rightshoe* = 3032'i32

const KEY_rightsinglequotemark* = 2769'i32

const KEY_rightt* = 2549'i32

const KEY_righttack* = 3068'i32

const KEY_s* = 115'i32

const KEY_sabovedot* = 16784993'i32

const KEY_sacute* = 438'i32

const KEY_scaron* = 441'i32

const KEY_scedilla* = 442'i32

const KEY_schwa* = 16777817'i32

const KEY_scircumflex* = 766'i32

const KEY_script_switch* = 65406'i32

const KEY_seconds* = 2775'i32

const KEY_section* = 167'i32

const KEY_semicolon* = 59'i32

const KEY_semivoicedsound* = 1247'i32

const KEY_seveneighths* = 2758'i32

const KEY_sevensubscript* = 16785543'i32

const KEY_sevensuperior* = 16785527'i32

const KEY_signaturemark* = 2762'i32

const KEY_signifblank* = 2732'i32

const KEY_similarequal* = 2249'i32

const KEY_singlelowquotemark* = 2813'i32

const KEY_sixsubscript* = 16785542'i32

const KEY_sixsuperior* = 16785526'i32

const KEY_slash* = 47'i32

const KEY_soliddiamond* = 2528'i32

const KEY_space* = 32'i32

const KEY_squareroot* = 16785946'i32

const KEY_ssharp* = 223'i32

const KEY_sterling* = 163'i32

const KEY_stricteq* = 16786019'i32

const KEY_t* = 116'i32

const KEY_tabovedot* = 16785003'i32

const KEY_tcaron* = 443'i32

const KEY_tcedilla* = 510'i32

const KEY_telephone* = 2809'i32

const KEY_telephonerecorder* = 2810'i32

const KEY_therefore* = 2240'i32

const KEY_thinspace* = 2727'i32

const KEY_thorn* = 254'i32

const KEY_threeeighths* = 2756'i32

const KEY_threefifths* = 2740'i32

const KEY_threequarters* = 190'i32

const KEY_threesubscript* = 16785539'i32

const KEY_threesuperior* = 179'i32

const KEY_tintegral* = 16785965'i32

const KEY_topintegral* = 2212'i32

const KEY_topleftparens* = 2219'i32

const KEY_topleftradical* = 2210'i32

const KEY_topleftsqbracket* = 2215'i32

const KEY_topleftsummation* = 2225'i32

const KEY_toprightparens* = 2221'i32

const KEY_toprightsqbracket* = 2217'i32

const KEY_toprightsummation* = 2229'i32

const KEY_topt* = 2551'i32

const KEY_topvertsummationconnector* = 2227'i32

const KEY_trademark* = 2761'i32

const KEY_trademarkincircle* = 2763'i32

const KEY_tslash* = 956'i32

const KEY_twofifths* = 2739'i32

const KEY_twosubscript* = 16785538'i32

const KEY_twosuperior* = 178'i32

const KEY_twothirds* = 2737'i32

const KEY_u* = 117'i32

const KEY_uacute* = 250'i32

const KEY_ubelowdot* = 16785125'i32

const KEY_ubreve* = 765'i32

const KEY_ucircumflex* = 251'i32

const KEY_udiaeresis* = 252'i32

const KEY_udoubleacute* = 507'i32

const KEY_ugrave* = 249'i32

const KEY_uhook* = 16785127'i32

const KEY_uhorn* = 16777648'i32

const KEY_uhornacute* = 16785129'i32

const KEY_uhornbelowdot* = 16785137'i32

const KEY_uhorngrave* = 16785131'i32

const KEY_uhornhook* = 16785133'i32

const KEY_uhorntilde* = 16785135'i32

const KEY_umacron* = 1022'i32

const KEY_underbar* = 3014'i32

const KEY_underscore* = 95'i32

const KEY_union* = 2269'i32

const KEY_uogonek* = 1017'i32

const KEY_uparrow* = 2300'i32

const KEY_upcaret* = 2985'i32

const KEY_upleftcorner* = 2540'i32

const KEY_uprightcorner* = 2539'i32

const KEY_upshoe* = 3011'i32

const KEY_upstile* = 3027'i32

const KEY_uptack* = 3022'i32

const KEY_uring* = 505'i32

const KEY_utilde* = 1021'i32

const KEY_v* = 118'i32

const KEY_variation* = 2241'i32

const KEY_vertbar* = 2552'i32

const KEY_vertconnector* = 2214'i32

const KEY_voicedsound* = 1246'i32

const KEY_vt* = 2537'i32

const KEY_w* = 119'i32

const KEY_wacute* = 16785027'i32

const KEY_wcircumflex* = 16777589'i32

const KEY_wdiaeresis* = 16785029'i32

const KEY_wgrave* = 16785025'i32

const KEY_x* = 120'i32

const KEY_xabovedot* = 16785035'i32

const KEY_y* = 121'i32

const KEY_yacute* = 253'i32

const KEY_ybelowdot* = 16785141'i32

const KEY_ycircumflex* = 16777591'i32

const KEY_ydiaeresis* = 255'i32

const KEY_yen* = 165'i32

const KEY_ygrave* = 16785139'i32

const KEY_yhook* = 16785143'i32

const KEY_ytilde* = 16785145'i32

const KEY_z* = 122'i32

const KEY_zabovedot* = 447'i32

const KEY_zacute* = 444'i32

const KEY_zcaron* = 446'i32

const KEY_zerosubscript* = 16785536'i32

const KEY_zerosuperior* = 16785520'i32

const KEY_zstroke* = 16777654'i32

type
  Keymap* = ref object of gobject.Object
  Keymap00* = object of gobject.Object00

proc scDirectionChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "direction-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scKeysChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "keys-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scStateChanged*(self: Keymap;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "state-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc gdk_keymap_get_default*(): ptr Keymap00 {.
    importc: "gdk_keymap_get_default", libprag.}

proc getDefault*(): Keymap =
  let gobj = gdk_keymap_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Keymap](g_object_get_qdata(gobj, Quark))
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

proc default*(): Keymap =
  let gobj = gdk_keymap_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Keymap](g_object_get_qdata(gobj, Quark))
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

proc gdk_keymap_get_for_display*(display: ptr Display00): ptr Keymap00 {.
    importc: "gdk_keymap_get_for_display", libprag.}

proc getForDisplay*(display: Display): Keymap =
  let gobj = gdk_keymap_get_for_display(cast[ptr Display00](display.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Keymap](g_object_get_qdata(gobj, Quark))
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

proc forDisplay*(display: Display): Keymap =
  let gobj = gdk_keymap_get_for_display(cast[ptr Display00](display.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Keymap](g_object_get_qdata(gobj, Quark))
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

proc gdk_keymap_add_virtual_modifiers*(self: ptr Keymap00; state: ModifierType) {.
    importc: "gdk_keymap_add_virtual_modifiers", libprag.}

proc addVirtualModifiers*(self: Keymap; state: ModifierType) =
  gdk_keymap_add_virtual_modifiers(cast[ptr Keymap00](self.impl), state)

proc gdk_keymap_get_caps_lock_state*(self: ptr Keymap00): gboolean {.
    importc: "gdk_keymap_get_caps_lock_state", libprag.}

proc getCapsLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_caps_lock_state(cast[ptr Keymap00](self.impl)))

proc capsLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_caps_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_direction*(self: ptr Keymap00): pango.Direction {.
    importc: "gdk_keymap_get_direction", libprag.}

proc getDirection*(self: Keymap): pango.Direction =
  gdk_keymap_get_direction(cast[ptr Keymap00](self.impl))

proc direction*(self: Keymap): pango.Direction =
  gdk_keymap_get_direction(cast[ptr Keymap00](self.impl))

proc gdk_keymap_get_modifier_state*(self: ptr Keymap00): uint32 {.
    importc: "gdk_keymap_get_modifier_state", libprag.}

proc getModifierState*(self: Keymap): int =
  int(gdk_keymap_get_modifier_state(cast[ptr Keymap00](self.impl)))

proc modifierState*(self: Keymap): int =
  int(gdk_keymap_get_modifier_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_num_lock_state*(self: ptr Keymap00): gboolean {.
    importc: "gdk_keymap_get_num_lock_state", libprag.}

proc getNumLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_num_lock_state(cast[ptr Keymap00](self.impl)))

proc numLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_num_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_get_scroll_lock_state*(self: ptr Keymap00): gboolean {.
    importc: "gdk_keymap_get_scroll_lock_state", libprag.}

proc getScrollLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_scroll_lock_state(cast[ptr Keymap00](self.impl)))

proc scrollLockState*(self: Keymap): bool =
  toBool(gdk_keymap_get_scroll_lock_state(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_have_bidi_layouts*(self: ptr Keymap00): gboolean {.
    importc: "gdk_keymap_have_bidi_layouts", libprag.}

proc haveBidiLayouts*(self: Keymap): bool =
  toBool(gdk_keymap_have_bidi_layouts(cast[ptr Keymap00](self.impl)))

proc gdk_keymap_map_virtual_modifiers*(self: ptr Keymap00; state: ModifierType): gboolean {.
    importc: "gdk_keymap_map_virtual_modifiers", libprag.}

proc mapVirtualModifiers*(self: Keymap; state: ModifierType): bool =
  toBool(gdk_keymap_map_virtual_modifiers(cast[ptr Keymap00](self.impl), state))

proc gdk_keymap_translate_keyboard_state*(self: ptr Keymap00; hardwareKeycode: uint32; state: ModifierType; 
    group: int32; keyval: var uint32; effectiveGroup: var int32; level: var int32; 
    consumedModifiers: var ModifierType): gboolean {.
    importc: "gdk_keymap_translate_keyboard_state", libprag.}

proc translateKeyboardState*(self: Keymap; hardwareKeycode: int; state: ModifierType; 
    group: int; keyval: var int; effectiveGroup: var int; level: var int; consumedModifiers: var ModifierType): bool =
  var level_00 = int32(level)
  var keyval_00 = uint32(keyval)
  var effectiveGroup_00 = int32(effectiveGroup)
  result = toBool(gdk_keymap_translate_keyboard_state(cast[ptr Keymap00](self.impl), uint32(hardwareKeycode), state, int32(group), keyval_00, effectiveGroup_00, level_00, consumedModifiers))
  level = int(level_00)
  keyval = int(keyval_00)
  effectiveGroup = int(effectiveGroup_00)

type
  ModifierIntent* {.size: sizeof(cint), pure.} = enum
    primaryAccelerator = 0
    contextMenu = 1
    extendSelection = 2
    modifySelection = 3
    noTextInput = 4
    shiftGroup = 5
    defaultModMask = 6

proc gdk_keymap_get_modifier_mask*(self: ptr Keymap00; intent: ModifierIntent): ModifierType {.
    importc: "gdk_keymap_get_modifier_mask", libprag.}

proc getModifierMask*(self: Keymap; intent: ModifierIntent): ModifierType =
  gdk_keymap_get_modifier_mask(cast[ptr Keymap00](self.impl), intent)

proc modifierMask*(self: Keymap; intent: ModifierIntent): ModifierType =
  gdk_keymap_get_modifier_mask(cast[ptr Keymap00](self.impl), intent)

type
  KeymapKey00* {.pure.} = object
    keycode*: uint32
    group*: int32
    level*: int32
  KeymapKey* = ref object
    impl*: ptr KeymapKey00

proc gdk_keymap_get_entries_for_keycode*(self: ptr Keymap00; hardwareKeycode: uint32; keys: var KeymapKey00Array; 
    keyvals: var uint32Array; nEntries: var int32): gboolean {.
    importc: "gdk_keymap_get_entries_for_keycode", libprag.}

proc getEntriesForKeycode*(self: Keymap; hardwareKeycode: int; keys: var KeymapKey00Array; 
    keyvals: var uint32Array; nEntries: var int): bool =
  var nEntries_00 = int32(nEntries)
  result = toBool(gdk_keymap_get_entries_for_keycode(cast[ptr Keymap00](self.impl), uint32(hardwareKeycode), keys, keyvals, nEntries_00))
  nEntries = int(nEntries_00)

proc entriesForKeycode*(self: Keymap; hardwareKeycode: int; keys: var KeymapKey00Array; 
    keyvals: var uint32Array; nEntries: var int): bool =
  var nEntries_00 = int32(nEntries)
  result = toBool(gdk_keymap_get_entries_for_keycode(cast[ptr Keymap00](self.impl), uint32(hardwareKeycode), keys, keyvals, nEntries_00))
  nEntries = int(nEntries_00)

proc gdk_keymap_get_entries_for_keyval*(self: ptr Keymap00; keyval: uint32; keys: var KeymapKey00Array; 
    nKeys: var int32): gboolean {.
    importc: "gdk_keymap_get_entries_for_keyval", libprag.}

proc getEntriesForKeyval*(self: Keymap; keyval: int; keys: var KeymapKey00Array; 
    nKeys: var int): bool =
  var nKeys_00 = int32(nKeys)
  result = toBool(gdk_keymap_get_entries_for_keyval(cast[ptr Keymap00](self.impl), uint32(keyval), keys, nKeys_00))
  nKeys = int(nKeys_00)

proc entriesForKeyval*(self: Keymap; keyval: int; keys: var KeymapKey00Array; 
    nKeys: var int): bool =
  var nKeys_00 = int32(nKeys)
  result = toBool(gdk_keymap_get_entries_for_keyval(cast[ptr Keymap00](self.impl), uint32(keyval), keys, nKeys_00))
  nKeys = int(nKeys_00)

proc gdk_keymap_lookup_key*(self: ptr Keymap00; key: ptr KeymapKey00): uint32 {.
    importc: "gdk_keymap_lookup_key", libprag.}

proc lookupKey*(self: Keymap; key: KeymapKey): int =
  int(gdk_keymap_lookup_key(cast[ptr Keymap00](self.impl), cast[ptr KeymapKey00](key.impl)))

const MAX_TIMECOORD_AXES* = 128'i32

type
  MonitorClass00* {.pure.} = object
  MonitorClass* = ref object
    impl*: ptr MonitorClass00

const PARENT_RELATIVE* = 1'i32

const PRIORITY_REDRAW* = 20'i32

type
  Point00* {.pure.} = object
    x*: int32
    y*: int32
  Point* = ref object
    impl*: ptr Point00

type
  PropMode* {.size: sizeof(cint), pure.} = enum
    replace = 0
    prepend = 1
    append = 2

type
  SeatGrabPrepareFunc* = proc (seat: ptr Seat00; window: ptr Window00; userData: pointer) {.cdecl.}

proc gdk_seat_grab*(self: ptr Seat00; window: ptr Window00; capabilities: SeatCapabilities; 
    ownerEvents: gboolean; cursor: ptr Cursor00; event: ptr Event00; prepareFunc: SeatGrabPrepareFunc; 
    prepareFuncData: pointer): GrabStatus {.
    importc: "gdk_seat_grab", libprag.}

proc grab*(self: Seat; window: Window; capabilities: SeatCapabilities; 
    ownerEvents: bool; cursor: Cursor; event: Event; prepareFunc: SeatGrabPrepareFunc; prepareFuncData: pointer): GrabStatus =
  gdk_seat_grab(cast[ptr Seat00](self.impl), cast[ptr Window00](window.impl), capabilities, gboolean(ownerEvents), cast[ptr Cursor00](cursor.impl), cast[ptr Event00](event.impl), prepareFunc, prepareFuncData)

type
  Status* {.size: sizeof(cint), pure.} = enum
    errorMem = -4
    errorFile = -3
    errorParam = -2
    error = -1
    ok = 0

type
  TimeCoord00* {.pure.} = object
    time*: uint32
    axes*: array[128, cdouble]
  TimeCoord* = ref object
    impl*: ptr TimeCoord00

type
  WindowChildFunc* = proc (window: ptr Window00; userData: pointer): gboolean {.cdecl.}

proc gdk_window_invalidate_maybe_recurse*(self: ptr Window00; region: ptr cairo.Region00; childFunc: WindowChildFunc; 
    userData: pointer) {.
    importc: "gdk_window_invalidate_maybe_recurse", libprag.}

proc invalidateMaybeRecurse*(self: Window; region: cairo.Region; childFunc: WindowChildFunc; 
    userData: pointer) =
  gdk_window_invalidate_maybe_recurse(cast[ptr Window00](self.impl), cast[ptr cairo.Region00](region.impl), childFunc, userData)

type
  WindowClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    pickEmbeddedChild*: pointer
    toEmbedder*: proc(window: ptr Window00; offscreenX: cdouble; offscreenY: cdouble; 
    embedderX: ptr cdouble; embedderY: ptr cdouble) {.cdecl.}
    fromEmbedder*: proc(window: ptr Window00; embedderX: cdouble; embedderY: cdouble; 
    offscreenX: ptr cdouble; offscreenY: ptr cdouble) {.cdecl.}
    createSurface*: proc(window: ptr Window00; width: int32; height: int32): ptr cairo.Surface00 {.cdecl.}
    gdkReserved1*: pointer
    gdkReserved2*: pointer
    gdkReserved3*: pointer
    gdkReserved4*: pointer
    gdkReserved5*: pointer
    gdkReserved6*: pointer
    gdkReserved7*: pointer
    gdkReserved8*: pointer
  WindowClass* = ref object
    impl*: ptr WindowClass00

type
  WindowInvalidateHandlerFunc* = proc (window: ptr Window00; region: ptr cairo.Region00) {.cdecl.}

type
  WindowRedirect00* {.pure.} = object
  WindowRedirect* = ref object
    impl*: ptr WindowRedirect00

proc gdk_add_option_entries_libgtk_only*(group: ptr glib.OptionGroup00) {.
    importc: "gdk_add_option_entries_libgtk_only", libprag.}

proc addOptionEntriesLibgtkOnly*(group: glib.OptionGroup) =
  gdk_add_option_entries_libgtk_only(cast[ptr glib.OptionGroup00](group.impl))

proc gdk_beep*() {.
    importc: "gdk_beep", libprag.}

proc beep*() {.
    importc: "gdk_beep", libprag.}

proc gdk_cairo_create*(window: ptr Window00): ptr cairo.Context00 {.
    importc: "gdk_cairo_create", libprag.}

proc cairoCreate*(window: Window): cairo.Context =
  new(result)
  result.impl = gdk_cairo_create(cast[ptr Window00](window.impl))

proc gdk_cairo_draw_from_gl*(cr: ptr cairo.Context00; window: ptr Window00; source: int32; 
    sourceType: int32; bufferScale: int32; x: int32; y: int32; width: int32; height: int32) {.
    importc: "gdk_cairo_draw_from_gl", libprag.}

proc cairoDrawFromGl*(cr: cairo.Context; window: Window; source: int; sourceType: int; 
    bufferScale: int; x: int; y: int; width: int; height: int) =
  gdk_cairo_draw_from_gl(cast[ptr cairo.Context00](cr.impl), cast[ptr Window00](window.impl), int32(source), int32(sourceType), int32(bufferScale), int32(x), int32(y), int32(width), int32(height))

proc gdk_cairo_get_clip_rectangle*(cr: ptr cairo.Context00; rect: var Rectangle00): gboolean {.
    importc: "gdk_cairo_get_clip_rectangle", libprag.}

proc cairoGetClipRectangle*(cr: ptr cairo.Context00; rect: var Rectangle00): gboolean {.
    importc: "gdk_cairo_get_clip_rectangle", libprag.}

proc gdk_cairo_get_drawing_context*(cr: ptr cairo.Context00): ptr DrawingContext00 {.
    importc: "gdk_cairo_get_drawing_context", libprag.}

proc cairoGetDrawingContext*(cr: cairo.Context): DrawingContext =
  let gobj = gdk_cairo_get_drawing_context(cast[ptr cairo.Context00](cr.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DrawingContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_cairo_rectangle*(cr: ptr cairo.Context00; rectangle: ptr Rectangle00) {.
    importc: "gdk_cairo_rectangle", libprag.}

proc cairoRectangle*(cr: cairo.Context; rectangle: Rectangle) =
  gdk_cairo_rectangle(cast[ptr cairo.Context00](cr.impl), cast[ptr Rectangle00](rectangle.impl))

proc gdk_cairo_region*(cr: ptr cairo.Context00; region: ptr cairo.Region00) {.
    importc: "gdk_cairo_region", libprag.}

proc cairoRegion*(cr: cairo.Context; region: cairo.Region) =
  gdk_cairo_region(cast[ptr cairo.Context00](cr.impl), cast[ptr cairo.Region00](region.impl))

proc gdk_cairo_region_create_from_surface*(surface: ptr cairo.Surface00): ptr cairo.Region00 {.
    importc: "gdk_cairo_region_create_from_surface", libprag.}

proc cairoRegionCreateFromSurface*(surface: cairo.Surface): cairo.Region =
  new(result)
  result.impl = gdk_cairo_region_create_from_surface(cast[ptr cairo.Surface00](surface.impl))

proc gdk_cairo_set_source_color*(cr: ptr cairo.Context00; color: ptr Color00) {.
    importc: "gdk_cairo_set_source_color", libprag.}

proc cairoSetSourceColor*(cr: cairo.Context; color: Color) =
  gdk_cairo_set_source_color(cast[ptr cairo.Context00](cr.impl), cast[ptr Color00](color.impl))

proc gdk_cairo_set_source_pixbuf*(cr: ptr cairo.Context00; pixbuf: ptr gdkpixbuf.Pixbuf00; 
    pixbufX: cdouble; pixbufY: cdouble) {.
    importc: "gdk_cairo_set_source_pixbuf", libprag.}

proc cairoSetSourcePixbuf*(cr: cairo.Context; pixbuf: gdkpixbuf.Pixbuf; pixbufX: cdouble; 
    pixbufY: cdouble) =
  gdk_cairo_set_source_pixbuf(cast[ptr cairo.Context00](cr.impl), cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), pixbufX, pixbufY)

proc gdk_cairo_set_source_rgba*(cr: ptr cairo.Context00; rgba: ptr RGBA00) {.
    importc: "gdk_cairo_set_source_rgba", libprag.}

proc cairoSetSourceRgba*(cr: cairo.Context; rgba: RGBA) =
  gdk_cairo_set_source_rgba(cast[ptr cairo.Context00](cr.impl), cast[ptr RGBA00](rgba.impl))

proc gdk_cairo_set_source_window*(cr: ptr cairo.Context00; window: ptr Window00; x: cdouble; 
    y: cdouble) {.
    importc: "gdk_cairo_set_source_window", libprag.}

proc cairoSetSourceWindow*(cr: cairo.Context; window: Window; x: cdouble; y: cdouble) =
  gdk_cairo_set_source_window(cast[ptr cairo.Context00](cr.impl), cast[ptr Window00](window.impl), x, y)

proc gdk_cairo_surface_create_from_pixbuf*(pixbuf: ptr gdkpixbuf.Pixbuf00; scale: int32; forWindow: ptr Window00): ptr cairo.Surface00 {.
    importc: "gdk_cairo_surface_create_from_pixbuf", libprag.}

proc cairoSurfaceCreateFromPixbuf*(pixbuf: gdkpixbuf.Pixbuf; scale: int; forWindow: Window): cairo.Surface =
  new(result)
  result.impl = gdk_cairo_surface_create_from_pixbuf(cast[ptr gdkpixbuf.Pixbuf00](pixbuf.impl), int32(scale), cast[ptr Window00](forWindow.impl))

proc gdk_disable_multidevice*() {.
    importc: "gdk_disable_multidevice", libprag.}

proc disableMultidevice*() {.
    importc: "gdk_disable_multidevice", libprag.}

proc gdk_drag_abort*(context: ptr DragContext00; time: uint32) {.
    importc: "gdk_drag_abort", libprag.}

proc dragAbort*(context: DragContext; time: int) =
  gdk_drag_abort(cast[ptr DragContext00](context.impl), uint32(time))

proc gdk_drag_begin*(window: ptr Window00; targets: ptr pointer): ptr DragContext00 {.
    importc: "gdk_drag_begin", libprag.}

proc dragBegin*(window: Window; targets: ptr pointer): DragContext =
  let gobj = gdk_drag_begin(cast[ptr Window00](window.impl), targets)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DragContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_begin_for_device*(window: ptr Window00; device: ptr Device00; targets: ptr pointer): ptr DragContext00 {.
    importc: "gdk_drag_begin_for_device", libprag.}

proc dragBeginForDevice*(window: Window; device: Device; targets: ptr pointer): DragContext =
  let gobj = gdk_drag_begin_for_device(cast[ptr Window00](window.impl), cast[ptr Device00](device.impl), targets)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DragContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_begin_from_point*(window: ptr Window00; device: ptr Device00; targets: ptr pointer; 
    xRoot: int32; yRoot: int32): ptr DragContext00 {.
    importc: "gdk_drag_begin_from_point", libprag.}

proc dragBeginFromPoint*(window: Window; device: Device; targets: ptr pointer; 
    xRoot: int; yRoot: int): DragContext =
  let gobj = gdk_drag_begin_from_point(cast[ptr Window00](window.impl), cast[ptr Device00](device.impl), targets, int32(xRoot), int32(yRoot))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DragContext](g_object_get_qdata(gobj, Quark))
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

proc gdk_drag_drop*(context: ptr DragContext00; time: uint32) {.
    importc: "gdk_drag_drop", libprag.}

proc dragDrop*(context: DragContext; time: int) =
  gdk_drag_drop(cast[ptr DragContext00](context.impl), uint32(time))

proc gdk_drag_drop_done*(context: ptr DragContext00; success: gboolean) {.
    importc: "gdk_drag_drop_done", libprag.}

proc dragDropDone*(context: DragContext; success: bool) =
  gdk_drag_drop_done(cast[ptr DragContext00](context.impl), gboolean(success))

proc gdk_drag_drop_succeeded*(context: ptr DragContext00): gboolean {.
    importc: "gdk_drag_drop_succeeded", libprag.}

proc dragDropSucceeded*(context: DragContext): bool =
  toBool(gdk_drag_drop_succeeded(cast[ptr DragContext00](context.impl)))

proc gdk_drag_find_window_for_screen*(context: ptr DragContext00; dragWindow: ptr Window00; 
    screen: ptr Screen00; xRoot: int32; yRoot: int32; destWindow: var ptr Window00; protocol: var DragProtocol) {.
    importc: "gdk_drag_find_window_for_screen", libprag.}

proc dragFindWindowForScreen*(context: ptr DragContext00; dragWindow: ptr Window00; 
    screen: ptr Screen00; xRoot: int32; yRoot: int32; destWindow: var ptr Window00; protocol: var DragProtocol) {.
    importc: "gdk_drag_find_window_for_screen", libprag.}

proc gdk_drag_get_selection*(context: ptr DragContext00): ptr Atom00 {.
    importc: "gdk_drag_get_selection", libprag.}

proc dragGetSelection*(context: DragContext): Atom =
  new(result)
  result.impl = gdk_drag_get_selection(cast[ptr DragContext00](context.impl))

proc gdk_drag_motion*(context: ptr DragContext00; destWindow: ptr Window00; 
    protocol: DragProtocol; xRoot: int32; yRoot: int32; suggestedAction: DragAction; possibleActions: DragAction; 
    time: uint32): gboolean {.
    importc: "gdk_drag_motion", libprag.}

proc dragMotion*(context: DragContext; destWindow: Window; protocol: DragProtocol; 
    xRoot: int; yRoot: int; suggestedAction: DragAction; possibleActions: DragAction; 
    time: int): bool =
  toBool(gdk_drag_motion(cast[ptr DragContext00](context.impl), cast[ptr Window00](destWindow.impl), protocol, int32(xRoot), int32(yRoot), suggestedAction, possibleActions, uint32(time)))

proc gdk_drag_status*(context: ptr DragContext00; action: DragAction; time: uint32) {.
    importc: "gdk_drag_status", libprag.}

proc dragStatus*(context: DragContext; action: DragAction; time: int) =
  gdk_drag_status(cast[ptr DragContext00](context.impl), action, uint32(time))

proc gdk_drop_finish*(context: ptr DragContext00; success: gboolean; time: uint32) {.
    importc: "gdk_drop_finish", libprag.}

proc dropFinish*(context: DragContext; success: bool; time: int) =
  gdk_drop_finish(cast[ptr DragContext00](context.impl), gboolean(success), uint32(time))

proc gdk_drop_reply*(context: ptr DragContext00; accepted: gboolean; time: uint32) {.
    importc: "gdk_drop_reply", libprag.}

proc dropReply*(context: DragContext; accepted: bool; time: int) =
  gdk_drop_reply(cast[ptr DragContext00](context.impl), gboolean(accepted), uint32(time))

proc gdk_error_trap_pop*(): int32 {.
    importc: "gdk_error_trap_pop", libprag.}

proc errorTrapPop*(): int32 {.
    importc: "gdk_error_trap_pop", libprag.}

proc gdk_error_trap_pop_ignored*() {.
    importc: "gdk_error_trap_pop_ignored", libprag.}

proc errorTrapPopIgnored*() {.
    importc: "gdk_error_trap_pop_ignored", libprag.}

proc gdk_error_trap_push*() {.
    importc: "gdk_error_trap_push", libprag.}

proc errorTrapPush*() {.
    importc: "gdk_error_trap_push", libprag.}

proc gdk_events_pending*(): gboolean {.
    importc: "gdk_events_pending", libprag.}

proc eventsPending*(): gboolean {.
    importc: "gdk_events_pending", libprag.}

proc gdk_flush*() {.
    importc: "gdk_flush", libprag.}

proc flush*() {.
    importc: "gdk_flush", libprag.}

proc gdk_get_default_root_window*(): ptr Window00 {.
    importc: "gdk_get_default_root_window", libprag.}

proc getDefaultRootWindow*(): Window =
  let gobj = gdk_get_default_root_window()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc defaultRootWindow*(): Window =
  let gobj = gdk_get_default_root_window()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_get_display*(): cstring {.
    importc: "gdk_get_display", libprag.}

proc getDisplay*(): string =
  let resul0 = gdk_get_display()
  result = $resul0
  cogfree(resul0)

proc display*(): string =
  let resul0 = gdk_get_display()
  result = $resul0
  cogfree(resul0)

proc gdk_get_display_arg_name*(): cstring {.
    importc: "gdk_get_display_arg_name", libprag.}

proc getDisplayArgName*(): string =
  let resul0 = gdk_get_display_arg_name()
  result = $resul0

proc displayArgName*(): string =
  let resul0 = gdk_get_display_arg_name()
  result = $resul0

proc gdk_get_program_class*(): cstring {.
    importc: "gdk_get_program_class", libprag.}

proc getProgramClass*(): string =
  let resul0 = gdk_get_program_class()
  result = $resul0

proc programClass*(): string =
  let resul0 = gdk_get_program_class()
  result = $resul0

proc gdk_get_show_events*(): gboolean {.
    importc: "gdk_get_show_events", libprag.}

proc getShowEvents*(): gboolean {.
    importc: "gdk_get_show_events", libprag.}

proc showEvents*(): gboolean {.
    importc: "gdk_get_show_events", libprag.}

proc gdk_init*(argc: int32; argv: cstringArray) {.
    importc: "gdk_init", libprag.}

proc init*(argc: int32; argv: cstringArray) {.
    importc: "gdk_init", libprag.}

proc gdk_init_check*(argc: int32; argv: cstringArray): gboolean {.
    importc: "gdk_init_check", libprag.}

proc initCheck*(argc: int32; argv: cstringArray): gboolean {.
    importc: "gdk_init_check", libprag.}

proc gdk_keyboard_grab*(window: ptr Window00; ownerEvents: gboolean; time: uint32): GrabStatus {.
    importc: "gdk_keyboard_grab", libprag.}

proc keyboardGrab*(window: Window; ownerEvents: bool; time: int): GrabStatus =
  gdk_keyboard_grab(cast[ptr Window00](window.impl), gboolean(ownerEvents), uint32(time))

proc gdk_keyboard_ungrab*(time: uint32) {.
    importc: "gdk_keyboard_ungrab", libprag.}

proc keyboardUngrab*(time: uint32) {.
    importc: "gdk_keyboard_ungrab", libprag.}

proc gdk_keyval_convert_case*(symbol: uint32; lower: var uint32; upper: var uint32) {.
    importc: "gdk_keyval_convert_case", libprag.}

proc keyvalConvertCase*(symbol: uint32; lower: var uint32; upper: var uint32) {.
    importc: "gdk_keyval_convert_case", libprag.}

proc gdk_keyval_from_name*(keyvalName: cstring): uint32 {.
    importc: "gdk_keyval_from_name", libprag.}

proc keyvalFromName*(keyvalName: cstring): uint32 {.
    importc: "gdk_keyval_from_name", libprag.}

proc gdk_keyval_is_lower*(keyval: uint32): gboolean {.
    importc: "gdk_keyval_is_lower", libprag.}

proc keyvalIsLower*(keyval: uint32): gboolean {.
    importc: "gdk_keyval_is_lower", libprag.}

proc gdk_keyval_is_upper*(keyval: uint32): gboolean {.
    importc: "gdk_keyval_is_upper", libprag.}

proc keyvalIsUpper*(keyval: uint32): gboolean {.
    importc: "gdk_keyval_is_upper", libprag.}

proc gdk_keyval_name*(keyval: uint32): cstring {.
    importc: "gdk_keyval_name", libprag.}

proc keyvalName*(keyval: int): string =
  let resul0 = gdk_keyval_name(uint32(keyval))
  result = $resul0

proc gdk_keyval_to_lower*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_lower", libprag.}

proc keyvalToLower*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_lower", libprag.}

proc gdk_keyval_to_unicode*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_unicode", libprag.}

proc keyvalToUnicode*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_unicode", libprag.}

proc gdk_keyval_to_upper*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_upper", libprag.}

proc keyvalToUpper*(keyval: uint32): uint32 {.
    importc: "gdk_keyval_to_upper", libprag.}

proc gdk_list_visuals*(): ptr pointer {.
    importc: "gdk_list_visuals", libprag.}

proc listVisuals*(): ptr pointer {.
    importc: "gdk_list_visuals", libprag.}

proc gdk_notify_startup_complete*() {.
    importc: "gdk_notify_startup_complete", libprag.}

proc notifyStartupComplete*() {.
    importc: "gdk_notify_startup_complete", libprag.}

proc gdk_notify_startup_complete_with_id*(startupId: cstring) {.
    importc: "gdk_notify_startup_complete_with_id", libprag.}

proc notifyStartupCompleteWithId*(startupId: cstring) {.
    importc: "gdk_notify_startup_complete_with_id", libprag.}

proc gdk_offscreen_window_get_embedder*(window: ptr Window00): ptr Window00 {.
    importc: "gdk_offscreen_window_get_embedder", libprag.}

proc offscreenWindowGetEmbedder*(window: Window): Window =
  let gobj = gdk_offscreen_window_get_embedder(cast[ptr Window00](window.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_offscreen_window_get_surface*(window: ptr Window00): ptr cairo.Surface00 {.
    importc: "gdk_offscreen_window_get_surface", libprag.}

proc offscreenWindowGetSurface*(window: Window): cairo.Surface =
  new(result)
  result.impl = gdk_offscreen_window_get_surface(cast[ptr Window00](window.impl))

proc gdk_offscreen_window_set_embedder*(window: ptr Window00; embedder: ptr Window00) {.
    importc: "gdk_offscreen_window_set_embedder", libprag.}

proc offscreenWindowSetEmbedder*(window: Window; embedder: Window) =
  gdk_offscreen_window_set_embedder(cast[ptr Window00](window.impl), cast[ptr Window00](embedder.impl))

proc gdk_pango_context_get*(): ptr pango.Context00 {.
    importc: "gdk_pango_context_get", libprag.}

proc pangoContextGet*(): pango.Context =
  let gobj = gdk_pango_context_get()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[pango.Context](g_object_get_qdata(gobj, Quark))
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

proc gdk_pango_context_get_for_display*(display: ptr Display00): ptr pango.Context00 {.
    importc: "gdk_pango_context_get_for_display", libprag.}

proc pangoContextGetForDisplay*(display: Display): pango.Context =
  let gobj = gdk_pango_context_get_for_display(cast[ptr Display00](display.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[pango.Context](g_object_get_qdata(gobj, Quark))
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

proc gdk_pango_context_get_for_screen*(screen: ptr Screen00): ptr pango.Context00 {.
    importc: "gdk_pango_context_get_for_screen", libprag.}

proc pangoContextGetForScreen*(screen: Screen): pango.Context =
  let gobj = gdk_pango_context_get_for_screen(cast[ptr Screen00](screen.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[pango.Context](g_object_get_qdata(gobj, Quark))
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

proc gdk_parse_args*(argc: int32; argv: cstringArray) {.
    importc: "gdk_parse_args", libprag.}

proc parseArgs*(argc: int32; argv: cstringArray) {.
    importc: "gdk_parse_args", libprag.}

proc gdk_pixbuf_get_from_surface*(surface: ptr cairo.Surface00; srcX: int32; srcY: int32; 
    width: int32; height: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc: "gdk_pixbuf_get_from_surface", libprag.}

proc pixbufGetFromSurface*(surface: cairo.Surface; srcX: int; srcY: int; width: int; 
    height: int): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_surface(cast[ptr cairo.Surface00](surface.impl), int32(srcX), int32(srcY), int32(width), int32(height))
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

proc gdk_pixbuf_get_from_window*(window: ptr Window00; srcX: int32; srcY: int32; width: int32; 
    height: int32): ptr gdkpixbuf.Pixbuf00 {.
    importc: "gdk_pixbuf_get_from_window", libprag.}

proc pixbufGetFromWindow*(window: Window; srcX: int; srcY: int; width: int; 
    height: int): gdkpixbuf.Pixbuf =
  let gobj = gdk_pixbuf_get_from_window(cast[ptr Window00](window.impl), int32(srcX), int32(srcY), int32(width), int32(height))
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

proc gdk_pointer_grab*(window: ptr Window00; ownerEvents: gboolean; eventMask: EventMask; 
    confineTo: ptr Window00; cursor: ptr Cursor00; time: uint32): GrabStatus {.
    importc: "gdk_pointer_grab", libprag.}

proc pointerGrab*(window: Window; ownerEvents: bool; eventMask: EventMask; 
    confineTo: Window; cursor: Cursor; time: int): GrabStatus =
  gdk_pointer_grab(cast[ptr Window00](window.impl), gboolean(ownerEvents), eventMask, cast[ptr Window00](confineTo.impl), cast[ptr Cursor00](cursor.impl), uint32(time))

proc gdk_pointer_is_grabbed*(): gboolean {.
    importc: "gdk_pointer_is_grabbed", libprag.}

proc pointerIsGrabbed*(): gboolean {.
    importc: "gdk_pointer_is_grabbed", libprag.}

proc gdk_pointer_ungrab*(time: uint32) {.
    importc: "gdk_pointer_ungrab", libprag.}

proc pointerUngrab*(time: uint32) {.
    importc: "gdk_pointer_ungrab", libprag.}

proc gdk_pre_parse_libgtk_only*() {.
    importc: "gdk_pre_parse_libgtk_only", libprag.}

proc preParseLibgtkOnly*() {.
    importc: "gdk_pre_parse_libgtk_only", libprag.}

proc gdk_property_delete*(window: ptr Window00; property: ptr Atom00) {.
    importc: "gdk_property_delete", libprag.}

proc propertyDelete*(window: Window; property: Atom) =
  gdk_property_delete(cast[ptr Window00](window.impl), cast[ptr Atom00](property.impl))

proc gdk_property_get*(window: ptr Window00; property: ptr Atom00; `type`: ptr Atom00; 
    offset: uint64; length: uint64; pdelete: int32; actualPropertyType: var ptr Atom00; 
    actualFormat: var int32; actualLength: var int32; data: var uint8Array): gboolean {.
    importc: "gdk_property_get", libprag.}

proc propertyGet*(window: ptr Window00; property: ptr Atom00; `type`: ptr Atom00; 
    offset: uint64; length: uint64; pdelete: int32; actualPropertyType: var ptr Atom00; 
    actualFormat: var int32; actualLength: var int32; data: var uint8Array): gboolean {.
    importc: "gdk_property_get", libprag.}

proc gdk_query_depths*(depths: var int32Array; count: var int32) {.
    importc: "gdk_query_depths", libprag.}

proc queryDepths*(depths: var int32Array; count: var int32) {.
    importc: "gdk_query_depths", libprag.}

proc gdk_query_visual_types*(visualTypes: var VisualTypeArray; count: var int32) {.
    importc: "gdk_query_visual_types", libprag.}

proc queryVisualTypes*(visualTypes: var VisualTypeArray; count: var int32) {.
    importc: "gdk_query_visual_types", libprag.}

proc gdk_selection_convert*(requestor: ptr Window00; selection: ptr Atom00; target: ptr Atom00; 
    time: uint32) {.
    importc: "gdk_selection_convert", libprag.}

proc selectionConvert*(requestor: Window; selection: Atom; target: Atom; 
    time: int) =
  gdk_selection_convert(cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), uint32(time))

proc gdk_selection_owner_get*(selection: ptr Atom00): ptr Window00 {.
    importc: "gdk_selection_owner_get", libprag.}

proc selectionOwnerGet*(selection: Atom): Window =
  let gobj = gdk_selection_owner_get(cast[ptr Atom00](selection.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_selection_owner_get_for_display*(display: ptr Display00; selection: ptr Atom00): ptr Window00 {.
    importc: "gdk_selection_owner_get_for_display", libprag.}

proc selectionOwnerGetForDisplay*(display: Display; selection: Atom): Window =
  let gobj = gdk_selection_owner_get_for_display(cast[ptr Display00](display.impl), cast[ptr Atom00](selection.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Window](g_object_get_qdata(gobj, Quark))
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

proc gdk_selection_owner_set*(owner: ptr Window00; selection: ptr Atom00; time: uint32; 
    sendEvent: gboolean): gboolean {.
    importc: "gdk_selection_owner_set", libprag.}

proc selectionOwnerSet*(owner: Window; selection: Atom; time: int; sendEvent: bool): bool =
  toBool(gdk_selection_owner_set(cast[ptr Window00](owner.impl), cast[ptr Atom00](selection.impl), uint32(time), gboolean(sendEvent)))

proc gdk_selection_owner_set_for_display*(display: ptr Display00; owner: ptr Window00; selection: ptr Atom00; 
    time: uint32; sendEvent: gboolean): gboolean {.
    importc: "gdk_selection_owner_set_for_display", libprag.}

proc selectionOwnerSetForDisplay*(display: Display; owner: Window; selection: Atom; 
    time: int; sendEvent: bool): bool =
  toBool(gdk_selection_owner_set_for_display(cast[ptr Display00](display.impl), cast[ptr Window00](owner.impl), cast[ptr Atom00](selection.impl), uint32(time), gboolean(sendEvent)))

proc gdk_selection_send_notify*(requestor: ptr Window00; selection: ptr Atom00; target: ptr Atom00; 
    property: ptr Atom00; time: uint32) {.
    importc: "gdk_selection_send_notify", libprag.}

proc selectionSendNotify*(requestor: Window; selection: Atom; target: Atom; 
    property: Atom; time: int) =
  gdk_selection_send_notify(cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), cast[ptr Atom00](property.impl), uint32(time))

proc gdk_selection_send_notify_for_display*(display: ptr Display00; requestor: ptr Window00; selection: ptr Atom00; 
    target: ptr Atom00; property: ptr Atom00; time: uint32) {.
    importc: "gdk_selection_send_notify_for_display", libprag.}

proc selectionSendNotifyForDisplay*(display: Display; requestor: Window; selection: Atom; 
    target: Atom; property: Atom; time: int) =
  gdk_selection_send_notify_for_display(cast[ptr Display00](display.impl), cast[ptr Window00](requestor.impl), cast[ptr Atom00](selection.impl), cast[ptr Atom00](target.impl), cast[ptr Atom00](property.impl), uint32(time))

proc gdk_set_allowed_backends*(backends: cstring) {.
    importc: "gdk_set_allowed_backends", libprag.}

proc setAllowedBackends*(backends: cstring) {.
    importc: "gdk_set_allowed_backends", libprag.}

proc `allowedBackends=`*(backends: cstring) {.
    importc: "gdk_set_allowed_backends", libprag.}

proc gdk_set_double_click_time*(msec: uint32) {.
    importc: "gdk_set_double_click_time", libprag.}

proc setDoubleClickTime*(msec: uint32) {.
    importc: "gdk_set_double_click_time", libprag.}

proc `doubleClickTime=`*(msec: uint32) {.
    importc: "gdk_set_double_click_time", libprag.}

proc gdk_set_program_class*(programClass: cstring) {.
    importc: "gdk_set_program_class", libprag.}

proc setProgramClass*(programClass: cstring) {.
    importc: "gdk_set_program_class", libprag.}

proc `programClass=`*(programClass: cstring) {.
    importc: "gdk_set_program_class", libprag.}

proc gdk_set_show_events*(showEvents: gboolean) {.
    importc: "gdk_set_show_events", libprag.}

proc setShowEvents*(showEvents: gboolean) {.
    importc: "gdk_set_show_events", libprag.}

proc `showEvents=`*(showEvents: gboolean) {.
    importc: "gdk_set_show_events", libprag.}

proc gdk_setting_get*(name: cstring; value: ptr gobject.Value00): gboolean {.
    importc: "gdk_setting_get", libprag.}

proc settingGet*(name: string; value: gobject.Value): bool =
  toBool(gdk_setting_get(cstring(name), cast[ptr gobject.Value00](value.impl)))

proc `tingGet=`*(name: string; value: gobject.Value): bool =
  toBool(gdk_setting_get(cstring(name), cast[ptr gobject.Value00](value.impl)))

proc gdk_synthesize_window_state*(window: ptr Window00; unsetFlags: WindowState; setFlags: WindowState) {.
    importc: "gdk_synthesize_window_state", libprag.}

proc synthesizeWindowState*(window: Window; unsetFlags: WindowState; setFlags: WindowState) =
  gdk_synthesize_window_state(cast[ptr Window00](window.impl), unsetFlags, setFlags)

proc gdk_test_render_sync*(window: ptr Window00) {.
    importc: "gdk_test_render_sync", libprag.}

proc testRenderSync*(window: Window) =
  gdk_test_render_sync(cast[ptr Window00](window.impl))

proc gdk_test_simulate_button*(window: ptr Window00; x: int32; y: int32; button: uint32; 
    modifiers: ModifierType; buttonPressrelease: EventType): gboolean {.
    importc: "gdk_test_simulate_button", libprag.}

proc testSimulateButton*(window: Window; x: int; y: int; button: int; modifiers: ModifierType; 
    buttonPressrelease: EventType): bool =
  toBool(gdk_test_simulate_button(cast[ptr Window00](window.impl), int32(x), int32(y), uint32(button), modifiers, buttonPressrelease))

proc gdk_test_simulate_key*(window: ptr Window00; x: int32; y: int32; keyval: uint32; 
    modifiers: ModifierType; keyPressrelease: EventType): gboolean {.
    importc: "gdk_test_simulate_key", libprag.}

proc testSimulateKey*(window: Window; x: int; y: int; keyval: int; modifiers: ModifierType; 
    keyPressrelease: EventType): bool =
  toBool(gdk_test_simulate_key(cast[ptr Window00](window.impl), int32(x), int32(y), uint32(keyval), modifiers, keyPressrelease))

proc gdk_text_property_to_utf8_list_for_display*(display: ptr Display00; encoding: ptr Atom00; format: int32; 
    text: uint8Array; length: int32; list: var cstringArray): int32 {.
    importc: "gdk_text_property_to_utf8_list_for_display", libprag.}

proc textPropertyToUtf8ListForDisplay*(display: Display; encoding: Atom; format: int; text: uint8Array; 
    length: int; list: var cstringArray): int =
  int(gdk_text_property_to_utf8_list_for_display(cast[ptr Display00](display.impl), cast[ptr Atom00](encoding.impl), int32(format), text, int32(length), list))

proc gdk_threads_add_idle_full*(priority: int32; function: SourceFunc; data: pointer; 
    notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_idle_full", libprag.}

proc threadsAddIdle*(priority: int32; function: SourceFunc; data: pointer; 
    notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_idle_full", libprag.}

proc gdk_threads_add_timeout_full*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_timeout_full", libprag.}

proc threadsAddTimeout*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_timeout_full", libprag.}

proc gdk_threads_add_timeout_seconds_full*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_timeout_seconds_full", libprag.}

proc threadsAddTimeoutSeconds*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "gdk_threads_add_timeout_seconds_full", libprag.}

proc gdk_threads_enter*() {.
    importc: "gdk_threads_enter", libprag.}

proc threadsEnter*() {.
    importc: "gdk_threads_enter", libprag.}

proc gdk_threads_init*() {.
    importc: "gdk_threads_init", libprag.}

proc threadsInit*() {.
    importc: "gdk_threads_init", libprag.}

proc gdk_threads_leave*() {.
    importc: "gdk_threads_leave", libprag.}

proc threadsLeave*() {.
    importc: "gdk_threads_leave", libprag.}

proc gdk_unicode_to_keyval*(wc: uint32): uint32 {.
    importc: "gdk_unicode_to_keyval", libprag.}

proc unicodeToKeyval*(wc: uint32): uint32 {.
    importc: "gdk_unicode_to_keyval", libprag.}

proc gdk_utf8_to_string_target*(str: cstring): cstring {.
    importc: "gdk_utf8_to_string_target", libprag.}

proc utf8ToStringTarget*(str: string): string =
  let resul0 = gdk_utf8_to_string_target(cstring(str))
  result = $resul0
  cogfree(resul0)
# === remaining symbols:

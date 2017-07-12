# dependencies:
# GLib-2.0
# immediate dependencies:
# GLib-2.0
# libraries:
# libgmodule-2.0.so.0
{.deadCodeElim: on.}
import glib
const Lib* = "libgmodule-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
let Quark = g_quark_from_static_string("NimGIQuark")

type
  Module00* {.pure.} = object
  Module* = ref object
    impl*: ptr Module00

proc g_module_close*(self: ptr Module00): gboolean {.
    importc: "g_module_close", libprag.}

proc close*(self: Module): bool =
  toBool(g_module_close(cast[ptr Module00](self.impl)))

proc g_module_make_resident*(self: ptr Module00) {.
    importc: "g_module_make_resident", libprag.}

proc makeResident*(self: Module) =
  g_module_make_resident(cast[ptr Module00](self.impl))

proc g_module_name*(self: ptr Module00): cstring {.
    importc: "g_module_name", libprag.}

proc name*(self: Module): string =
  let resul0 = g_module_name(cast[ptr Module00](self.impl))
  result = $resul0

proc g_module_symbol*(self: ptr Module00; symbolName: cstring; symbol: var pointer): gboolean {.
    importc: "g_module_symbol", libprag.}

proc symbol*(self: Module; symbolName: string; symbol: var pointer): bool =
  toBool(g_module_symbol(cast[ptr Module00](self.impl), cstring(symbolName), symbol))

proc g_module_build_path*(directory: cstring; moduleName: cstring): cstring {.
    importc: "g_module_build_path", libprag.}

proc buildPath*(directory: string; moduleName: string): string =
  let resul0 = g_module_build_path(cstring(directory), cstring(moduleName))
  result = $resul0
  cogfree(resul0)

proc g_module_error*(): cstring {.
    importc: "g_module_error", libprag.}

proc error*(): string =
  let resul0 = g_module_error()
  result = $resul0

proc g_module_supported*(): gboolean {.
    importc: "g_module_supported", libprag.}

proc supported*(): gboolean {.
    importc: "g_module_supported", libprag.}

type
  ModuleCheckInit* = proc (module: ptr Module00): cstring {.cdecl.}

type
  ModuleFlags* {.size: sizeof(cint), pure.} = enum
    lazy = 1
    local = 2
    mask = 3

type
  ModuleUnload* = proc (module: ptr Module00) {.cdecl.}
# === remaining symbols:

# dependencies:
# immediate dependencies:
# libraries:
# libcairo-gobject.so.2
{.deadCodeElim: on.}

const Lib* = "libcairo-gobject.so.2"
{.pragma: libprag, cdecl, dynlib: Lib.}

type
  Context00* {.pure.} = object
  Context* = ref object
    impl*: ptr Context00

type
  Surface00* {.pure.} = object
  Surface* = ref object
    impl*: ptr Surface00

type
  Matrix00* {.pure.} = object
  Matrix* = ref object
    impl*: ptr Matrix00

type
  Pattern00* {.pure.} = object
  Pattern* = ref object
    impl*: ptr Pattern00

type
  Region00* {.pure.} = object
  Region* = ref object
    impl*: ptr Region00

type
  Content* {.size: sizeof(cint), pure.} = enum
    COLOR = 4096
    ALPHA = 8192
    COLOR_ALPHA = 12288

type
  FontOptions00* {.pure.} = object
  FontOptions* = ref object
    impl*: ptr FontOptions00

type
  FontType00* {.pure.} = object
  FontType* = ref object
    impl*: ptr FontType00

type
  FontFace00* {.pure.} = object
  FontFace* = ref object
    impl*: ptr FontFace00

type
  ScaledFont00* {.pure.} = object
  ScaledFont* = ref object
    impl*: ptr ScaledFont00

type
  Path00* {.pure.} = object
  Path* = ref object
    impl*: ptr Path00

type
  RectangleInt00* {.pure.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  RectangleInt* = ref object
    impl*: ptr RectangleInt00

proc cairo_image_surface_create*() {.
    importc: "cairo_image_surface_create", libprag.}

proc imageSurfaceCreate*() {.
    importc: "cairo_image_surface_create", libprag.}
# === remaining symbols:

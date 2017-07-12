# dependencies:
# immediate dependencies:
# libraries:
# 
{.deadCodeElim: on.}

const Lib* = ""
{.pragma: libprag, cdecl, dynlib: Lib.}

type
  Display00* {.pure.} = object
  Display* = ref object
    impl*: ptr Display00

type
  Screen00* {.pure.} = object
  Screen* = ref object
    impl*: ptr Screen00

type
  Visual00* {.pure.} = object
  Visual* = ref object
    impl*: ptr Visual00

type
  XEvent00* = object {.union.}
  XEvent* = ref object
    impl*: ptr XEvent00

type
  XConfigureEvent00* {.pure.} = object
  XConfigureEvent* = ref object
    impl*: ptr XConfigureEvent00

type
  XImage00* {.pure.} = object
  XImage* = ref object
    impl*: ptr XImage00

type
  XFontStruct00* {.pure.} = object
  XFontStruct* = ref object
    impl*: ptr XFontStruct00

type
  XTrapezoid00* {.pure.} = object
  XTrapezoid* = ref object
    impl*: ptr XTrapezoid00

type
  XVisualInfo00* {.pure.} = object
  XVisualInfo* = ref object
    impl*: ptr XVisualInfo00

type
  XWindowAttributes00* {.pure.} = object
  XWindowAttributes* = ref object
    impl*: ptr XWindowAttributes00

proc XOpenDisplay*() {.
    importc: "XOpenDisplay", libprag.}

proc openDisplay*() {.
    importc: "XOpenDisplay", libprag.}
# === remaining symbols:

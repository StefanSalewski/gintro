# This is the high level cairo module for Nim -- based on the low level ngtk3 module, manually tuned.
# (c) S. Salewski 2017, cairo 1.15.6
# v0.9.4
# 10-AUG-2021

# starting with gintro v.0.6.0 we split cairo into the gobject-introspection generated cairo.nim and this file.

# Cairo does not really support gobject introspection and gobject's toggle references.
# So code for memory management is a bit different compared to other gtk modules.

# This was the initial template for creation of new objects :

# proc newImageSurface*(format: Format; width, height: int): Surface =
#   new(result, surfaceDestroy) 
#   result.impl = cairo_image_surface_create(format, width.cint, height.cint)
#   discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

# with
# proc gcuref(o: pointer) {.cdecl.} =  GC_unref(cast[RootRef](o))
# proc surfaceDestroy*(surface: Surface) = cairo_surface_destroy(surface.impl)

# and this is the template for refering such an object:

#proc newContext*(target: Surface): Context =
#  new(result, destroy)
#  GC_ref(target)
#  result.impl = cairo_create(target.impl)
#  discard cairo_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

# We have to call GC_ref() because we store no direct reference to the proxy object, while
# cairo_get_target() allows us to get the surface back from cairo context.
# For this example cairo_create() references the surface.
# When ref count of surface is decreased, maybe because context is destroyed, then gcuref is called
# which calls GC_unref() on proxy. When there is no other ref to proxy GC can free proxy and surface
# by calling surfaceDestroy(). This works also when surface is newer used for something.
 
# But there is at least one design flaw:
# When we create for example a surface and GC releases it, then gcunref() is called on it while
# gc_ref() was newer called. When we consider that the cairo context is the only element which
# stores references to other objects, then we can simplify the code to (Footnote: This is not really
# true, for example Pattern stores references to surface too -- but it should work similar.)

# proc newImageSurface*(format: Format; width, height: int): Surface =
#   new(result, surfaceDestroy) 
#   result.impl = cairo_image_surface_create(format, width.cint, height.cint)

# with

# proc surfaceDestroy*(surface: Surface) = cairo_surface_destroy(surface.impl)

# and this is the template for refering such an object:

# proc newContext*(target: Surface): Context =
#  new(result, destroy)
#  GC_ref(target)
#  result.impl = cairo_create(target.impl)
#   discard cairo_surface_set_user_data(target.impl, NUDK, cast[pointer](target), gcuref)

# with
# proc gcuref(o: pointer) {.cdecl.} =  GC_unref(cast[RootRef](o))

# cairo_image_surface_create() set refcount of the plain cairo surface to 1.
# cairo_create() increases refcount of surface (by 2), cairo destroy decreases
# surface refcount again. cairo_surface_set_user_data() ensures that
# Nim surface proxy element is unreffed when refcount of cairo surface
# drops to zero, so surfaceDestroy() frees the cairo memory.

# Note: For some other procs like cairo_set_source_surface() we also need code like
#  discard cairo_surface_set_user_data(target.impl, NUDK, cast[pointer](target), gcuref)

# Currently this is all not really tested.

# One problem may be procs like cairo_surface_create_similar() when called frequently, maybe
# for each frame in animations. GC may be too slow in freeing the memory.
# We should try to avoid such usage, or we may add a way to manually free memory.
# Maybe later destructors can be used, or newruntime with owned refs?

# Maybe currently the best fix is to allow manually calling destroy() procs, which then ignore
# the later call from GC because impl field is already nil. 

# Some procs are marked with label TODO -- because I have no real idea what to do with them

# sed -E -i '/proc cairo/s/([a-z0-9])([A-Z])/\1_\L\2/g' cairo.nim
# sed -E 's/_([a-z])/\U\1/g' <<< my_long_variable
# sed -i 's/importc: "[a-z_]*"/importc/g' cairo.nim
{.deadCodeElim: on.}

when defined(windows):
  const LIB_CAIRO* = "libcairo-2.dll"
elif defined(macosx):
  const LIB_CAIRO* = "libcairo.dylib"
else:
  const LIB_CAIRO* = "libcairo.so(|.2)"

{.pragma: libcairo, cdecl, dynlib: LIB_CAIRO.}

const
  CAIRO_HAS_TEE_SURFACE = true
  CAIRO_HAS_DRM_SURFACE = true
  CAIRO_HAS_SKIA_SURFACE = true
  CAIRO_HAS_SCRIPT_SURFACE = true
  CAIRO_HAS_XML_SURFACE = true
  CAIRO_HAS_SVG_SURFACE = true
  CAIRO_HAS_PS_SURFACE = true
  CAIRO_HAS_PDF_SURFACE = true
  CAIRO_HAS_PNG_FUNCTIONS = true

template cairo_Version_Encode*(major, minor, micro: untyped): untyped =
  ((major * 10000) + (minor * 100) + (micro * 1))

proc cairo_version*(): cint {.importc, libcairo.}
proc cairo_version_string*(): cstring {.importc, libcairo.}

type
  Bool00* = distinct cint

# we should not need these constants
#const
#  CAIRO_FALSE* = Bool00(0)
#  CAIRO_TRUE* = Bool00(1)

#converter cbool*(nimbool: bool): Bool00 =
#  ord(nimbool).Bool00

#converter toBool*(cbool: Bool00): bool =
#  int(cbool) != 0

type
  DestroyFunc00* = proc (data: pointer) {.cdecl.}

type
  UserDataKey* = object
    unused: cint
  #UserDataKey* = ref object
  #  impl*: ptr UserDataKey00

var NUDK: ptr UserDataKey = cast[ptr UserDataKey](alloc(sizeof(UserDataKey)))

# copy from glib.nim
template fnew(a: untyped; finalizer: untyped) =
  # when compileOption("gc", "arc"):
  when defined(gcDestructors):
    new(a)
  else:
    new(a, finalizer)

proc gcuref(o: pointer) {.cdecl.} =
  #echo "gcunref"
  GC_unref(cast[RootRef](o))

type
  WriteFunc00* = proc (closure: pointer; data: ptr cuchar; length: cuint): Status {.cdecl.}

type
  ReadFunc00* = proc (closure: pointer; data: ptr cuchar; length: cuint): Status {.cdecl.}

proc cairo_get_user_data*(cr: ptr Context00; key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(cr: Context; key: ptr UserDataKey): pointer =
  cairo_get_user_data(cr.impl, key)
#
#const userData* = getUserData

proc cairo_set_user_data*(cr: ptr Context00; key: ptr UserDataKey; user_data: pointer;
  destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(cr: Context; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_set_user_data(cr.impl, key, userData, destroy)
#
#const `userData=`* = setUserData

proc cairo_destroy*(cr: ptr Context00) {.importc, libcairo.}
#
proc destroy*(cr: Context) =
  if cr != nil and cr.impl != nil:
    cairo_destroy(cr.impl)
    cr.impl = nil

proc cairo_surface_reference*(surface: ptr Surface00): ptr Surface00 {.importc, libcairo.}
#
proc surfaceReference*(surface: Surface): Surface =
  discard cairo_surface_reference(surface.impl)
  return surface

proc cairo_surface_set_user_data*(surface: ptr Surface00;
  key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(surface: Surface; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_surface_set_user_data(surface.impl, key, userData, destroy)

proc cairo_create*(target: ptr Surface00): ptr Context00 {.importc, libcairo.}
#
proc newContext*(target: Surface): Context =
  fnew(result, gBoxedFreeCairoContext)
  GC_ref(target)
  result.impl = cairo_create(target.impl)
  #discard cairo_surface_set_user_data(target.impl, NUDK, cast[pointer](target), gcuref) # that was wrong before v0.9.4
  discard cairo_set_user_data(result.impl, NUDK, cast[pointer](target), gcuref)

proc cairo_reference*(cr: ptr Context00): ptr Context00 {.importc, libcairo.}
#
proc reference*(cr: Context): Context =
  discard cairo_reference(cr.impl)
  return cr

proc cairo_get_reference_count*(cr: ptr Context00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(cr: Context): int =
  cairo_get_reference_count(cr.impl).int
#
#const referenceCount* = getReferenceCount

proc cairo_save*(cr: ptr Context00) {.importc, libcairo.}
#
proc save*(cr: Context) =
  cairo_save(cr.impl)

proc cairo_restore*(cr: ptr Context00) {.importc, libcairo.}
#
proc restore*(cr: Context) =
  cairo_restore(cr.impl)

proc cairo_push_group*(cr: ptr Context00) {.importc, libcairo.}
#
proc pushGroup*(cr: Context) =
  cairo_push_group(cr.impl)

proc cairo_push_group_with_content*(cr: ptr Context00; content: Content) {.importc, libcairo.}
#
proc pushGroup*(cr: Context; content: Content) =
  cairo_push_group_with_content(cr.impl, content)

proc cairo_pattern_destroy*(pattern: ptr Pattern00) {.importc, libcairo.}
#
proc patternDestroy*(pattern: Pattern) =
  if pattern != nil and pattern.impl != nil:
    cairo_pattern_destroy(pattern.impl)
    pattern.impl = nil

proc cairo_pattern_set_user_data*(pattern: ptr Pattern00; key: ptr UserDataKey; userData: pointer;
  destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(pattern: Pattern; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_pattern_set_user_data(pattern.impl, key, userData, destroy)

proc cairo_pop_group*(cr: ptr Context00): ptr Pattern00 {.importc, libcairo.}
#
proc popGroup*(cr: Context): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pop_group(cr.impl)
  GC_Ref(result)
  discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pop_group_to_source*(cr: ptr Context00) {.importc, libcairo.}
#
proc popGroupToSource*(cr: Context) =
  cairo_pop_group_to_source(cr.impl)

proc cairo_set_operator*(cr: ptr Context00; op: Operator) {.importc, libcairo.}
#
proc setOperator*(cr: Context; op: Operator) =
  cairo_set_operator(cr.impl, op)
#
#const `operator=`* = setOperator

proc cairo_pattern_get_reference_count*(pattern: ptr Pattern00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(pattern: Pattern): int =
  cairo_pattern_get_reference_count(pattern.impl).int

proc cairo_pattern_get_user_data*(pattern: ptr Pattern00; key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(pattern: Pattern; key: ptr UserDataKey): pointer =
  cairo_pattern_get_user_data(pattern.impl, key)

proc cairo_pattern_reference*(pattern: ptr Pattern00): ptr Pattern00 {.importc, libcairo.}
#
proc patternReference*(pattern: Pattern): Pattern =
  discard cairo_pattern_reference(pattern.impl)
  return pattern

# Returns the current source pattern. This object is owned by cairo.
# To keep a reference to it, you must call cairo_pattern_reference().
proc cairo_get_source*(cr: ptr Context00): ptr Pattern00 {.importc, libcairo.}
#
proc getSource*(cr: Context): Pattern =
  let h = cairo_get_source(cr.impl)
  let d = cairo_pattern_get_user_data(h, NUDK)
  if d.isNil:
    fnew(result, gBoxedFreeCairoPattern)
    result.impl = cairo_pattern_reference(h)
  else:
    result = cast[Pattern](d)
    assert(result.impl == h)
#
#const source* = getSource

proc tryReleasePat(crimpl: ptr Context00) =
  let oldpattern = cairo_get_source(crimpl)
  if oldpattern != nil:
    let o = cairo_pattern_get_user_data(oldpattern, NUDK)
    if o != nil:
      discard cairo_pattern_set_user_data(oldpattern, NUDK, nil, nil)
      GC_unref(cast[Pattern](o))

proc cairo_set_source*(cr: ptr Context00; source: ptr Pattern00) {.importc, libcairo.}
#
proc setSource*(cr: Context; source: Pattern) =
  # echo cast[int](source), " ", cast[int](source.impl)
  # new for gintro v0.9.4
  GC_ref(source) # better before tryReleasePat() ?
  tryReleasePat(cr.impl)
  #GC_ref(source)
  cairo_set_source(cr.impl, source.impl)
  discard cairo_pattern_set_user_data(source.impl, NUDK, cast[pointer](source), nil) # store reference to the Nim proxy object
  discard cairo_set_user_data(cr.impl, NUDK, cast[pointer](source), gcuref) # When Context gets collected Pattern is unreffed
#
#const `source=`* = setSource

proc cairo_set_source_rgb*(cr: ptr Context00; red, green, blue: cdouble) {.importc, libcairo.}
#
#proc setSourceRgb*(cr: Context; red, green, blue: float) =
proc setSource*(cr: Context; red, green, blue: float) =
  #tryReleasePat(cr.impl) # wrong!
  #echo cast[int](cairo_get_source(cr.impl))
  cairo_set_source_rgb(cr.impl, red.cdouble, green.cdouble, blue.cdouble)
  #echo cast[int](cairo_get_source(cr.impl)), "++"
#
#const `source=`* = setSourceRgb
proc setSource*(cr: Context; rgb: array[3, float]) =
  #tryReleasePat(cr.impl)
  cairo_set_source_rgb(cr.impl, rgb[0], rgb[1], rgb[2])
#
proc setSource*(cr: Context; rgb: tuple[r, g, b: float]) =
  #tryReleasePat(cr.impl)
  cairo_set_source_rgb(cr.impl, rgb[0], rgb[1], rgb[2])

proc cairo_set_source_rgba*(cr: ptr Context00; red, green, blue, alpha: cdouble) {.importc, libcairo.}
#
proc setSource*(cr: Context; red, green, blue, alpha: float) =
  #tryReleasePat(cr.impl)
  cairo_set_source_rgba(cr.impl, red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)
#
#const `sourceRgba=`* = setSourceRgba
#
proc setSource*(cr: Context; rgba: array[4, float]) =
  #tryReleasePat(cr.impl)
  cairo_set_source_rgba(cr.impl, rgba[0],  rgba[1], rgba[2], rgba[3])
#
proc setSource*(cr: Context; rgba: tuple[r, g, b, a: float]) =
  #tryReleasePat(cr.impl)
  cairo_set_source_rgba(cr.impl, rgba[0],  rgba[1], rgba[2], rgba[3])

proc cairo_surface_get_reference_count*(surface: ptr Surface00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(surface: Surface): int =
  cairo_surface_get_reference_count(surface.impl).int
#
#const referenceCount* = getReferenceCount

proc cairo_set_source_surface*(cr: ptr Context00; surface: ptr Surface00; x, y: cdouble) {.importc, libcairo.}
#
proc setSourceSurface*(cr: Context; surface: Surface; x, y: float) =
  GC_ref(surface)
  cairo_set_source_surface(cr.impl, surface.impl, x.cdouble, y.cdouble)
  discard cairo_surface_set_user_data(surface.impl, NUDK, cast[pointer](surface), gcuref)
#const `sourceSurface=`* = setSourceSurface

proc cairo_set_tolerance*(cr: ptr Context00; tolerance: cdouble) {.importc, libcairo.}
#
proc setTolerance*(cr: Context; tolerance: float) =
  cairo_set_tolerance(cr.impl, tolerance.cdouble)
#
const `tolerance=`* = setTolerance

proc cairo_set_antialias*(cr: ptr Context00; antialias: Antialias) {.importc, libcairo.}
#
proc setAntialias*(cr: Context; antialias = Antialias.default) =
  cairo_set_antialias(cr.impl, antialias)
#
const `antialias=`* = setAntialias

proc cairo_set_fill_rule*(cr: ptr Context00; fillRule: FillRule) {.importc, libcairo.}
#
proc setFillRule*(cr: Context; fillRule: FillRule) =
  cairo_set_fill_rule(cr.impl, fillRule)
#
const `fillRule=`* = setFillRule

proc cairo_set_line_width*(cr: ptr Context00; width: cdouble) {.importc, libcairo.}
#
proc setLineWidth*(cr: Context; width: float) =
  cairo_set_line_width(cr.impl, width.cdouble)
#
const `lineWidth=`* = setLineWidth

proc cairo_set_line_cap*(cr: ptr Context00; lineCap: LineCap) {.importc, libcairo.}
#
proc setLineCap*(cr: Context; lineCap: LineCap) =
  cairo_set_line_cap(cr.impl, lineCap)
#
const `lineCap=`* = setLineCap

proc cairo_set_line_join*(cr: ptr Context00; lineJoin: Line_join) {.importc, libcairo.}
#
proc setLineJoin*(cr: Context; lineJoin: LineJoin) =
  cairo_set_line_join(cr.impl, lineJoin)
#
const `lineJoin=`* = setLineJoin

proc cairo_set_dash*(cr: ptr Context00; dashes: ptr cdouble; numDashes: cint; offset: cdouble) {.importc, libcairo.}
# TODO: use float array
proc setDash*(cr: Context; dashes: openArray[cdouble]; offset: cdouble = 0) =
  cairo_set_dash(cr.impl, unsafeaddr dashes[0], dashes.len.cint, offset)
#
#const `dash=`* = setDash

proc cairo_set_miter_limit*(cr: ptr Context00; limit: cdouble) {.importc, libcairo.}
#
proc setMiterLimit*(cr: Context; limit: float) =
  cairo_set_miter_limit(cr.impl, limit.cdouble)
#
const `miterLimit=`* = setMiterLimit

proc cairo_translate*(cr: ptr Context00; tx, ty: cdouble) {.importc, libcairo.}
#
proc translate*(cr: Context; tx, ty: float) =
  cairo_translate(cr.impl, tx.cdouble, ty.cdouble)

proc cairo_scale*(cr: ptr Context00; sx, sy: cdouble) {.importc, libcairo.}
#
proc scale*(cr: Context; sx, sy: float) =
  cairo_scale(cr.impl, sx.cdouble, sy.cdouble)

proc cairo_rotate*(cr: ptr Context00; angle: cdouble) {.importc, libcairo.}
#
proc rotate*(cr: Context; angle: float) =
  cairo_rotate(cr.impl, angle.cdouble)

#[
typedef struct {
    double xx; double yx;
    double xy; double yy;
    double x0; double y0;
} cairo_matrix_t;
]#

type
  Matrix* {.pure, byRef.} = object    
    xx*: cdouble
    yx*: cdouble
    xy*: cdouble
    yy*: cdouble
    x0*: cdouble
    y0*: cdouble

proc cairo_transform*(cr: ptr Context00; matrix: Matrix) {.importc, libcairo.}
#
proc transform*(cr: Context; matrix: Matrix) =
  cairo_transform(cr.impl, matrix)

proc cairo_set_matrix*(cr: ptr Context00; matrix: Matrix) {.importc, libcairo.}
#
proc setMatrix*(cr: Context; matrix: Matrix) =
  cairo_set_matrix(cr.impl, matrix)
#
const `matrix=`* = setMatrix

proc cairo_identity_matrix*(cr: ptr Context00) {.importc, libcairo.}
#
proc identityMatrix*(cr: Context) =
  cairo_identity_matrix(cr.impl)
#
const setIdentityMatrix* = identityMatrix

proc cairo_user_to_device*(cr: ptr Context00; x, y: var cdouble) {.importc, libcairo.}
#
proc userToDevice*(cr: Context; x, y: var float) =
  var x1, y1: cdouble
  (x1, y1) = (x, y)
  cairo_user_to_device(cr.impl, x1, y1)
  x = x1.float
  y = y1.float
#
proc userToDevice*(cr: Context; x, y: float): array[2, float] =
  result = [x, y]
  cairo_user_to_device(cr.impl, result[0], result[1])

proc cairo_user_to_device_distance*(cr: ptr Context00; dx, dy: var cdouble) {.importc, libcairo.}
#
proc userToDeviceDistance*(cr: Context; dx, dy: var float) =
  var dx1, dy1: cdouble
  (dx1, dy1) = (dx, dy)
  cairo_user_to_device_distance(cr.impl, dx1, dy1)
  dx = dx1.float
  dy = dy1.float
#
proc userToDeviceDistance*(cr: Context; dx, dy: float): array[2, float] =
  result = [dx, dy]
  cairo_user_to_device_distance(cr.impl, result[0], result[1])

proc cairo_device_to_user*(cr: ptr Context00; x, y: var cdouble) {.importc, libcairo.}
#
proc deviceToUser*(cr: Context; x, y: var float) =
  var x1, y1: cdouble
  (x1, y1) = (x, y)
  cairo_device_to_user(cr.impl, x1, y1)
  x = x1.float
  y = y1.float
#
proc deviceToUser*(cr: Context; x, y: float): array[2, float] =
  result = [x, y]
  cairo_device_to_user(cr.impl, result[0], result[1])

proc cairo_device_to_user_distance*(cr: ptr Context00; dx, dy: var cdouble) {.importc, libcairo.}
#
proc deviceToUserDistance*(cr: Context; dx, dy: var float) =
  var dx1, dy1: cdouble
  (dx1, dy1) = (dx, dy)
  cairo_device_to_user_distance(cr.impl, dx1, dy1)
  dx = dx1.float
  dy = dy1.float
#
proc deviceToUserDistance*(cr: Context; dx, dy: float): array[2, float] =
  result = [dx, dy]
  cairo_device_to_user_distance(cr.impl, result[0], result[1])

proc cairo_new_path*(cr: ptr Context00) {.importc, libcairo.}
#
proc newPath*(cr: Context) =
  cairo_new_path(cr.impl)

proc cairo_move_to*(cr: ptr Context00; x, y: cdouble) {.importc, libcairo.}
#
proc moveTo*(cr: Context; x, y: float) =
  cairo_move_to(cr.impl, x.cdouble, y.cdouble)

proc cairo_new_sub_path*(cr: ptr Context00) {.importc, libcairo.}
#
proc newSubPath*(cr: Context) =
  cairo_new_sub_path(cr.impl)

proc cairo_line_to*(cr: ptr Context00; x, y: cdouble) {.importc, libcairo.}
#
proc lineTo*(cr: Context; x, y: float) =
  cairo_line_to(cr.impl, x.cdouble, y.cdouble)

proc cairo_curve_to*(cr: ptr Context00; x1, y1, x2, y2, x3, y3: cdouble) {.importc, libcairo.}
#
proc curveTo*(cr: Context; x1, y1, x2, y2, x3, y3: float) =
  cairo_curve_to(cr.impl, x1.cdouble, y1.cdouble, x2.cdouble, y2.cdouble, x3.cdouble, y3.cdouble)

proc cairo_arc*(cr: ptr Context00; xc, yc, radius, angle1, angle2: cdouble) {.importc, libcairo.}
#
proc arc*(cr: Context; xc, yc, radius, angle1, angle2: float) =
  cairo_arc(cr.impl, xc.cdouble, yc.cdouble, radius.cdouble, angle1.cdouble, angle2.cdouble)

proc cairo_arc_negative*(cr: ptr Context00; xc, yc, radius, angle1, angle2: cdouble) {.importc, libcairo.}
#
proc arcNegative*(cr: Context; xc, yc, radius, angle1, angle2: float) =
  cairo_arc_negative(cr.impl, xc.cdouble, yc.cdouble, radius.cdouble, angle1.cdouble, angle2.cdouble)

proc cairo_rel_move_to*(cr: ptr Context00; dx, dy: cdouble) {.importc, libcairo.}
#
proc relMoveTo*(cr: Context; dx, dy: float) =
  cairo_rel_move_to(cr.impl, dx.cdouble, dy.cdouble)

proc cairo_rel_line_to*(cr: ptr Context00; dx, dy: cdouble) {.importc, libcairo.}
#
proc relLineTo*(cr: Context; dx, dy: float) =
  cairo_rel_line_to(cr.impl, dx.cdouble, dy.cdouble)

proc cairo_rel_curve_to*(cr: ptr Context00; dx1, dy1, dx2, dy2, dx3, dy3: cdouble) {.importc, libcairo.}
#
proc relCurveTo*(cr: Context; dx1, dy1, dx2, dy2, dx3, dy3: float) =
  cairo_rel_curve_to(cr.impl, dx1.cdouble, dy1.cdouble, dx2.cdouble, dy2.cdouble, dx3.cdouble, dy3.cdouble)

proc cairo_rectangle*(cr: ptr Context00; x, y, width, height: cdouble) {.importc, libcairo.}
#
proc rectangle*(cr: Context; x, y, width, height: float) =
  cairo_rectangle(cr.impl, x.cdouble, y.cdouble, width.cdouble, height.cdouble)

proc cairo_close_path*(cr: ptr Context00) {.importc, libcairo.}
#
proc closePath*(cr: Context) =
  cairo_close_path(cr.impl)

proc cairo_path_extents*(cr: ptr Context00; x1, y1, x2, y2: var cdouble) {.importc, libcairo.}
#
proc pathExtents*(cr: Context; x1, y1, x2, y2: var float) =
  var x10, y10, x20, y20: cdouble
  cairo_path_extents(cr.impl, x10, y10, x20, y20)
  x1 = x10
  y1 = y10
  x2 = x20
  y2 = y20

proc cairo_paint*(cr: ptr Context00) {.importc, libcairo.}
#
proc paint*(cr: Context) =
  cairo_paint(cr.impl)

proc cairo_paint_with_alpha*(cr: ptr Context00; alpha: cdouble) {.importc, libcairo.}
#
proc paintWithAlpha*(cr: Context; alpha: float) =
  cairo_paint_with_alpha(cr.impl, alpha.cdouble)

proc cairo_mask*(cr: ptr Context00; pattern: ptr Pattern00) {.importc, libcairo.}
#
proc mask*(cr: Context; pattern: Pattern) =
  let h = cairo_pattern_get_reference_count(pattern.impl)
  cairo_mask(cr.impl, pattern.impl)
  assert(h == cairo_pattern_get_reference_count(pattern.impl)) # is there really no reffering?

proc cairo_mask_surface*(cr: ptr Context00; surface: ptr Surface00; surface_x, surfaceY: cdouble) {.importc, libcairo.}
#
proc maskSurface*(cr: Context; surface: Surface; surfaceX, surfaceY: float) =
  let h = cairo_surface_get_reference_count(surface.impl)
  cairo_mask_surface(cr.impl, surface.impl, surfaceX.cdouble, surfaceY.cdouble)
  assert(h == cairo_surface_get_reference_count(surface.impl))

proc cairo_stroke*(cr: ptr Context00) {.importc, libcairo.}
#
proc stroke*(cr: Context) =
  cairo_stroke(cr.impl)

proc cairo_stroke_preserve*(cr: ptr Context00) {.importc, libcairo.}
#
proc strokePreserve*(cr: Context) =
  cairo_stroke_preserve(cr.impl)

proc cairo_fill*(cr: ptr Context00) {.importc, libcairo.}
#
proc fill*(cr: Context) =
  cairo_fill(cr.impl)

proc cairo_fill_preserve*(cr: ptr Context00) {.importc, libcairo.}
#
proc fillPreserve*(cr: Context) =
  cairo_fill_preserve(cr.impl)

proc cairo_copy_page*(cr: ptr Context00) {.importc, libcairo.}
#
proc copyPage*(cr: Context) =
  cairo_copy_page(cr.impl)

proc cairo_show_page*(cr: ptr Context00) {.importc, libcairo.}
#
proc showPage*(cr: Context) =
  cairo_show_page(cr.impl)

proc cairo_in_stroke*(cr: ptr Context00; x, y: cdouble): Bool00 {.importc, libcairo.}
#
proc inStroke*(cr: Context; x, y: float): bool =
  cairo_in_stroke(cr.impl, x.cdouble, y.cdouble).bool

proc cairo_in_fill*(cr: ptr Context00; x, y: cdouble): Bool00 {.importc, libcairo.}
#
proc inFill*(cr: Context; x, y: float): bool =
  cairo_in_fill(cr.impl, x.cdouble, y.cdouble).bool

proc cairo_in_clip*(cr: ptr Context00; x, y: cdouble): Bool00 {.importc, libcairo.}
#
proc inClip*(cr: Context; x, y: float): bool =
  cairo_in_clip(cr.impl, x.cdouble, y.cdouble).bool

proc cairo_stroke_extents*(cr: ptr Context00; x1, y1, x2, y2: var cdouble) {.importc, libcairo.}
#
proc strokeExtents*(cr: Context; x1, y1, x2, y2: var float) =
  var x10, y10, x20, y20: cdouble
  cairo_stroke_extents(cr.impl, x10.cdouble, y10.cdouble, x20.cdouble, y20.cdouble)
  x1 = x10.float
  y1 = y10.float
  x2 = x20.float
  y2 = y20.float

proc cairo_fill_extents*(cr: ptr Context00; x1, y1, x2, y2: var cdouble) {.importc, libcairo.}
#
proc fillExtents*(cr: Context; x1, y1, x2, y2: var float) =
  var x10, y10, x20, y20: cdouble
  cairo_fill_extents(cr.impl, x10, y10, x20, y20)
  x1 = x10.float
  y1 = y10.float
  x2 = x20.float
  y2 = y20.float

proc cairo_reset_clip*(cr: ptr Context00) {.importc, libcairo.}
#
proc resetClip*(cr: Context) =
  cairo_reset_clip(cr.impl)

proc cairo_clip*(cr: ptr Context00) {.importc, libcairo.}
#
proc clip*(cr: Context) =
  cairo_clip(cr.impl)

proc cairo_clip_preserve*(cr: ptr Context00) {.importc, libcairo.}
#
proc clipPreserve*(cr: Context) =
  cairo_clip_preserve(cr.impl)

proc cairo_clip_extents*(cr: ptr Context00; x1, y1, x2, y2: var cdouble) {.importc, libcairo.}
#
proc clipExtents*(cr: Context; x1, y1, x2, y2: var float) =
  var x10, y10, x20, y20: cdouble
  cairo_clip_extents(cr.impl, x10, y10, x20, y20)
  x1 = x10.float
  y1 = y10.float
  x2 = x20.float
  y2 = y20.float

const getClipExtents* = clipExtents

type
  RectangleList00* = object
    status*: Status
    rectangles*: ptr Rectangle
    numRectangles*: cint

proc cairo_copy_clip_rectangle_list(cr: ptr Context00): ptr RectangleList00 {.importc, libcairo.}

proc cairo_rectangle_list_destroy(rectangle_list: ptr RectangleList00) {.importc, libcairo.}

proc copyClipRectangleList*(cr: Context): seq[Rectangle] =
  var h: Rectangle
  var r = cairo_copy_clip_rectangle_list(cr.impl)
  defer: cairo_rectangle_list_destroy(r)
  if r.status != Status.success or r.numRectangles == 0: return @[]
  result = newSeq[Rectangle]()
  for i in 0 ..< r.numRectangles:
    let k = cast[ptr array[99, Rectangle]](r.rectangles)[i]
    h.x = k.x.float
    h.y = k.y.float
    h.width = k.width.float
    h.height = k.height.float
    result.add(h)

const
  CAIRO_TAG_DEST* = "cairo.dest"
  CAIRO_TAG_LINK* = "Link"

proc cairo_tag_begin*(cr: ptr Context00; tagName: cstring; attributes: cstring) {.importc, libcairo.}
#
proc tagBegin*(cr: Context; tagName: string; attributes: string) =
  cairo_tag_begin(cr.impl, tagName, attributes)

proc cairo_tag_end*(cr: ptr Context00; tagName: cstring) {.importc, libcairo.}
#
proc tagEnd*(cr: Context; tagName: string) =
  cairo_tag_end(cr.impl, tagName)

type
  Glyph00* = object
    index*: culong
    x*: cdouble
    y*: cdouble

  Glyph* = ref object of RootRef
    impl*: ptr Glyph00

# TODO
proc cairo_glyph_allocate*(num_glyphs: cint): ptr Glyph00 {.importc, libcairo.}
proc cairo_glyph_free*(glyphs: ptr Glyph00) {.importc,
    libcairo.}

type
  TextCluster00* = object
    numBytes*: cint
    numGlyphs*: cint

  TextCluster* = ref object of RootRef
    impl*: ptr TextCluster00

# TODO
proc cairo_text_cluster_allocate*(num_clusters: cint): ptr Text_cluster00 {.importc, libcairo.}
proc cairo_text_cluster_free*(clusters: ptr Text_cluster00) {.importc, libcairo.}

type
  TextExtents* {.byRef.} = object
    xBearing*: cdouble
    yBearing*: cdouble
    width*: cdouble
    height*: cdouble
    xAdvance*: cdouble
    yAdvance*: cdouble

type
  FontExtents* {.byRef.} = object
    ascent*: cdouble
    descent*: cdouble
    height*: cdouble
    maxXAdvance*: cdouble
    maxYAdvance*: cdouble

proc cairo_font_options_destroy*(options: ptr FontOptions00) {.importc, libcairo.}
#
#proc fontOptionsDestroy(options: FontOptions) =
#  cairo_font_options_destroy(options.impl)

# FontOptions00 is special -- there is no cairo_font_options_set_user_data() and no cairo_font_options_reference()
proc cairo_font_options_create*(): ptr FontOptions00 {.importc, libcairo.}
#
proc newFontOptions*(): FontOptions =
  fnew(result, gBoxedFreeCairoFontOptions)
  result.impl = cairo_font_options_create()
  ###discard cairo_font_options_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_font_options_copy*(original: ptr FontOptions00): ptr FontOptions00 {.importc, libcairo.}
#
proc fontOptionsCopy*(original: FontOptions): FontOptions =
  fnew(result, gBoxedFreeCairoFontOptions)
  result.impl = cairo_font_options_copy(original.impl)

proc cairo_font_options_status*(options: ptr FontOptions00): Status {.importc, libcairo.}
#
proc status*(options: FontOptions): Status =
  cairo_font_options_status(options.impl)

proc cairo_font_options_merge*(options: ptr FontOptions00; other: ptr FontOptions00) {.importc, libcairo.}
#
proc merge*(options: FontOptions; other: FontOptions) =
  cairo_font_options_merge(options.impl, other.impl)

proc cairo_font_options_equal*(options: ptr FontOptions00; other: ptr FontOptions00): Bool00 {.importc, libcairo.}
#
proc equal*(options: FontOptions; other: FontOptions): bool =
  cairo_font_options_equal(options.impl, other.impl).bool

proc cairo_font_options_hash*(options: ptr FontOptions00): culong {.importc, libcairo.}
#
proc hash*(options: FontOptions): int =
  cairo_font_options_hash(options.impl).int

proc cairo_font_options_set_antialias*(options: ptr FontOptions00; antialias: Antialias) {.importc, libcairo.}
#
proc setAntialias*(options: FontOptions; antialias: Antialias) =
  cairo_font_options_set_antialias(options.impl, antialias)
#
#const `antialias=`* = setAntialias

proc cairo_font_options_get_antialias*(options: ptr FontOptions00): Antialias {.importc, libcairo.}
#
proc getAntialias*(options: FontOptions): Antialias =
  cairo_font_options_get_antialias(options.impl)
#
#const antialias* = getAntialias

proc cairo_font_options_set_subpixel_order*(options: ptr FontOptions00; subpixelOrder: SubpixelOrder) {.importc, libcairo.}
#
proc setSubpixelOrder*(options: FontOptions; subpixelOrder: SubpixelOrder) =
  cairo_font_options_set_subpixel_order(options.impl, subpixelOrder)
#
#const `subpixelOrder=`* = setSubpixelOrder

proc cairo_font_options_get_subpixel_order*(options: ptr FontOptions00): SubpixelOrder {.importc, libcairo.}
#
proc getSubpixelOrder*(options: FontOptions): SubpixelOrder =
  cairo_font_options_get_subpixel_order(options.impl)
#
#const subpixelOrder* = getSubpixelOrder

proc cairo_font_options_set_hint_style*(options: ptr FontOptions00; hintStyle: HintStyle) {.importc, libcairo.}
#
proc setHintStyle*(options: FontOptions; hintStyle: HintStyle) =
  cairo_font_options_set_hint_style(options.impl, hintStyle)
#
#const  `hintStyle=`* = setHintStyle

proc cairo_font_options_get_hint_style*(options: ptr FontOptions00): HintStyle {.importc, libcairo.}
#
proc getHintStyle*(options: FontOptions): HintStyle =
  cairo_font_options_get_hint_style(options.impl)
#
#const hintStyle* = getHintStyle

proc cairo_font_options_set_hint_metrics*(options: ptr FontOptions00; hintMetrics: HintMetrics) {.importc, libcairo.}
#
proc setHintMetrics*(options: FontOptions; hintMetrics: HintMetrics) =
  cairo_font_options_set_hint_metrics(options.impl, hintMetrics)
#
#const `hintMetrics=`* = setHintMetrics

proc cairo_font_options_get_hint_metrics*(options: ptr FontOptions00): HintMetrics {.importc, libcairo.}
#
proc getHintMetrics*(options: FontOptions): HintMetrics =
  cairo_font_options_get_hint_metrics(options.impl)
#
#const hintMetrics* = getHintMetrics

proc cairo_select_font_face*(cr: ptr Context00; family: cstring; slant: FontSlant;
  weight: FontWeight) {.importc, libcairo.}
#
proc selectFontFace*(cr: Context; family: string; slant: FontSlant; weight: FontWeight) =
  cairo_select_font_face(cr.impl, family, slant, weight)

proc cairo_set_font_size*(cr: ptr Context00; size: cdouble) {.importc, libcairo.}
#
proc setFontSize*(cr: Context; size: float) =
  cairo_set_font_size(cr.impl, size.cdouble)

proc cairo_set_font_matrix*(cr: ptr Context00; matrix: Matrix) {.importc, libcairo.}
#
proc setFontMatrix*(cr: Context; matrix: Matrix) =
  cairo_set_font_matrix(cr.impl, matrix)
#
#const `fontMatrix=`* = setFontMatrix

proc cairo_get_font_matrix*(cr: ptr Context00; matrix: var Matrix) {.importc, libcairo.}
#
proc getFontMatrix*(cr: Context; matrix: var Matrix) =
  cairo_get_font_matrix(cr.impl, matrix)

proc cairo_set_font_options*(cr: ptr Context00; options: ptr FontOptions00) {.importc, libcairo.}
#
proc setFontOptions*(cr: Context; options: FontOptions) =
  cairo_set_font_options(cr.impl, options.impl)
#
#const `fontOptions=`* = setFontOptions

proc cairo_get_font_options*(cr: ptr Context00; options: ptr FontOptions00) {.importc, libcairo.}
#
proc getFontOptions*(cr: Context; options: var FontOptions) =
  ###new(options, gBoxedFreeCairoFontOptions)
  fnew(options, gBoxedFreeCairoFontOptions)
  options.impl = cairo_font_options_create()
  cairo_get_font_options(cr.impl, options.impl)

proc cairo_set_font_face*(cr: ptr Context00; fontFace: ptr FontFace00) {.importc, libcairo.}
#
proc setFontFace*(cr: Context; fontFace: FontFace) =
  GC_ref(fontFace)
  cairo_set_font_face(cr.impl, fontFace.impl)
#
#const `fontFace=` = setFontFace

proc cairo_font_face_destroy*(fontFace: ptr FontFace00) {.importc, libcairo.}
#
proc fontFaceDestroy(fontFace: FontFace) =
  cairo_font_face_destroy(fontFace.impl)

proc cairo_font_face_get_user_data*(fontFace: ptr FontFace00;
  key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(fontFace: FontFace; key: ptr UserDataKey): pointer =
  cairo_font_face_get_user_data(fontFace.impl, key)
#
#const userData* = getUserData

proc cairo_font_face_set_user_data*(fontFace: ptr FontFace00;
  key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(fontFace: FontFace; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_font_face_set_user_data(fontFace.impl, key, userData, destroy)

proc cairo_font_face_reference*(fontFace: ptr FontFace00): ptr FontFace00 {.importc, libcairo.}
#
proc fontFaceReference*(fontFace: FontFace): FontFace =
  discard cairo_font_face_reference(fontFace.impl)
  return fontFace

# FontFace00. This object is owned by cairo.
proc cairo_get_font_face*(cr: ptr Context00): ptr FontFace00 {.importc, libcairo.}
#
proc getFontFace*(cr: Context): FontFace =
  let h = cairo_get_font_face(cr.impl)
  if h.isNil: return nil
  let d = cairo_font_face_get_user_data(h, NUDK)
  if d.isNil:
    #assert false # may this happen?
    fnew(result, fontFaceDestroy)
    result.impl = h
    # TODO check
    discard cairo_font_face_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)
    discard cairo_font_face_reference(result.impl)
  else:
    result = cast[FontFace](d)
    assert(result.impl == h)
    #discard cairo_font_face_reference(result.impl) # should be not necessary?
  #
  #const fontFace* = getFontFace

proc cairo_set_scaled_font*(cr: ptr Context00; scaledFont: ptr ScaledFont00) {.importc, libcairo.}
#
proc setScaledFont*(cr: Context; scaledFont: ScaledFont) =
  GC_ref(scaledFont)
  cairo_set_scaled_font(cr.impl, scaledFont.impl)
#
#const `scaledFont=`* = setScaledFont

proc cairo_scaled_font_destroy*(scaled_font: ptr ScaledFont00) {.importc, libcairo.}
#
#proc scaledFontDestroy*(scaledFont: ScaledFont) =
#  cairo_scaled_font_destroy(scaledFont.impl)

proc cairo_scaled_font_get_user_data*(scaledFont: ptr ScaledFont00;
  key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(scaledFont: ScaledFont; key: ptr UserDataKey): pointer =
  cairo_scaled_font_get_user_data(scaledFont.impl, key)

proc cairo_scaled_font_set_user_data*(scaled_font: ptr Scaled_font00;
  key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(scaledFont: ScaledFont; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_scaled_font_set_user_data(scaledFont.impl, key, userData, destroy)

proc cairo_scaled_font_reference*(scaledFont: ptr ScaledFont00): ptr ScaledFont00 {.importc, libcairo.}
#
proc reference*(scaledFont: ScaledFont): ScaledFont =
  discard cairo_scaled_font_reference(scaledFont.impl)
  return scaledFont

# This object is owned by cairo.
proc cairo_get_scaled_font*(cr: ptr Context00): ptr ScaledFont00 {.importc, libcairo.}
#
proc getScaledFont*(cr: Context): ScaledFont =
  let h = cairo_get_scaled_font(cr.impl)
  if h.isNil: return nil
  let d = cairo_scaled_font_get_user_data(h, NUDK)
  if d.isNil:
    #assert false # may this happen?
    fnew(result, gBoxedFreeCairoScaledFont)
    result.impl = h
    discard cairo_scaled_font_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)
    discard cairo_scaled_font_reference(result.impl)
  else:
    result = cast[ScaledFont](d)
    assert(result.impl == h)
    #discard cairo_scaled_font_reference(result.impl) # should be not necessary?
  #
  #const scaledFont* = getScaledFont

proc cairo_show_text*(cr: ptr Context00; utf8: cstring) {.importc, libcairo.}
#
proc showText*(cr: Context; utf8: string) =
  cairo_show_text(cr.impl, utf8)

proc cairo_show_glyphs*(cr: ptr Context00; glyphs: ptr Glyph00; num_glyphs: cint) {.importc, libcairo.}
#
# TODO
#proc showGlyphs*(cr: Context; glyphs: Glyph00; num_glyphs: cint)
#proc cairo_show_glyphs*(cr: ptr Context00; glyphs: ptr Glyph00; num_glyphs: cint)

proc cairo_show_text_glyphs*(cr: ptr Context00; utf8: cstring; utf8_len: cint;
                         glyphs: ptr Glyph00; numGlyphs: cint;
                         clusters: ptr TextCluster00; numClusters: cint;
                         clusterFlags: TextClusterFlags) {.importc, libcairo.}

proc cairo_text_path*(cr: ptr Context00; utf8: cstring) {.importc, libcairo.}
#
proc textPath*(cr: Context; utf8: string) =
  cairo_text_path(cr.impl, utf8)

# TODO
proc cairo_glyph_path*(cr: ptr Context00; glyphs: ptr Glyph00; num_glyphs: cint) {.importc, libcairo.}
# TODO
proc cairo_text_extents*(cr: ptr Context00; utf8: cstring; extents: var TextExtents) {.importc, libcairo.}
#
proc textExtents*(cr: Context; utf8: string; extents: var TextExtents) =
  cairo_text_extents(cr.impl, utf8, extents)
#
const getTextExtents* = textExtents

# TODO
proc cairo_glyph_extents*(cr: ptr Context00; glyphs: ptr Glyph00; num_glyphs: cint;
                       extents: var TextExtents) {.importc, libcairo.}

proc cairo_font_extents*(cr: ptr Context00; extents: var FontExtents) {.importc, libcairo.}
#
proc fontExtents*(cr: Context; extents: var FontExtents) =
  cairo_font_extents(cr.impl, extents)
#
const getFontExtents* = fontExtents

proc cairo_font_face_get_reference_count*(font_face: ptr FontFace00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(fontFace: FontFace): int =
  cairo_font_face_get_reference_count(fontFace.impl).int

proc cairo_font_face_status*(font_face: ptr FontFace00): Status {.importc, libcairo.}
#
proc status*(fontFace: FontFace): Status =
  cairo_font_face_status(fontFace.impl)
#
#const getStatus* = status # does not compile

proc cairo_font_face_get_type*(fontFace: ptr FontFace00): FontType {.importc, libcairo.}
#
proc getType*(fontFace: FontFace): FontType =
  cairo_font_face_get_type(fontFace.impl)

proc cairo_scaled_font_create*(fontFace: ptr FontFace00;
  fontMatrix: Matrix; ctm: Matrix; options: ptr FontOptions00): ptr ScaledFont00 {.importc, libcairo.}
#
proc scaledFontCreate*(fontFace: FontFace; fontMatrix: Matrix; ctm: Matrix; options: FontOptions): ScaledFont =
  fnew(result, gBoxedFreeCairoScaledFont)
  GC_ref(fontFace)
  result.impl = cairo_scaled_font_create(fontFace.impl, fontMatrix, ctm, options.impl)
  discard cairo_scaled_font_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_scaled_font_get_reference_count*(scaledFont: ptr ScaledFont00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(scaledFont: ScaledFont): int =
  cairo_scaled_font_get_reference_count(scaledFont.impl).int
#
#const referenceCount* = getReferenceCount

proc cairo_scaled_font_status*(scaledFont: ptr ScaledFont00): Status {.importc, libcairo.}
#
proc status*(scaledFont: ScaledFont): Status =
  cairo_scaled_font_status(scaledFont.impl)
#
#const getStatus* = status

proc cairo_scaled_font_get_type*(scaledFont: ptr ScaledFont00): FontType {.importc, libcairo.}
#
proc getType*(scaledFont: ScaledFont): FontType =
  cairo_scaled_font_get_type(scaledFont.impl)

proc cairo_scaled_font_extents*(scaledFont: ptr ScaledFont00; extents: var FontExtents) {.importc, libcairo.}
#
proc extents*(scaledFont: ScaledFont; extents: var FontExtents) =
  cairo_scaled_font_extents(scaledFont.impl, extents)
#
#const getExtents* = extents # does not compile

proc cairo_scaled_font_text_extents*(scaledFont: ptr ScaledFont00; utf8: cstring;
  extents: var TextExtents) {.importc, libcairo.}
#
proc textExtents*(scaledFont: ScaledFont; utf8: string; extents: var TextExtents) =
  cairo_scaled_font_text_extents(scaledFont.impl, utf8, extents)
#
#const getTextExtents* = textExtents

#TODO
proc cairo_scaled_font_glyph_extents*(scaled_font: ptr Scaled_font00;
  glyphs: ptr Glyph00; numGlyphs: cint; extents: var TextExtents) {.importc, libcairo.}
#
#proc cairo_scaled_font_glyph_extents*(scaled_font: ptr Scaled_font00; glyphs: ptr Glyph00; numGlyphs: cint; extents: var TextExtents)
#proc cairo_scaled_font_glyph_extents*(scaled_font: ptr Scaled_font00; glyphs: ptr Glyph00; numGlyphs: cint; extents: var TextExtents)

#TODO
proc cairo_scaled_font_text_to_glyphs*(scaled_font: ptr Scaled_font00; x, y: cdouble;
  utf8: cstring; utf8Len: cint; glyphs: ptr ptr Glyph00; numGlyphs: var cint;
  clusters: ptr ptr TextCluster00; numClusters: var cint; clusterFlags: var TextClusterFlags): Status {.importc, libcairo.}

proc cairo_scaled_font_get_font_face*(scaled_font: ptr ScaledFont00): ptr FontFace00 {.importc, libcairo.}
#
proc getFontFace*(scaledFont: ScaledFont): FontFace =
  let h = cairo_scaled_font_get_font_face(scaledFont.impl)
  let d = cairo_font_face_get_user_data(h, NUDK)
  if d.isNil:
    assert false # may this happen?
    fnew(result, fontFaceDestroy)
    result.impl = h
  else:
    result = cast[FontFace](d)
    assert(result.impl == h)

proc cairo_scaled_font_get_font_matrix*(scaledFont: ptr ScaledFont00;
  fontMatrix: var Matrix) {.importc, libcairo.}
#
proc getFontMatrix*(scaledFont: ScaledFont; fontMatrix: var Matrix) =
  cairo_scaled_font_get_font_matrix(scaledFont.impl, fontMatrix)
#
#const fontMatrix* = getFontMatrix

proc cairo_scaled_font_get_ctm*(scaledFont: ptr ScaledFont00; ctm: var Matrix) {.importc, libcairo.}
#
proc getCtm*(scaledFont: ScaledFont; ctm: var Matrix) =
  cairo_scaled_font_get_ctm(scaledFont.impl, ctm)
#
#const ctm* = getCtm

proc cairo_scaled_font_get_scale_matrix*(scaledFont: ptr ScaledFont00;
  scaleMatrix: var Matrix) {.importc, libcairo.}
#
proc getScaleMatrix*(scaledFont: ScaledFont; scaleMatrix: var Matrix) =
  cairo_scaled_font_get_scale_matrix(scaledFont.impl, scaleMatrix)
#
#const scaleMatrix* = getScaleMatrix

# FontOptions00 is special -- there is no cairo_font_options_set_user_data() and no cairo_font_options_reference()
proc cairo_scaled_font_get_font_options*(scaledFont: ptr ScaledFont00;
  options: ptr FontOptions00) {.importc, libcairo.}
#
proc getFontOptions*(scaledFont: ScaledFont; options: var FontOptions) =
  fnew(options, gBoxedFreeCairoFontOptions)
  options.impl = cairo_font_options_create()
  cairo_scaled_font_get_font_options(scaledFont.impl, options.impl)
#
#const fontOptions* = getFontOptions

proc cairo_toy_font_face_create*(family: cstring; slant: FontSlant;
  weight: FontWeight): ptr FontFace00 {.importc, libcairo.}
#
proc toyFontFaceCreate*(family: string; slant: FontSlant; weight: FontWeight): FontFace =
  fnew(result, fontFaceDestroy)
  result.impl = cairo_toy_font_face_create(family, slant, weight)
  ### discard cairo_font_face_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

# returns: The family name. This string is owned by the font face and remains valid as long as the font face is alive (referenced).
proc cairo_toy_font_face_get_family*(fontFace: ptr Font_face00): cstring {.importc, libcairo.}
#
proc toyFontFaceGetFamily*(fontFace: FontFace): string =
  $cairo_toy_font_face_get_family(fontFace.impl)

proc cairo_toy_font_face_get_slant*(fontFace: ptr FontFace00): FontSlant {.importc, libcairo.}
#
proc toyFontFaceGetSlant*(fontFace: FontFace): FontSlant =
  cairo_toy_font_face_get_slant(fontFace.impl)

proc cairo_toy_font_face_get_weight*(fontFace: ptr FontFace00): FontWeight {.importc, libcairo.}
#
proc toyFontFaceGetWeight*(fontFace: FontFace): FontWeight =
  cairo_toy_font_face_get_weight(fontFace.impl)

proc cairo_user_font_face_create*(): ptr FontFace00 {.importc, libcairo.}
#
proc userFontFaceCreate*(): FontFace =
  fnew(result, fontFaceDestroy)
  result.impl = cairo_user_font_face_create()
  # there is no cairo_user_font_face_set_user_data()
  # discard cairo_font_face_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

type
  UserScaledFontInitFunc00* = proc (scaledFont: ptr ScaledFont00;
                                     cr: ptr Context00; extents: ptr FontExtents): Status {.cdecl.}

type
  UserScaledFontRenderGlyphFunc00* = proc (scaledFont: ptr ScaledFont00;
      glyph: culong; cr: ptr Context00; extents: ptr TextExtents): Status {.cdecl.}

type
  UserScaledFontTextToGlyphsFunc00* = proc (scaledFont: ptr ScaledFont00;
      utf8: cstring; utf8Len: cint; glyphs: ptr ptr Glyph00; numGlyphs: var cint;
      clusters: ptr ptr TextCluster00; numClusters: var cint;
      clusterFlags: var TextClusterFlags): Status {.cdecl.}

type
  UserScaledFontUnicodeToGlyphFunc00* = proc (scaledFont: ptr ScaledFont00;
      unicode: culong; glyphIndex: var culong): Status {.cdecl.}

proc cairo_user_font_face_set_init_func*(fontFace: ptr FontFace00;
  initFunc: UserScaledFontInitFunc00) {.importc, libcairo.}
#
proc userFontFaceSetInitFunc*(fontFace: FontFace; initFunc: UserScaledFontInitFunc00) =
  cairo_user_font_face_set_init_func(fontFace.impl, initFunc)

proc cairo_user_font_face_set_render_glyph_func*(fontFace: ptr FontFace00;
  renderGlyphFunc: UserScaledFontRenderGlyphFunc00) {.importc, libcairo.}
#
proc userFontFaceSetRenderGlyphFunc*(fontFace: FontFace; renderGlyphFunc: UserScaledFontRenderGlyphFunc00) =
  cairo_user_font_face_set_render_glyph_func(fontFace.impl, renderGlyphFunc)

proc cairo_user_font_face_set_text_to_glyphs_func*(fontFace: ptr FontFace00;
  textToGlyphsFunc: UserScaledFontTextToGlyphsFunc00) {.importc, libcairo.}
#
proc userFontFaceSetTextToGlyphsFunc*(fontFace: FontFace; textToGlyphsFunc: UserScaledFontTextToGlyphsFunc00) =
  cairo_user_font_face_set_text_to_glyphs_func(fontFace.impl, textToGlyphsFunc)

proc cairo_user_font_face_set_unicode_to_glyph_func*(fontFace: ptr FontFace00;
  unicodeToGlyphFunc: UserScaledFontUnicodeToGlyphFunc00) {.importc, libcairo.}
#
proc userFontFaceSetUnicodeToGlyphFunc*(fontFace: FontFace; unicodeToGlyphFunc: UserScaledFontUnicodeToGlyphFunc00) =
  cairo_user_font_face_set_unicode_to_glyph_func(fontFace.impl, unicodeToGlyphFunc)

proc cairo_user_font_face_get_init_func*(fontFace: ptr FontFace00):
  User_scaled_font_init_func00 {.importc, libcairo.}
#
proc userFontFaceGetInitFunc*(fontFace: FontFace): UserScaledFontInitFunc00 =
  cairo_user_font_face_get_init_func(fontFace.impl)

proc cairo_user_font_face_get_render_glyph_func*(fontFace: ptr FontFace00):
  User_scaled_font_render_glyph_func00 {.importc, libcairo.}
#
proc userFontFaceGetRenderGlyphFunc*(fontFace: FontFace): UserScaledFontRenderGlyphFunc00 =
  cairo_user_font_face_get_render_glyph_func(fontFace.impl)

proc cairo_user_font_face_get_text_to_glyphs_func*(fontFace: ptr FontFace00):
  User_scaled_font_text_to_glyphs_func00 {.importc, libcairo.}
#
proc userFontFaceGetTextToGlyphsFunc*(fontFace: FontFace): UserScaledFontTextToGlyphsFunc00 =
  cairo_user_font_face_get_text_to_glyphs_func(fontFace.impl)

proc cairo_user_font_face_get_unicode_to_glyph_func*(fontFace: ptr FontFace00):
  User_scaled_font_unicode_to_glyph_func00 {.importc, libcairo.}
#
proc userFontFaceGetUnicodeToGlyphFunc*(fontFace: FontFace): UserScaledFontUnicodeToGlyphFunc00 =
  cairo_user_font_face_get_unicode_to_glyph_func(fontFace.impl)

proc cairo_get_operator*(cr: ptr Context00): Operator {.importc, libcairo.}
#
proc getOperator*(cr: Context): Operator =
  cairo_get_operator(cr.impl)
#
#const operator* = getOperator

proc cairo_get_tolerance*(cr: ptr Context00): cdouble {.importc, libcairo.}
#
proc getTolerance*(cr: Context): float =
  cairo_get_tolerance(cr.impl).float
#
#const tolerance* = getTolerance

proc cairo_get_antialias*(cr: ptr Context00): Antialias {.importc, libcairo.}
#
proc getAntialias*(cr: Context): Antialias =
  cairo_get_antialias(cr.impl)
#
#const antialias* = getAntialias

proc cairo_has_current_point*(cr: ptr Context00): Bool00 {.importc, libcairo.}
#
proc hasCurrentPoint*(cr: Context): bool =
  cairo_has_current_point(cr.impl).bool

proc cairo_get_current_point*(cr: ptr Context00; x, y: var cdouble) {.importc, libcairo.}
#
proc getCurrentPoint*(cr: Context; x, y: var float) =
  var x0, y0: cdouble
  cairo_get_current_point(cr.impl, x0, y0)
  x = x0.float
  y = y0.float

proc cairo_get_fill_rule*(cr: ptr Context00): FillRule {.importc, libcairo.}
#
proc getFillRule*(cr: Context): FillRule =
  cairo_get_fill_rule(cr.impl)
#
#const fillRule* = getFillRule

proc cairo_get_line_width*(cr: ptr Context00): cdouble {.importc, libcairo.}
#
proc getLineWidth*(cr: Context): float =
  cairo_get_line_width(cr.impl).float
#
const lineWidth* = getLineWidth

proc cairo_get_line_cap*(cr: ptr Context00): LineCap {.importc, libcairo.}
#
proc getLineCap*(cr: Context): LineCap =
  cairo_get_line_cap(cr.impl)
#
const lineCap* = getLineCap

proc cairo_get_line_join*(cr: ptr Context00): LineJoin {.importc, libcairo.}
#
proc getLineJoin*(cr: Context): LineJoin =
  cairo_get_line_join(cr.impl)
#
const lineJoin* = getLineJoin

proc cairo_get_miter_limit*(cr: ptr Context00): cdouble {.importc, libcairo.}
#
proc getMiterLimit*(cr: Context): float =
  cairo_get_miter_limit(cr.impl).float
#
#const miterLimit* = getMiterLimit

proc cairo_get_dash_count*(cr: ptr Context00): cint {.importc, libcairo.}
#
proc getDashCount*(cr: Context): int =
  cairo_get_dash_count(cr.impl).int
#
#const dashCount* = getDashCount

# TODO
#proc cairo_get_dash*(cr: ptr Context00; dashes, offset: var cdouble) {.importc, libcairo.}

proc cairo_get_matrix*(cr: ptr Context00; matrix: var Matrix) {.importc, libcairo.}
#
proc getMatrix*(cr: Context; matrix: var Matrix) =
  cairo_get_matrix(cr.impl, matrix)
#
#const matrix* = getMatrix

proc cairo_surface_destroy*(surface: ptr Surface00) {.importc, libcairo.}
#
proc destroy*(surface: Surface) =
  if surface != nil and surface.impl != nil:
    cairo_surface_destroy(surface.impl)
    surface.impl = nil

proc cairo_surface_get_user_data*(surface: ptr Surface00; key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(surface: Surface; key: ptr UserDataKey): pointer =
  cairo_surface_get_user_data(surface.impl, key)

proc cairo_get_target*(cr: ptr Context00): ptr Surface00 {.importc, libcairo.}
#
proc getTarget*(cr: Context): Surface =
  let h = cairo_get_target(cr.impl)
  if h.isNil: return nil
  let d = cairo_surface_get_user_data(h, NUDK)
  if d.isNil:
    assert false # may this happen?
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = h
    discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)
    discard cairo_surface_reference(result.impl)
  else:
    result = cast[Surface](d)
    assert(result.impl == h)
    #discard cairo_surface_reference(result.impl) # should be not necessary?

proc cairo_get_group_target*(cr: ptr Context00): ptr Surface00 {.importc, libcairo.}
#
proc getGroupTarget*(cr: Context): Surface =
  let h = cairo_get_group_target(cr.impl)
  if h.isNil: return nil
  let d = cairo_surface_get_user_data(h, NUDK)
  if d.isNil:
    #assert false # may this happen?
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = h
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)
    ### discard cairo_surface_reference(result.impl)
  else:
    result = cast[Surface](d)
    assert(result.impl == h)
    #discard cairo_surface_reference(result.impl) # should be not necessary?

proc cairo_path_destroy*(path: ptr Path00) {.importc, libcairo.}
#
proc pathDestroy(path: Path) =
  cairo_path_destroy(path.impl)

# path is not ref counted, and there is no airo_path_set_user_data()
proc cairo_copy_path*(cr: ptr Context00): ptr Path00 {.importc, libcairo.}
#
proc copyPath*(cr: Context): Path =
  fnew(result, pathDestroy)
  result.impl = cairo_copy_path(cr.impl)
  #discard cairo_path_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_copy_path_flat*(cr: ptr Context00): ptr Path00 {.importc, libcairo.}
#
proc copyPathFlat*(cr: Context): Path =
  fnew(result, pathDestroy)
  result.impl = cairo_copy_path_flat(cr.impl)

proc cairo_append_path*(cr: ptr Context00; path: ptr Path00) {.importc, libcairo.}
#
proc appendPath*(cr: Context; path: Path) =
  cairo_append_path(cr.impl, path.impl)

proc cairo_status*(cr: ptr Context00): Status {.importc, libcairo.}
#
proc status*(cr: Context): Status =
  cairo_status(cr.impl)
#
#const getStatus* = status

proc cairo_status_to_string*(status: Status): cstring {.importc, libcairo.}
#
proc statusToString*(status: Status): string =
  $cairo_status_to_string(status)

proc cairo_device_reference*(device: ptr Device00): ptr Device00 {.importc, libcairo.}
#
proc devicReference*(device: Device): Device =
  discard cairo_device_reference(device.impl)
  return device

proc cairo_device_get_type*(device: ptr Device00): DeviceType {.importc, libcairo.}
#
proc getType*(device: Device): DeviceType =
  cairo_device_get_type(device.impl)

proc cairo_device_status*(device: ptr Device00): Status {.importc, libcairo.}
#
proc status*(device: Device): Status =
  cairo_device_status(device.impl)

proc cairo_device_acquire*(device: ptr Device00): Status {.importc, libcairo.}
#
proc acquire*(device: Device): Status =
  cairo_device_acquire(device.impl)

proc cairo_device_release*(device: ptr Device00) {.importc, libcairo.}
#
proc release*(device: Device) =
  cairo_device_release(device.impl)

proc cairo_device_flush*(device: ptr Device00) {.importc, libcairo.}
#
proc flush*(device: Device) =
  cairo_device_flush(device.impl)

proc cairo_device_finish*(device: ptr Device00) {.importc, libcairo.}
#
proc finish*(device: Device) =
  cairo_device_finish(device.impl)

proc cairo_device_destroy*(device: ptr Device00) {.importc, libcairo.}
#
proc deviceDestroy*(device: Device) =
  cairo_device_destroy(device.impl)

proc cairo_device_get_reference_count*(device: ptr Device00): cuint {.importc, libcairo.}
#
proc getReferenceCount*(device: Device): int =
  cairo_device_get_reference_count(device.impl).int

proc cairo_device_get_user_data*(device: ptr Device00; key: ptr UserDataKey): pointer {.importc, libcairo.}
#
proc getUserData*(device: Device; key: ptr UserDataKey): pointer =
  cairo_device_get_user_data(device.impl, key)

proc cairo_device_set_user_data*(device: ptr Device00; key: ptr UserDataKey;
  userData: pointer; destroy: DestroyFunc00): Status {.importc, libcairo.}
#
proc setUserData*(device: Device; key: ptr UserDataKey; userData: pointer; destroy: DestroyFunc00): Status =
  cairo_device_set_user_data(device.impl, key, userData, destroy)

# TODO: problem is, that it may take too long until GC may release surfaces!
proc cairo_surface_create_similar*(other: ptr Surface00; content: Content; width, height: cint):
  ptr Surface00 {.importc, libcairo.}

proc createSimilar*(other: Surface; content: Content; width, height: int): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_surface_create_similar(other.impl, content, width.cint, height.cint)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_surface_create_similar_image*(other: ptr Surface00; format: Format; width, height: cint):
  ptr Surface00 {.importc, libcairo.}
#
proc createSimilarImage*(other: Surface; format: Format; width, height: int): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_surface_create_similar_image(other.impl, format, width.cint, height.cint)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_surface_unmap_image*(surface: ptr Surface00; image: ptr Surface00) {.importc, libcairo.}
#
proc unmapImage*(surface: Surface; image: Surface) =
  cairo_surface_unmap_image(surface.impl, image.impl)

proc cairo_surface_map_to_image*(surface: ptr Surface00; extents: RectangleInt): ptr Surface00 {.importc, libcairo.}
#
proc mapToImage*(surface: Surface; extents: RectangleInt): Surface =
  #new(result, destroy) # no idea currently
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_surface_map_to_image(surface.impl, extents)

proc cairo_surface_create_for_rectangle*(target: ptr Surface00; x, y, width, height: cdouble):
  ptr Surface00 {.importc, libcairo.}
#
proc surfaceCreateForRectangle*(target: Surface; x, y, width, height: float): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_surface_create_for_rectangle(target.impl, x.cdouble, y.cdouble, width.cdouble, height.cdouble)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

type
  SurfaceObserverMode* {.size: sizeof(cint), pure.} = enum
    normal = 0,
    recordOperations = 0x1

proc cairo_surface_create_observer*(target: ptr Surface00;
  mode: SurfaceObserverMode): ptr Surface00 {.importc, libcairo.}
#
proc createObserver*(target: Surface; mode: SurfaceObserverMode): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_surface_create_observer(target.impl, mode)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

type
  SurfaceObserverCallback00* = proc (observer: ptr Surface00;
                                      target: ptr Surface00; data: pointer) {.cdecl.}

# TODO: no high level procs for observers now -- we have to think about, and see if someone intents to use it
proc cairo_surface_observer_add_paint_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_mask_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_fill_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_stroke_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_glyphs_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_flush_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_add_finish_callback*(abstract_surface: ptr Surface00;
  `func`: SurfaceObserverCallback00; data: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_print*(surface: ptr Surface00;
  writeFunc: WriteFunc00; closure: pointer): Status {.importc, libcairo.}
proc cairo_surface_observer_elapsed*(surface: ptr Surface00): cdouble {.importc, libcairo.}
proc cairo_device_observer_print*(device: ptr Device00; write_func: Write_func00;
  closure: pointer): Status {.importc, libcairo.}
proc cairo_device_observer_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}
proc cairo_device_observer_paint_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}
proc cairo_device_observer_mask_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}
proc cairo_device_observer_fill_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}
proc cairo_device_observer_stroke_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}
proc cairo_device_observer_glyphs_elapsed*(device: ptr Device00): cdouble {.importc, libcairo.}

proc cairo_surface_finish*(surface: ptr Surface00) {.importc, libcairo.}
#
proc finish*(surface: Surface) =
  cairo_surface_finish(surface.impl)

proc cairo_surface_get_device*(surface: ptr Surface00): ptr Device00 {.importc, libcairo.}
#
proc getDevice*(surface: Surface): Device =
  let h = cairo_surface_get_device(surface.impl)
  if h.isNil: return nil
  let d = cairo_device_get_user_data(h, NUDK)
  if d.isNil:
    assert false # may this happen?
    fnew(result, deviceDestroy)
    result.impl = h
    discard cairo_device_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)
    discard cairo_device_reference(result.impl)
  else:
    result = cast[Device](d)
    assert(result.impl == h)
    #discard cairo_device_reference(result.impl) # should be not necessary?

proc cairo_surface_status*(surface: ptr Surface00): Status {.importc, libcairo.}
#
proc status*(surface: Surface): Status =
  cairo_surface_status(surface.impl)
#
#const getStatus* = status

proc cairo_surface_get_type*(surface: ptr Surface00): SurfaceType {.importc, libcairo.}
#
proc getType*(surface: Surface): SurfaceType =
  cairo_surface_get_type(surface.impl)

proc cairo_surface_get_content*(surface: ptr Surface00): Content {.importc, libcairo.}
#
proc getContent*(surface: Surface): Content =
  cairo_surface_get_content(surface.impl)
#
#const content* = getContent

when CAIRO_HAS_PNG_FUNCTIONS:
  proc cairo_surface_write_to_png*(surface: ptr Surface00; filename: cstring): Status {.importc, libcairo.}
#
  proc writeToPng*(surface: Surface; filename: string): Status =
    cairo_surface_write_to_png(surface.impl, filename)

  proc cairo_surface_write_to_png_stream*(surface: ptr Surface00;
    writeFunc: WriteFunc00; closure: pointer): Status {.importc, libcairo.}
#
  proc writeToPngStream*(surface: Surface; writeFunc: WriteFunc00; closure: pointer): Status =
    cairo_surface_write_to_png_stream(surface.impl, writeFunc, closure)

const
  MIME_TYPE_JPEG* = "image/jpeg"
  MIME_TYPE_PNG* = "image/png"
  MIME_TYPE_JP2* = "image/jp2"
  MIME_TYPE_URI* = "text/x-uri"
  MIME_TYPE_UNIQUE_ID* = "application/x-cairo.uuid"
  MIME_TYPE_JBIG2* = "application/x-cairo.jbig2"
  MIME_TYPE_JBIG2_GLOBAL* = "application/x-cairo.jbig2-global"
  MIME_TYPE_JBIG2_GLOBAL_ID* = "application/x-cairo.jbig2-global-id"

proc cairo_surface_get_mime_data*(surface: ptr Surface00; mime_type: cstring;
  data: var ptr cuchar; length: var culong) {.importc, libcairo.}
#
proc getMimeData*(surface: Surface; mimeType: string; data: var seq[int8]) =
  var p: ptr cuchar
  var l: culong
  cairo_surface_get_mime_data(surface.impl, mimeType, p, l)
  data = newSeq[int8](l.int)
  copyMem(addr data[0], p, l.int)
  #for i in 0 .. data.high:
  #  data[i] = cast[ptr array[99, int8]](p)[i] # wrong

proc cairo_surface_set_mime_data*(surface: ptr Surface00; mime_type: cstring;
  data: ptr cuchar; length: culong; destroy: DestroyFunc00; closure: pointer): Status {.importc, libcairo.}
#
proc setMimeData*(surface: Surface; mimeType: string; data: openArray[int8]; destroy: DestroyFunc00; closure: pointer): Status =
  cairo_surface_set_mime_data(surface.impl, mimeType, cast[ptr cuchar](unsafeaddr data[0]), data.len.culong, destroy, closure)

proc cairo_surface_supports_mime_type*(surface: ptr Surface00; mime_type: cstring): Bool00 {.importc, libcairo.}
#
proc supportsMimeType*(surface: Surface; mimeType: string): bool =
  cairo_surface_supports_mime_type(surface.impl, mimeType).bool

proc cairo_surface_get_font_options*(surface: ptr Surface00; options: ptr FontOptions00) {.importc, libcairo.}

proc getFontOptions*(surface: Surface; options: var FontOptions) =
  fnew(options, gBoxedFreeCairoFontOptions)
  options.impl = cairo_font_options_create()
  cairo_surface_get_font_options(surface.impl, options.impl)

proc cairo_surface_flush*(surface: ptr Surface00) {.importc, libcairo.}
#
proc flush*(surface: Surface) =
  cairo_surface_flush(surface.impl)

proc cairo_surface_mark_dirty*(surface: ptr Surface00) {.importc, libcairo.}
#
proc markDirty*(surface: Surface) =
  cairo_surface_mark_dirty(surface.impl)

proc cairo_surface_mark_dirty_rectangle*(surface: ptr Surface00; x, y, width, height: cint) {.importc, libcairo.}
#
proc markDirtyRectangle*(surface: Surface; x, y, width, height: int) =
  cairo_surface_mark_dirty_rectangle(surface.impl, x.cint, y.cint, width.cint, height.cint)

proc cairo_surface_set_device_scale*(surface: ptr Surface00; xScale, yScale: cdouble) {.importc, libcairo.}
#
proc setDeviceScale*(surface: Surface; xScale, yScale: float) =
  cairo_surface_set_device_scale(surface.impl, xScale.cdouble, yScale.cdouble)

proc cairo_surface_get_device_scale*(surface: ptr Surface00; xScale, yScale: var cdouble) {.importc, libcairo.}
#
proc getDeviceScale*(surface: Surface; xScale, yScale: var float) =
  var x, y: cdouble
  cairo_surface_get_device_scale(surface.impl, x, y)
  xScale = x.float
  yScale = y.float

proc cairo_surface_set_device_offset*(surface: ptr Surface00; xOffset, yOffset: cdouble) {.importc, libcairo.}
#
proc setDeviceOffset*(surface: Surface; xOffset, yOffset: float) =
  cairo_surface_set_device_offset(surface.impl, xOffset.cdouble, yOffset.cdouble)

proc cairo_surface_get_device_offset*(surface: ptr Surface00; xOffset, yOffset: var cdouble) {.importc, libcairo.}
#
proc getDeviceOffset*(surface: Surface; xOffset, yOffset: var float) =
  var x, y: cdouble
  cairo_surface_get_device_offset(surface.impl, x, y)
  xOffset = x.float
  yOffset = y.float

proc cairo_surface_set_fallback_resolution*(surface: ptr Surface00; xPixelsPerInch, yPixelsPerInch: cdouble) {.importc, libcairo.}
#
proc setFallbackResolution*(surface: Surface; xPixelsPerInch, yPixelsPerInch: float) =
  cairo_surface_set_fallback_resolution(surface.impl, xPixelsPerInch.cdouble, yPixelsPerInch.cdouble)

proc cairo_surface_get_fallback_resolution*(surface: ptr Surface00; xPixelsPerInch, yPixelsPerInch: var cdouble) {.
  importc, libcairo.}
#
proc getFallbackResolution*(surface: Surface; xPixelsPerInch, yPixelsPerInch: var float) =
  var x, y: cdouble
  cairo_surface_get_fallback_resolution(surface.impl, x, y)
  xPixelsPerInch = x.float
  yPixelsPerInch = y.float

proc cairo_surface_copy_page*(surface: ptr Surface00) {.importc, libcairo.}
#
proc copyPage*(surface: Surface) =
  cairo_surface_copy_page(surface.impl)

proc cairo_surface_show_page*(surface: ptr Surface00) {.importc, libcairo.}
#
proc showPage*(surface: Surface) =
  cairo_surface_show_page(surface.impl)

proc cairo_surface_has_show_text_glyphs*(surface: ptr Surface00): Bool00 {.importc, libcairo.}
#
proc hasShowTextGlyphs*(surface: Surface): bool =
  cairo_surface_has_show_text_glyphs(surface.impl).bool

proc cairo_image_surface_create*(format: Format; width, height: cint): ptr Surface00 {.importc, libcairo.}
#
proc imageSurfaceCreate*(format: Format; width, height: int): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_image_surface_create(format, width.cint, height.cint)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_format_stride_for_width*(format: Format; width: cint): cint {.importc, libcairo.}
#
proc strideForWidth*(format: Format; width: int): int =
  cairo_format_stride_for_width(format, width.cint).int

# TODO: no high level support for now
proc cairo_image_surface_create_for_data*(data: ptr cuchar; format: Format; width, height, stride: cint):
  ptr Surface00 {.importc, libcairo.}

proc cairo_image_surface_get_data*(surface: ptr Surface00): ptr cuchar {.importc, libcairo.}

proc cairo_image_surface_get_format*(surface: ptr Surface00): Format {.importc, libcairo.}
#
proc imageSurfaceGetFormat*(surface: Surface): Format =
  cairo_image_surface_get_format(surface.impl)

proc cairo_image_surface_get_width*(surface: ptr Surface00): cint {.importc, libcairo.}
#
proc imageSurfaceGetWidth*(surface: Surface): int =
  cairo_image_surface_get_width(surface.impl).int

proc cairo_image_surface_get_height*(surface: ptr Surface00): cint {.importc, libcairo.}
#
proc imageSurfaceGetHeight*(surface: Surface): int =
  cairo_image_surface_get_height(surface.impl).int

proc cairo_image_surface_get_stride*(surface: ptr Surface00): cint {.importc, libcairo.}
#
proc imageSurfaceGetStride*(surface: Surface): int =
  cairo_image_surface_get_stride(surface.impl).int

when CAIRO_HAS_PNG_FUNCTIONS:
  proc cairo_image_surface_create_from_png*(filename: cstring): ptr Surface00 {.importc, libcairo.}

  proc imageSurfaceCreateFromPng*(filename: string): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_image_surface_create_from_png(filename)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_image_surface_create_from_png_stream*(read_func: Read_func00;
    closure: pointer): ptr Surface00 {.importc, libcairo.}
#
  proc imageSurfaceCreateFromPngStream*(readFunc: ReadFunc00; closure: pointer): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_image_surface_create_from_png_stream(readFunc, closure)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_recording_surface_create*(content: Content; extents: Rectangle): ptr Surface00 {.importc, libcairo.}
#
proc recordingSurfaceCreate*(content: Content; extents: Rectangle): Surface =
  fnew(result, gBoxedFreeCairoSurface)
  result.impl = cairo_recording_surface_create(content, extents)
  ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_recording_surface_ink_extents*(surface: ptr Surface00; x0, y0, width, height: var cdouble) {.importc, libcairo.}
#
proc recordingSurfaceInkExtents*(surface: Surface; x0, y0, width, height: var float) =
  var x00, y00, width0, height0: cdouble
  cairo_recording_surface_ink_extents(surface.impl, x00, y00, width0, height0)
  x0 = x00.float
  y0 = y00.float
  width = width0.float
  height = height0.float

proc cairo_recording_surface_get_extents*(surface: ptr Surface00; extents: Rectangle): Bool00 {.importc, libcairo.}
#
proc recordingSurfaceGetExtents*(surface: Surface; extents: Rectangle): bool =
  cairo_recording_surface_get_extents(surface.impl, extents).bool

type
  RasterSourceAcquireFunc00* = proc (pattern: ptr Pattern00;
                                      callbackData: pointer;
                                      target: ptr Surface00;
                                      extents: ptr RectangleInt): ptr Surface00 {.cdecl.}

type
  RasterSourceReleaseFunc00* = proc (pattern: ptr Pattern00;
                                      callbackData: pointer;
                                      surface: ptr Surface00) {.cdecl.}

type
  RasterSourceSnapshotFunc00* = proc (pattern: ptr Pattern00;
                                       callbackData: pointer): Status {.cdecl.}

type
  RasterSourceCopyFunc00* = proc (pattern: ptr Pattern00;
                                   callbackData: pointer; other: ptr Pattern00): Status {.cdecl.}

type
  RasterSourceFinishFunc00* = proc (pattern: ptr Pattern00;
                                     callbackData: pointer) {.cdecl.}

proc cairo_pattern_create_raster_source*(userData: pointer; content: Content; width, height: cint):
  ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateRasterSource*(userData: pointer; content: Content; width, height: int): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_raster_source(userData, content, width.cint, height.cint)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_raster_source_pattern_set_callback_data*(pattern: ptr Pattern00; data: pointer) {.importc, libcairo.}
#
proc rasterSourcePatternSetCallbackData*(pattern: Pattern; data: pointer) =
  cairo_raster_source_pattern_set_callback_data(pattern.impl, data)

proc cairo_raster_source_pattern_get_callback_data*(pattern: ptr Pattern00): pointer {.importc, libcairo.}
#
proc rasterSourcePatternGetCallbackData*(pattern: Pattern): pointer =
  cairo_raster_source_pattern_get_callback_data(pattern.impl)

proc cairo_raster_source_pattern_set_acquire*(pattern: ptr Pattern00;
  acquire: RasterSourceAcquireFunc00; release: RasterSourceReleaseFunc00) {.importc, libcairo.}
#
proc rasterSourcePatternSetAcquire*(pattern: Pattern; acquire: RasterSourceAcquireFunc00; release: RasterSourceReleaseFunc00) =
  cairo_raster_source_pattern_set_acquire(pattern.impl, acquire, release)

proc cairo_raster_source_pattern_get_acquire*(pattern: ptr Pattern00; acquire: ptr Raster_source_acquire_func00;
    release: ptr RasterSourceReleaseFunc00) {.importc, libcairo.}
#
proc rasterSourcePatternGetAcquire*(pattern: Pattern; acquire: ptr Raster_source_acquire_func00; release: ptr RasterSourceReleaseFunc00) =
  cairo_raster_source_pattern_get_acquire(pattern.impl, acquire, release)

proc cairo_raster_source_pattern_set_snapshot*(pattern: ptr Pattern00; snapshot: RasterSourceSnapshotFunc00) {.importc, libcairo.}
#
proc rasterSourcePatternSetSnapshot*(pattern: Pattern; snapshot: RasterSourceSnapshotFunc00) =
  cairo_raster_source_pattern_set_snapshot(pattern.impl, snapshot)

proc cairo_raster_source_pattern_get_snapshot*(pattern: ptr Pattern00): Raster_source_snapshot_func00 {.importc, libcairo.}
#
proc rasterSourcePatternGetSnapshot*(pattern: Pattern): RasterSourceSnapshotFunc00 =
  cairo_raster_source_pattern_get_snapshot(pattern.impl)

proc cairo_raster_source_pattern_set_copy*(pattern: ptr Pattern00; copy: RasterSourceCopyFunc00) {.importc, libcairo.}
#
proc rasterSourcePatternSetCopy*(pattern: Pattern; copy: RasterSourceCopyFunc00) =
  cairo_raster_source_pattern_set_copy(pattern.impl, copy)

proc cairo_raster_source_pattern_get_copy*(pattern: ptr Pattern00): Raster_source_copy_func00 {.importc, libcairo.}
#
proc rasterSourcePatternGetCopy*(pattern: Pattern): RasterSourceCopyFunc00 =
  cairo_raster_source_pattern_get_copy(pattern.impl)

proc cairo_raster_source_pattern_set_finish*(pattern: ptr Pattern00; finish: RasterSourceFinishFunc00) {.importc, libcairo.}
#
proc raster_source_pattern_set_finish*(pattern: Pattern; finish: RasterSourceFinishFunc00) =
  cairo_raster_source_pattern_set_finish(pattern.impl, finish)

proc cairo_raster_source_pattern_get_finish*(pattern: ptr Pattern00): RasterSourceFinishFunc00 {.importc, libcairo.}
#
proc rasterSourcePatternGetFinish*(pattern: Pattern): RasterSourceFinishFunc00 =
  cairo_raster_source_pattern_get_finish(pattern.impl)

proc cairo_pattern_create_rgb*(red, green, blue: cdouble): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateRgb*(red, green, blue: float): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_rgb(red.cdouble, green.cdouble, blue.cdouble)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_create_rgba*(red, green, blue, alpha: cdouble): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateRgba*(red, green, blue, alpha: float): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_rgba(red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_create_for_surface*(surface: ptr Surface00): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateForSurface*(surface: Surface): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_for_surface(surface.impl)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_create_linear*(x0, y0, x1, y1: cdouble): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateLinear*(x0, y0, x1, y1: float): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_linear(x0.cdouble, y0.cdouble, x1.cdouble, y1.cdouble)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_create_radial*(cx0, cy0, radius0, cx1, cy1, radius1: cdouble): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateRadial*(cx0, cy0, radius0, cx1, cy1, radius1: float): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_radial(cx0.cdouble, cy0.cdouble, radius0.cdouble, cx1.cdouble, cy1.cdouble, radius1.cdouble)
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_create_mesh*(): ptr Pattern00 {.importc, libcairo.}
#
proc patternCreateMesh*(): Pattern =
  fnew(result, gBoxedFreeCairoPattern)
  result.impl = cairo_pattern_create_mesh()
  ### discard cairo_pattern_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_pattern_status*(pattern: ptr Pattern00): Status {.importc, libcairo.}
#
proc status*(pattern: Pattern): Status =
  cairo_pattern_status(pattern.impl)

proc cairo_pattern_get_type*(pattern: ptr Pattern00): PatternType {.importc, libcairo.}
#
proc getType*(pattern: Pattern): PatternType =
  cairo_pattern_get_type(pattern.impl)

proc cairo_pattern_add_color_stop_rgb*(pattern: ptr Pattern00; offset, red, green, blue: cdouble) {.importc, libcairo.}
#
proc addColorStopRgb*(pattern: Pattern; offset, red, green, blue: float) =
  cairo_pattern_add_color_stop_rgb(pattern.impl, offset.cdouble, red.cdouble, green.cdouble, blue.cdouble)

proc cairo_pattern_add_color_stop_rgba*(pattern: ptr Pattern00; offset, red, green, blue, alpha: cdouble) {.importc, libcairo.}
#
proc addColorStopRgba*(pattern: Pattern; offset, red, green, blue, alpha: float) =
  cairo_pattern_add_color_stop_rgba(pattern.impl, offset.cdouble, red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)

proc cairo_mesh_pattern_begin_patch*(pattern: ptr Pattern00) {.importc, libcairo.}
#
proc meshPatternBeginPatch*(pattern: Pattern) =
  cairo_mesh_pattern_begin_patch(pattern.impl)

proc cairo_mesh_pattern_end_patch*(pattern: ptr Pattern00) {.importc, libcairo.}
#
proc meshPatternEndPatch*(pattern: Pattern) =
  cairo_mesh_pattern_end_patch(pattern.impl)

proc cairo_mesh_pattern_curve_to*(pattern: ptr Pattern00; x1, y1, x2, y2, x3, y3: cdouble) {.importc, libcairo.}
#
proc meshPatternCurveTo*(pattern: Pattern; x1, y1, x2, y2, x3, y3: float) =
  cairo_mesh_pattern_curve_to(pattern.impl, x1.cdouble, y1.cdouble, x2.cdouble, y2.cdouble, x3.cdouble, y3.cdouble)

proc cairo_mesh_pattern_line_to*(pattern: ptr Pattern00; x, y: cdouble) {.importc, libcairo.}
#
proc meshPatternLineTo*(pattern: Pattern; x, y: float) =
  cairo_mesh_pattern_line_to(pattern.impl, x.cdouble, y.cdouble)

proc cairo_mesh_pattern_move_to*(pattern: ptr Pattern00; x, y: cdouble) {.importc, libcairo.}
#
proc meshPatternMoveTo*(pattern: Pattern; x, y: float) =
  cairo_mesh_pattern_move_to(pattern.impl, x.cdouble, y.cdouble)

proc cairo_mesh_pattern_set_control_point*(pattern: ptr Pattern00; pointNum: cuint; x, y: cdouble) {.importc, libcairo.}
#
proc meshPatternSetControlPoint*(pattern: Pattern; pointNum: int; x, y: float) =
  cairo_mesh_pattern_set_control_point(pattern.impl, pointNum.cuint, x.cdouble, y.cdouble)

proc cairo_mesh_pattern_set_corner_color_rgb*(pattern: ptr Pattern00; cornerNum: cuint; red, green, blue: cdouble) {.
  importc, libcairo.}
#
proc meshPatternSetCornerColorRgb*(pattern: Pattern; cornerNum: int; red, green, blue: float) =
  cairo_mesh_pattern_set_corner_color_rgb(pattern.impl, cornerNum.cuint, red.cdouble, green.cdouble, blue.cdouble)

proc cairo_mesh_pattern_set_corner_color_rgba*(pattern: ptr Pattern00; cornerNum: cuint; red, green, blue, alpha: cdouble) {.
  importc, libcairo.}
#
proc mesh_pattern_set_corner_color_rgba*(pattern: Pattern; cornerNum: int; red, green, blue, alpha: float) =
  cairo_mesh_pattern_set_corner_color_rgba(pattern.impl, cornerNum.cuint, red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)

proc cairo_pattern_set_matrix*(pattern: ptr Pattern00; matrix: Matrix) {.importc, libcairo.}
#
proc patternSetMatrix*(pattern: Pattern; matrix: Matrix) =
  cairo_pattern_set_matrix(pattern.impl, matrix)

proc cairo_pattern_get_matrix*(pattern: ptr Pattern00; matrix: var Matrix) {.importc, libcairo.}
#
proc patternGetMatrix*(pattern: Pattern; matrix: var Matrix) =
  cairo_pattern_get_matrix(pattern.impl, matrix)

proc cairo_pattern_set_extend*(pattern: ptr Pattern00; extend: Extend) {.importc, libcairo.}
#
proc setExtend*(pattern: Pattern; extend: Extend) =
  cairo_pattern_set_extend(pattern.impl, extend)
#
#const `extend=`* = setExtend

proc cairo_pattern_get_extend*(pattern: ptr Pattern00): Extend {.importc, libcairo.}
#
proc getExtend*(pattern: Pattern): Extend =
  cairo_pattern_get_extend(pattern.impl)

proc cairo_pattern_set_filter*(pattern: ptr Pattern00; filter: Filter) {.importc, libcairo.}
#
proc setFilter*(pattern: Pattern; filter: Filter) =
  cairo_pattern_set_filter(pattern.impl, filter)
#
#const `filter=`* = setFilter

proc cairo_pattern_get_filter*(pattern: ptr Pattern00): Filter {.importc, libcairo.}
#
proc getFilter*(pattern: Pattern): Filter =
  cairo_pattern_get_filter(pattern.impl)

proc cairo_pattern_get_rgba*(pattern: ptr Pattern00; red, green, blue, alpha: var cdouble): Status {.importc, libcairo.}
#
proc getRgba*(pattern: Pattern; red, green, blue, alpha: var float): Status =
  var red0, green0, blue0, alpha0: cdouble
  result = cairo_pattern_get_rgba(pattern.impl, red0, green0, blue0, alpha0)
  red = red0.float
  green = green0.float
  blue = blue0.float
  alpha = alpha0.float

# TODO this seems to be wrong
proc cairo_pattern_get_surface*(pattern: ptr Pattern00; surface: var ptr Surface00): Status {.importc, libcairo.}
#
proc getSurface*(pattern: Pattern; surface: var Surface): Status =
  var h: ptr Surface00
  let s = cairo_pattern_get_surface(pattern.impl, h)
  if s != Status.success: return s
  let d = cairo_surface_get_user_data(h, NUDK)
  if d.isNil:
    assert false # may this happen?
    fnew(surface, gBoxedFreeCairoSurface)
    surface.impl = h
    discard cairo_surface_set_user_data(surface.impl, NUDK, cast[pointer](surface), gcuref)
    discard cairo_surface_reference(surface.impl)
  else:
    surface = cast[Surface](d)
    assert(surface.impl == h)
    #discard cairo_surface_reference(result.impl) # should be not necessary?

proc cairo_pattern_get_color_stop_rgba*(pattern: ptr Pattern00; index: cint; offset, red, green, blue, alpha: var cdouble):
  Status {.importc, libcairo.}
#
proc getColorStopRgba*(pattern: Pattern; index: int; offset, red, green, blue, alpha: var float): Status =
  var offset0, red0, green0, blue0, alpha0: cdouble
  result = cairo_pattern_get_color_stop_rgba(pattern.impl, index.cint, offset0, red0, green0, blue0, alpha0)
  offset = offset0
  red = red0
  green = green0
  blue = blue0
  alpha = alpha0

proc cairo_pattern_get_color_stop_count*(pattern: ptr Pattern00; count: var cint): Status {.importc, libcairo.}
#
proc getColorStopCount*(pattern: Pattern; count: var int): Status =
  var c: cint
  result = cairo_pattern_get_color_stop_count(pattern.impl, c)
  count = c.int

proc cairo_pattern_get_linear_points*(pattern: ptr Pattern00; x0, y0, x1, y1: var cdouble): Status {.importc, libcairo.}
#
proc getLinearPoints*(pattern: Pattern; x0, y0, x1, y1: var float): Status =
  var x00, y00, x10, y10: cdouble
  result = cairo_pattern_get_linear_points(pattern.impl, x00, y00, x10, y10)
  x0 = x00
  y0 = y00
  x1 = x10
  y1 = y10

proc cairo_pattern_get_radial_circles*(pattern: ptr Pattern00; x0, y0, r0, x1, y1, r1: var cdouble): Status {.importc, libcairo.}
#
proc getRadialCircles*(pattern: Pattern; x0, y0, r0, x1, y1, r1: var float): Status =
  var x00, y00, r00, x10, y10, r10: cdouble
  result = cairo_pattern_get_radial_circles(pattern.impl, x00, y00, r00, x10, y10, r10)
  x0 = x00
  y0 = y00
  x1 = x10
  y1 = y10
  r0 = r00
  r1 = r10

proc cairo_mesh_pattern_get_patch_count*(pattern: ptr Pattern00; count: var cuint): Status {.importc, libcairo.}
#
proc meshPatternGetPatchCount*(pattern: Pattern; count: var int): Status =
  var c: cuint
  result = cairo_mesh_pattern_get_patch_count(pattern.impl, c)
  count = c.int

proc cairo_mesh_pattern_get_path*(pattern: ptr Pattern00; patchNum: cuint): ptr Path00 {.importc, libcairo.}
#
proc meshPatternGetPath*(pattern: Pattern; patchNum: int): Path =
  fnew(result, pathDestroy)
  result.impl = cairo_mesh_pattern_get_path(pattern.impl, patchNum.cuint)

proc cairo_mesh_pattern_get_corner_color_rgba*(pattern: ptr Pattern00; patchNum, cornerNum: cuint;
  red, green, blue, alpha: var cdouble): Status {.importc, libcairo.}
#
proc meshPatternGetCornerColorRgba*(pattern: Pattern; patchNum, cornerNum: int; red, green, blue, alpha: var float): Status =
  cairo_mesh_pattern_get_corner_color_rgba(pattern.impl, patchNum.cuint, cornerNum.cuint, red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)

proc cairo_mesh_pattern_get_control_point*(pattern: ptr Pattern00; patchNum, pointNum: cuint; x, y: var cdouble):
  Status {.importc, libcairo.}
#
proc meshPatternGetControlPoint*(pattern: Pattern; patchNum, pointNum: int; x, y: var float): Status =
  var x0, y0: cdouble
  result = cairo_mesh_pattern_get_control_point(pattern.impl, patchNum.cuint, pointNum.cuint, x0, y0)
  x = x0
  y = y0

proc cairo_matrix_init*(matrix: var Matrix; xx, yx, xy, yy, x0, y0: cdouble) {.importc, libcairo.}
#
proc matrixInit*(matrix: var Matrix; xx, yx, xy, yy, x0, y0: float) =
  cairo_matrix_init(matrix, xx.cdouble, yx.cdouble, xy.cdouble, yy.cdouble, x0.cdouble, y0.cdouble)

proc cairo_matrix_init_identity*(matrix: var Matrix) {.importc, libcairo.}
#
const initIdentity* = cairo_matrix_init_identity

proc cairo_matrix_init_translate*(matrix: var Matrix; tx, ty: cdouble) {.importc, libcairo.}
#
proc initTranslate*(matrix: var Matrix; tx, ty: float) =
  cairo_matrix_init_translate(matrix, tx.cdouble, ty.cdouble)

proc cairo_matrix_init_scale*(matrix: var Matrix; sx, sy: cdouble) {.importc, libcairo.}
#
proc initScale*(matrix: var Matrix; sx, sy: float) =
  cairo_matrix_init_scale(matrix, sx.cdouble, sy.cdouble)

proc cairo_matrix_init_rotate*(matrix: var Matrix; radians: cdouble) {.importc, libcairo.}
#
proc initRotate*(matrix: var Matrix; radians: float) =
  cairo_matrix_init_rotate(matrix, radians.cdouble)

proc cairo_matrix_translate*(matrix: var Matrix; tx, ty: cdouble) {.importc, libcairo.}
#
proc translate*(matrix: var Matrix; tx, ty: float) =
  cairo_matrix_translate(matrix, tx.cdouble, ty.cdouble)

proc cairo_matrix_scale*(matrix: var Matrix; sx, sy: cdouble) {.importc, libcairo.}
#
proc scale*(matrix: var Matrix; sx, sy: float) =
  cairo_matrix_scale(matrix, sx.cdouble, sy.cdouble)

proc cairo_matrix_rotate*(matrix: var Matrix; radians: cdouble) {.importc, libcairo.}
#
proc rotate*(matrix: var Matrix; radians: float) =
  cairo_matrix_rotate(matrix, radians.cdouble)

proc cairo_matrix_invert*(matrix: var Matrix): Status {.importc, libcairo.}
#
const invert* = cairo_matrix_invert
 #proc invert*(matrix: var Matrix): Status =
 #  cairo_matrix_invert(matrix)

proc cairo_matrix_multiply*(result: var Matrix; a: Matrix; b: Matrix) {.importc, libcairo.}
#
const multiply* = cairo_matrix_multiply

proc cairo_matrix_transform_distance*(matrix: var Matrix; dx, dy: var cdouble) {.importc, libcairo.}
#
proc transformDistance*(matrix: var Matrix; dx, dy: var float) =
  var x, y: cdouble
  cairo_matrix_transform_distance(matrix, x, y)
  dx = x
  dy = y

proc cairo_matrix_transform_point*(matrix: var Matrix; x, y: var cdouble) {.importc, libcairo.}
#
proc transformPoint*(matrix: var Matrix; x, y: var float) =
  var x0, y0: cdouble
  cairo_matrix_transform_point(matrix, x0, y0)
  x = x0
  y = y0

proc cairo_region_destroy*(region: ptr Region00) {.importc, libcairo.}
#
proc destroy*(region: Region) =
  cairo_region_destroy(region.impl)

# there is no cairo_region_set_user_data()
proc cairo_region_create*(): ptr Region00 {.importc, libcairo.}
#
proc regionCreate*(): Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cairo_region_create()
  ### discard cairo_region_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

proc cairo_region_create_rectangle*(rectangle: RectangleInt): ptr Region00 {.importc, libcairo.}
#
proc regionCreateRectangle*(rectangle: RectangleInt): Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cairo_region_create_rectangle(rectangle)

# TODO
proc cairo_region_create_rectangles*(rects: RectangleInt; count: cint): ptr Region00 {.importc, libcairo.}
#

proc cairo_region_copy*(original: ptr Region00): ptr Region00 {.importc, libcairo.}
#
proc regionCopy*(original: Region): Region =
  fnew(result, gBoxedFreeCairoRegion)
  result.impl = cairo_region_copy(original.impl)

proc cairo_region_reference*(region: ptr Region00): ptr Region00 {.importc, libcairo.}
#
proc regionReference*(region: Region): Region =
  discard cairo_region_reference(region.impl)
  return region

proc cairo_region_equal*(a: ptr Region00; b: ptr Region00): Bool00 {.importc, libcairo.}
#
proc equal*(a: Region; b: Region): bool =
  cairo_region_equal(a.impl, b.impl).bool

proc cairo_region_status*(region: ptr Region00): Status {.importc, libcairo.}
#
proc status*(region: Region): Status =
  cairo_region_status(region.impl)

proc cairo_region_get_extents*(region: ptr Region00; extents: var RectangleInt) {.importc, libcairo.}
#
proc getExtents*(region: Region; extents: var RectangleInt) =
  cairo_region_get_extents(region.impl, extents)

proc cairo_region_num_rectangles*(region: ptr Region00): cint {.importc, libcairo.}
#
proc numRectangles*(region: Region): int =
  cairo_region_num_rectangles(region.impl).int

proc cairo_region_get_rectangle*(region: ptr Region00; nth: cint; rectangle: var RectangleInt) {.importc, libcairo.}
#
proc getRectangle*(region: Region; nth: int; rectangle: var RectangleInt) =
  cairo_region_get_rectangle(region.impl, nth.cint, rectangle)

proc cairo_region_is_empty*(region: ptr Region00): Bool00 {.importc, libcairo.}
#
proc isEmpty*(region: Region): bool =
  cairo_region_is_empty(region.impl).bool

proc cairo_region_contains_rectangle*(region: ptr Region00;
  rectangle: RectangleInt): RegionOverlap {.importc, libcairo.}
#
proc containsRectangle*(region: Region; rectangle: RectangleInt): RegionOverlap =
  cairo_region_contains_rectangle(region.impl, rectangle)

proc cairo_region_contains_point*(region: ptr Region00; x, y: cint): Bool00 {.importc, libcairo.}
#
proc containsPoint*(region: Region; x, y: int): bool =
  cairo_region_contains_point(region.impl, x.cint, y.cint).bool

proc cairo_region_translate*(region: ptr Region00; dx, dy: cint) {.importc, libcairo.}
#
proc translate*(region: Region; dx, dy: int) =
  cairo_region_translate(region.impl, dx.cint, dy.cint)

proc cairo_region_subtract*(dst: ptr Region00; other: ptr Region00): Status {.importc, libcairo.}
#
proc subtract*(dst: Region; other: Region): Status =
  cairo_region_subtract(dst.impl, other.impl)

proc cairo_region_subtract_rectangle*(dst: ptr Region00;
  rectangle: RectangleInt): Status {.importc, libcairo.}
#
proc subtractRectangle*(dst: Region; rectangle: RectangleInt): Status =
  cairo_region_subtract_rectangle(dst.impl, rectangle)

proc cairo_region_intersect*(dst: ptr Region00; other: ptr Region00): Status {.importc, libcairo.}
#
proc intersect*(dst: Region; other: Region): Status =
  cairo_region_intersect(dst.impl, other.impl)

proc cairo_region_intersect_rectangle*(dst: ptr Region00;
  rectangle: RectangleInt): Status {.importc, libcairo.}
#
proc intersectRectangle*(dst: Region; rectangle: RectangleInt): Status =
  cairo_region_intersect_rectangle(dst.impl, rectangle)

proc cairo_region_union*(dst: ptr Region00; other: ptr Region00): Status {.importc, libcairo.}
#
proc union*(dst: Region; other: Region): Status =
  cairo_region_union(dst.impl, other.impl)

proc cairo_region_union_rectangle*(dst: ptr Region00;
  rectangle: RectangleInt): Status {.importc, libcairo.}
#
proc unionRectangle*(dst: Region; rectangle: RectangleInt): Status =
  cairo_region_union_rectangle(dst.impl, rectangle)

proc cairo_region_xor*(dst: ptr Region00; other: ptr Region00): Status {.importc, libcairo.}
#
proc regionXor*(dst: Region; other: Region): Status =
  cairo_region_xor(dst.impl, other.impl)

proc cairo_region_xor_rectangle*(dst: ptr Region00; rectangle: RectangleInt): Status {.importc, libcairo.}
#
proc xorRectangle*(dst: Region; rectangle: RectangleInt): Status =
  cairo_region_xor_rectangle(dst.impl, rectangle)

proc cairo_debug_reset_static_data*() {.importc, libcairo.}

when CAIRO_HAS_PDF_SURFACE:
  type
    PdfVersion* {.size: sizeof(cint), pure.} = enum
      v1_4, v1_5
  proc cairo_pdf_surface_create*(filename: cstring; widthInPoints, heightInPoints: cdouble): ptr Surface00 {.
    importc, libcairo.}

  proc pdfSurfaceCreate*(filename: string; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_pdf_surface_create(filename, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_pdf_surface_create_for_stream*(writeFunc: WriteFunc00;
    closure: pointer; widthInPoints, heightInPoints: cdouble): ptr Surface00 {.importc, libcairo.}
#
  proc pdfSurfaceCreateForStream*(writeFunc: WriteFunc00; closure: pointer; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_pdf_surface_create_for_stream(writeFunc, closure, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_pdf_surface_restrict_to_version*(surface: ptr Surface00;
    version: PdfVersion) {.importc, libcairo.}
#
  proc pdfSurfaceRestrictToVersion*(surface: Surface; version: PdfVersion) =
    cairo_pdf_surface_restrict_to_version(surface.impl, version)

#TODO
  proc cairo_pdf_get_versions*(versions: ptr ptr PdfVersion; numVersions: var cint) {.importc, libcairo.}
#
  #proc pdfGetVersions*(versions: ptr ptr Pdf_version; num_versions: var cint)
  #proc cairo_pdf_get_versions*(versions: ptr ptr Pdf_version; num_versions: var cint)

  proc cairo_pdf_version_to_string*(version: PdfVersion): cstring {.importc, libcairo.}
#
  proc `$`*(version: PdfVersion): string =
    $cairo_pdf_version_to_string(version)

  proc cairo_pdf_surface_set_size*(surface: ptr Surface00; widthInPoints, heightInPoints: cdouble) {.
    importc, libcairo.}
#
  proc setSize*(surface: Surface; widthInPoints, heightInPoints: float) =
    cairo_pdf_surface_set_size(surface.impl, widthInPoints.cdouble, heightInPoints.cdouble)

  type
    PdfOutlineFlags* {.size: sizeof(cint), pure.} = enum
      open = 0x1,
      bold = 0x2,
      italic = 0x4
  const
    CAIRO_PDF_OUTLINE_ROOT* = 0

  proc cairo_pdf_surface_add_outline*(surface: ptr Surface00; parentId: cint;
    utf8: cstring; dest: cstring; flags: PdfOutlineFlags): cint {.importc, libcairo.}
#
  proc pdfSurfaceAddOutline*(surface: Surface; parentId: int; utf8: string; dest: string; flags: PdfOutlineFlags): int =
    cairo_pdf_surface_add_outline(surface.impl, parentId.cint, utf8, dest, flags).int

  type
    PdfMetadata* {.size: sizeof(cint), pure.} = enum
      title, author,
      subject, keywords,
      creator, create_date,
      mod_date

  proc cairo_pdf_surface_set_metadata*(surface: ptr Surface00;
    metadata: PdfMetadata; utf8: cstring) {.importc, libcairo.}
#
  proc pdfSurfaceSetMetadata*(surface: Surface; metadata: PdfMetadata; utf8: string) =
    cairo_pdf_surface_set_metadata(surface.impl, metadata, utf8)

  proc cairo_pdf_surface_set_page_label*(surface: ptr Surface00; utf8: cstring) {.importc, libcairo.}
#
  proc pdfSurfaceSetPageLabel*(surface: Surface; utf8: string) =
    cairo_pdf_surface_set_page_label(surface.impl, utf8)

  proc cairo_pdf_surface_set_thumbnail_size*(surface: ptr Surface00; width, height: cint) {.importc, libcairo.}
#
  proc pdfSurfaceSetThumbnailSize*(surface: Surface; width, height: int) =
    cairo_pdf_surface_set_thumbnail_size(surface.impl, width.cint, height.cint)

when CAIRO_HAS_PS_SURFACE:
  type
    PS_Level* {.size: sizeof(cint), pure.} = enum
      l2, l3

  proc cairo_ps_surface_create*(filename: cstring; widthInPoints, heightInPoints: cdouble): ptr Surface00 {.
    importc, libcairo.}
#
  proc psSurfaceCreate*(filename: string; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_ps_surface_create(filename, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_ps_surface_create_for_stream*(writeFunc: WriteFunc00; closure: pointer;
    widthInPoints, heightInPoints: cdouble): ptr Surface00 {.importc, libcairo.}
#
  proc psSurfaceCreateForStream*(writeFunc: WriteFunc00; closure: pointer; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_ps_surface_create_for_stream(writeFunc, closure, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_ps_surface_restrict_to_level*(surface: ptr Surface00; level: PsLevel) {.importc, libcairo.}
#
  proc psSurfaceRestrictToLevel*(surface: Surface; level: PsLevel) =
    cairo_ps_surface_restrict_to_level(surface.impl, level)

#TODO
  proc cairo_ps_get_levels*(levels: ptr ptr PsLevel; numLevels: var cint) {.importc, libcairo.}
#
  #proc cairo_ps_get_levels*(levels: ptr ptr Ps_level; num_levels: var cint)
  #proc cairo_ps_get_levels*(levels: ptr ptr Ps_level; num_levels: var cint)

  proc cairo_ps_level_to_string*(level: PsLevel): cstring {.importc, libcairo.}
#
  proc `$`*(level: Ps_level): string =
    $cairo_ps_level_to_string(level)

  proc cairo_ps_surface_set_eps*(surface: ptr Surface00; eps: Bool00) {.importc, libcairo.}
#
  proc psSurfaceSetEps*(surface: Surface; eps = true) =
    cairo_ps_surface_set_eps(surface.impl, eps.Bool00)

  proc cairo_ps_surface_get_eps*(surface: ptr Surface00): Bool00 {.importc, libcairo.}
#
  proc psSurfaceGetEps*(surface: Surface): bool =
    cairo_ps_surface_get_eps(surface.impl).bool

  proc cairo_ps_surface_set_size*(surface: ptr Surface00; widthInPoints, heightInPoints: cdouble) {.importc, libcairo.}
#
  proc psSurfaceSetSize*(surface: Surface; widthInPoints, heightInPoints: float) =
    cairo_ps_surface_set_size(surface.impl, widthInPoints.cdouble, heightInPoints.cdouble)

  proc cairo_ps_surface_dsc_comment*(surface: ptr Surface00; comment: cstring) {.importc, libcairo.}
#
  proc psSurfaceDscComment*(surface: Surface; comment: string) =
    cairo_ps_surface_dsc_comment(surface.impl, comment)

  proc cairo_ps_surface_dsc_begin_setup*(surface: ptr Surface00) {.importc, libcairo.}
#
  proc psSurfaceDscBeginSetup*(surface: Surface) =
    cairo_ps_surface_dsc_begin_setup(surface.impl)

  proc cairo_ps_surface_dsc_begin_page_setup*(surface: ptr Surface00) {.importc, libcairo.}
#
  proc psSurfaceDscBeginPageSetup*(surface: Surface) =
    cairo_ps_surface_dsc_begin_page_setup(surface.impl)

when CAIRO_HAS_SVG_SURFACE:
  type
    SvgVersion* {.size: sizeof(cint), pure.} = enum
      v1_1, v1_2

  proc cairo_svg_surface_create*(filename: cstring; widthInPoints, heightInPoints: cdouble): ptr Surface00 {.
    importc, libcairo.}
#
  proc svgSurfaceCreate*(filename: string; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_svg_surface_create(filename, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_svg_surface_create_for_stream*(write_func: Write_func00;
    closure: pointer; widthInPoints, heightInPoints: cdouble): ptr Surface00 {.importc, libcairo.}
#
  proc svgSurfaceCreateForstream*(writeFunc: WriteFunc00; closure: pointer; widthInPoints, heightInPoints: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_svg_surface_create_for_stream(writeFunc, closure, widthInPoints.cdouble, heightInPoints.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_svg_surface_restrict_to_version*(surface: ptr Surface00; version: SvgVersion) {.importc, libcairo.}
#
  proc svgSurfaceRestrictToversion*(surface: Surface; version: SvgVersion) =
    cairo_svg_surface_restrict_to_version(surface.impl, version)

#TODO
  proc cairo_svg_get_versions*(versions: ptr ptr Svg_version; num_versions: var cint) {.importc, libcairo.}
#
  #proc svgGetVersions*(versions: ptr ptr Svg_version; num_versions: var cint)
  #proc cairo_svg_get_versions*(versions: ptr ptr Svg_version; num_versions: var cint)

  proc cairo_svg_version_to_string*(version: Svg_version): cstring {.importc, libcairo.}
#
  proc svgVersionToString*(version: SvgVersion): string =
    $cairo_svg_version_to_string(version)

when CAIRO_HAS_XML_SURFACE:
  proc cairo_xml_create*(filename: cstring): ptr Device00 {.importc, libcairo.}
#
  proc xml_create*(filename: string): Device =
    fnew(result, deviceDestroy)
    result.impl = cairo_xml_create(filename)
    ### discard cairo_device_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_xml_create_for_stream*(writeFunc: WriteFunc00; closure: pointer): ptr Device00 {.importc, libcairo.}
#
  proc xmlCreateForStream*(writeFunc: WriteFunc00; closure: pointer): Device =
    fnew(result, deviceDestroy)
    result.impl = cairo_xml_create_for_stream(writeFunc, closure)
    ### discard cairo_device_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_xml_surface_create*(xml: ptr Device00; content: Content; width, height: cdouble): ptr Surface00 {.
    importc, libcairo.}
#
  proc xmlSurfaceCreate*(xml: Device; content: Content; width, height: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_xml_surface_create(xml.impl, content, width.cdouble, height.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_xml_for_recording_surface*(xml: ptr Device00; surface: ptr Surface00): Status {.importc, libcairo.}
#
  proc xmlForRecordingSurface*(xml: Device; surface: Surface): Status =
    cairo_xml_for_recording_surface(xml.impl, surface.impl)

when CAIRO_HAS_SCRIPT_SURFACE:
  type
    ScriptMode* {.size: sizeof(cint), pure.} = enum
      ascii, binary

  proc cairo_script_create*(filename: cstring): ptr Device00 {.importc, libcairo.}
#
  proc scriptCreate*(filename: string): Device =
    fnew(result, deviceDestroy)
    result.impl = cairo_script_create(filename)
    ### discard cairo_device_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_script_create_for_stream*(writeFunc: WriteFunc00; closure: pointer): ptr Device00 {.importc, libcairo.}
#
  proc scriptCreateForStream*(writeFunc: WriteFunc00; closure: pointer): Device =
    fnew(result, deviceDestroy)
    result.impl = cairo_script_create_for_stream(writeFunc, closure)
    ### discard cairo_device_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_script_write_comment*(script: ptr Device00; comment: cstring; len: cint) {.importc, libcairo.}
#
  proc scriptWriteComment*(script: Device; comment: string; len: int) =
    cairo_script_write_comment(script.impl, comment, len.cint)

  proc cairo_script_set_mode*(script: ptr Device00; mode: ScriptMode) {.importc, libcairo.}
#
  proc scriptSetMode*(script: Device; mode: ScriptMode) =
    cairo_script_set_mode(script.impl, mode)

  proc cairo_script_get_mode*(script: ptr Device00): ScriptMode {.importc, libcairo.}
#
  proc scriptGetMode*(script: Device): ScriptMode =
    cairo_script_get_mode(script.impl)

  proc cairo_script_surface_create*(script: ptr Device00; content: Content; width, height: cdouble): ptr Surface00 {.
    importc, libcairo.}
#
  proc scriptSurfaceCreate*(script: Device; content: Content; width, height: float): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_script_surface_create(script.impl, content, width.cdouble, height.cdouble)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_script_surface_create_for_target*(script: ptr Device00;
    target: ptr Surface00): ptr Surface00 {.importc, libcairo.}
#
  proc scriptSurfaceCreateForTarget*(script: Device; target: Surface): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_script_surface_create_for_target(script.impl, target.impl)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_script_from_recording_surface*(script: ptr Device00;
    recordingSurface: ptr Surface00): Status {.importc, libcairo.}
#
  proc scriptFromRecordingSurface*(script: Device; recordingSurface: Surface): Status =
    cairo_script_from_recording_surface(script.impl, recordingSurface.impl)

when CAIRO_HAS_SKIA_SURFACE:
  proc cairo_skia_surface_create*(format: Format; width, height: cint): ptr Surface00 {.importc, libcairo.}
#
  proc skiaSurfaceCreate*(format: Format; width, height: int): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_skia_surface_create(format, width.cint, height.cint)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

#TODO
  proc cairo_skia_surface_create_for_data*(data: ptr cuchar; format: Format; width, height, stride: cint):
    ptr Surface00 {.importc, libcairo.}
#
  #proc skiaSurfaceCreateForData*(data: ptr cuchar; format: Format; width, height, stride: cint): ptr Surface00
  #proc cairo_skia_surface_create_for_data*(data: ptr cuchar; format: Format; width, height, stride: cint): ptr Surface00

#TODO
# seems to be fully undocumented, so we ignore it for now
when CAIRO_HAS_DRM_SURFACE:
  type
    UdevDevice* = object

  proc cairo_drm_device_get*(device: ptr Udev_device): ptr Device00 {.importc, libcairo.}
  proc cairo_drm_device_get_for_fd*(fd: cint): ptr Device00 {.importc, libcairo.}
  proc cairo_drm_device_default*(): ptr Device00 {.importc, libcairo.}
  proc cairo_drm_device_get_fd*(device: ptr Device00): cint {.importc, libcairo.}
  proc cairo_drm_device_throttle*(device: ptr Device00) {.importc, libcairo.}
  proc cairo_drm_surface_create*(device: ptr Device00; format: Format; width, height: cint): ptr Surface00 {.
    importc, libcairo.}
  proc cairo_drm_surface_create_for_name*(device: ptr Device00; name: cuint; format: Format; width, height, stride: cint):
    ptr Surface00 {.importc, libcairo.}
  proc cairo_drm_surface_create_from_cacheable_image*(device: ptr Device00;
      surface: ptr Surface00): ptr Surface00 {.importc, libcairo.}
  proc cairo_drm_surface_enable_scan_out*(surface: ptr Surface00): Status {.importc, libcairo.}
  proc cairo_drm_surface_get_handle*(surface: ptr Surface00): cuint {.importc, libcairo.}
  proc cairo_drm_surface_get_name*(surface: ptr Surface00): cuint {.importc, libcairo.}
  proc cairo_drm_surface_get_format*(surface: ptr Surface00): Format {.importc, libcairo.}
  proc cairo_drm_surface_get_width*(surface: ptr Surface00): cint {.importc, libcairo.}
  proc cairo_drm_surface_get_height*(surface: ptr Surface00): cint {.importc, libcairo.}
  proc cairo_drm_surface_get_stride*(surface: ptr Surface00): cint {.importc, libcairo.}
  proc cairo_drm_surface_map_to_image*(surface: ptr Surface00): ptr Surface00 {.importc, libcairo.}
  proc cairo_drm_surface_unmap*(drm_surface: ptr Surface00; imageSurface: ptr Surface00) {.importc, libcairo.}

when CAIRO_HAS_TEE_SURFACE:
  proc cairo_tee_surface_create*(master: ptr Surface00): ptr Surface00 {.importc, libcairo.}
#
  proc teeSurfaceCreate*(master: Surface): Surface =
    fnew(result, gBoxedFreeCairoSurface)
    result.impl = cairo_tee_surface_create(master.impl)
    ### discard cairo_surface_set_user_data(result.impl, NUDK, cast[pointer](result), gcuref)

  proc cairo_tee_surface_add*(surface: ptr Surface00; target: ptr Surface00) {.importc, libcairo.}
#
  proc teeSurfaceAdd*(surface: Surface; target: Surface) =
    cairo_tee_surface_add(surface.impl, target.impl)

  proc cairo_tee_surface_remove*(surface: ptr Surface00; target: ptr Surface00) {.importc, libcairo.}
#
  proc teeSurfaceRemove*(surface: Surface; target: Surface) =
    cairo_tee_surface_remove(surface.impl, target.impl)

  proc cairo_tee_surface_index*(surface: ptr Surface00; index: cuint): ptr Surface00 {.importc, libcairo.}
#
  proc teeSurfaceIndex*(surface: Surface; index: int): Surface =
    discard cairo_tee_surface_index(surface.impl, index.cuint)
    return surface

# 2681 lines


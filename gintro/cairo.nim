{.deadCodeElim: on.}

when defined(windows):
  const LIB_CAIRO* = "libcairo-2.dll"
elif defined(macosx):
  const LIB_CAIRO* = "libcairo.dylib"
else:
  const LIB_CAIRO* = "libcairo.so(|.2)"

{.pragma: libcairo, cdecl, dynlib: LIB_CAIRO.}

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
    xx*: cdouble
    yx*: cdouble
    xy*: cdouble
    yy*: cdouble
    x0*: cdouble
    y0*: cdouble
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
    color = 0x1000, alpha = 0x2000,
    color_alpha = 0x3000

type
  FontOptions00* {.pure.} = object
  FontOptions* = ref object
    impl*: ptr FontOptions00

type
  FontFace00* {.pure.} = object
  FontFace* = ref object
    impl*: ptr FontFace00

type
  ScaledFont00* {.pure.} = object
  ScaledFont* = ref object
    impl*: ptr ScaledFont00

type
  Status* {.size: sizeof(cint), pure.} = enum
    success = 0, no_memory, invalid_restore,
    invalid_pop_group, no_current_point,
    invalid_matrix, invalid_status,
    null_pointer, invalid_string,
    invalid_path_data, read_error,
    write_error, surface_finished,
    surface_type_mismatch, pattern_type_mismatch,
    invalid_content, invalid_format,
    invalid_visual, file_not_found,
    invalid_dash, invalid_dsc_comment,
    invalid_index, clip_not_representable,
    temp_file_error, invalid_stride,
    font_type_mismatch, user_font_immutable,
    user_font_error, negative_count,
    invalid_clusters, invalid_slant,
    invalid_weight, invalid_size,
    user_font_not_implemented, device_type_mismatch,
    device_error, invalid_mesh_construction,
    device_finished, jbig2_global_missing,
    png_error, freetype_error,
    win32_gdi_error, tag_error, last_status

type
  PathDataType* {.size: sizeof(cint), pure.} = enum
    move_to, line_to, curve_to,
    close_path

type
  INNER_C_STRUCT_3330700347* = object
    `type`*: PathDataType
    length*: cint

  INNER_C_STRUCT_1651263489* = object
    x*: cdouble
    y*: cdouble

  PathData00* = object {.union.}
    header*: INNER_C_STRUCT_3330700347
    point*: INNER_C_STRUCT_1651263489

type
  Path00* {.pure.} = object
    status*: Status
    data*: ptr PathData00
    numData*: cint
  Path* = ref object
    impl*: ptr Path00

type
  RectangleInt00* {.pure.} = object
    x*: cint
    y*: cint
    width*: cint
    height*: cint
  RectangleInt* = ref object
    impl*: ptr RectangleInt00

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

proc cairoVersion*(): cint {.importc: "cairo_version", libcairo.}
proc cairoVersionString*(): cstring {.importc: "cairo_version_string", libcairo.}

type
  Bool00* = distinct cint

# we should not need these constants often, because we have converters to and from Nim bool
const
  CAIRO_FALSE* = Bool00(0)
  CAIRO_TRUE* = Bool00(1)

converter cbool*(nimbool: bool): Bool00 =
  ord(nimbool).Bool00

converter toBool*(cbool: Bool00): bool =
  int(cbool) != 0

type
  Device00* = object

type
  DestroyFunc00* = proc (data: pointer) {.cdecl.}

type
  UserDataKey00* = object
    unused: cint


type
  Format* {.size: sizeof(cint), pure.} = enum
    invalid = - 1, argb32 = 0, rgb24 = 1,
    a8 = 2, a1 = 3, rgb16_565 = 4,
    rgb30 = 5

type
  WriteFunc00* = proc (closure: pointer; data: ptr cuchar; length: cuint): Status {.cdecl.}

type
  ReadFunc00* = proc (closure: pointer; data: ptr cuchar; length: cuint): Status {.cdecl.}

proc cairoDestroy*(cr: ptr Context00) {.importc: "cairo_destroy", libcairo.}

proc finalizeCairoContext[T](o: T) =
  cairo_destroy(o.impl)

proc cairoCreate*(target: ptr Surface00): ptr Context00 {.importc: "cairo_create", libcairo.}
#
proc newContext*(target: Surface): Context =
  new(result, finalizeCairoContext)
  result.impl = cairoCreate(target.impl)









proc cairoReference*(cr: ptr Context00): ptr Context00 {.importc: "cairo_reference",
    libcairo.}

proc cairoGetReferenceCount*(cr: ptr Context00): cuint {.
    importc: "cairo_get_reference_count", libcairo.}
proc cairoGetUserData*(cr: ptr Context00; key: ptr UserDataKey00): pointer {.
    importc: "cairo_get_user_data", libcairo.}
proc cairoSetUserData*(cr: ptr Context00; key: ptr UserDataKey00; userData: pointer;
                      destroy: DestroyFunc00): Status {.
    importc: "cairo_set_user_data", libcairo.}
proc cairoSave*(cr: ptr Context00) {.importc: "cairo_save", libcairo.}
proc cairoRestore*(cr: ptr Context00) {.importc: "cairo_restore", libcairo.}
proc cairoPushGroup*(cr: ptr Context00) {.importc: "cairo_push_group", libcairo.}
proc cairoPushGroupWithContent*(cr: ptr Context00; content: Content) {.
    importc: "cairo_push_group_with_content", libcairo.}
proc cairoPopGroup*(cr: ptr Context00): ptr Pattern00 {.importc: "cairo_pop_group",
    libcairo.}
proc cairoPopGroupToSource*(cr: ptr Context00) {.importc: "cairo_pop_group_to_source",
    libcairo.}

type
  Operator* {.size: sizeof(cint), pure.} = enum
    clear, source, over,
    `in`, `out`, atop,
    dest, dest_over, dest_in,
    dest_out, dest_atop, `xor`,
    add, saturate, multiply,
    screen, overlay, darken,
    lighten, color_dodge, color_burn,
    hard_light, soft_light,
    difference, exclusion, hsl_hue,
    hsl_saturation, hsl_color,
    hsl_luminosity

proc cairoSetOperator*(cr: ptr Context00; op: Operator) {.
    importc: "cairo_set_operator", libcairo.}
proc cairoSetSource*(cr: ptr Context00; source: ptr Pattern00) {.
    importc: "cairo_set_source", libcairo.}

proc cairoSetSourceRgb*(cr: ptr Context00; red: cdouble; green: cdouble; blue: cdouble) {.
    importc: "cairo_set_source_rgb", libcairo.}
#
proc setSourceRgb*(cr: Context; red, green, blue: float) =
  cairoSetSourceRgb(cr.impl, red.cdouble, green.cdouble, blue.cdouble)


proc cairoSetSourceRgba*(cr: ptr Context00; red: cdouble; green: cdouble; blue: cdouble;
                        alpha: cdouble) {.importc: "cairo_set_source_rgba", libcairo.}
#
proc setSourceRgba*(cr: Context; red, green, blue, alpha: float) =
  cairoSetSourceRgba(cr.impl, red.cdouble, green.cdouble, blue.cdouble, alpha.cdouble)

proc cairoSetSourceSurface*(cr: ptr Context00; surface: ptr Surface00; x: cdouble;
                           y: cdouble) {.importc: "cairo_set_source_surface",
                                       libcairo.}
proc cairoSetTolerance*(cr: ptr Context00; tolerance: cdouble) {.
    importc: "cairo_set_tolerance", libcairo.}

type
  Antialias* {.size: sizeof(cint), pure.} = enum
    default, none, gray,
    subpixel, fast, good,
    best

proc cairoSetAntialias*(cr: ptr Context00; antialias: Antialias) {.
    importc: "cairo_set_antialias", libcairo.}

type
  FillRule* {.size: sizeof(cint), pure.} = enum
    winding, even_odd

proc cairoSetFillRule*(cr: ptr Context00; fillRule: FillRule) {.
    importc: "cairo_set_fill_rule", libcairo.}
proc cairoSetLineWidth*(cr: ptr Context00; width: cdouble) {.
    importc: "cairo_set_line_width", libcairo.}

type
  LineCap* {.size: sizeof(cint), pure.} = enum
    butt, round, square

proc cairoSetLineCap*(cr: ptr Context00; lineCap: LineCap) {.
    importc: "cairo_set_line_cap", libcairo.}

type
  LineJoin* {.size: sizeof(cint), pure.} = enum
    miter, round, bevel

proc cairoSetLineJoin*(cr: ptr Context00; lineJoin: LineJoin) {.
    importc: "cairo_set_line_join", libcairo.}
proc cairoSetDash*(cr: ptr Context00; dashes: var cdouble; numDashes: cint; offset: cdouble) {.
    importc: "cairo_set_dash", libcairo.}
proc cairoSetMiterLimit*(cr: ptr Context00; limit: cdouble) {.
    importc: "cairo_set_miter_limit", libcairo.}
proc cairoTranslate*(cr: ptr Context00; tx: cdouble; ty: cdouble) {.
    importc: "cairo_translate", libcairo.}
proc cairoScale*(cr: ptr Context00; sx: cdouble; sy: cdouble) {.importc: "cairo_scale",
    libcairo.}
proc cairoRotate*(cr: ptr Context00; angle: cdouble) {.importc: "cairo_rotate", libcairo.}
proc cairoTransform*(cr: ptr Context00; matrix: ptr Matrix00) {.
    importc: "cairo_transform", libcairo.}
proc cairoSetMatrix*(cr: ptr Context00; matrix: ptr Matrix00) {.
    importc: "cairo_set_matrix", libcairo.}
proc cairoIdentityMatrix*(cr: ptr Context00) {.importc: "cairo_identity_matrix",
                                        libcairo.}
proc cairoUserToDevice*(cr: ptr Context00; x: var cdouble; y: var cdouble) {.
    importc: "cairo_user_to_device", libcairo.}
proc cairoUserToDeviceDistance*(cr: ptr Context00; dx: var cdouble; dy: var cdouble) {.
    importc: "cairo_user_to_device_distance", libcairo.}
proc cairoDeviceToUser*(cr: ptr Context00; x: var cdouble; y: var cdouble) {.
    importc: "cairo_device_to_user", libcairo.}
proc cairoDeviceToUserDistance*(cr: ptr Context00; dx: var cdouble; dy: var cdouble) {.
    importc: "cairo_device_to_user_distance", libcairo.}

proc cairoNewPath*(cr: ptr Context00) {.importc: "cairo_new_path", libcairo.}

proc cairoMoveTo*(cr: ptr Context00; x: cdouble; y: cdouble) {.importc: "cairo_move_to",
    libcairo.}
#
proc moveTo*(cr: Context; x, y: float) =
  cairoMoveTo(cr.impl,  x.cdouble, y.cdouble)


proc cairoNewSubPath*(cr: ptr Context00) {.importc: "cairo_new_sub_path", libcairo.}

proc cairoLineTo*(cr: ptr Context00; x, y: cdouble) {.importc: "cairo_line_to", libcairo.}
#
proc lineTo*(cr: Context; x, y: float) = cairoLineTo(cast[ptr Context00](cr.impl), cdouble(x), cdouble(y))

proc cairoCurveTo*(cr: ptr Context00; x1: cdouble; y1: cdouble; x2: cdouble; y2: cdouble;
                  x3: cdouble; y3: cdouble) {.importc: "cairo_curve_to", libcairo.}
proc cairoArc*(cr: ptr Context00; xc: cdouble; yc: cdouble; radius: cdouble; angle1: cdouble;
              angle2: cdouble) {.importc: "cairo_arc", libcairo.}
proc cairoArcNegative*(cr: ptr Context00; xc: cdouble; yc: cdouble; radius: cdouble;
                      angle1: cdouble; angle2: cdouble) {.
    importc: "cairo_arc_negative", libcairo.}

proc cairoRelMoveTo*(cr: ptr Context00; dx: cdouble; dy: cdouble) {.
    importc: "cairo_rel_move_to", libcairo.}
proc cairoRelLineTo*(cr: ptr Context00; dx: cdouble; dy: cdouble) {.
    importc: "cairo_rel_line_to", libcairo.}
proc cairoRelCurveTo*(cr: ptr Context00; dx1: cdouble; dy1: cdouble; dx2: cdouble;
                     dy2: cdouble; dx3: cdouble; dy3: cdouble) {.
    importc: "cairo_rel_curve_to", libcairo.}
proc cairoRectangle*(cr: ptr Context00; x: cdouble; y: cdouble; width: cdouble;
                    height: cdouble) {.importc: "cairo_rectangle", libcairo.}
#
proc rectangle*(cr: Context; x, y, width, height: float) =
  cairoRectangle(cr.impl, x.cdouble, y.cdouble, width.cdouble, height.cdouble)

proc cairoClosePath*(cr: ptr Context00) {.importc: "cairo_close_path", libcairo.}
proc cairoPathExtents*(cr: ptr Context00; x1: var cdouble; y1: var cdouble; x2: var cdouble;
                      y2: var cdouble) {.importc: "cairo_path_extents", libcairo.}

proc cairoPaint*(cr: ptr Context00) {.importc: "cairo_paint", libcairo.}
#
proc paint*(cr: Context) =
  cairoPaint(cr.impl)

proc cairoPaintWithAlpha*(cr: ptr Context00; alpha: cdouble) {.
    importc: "cairo_paint_with_alpha", libcairo.}
proc cairoMask*(cr: ptr Context00; pattern: ptr Pattern00) {.importc: "cairo_mask",
    libcairo.}
proc cairoMaskSurface*(cr: ptr Context00; surface: ptr Surface00; surfaceX: cdouble;
                      surfaceY: cdouble) {.importc: "cairo_mask_surface",
    libcairo.}

proc cairoStroke*(cr: ptr Context00) {.importc: "cairo_stroke", libcairo.}
#
proc stroke*(cr: Context) = cairoStroke(cast[ptr Context00](cr.impl))

proc cairoStrokePreserve*(cr: ptr Context00) {.importc: "cairo_stroke_preserve",
                                        libcairo.}
proc cairoFill*(cr: ptr Context00) {.importc: "cairo_fill", libcairo.}
#
proc fill*(cr: Context) = cairoFill(cr. impl)

proc cairoFillPreserve*(cr: ptr Context00) {.importc: "cairo_fill_preserve", libcairo.}
proc cairoCopyPage*(cr: ptr Context00) {.importc: "cairo_copy_page", libcairo.}
proc cairoShowPage*(cr: ptr Context00) {.importc: "cairo_show_page", libcairo.}

proc cairoInStroke*(cr: ptr Context00; x: cdouble; y: cdouble): Bool00 {.
    importc: "cairo_in_stroke", libcairo.}
proc cairoInFill*(cr: ptr Context00; x: cdouble; y: cdouble): Bool00 {.
    importc: "cairo_in_fill", libcairo.}
proc cairoInClip*(cr: ptr Context00; x: cdouble; y: cdouble): Bool00 {.
    importc: "cairo_in_clip", libcairo.}

proc cairoStrokeExtents*(cr: ptr Context00; x1: var cdouble; y1: var cdouble;
                        x2: var cdouble; y2: var cdouble) {.
    importc: "cairo_stroke_extents", libcairo.}
proc cairoFillExtents*(cr: ptr Context00; x1: var cdouble; y1: var cdouble; x2: var cdouble;
                      y2: var cdouble) {.importc: "cairo_fill_extents", libcairo.}

proc cairoResetClip*(cr: ptr Context00) {.importc: "cairo_reset_clip", libcairo.}
proc cairoClip*(cr: ptr Context00) {.importc: "cairo_clip", libcairo.}
proc cairoClipPreserve*(cr: ptr Context00) {.importc: "cairo_clip_preserve", libcairo.}
proc cairoClipExtents*(cr: ptr Context00; x1: var cdouble; y1: var cdouble; x2: var cdouble;
                      y2: var cdouble) {.importc: "cairo_clip_extents", libcairo.}

type
  Rectangle00* = object
    x*: cdouble
    y*: cdouble
    width*: cdouble
    height*: cdouble

type
  RectangleList00* = object
    status*: Status
    rectangles*: ptr Rectangle00
    numRectangles*: cint

proc cairoCopyClipRectangleList*(cr: ptr Context00): ptr RectangleList00 {.
    importc: "cairo_copy_clip_rectangle_list", libcairo.}
proc cairoRectangleListDestroy*(rectangleList: ptr RectangleList00) {.
    importc: "cairo_rectangle_list_destroy", libcairo.}

const
  CAIRO_TAG_DEST* = "cairo.dest"
  CAIRO_TAG_LINK* = "Link"

proc cairoTagBegin*(cr: ptr Context00; tagName: cstring; attributes: cstring) {.
    importc: "cairo_tag_begin", libcairo.}
proc cairoTagEnd*(cr: ptr Context00; tagName: cstring) {.importc: "cairo_tag_end",
    libcairo.}

type
  Glyph00* = object
    index*: culong
    x*: cdouble
    y*: cdouble

proc cairoGlyphAllocate*(numGlyphs: cint): ptr Glyph00 {.
    importc: "cairo_glyph_allocate", libcairo.}
proc cairoGlyphFree*(glyphs: ptr Glyph00) {.importc: "cairo_glyph_free",
    libcairo.}

type
  TextCluster00* = object
    numBytes*: cint
    numGlyphs*: cint

proc cairoTextClusterAllocate*(numClusters: cint): ptr TextCluster00 {.
    importc: "cairo_text_cluster_allocate", libcairo.}
proc cairoTextClusterFree*(clusters: ptr TextCluster00) {.
    importc: "cairo_text_cluster_free", libcairo.}

type
  TextClusterFlags* {.size: sizeof(cint), pure.} = enum
    backward = 0x1

type
  TextExtents00* = object
    xBearing*: cdouble
    yBearing*: cdouble
    width*: cdouble
    height*: cdouble
    xAdvance*: cdouble
    yAdvance*: cdouble

type
  FontExtents00* = object
    ascent*: cdouble
    descent*: cdouble
    height*: cdouble
    maxXAdvance*: cdouble
    maxYAdvance*: cdouble

type
  FontSlant* {.size: sizeof(cint), pure.} = enum
    normal, italic, oblique

type
  FontWeight* {.size: sizeof(cint), pure.} = enum
    normal, bold

type
  SubpixelOrder* {.size: sizeof(cint), pure.} = enum
    default, rgb,
    bgr, vrgb, vbgr

type
  HintStyle* {.size: sizeof(cint), pure.} = enum
    default, none, slight,
    medium, full

type
  HintMetrics* {.size: sizeof(cint), pure.} = enum
    default, off, on

proc cairoFontOptionsCreate*(): ptr FontOptions00 {.
    importc: "cairo_font_options_create", libcairo.}
proc cairoFontOptionsCopy*(original: ptr FontOptions00): ptr FontOptions00 {.
    importc: "cairo_font_options_copy", libcairo.}
proc cairoFontOptionsDestroy*(options: ptr FontOptions00) {.
    importc: "cairo_font_options_destroy", libcairo.}
proc cairoFontOptionsStatus*(options: ptr FontOptions00): Status {.
    importc: "cairo_font_options_status", libcairo.}
proc cairoFontOptionsMerge*(options: ptr FontOptions00;
                           other: ptr FontOptions00) {.
    importc: "cairo_font_options_merge", libcairo.}
proc cairoFontOptionsEqual*(options: ptr FontOptions00;
                           other: ptr FontOptions00): Bool00 {.
    importc: "cairo_font_options_equal", libcairo.}
proc cairoFontOptionsHash*(options: ptr FontOptions00): culong {.
    importc: "cairo_font_options_hash", libcairo.}
proc cairoFontOptionsSetAntialias*(options: ptr FontOptions00;
                                  antialias: Antialias) {.
    importc: "cairo_font_options_set_antialias", libcairo.}
proc cairoFontOptionsGetAntialias*(options: ptr FontOptions00): Antialias {.
    importc: "cairo_font_options_get_antialias", libcairo.}
proc cairoFontOptionsSetSubpixelOrder*(options: ptr FontOptions00;
                                      subpixelOrder: SubpixelOrder) {.
    importc: "cairo_font_options_set_subpixel_order", libcairo.}
proc cairoFontOptionsGetSubpixelOrder*(options: ptr FontOptions00): SubpixelOrder {.
    importc: "cairo_font_options_get_subpixel_order", libcairo.}
proc cairoFontOptionsSetHintStyle*(options: ptr FontOptions00;
                                  hintStyle: HintStyle) {.
    importc: "cairo_font_options_set_hint_style", libcairo.}
proc cairoFontOptionsGetHintStyle*(options: ptr FontOptions00): HintStyle {.
    importc: "cairo_font_options_get_hint_style", libcairo.}
proc cairoFontOptionsSetHintMetrics*(options: ptr FontOptions00;
                                    hintMetrics: HintMetrics) {.
    importc: "cairo_font_options_set_hint_metrics", libcairo.}
proc cairoFontOptionsGetHintMetrics*(options: ptr FontOptions00): HintMetrics {.
    importc: "cairo_font_options_get_hint_metrics", libcairo.}

proc cairoSelectFontFace*(cr: ptr Context00; family: cstring; slant: FontSlant;
                         weight: FontWeight) {.importc: "cairo_select_font_face", libcairo.}
#
proc selectFontFace*(cr: Context; family: string; slant: FontSlant; weight: FontWeight) =
  cairoSelectFontFace(cr.impl, family, slant, weight)


proc cairoSetFontSize*(cr: ptr Context00; size: cdouble) {.
    importc: "cairo_set_font_size", libcairo.}
#
proc setFontSize*(cr: Context; size: float) =
  cairoSetFontSize(cr.impl, size.cdouble)

proc cairoSetFontMatrix*(cr: ptr Context00; matrix: ptr Matrix00) {.
    importc: "cairo_set_font_matrix", libcairo.}
proc cairoGetFontMatrix*(cr: ptr Context00; matrix: ptr Matrix00) {.
    importc: "cairo_get_font_matrix", libcairo.}
proc cairoSetFontOptions*(cr: ptr Context00; options: ptr FontOptions00) {.
    importc: "cairo_set_font_options", libcairo.}
proc cairoGetFontOptions*(cr: ptr Context00; options: ptr FontOptions00) {.
    importc: "cairo_get_font_options", libcairo.}

proc cairoSetFontFace*(cr: ptr Context00; fontFace: ptr FontFace00) {.
    importc: "cairo_set_font_face", libcairo.}



proc cairoGetFontFace*(cr: ptr Context00): ptr FontFace00 {.
    importc: "cairo_get_font_face", libcairo.}
proc cairoSetScaledFont*(cr: ptr Context00; scaledFont: ptr ScaledFont00) {.
    importc: "cairo_set_scaled_font", libcairo.}
proc cairoGetScaledFont*(cr: ptr Context00): ptr ScaledFont00 {.
    importc: "cairo_get_scaled_font", libcairo.}
proc cairoShowText*(cr: ptr Context00; utf8: cstring) {.importc: "cairo_show_text",
    libcairo.}
#
proc showText*(cr: Context; utf8: string) =
  cairoShowText(cr.impl, utf8)

proc cairoShowGlyphs*(cr: ptr Context00; glyphs: ptr Glyph00; numGlyphs: cint) {.
    importc: "cairo_show_glyphs", libcairo.}
proc cairoShowTextGlyphs*(cr: ptr Context00; utf8: cstring; utf8Len: cint;
                         glyphs: ptr Glyph00; numGlyphs: cint;
                         clusters: ptr TextCluster00; numClusters: cint;
                         clusterFlags: TextClusterFlags) {.
    importc: "cairo_show_text_glyphs", libcairo.}
proc cairoTextPath*(cr: ptr Context00; utf8: cstring) {.importc: "cairo_text_path",
    libcairo.}
proc cairoGlyphPath*(cr: ptr Context00; glyphs: ptr Glyph00; numGlyphs: cint) {.
    importc: "cairo_glyph_path", libcairo.}
proc cairoTextExtents*(cr: ptr Context00; utf8: cstring; extents: ptr TextExtents00) {.
    importc: "cairo_text_extents", libcairo.}
proc cairoGlyphExtents*(cr: ptr Context00; glyphs: ptr Glyph00; numGlyphs: cint;
                       extents: ptr TextExtents00) {.
    importc: "cairo_glyph_extents", libcairo.}
proc cairoFontExtents*(cr: ptr Context00; extents: ptr FontExtents00) {.
    importc: "cairo_font_extents", libcairo.}

proc cairoFontFaceReference*(fontFace: ptr FontFace00): ptr FontFace00 {.
    importc: "cairo_font_face_reference", libcairo.}
proc cairoFontFaceDestroy*(fontFace: ptr FontFace00) {.
    importc: "cairo_font_face_destroy", libcairo.}
proc cairoFontFaceGetReferenceCount*(fontFace: ptr FontFace00): cuint {.
    importc: "cairo_font_face_get_reference_count", libcairo.}
proc cairoFontFaceStatus*(fontFace: ptr FontFace00): Status {.
    importc: "cairo_font_face_status", libcairo.}

type
  FontType* {.size: sizeof(cint), pure.} = enum
    toy, ft, win32,
    quartz, user

proc cairoFontFaceGetType*(fontFace: ptr FontFace00): FontType {.
    importc: "cairo_font_face_get_type", libcairo.}
proc cairoFontFaceGetUserData*(fontFace: ptr FontFace00;
                              key: ptr UserDataKey00): pointer {.
    importc: "cairo_font_face_get_user_data", libcairo.}
proc cairoFontFaceSetUserData*(fontFace: ptr FontFace00;
                              key: ptr UserDataKey00; userData: pointer;
                              destroy: DestroyFunc00): Status {.
    importc: "cairo_font_face_set_user_data", libcairo.}

proc cairoScaledFontCreate*(fontFace: ptr FontFace00;
                           fontMatrix: ptr Matrix00; ctm: ptr Matrix00;
                           options: ptr FontOptions00): ptr ScaledFont00 {.
    importc: "cairo_scaled_font_create", libcairo.}
proc cairoScaledFontReference*(scaledFont: ptr ScaledFont00): ptr ScaledFont00 {.
    importc: "cairo_scaled_font_reference", libcairo.}
proc cairoScaledFontDestroy*(scaledFont: ptr ScaledFont00) {.
    importc: "cairo_scaled_font_destroy", libcairo.}
proc cairoScaledFontGetReferenceCount*(scaledFont: ptr ScaledFont00): cuint {.
    importc: "cairo_scaled_font_get_reference_count", libcairo.}
proc cairoScaledFontStatus*(scaledFont: ptr ScaledFont00): Status {.
    importc: "cairo_scaled_font_status", libcairo.}
proc cairoScaledFontGetType*(scaledFont: ptr ScaledFont00): FontType {.
    importc: "cairo_scaled_font_get_type", libcairo.}
proc cairoScaledFontGetUserData*(scaledFont: ptr ScaledFont00;
                                key: ptr UserDataKey00): pointer {.
    importc: "cairo_scaled_font_get_user_data", libcairo.}
proc cairoScaledFontSetUserData*(scaledFont: ptr ScaledFont00;
                                key: ptr UserDataKey00; userData: pointer;
                                destroy: DestroyFunc00): Status {.
    importc: "cairo_scaled_font_set_user_data", libcairo.}
proc cairoScaledFontExtents*(scaledFont: ptr ScaledFont00;
                            extents: ptr FontExtents00) {.
    importc: "cairo_scaled_font_extents", libcairo.}
proc cairoScaledFontTextExtents*(scaledFont: ptr ScaledFont00; utf8: cstring;
                                extents: ptr TextExtents00) {.
    importc: "cairo_scaled_font_text_extents", libcairo.}
proc cairoScaledFontGlyphExtents*(scaledFont: ptr ScaledFont00;
                                 glyphs: ptr Glyph00; numGlyphs: cint;
                                 extents: ptr TextExtents00) {.
    importc: "cairo_scaled_font_glyph_extents", libcairo.}
proc cairoScaledFontTextToGlyphs*(scaledFont: ptr ScaledFont00; x: cdouble;
                                 y: cdouble; utf8: cstring; utf8Len: cint;
                                 glyphs: ptr ptr Glyph00; numGlyphs: var cint;
                                 clusters: ptr ptr TextCluster00;
                                 numClusters: var cint;
                                 clusterFlags: var TextClusterFlags): Status {.
    importc: "cairo_scaled_font_text_to_glyphs", libcairo.}
proc cairoScaledFontGetFontFace*(scaledFont: ptr ScaledFont00): ptr FontFace00 {.
    importc: "cairo_scaled_font_get_font_face", libcairo.}
proc cairoScaledFontGetFontMatrix*(scaledFont: ptr ScaledFont00;
                                  fontMatrix: ptr Matrix00) {.
    importc: "cairo_scaled_font_get_font_matrix", libcairo.}
proc cairoScaledFontGetCtm*(scaledFont: ptr ScaledFont00; ctm: ptr Matrix00) {.
    importc: "cairo_scaled_font_get_ctm", libcairo.}
proc cairoScaledFontGetScaleMatrix*(scaledFont: ptr ScaledFont00;
                                   scaleMatrix: ptr Matrix00) {.
    importc: "cairo_scaled_font_get_scale_matrix", libcairo.}
proc cairoScaledFontGetFontOptions*(scaledFont: ptr ScaledFont00;
                                   options: ptr FontOptions00) {.
    importc: "cairo_scaled_font_get_font_options", libcairo.}

proc cairoToyFontFaceCreate*(family: cstring; slant: FontSlant;
                            weight: FontWeight): ptr FontFace00 {.
    importc: "cairo_toy_font_face_create", libcairo.}
proc cairoToyFontFaceGetFamily*(fontFace: ptr FontFace00): cstring {.
    importc: "cairo_toy_font_face_get_family", libcairo.}
proc cairoToyFontFaceGetSlant*(fontFace: ptr FontFace00): FontSlant {.
    importc: "cairo_toy_font_face_get_slant", libcairo.}
proc cairoToyFontFaceGetWeight*(fontFace: ptr FontFace00): FontWeight {.
    importc: "cairo_toy_font_face_get_weight", libcairo.}

proc cairoUserFontFaceCreate*(): ptr FontFace00 {.
    importc: "cairo_user_font_face_create", libcairo.}

type
  UserScaledFontInitFunc00* = proc (scaledFont: ptr ScaledFont00;
                                     cr: ptr Context00; extents: ptr FontExtents00): Status {.cdecl.}

type
  UserScaledFontRenderGlyphFunc00* = proc (scaledFont: ptr ScaledFont00;
      glyph: culong; cr: ptr Context00; extents: ptr TextExtents00): Status {.cdecl.}

type
  UserScaledFontTextToGlyphsFunc00* = proc (scaledFont: ptr ScaledFont00;
      utf8: cstring; utf8Len: cint; glyphs: ptr ptr Glyph00; numGlyphs: var cint;
      clusters: ptr ptr TextCluster00; numClusters: var cint;
      clusterFlags: var TextClusterFlags): Status {.cdecl.}

type
  UserScaledFontUnicodeToGlyphFunc00* = proc (scaledFont: ptr ScaledFont00;
      unicode: culong; glyphIndex: var culong): Status {.cdecl.}

proc cairoUserFontFaceSetInitFunc*(fontFace: ptr FontFace00;
                                  initFunc: UserScaledFontInitFunc00) {.
    importc: "cairo_user_font_face_set_init_func", libcairo.}
proc cairoUserFontFaceSetRenderGlyphFunc*(fontFace: ptr FontFace00;
    renderGlyphFunc: UserScaledFontRenderGlyphFunc00) {.
    importc: "cairo_user_font_face_set_render_glyph_func", libcairo.}
proc cairoUserFontFaceSetTextToGlyphsFunc*(fontFace: ptr FontFace00;
    textToGlyphsFunc: UserScaledFontTextToGlyphsFunc00) {.
    importc: "cairo_user_font_face_set_text_to_glyphs_func", libcairo.}
proc cairoUserFontFaceSetUnicodeToGlyphFunc*(fontFace: ptr FontFace00;
    unicodeToGlyphFunc: UserScaledFontUnicodeToGlyphFunc00) {.
    importc: "cairo_user_font_face_set_unicode_to_glyph_func", libcairo.}

proc cairoUserFontFaceGetInitFunc*(fontFace: ptr FontFace00): UserScaledFontInitFunc00 {.
    importc: "cairo_user_font_face_get_init_func", libcairo.}
proc cairoUserFontFaceGetRenderGlyphFunc*(fontFace: ptr FontFace00): UserScaledFontRenderGlyphFunc00 {.
    importc: "cairo_user_font_face_get_render_glyph_func", libcairo.}
proc cairoUserFontFaceGetTextToGlyphsFunc*(fontFace: ptr FontFace00): UserScaledFontTextToGlyphsFunc00 {.
    importc: "cairo_user_font_face_get_text_to_glyphs_func", libcairo.}
proc cairoUserFontFaceGetUnicodeToGlyphFunc*(fontFace: ptr FontFace00): UserScaledFontUnicodeToGlyphFunc00 {.
    importc: "cairo_user_font_face_get_unicode_to_glyph_func", libcairo.}

proc cairoGetOperator*(cr: ptr Context00): Operator {.
    importc: "cairo_get_operator", libcairo.}
proc cairoGetSource*(cr: ptr Context00): ptr Pattern00 {.importc: "cairo_get_source",
    libcairo.}
proc cairoGetTolerance*(cr: ptr Context00): cdouble {.importc: "cairo_get_tolerance",
    libcairo.}
proc cairoGetAntialias*(cr: ptr Context00): Antialias {.
    importc: "cairo_get_antialias", libcairo.}
proc cairoHasCurrentPoint*(cr: ptr Context00): Bool00 {.
    importc: "cairo_has_current_point", libcairo.}
proc cairoGetCurrentPoint*(cr: ptr Context00; x: var cdouble; y: var cdouble) {.
    importc: "cairo_get_current_point", libcairo.}
proc cairoGetFillRule*(cr: ptr Context00): FillRule {.
    importc: "cairo_get_fill_rule", libcairo.}
proc cairoGetLineWidth*(cr: ptr Context00): cdouble {.importc: "cairo_get_line_width",
    libcairo.}
proc cairoGetLineCap*(cr: ptr Context00): LineCap {.importc: "cairo_get_line_cap",
    libcairo.}
proc cairoGetLineJoin*(cr: ptr Context00): LineJoin {.
    importc: "cairo_get_line_join", libcairo.}
proc cairoGetMiterLimit*(cr: ptr Context00): cdouble {.importc: "cairo_get_miter_limit",
    libcairo.}
proc cairoGetDashCount*(cr: ptr Context00): cint {.importc: "cairo_get_dash_count",
    libcairo.}
proc cairoGetDash*(cr: ptr Context00; dashes: var cdouble; offset: var cdouble) {.
    importc: "cairo_get_dash", libcairo.}
proc cairoGetMatrix*(cr: ptr Context00; matrix: ptr Matrix00) {.
    importc: "cairo_get_matrix", libcairo.}
proc cairoGetTarget*(cr: ptr Context00): ptr Surface00 {.importc: "cairo_get_target",
    libcairo.}
proc cairoGetGroupTarget*(cr: ptr Context00): ptr Surface00 {.
    importc: "cairo_get_group_target", libcairo.}

proc cairoCopyPath*(cr: ptr Context00): ptr Path00 {.importc: "cairo_copy_path",
    libcairo.}
proc cairoCopyPathFlat*(cr: ptr Context00): ptr Path00 {.
    importc: "cairo_copy_path_flat", libcairo.}
proc cairoAppendPath*(cr: ptr Context00; path: ptr Path00) {.
    importc: "cairo_append_path", libcairo.}
proc cairoPathDestroy*(path: ptr Path00) {.importc: "cairo_path_destroy",
    libcairo.}

proc cairoStatus*(cr: ptr Context00): Status {.importc: "cairo_status", libcairo.}
proc cairoStatusToString*(status: Status): cstring {.
    importc: "cairo_status_to_string", libcairo.}

proc cairoDeviceReference*(device: ptr Device00): ptr Device00 {.
    importc: "cairo_device_reference", libcairo.}

type
  DeviceType* {.size: sizeof(cint), pure.} = enum
    invalid = - 1, drm, gl,
    script, xcb, xlib,
    xml, cogl, win32

proc cairoDeviceGetType*(device: ptr Device00): DeviceType {.
    importc: "cairo_device_get_type", libcairo.}
proc cairoDeviceStatus*(device: ptr Device00): Status {.
    importc: "cairo_device_status", libcairo.}
proc cairoDeviceAcquire*(device: ptr Device00): Status {.
    importc: "cairo_device_acquire", libcairo.}
proc cairoDeviceRelease*(device: ptr Device00) {.
    importc: "cairo_device_release", libcairo.}
proc cairoDeviceFlush*(device: ptr Device00) {.importc: "cairo_device_flush",
    libcairo.}
proc cairoDeviceFinish*(device: ptr Device00) {.importc: "cairo_device_finish",
    libcairo.}
proc cairoDeviceDestroy*(device: ptr Device00) {.
    importc: "cairo_device_destroy", libcairo.}
proc cairoDeviceGetReferenceCount*(device: ptr Device00): cuint {.
    importc: "cairo_device_get_reference_count", libcairo.}
proc cairoDeviceGetUserData*(device: ptr Device00; key: ptr UserDataKey00): pointer {.
    importc: "cairo_device_get_user_data", libcairo.}
proc cairoDeviceSetUserData*(device: ptr Device00; key: ptr UserDataKey00;
                            userData: pointer; destroy: DestroyFunc00): Status {.
    importc: "cairo_device_set_user_data", libcairo.}

proc cairoSurfaceCreateSimilar*(other: ptr Surface00; content: Content;
                               width: cint; height: cint): ptr Surface00 {.
    importc: "cairo_surface_create_similar", libcairo.}
proc cairoSurfaceCreateSimilarImage*(other: ptr Surface00; format: Format;
                                    width: cint; height: cint): ptr Surface00 {.
    importc: "cairo_surface_create_similar_image", libcairo.}
proc cairoSurfaceMapToImage*(surface: ptr Surface00;
                            extents: ptr RectangleInt00): ptr Surface00 {.
    importc: "cairo_surface_map_to_image", libcairo.}
proc cairoSurfaceUnmapImage*(surface: ptr Surface00; image: ptr Surface00) {.
    importc: "cairo_surface_unmap_image", libcairo.}
proc cairoSurfaceCreateForRectangle*(target: ptr Surface00; x: cdouble;
                                    y: cdouble; width: cdouble; height: cdouble): ptr Surface00 {.
    importc: "cairo_surface_create_for_rectangle", libcairo.}

type
  SurfaceObserverMode* {.size: sizeof(cint), pure.} = enum
    normal = 0,
    record_operations = 0x1

proc cairoSurfaceCreateObserver*(target: ptr Surface00;
                                mode: SurfaceObserverMode): ptr Surface00 {.
    importc: "cairo_surface_create_observer", libcairo.}
type
  SurfaceObserverCallback00* = proc (observer: ptr Surface00;
                                      target: ptr Surface00; data: pointer) {.cdecl.}

proc cairoSurfaceObserverAddPaintCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_paint_callback", libcairo.}
proc cairoSurfaceObserverAddMaskCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_mask_callback", libcairo.}
proc cairoSurfaceObserverAddFillCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_fill_callback", libcairo.}
proc cairoSurfaceObserverAddStrokeCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_stroke_callback", libcairo.}
proc cairoSurfaceObserverAddGlyphsCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_glyphs_callback", libcairo.}
proc cairoSurfaceObserverAddFlushCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_flush_callback", libcairo.}
proc cairoSurfaceObserverAddFinishCallback*(abstractSurface: ptr Surface00;
    `func`: SurfaceObserverCallback00; data: pointer): Status {.
    importc: "cairo_surface_observer_add_finish_callback", libcairo.}
proc cairoSurfaceObserverPrint*(surface: ptr Surface00;
                               writeFunc: WriteFunc00; closure: pointer): Status {.
    importc: "cairo_surface_observer_print", libcairo.}
proc cairoSurfaceObserverElapsed*(surface: ptr Surface00): cdouble {.
    importc: "cairo_surface_observer_elapsed", libcairo.}
proc cairoDeviceObserverPrint*(device: ptr Device00; writeFunc: WriteFunc00;
                              closure: pointer): Status {.
    importc: "cairo_device_observer_print", libcairo.}
proc cairoDeviceObserverElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_elapsed", libcairo.}
proc cairoDeviceObserverPaintElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_paint_elapsed", libcairo.}
proc cairoDeviceObserverMaskElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_mask_elapsed", libcairo.}
proc cairoDeviceObserverFillElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_fill_elapsed", libcairo.}
proc cairoDeviceObserverStrokeElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_stroke_elapsed", libcairo.}
proc cairoDeviceObserverGlyphsElapsed*(device: ptr Device00): cdouble {.
    importc: "cairo_device_observer_glyphs_elapsed", libcairo.}
proc cairoSurfaceReference*(surface: ptr Surface00): ptr Surface00 {.
    importc: "cairo_surface_reference", libcairo.}
proc cairoSurfaceFinish*(surface: ptr Surface00) {.
    importc: "cairo_surface_finish", libcairo.}
proc cairoSurfaceDestroy*(surface: ptr Surface00) {.
    importc: "cairo_surface_destroy", libcairo.}
proc cairoSurfaceGetDevice*(surface: ptr Surface00): ptr Device00 {.
    importc: "cairo_surface_get_device", libcairo.}
proc cairoSurfaceGetReferenceCount*(surface: ptr Surface00): cuint {.
    importc: "cairo_surface_get_reference_count", libcairo.}
proc cairoSurfaceStatus*(surface: ptr Surface00): Status {.
    importc: "cairo_surface_status", libcairo.}

type
  SurfaceType* {.size: sizeof(cint), pure.} = enum
    image, pdf, ps,
    xlib, xcb, glitz,
    quartz, win32, beos,
    directfb, svg, os2,
    win32_printing, quartz_image,
    script, qt,
    recording, vg, gl,
    drm, tee, xml,
    skia, subsurface,
    cogl

proc cairoSurfaceGetType*(surface: ptr Surface00): SurfaceType {.
    importc: "cairo_surface_get_type", libcairo.}
proc cairoSurfaceGetContent*(surface: ptr Surface00): Content {.
    importc: "cairo_surface_get_content", libcairo.}
when CAIRO_HAS_PNG_FUNCTIONS:
  proc cairoSurfaceWriteToPng*(surface: ptr Surface00; filename: cstring): Status {.
      importc: "cairo_surface_write_to_png", libcairo.}
#
  proc writeToPng*(surface: Surface; filename: string): Status =
    cairoSurfaceWriteToPng(surface.impl, filename)

  proc cairoSurfaceWriteToPngStream*(surface: ptr Surface00;
                                    writeFunc: WriteFunc00; closure: pointer): Status {.
      importc: "cairo_surface_write_to_png_stream", libcairo.}
proc cairoSurfaceGetUserData*(surface: ptr Surface00; key: ptr UserDataKey00): pointer {.
    importc: "cairo_surface_get_user_data", libcairo.}
proc cairoSurfaceSetUserData*(surface: ptr Surface00;
                             key: ptr UserDataKey00; userData: pointer;
                             destroy: DestroyFunc00): Status {.
    importc: "cairo_surface_set_user_data", libcairo.}
const
  MIME_TYPE_JPEG* = "image/jpeg"
  MIME_TYPE_PNG* = "image/png"
  MIME_TYPE_JP2* = "image/jp2"
  MIME_TYPE_URI* = "text/x-uri"
  MIME_TYPE_UNIQUE_ID* = "application/x-cairo.uuid"
  MIME_TYPE_JBIG2* = "application/x-cairo.jbig2"
  MIME_TYPE_JBIG2_GLOBAL* = "application/x-cairo.jbig2-global"
  MIME_TYPE_JBIG2_GLOBAL_ID* = "application/x-cairo.jbig2-global-id"

proc cairoSurfaceGetMimeData*(surface: ptr Surface00; mimeType: cstring;
                             data: ptr ptr cuchar; length: var culong) {.
    importc: "cairo_surface_get_mime_data", libcairo.}
proc cairoSurfaceSetMimeData*(surface: ptr Surface00; mimeType: cstring;
                             data: ptr cuchar; length: culong;
                             destroy: DestroyFunc00; closure: pointer): Status {.
    importc: "cairo_surface_set_mime_data", libcairo.}
proc cairoSurfaceSupportsMimeType*(surface: ptr Surface00; mimeType: cstring): Bool00 {.
    importc: "cairo_surface_supports_mime_type", libcairo.}
proc cairoSurfaceGetFontOptions*(surface: ptr Surface00;
                                options: ptr FontOptions00) {.
    importc: "cairo_surface_get_font_options", libcairo.}
proc cairoSurfaceFlush*(surface: ptr Surface00) {.
    importc: "cairo_surface_flush", libcairo.}
proc cairoSurfaceMarkDirty*(surface: ptr Surface00) {.
    importc: "cairo_surface_mark_dirty", libcairo.}
proc cairoSurfaceMarkDirtyRectangle*(surface: ptr Surface00; x: cint; y: cint;
                                    width: cint; height: cint) {.
    importc: "cairo_surface_mark_dirty_rectangle", libcairo.}
proc cairoSurfaceSetDeviceScale*(surface: ptr Surface00; xScale: cdouble;
                                yScale: cdouble) {.
    importc: "cairo_surface_set_device_scale", libcairo.}
proc cairoSurfaceGetDeviceScale*(surface: ptr Surface00; xScale: var cdouble;
                                yScale: var cdouble) {.
    importc: "cairo_surface_get_device_scale", libcairo.}
proc cairoSurfaceSetDeviceOffset*(surface: ptr Surface00; xOffset: cdouble;
                                 yOffset: cdouble) {.
    importc: "cairo_surface_set_device_offset", libcairo.}
proc cairoSurfaceGetDeviceOffset*(surface: ptr Surface00; xOffset: var cdouble;
                                 yOffset: var cdouble) {.
    importc: "cairo_surface_get_device_offset", libcairo.}
proc cairoSurfaceSetFallbackResolution*(surface: ptr Surface00;
                                       xPixelsPerInch: cdouble;
                                       yPixelsPerInch: cdouble) {.
    importc: "cairo_surface_set_fallback_resolution", libcairo.}
proc cairoSurfaceGetFallbackResolution*(surface: ptr Surface00;
                                       xPixelsPerInch: var cdouble;
                                       yPixelsPerInch: var cdouble) {.
    importc: "cairo_surface_get_fallback_resolution", libcairo.}
proc cairoSurfaceCopyPage*(surface: ptr Surface00) {.
    importc: "cairo_surface_copy_page", libcairo.}
proc cairoSurfaceShowPage*(surface: ptr Surface00) {.
    importc: "cairo_surface_show_page", libcairo.}
proc cairoSurfaceHasShowTextGlyphs*(surface: ptr Surface00): Bool00 {.
    importc: "cairo_surface_has_show_text_glyphs", libcairo.}

proc cairoImageSurfaceCreate*(format: Format; width: cint; height: cint): ptr Surface00 {.
    importc: "cairo_image_surface_create", libcairo.}

proc finalizeCairoSurface[T](o: T) =
  cairo_surface_destroy(o.impl)

proc newImageSurface*(format: Format; width: int; height: int): Surface =
  new(result, finalizeCairoSurface)
  result.impl = cairoImageSurfaceCreate(format, width.cint, height.cint)







proc cairoFormatStrideForWidth*(format: Format; width: cint): cint {.
    importc: "cairo_format_stride_for_width", libcairo.}
proc cairoImageSurfaceCreateForData*(data: ptr cuchar; format: Format;
                                    width: cint; height: cint; stride: cint): ptr Surface00 {.
    importc: "cairo_image_surface_create_for_data", libcairo.}
proc cairoImageSurfaceGetData*(surface: ptr Surface00): ptr cuchar {.
    importc: "cairo_image_surface_get_data", libcairo.}
proc cairoImageSurfaceGetFormat*(surface: ptr Surface00): Format {.
    importc: "cairo_image_surface_get_format", libcairo.}
proc cairoImageSurfaceGetWidth*(surface: ptr Surface00): cint {.
    importc: "cairo_image_surface_get_width", libcairo.}
proc cairoImageSurfaceGetHeight*(surface: ptr Surface00): cint {.
    importc: "cairo_image_surface_get_height", libcairo.}
proc cairoImageSurfaceGetStride*(surface: ptr Surface00): cint {.
    importc: "cairo_image_surface_get_stride", libcairo.}
when CAIRO_HAS_PNG_FUNCTIONS:
  proc cairoImageSurfaceCreateFromPng*(filename: cstring): ptr Surface00 {.
      importc: "cairo_image_surface_create_from_png", libcairo.}
  proc cairoImageSurfaceCreateFromPngStream*(readFunc: ReadFunc00;
      closure: pointer): ptr Surface00 {.
      importc: "cairo_image_surface_create_from_png_stream", libcairo.}

proc cairoRecordingSurfaceCreate*(content: Content;
                                 extents: ptr Rectangle00): ptr Surface00 {.
    importc: "cairo_recording_surface_create", libcairo.}
proc cairoRecordingSurfaceInkExtents*(surface: ptr Surface00; x0: var cdouble;
                                     y0: var cdouble; width: var cdouble;
                                     height: var cdouble) {.
    importc: "cairo_recording_surface_ink_extents", libcairo.}
proc cairoRecordingSurfaceGetExtents*(surface: ptr Surface00;
                                     extents: ptr Rectangle00): Bool00 {.
    importc: "cairo_recording_surface_get_extents", libcairo.}

type
  RasterSourceAcquireFunc00* = proc (pattern: ptr Pattern00;
                                      callbackData: pointer;
                                      target: ptr Surface00;
                                      extents: ptr RectangleInt00): ptr Surface00 {.cdecl.}

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

proc cairoPatternCreateRasterSource*(userData: pointer; content: Content;
                                    width: cint; height: cint): ptr Pattern00 {.
    importc: "cairo_pattern_create_raster_source", libcairo.}
proc cairoRasterSourcePatternSetCallbackData*(pattern: ptr Pattern00;
    data: pointer) {.importc: "cairo_raster_source_pattern_set_callback_data",
                   libcairo.}
proc cairoRasterSourcePatternGetCallbackData*(pattern: ptr Pattern00): pointer {.
    importc: "cairo_raster_source_pattern_get_callback_data", libcairo.}
proc cairoRasterSourcePatternSetAcquire*(pattern: ptr Pattern00;
                                        acquire: RasterSourceAcquireFunc00;
                                        release: RasterSourceReleaseFunc00) {.
    importc: "cairo_raster_source_pattern_set_acquire", libcairo.}
proc cairoRasterSourcePatternGetAcquire*(pattern: ptr Pattern00; acquire: ptr RasterSourceAcquireFunc00;
    release: ptr RasterSourceReleaseFunc00) {.
    importc: "cairo_raster_source_pattern_get_acquire", libcairo.}
proc cairoRasterSourcePatternSetSnapshot*(pattern: ptr Pattern00;
    snapshot: RasterSourceSnapshotFunc00) {.
    importc: "cairo_raster_source_pattern_set_snapshot", libcairo.}
proc cairoRasterSourcePatternGetSnapshot*(pattern: ptr Pattern00): RasterSourceSnapshotFunc00 {.
    importc: "cairo_raster_source_pattern_get_snapshot", libcairo.}
proc cairoRasterSourcePatternSetCopy*(pattern: ptr Pattern00;
                                     copy: RasterSourceCopyFunc00) {.
    importc: "cairo_raster_source_pattern_set_copy", libcairo.}
proc cairoRasterSourcePatternGetCopy*(pattern: ptr Pattern00): RasterSourceCopyFunc00 {.
    importc: "cairo_raster_source_pattern_get_copy", libcairo.}
proc cairoRasterSourcePatternSetFinish*(pattern: ptr Pattern00;
                                       finish: RasterSourceFinishFunc00) {.
    importc: "cairo_raster_source_pattern_set_finish", libcairo.}
proc cairoRasterSourcePatternGetFinish*(pattern: ptr Pattern00): RasterSourceFinishFunc00 {.
    importc: "cairo_raster_source_pattern_get_finish", libcairo.}

proc cairoPatternCreateRgb*(red: cdouble; green: cdouble; blue: cdouble): ptr Pattern00 {.
    importc: "cairo_pattern_create_rgb", libcairo.}
proc cairoPatternCreateRgba*(red: cdouble; green: cdouble; blue: cdouble;
                            alpha: cdouble): ptr Pattern00 {.
    importc: "cairo_pattern_create_rgba", libcairo.}
proc cairoPatternCreateForSurface*(surface: ptr Surface00): ptr Pattern00 {.
    importc: "cairo_pattern_create_for_surface", libcairo.}
proc cairoPatternCreateLinear*(x0: cdouble; y0: cdouble; x1: cdouble; y1: cdouble): ptr Pattern00 {.
    importc: "cairo_pattern_create_linear", libcairo.}
proc cairoPatternCreateRadial*(cx0: cdouble; cy0: cdouble; radius0: cdouble;
                              cx1: cdouble; cy1: cdouble; radius1: cdouble): ptr Pattern00 {.
    importc: "cairo_pattern_create_radial", libcairo.}
proc cairoPatternCreateMesh*(): ptr Pattern00 {.
    importc: "cairo_pattern_create_mesh", libcairo.}
proc cairoPatternReference*(pattern: ptr Pattern00): ptr Pattern00 {.
    importc: "cairo_pattern_reference", libcairo.}
proc cairoPatternDestroy*(pattern: ptr Pattern00) {.
    importc: "cairo_pattern_destroy", libcairo.}
proc cairoPatternGetReferenceCount*(pattern: ptr Pattern00): cuint {.
    importc: "cairo_pattern_get_reference_count", libcairo.}
proc cairoPatternStatus*(pattern: ptr Pattern00): Status {.
    importc: "cairo_pattern_status", libcairo.}
proc cairoPatternGetUserData*(pattern: ptr Pattern00; key: ptr UserDataKey00): pointer {.
    importc: "cairo_pattern_get_user_data", libcairo.}
proc cairoPatternSetUserData*(pattern: ptr Pattern00;
                             key: ptr UserDataKey00; userData: pointer;
                             destroy: DestroyFunc00): Status {.
    importc: "cairo_pattern_set_user_data", libcairo.}

type
  PatternType* {.size: sizeof(cint), pure.} = enum
    solid, surface,
    linear, radial, mesh,
    raster_source

proc cairoPatternGetType*(pattern: ptr Pattern00): PatternType {.
    importc: "cairo_pattern_get_type", libcairo.}
proc cairoPatternAddColorStopRgb*(pattern: ptr Pattern00; offset: cdouble;
                                 red: cdouble; green: cdouble; blue: cdouble) {.
    importc: "cairo_pattern_add_color_stop_rgb", libcairo.}
proc cairoPatternAddColorStopRgba*(pattern: ptr Pattern00; offset: cdouble;
                                  red: cdouble; green: cdouble; blue: cdouble;
                                  alpha: cdouble) {.
    importc: "cairo_pattern_add_color_stop_rgba", libcairo.}
proc cairoMeshPatternBeginPatch*(pattern: ptr Pattern00) {.
    importc: "cairo_mesh_pattern_begin_patch", libcairo.}
proc cairoMeshPatternEndPatch*(pattern: ptr Pattern00) {.
    importc: "cairo_mesh_pattern_end_patch", libcairo.}
proc cairoMeshPatternCurveTo*(pattern: ptr Pattern00; x1: cdouble; y1: cdouble;
                             x2: cdouble; y2: cdouble; x3: cdouble; y3: cdouble) {.
    importc: "cairo_mesh_pattern_curve_to", libcairo.}
proc cairoMeshPatternLineTo*(pattern: ptr Pattern00; x: cdouble; y: cdouble) {.
    importc: "cairo_mesh_pattern_line_to", libcairo.}
proc cairoMeshPatternMoveTo*(pattern: ptr Pattern00; x: cdouble; y: cdouble) {.
    importc: "cairo_mesh_pattern_move_to", libcairo.}
proc cairoMeshPatternSetControlPoint*(pattern: ptr Pattern00; pointNum: cuint;
                                     x: cdouble; y: cdouble) {.
    importc: "cairo_mesh_pattern_set_control_point", libcairo.}
proc cairoMeshPatternSetCornerColorRgb*(pattern: ptr Pattern00;
                                       cornerNum: cuint; red: cdouble;
                                       green: cdouble; blue: cdouble) {.
    importc: "cairo_mesh_pattern_set_corner_color_rgb", libcairo.}
proc cairoMeshPatternSetCornerColorRgba*(pattern: ptr Pattern00;
                                        cornerNum: cuint; red: cdouble;
                                        green: cdouble; blue: cdouble;
                                        alpha: cdouble) {.
    importc: "cairo_mesh_pattern_set_corner_color_rgba", libcairo.}
proc cairoPatternSetMatrix*(pattern: ptr Pattern00; matrix: ptr Matrix00) {.
    importc: "cairo_pattern_set_matrix", libcairo.}
proc cairoPatternGetMatrix*(pattern: ptr Pattern00; matrix: ptr Matrix00) {.
    importc: "cairo_pattern_get_matrix", libcairo.}

type
  Extend* {.size: sizeof(cint), pure.} = enum
    none, repeat, reflect, pad

proc cairoPatternSetExtend*(pattern: ptr Pattern00; extend: Extend) {.
    importc: "cairo_pattern_set_extend", libcairo.}
proc cairoPatternGetExtend*(pattern: ptr Pattern00): Extend {.
    importc: "cairo_pattern_get_extend", libcairo.}

type
  Filter* {.size: sizeof(cint), pure.} = enum
    fast, good, best, nearest,
    bilinear, gaussian

proc cairoPatternSetFilter*(pattern: ptr Pattern00; filter: Filter) {.
    importc: "cairo_pattern_set_filter", libcairo.}
proc cairoPatternGetFilter*(pattern: ptr Pattern00): Filter {.
    importc: "cairo_pattern_get_filter", libcairo.}
proc cairoPatternGetRgba*(pattern: ptr Pattern00; red: var cdouble;
                         green: var cdouble; blue: var cdouble; alpha: var cdouble): Status {.
    importc: "cairo_pattern_get_rgba", libcairo.}
proc cairoPatternGetSurface*(pattern: ptr Pattern00;
                            surface: ptr ptr Surface00): Status {.
    importc: "cairo_pattern_get_surface", libcairo.}
proc cairoPatternGetColorStopRgba*(pattern: ptr Pattern00; index: cint;
                                  offset: var cdouble; red: var cdouble;
                                  green: var cdouble; blue: var cdouble;
                                  alpha: var cdouble): Status {.
    importc: "cairo_pattern_get_color_stop_rgba", libcairo.}
proc cairoPatternGetColorStopCount*(pattern: ptr Pattern00; count: var cint): Status {.
    importc: "cairo_pattern_get_color_stop_count", libcairo.}
proc cairoPatternGetLinearPoints*(pattern: ptr Pattern00; x0: var cdouble;
                                 y0: var cdouble; x1: var cdouble; y1: var cdouble): Status {.
    importc: "cairo_pattern_get_linear_points", libcairo.}
proc cairoPatternGetRadialCircles*(pattern: ptr Pattern00; x0: var cdouble;
                                  y0: var cdouble; r0: var cdouble; x1: var cdouble;
                                  y1: var cdouble; r1: var cdouble): Status {.
    importc: "cairo_pattern_get_radial_circles", libcairo.}
proc cairoMeshPatternGetPatchCount*(pattern: ptr Pattern00; count: var cuint): Status {.
    importc: "cairo_mesh_pattern_get_patch_count", libcairo.}
proc cairoMeshPatternGetPath*(pattern: ptr Pattern00; patchNum: cuint): ptr Path00 {.
    importc: "cairo_mesh_pattern_get_path", libcairo.}
proc cairoMeshPatternGetCornerColorRgba*(pattern: ptr Pattern00;
                                        patchNum: cuint; cornerNum: cuint;
                                        red: var cdouble; green: var cdouble;
                                        blue: var cdouble; alpha: var cdouble): Status {.
    importc: "cairo_mesh_pattern_get_corner_color_rgba", libcairo.}
proc cairoMeshPatternGetControlPoint*(pattern: ptr Pattern00; patchNum: cuint;
                                     pointNum: cuint; x: var cdouble; y: var cdouble): Status {.
    importc: "cairo_mesh_pattern_get_control_point", libcairo.}

proc cairoMatrixInit*(matrix: ptr Matrix00; xx: cdouble; yx: cdouble; xy: cdouble;
                     yy: cdouble; x0: cdouble; y0: cdouble) {.
    importc: "cairo_matrix_init", libcairo.}
proc cairoMatrixInitIdentity*(matrix: ptr Matrix00) {.
    importc: "cairo_matrix_init_identity", libcairo.}
proc cairoMatrixInitTranslate*(matrix: ptr Matrix00; tx: cdouble; ty: cdouble) {.
    importc: "cairo_matrix_init_translate", libcairo.}
proc cairoMatrixInitScale*(matrix: ptr Matrix00; sx: cdouble; sy: cdouble) {.
    importc: "cairo_matrix_init_scale", libcairo.}
proc cairoMatrixInitRotate*(matrix: ptr Matrix00; radians: cdouble) {.
    importc: "cairo_matrix_init_rotate", libcairo.}
proc cairoMatrixTranslate*(matrix: ptr Matrix00; tx: cdouble; ty: cdouble) {.
    importc: "cairo_matrix_translate", libcairo.}
proc cairoMatrixScale*(matrix: ptr Matrix00; sx: cdouble; sy: cdouble) {.
    importc: "cairo_matrix_scale", libcairo.}
proc cairoMatrixRotate*(matrix: ptr Matrix00; radians: cdouble) {.
    importc: "cairo_matrix_rotate", libcairo.}
proc cairoMatrixInvert*(matrix: ptr Matrix00): Status {.
    importc: "cairo_matrix_invert", libcairo.}
proc cairoMatrixMultiply*(result: ptr Matrix00; a: ptr Matrix00;
                         b: ptr Matrix00) {.importc: "cairo_matrix_multiply",
    libcairo.}
proc cairoMatrixTransformDistance*(matrix: ptr Matrix00; dx: var cdouble;
                                  dy: var cdouble) {.
    importc: "cairo_matrix_transform_distance", libcairo.}
proc cairoMatrixTransformPoint*(matrix: ptr Matrix00; x: var cdouble;
                               y: var cdouble) {.
    importc: "cairo_matrix_transform_point", libcairo.}

type
  RegionOverlap* {.size: sizeof(cint), pure.} = enum
    `in`, `out`, part

proc cairoRegionCreate*(): ptr Region00 {.importc: "cairo_region_create",
    libcairo.}
proc cairoRegionCreateRectangle*(rectangle: ptr RectangleInt00): ptr Region00 {.
    importc: "cairo_region_create_rectangle", libcairo.}
proc cairoRegionCreateRectangles*(rects: ptr RectangleInt00; count: cint): ptr Region00 {.
    importc: "cairo_region_create_rectangles", libcairo.}
proc cairoRegionCopy*(original: ptr Region00): ptr Region00 {.
    importc: "cairo_region_copy", libcairo.}
proc cairoRegionReference*(region: ptr Region00): ptr Region00 {.
    importc: "cairo_region_reference", libcairo.}
proc cairoRegionDestroy*(region: ptr Region00) {.
    importc: "cairo_region_destroy", libcairo.}
proc cairoRegionEqual*(a: ptr Region00; b: ptr Region00): Bool00 {.
    importc: "cairo_region_equal", libcairo.}
proc cairoRegionStatus*(region: ptr Region00): Status {.
    importc: "cairo_region_status", libcairo.}
proc cairoRegionGetExtents*(region: ptr Region00;
                           extents: ptr RectangleInt00) {.
    importc: "cairo_region_get_extents", libcairo.}
proc cairoRegionNumRectangles*(region: ptr Region00): cint {.
    importc: "cairo_region_num_rectangles", libcairo.}
proc cairoRegionGetRectangle*(region: ptr Region00; nth: cint;
                             rectangle: ptr RectangleInt00) {.
    importc: "cairo_region_get_rectangle", libcairo.}
proc cairoRegionIsEmpty*(region: ptr Region00): Bool00 {.
    importc: "cairo_region_is_empty", libcairo.}
proc cairoRegionContainsRectangle*(region: ptr Region00;
                                  rectangle: ptr RectangleInt00): RegionOverlap {.
    importc: "cairo_region_contains_rectangle", libcairo.}
proc cairoRegionContainsPoint*(region: ptr Region00; x: cint; y: cint): Bool00 {.
    importc: "cairo_region_contains_point", libcairo.}
proc cairoRegionTranslate*(region: ptr Region00; dx: cint; dy: cint) {.
    importc: "cairo_region_translate", libcairo.}
proc cairoRegionSubtract*(dst: ptr Region00; other: ptr Region00): Status {.
    importc: "cairo_region_subtract", libcairo.}
proc cairoRegionSubtractRectangle*(dst: ptr Region00;
                                  rectangle: ptr RectangleInt00): Status {.
    importc: "cairo_region_subtract_rectangle", libcairo.}
proc cairoRegionIntersect*(dst: ptr Region00; other: ptr Region00): Status {.
    importc: "cairo_region_intersect", libcairo.}
proc cairoRegionIntersectRectangle*(dst: ptr Region00;
                                   rectangle: ptr RectangleInt00): Status {.
    importc: "cairo_region_intersect_rectangle", libcairo.}
proc cairoRegionUnion*(dst: ptr Region00; other: ptr Region00): Status {.
    importc: "cairo_region_union", libcairo.}
proc cairoRegionUnionRectangle*(dst: ptr Region00;
                               rectangle: ptr RectangleInt00): Status {.
    importc: "cairo_region_union_rectangle", libcairo.}
proc cairoRegionXor*(dst: ptr Region00; other: ptr Region00): Status {.
    importc: "cairo_region_xor", libcairo.}
proc cairoRegionXorRectangle*(dst: ptr Region00;
                             rectangle: ptr RectangleInt00): Status {.
    importc: "cairo_region_xor_rectangle", libcairo.}

proc cairoDebugResetStaticData*() {.importc: "cairo_debug_reset_static_data",
                                  libcairo.}

when CAIRO_HAS_PDF_SURFACE:
  type
    PdfVersion* {.size: sizeof(cint), pure.} = enum
      v1_4, v1_5
  proc cairoPdfSurfaceCreate*(filename: cstring; widthInPoints: cdouble;
                             heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_pdf_surface_create", libcairo.}
  proc cairoPdfSurfaceCreateForStream*(writeFunc: WriteFunc00;
                                      closure: pointer; widthInPoints: cdouble;
                                      heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_pdf_surface_create_for_stream", libcairo.}
  proc cairoPdfSurfaceRestrictToVersion*(surface: ptr Surface00;
                                        version: PdfVersion) {.
      importc: "cairo_pdf_surface_restrict_to_version", libcairo.}
  proc cairoPdfGetVersions*(versions: ptr ptr PdfVersion; numVersions: var cint) {.
      importc: "cairo_pdf_get_versions", libcairo.}
  proc cairoPdfVersionToString*(version: PdfVersion): cstring {.
      importc: "cairo_pdf_version_to_string", libcairo.}
  proc cairoPdfSurfaceSetSize*(surface: ptr Surface00; widthInPoints: cdouble;
                              heightInPoints: cdouble) {.
      importc: "cairo_pdf_surface_set_size", libcairo.}
  type
    PdfOutlineFlags* {.size: sizeof(cint), pure.} = enum
      flag_open = 0x1,
      flag_bold = 0x2,
      flag_italic = 0x4
  const
    CAIRO_PDF_OUTLINE_ROOT* = 0
  proc cairoPdfSurfaceAddOutline*(surface: ptr Surface00; parentId: cint;
                                 utf8: cstring; dest: cstring;
                                 flags: PdfOutlineFlags): cint {.
      importc: "cairo_pdf_surface_add_outline", libcairo.}
  type
    PdfMetadata* {.size: sizeof(cint), pure.} = enum
      title, author,
      subject, keywords,
      creator, create_date,
      mod_date
  proc cairoPdfSurfaceSetMetadata*(surface: ptr Surface00;
                                  metadata: PdfMetadata; utf8: cstring) {.
      importc: "cairo_pdf_surface_set_metadata", libcairo.}
  proc cairoPdfSurfaceSetPageLabel*(surface: ptr Surface00; utf8: cstring) {.
      importc: "cairo_pdf_surface_set_page_label", libcairo.}
  proc cairoPdfSurfaceSetThumbnailSize*(surface: ptr Surface00; width: cint;
                                       height: cint) {.
      importc: "cairo_pdf_surface_set_thumbnail_size", libcairo.}

when CAIRO_HAS_PS_SURFACE:
  type
    PS_Level* {.size: sizeof(cint), pure.} = enum
      l2, l3
  proc cairoPsSurfaceCreate*(filename: cstring; widthInPoints: cdouble;
                            heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_ps_surface_create", libcairo.}
  proc cairoPsSurfaceCreateForStream*(writeFunc: WriteFunc00; closure: pointer;
                                     widthInPoints: cdouble;
                                     heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_ps_surface_create_for_stream", libcairo.}
  proc cairoPsSurfaceRestrictToLevel*(surface: ptr Surface00;
                                     level: PsLevel) {.
      importc: "cairo_ps_surface_restrict_to_level", libcairo.}
  proc cairoPsGetLevels*(levels: ptr ptr PsLevel; numLevels: var cint) {.
      importc: "cairo_ps_get_levels", libcairo.}
  proc cairoPsLevelToString*(level: PsLevel): cstring {.
      importc: "cairo_ps_level_to_string", libcairo.}
  proc cairoPsSurfaceSetEps*(surface: ptr Surface00; eps: Bool00) {.
      importc: "cairo_ps_surface_set_eps", libcairo.}
  proc cairoPsSurfaceGetEps*(surface: ptr Surface00): Bool00 {.
      importc: "cairo_ps_surface_get_eps", libcairo.}
  proc cairoPsSurfaceSetSize*(surface: ptr Surface00; widthInPoints: cdouble;
                             heightInPoints: cdouble) {.
      importc: "cairo_ps_surface_set_size", libcairo.}
  proc cairoPsSurfaceDscComment*(surface: ptr Surface00; comment: cstring) {.
      importc: "cairo_ps_surface_dsc_comment", libcairo.}
  proc cairoPsSurfaceDscBeginSetup*(surface: ptr Surface00) {.
      importc: "cairo_ps_surface_dsc_begin_setup", libcairo.}
  proc cairoPsSurfaceDscBeginPageSetup*(surface: ptr Surface00) {.
      importc: "cairo_ps_surface_dsc_begin_page_setup", libcairo.}

when CAIRO_HAS_SVG_SURFACE:
  type
    SvgVersion* {.size: sizeof(cint), pure.} = enum
      v1_1, v1_2
  proc cairoSvgSurfaceCreate*(filename: cstring; widthInPoints: cdouble;
                             heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_svg_surface_create", libcairo.}
  proc cairoSvgSurfaceCreateForStream*(writeFunc: WriteFunc00;
                                      closure: pointer; widthInPoints: cdouble;
                                      heightInPoints: cdouble): ptr Surface00 {.
      importc: "cairo_svg_surface_create_for_stream", libcairo.}
  proc cairoSvgSurfaceRestrictToVersion*(surface: ptr Surface00;
                                        version: SvgVersion) {.
      importc: "cairo_svg_surface_restrict_to_version", libcairo.}
  proc cairoSvgGetVersions*(versions: ptr ptr SvgVersion; numVersions: var cint) {.
      importc: "cairo_svg_get_versions", libcairo.}
  proc cairoSvgVersionToString*(version: SvgVersion): cstring {.
      importc: "cairo_svg_version_to_string", libcairo.}

when CAIRO_HAS_XML_SURFACE:
  proc cairoXmlCreate*(filename: cstring): ptr Device00 {.
      importc: "cairo_xml_create", libcairo.}
  proc cairoXmlCreateForStream*(writeFunc: WriteFunc00; closure: pointer): ptr Device00 {.
      importc: "cairo_xml_create_for_stream", libcairo.}
  proc cairoXmlSurfaceCreate*(xml: ptr Device00; content: Content;
                             width: cdouble; height: cdouble): ptr Surface00 {.
      importc: "cairo_xml_surface_create", libcairo.}
  proc cairoXmlForRecordingSurface*(xml: ptr Device00;
                                   surface: ptr Surface00): Status {.
      importc: "cairo_xml_for_recording_surface", libcairo.}

when CAIRO_HAS_SCRIPT_SURFACE:
  type
    ScriptMode* {.size: sizeof(cint), pure.} = enum
      ascii, binary
  proc cairoScriptCreate*(filename: cstring): ptr Device00 {.
      importc: "cairo_script_create", libcairo.}
  proc cairoScriptCreateForStream*(writeFunc: WriteFunc00; closure: pointer): ptr Device00 {.
      importc: "cairo_script_create_for_stream", libcairo.}
  proc cairoScriptWriteComment*(script: ptr Device00; comment: cstring; len: cint) {.
      importc: "cairo_script_write_comment", libcairo.}
  proc cairoScriptSetMode*(script: ptr Device00; mode: ScriptMode) {.
      importc: "cairo_script_set_mode", libcairo.}
  proc cairoScriptGetMode*(script: ptr Device00): ScriptMode {.
      importc: "cairo_script_get_mode", libcairo.}
  proc cairoScriptSurfaceCreate*(script: ptr Device00; content: Content;
                                width: cdouble; height: cdouble): ptr Surface00 {.
      importc: "cairo_script_surface_create", libcairo.}
  proc cairoScriptSurfaceCreateForTarget*(script: ptr Device00;
      target: ptr Surface00): ptr Surface00 {.
      importc: "cairo_script_surface_create_for_target", libcairo.}
  proc cairoScriptFromRecordingSurface*(script: ptr Device00;
                                       recordingSurface: ptr Surface00): Status {.
      importc: "cairo_script_from_recording_surface", libcairo.}

when CAIRO_HAS_SKIA_SURFACE:
  proc cairoSkiaSurfaceCreate*(format: Format; width: cint; height: cint): ptr Surface00 {.
      importc: "cairo_skia_surface_create", libcairo.}
  proc cairoSkiaSurfaceCreateForData*(data: ptr cuchar; format: Format;
                                     width: cint; height: cint; stride: cint): ptr Surface00 {.
      importc: "cairo_skia_surface_create_for_data", libcairo.}

when CAIRO_HAS_DRM_SURFACE:
  type
    UdevDevice* = object
  proc cairoDrmDeviceGet*(device: ptr UdevDevice): ptr Device00 {.
      importc: "cairo_drm_device_get", libcairo.}
  proc cairoDrmDeviceGetForFd*(fd: cint): ptr Device00 {.
      importc: "cairo_drm_device_get_for_fd", libcairo.}
  proc cairoDrmDeviceDefault*(): ptr Device00 {.
      importc: "cairo_drm_device_default", libcairo.}
  proc cairoDrmDeviceGetFd*(device: ptr Device00): cint {.
      importc: "cairo_drm_device_get_fd", libcairo.}
  proc cairoDrmDeviceThrottle*(device: ptr Device00) {.
      importc: "cairo_drm_device_throttle", libcairo.}
  proc cairoDrmSurfaceCreate*(device: ptr Device00; format: Format;
                             width: cint; height: cint): ptr Surface00 {.
      importc: "cairo_drm_surface_create", libcairo.}
  proc cairoDrmSurfaceCreateForName*(device: ptr Device00; name: cuint;
                                    format: Format; width: cint; height: cint;
                                    stride: cint): ptr Surface00 {.
      importc: "cairo_drm_surface_create_for_name", libcairo.}
  proc cairoDrmSurfaceCreateFromCacheableImage*(device: ptr Device00;
      surface: ptr Surface00): ptr Surface00 {.
      importc: "cairo_drm_surface_create_from_cacheable_image", libcairo.}
  proc cairoDrmSurfaceEnableScanOut*(surface: ptr Surface00): Status {.
      importc: "cairo_drm_surface_enable_scan_out", libcairo.}
  proc cairoDrmSurfaceGetHandle*(surface: ptr Surface00): cuint {.
      importc: "cairo_drm_surface_get_handle", libcairo.}
  proc cairoDrmSurfaceGetName*(surface: ptr Surface00): cuint {.
      importc: "cairo_drm_surface_get_name", libcairo.}
  proc cairoDrmSurfaceGetFormat*(surface: ptr Surface00): Format {.
      importc: "cairo_drm_surface_get_format", libcairo.}
  proc cairoDrmSurfaceGetWidth*(surface: ptr Surface00): cint {.
      importc: "cairo_drm_surface_get_width", libcairo.}
  proc cairoDrmSurfaceGetHeight*(surface: ptr Surface00): cint {.
      importc: "cairo_drm_surface_get_height", libcairo.}
  proc cairoDrmSurfaceGetStride*(surface: ptr Surface00): cint {.
      importc: "cairo_drm_surface_get_stride", libcairo.}
  proc cairoDrmSurfaceMapToImage*(surface: ptr Surface00): ptr Surface00 {.
      importc: "cairo_drm_surface_map_to_image", libcairo.}
  proc cairoDrmSurfaceUnmap*(drmSurface: ptr Surface00;
                            imageSurface: ptr Surface00) {.
      importc: "cairo_drm_surface_unmap", libcairo.}

when CAIRO_HAS_TEE_SURFACE:
  proc cairoTeeSurfaceCreate*(master: ptr Surface00): ptr Surface00 {.
      importc: "cairo_tee_surface_create", libcairo.}
  proc cairoTeeSurfaceAdd*(surface: ptr Surface00; target: ptr Surface00) {.
      importc: "cairo_tee_surface_add", libcairo.}
  proc cairoTeeSurfaceRemove*(surface: ptr Surface00; target: ptr Surface00) {.
      importc: "cairo_tee_surface_remove", libcairo.}
  proc cairoTeeSurfaceIndex*(surface: ptr Surface00; index: cuint): ptr Surface00 {.
      importc: "cairo_tee_surface_index", libcairo.}


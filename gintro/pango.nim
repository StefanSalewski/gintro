# dependencies:
# cairo-1.0
# GLib-2.0
# GObject-2.0
# immediate dependencies:
# cairo-1.0
# GObject-2.0
# libraries:
# libpango-1.0.so.0
{.deadCodeElim: on.}
import cairo, glib, gobject
const Lib* = "libpango-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  GlyphInfo00Array* = pointer
type
  LogAttr00Array* = pointer
type
  FontDescription00Array* = pointer
type
  FontFamily00Array* = pointer
type
  FontFace00Array* = pointer
type
  ScriptArray* = pointer
let Quark = g_quark_from_static_string("NimGIQuark")

const ANALYSIS_FLAG_CENTERED_BASELINE* = 1'i32

const ANALYSIS_FLAG_IS_ELLIPSIS* = 2'i32

const ATTR_INDEX_FROM_TEXT_BEGINNING* = 0'i32

type
  Alignment* {.size: sizeof(cint), pure.} = enum
    left = 0
    center = 1
    right = 2

type
  Engine* = ref object of gobject.Object
  Engine00* = object of gobject.Object00

type
  EngineShape* = ref object of Engine
  EngineShape00* = object of Engine00

type
  EngineLang* = ref object of Engine
  EngineLang00* = object of Engine00

type
  Font* = ref object of gobject.Object
  Font00* = object of gobject.Object00

type
  FontDescription00* {.pure.} = object
  FontDescription* = ref object
    impl*: ptr FontDescription00

proc pango_font_description_new*(): ptr FontDescription00 {.
    importc: "pango_font_description_new", libprag.}

proc newFontDescription*(): FontDescription =
  new(result)
  result.impl = pango_font_description_new()

proc initFontDescription*[T](result: var T) =
  assert(result is FontDescription)
  new(result)
  result.impl = pango_font_description_new()

proc pango_font_description_better_match*(self: ptr FontDescription00; oldMatch: ptr FontDescription00; 
    newMatch: ptr FontDescription00): gboolean {.
    importc: "pango_font_description_better_match", libprag.}

proc betterMatch*(self: FontDescription; oldMatch: FontDescription; 
    newMatch: FontDescription): bool =
  toBool(pango_font_description_better_match(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](oldMatch.impl), cast[ptr FontDescription00](newMatch.impl)))

proc pango_font_description_copy*(self: ptr FontDescription00): ptr FontDescription00 {.
    importc: "pango_font_description_copy", libprag.}

proc copy*(self: FontDescription): FontDescription =
  new(result)
  result.impl = pango_font_description_copy(cast[ptr FontDescription00](self.impl))

proc pango_font_description_copy_static*(self: ptr FontDescription00): ptr FontDescription00 {.
    importc: "pango_font_description_copy_static", libprag.}

proc copyStatic*(self: FontDescription): FontDescription =
  new(result)
  result.impl = pango_font_description_copy_static(cast[ptr FontDescription00](self.impl))

proc pango_font_description_equal*(self: ptr FontDescription00; desc2: ptr FontDescription00): gboolean {.
    importc: "pango_font_description_equal", libprag.}

proc equal*(self: FontDescription; desc2: FontDescription): bool =
  toBool(pango_font_description_equal(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](desc2.impl)))

proc pango_font_description_free*(self: ptr FontDescription00) {.
    importc: "pango_font_description_free", libprag.}

proc free*(self: FontDescription) =
  pango_font_description_free(cast[ptr FontDescription00](self.impl))

proc pango_font_description_get_family*(self: ptr FontDescription00): cstring {.
    importc: "pango_font_description_get_family", libprag.}

proc getFamily*(self: FontDescription): string =
  let resul0 = pango_font_description_get_family(cast[ptr FontDescription00](self.impl))
  result = $resul0

proc family*(self: FontDescription): string =
  let resul0 = pango_font_description_get_family(cast[ptr FontDescription00](self.impl))
  result = $resul0

proc pango_font_description_get_size*(self: ptr FontDescription00): int32 {.
    importc: "pango_font_description_get_size", libprag.}

proc getSize*(self: FontDescription): int =
  int(pango_font_description_get_size(cast[ptr FontDescription00](self.impl)))

proc size*(self: FontDescription): int =
  int(pango_font_description_get_size(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_get_size_is_absolute*(self: ptr FontDescription00): gboolean {.
    importc: "pango_font_description_get_size_is_absolute", libprag.}

proc getSizeIsAbsolute*(self: FontDescription): bool =
  toBool(pango_font_description_get_size_is_absolute(cast[ptr FontDescription00](self.impl)))

proc sizeIsAbsolute*(self: FontDescription): bool =
  toBool(pango_font_description_get_size_is_absolute(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_hash*(self: ptr FontDescription00): uint32 {.
    importc: "pango_font_description_hash", libprag.}

proc hash*(self: FontDescription): int =
  int(pango_font_description_hash(cast[ptr FontDescription00](self.impl)))

proc pango_font_description_merge*(self: ptr FontDescription00; descToMerge: ptr FontDescription00; 
    replaceExisting: gboolean) {.
    importc: "pango_font_description_merge", libprag.}

proc merge*(self: FontDescription; descToMerge: FontDescription; 
    replaceExisting: bool) =
  pango_font_description_merge(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](descToMerge.impl), gboolean(replaceExisting))

proc pango_font_description_merge_static*(self: ptr FontDescription00; descToMerge: ptr FontDescription00; 
    replaceExisting: gboolean) {.
    importc: "pango_font_description_merge_static", libprag.}

proc mergeStatic*(self: FontDescription; descToMerge: FontDescription; 
    replaceExisting: bool) =
  pango_font_description_merge_static(cast[ptr FontDescription00](self.impl), cast[ptr FontDescription00](descToMerge.impl), gboolean(replaceExisting))

proc pango_font_description_set_absolute_size*(self: ptr FontDescription00; size: cdouble) {.
    importc: "pango_font_description_set_absolute_size", libprag.}

proc setAbsoluteSize*(self: FontDescription; size: cdouble) =
  pango_font_description_set_absolute_size(cast[ptr FontDescription00](self.impl), size)

proc `absoluteSize=`*(self: FontDescription; size: cdouble) =
  pango_font_description_set_absolute_size(cast[ptr FontDescription00](self.impl), size)

proc pango_font_description_set_family*(self: ptr FontDescription00; family: cstring) {.
    importc: "pango_font_description_set_family", libprag.}

proc setFamily*(self: FontDescription; family: string) =
  pango_font_description_set_family(cast[ptr FontDescription00](self.impl), cstring(family))

proc `family=`*(self: FontDescription; family: string) =
  pango_font_description_set_family(cast[ptr FontDescription00](self.impl), cstring(family))

proc pango_font_description_set_family_static*(self: ptr FontDescription00; family: cstring) {.
    importc: "pango_font_description_set_family_static", libprag.}

proc setFamilyStatic*(self: FontDescription; family: string) =
  pango_font_description_set_family_static(cast[ptr FontDescription00](self.impl), cstring(family))

proc `familyStatic=`*(self: FontDescription; family: string) =
  pango_font_description_set_family_static(cast[ptr FontDescription00](self.impl), cstring(family))

proc pango_font_description_set_size*(self: ptr FontDescription00; size: int32) {.
    importc: "pango_font_description_set_size", libprag.}

proc setSize*(self: FontDescription; size: int) =
  pango_font_description_set_size(cast[ptr FontDescription00](self.impl), int32(size))

proc `size=`*(self: FontDescription; size: int) =
  pango_font_description_set_size(cast[ptr FontDescription00](self.impl), int32(size))

proc pango_font_description_to_filename*(self: ptr FontDescription00): cstring {.
    importc: "pango_font_description_to_filename", libprag.}

proc toFilename*(self: FontDescription): string =
  let resul0 = pango_font_description_to_filename(cast[ptr FontDescription00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pango_font_description_to_string*(self: ptr FontDescription00): cstring {.
    importc: "pango_font_description_to_string", libprag.}

proc toString*(self: FontDescription): string =
  let resul0 = pango_font_description_to_string(cast[ptr FontDescription00](self.impl))
  result = $resul0
  cogfree(resul0)

proc pango_font_description_from_string*(str: cstring): ptr FontDescription00 {.
    importc: "pango_font_description_from_string", libprag.}

proc fromString*(str: string): FontDescription =
  new(result)
  result.impl = pango_font_description_from_string(cstring(str))

proc pango_font_descriptions_free*(descs: ptr FontDescription00Array; nDescs: int32) {.
    importc: "pango_font_descriptions_free", libprag.}

proc descriptionsFree*(descs: ptr FontDescription00Array; nDescs: int32) {.
    importc: "pango_font_descriptions_free", libprag.}

proc pango_font_describe*(self: ptr Font00): ptr FontDescription00 {.
    importc: "pango_font_describe", libprag.}

proc describe*(self: Font): FontDescription =
  new(result)
  result.impl = pango_font_describe(cast[ptr Font00](self.impl))

proc pango_font_describe_with_absolute_size*(self: ptr Font00): ptr FontDescription00 {.
    importc: "pango_font_describe_with_absolute_size", libprag.}

proc describeWithAbsoluteSize*(self: Font): FontDescription =
  new(result)
  result.impl = pango_font_describe_with_absolute_size(cast[ptr Font00](self.impl))

type
  Gravity* {.size: sizeof(cint), pure.} = enum
    south = 0
    east = 1
    north = 2
    west = 3
    auto = 4

proc pango_gravity_to_rotation*(gravity: Gravity): cdouble {.
    importc: "pango_gravity_to_rotation", libprag.}

proc toRotation*(gravity: Gravity): cdouble {.
    importc: "pango_gravity_to_rotation", libprag.}

proc pango_font_description_get_gravity*(self: ptr FontDescription00): Gravity {.
    importc: "pango_font_description_get_gravity", libprag.}

proc getGravity*(self: FontDescription): Gravity =
  pango_font_description_get_gravity(cast[ptr FontDescription00](self.impl))

proc gravity*(self: FontDescription): Gravity =
  pango_font_description_get_gravity(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_gravity*(self: ptr FontDescription00; gravity: Gravity) {.
    importc: "pango_font_description_set_gravity", libprag.}

proc setGravity*(self: FontDescription; gravity: Gravity) =
  pango_font_description_set_gravity(cast[ptr FontDescription00](self.impl), gravity)

proc `gravity=`*(self: FontDescription; gravity: Gravity) =
  pango_font_description_set_gravity(cast[ptr FontDescription00](self.impl), gravity)

type
  Matrix00* {.pure.} = object
    xx*: cdouble
    xy*: cdouble
    yx*: cdouble
    yy*: cdouble
    x0*: cdouble
    y0*: cdouble
  Matrix* = ref object
    impl*: ptr Matrix00

proc pango_matrix_concat*(self: ptr Matrix00; newMatrix: ptr Matrix00) {.
    importc: "pango_matrix_concat", libprag.}

proc concat*(self: Matrix; newMatrix: Matrix) =
  pango_matrix_concat(cast[ptr Matrix00](self.impl), cast[ptr Matrix00](newMatrix.impl))

proc pango_matrix_copy*(self: ptr Matrix00): ptr Matrix00 {.
    importc: "pango_matrix_copy", libprag.}

proc copy*(self: Matrix): Matrix =
  new(result)
  result.impl = pango_matrix_copy(cast[ptr Matrix00](self.impl))

proc pango_matrix_free*(self: ptr Matrix00) {.
    importc: "pango_matrix_free", libprag.}

proc free*(self: Matrix) =
  pango_matrix_free(cast[ptr Matrix00](self.impl))

proc pango_matrix_get_font_scale_factor*(self: ptr Matrix00): cdouble {.
    importc: "pango_matrix_get_font_scale_factor", libprag.}

proc getFontScaleFactor*(self: Matrix): cdouble =
  pango_matrix_get_font_scale_factor(cast[ptr Matrix00](self.impl))

proc fontScaleFactor*(self: Matrix): cdouble =
  pango_matrix_get_font_scale_factor(cast[ptr Matrix00](self.impl))

proc pango_matrix_get_font_scale_factors*(self: ptr Matrix00; xscale: var cdouble; yscale: var cdouble) {.
    importc: "pango_matrix_get_font_scale_factors", libprag.}

proc getFontScaleFactors*(self: Matrix; xscale: var cdouble; yscale: var cdouble) =
  pango_matrix_get_font_scale_factors(cast[ptr Matrix00](self.impl), xscale, yscale)

proc fontScaleFactors*(self: Matrix; xscale: var cdouble; yscale: var cdouble) =
  pango_matrix_get_font_scale_factors(cast[ptr Matrix00](self.impl), xscale, yscale)

proc pango_matrix_rotate*(self: ptr Matrix00; degrees: cdouble) {.
    importc: "pango_matrix_rotate", libprag.}

proc rotate*(self: Matrix; degrees: cdouble) =
  pango_matrix_rotate(cast[ptr Matrix00](self.impl), degrees)

proc pango_matrix_scale*(self: ptr Matrix00; scaleX: cdouble; scaleY: cdouble) {.
    importc: "pango_matrix_scale", libprag.}

proc scale*(self: Matrix; scaleX: cdouble; scaleY: cdouble) =
  pango_matrix_scale(cast[ptr Matrix00](self.impl), scaleX, scaleY)

proc pango_matrix_transform_distance*(self: ptr Matrix00; dx: cdouble; dy: cdouble) {.
    importc: "pango_matrix_transform_distance", libprag.}

proc transformDistance*(self: Matrix; dx: cdouble; dy: cdouble) =
  pango_matrix_transform_distance(cast[ptr Matrix00](self.impl), dx, dy)

proc pango_matrix_transform_point*(self: ptr Matrix00; x: cdouble; y: cdouble) {.
    importc: "pango_matrix_transform_point", libprag.}

proc transformPoint*(self: Matrix; x: cdouble; y: cdouble) =
  pango_matrix_transform_point(cast[ptr Matrix00](self.impl), x, y)

proc pango_matrix_translate*(self: ptr Matrix00; tx: cdouble; ty: cdouble) {.
    importc: "pango_matrix_translate", libprag.}

proc translate*(self: Matrix; tx: cdouble; ty: cdouble) =
  pango_matrix_translate(cast[ptr Matrix00](self.impl), tx, ty)

proc pango_gravity_get_for_matrix*(matrix: ptr Matrix00): Gravity {.
    importc: "pango_gravity_get_for_matrix", libprag.}

proc getForMatrix*(matrix: Matrix): Gravity =
  pango_gravity_get_for_matrix(cast[ptr Matrix00](matrix.impl))

proc forMatrix*(matrix: Matrix): Gravity =
  pango_gravity_get_for_matrix(cast[ptr Matrix00](matrix.impl))

type
  Script* {.size: sizeof(cint), pure.} = enum
    invalidCode = -1
    common = 0
    inherited = 1
    arabic = 2
    armenian = 3
    bengali = 4
    bopomofo = 5
    cherokee = 6
    coptic = 7
    cyrillic = 8
    deseret = 9
    devanagari = 10
    ethiopic = 11
    georgian = 12
    gothic = 13
    greek = 14
    gujarati = 15
    gurmukhi = 16
    han = 17
    hangul = 18
    hebrew = 19
    hiragana = 20
    kannada = 21
    katakana = 22
    khmer = 23
    lao = 24
    latin = 25
    malayalam = 26
    mongolian = 27
    myanmar = 28
    ogham = 29
    oldItalic = 30
    oriya = 31
    runic = 32
    sinhala = 33
    syriac = 34
    tamil = 35
    telugu = 36
    thaana = 37
    thai = 38
    tibetan = 39
    canadianAboriginal = 40
    yi = 41
    tagalog = 42
    hanunoo = 43
    buhid = 44
    tagbanwa = 45
    braille = 46
    cypriot = 47
    limbu = 48
    osmanya = 49
    shavian = 50
    linearB = 51
    taiLe = 52
    ugaritic = 53
    newTaiLue = 54
    buginese = 55
    glagolitic = 56
    tifinagh = 57
    sylotiNagri = 58
    oldPersian = 59
    kharoshthi = 60
    unknown = 61
    balinese = 62
    cuneiform = 63
    phoenician = 64
    phagsPa = 65
    nko = 66
    kayahLi = 67
    lepcha = 68
    rejang = 69
    sundanese = 70
    saurashtra = 71
    cham = 72
    olChiki = 73
    vai = 74
    carian = 75
    lycian = 76
    lydian = 77
    batak = 78
    brahmi = 79
    mandaic = 80
    chakma = 81
    meroiticCursive = 82
    meroiticHieroglyphs = 83
    miao = 84
    sharada = 85
    soraSompeng = 86
    takri = 87
    bassaVah = 88
    caucasianAlbanian = 89
    duployan = 90
    elbasan = 91
    grantha = 92
    khojki = 93
    khudawadi = 94
    linearA = 95
    mahajani = 96
    manichaean = 97
    mendeKikakui = 98
    modi = 99
    mro = 100
    nabataean = 101
    oldNorthArabian = 102
    oldPermic = 103
    pahawhHmong = 104
    palmyrene = 105
    pauCinHau = 106
    psalterPahlavi = 107
    siddham = 108
    tirhuta = 109
    warangCiti = 110
    ahom = 111
    anatolianHieroglyphs = 112
    hatran = 113
    multani = 114
    oldHungarian = 115
    signwriting = 116

proc pango_script_for_unichar*(ch: gunichar): Script {.
    importc: "pango_script_for_unichar", libprag.}

proc forUnichar*(ch: gunichar): Script {.
    importc: "pango_script_for_unichar", libprag.}

type
  GravityHint* {.size: sizeof(cint), pure.} = enum
    natural = 0
    strong = 1
    line = 2

proc pango_gravity_get_for_script*(script: Script; baseGravity: Gravity; hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script", libprag.}

proc getForScript*(script: Script; baseGravity: Gravity; hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script", libprag.}

proc forScript*(script: Script; baseGravity: Gravity; hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script", libprag.}

proc pango_gravity_get_for_script_and_width*(script: Script; wide: gboolean; baseGravity: Gravity; 
    hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script_and_width", libprag.}

proc getForScriptAndWidth*(script: Script; wide: gboolean; baseGravity: Gravity; 
    hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script_and_width", libprag.}

proc forScriptAndWidth*(script: Script; wide: gboolean; baseGravity: Gravity; 
    hint: GravityHint): Gravity {.
    importc: "pango_gravity_get_for_script_and_width", libprag.}

type
  Stretch* {.size: sizeof(cint), pure.} = enum
    ultraCondensed = 0
    extraCondensed = 1
    condensed = 2
    semiCondensed = 3
    normal = 4
    semiExpanded = 5
    expanded = 6
    extraExpanded = 7
    ultraExpanded = 8

proc pango_font_description_get_stretch*(self: ptr FontDescription00): Stretch {.
    importc: "pango_font_description_get_stretch", libprag.}

proc getStretch*(self: FontDescription): Stretch =
  pango_font_description_get_stretch(cast[ptr FontDescription00](self.impl))

proc stretch*(self: FontDescription): Stretch =
  pango_font_description_get_stretch(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_stretch*(self: ptr FontDescription00; stretch: Stretch) {.
    importc: "pango_font_description_set_stretch", libprag.}

proc setStretch*(self: FontDescription; stretch: Stretch) =
  pango_font_description_set_stretch(cast[ptr FontDescription00](self.impl), stretch)

proc `stretch=`*(self: FontDescription; stretch: Stretch) =
  pango_font_description_set_stretch(cast[ptr FontDescription00](self.impl), stretch)

type
  Style* {.size: sizeof(cint), pure.} = enum
    normal = 0
    oblique = 1
    italic = 2

proc pango_font_description_get_style*(self: ptr FontDescription00): Style {.
    importc: "pango_font_description_get_style", libprag.}

proc getStyle*(self: FontDescription): Style =
  pango_font_description_get_style(cast[ptr FontDescription00](self.impl))

proc style*(self: FontDescription): Style =
  pango_font_description_get_style(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_style*(self: ptr FontDescription00; style: Style) {.
    importc: "pango_font_description_set_style", libprag.}

proc setStyle*(self: FontDescription; style: Style) =
  pango_font_description_set_style(cast[ptr FontDescription00](self.impl), style)

proc `style=`*(self: FontDescription; style: Style) =
  pango_font_description_set_style(cast[ptr FontDescription00](self.impl), style)

type
  Variant* {.size: sizeof(cint), pure.} = enum
    normal = 0
    smallCaps = 1

proc pango_font_description_get_variant*(self: ptr FontDescription00): Variant {.
    importc: "pango_font_description_get_variant", libprag.}

proc getVariant*(self: FontDescription): Variant =
  pango_font_description_get_variant(cast[ptr FontDescription00](self.impl))

proc variant*(self: FontDescription): Variant =
  pango_font_description_get_variant(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_variant*(self: ptr FontDescription00; variant: Variant) {.
    importc: "pango_font_description_set_variant", libprag.}

proc setVariant*(self: FontDescription; variant: Variant) =
  pango_font_description_set_variant(cast[ptr FontDescription00](self.impl), variant)

proc `variant=`*(self: FontDescription; variant: Variant) =
  pango_font_description_set_variant(cast[ptr FontDescription00](self.impl), variant)

type
  Weight* {.size: sizeof(cint), pure.} = enum
    thin = 100
    ultralight = 200
    light = 300
    semilight = 350
    book = 380
    normal = 400
    medium = 500
    semibold = 600
    bold = 700
    ultrabold = 800
    heavy = 900
    ultraheavy = 1000

proc pango_font_description_get_weight*(self: ptr FontDescription00): Weight {.
    importc: "pango_font_description_get_weight", libprag.}

proc getWeight*(self: FontDescription): Weight =
  pango_font_description_get_weight(cast[ptr FontDescription00](self.impl))

proc weight*(self: FontDescription): Weight =
  pango_font_description_get_weight(cast[ptr FontDescription00](self.impl))

proc pango_font_description_set_weight*(self: ptr FontDescription00; weight: Weight) {.
    importc: "pango_font_description_set_weight", libprag.}

proc setWeight*(self: FontDescription; weight: Weight) =
  pango_font_description_set_weight(cast[ptr FontDescription00](self.impl), weight)

proc `weight=`*(self: FontDescription; weight: Weight) =
  pango_font_description_set_weight(cast[ptr FontDescription00](self.impl), weight)

type
  FontMask* {.size: sizeof(cint), pure.} = enum
    family = 1
    style = 2
    variant = 4
    weight = 8
    stretch = 16
    size = 32
    gravity = 64

proc pango_font_description_get_set_fields*(self: ptr FontDescription00): FontMask {.
    importc: "pango_font_description_get_set_fields", libprag.}

proc getSetFields*(self: FontDescription): FontMask =
  pango_font_description_get_set_fields(cast[ptr FontDescription00](self.impl))

proc `fields=`*(self: FontDescription): FontMask =
  pango_font_description_get_set_fields(cast[ptr FontDescription00](self.impl))

proc pango_font_description_unset_fields*(self: ptr FontDescription00; toUnset: FontMask) {.
    importc: "pango_font_description_unset_fields", libprag.}

proc unsetFields*(self: FontDescription; toUnset: FontMask) =
  pango_font_description_unset_fields(cast[ptr FontDescription00](self.impl), toUnset)

type
  FontMap* = ref object of gobject.Object
  FontMap00* = object of gobject.Object00

proc pango_font_map_changed*(self: ptr FontMap00) {.
    importc: "pango_font_map_changed", libprag.}

proc changed*(self: FontMap) =
  pango_font_map_changed(cast[ptr FontMap00](self.impl))

proc pango_font_map_get_serial*(self: ptr FontMap00): uint32 {.
    importc: "pango_font_map_get_serial", libprag.}

proc getSerial*(self: FontMap): int =
  int(pango_font_map_get_serial(cast[ptr FontMap00](self.impl)))

proc serial*(self: FontMap): int =
  int(pango_font_map_get_serial(cast[ptr FontMap00](self.impl)))

proc pango_font_map_get_shape_engine_type*(self: ptr FontMap00): cstring {.
    importc: "pango_font_map_get_shape_engine_type", libprag.}

proc getShapeEngineType*(self: FontMap): string =
  let resul0 = pango_font_map_get_shape_engine_type(cast[ptr FontMap00](self.impl))
  result = $resul0

proc shapeEngineType*(self: FontMap): string =
  let resul0 = pango_font_map_get_shape_engine_type(cast[ptr FontMap00](self.impl))
  result = $resul0

proc pango_font_get_font_map*(self: ptr Font00): ptr FontMap00 {.
    importc: "pango_font_get_font_map", libprag.}

proc getFontMap*(self: Font): FontMap =
  let gobj = pango_font_get_font_map(cast[ptr Font00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FontMap](g_object_get_qdata(gobj, Quark))
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

proc fontMap*(self: Font): FontMap =
  let gobj = pango_font_get_font_map(cast[ptr Font00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FontMap](g_object_get_qdata(gobj, Quark))
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
  FontFamily* = ref object of gobject.Object
  FontFamily00* = object of gobject.Object00

proc pango_font_family_get_name*(self: ptr FontFamily00): cstring {.
    importc: "pango_font_family_get_name", libprag.}

proc getName*(self: FontFamily): string =
  let resul0 = pango_font_family_get_name(cast[ptr FontFamily00](self.impl))
  result = $resul0

proc name*(self: FontFamily): string =
  let resul0 = pango_font_family_get_name(cast[ptr FontFamily00](self.impl))
  result = $resul0

proc pango_font_family_is_monospace*(self: ptr FontFamily00): gboolean {.
    importc: "pango_font_family_is_monospace", libprag.}

proc isMonospace*(self: FontFamily): bool =
  toBool(pango_font_family_is_monospace(cast[ptr FontFamily00](self.impl)))

proc pango_font_map_list_families*(self: ptr FontMap00; families: var ptr FontFamily00Array; 
    nFamilies: var int32) {.
    importc: "pango_font_map_list_families", libprag.}

proc listFamilies*(self: FontMap; families: var ptr FontFamily00Array; 
    nFamilies: var int) =
  var nFamilies_00 = int32(nFamilies)
  pango_font_map_list_families(cast[ptr FontMap00](self.impl), families, nFamilies_00)
  nFamilies = int(nFamilies_00)

type
  FontFace* = ref object of gobject.Object
  FontFace00* = object of gobject.Object00

proc pango_font_face_describe*(self: ptr FontFace00): ptr FontDescription00 {.
    importc: "pango_font_face_describe", libprag.}

proc describe*(self: FontFace): FontDescription =
  new(result)
  result.impl = pango_font_face_describe(cast[ptr FontFace00](self.impl))

proc pango_font_face_get_face_name*(self: ptr FontFace00): cstring {.
    importc: "pango_font_face_get_face_name", libprag.}

proc getFaceName*(self: FontFace): string =
  let resul0 = pango_font_face_get_face_name(cast[ptr FontFace00](self.impl))
  result = $resul0

proc faceName*(self: FontFace): string =
  let resul0 = pango_font_face_get_face_name(cast[ptr FontFace00](self.impl))
  result = $resul0

proc pango_font_face_is_synthesized*(self: ptr FontFace00): gboolean {.
    importc: "pango_font_face_is_synthesized", libprag.}

proc isSynthesized*(self: FontFace): bool =
  toBool(pango_font_face_is_synthesized(cast[ptr FontFace00](self.impl)))

proc pango_font_face_list_sizes*(self: ptr FontFace00; sizes: var int32Array; nSizes: var int32) {.
    importc: "pango_font_face_list_sizes", libprag.}

proc listSizes*(self: FontFace; sizes: var int32Array; nSizes: var int) =
  var nSizes_00 = int32(nSizes)
  pango_font_face_list_sizes(cast[ptr FontFace00](self.impl), sizes, nSizes_00)
  nSizes = int(nSizes_00)

proc pango_font_family_list_faces*(self: ptr FontFamily00; faces: var ptr FontFace00Array; 
    nFaces: var int32) {.
    importc: "pango_font_family_list_faces", libprag.}

proc listFaces*(self: FontFamily; faces: var ptr FontFace00Array; 
    nFaces: var int) =
  var nFaces_00 = int32(nFaces)
  pango_font_family_list_faces(cast[ptr FontFamily00](self.impl), faces, nFaces_00)
  nFaces = int(nFaces_00)

type
  Context* = ref object of gobject.Object
  Context00* = object of gobject.Object00

proc pango_context_new*(): ptr Context00 {.
    importc: "pango_context_new", libprag.}

proc newContext*(): Context =
  new(result, finalizeGObject)
  result.impl = pango_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initContext*[T](result: var T) =
  assert(result is Context)
  new(result, finalizeGObject)
  result.impl = pango_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_context_changed*(self: ptr Context00) {.
    importc: "pango_context_changed", libprag.}

proc changed*(self: Context) =
  pango_context_changed(cast[ptr Context00](self.impl))

proc pango_context_get_base_gravity*(self: ptr Context00): Gravity {.
    importc: "pango_context_get_base_gravity", libprag.}

proc getBaseGravity*(self: Context): Gravity =
  pango_context_get_base_gravity(cast[ptr Context00](self.impl))

proc baseGravity*(self: Context): Gravity =
  pango_context_get_base_gravity(cast[ptr Context00](self.impl))

proc pango_context_get_font_description*(self: ptr Context00): ptr FontDescription00 {.
    importc: "pango_context_get_font_description", libprag.}

proc getFontDescription*(self: Context): FontDescription =
  new(result)
  result.impl = pango_context_get_font_description(cast[ptr Context00](self.impl))

proc fontDescription*(self: Context): FontDescription =
  new(result)
  result.impl = pango_context_get_font_description(cast[ptr Context00](self.impl))

proc pango_context_get_font_map*(self: ptr Context00): ptr FontMap00 {.
    importc: "pango_context_get_font_map", libprag.}

proc getFontMap*(self: Context): FontMap =
  let gobj = pango_context_get_font_map(cast[ptr Context00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FontMap](g_object_get_qdata(gobj, Quark))
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

proc fontMap*(self: Context): FontMap =
  let gobj = pango_context_get_font_map(cast[ptr Context00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FontMap](g_object_get_qdata(gobj, Quark))
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

proc pango_context_get_gravity*(self: ptr Context00): Gravity {.
    importc: "pango_context_get_gravity", libprag.}

proc getGravity*(self: Context): Gravity =
  pango_context_get_gravity(cast[ptr Context00](self.impl))

proc gravity*(self: Context): Gravity =
  pango_context_get_gravity(cast[ptr Context00](self.impl))

proc pango_context_get_gravity_hint*(self: ptr Context00): GravityHint {.
    importc: "pango_context_get_gravity_hint", libprag.}

proc getGravityHint*(self: Context): GravityHint =
  pango_context_get_gravity_hint(cast[ptr Context00](self.impl))

proc gravityHint*(self: Context): GravityHint =
  pango_context_get_gravity_hint(cast[ptr Context00](self.impl))

proc pango_context_get_matrix*(self: ptr Context00): ptr Matrix00 {.
    importc: "pango_context_get_matrix", libprag.}

proc getMatrix*(self: Context): Matrix =
  new(result)
  result.impl = pango_context_get_matrix(cast[ptr Context00](self.impl))

proc matrix*(self: Context): Matrix =
  new(result)
  result.impl = pango_context_get_matrix(cast[ptr Context00](self.impl))

proc pango_context_get_serial*(self: ptr Context00): uint32 {.
    importc: "pango_context_get_serial", libprag.}

proc getSerial*(self: Context): int =
  int(pango_context_get_serial(cast[ptr Context00](self.impl)))

proc serial*(self: Context): int =
  int(pango_context_get_serial(cast[ptr Context00](self.impl)))

proc pango_context_list_families*(self: ptr Context00; families: var ptr FontFamily00Array; 
    nFamilies: var int32) {.
    importc: "pango_context_list_families", libprag.}

proc listFamilies*(self: Context; families: var ptr FontFamily00Array; 
    nFamilies: var int) =
  var nFamilies_00 = int32(nFamilies)
  pango_context_list_families(cast[ptr Context00](self.impl), families, nFamilies_00)
  nFamilies = int(nFamilies_00)

proc pango_context_load_font*(self: ptr Context00; desc: ptr FontDescription00): ptr Font00 {.
    importc: "pango_context_load_font", libprag.}

proc loadFont*(self: Context; desc: FontDescription): Font =
  let gobj = pango_context_load_font(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Font](g_object_get_qdata(gobj, Quark))
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

proc pango_context_set_base_gravity*(self: ptr Context00; gravity: Gravity) {.
    importc: "pango_context_set_base_gravity", libprag.}

proc setBaseGravity*(self: Context; gravity: Gravity) =
  pango_context_set_base_gravity(cast[ptr Context00](self.impl), gravity)

proc `baseGravity=`*(self: Context; gravity: Gravity) =
  pango_context_set_base_gravity(cast[ptr Context00](self.impl), gravity)

proc pango_context_set_font_description*(self: ptr Context00; desc: ptr FontDescription00) {.
    importc: "pango_context_set_font_description", libprag.}

proc setFontDescription*(self: Context; desc: FontDescription) =
  pango_context_set_font_description(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))

proc `fontDescription=`*(self: Context; desc: FontDescription) =
  pango_context_set_font_description(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl))

proc pango_context_set_font_map*(self: ptr Context00; fontMap: ptr FontMap00) {.
    importc: "pango_context_set_font_map", libprag.}

proc setFontMap*(self: Context; fontMap: FontMap) =
  pango_context_set_font_map(cast[ptr Context00](self.impl), cast[ptr FontMap00](fontMap.impl))

proc `fontMap=`*(self: Context; fontMap: FontMap) =
  pango_context_set_font_map(cast[ptr Context00](self.impl), cast[ptr FontMap00](fontMap.impl))

proc pango_context_set_gravity_hint*(self: ptr Context00; hint: GravityHint) {.
    importc: "pango_context_set_gravity_hint", libprag.}

proc setGravityHint*(self: Context; hint: GravityHint) =
  pango_context_set_gravity_hint(cast[ptr Context00](self.impl), hint)

proc `gravityHint=`*(self: Context; hint: GravityHint) =
  pango_context_set_gravity_hint(cast[ptr Context00](self.impl), hint)

proc pango_context_set_matrix*(self: ptr Context00; matrix: ptr Matrix00) {.
    importc: "pango_context_set_matrix", libprag.}

proc setMatrix*(self: Context; matrix: Matrix) =
  pango_context_set_matrix(cast[ptr Context00](self.impl), cast[ptr Matrix00](matrix.impl))

proc `matrix=`*(self: Context; matrix: Matrix) =
  pango_context_set_matrix(cast[ptr Context00](self.impl), cast[ptr Matrix00](matrix.impl))

proc pango_font_map_create_context*(self: ptr FontMap00): ptr Context00 {.
    importc: "pango_font_map_create_context", libprag.}

proc createContext*(self: FontMap): Context =
  let gobj = pango_font_map_create_context(cast[ptr FontMap00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Context](g_object_get_qdata(gobj, Quark))
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

proc pango_font_map_load_font*(self: ptr FontMap00; context: ptr Context00; desc: ptr FontDescription00): ptr Font00 {.
    importc: "pango_font_map_load_font", libprag.}

proc loadFont*(self: FontMap; context: Context; desc: FontDescription): Font =
  let gobj = pango_font_map_load_font(cast[ptr FontMap00](self.impl), cast[ptr Context00](context.impl), cast[ptr FontDescription00](desc.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Font](g_object_get_qdata(gobj, Quark))
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
  Direction* {.size: sizeof(cint), pure.} = enum
    ltr = 0
    rtl = 1
    ttbLtr = 2
    ttbRtl = 3
    weakLtr = 4
    weakRtl = 5
    neutral = 6

proc pango_context_get_base_dir*(self: ptr Context00): Direction {.
    importc: "pango_context_get_base_dir", libprag.}

proc getBaseDir*(self: Context): Direction =
  pango_context_get_base_dir(cast[ptr Context00](self.impl))

proc baseDir*(self: Context): Direction =
  pango_context_get_base_dir(cast[ptr Context00](self.impl))

proc pango_context_set_base_dir*(self: ptr Context00; direction: Direction) {.
    importc: "pango_context_set_base_dir", libprag.}

proc setBaseDir*(self: Context; direction: Direction) =
  pango_context_set_base_dir(cast[ptr Context00](self.impl), direction)

proc `baseDir=`*(self: Context; direction: Direction) =
  pango_context_set_base_dir(cast[ptr Context00](self.impl), direction)

type
  Rectangle00* {.pure.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  Rectangle* = ref object
    impl*: ptr Rectangle00

proc pango_font_get_glyph_extents*(self: ptr Font00; glyph: uint32; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_font_get_glyph_extents", libprag.}

proc getGlyphExtents*(self: ptr Font00; glyph: uint32; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_font_get_glyph_extents", libprag.}

proc glyphExtents*(self: ptr Font00; glyph: uint32; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_font_get_glyph_extents", libprag.}

proc pango_matrix_transform_pixel_rectangle*(self: ptr Matrix00; rect: Rectangle00) {.
    importc: "pango_matrix_transform_pixel_rectangle", libprag.}

proc transformPixelRectangle*(self: ptr Matrix00; rect: Rectangle00) {.
    importc: "pango_matrix_transform_pixel_rectangle", libprag.}

proc pango_matrix_transform_rectangle*(self: ptr Matrix00; rect: Rectangle00) {.
    importc: "pango_matrix_transform_rectangle", libprag.}

proc transformRectangle*(self: ptr Matrix00; rect: Rectangle00) {.
    importc: "pango_matrix_transform_rectangle", libprag.}

type
  Language00* {.pure.} = object
  Language* = ref object
    impl*: ptr Language00

proc pango_language_get_sample_string*(self: ptr Language00): cstring {.
    importc: "pango_language_get_sample_string", libprag.}

proc getSampleString*(self: Language): string =
  let resul0 = pango_language_get_sample_string(cast[ptr Language00](self.impl))
  result = $resul0

proc sampleString*(self: Language): string =
  let resul0 = pango_language_get_sample_string(cast[ptr Language00](self.impl))
  result = $resul0

proc pango_language_get_scripts*(self: ptr Language00; numScripts: var int32): ScriptArray {.
    importc: "pango_language_get_scripts", libprag.}

proc getScripts*(self: Language; numScripts: var int): ScriptArray =
  var numScripts_00 = int32(numScripts)
  result = pango_language_get_scripts(cast[ptr Language00](self.impl), numScripts_00)
  numScripts = int(numScripts_00)

proc scripts*(self: Language; numScripts: var int): ScriptArray =
  var numScripts_00 = int32(numScripts)
  result = pango_language_get_scripts(cast[ptr Language00](self.impl), numScripts_00)
  numScripts = int(numScripts_00)

proc pango_language_includes_script*(self: ptr Language00; script: Script): gboolean {.
    importc: "pango_language_includes_script", libprag.}

proc includesScript*(self: Language; script: Script): bool =
  toBool(pango_language_includes_script(cast[ptr Language00](self.impl), script))

proc pango_language_matches*(self: ptr Language00; rangeList: cstring): gboolean {.
    importc: "pango_language_matches", libprag.}

proc matches*(self: Language; rangeList: string): bool =
  toBool(pango_language_matches(cast[ptr Language00](self.impl), cstring(rangeList)))

proc pango_language_to_string*(self: ptr Language00): cstring {.
    importc: "pango_language_to_string", libprag.}

proc toString*(self: Language): string =
  let resul0 = pango_language_to_string(cast[ptr Language00](self.impl))
  result = $resul0

proc pango_language_from_string*(language: cstring): ptr Language00 {.
    importc: "pango_language_from_string", libprag.}

proc fromString*(language: string): Language =
  new(result)
  result.impl = pango_language_from_string(cstring(language))

proc pango_language_get_default*(): ptr Language00 {.
    importc: "pango_language_get_default", libprag.}

proc getDefault*(): Language =
  new(result)
  result.impl = pango_language_get_default()

proc default*(): Language =
  new(result)
  result.impl = pango_language_get_default()

type
  Analysis00* {.pure.} = object
    shapeEngine*: ptr EngineShape00
    langEngine*: ptr EngineLang00
    font*: ptr Font00
    level*: uint8
    gravity*: uint8
    flags*: uint8
    script*: uint8
    language*: ptr Language00
    extraAttrs*: ptr pointer
  Analysis* = ref object
    impl*: ptr Analysis00

proc pango_font_find_shaper*(self: ptr Font00; language: ptr Language00; ch: uint32): ptr EngineShape00 {.
    importc: "pango_font_find_shaper", libprag.}

proc findShaper*(self: Font; language: Language; ch: int): EngineShape =
  let gobj = pango_font_find_shaper(cast[ptr Font00](self.impl), cast[ptr Language00](language.impl), uint32(ch))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[EngineShape](g_object_get_qdata(gobj, Quark))
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

proc pango_script_get_sample_language*(script: Script): ptr Language00 {.
    importc: "pango_script_get_sample_language", libprag.}

proc getSampleLanguage*(script: Script): Language =
  new(result)
  result.impl = pango_script_get_sample_language(script)

proc sampleLanguage*(script: Script): Language =
  new(result)
  result.impl = pango_script_get_sample_language(script)

proc pango_context_get_language*(self: ptr Context00): ptr Language00 {.
    importc: "pango_context_get_language", libprag.}

proc getLanguage*(self: Context): Language =
  new(result)
  result.impl = pango_context_get_language(cast[ptr Context00](self.impl))

proc language*(self: Context): Language =
  new(result)
  result.impl = pango_context_get_language(cast[ptr Context00](self.impl))

proc pango_context_set_language*(self: ptr Context00; language: ptr Language00) {.
    importc: "pango_context_set_language", libprag.}

proc setLanguage*(self: Context; language: Language) =
  pango_context_set_language(cast[ptr Context00](self.impl), cast[ptr Language00](language.impl))

proc `language=`*(self: Context; language: Language) =
  pango_context_set_language(cast[ptr Context00](self.impl), cast[ptr Language00](language.impl))

type
  FontMetrics00* {.pure.} = object
    refCount*: uint32
    ascent*: int32
    descent*: int32
    approximateCharWidth*: int32
    approximateDigitWidth*: int32
    underlinePosition*: int32
    underlineThickness*: int32
    strikethroughPosition*: int32
    strikethroughThickness*: int32
  FontMetrics* = ref object
    impl*: ptr FontMetrics00

proc pango_font_metrics_new*(): ptr FontMetrics00 {.
    importc: "pango_font_metrics_new", libprag.}

proc newFontMetrics*(): FontMetrics =
  new(result)
  result.impl = pango_font_metrics_new()

proc initFontMetrics*[T](result: var T) =
  assert(result is FontMetrics)
  new(result)
  result.impl = pango_font_metrics_new()

proc pango_font_metrics_get_approximate_char_width*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_approximate_char_width", libprag.}

proc getApproximateCharWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_char_width(cast[ptr FontMetrics00](self.impl)))

proc approximateCharWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_char_width(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_approximate_digit_width*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_approximate_digit_width", libprag.}

proc getApproximateDigitWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_digit_width(cast[ptr FontMetrics00](self.impl)))

proc approximateDigitWidth*(self: FontMetrics): int =
  int(pango_font_metrics_get_approximate_digit_width(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_ascent*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_ascent", libprag.}

proc getAscent*(self: FontMetrics): int =
  int(pango_font_metrics_get_ascent(cast[ptr FontMetrics00](self.impl)))

proc ascent*(self: FontMetrics): int =
  int(pango_font_metrics_get_ascent(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_descent*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_descent", libprag.}

proc getDescent*(self: FontMetrics): int =
  int(pango_font_metrics_get_descent(cast[ptr FontMetrics00](self.impl)))

proc descent*(self: FontMetrics): int =
  int(pango_font_metrics_get_descent(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_strikethrough_position*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_strikethrough_position", libprag.}

proc getStrikethroughPosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_position(cast[ptr FontMetrics00](self.impl)))

proc strikethroughPosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_position(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_strikethrough_thickness*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_strikethrough_thickness", libprag.}

proc getStrikethroughThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_thickness(cast[ptr FontMetrics00](self.impl)))

proc strikethroughThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_strikethrough_thickness(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_underline_position*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_underline_position", libprag.}

proc getUnderlinePosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_position(cast[ptr FontMetrics00](self.impl)))

proc underlinePosition*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_position(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_get_underline_thickness*(self: ptr FontMetrics00): int32 {.
    importc: "pango_font_metrics_get_underline_thickness", libprag.}

proc getUnderlineThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_thickness(cast[ptr FontMetrics00](self.impl)))

proc underlineThickness*(self: FontMetrics): int =
  int(pango_font_metrics_get_underline_thickness(cast[ptr FontMetrics00](self.impl)))

proc pango_font_metrics_ref*(self: ptr FontMetrics00): ptr FontMetrics00 {.
    importc: "pango_font_metrics_ref", libprag.}

proc `ref`*(self: FontMetrics): FontMetrics =
  new(result)
  result.impl = pango_font_metrics_ref(cast[ptr FontMetrics00](self.impl))

proc pango_font_metrics_unref*(self: ptr FontMetrics00) {.
    importc: "pango_font_metrics_unref", libprag.}

proc unref*(self: FontMetrics) =
  pango_font_metrics_unref(cast[ptr FontMetrics00](self.impl))

proc pango_font_get_metrics*(self: ptr Font00; language: ptr Language00): ptr FontMetrics00 {.
    importc: "pango_font_get_metrics", libprag.}

proc getMetrics*(self: Font; language: Language): FontMetrics =
  new(result)
  result.impl = pango_font_get_metrics(cast[ptr Font00](self.impl), cast[ptr Language00](language.impl))

proc metrics*(self: Font; language: Language): FontMetrics =
  new(result)
  result.impl = pango_font_get_metrics(cast[ptr Font00](self.impl), cast[ptr Language00](language.impl))

proc pango_context_get_metrics*(self: ptr Context00; desc: ptr FontDescription00; 
    language: ptr Language00): ptr FontMetrics00 {.
    importc: "pango_context_get_metrics", libprag.}

proc getMetrics*(self: Context; desc: FontDescription; language: Language): FontMetrics =
  new(result)
  result.impl = pango_context_get_metrics(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))

proc metrics*(self: Context; desc: FontDescription; language: Language): FontMetrics =
  new(result)
  result.impl = pango_context_get_metrics(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))

type
  Fontset* = ref object of gobject.Object
  Fontset00* = object of gobject.Object00

proc pango_fontset_get_font*(self: ptr Fontset00; wc: uint32): ptr Font00 {.
    importc: "pango_fontset_get_font", libprag.}

proc getFont*(self: Fontset; wc: int): Font =
  let gobj = pango_fontset_get_font(cast[ptr Fontset00](self.impl), uint32(wc))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Font](g_object_get_qdata(gobj, Quark))
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

proc font*(self: Fontset; wc: int): Font =
  let gobj = pango_fontset_get_font(cast[ptr Fontset00](self.impl), uint32(wc))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Font](g_object_get_qdata(gobj, Quark))
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

proc pango_fontset_get_metrics*(self: ptr Fontset00): ptr FontMetrics00 {.
    importc: "pango_fontset_get_metrics", libprag.}

proc getMetrics*(self: Fontset): FontMetrics =
  new(result)
  result.impl = pango_fontset_get_metrics(cast[ptr Fontset00](self.impl))

proc metrics*(self: Fontset): FontMetrics =
  new(result)
  result.impl = pango_fontset_get_metrics(cast[ptr Fontset00](self.impl))

proc pango_font_map_load_fontset*(self: ptr FontMap00; context: ptr Context00; desc: ptr FontDescription00; 
    language: ptr Language00): ptr Fontset00 {.
    importc: "pango_font_map_load_fontset", libprag.}

proc loadFontset*(self: FontMap; context: Context; desc: FontDescription; 
    language: Language): Fontset =
  let gobj = pango_font_map_load_fontset(cast[ptr FontMap00](self.impl), cast[ptr Context00](context.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Fontset](g_object_get_qdata(gobj, Quark))
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

proc pango_context_load_fontset*(self: ptr Context00; desc: ptr FontDescription00; 
    language: ptr Language00): ptr Fontset00 {.
    importc: "pango_context_load_fontset", libprag.}

proc loadFontset*(self: Context; desc: FontDescription; language: Language): Fontset =
  let gobj = pango_context_load_fontset(cast[ptr Context00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Fontset](g_object_get_qdata(gobj, Quark))
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
  AttrType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    language = 1
    family = 2
    style = 3
    weight = 4
    variant = 5
    stretch = 6
    size = 7
    fontDesc = 8
    foreground = 9
    background = 10
    underline = 11
    strikethrough = 12
    rise = 13
    shape = 14
    scale = 15
    fallback = 16
    letterSpacing = 17
    underlineColor = 18
    strikethroughColor = 19
    absoluteSize = 20
    gravity = 21
    gravityHint = 22
    fontFeatures = 23
    foregroundAlpha = 24
    backgroundAlpha = 25

proc pango_attr_type_get_name*(`type`: AttrType): cstring {.
    importc: "pango_attr_type_get_name", libprag.}

proc getName*(`type`: AttrType): string =
  let resul0 = pango_attr_type_get_name(`type`)
  result = $resul0

proc name*(`type`: AttrType): string =
  let resul0 = pango_attr_type_get_name(`type`)
  result = $resul0

proc pango_attr_type_register*(name: cstring): AttrType {.
    importc: "pango_attr_type_register", libprag.}

proc register*(name: cstring): AttrType {.
    importc: "pango_attr_type_register", libprag.}
type

  Attribute00* {.pure.} = object
    klass*: ptr AttrClass00
    startIndex*: uint32
    endIndex*: uint32
  Attribute* = ref object
    impl*: ptr Attribute00

  AttrClass00* {.pure.} = object
    `type`*: AttrType
    copy*: pointer
    destroy*: proc(attr: ptr Attribute00) {.cdecl.}
    equal*: proc(attr1: ptr Attribute00; attr2: ptr Attribute00): gboolean {.cdecl.}
  AttrClass* = ref object
    impl*: ptr AttrClass00

proc pango_attribute_destroy*(self: ptr Attribute00) {.
    importc: "pango_attribute_destroy", libprag.}

proc destroy*(self: Attribute) =
  pango_attribute_destroy(cast[ptr Attribute00](self.impl))

proc pango_attribute_equal*(self: ptr Attribute00; attr2: ptr Attribute00): gboolean {.
    importc: "pango_attribute_equal", libprag.}

proc equal*(self: Attribute; attr2: Attribute): bool =
  toBool(pango_attribute_equal(cast[ptr Attribute00](self.impl), cast[ptr Attribute00](attr2.impl)))

proc pango_attribute_init*(self: ptr Attribute00; klass: ptr AttrClass00) {.
    importc: "pango_attribute_init", libprag.}

proc init*(self: Attribute; klass: AttrClass) =
  pango_attribute_init(cast[ptr Attribute00](self.impl), cast[ptr AttrClass00](klass.impl))

type
  Color00* {.pure.} = object
    red*: uint16
    green*: uint16
    blue*: uint16
  Color* = ref object
    impl*: ptr Color00

proc pango_color_copy*(self: ptr Color00): ptr Color00 {.
    importc: "pango_color_copy", libprag.}

proc copy*(self: Color): Color =
  new(result)
  result.impl = pango_color_copy(cast[ptr Color00](self.impl))

proc pango_color_free*(self: ptr Color00) {.
    importc: "pango_color_free", libprag.}

proc free*(self: Color) =
  pango_color_free(cast[ptr Color00](self.impl))

proc pango_color_parse*(self: ptr Color00; spec: cstring): gboolean {.
    importc: "pango_color_parse", libprag.}

proc parse*(self: Color; spec: string): bool =
  toBool(pango_color_parse(cast[ptr Color00](self.impl), cstring(spec)))

proc pango_color_to_string*(self: ptr Color00): cstring {.
    importc: "pango_color_to_string", libprag.}

proc toString*(self: Color): string =
  let resul0 = pango_color_to_string(cast[ptr Color00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  AttrColor00* {.pure.} = object
    attr*: Attribute00
    color*: Color00
  AttrColor* = ref object
    impl*: ptr AttrColor00

type
  AttrDataCopyFunc* = proc (userData: pointer): pointer {.cdecl.}

type
  AttrFilterFunc* = proc (attribute: ptr Attribute00; userData: pointer): gboolean {.cdecl.}

type
  AttrFloat00* {.pure.} = object
    attr*: Attribute00
    value*: cdouble
  AttrFloat* = ref object
    impl*: ptr AttrFloat00

type
  AttrFontDesc00* {.pure.} = object
    attr*: Attribute00
    desc*: ptr FontDescription00
  AttrFontDesc* = ref object
    impl*: ptr AttrFontDesc00

type
  AttrFontFeatures00* {.pure.} = object
    attr*: Attribute00
    features*: cstring
  AttrFontFeatures* = ref object
    impl*: ptr AttrFontFeatures00

type
  AttrInt00* {.pure.} = object
    attr*: Attribute00
    value*: int32
  AttrInt* = ref object
    impl*: ptr AttrInt00

type
  AttrIterator00* {.pure.} = object
  AttrIterator* = ref object
    impl*: ptr AttrIterator00

proc pango_attr_iterator_destroy*(self: ptr AttrIterator00) {.
    importc: "pango_attr_iterator_destroy", libprag.}

proc destroy*(self: AttrIterator) =
  pango_attr_iterator_destroy(cast[ptr AttrIterator00](self.impl))

proc pango_attr_iterator_get_attrs*(self: ptr AttrIterator00): ptr pointer {.
    importc: "pango_attr_iterator_get_attrs", libprag.}

proc getAttrs*(self: AttrIterator): ptr pointer =
  pango_attr_iterator_get_attrs(cast[ptr AttrIterator00](self.impl))

proc attrs*(self: AttrIterator): ptr pointer =
  pango_attr_iterator_get_attrs(cast[ptr AttrIterator00](self.impl))

proc pango_attr_iterator_get_font*(self: ptr AttrIterator00; desc: ptr FontDescription00; 
    language: ptr Language00; extraAttrs: ptr pointer) {.
    importc: "pango_attr_iterator_get_font", libprag.}

proc getFont*(self: AttrIterator; desc: FontDescription; language: Language; 
    extraAttrs: ptr pointer) =
  pango_attr_iterator_get_font(cast[ptr AttrIterator00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl), extraAttrs)

proc font*(self: AttrIterator; desc: FontDescription; language: Language; 
    extraAttrs: ptr pointer) =
  pango_attr_iterator_get_font(cast[ptr AttrIterator00](self.impl), cast[ptr FontDescription00](desc.impl), cast[ptr Language00](language.impl), extraAttrs)

proc pango_attr_iterator_next*(self: ptr AttrIterator00): gboolean {.
    importc: "pango_attr_iterator_next", libprag.}

proc next*(self: AttrIterator): bool =
  toBool(pango_attr_iterator_next(cast[ptr AttrIterator00](self.impl)))

proc pango_attr_iterator_range*(self: ptr AttrIterator00; start: var int32; `end`: var int32) {.
    importc: "pango_attr_iterator_range", libprag.}

proc range*(self: AttrIterator; start: var int; `end`: var int) =
  var end_00 = int32(`end`)
  var start_00 = int32(start)
  pango_attr_iterator_range(cast[ptr AttrIterator00](self.impl), start_00, end_00)
  `end` = int(end_00)
  start = int(start_00)

type
  AttrLanguage00* {.pure.} = object
    attr*: Attribute00
    value*: ptr Language00
  AttrLanguage* = ref object
    impl*: ptr AttrLanguage00

type
  AttrList00* {.pure.} = object
  AttrList* = ref object
    impl*: ptr AttrList00

proc pango_attr_list_new*(): ptr AttrList00 {.
    importc: "pango_attr_list_new", libprag.}

proc newAttrList*(): AttrList =
  new(result)
  result.impl = pango_attr_list_new()

proc initAttrList*[T](result: var T) =
  assert(result is AttrList)
  new(result)
  result.impl = pango_attr_list_new()

proc pango_attr_list_change*(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc: "pango_attr_list_change", libprag.}

proc change*(self: AttrList; attr: Attribute) =
  pango_attr_list_change(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](attr.impl))

proc pango_attr_list_copy*(self: ptr AttrList00): ptr AttrList00 {.
    importc: "pango_attr_list_copy", libprag.}

proc copy*(self: AttrList): AttrList =
  new(result)
  result.impl = pango_attr_list_copy(cast[ptr AttrList00](self.impl))

proc pango_attr_list_filter*(self: ptr AttrList00; `func`: AttrFilterFunc; data: pointer): ptr AttrList00 {.
    importc: "pango_attr_list_filter", libprag.}

proc filter*(self: AttrList; `func`: AttrFilterFunc; data: pointer): AttrList =
  new(result)
  result.impl = pango_attr_list_filter(cast[ptr AttrList00](self.impl), `func`, data)

proc pango_attr_list_insert*(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc: "pango_attr_list_insert", libprag.}

proc insert*(self: AttrList; attr: Attribute) =
  pango_attr_list_insert(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](attr.impl))

proc pango_attr_list_insert_before*(self: ptr AttrList00; attr: ptr Attribute00) {.
    importc: "pango_attr_list_insert_before", libprag.}

proc insertBefore*(self: AttrList; attr: Attribute) =
  pango_attr_list_insert_before(cast[ptr AttrList00](self.impl), cast[ptr Attribute00](attr.impl))

proc pango_attr_list_ref*(self: ptr AttrList00): ptr AttrList00 {.
    importc: "pango_attr_list_ref", libprag.}

proc `ref`*(self: AttrList): AttrList =
  new(result)
  result.impl = pango_attr_list_ref(cast[ptr AttrList00](self.impl))

proc pango_attr_list_splice*(self: ptr AttrList00; other: ptr AttrList00; pos: int32; 
    len: int32) {.
    importc: "pango_attr_list_splice", libprag.}

proc splice*(self: AttrList; other: AttrList; pos: int; len: int) =
  pango_attr_list_splice(cast[ptr AttrList00](self.impl), cast[ptr AttrList00](other.impl), int32(pos), int32(len))

proc pango_attr_list_unref*(self: ptr AttrList00) {.
    importc: "pango_attr_list_unref", libprag.}

proc unref*(self: AttrList) =
  pango_attr_list_unref(cast[ptr AttrList00](self.impl))

type
  AttrShape00* {.pure.} = object
    attr*: Attribute00
    inkRect*: Rectangle00
    logicalRect*: Rectangle00
    data*: pointer
    copyFunc*: AttrDataCopyFunc
    destroyFunc*: DestroyNotify
  AttrShape* = ref object
    impl*: ptr AttrShape00

type
  AttrSize00* {.pure.} = object
    attr*: Attribute00
    size*: int32
    absolute*: uint32
  AttrSize* = ref object
    impl*: ptr AttrSize00

type
  AttrString00* {.pure.} = object
    attr*: Attribute00
    value*: cstring
  AttrString* = ref object
    impl*: ptr AttrString00

type
  BidiType* {.size: sizeof(cint), pure.} = enum
    l = 0
    lre = 1
    lro = 2
    r = 3
    al = 4
    rle = 5
    rlo = 6
    pdf = 7
    en = 8
    es = 9
    et = 10
    an = 11
    cs = 12
    nsm = 13
    bn = 14
    b = 15
    s = 16
    ws = 17
    on = 18

proc pango_bidi_type_for_unichar*(ch: gunichar): BidiType {.
    importc: "pango_bidi_type_for_unichar", libprag.}

proc forUnichar*(ch: gunichar): BidiType {.
    importc: "pango_bidi_type_for_unichar", libprag.}

type
  ContextClass00* {.pure.} = object
  ContextClass* = ref object
    impl*: ptr ContextClass00

type
  Coverage00* {.pure.} = object
  Coverage* = ref object
    impl*: ptr Coverage00

proc pango_coverage_max*(self: ptr Coverage00; other: ptr Coverage00) {.
    importc: "pango_coverage_max", libprag.}

proc max*(self: Coverage; other: Coverage) =
  pango_coverage_max(cast[ptr Coverage00](self.impl), cast[ptr Coverage00](other.impl))

proc pango_coverage_to_bytes*(self: ptr Coverage00; bytes: var uint8Array; nBytes: var int32) {.
    importc: "pango_coverage_to_bytes", libprag.}

proc toBytes*(self: Coverage; bytes: var uint8Array; nBytes: var int) =
  var nBytes_00 = int32(nBytes)
  pango_coverage_to_bytes(cast[ptr Coverage00](self.impl), bytes, nBytes_00)
  nBytes = int(nBytes_00)

proc pango_coverage_unref*(self: ptr Coverage00) {.
    importc: "pango_coverage_unref", libprag.}

proc unref*(self: Coverage) =
  pango_coverage_unref(cast[ptr Coverage00](self.impl))

type
  CoverageLevel* {.size: sizeof(cint), pure.} = enum
    none = 0
    fallback = 1
    approximate = 2
    exact = 3

proc pango_coverage_get*(self: ptr Coverage00; index: int32): CoverageLevel {.
    importc: "pango_coverage_get", libprag.}

proc get*(self: Coverage; index: int): CoverageLevel =
  pango_coverage_get(cast[ptr Coverage00](self.impl), int32(index))

proc pango_coverage_set*(self: ptr Coverage00; index: int32; level: CoverageLevel) {.
    importc: "pango_coverage_set", libprag.}

proc set*(self: Coverage; index: int; level: CoverageLevel) =
  pango_coverage_set(cast[ptr Coverage00](self.impl), int32(index), level)

const ENGINE_TYPE_LANG* = "PangoEngineLang"

const ENGINE_TYPE_SHAPE* = "PangoEngineShape"

type
  EllipsizeMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    start = 1
    middle = 2
    `end` = 3

type
  EngineClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  EngineClass* = ref object
    impl*: ptr EngineClass00

type
  EngineScriptInfo00* {.pure.} = object
    script*: Script
    langs*: cstring
  EngineScriptInfo* = ref object
    impl*: ptr EngineScriptInfo00

type
  EngineInfo00* {.pure.} = object
    id*: cstring
    engineType*: cstring
    renderType*: cstring
    scripts*: ptr EngineScriptInfo00
    nScripts*: int32
  EngineInfo* = ref object
    impl*: ptr EngineInfo00

type
  LogAttr00* {.pure.} = object
    isLineBreak*: uint32
    isMandatoryBreak*: uint32
    isCharBreak*: uint32
    isWhite*: uint32
    isCursorPosition*: uint32
    isWordStart*: uint32
    isWordEnd*: uint32
    isSentenceBoundary*: uint32
    isSentenceStart*: uint32
    isSentenceEnd*: uint32
    backspaceDeletesCharacter*: uint32
    isExpandableSpace*: uint32
    isWordBoundary*: uint32
  LogAttr* = ref object
    impl*: ptr LogAttr00

type
  EngineLangClass00* {.pure.} = object
    parentClass*: EngineClass00
    scriptBreak*: proc(engine: ptr EngineLang00; text: cstring; len: int32; 
    analysis: ptr Analysis00; attrs: ptr LogAttr00; attrsLen: int32) {.cdecl.}
  EngineLangClass* = ref object
    impl*: ptr EngineLangClass00

type
  GlyphGeometry00* {.pure.} = object
    width*: int32
    xOffset*: int32
    yOffset*: int32
  GlyphGeometry* = ref object
    impl*: ptr GlyphGeometry00

type
  GlyphVisAttr00* {.pure.} = object
    isClusterStart*: uint32
  GlyphVisAttr* = ref object
    impl*: ptr GlyphVisAttr00

type
  GlyphInfo00* {.pure.} = object
    glyph*: uint32
    geometry*: GlyphGeometry00
    attr*: GlyphVisAttr00
  GlyphInfo* = ref object
    impl*: ptr GlyphInfo00

type
  GlyphString00* {.pure.} = object
    numGlyphs*: int32
    glyphs*: GlyphInfo00Array
    logClusters*: ptr int32
    space*: int32
  GlyphString* = ref object
    impl*: ptr GlyphString00

proc pango_glyph_string_new*(): ptr GlyphString00 {.
    importc: "pango_glyph_string_new", libprag.}

proc newGlyphString*(): GlyphString =
  new(result)
  result.impl = pango_glyph_string_new()

proc initGlyphString*[T](result: var T) =
  assert(result is GlyphString)
  new(result)
  result.impl = pango_glyph_string_new()

proc pango_glyph_string_copy*(self: ptr GlyphString00): ptr GlyphString00 {.
    importc: "pango_glyph_string_copy", libprag.}

proc copy*(self: GlyphString): GlyphString =
  new(result)
  result.impl = pango_glyph_string_copy(cast[ptr GlyphString00](self.impl))

proc pango_glyph_string_extents*(self: ptr GlyphString00; font: ptr Font00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_glyph_string_extents", libprag.}

proc extents*(self: ptr GlyphString00; font: ptr Font00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_glyph_string_extents", libprag.}

proc pango_glyph_string_extents_range*(self: ptr GlyphString00; start: int32; `end`: int32; 
    font: ptr Font00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_glyph_string_extents_range", libprag.}

proc extentsRange*(self: ptr GlyphString00; start: int32; `end`: int32; 
    font: ptr Font00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_glyph_string_extents_range", libprag.}

proc pango_glyph_string_free*(self: ptr GlyphString00) {.
    importc: "pango_glyph_string_free", libprag.}

proc free*(self: GlyphString) =
  pango_glyph_string_free(cast[ptr GlyphString00](self.impl))

proc pango_glyph_string_get_logical_widths*(self: ptr GlyphString00; text: cstring; length: int32; 
    embeddingLevel: int32; logicalWidths: int32Array) {.
    importc: "pango_glyph_string_get_logical_widths", libprag.}

proc getLogicalWidths*(self: GlyphString; text: string; length: int; embeddingLevel: int; 
    logicalWidths: int32Array) =
  pango_glyph_string_get_logical_widths(cast[ptr GlyphString00](self.impl), cstring(text), int32(length), int32(embeddingLevel), logicalWidths)

proc logicalWidths*(self: GlyphString; text: string; length: int; embeddingLevel: int; 
    logicalWidths: int32Array) =
  pango_glyph_string_get_logical_widths(cast[ptr GlyphString00](self.impl), cstring(text), int32(length), int32(embeddingLevel), logicalWidths)

proc pango_glyph_string_get_width*(self: ptr GlyphString00): int32 {.
    importc: "pango_glyph_string_get_width", libprag.}

proc getWidth*(self: GlyphString): int =
  int(pango_glyph_string_get_width(cast[ptr GlyphString00](self.impl)))

proc width*(self: GlyphString): int =
  int(pango_glyph_string_get_width(cast[ptr GlyphString00](self.impl)))

proc pango_glyph_string_index_to_x*(self: ptr GlyphString00; text: cstring; length: int32; 
    analysis: ptr Analysis00; index: int32; trailing: gboolean; xPos: var int32) {.
    importc: "pango_glyph_string_index_to_x", libprag.}

proc indexToX*(self: GlyphString; text: string; length: int; analysis: Analysis; 
    index: int; trailing: bool; xPos: var int) =
  var xPos_00 = int32(xPos)
  pango_glyph_string_index_to_x(cast[ptr GlyphString00](self.impl), cstring(text), int32(length), cast[ptr Analysis00](analysis.impl), int32(index), gboolean(trailing), xPos_00)
  xPos = int(xPos_00)

proc pango_glyph_string_set_size*(self: ptr GlyphString00; newLen: int32) {.
    importc: "pango_glyph_string_set_size", libprag.}

proc setSize*(self: GlyphString; newLen: int) =
  pango_glyph_string_set_size(cast[ptr GlyphString00](self.impl), int32(newLen))

proc `size=`*(self: GlyphString; newLen: int) =
  pango_glyph_string_set_size(cast[ptr GlyphString00](self.impl), int32(newLen))

proc pango_glyph_string_x_to_index*(self: ptr GlyphString00; text: cstring; length: int32; 
    analysis: ptr Analysis00; xPos: int32; index: var int32; trailing: var int32) {.
    importc: "pango_glyph_string_x_to_index", libprag.}

proc xToIndex*(self: GlyphString; text: string; length: int; analysis: Analysis; 
    xPos: int; index: var int; trailing: var int) =
  var index_00 = int32(index)
  var trailing_00 = int32(trailing)
  pango_glyph_string_x_to_index(cast[ptr GlyphString00](self.impl), cstring(text), int32(length), cast[ptr Analysis00](analysis.impl), int32(xPos), index_00, trailing_00)
  index = int(index_00)
  trailing = int(trailing_00)

type
  EngineShapeClass00* {.pure.} = object
    parentClass*: EngineClass00
    scriptShape*: proc(engine: ptr EngineShape00; font: ptr Font00; itemText: cstring; 
    itemLength: uint32; analysis: ptr Analysis00; glyphs: ptr GlyphString00; paragraphText: cstring; 
    paragraphLength: uint32) {.cdecl.}
    covers*: proc(engine: ptr EngineShape00; font: ptr Font00; language: ptr Language00; 
    wc: gunichar): CoverageLevel {.cdecl.}
  EngineShapeClass* = ref object
    impl*: ptr EngineShapeClass00

type
  FontClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    describe*: proc(font: ptr Font00): ptr FontDescription00 {.cdecl.}
    getCoverage*: pointer
    findShaper*: proc(font: ptr Font00; lang: ptr Language00; ch: uint32): ptr EngineShape00 {.cdecl.}
    getGlyphExtents*: proc(font: ptr Font00; glyph: uint32; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.cdecl.}
    getMetrics*: proc(font: ptr Font00; language: ptr Language00): ptr FontMetrics00 {.cdecl.}
    getFontMap*: proc(font: ptr Font00): ptr FontMap00 {.cdecl.}
    describeAbsolute*: proc(font: ptr Font00): ptr FontDescription00 {.cdecl.}
    pangoReserved1*: pointer
    pangoReserved2*: pointer
  FontClass* = ref object
    impl*: ptr FontClass00

type
  FontFaceClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getFaceName*: proc(face: ptr FontFace00): cstring {.cdecl.}
    describe*: proc(face: ptr FontFace00): ptr FontDescription00 {.cdecl.}
    listSizes*: proc(face: ptr FontFace00; sizes: var int32Array; nSizes: var int32) {.cdecl.}
    isSynthesized*: proc(face: ptr FontFace00): gboolean {.cdecl.}
    pangoReserved3*: pointer
    pangoReserved4*: pointer
  FontFaceClass* = ref object
    impl*: ptr FontFaceClass00

type
  FontFamilyClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    listFaces*: proc(family: ptr FontFamily00; faces: var ptr FontFace00Array; 
    nFaces: var int32) {.cdecl.}
    getName*: proc(family: ptr FontFamily00): cstring {.cdecl.}
    isMonospace*: proc(family: ptr FontFamily00): gboolean {.cdecl.}
    pangoReserved2*: pointer
    pangoReserved3*: pointer
    pangoReserved4*: pointer
  FontFamilyClass* = ref object
    impl*: ptr FontFamilyClass00

type
  FontMapClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    loadFont*: proc(fontmap: ptr FontMap00; context: ptr Context00; desc: ptr FontDescription00): ptr Font00 {.cdecl.}
    listFamilies*: proc(fontmap: ptr FontMap00; families: var ptr FontFamily00Array; 
    nFamilies: var int32) {.cdecl.}
    loadFontset*: proc(fontmap: ptr FontMap00; context: ptr Context00; desc: ptr FontDescription00; 
    language: ptr Language00): ptr Fontset00 {.cdecl.}
    shapeEngineType*: cstring
    getSerial*: proc(fontmap: ptr FontMap00): uint32 {.cdecl.}
    changed*: proc(fontmap: ptr FontMap00) {.cdecl.}
    pangoReserved1*: pointer
    pangoReserved2*: pointer
  FontMapClass* = ref object
    impl*: ptr FontMapClass00

type
  FontsetForeachFunc* = proc (fontset: ptr Fontset00; font: ptr Font00; userData: pointer): gboolean {.cdecl.}

type
  FontsetClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getFont*: proc(fontset: ptr Fontset00; wc: uint32): ptr Font00 {.cdecl.}
    getMetrics*: proc(fontset: ptr Fontset00): ptr FontMetrics00 {.cdecl.}
    getLanguage*: proc(fontset: ptr Fontset00): ptr Language00 {.cdecl.}
    foreach*: proc(fontset: ptr Fontset00; `func`: FontsetForeachFunc; 
    data: pointer) {.cdecl.}
    pangoReserved1*: pointer
    pangoReserved2*: pointer
    pangoReserved3*: pointer
    pangoReserved4*: pointer
  FontsetClass* = ref object
    impl*: ptr FontsetClass00

proc pango_fontset_foreach*(self: ptr Fontset00; `func`: FontsetForeachFunc; data: pointer) {.
    importc: "pango_fontset_foreach", libprag.}

proc foreach*(self: Fontset; `func`: FontsetForeachFunc; data: pointer) =
  pango_fontset_foreach(cast[ptr Fontset00](self.impl), `func`, data)

type
  FontsetSimple* = ref object of Fontset
  FontsetSimple00* = object of Fontset00

proc pango_fontset_simple_new*(language: ptr Language00): ptr FontsetSimple00 {.
    importc: "pango_fontset_simple_new", libprag.}

proc newFontsetSimple*(language: Language): FontsetSimple =
  new(result, finalizeGObject)
  result.impl = pango_fontset_simple_new(cast[ptr Language00](language.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFontsetSimple*[T](result: var T; language: Language) =
  assert(result is FontsetSimple)
  new(result, finalizeGObject)
  result.impl = pango_fontset_simple_new(cast[ptr Language00](language.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_fontset_simple_append*(self: ptr FontsetSimple00; font: ptr Font00) {.
    importc: "pango_fontset_simple_append", libprag.}

proc append*(self: FontsetSimple; font: Font) =
  pango_fontset_simple_append(cast[ptr FontsetSimple00](self.impl), cast[ptr Font00](font.impl))

proc pango_fontset_simple_size*(self: ptr FontsetSimple00): int32 {.
    importc: "pango_fontset_simple_size", libprag.}

proc size*(self: FontsetSimple): int =
  int(pango_fontset_simple_size(cast[ptr FontsetSimple00](self.impl)))

type
  FontsetSimpleClass00* {.pure.} = object
  FontsetSimpleClass* = ref object
    impl*: ptr FontsetSimpleClass00

const GLYPH_EMPTY* = 268435455'u32

const GLYPH_INVALID_INPUT* = 4294967295'u32

const GLYPH_UNKNOWN_FLAG* = 268435456'u32

type
  Item00* {.pure.} = object
    offset*: int32
    length*: int32
    numChars*: int32
    analysis*: Analysis00
  Item* = ref object
    impl*: ptr Item00

proc pango_item_new*(): ptr Item00 {.
    importc: "pango_item_new", libprag.}

proc newItem*(): Item =
  new(result)
  result.impl = pango_item_new()

proc initItem*[T](result: var T) =
  assert(result is Item)
  new(result)
  result.impl = pango_item_new()

proc pango_item_copy*(self: ptr Item00): ptr Item00 {.
    importc: "pango_item_copy", libprag.}

proc copy*(self: Item): Item =
  new(result)
  result.impl = pango_item_copy(cast[ptr Item00](self.impl))

proc pango_item_free*(self: ptr Item00) {.
    importc: "pango_item_free", libprag.}

proc free*(self: Item) =
  pango_item_free(cast[ptr Item00](self.impl))

proc pango_item_split*(self: ptr Item00; splitIndex: int32; splitOffset: int32): ptr Item00 {.
    importc: "pango_item_split", libprag.}

proc split*(self: Item; splitIndex: int; splitOffset: int): Item =
  new(result)
  result.impl = pango_item_split(cast[ptr Item00](self.impl), int32(splitIndex), int32(splitOffset))

type
  GlyphItem00* {.pure.} = object
    item*: ptr Item00
    glyphs*: ptr GlyphString00
  GlyphItem* = ref object
    impl*: ptr GlyphItem00

proc pango_glyph_item_apply_attrs*(self: ptr GlyphItem00; text: cstring; list: ptr AttrList00): ptr pointer {.
    importc: "pango_glyph_item_apply_attrs", libprag.}

proc applyAttrs*(self: GlyphItem; text: string; list: AttrList): ptr pointer =
  pango_glyph_item_apply_attrs(cast[ptr GlyphItem00](self.impl), cstring(text), cast[ptr AttrList00](list.impl))

proc pango_glyph_item_copy*(self: ptr GlyphItem00): ptr GlyphItem00 {.
    importc: "pango_glyph_item_copy", libprag.}

proc copy*(self: GlyphItem): GlyphItem =
  new(result)
  result.impl = pango_glyph_item_copy(cast[ptr GlyphItem00](self.impl))

proc pango_glyph_item_free*(self: ptr GlyphItem00) {.
    importc: "pango_glyph_item_free", libprag.}

proc free*(self: GlyphItem) =
  pango_glyph_item_free(cast[ptr GlyphItem00](self.impl))

proc pango_glyph_item_get_logical_widths*(self: ptr GlyphItem00; text: cstring; logicalWidths: int32Array) {.
    importc: "pango_glyph_item_get_logical_widths", libprag.}

proc getLogicalWidths*(self: GlyphItem; text: string; logicalWidths: int32Array) =
  pango_glyph_item_get_logical_widths(cast[ptr GlyphItem00](self.impl), cstring(text), logicalWidths)

proc logicalWidths*(self: GlyphItem; text: string; logicalWidths: int32Array) =
  pango_glyph_item_get_logical_widths(cast[ptr GlyphItem00](self.impl), cstring(text), logicalWidths)

proc pango_glyph_item_letter_space*(self: ptr GlyphItem00; text: cstring; logAttrs: LogAttr00Array; 
    letterSpacing: int32) {.
    importc: "pango_glyph_item_letter_space", libprag.}

proc letterSpace*(self: GlyphItem; text: string; logAttrs: LogAttr00Array; 
    letterSpacing: int) =
  pango_glyph_item_letter_space(cast[ptr GlyphItem00](self.impl), cstring(text), logAttrs, int32(letterSpacing))

proc pango_glyph_item_split*(self: ptr GlyphItem00; text: cstring; splitIndex: int32): ptr GlyphItem00 {.
    importc: "pango_glyph_item_split", libprag.}

proc split*(self: GlyphItem; text: string; splitIndex: int): GlyphItem =
  new(result)
  result.impl = pango_glyph_item_split(cast[ptr GlyphItem00](self.impl), cstring(text), int32(splitIndex))

type
  GlyphItemIter00* {.pure.} = object
    glyphItem*: ptr GlyphItem00
    text*: cstring
    startGlyph*: int32
    startIndex*: int32
    startChar*: int32
    endGlyph*: int32
    endIndex*: int32
    endChar*: int32
  GlyphItemIter* = ref object
    impl*: ptr GlyphItemIter00

proc pango_glyph_item_iter_copy*(self: ptr GlyphItemIter00): ptr GlyphItemIter00 {.
    importc: "pango_glyph_item_iter_copy", libprag.}

proc copy*(self: GlyphItemIter): GlyphItemIter =
  new(result)
  result.impl = pango_glyph_item_iter_copy(cast[ptr GlyphItemIter00](self.impl))

proc pango_glyph_item_iter_free*(self: ptr GlyphItemIter00) {.
    importc: "pango_glyph_item_iter_free", libprag.}

proc free*(self: GlyphItemIter) =
  pango_glyph_item_iter_free(cast[ptr GlyphItemIter00](self.impl))

proc pango_glyph_item_iter_init_end*(self: ptr GlyphItemIter00; glyphItem: ptr GlyphItem00; 
    text: cstring): gboolean {.
    importc: "pango_glyph_item_iter_init_end", libprag.}

proc initEnd*(self: GlyphItemIter; glyphItem: GlyphItem; text: string): bool =
  toBool(pango_glyph_item_iter_init_end(cast[ptr GlyphItemIter00](self.impl), cast[ptr GlyphItem00](glyphItem.impl), cstring(text)))

proc pango_glyph_item_iter_init_start*(self: ptr GlyphItemIter00; glyphItem: ptr GlyphItem00; 
    text: cstring): gboolean {.
    importc: "pango_glyph_item_iter_init_start", libprag.}

proc initStart*(self: GlyphItemIter; glyphItem: GlyphItem; text: string): bool =
  toBool(pango_glyph_item_iter_init_start(cast[ptr GlyphItemIter00](self.impl), cast[ptr GlyphItem00](glyphItem.impl), cstring(text)))

proc pango_glyph_item_iter_next_cluster*(self: ptr GlyphItemIter00): gboolean {.
    importc: "pango_glyph_item_iter_next_cluster", libprag.}

proc nextCluster*(self: GlyphItemIter): bool =
  toBool(pango_glyph_item_iter_next_cluster(cast[ptr GlyphItemIter00](self.impl)))

proc pango_glyph_item_iter_prev_cluster*(self: ptr GlyphItemIter00): gboolean {.
    importc: "pango_glyph_item_iter_prev_cluster", libprag.}

proc prevCluster*(self: GlyphItemIter): bool =
  toBool(pango_glyph_item_iter_prev_cluster(cast[ptr GlyphItemIter00](self.impl)))

type
  IncludedModule00* {.pure.} = object
    list*: proc(engines: ptr EngineInfo00; nEngines: ptr int32) {.cdecl.}
    init*: proc(module: ptr gobject.TypeModule00) {.cdecl.}
    exit*: proc() {.cdecl.}
    create*: pointer
  IncludedModule* = ref object
    impl*: ptr IncludedModule00

type
  Layout* = ref object of gobject.Object
  Layout00* = object of gobject.Object00

proc pango_layout_new*(context: ptr Context00): ptr Layout00 {.
    importc: "pango_layout_new", libprag.}

proc newLayout*(context: Context): Layout =
  new(result, finalizeGObject)
  result.impl = pango_layout_new(cast[ptr Context00](context.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initLayout*[T](result: var T; context: Context) =
  assert(result is Layout)
  new(result, finalizeGObject)
  result.impl = pango_layout_new(cast[ptr Context00](context.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc pango_layout_context_changed*(self: ptr Layout00) {.
    importc: "pango_layout_context_changed", libprag.}

proc contextChanged*(self: Layout) =
  pango_layout_context_changed(cast[ptr Layout00](self.impl))

proc pango_layout_copy*(self: ptr Layout00): ptr Layout00 {.
    importc: "pango_layout_copy", libprag.}

proc copy*(self: Layout): Layout =
  let gobj = pango_layout_copy(cast[ptr Layout00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Layout](g_object_get_qdata(gobj, Quark))
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

proc pango_layout_get_alignment*(self: ptr Layout00): Alignment {.
    importc: "pango_layout_get_alignment", libprag.}

proc getAlignment*(self: Layout): Alignment =
  pango_layout_get_alignment(cast[ptr Layout00](self.impl))

proc alignment*(self: Layout): Alignment =
  pango_layout_get_alignment(cast[ptr Layout00](self.impl))

proc pango_layout_get_attributes*(self: ptr Layout00): ptr AttrList00 {.
    importc: "pango_layout_get_attributes", libprag.}

proc getAttributes*(self: Layout): AttrList =
  new(result)
  result.impl = pango_layout_get_attributes(cast[ptr Layout00](self.impl))

proc attributes*(self: Layout): AttrList =
  new(result)
  result.impl = pango_layout_get_attributes(cast[ptr Layout00](self.impl))

proc pango_layout_get_auto_dir*(self: ptr Layout00): gboolean {.
    importc: "pango_layout_get_auto_dir", libprag.}

proc getAutoDir*(self: Layout): bool =
  toBool(pango_layout_get_auto_dir(cast[ptr Layout00](self.impl)))

proc autoDir*(self: Layout): bool =
  toBool(pango_layout_get_auto_dir(cast[ptr Layout00](self.impl)))

proc pango_layout_get_baseline*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_baseline", libprag.}

proc getBaseline*(self: Layout): int =
  int(pango_layout_get_baseline(cast[ptr Layout00](self.impl)))

proc baseline*(self: Layout): int =
  int(pango_layout_get_baseline(cast[ptr Layout00](self.impl)))

proc pango_layout_get_character_count*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_character_count", libprag.}

proc getCharacterCount*(self: Layout): int =
  int(pango_layout_get_character_count(cast[ptr Layout00](self.impl)))

proc characterCount*(self: Layout): int =
  int(pango_layout_get_character_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_context*(self: ptr Layout00): ptr Context00 {.
    importc: "pango_layout_get_context", libprag.}

proc getContext*(self: Layout): Context =
  let gobj = pango_layout_get_context(cast[ptr Layout00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Context](g_object_get_qdata(gobj, Quark))
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

proc context*(self: Layout): Context =
  let gobj = pango_layout_get_context(cast[ptr Layout00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Context](g_object_get_qdata(gobj, Quark))
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

proc pango_layout_get_cursor_pos*(self: ptr Layout00; index: int32; strongPos: var Rectangle00; 
    weakPos: var Rectangle00) {.
    importc: "pango_layout_get_cursor_pos", libprag.}

proc getCursorPos*(self: ptr Layout00; index: int32; strongPos: var Rectangle00; 
    weakPos: var Rectangle00) {.
    importc: "pango_layout_get_cursor_pos", libprag.}

proc cursorPos*(self: ptr Layout00; index: int32; strongPos: var Rectangle00; 
    weakPos: var Rectangle00) {.
    importc: "pango_layout_get_cursor_pos", libprag.}

proc pango_layout_get_ellipsize*(self: ptr Layout00): EllipsizeMode {.
    importc: "pango_layout_get_ellipsize", libprag.}

proc getEllipsize*(self: Layout): EllipsizeMode =
  pango_layout_get_ellipsize(cast[ptr Layout00](self.impl))

proc ellipsize*(self: Layout): EllipsizeMode =
  pango_layout_get_ellipsize(cast[ptr Layout00](self.impl))

proc pango_layout_get_extents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_extents", libprag.}

proc getExtents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_extents", libprag.}

proc extents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_extents", libprag.}

proc pango_layout_get_font_description*(self: ptr Layout00): ptr FontDescription00 {.
    importc: "pango_layout_get_font_description", libprag.}

proc getFontDescription*(self: Layout): FontDescription =
  new(result)
  result.impl = pango_layout_get_font_description(cast[ptr Layout00](self.impl))

proc fontDescription*(self: Layout): FontDescription =
  new(result)
  result.impl = pango_layout_get_font_description(cast[ptr Layout00](self.impl))

proc pango_layout_get_height*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_height", libprag.}

proc getHeight*(self: Layout): int =
  int(pango_layout_get_height(cast[ptr Layout00](self.impl)))

proc height*(self: Layout): int =
  int(pango_layout_get_height(cast[ptr Layout00](self.impl)))

proc pango_layout_get_indent*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_indent", libprag.}

proc getIndent*(self: Layout): int =
  int(pango_layout_get_indent(cast[ptr Layout00](self.impl)))

proc indent*(self: Layout): int =
  int(pango_layout_get_indent(cast[ptr Layout00](self.impl)))

proc pango_layout_get_justify*(self: ptr Layout00): gboolean {.
    importc: "pango_layout_get_justify", libprag.}

proc getJustify*(self: Layout): bool =
  toBool(pango_layout_get_justify(cast[ptr Layout00](self.impl)))

proc justify*(self: Layout): bool =
  toBool(pango_layout_get_justify(cast[ptr Layout00](self.impl)))

proc pango_layout_get_line_count*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_line_count", libprag.}

proc getLineCount*(self: Layout): int =
  int(pango_layout_get_line_count(cast[ptr Layout00](self.impl)))

proc lineCount*(self: Layout): int =
  int(pango_layout_get_line_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_lines*(self: ptr Layout00): ptr pointer {.
    importc: "pango_layout_get_lines", libprag.}

proc getLines*(self: Layout): ptr pointer =
  pango_layout_get_lines(cast[ptr Layout00](self.impl))

proc lines*(self: Layout): ptr pointer =
  pango_layout_get_lines(cast[ptr Layout00](self.impl))

proc pango_layout_get_lines_readonly*(self: ptr Layout00): ptr pointer {.
    importc: "pango_layout_get_lines_readonly", libprag.}

proc getLinesReadonly*(self: Layout): ptr pointer =
  pango_layout_get_lines_readonly(cast[ptr Layout00](self.impl))

proc linesReadonly*(self: Layout): ptr pointer =
  pango_layout_get_lines_readonly(cast[ptr Layout00](self.impl))

proc pango_layout_get_log_attrs*(self: ptr Layout00; attrs: var LogAttr00Array; nAttrs: var int32) {.
    importc: "pango_layout_get_log_attrs", libprag.}

proc getLogAttrs*(self: Layout; attrs: var LogAttr00Array; nAttrs: var int) =
  var nAttrs_00 = int32(nAttrs)
  pango_layout_get_log_attrs(cast[ptr Layout00](self.impl), attrs, nAttrs_00)
  nAttrs = int(nAttrs_00)

proc logAttrs*(self: Layout; attrs: var LogAttr00Array; nAttrs: var int) =
  var nAttrs_00 = int32(nAttrs)
  pango_layout_get_log_attrs(cast[ptr Layout00](self.impl), attrs, nAttrs_00)
  nAttrs = int(nAttrs_00)

proc pango_layout_get_log_attrs_readonly*(self: ptr Layout00; nAttrs: var int32): LogAttr00Array {.
    importc: "pango_layout_get_log_attrs_readonly", libprag.}

proc getLogAttrsReadonly*(self: Layout; nAttrs: var int): LogAttr00Array =
  var nAttrs_00 = int32(nAttrs)
  result = pango_layout_get_log_attrs_readonly(cast[ptr Layout00](self.impl), nAttrs_00)
  nAttrs = int(nAttrs_00)

proc logAttrsReadonly*(self: Layout; nAttrs: var int): LogAttr00Array =
  var nAttrs_00 = int32(nAttrs)
  result = pango_layout_get_log_attrs_readonly(cast[ptr Layout00](self.impl), nAttrs_00)
  nAttrs = int(nAttrs_00)

proc pango_layout_get_pixel_extents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_pixel_extents", libprag.}

proc getPixelExtents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_pixel_extents", libprag.}

proc pixelExtents*(self: ptr Layout00; inkRect: var Rectangle00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_get_pixel_extents", libprag.}

proc pango_layout_get_pixel_size*(self: ptr Layout00; width: var int32; height: var int32) {.
    importc: "pango_layout_get_pixel_size", libprag.}

proc getPixelSize*(self: Layout; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  pango_layout_get_pixel_size(cast[ptr Layout00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc pixelSize*(self: Layout; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  pango_layout_get_pixel_size(cast[ptr Layout00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc pango_layout_get_serial*(self: ptr Layout00): uint32 {.
    importc: "pango_layout_get_serial", libprag.}

proc getSerial*(self: Layout): int =
  int(pango_layout_get_serial(cast[ptr Layout00](self.impl)))

proc serial*(self: Layout): int =
  int(pango_layout_get_serial(cast[ptr Layout00](self.impl)))

proc pango_layout_get_single_paragraph_mode*(self: ptr Layout00): gboolean {.
    importc: "pango_layout_get_single_paragraph_mode", libprag.}

proc getSingleParagraphMode*(self: Layout): bool =
  toBool(pango_layout_get_single_paragraph_mode(cast[ptr Layout00](self.impl)))

proc singleParagraphMode*(self: Layout): bool =
  toBool(pango_layout_get_single_paragraph_mode(cast[ptr Layout00](self.impl)))

proc pango_layout_get_size*(self: ptr Layout00; width: var int32; height: var int32) {.
    importc: "pango_layout_get_size", libprag.}

proc getSize*(self: Layout; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  pango_layout_get_size(cast[ptr Layout00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc size*(self: Layout; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  pango_layout_get_size(cast[ptr Layout00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc pango_layout_get_spacing*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_spacing", libprag.}

proc getSpacing*(self: Layout): int =
  int(pango_layout_get_spacing(cast[ptr Layout00](self.impl)))

proc spacing*(self: Layout): int =
  int(pango_layout_get_spacing(cast[ptr Layout00](self.impl)))

proc pango_layout_get_text*(self: ptr Layout00): cstring {.
    importc: "pango_layout_get_text", libprag.}

proc getText*(self: Layout): string =
  let resul0 = pango_layout_get_text(cast[ptr Layout00](self.impl))
  result = $resul0

proc text*(self: Layout): string =
  let resul0 = pango_layout_get_text(cast[ptr Layout00](self.impl))
  result = $resul0

proc pango_layout_get_unknown_glyphs_count*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_unknown_glyphs_count", libprag.}

proc getUnknownGlyphsCount*(self: Layout): int =
  int(pango_layout_get_unknown_glyphs_count(cast[ptr Layout00](self.impl)))

proc unknownGlyphsCount*(self: Layout): int =
  int(pango_layout_get_unknown_glyphs_count(cast[ptr Layout00](self.impl)))

proc pango_layout_get_width*(self: ptr Layout00): int32 {.
    importc: "pango_layout_get_width", libprag.}

proc getWidth*(self: Layout): int =
  int(pango_layout_get_width(cast[ptr Layout00](self.impl)))

proc width*(self: Layout): int =
  int(pango_layout_get_width(cast[ptr Layout00](self.impl)))

proc pango_layout_index_to_line_x*(self: ptr Layout00; index: int32; trailing: gboolean; 
    line: var int32; xPos: var int32) {.
    importc: "pango_layout_index_to_line_x", libprag.}

proc indexToLineX*(self: Layout; index: int; trailing: bool; line: var int; 
    xPos: var int) =
  var xPos_00 = int32(xPos)
  var line_00 = int32(line)
  pango_layout_index_to_line_x(cast[ptr Layout00](self.impl), int32(index), gboolean(trailing), line_00, xPos_00)
  xPos = int(xPos_00)
  line = int(line_00)

proc pango_layout_index_to_pos*(self: ptr Layout00; index: int32; pos: var Rectangle00) {.
    importc: "pango_layout_index_to_pos", libprag.}

proc indexToPos*(self: ptr Layout00; index: int32; pos: var Rectangle00) {.
    importc: "pango_layout_index_to_pos", libprag.}

proc pango_layout_is_ellipsized*(self: ptr Layout00): gboolean {.
    importc: "pango_layout_is_ellipsized", libprag.}

proc isEllipsized*(self: Layout): bool =
  toBool(pango_layout_is_ellipsized(cast[ptr Layout00](self.impl)))

proc pango_layout_is_wrapped*(self: ptr Layout00): gboolean {.
    importc: "pango_layout_is_wrapped", libprag.}

proc isWrapped*(self: Layout): bool =
  toBool(pango_layout_is_wrapped(cast[ptr Layout00](self.impl)))

proc pango_layout_move_cursor_visually*(self: ptr Layout00; strong: gboolean; oldIndex: int32; 
    oldTrailing: int32; direction: int32; newIndex: var int32; newTrailing: var int32) {.
    importc: "pango_layout_move_cursor_visually", libprag.}

proc moveCursorVisually*(self: Layout; strong: bool; oldIndex: int; oldTrailing: int; 
    direction: int; newIndex: var int; newTrailing: var int) =
  var newIndex_00 = int32(newIndex)
  var newTrailing_00 = int32(newTrailing)
  pango_layout_move_cursor_visually(cast[ptr Layout00](self.impl), gboolean(strong), int32(oldIndex), int32(oldTrailing), int32(direction), newIndex_00, newTrailing_00)
  newIndex = int(newIndex_00)
  newTrailing = int(newTrailing_00)

proc pango_layout_set_alignment*(self: ptr Layout00; alignment: Alignment) {.
    importc: "pango_layout_set_alignment", libprag.}

proc setAlignment*(self: Layout; alignment: Alignment) =
  pango_layout_set_alignment(cast[ptr Layout00](self.impl), alignment)

proc `alignment=`*(self: Layout; alignment: Alignment) =
  pango_layout_set_alignment(cast[ptr Layout00](self.impl), alignment)

proc pango_layout_set_attributes*(self: ptr Layout00; attrs: ptr AttrList00) {.
    importc: "pango_layout_set_attributes", libprag.}

proc setAttributes*(self: Layout; attrs: AttrList) =
  pango_layout_set_attributes(cast[ptr Layout00](self.impl), cast[ptr AttrList00](attrs.impl))

proc `attributes=`*(self: Layout; attrs: AttrList) =
  pango_layout_set_attributes(cast[ptr Layout00](self.impl), cast[ptr AttrList00](attrs.impl))

proc pango_layout_set_auto_dir*(self: ptr Layout00; autoDir: gboolean) {.
    importc: "pango_layout_set_auto_dir", libprag.}

proc setAutoDir*(self: Layout; autoDir: bool) =
  pango_layout_set_auto_dir(cast[ptr Layout00](self.impl), gboolean(autoDir))

proc `autoDir=`*(self: Layout; autoDir: bool) =
  pango_layout_set_auto_dir(cast[ptr Layout00](self.impl), gboolean(autoDir))

proc pango_layout_set_ellipsize*(self: ptr Layout00; ellipsize: EllipsizeMode) {.
    importc: "pango_layout_set_ellipsize", libprag.}

proc setEllipsize*(self: Layout; ellipsize: EllipsizeMode) =
  pango_layout_set_ellipsize(cast[ptr Layout00](self.impl), ellipsize)

proc `ellipsize=`*(self: Layout; ellipsize: EllipsizeMode) =
  pango_layout_set_ellipsize(cast[ptr Layout00](self.impl), ellipsize)

proc pango_layout_set_font_description*(self: ptr Layout00; desc: ptr FontDescription00) {.
    importc: "pango_layout_set_font_description", libprag.}

proc setFontDescription*(self: Layout; desc: FontDescription) =
  pango_layout_set_font_description(cast[ptr Layout00](self.impl), cast[ptr FontDescription00](desc.impl))

proc `fontDescription=`*(self: Layout; desc: FontDescription) =
  pango_layout_set_font_description(cast[ptr Layout00](self.impl), cast[ptr FontDescription00](desc.impl))

proc pango_layout_set_height*(self: ptr Layout00; height: int32) {.
    importc: "pango_layout_set_height", libprag.}

proc setHeight*(self: Layout; height: int) =
  pango_layout_set_height(cast[ptr Layout00](self.impl), int32(height))

proc `height=`*(self: Layout; height: int) =
  pango_layout_set_height(cast[ptr Layout00](self.impl), int32(height))

proc pango_layout_set_indent*(self: ptr Layout00; indent: int32) {.
    importc: "pango_layout_set_indent", libprag.}

proc setIndent*(self: Layout; indent: int) =
  pango_layout_set_indent(cast[ptr Layout00](self.impl), int32(indent))

proc `indent=`*(self: Layout; indent: int) =
  pango_layout_set_indent(cast[ptr Layout00](self.impl), int32(indent))

proc pango_layout_set_justify*(self: ptr Layout00; justify: gboolean) {.
    importc: "pango_layout_set_justify", libprag.}

proc setJustify*(self: Layout; justify: bool) =
  pango_layout_set_justify(cast[ptr Layout00](self.impl), gboolean(justify))

proc `justify=`*(self: Layout; justify: bool) =
  pango_layout_set_justify(cast[ptr Layout00](self.impl), gboolean(justify))

proc pango_layout_set_markup*(self: ptr Layout00; markup: cstring; length: int32) {.
    importc: "pango_layout_set_markup", libprag.}

proc setMarkup*(self: Layout; markup: string; length: int) =
  pango_layout_set_markup(cast[ptr Layout00](self.impl), cstring(markup), int32(length))

proc pango_layout_set_markup_with_accel*(self: ptr Layout00; markup: cstring; length: int32; 
    accelMarker: gunichar; accelChar: var gunichar) {.
    importc: "pango_layout_set_markup_with_accel", libprag.}

proc setMarkupWithAccel*(self: Layout; markup: string; length: int; accelMarker: gunichar; 
    accelChar: var gunichar) =
  pango_layout_set_markup_with_accel(cast[ptr Layout00](self.impl), cstring(markup), int32(length), accelMarker, accelChar)

proc pango_layout_set_single_paragraph_mode*(self: ptr Layout00; setting: gboolean) {.
    importc: "pango_layout_set_single_paragraph_mode", libprag.}

proc setSingleParagraphMode*(self: Layout; setting: bool) =
  pango_layout_set_single_paragraph_mode(cast[ptr Layout00](self.impl), gboolean(setting))

proc `singleParagraphMode=`*(self: Layout; setting: bool) =
  pango_layout_set_single_paragraph_mode(cast[ptr Layout00](self.impl), gboolean(setting))

proc pango_layout_set_spacing*(self: ptr Layout00; spacing: int32) {.
    importc: "pango_layout_set_spacing", libprag.}

proc setSpacing*(self: Layout; spacing: int) =
  pango_layout_set_spacing(cast[ptr Layout00](self.impl), int32(spacing))

proc `spacing=`*(self: Layout; spacing: int) =
  pango_layout_set_spacing(cast[ptr Layout00](self.impl), int32(spacing))

proc pango_layout_set_text*(self: ptr Layout00; text: cstring; length: int32) {.
    importc: "pango_layout_set_text", libprag.}

proc setText*(self: Layout; text: string; length: int) =
  pango_layout_set_text(cast[ptr Layout00](self.impl), cstring(text), int32(length))

proc pango_layout_set_width*(self: ptr Layout00; width: int32) {.
    importc: "pango_layout_set_width", libprag.}

proc setWidth*(self: Layout; width: int) =
  pango_layout_set_width(cast[ptr Layout00](self.impl), int32(width))

proc `width=`*(self: Layout; width: int) =
  pango_layout_set_width(cast[ptr Layout00](self.impl), int32(width))

proc pango_layout_xy_to_index*(self: ptr Layout00; x: int32; y: int32; index: var int32; 
    trailing: var int32): gboolean {.
    importc: "pango_layout_xy_to_index", libprag.}

proc xyToIndex*(self: Layout; x: int; y: int; index: var int; trailing: var int): bool =
  var index_00 = int32(index)
  var trailing_00 = int32(trailing)
  result = toBool(pango_layout_xy_to_index(cast[ptr Layout00](self.impl), int32(x), int32(y), index_00, trailing_00))
  index = int(index_00)
  trailing = int(trailing_00)

type
  LayoutIter00* {.pure.} = object
  LayoutIter* = ref object
    impl*: ptr LayoutIter00

proc pango_layout_iter_at_last_line*(self: ptr LayoutIter00): gboolean {.
    importc: "pango_layout_iter_at_last_line", libprag.}

proc atLastLine*(self: LayoutIter): bool =
  toBool(pango_layout_iter_at_last_line(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_copy*(self: ptr LayoutIter00): ptr LayoutIter00 {.
    importc: "pango_layout_iter_copy", libprag.}

proc copy*(self: LayoutIter): LayoutIter =
  new(result)
  result.impl = pango_layout_iter_copy(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_free*(self: ptr LayoutIter00) {.
    importc: "pango_layout_iter_free", libprag.}

proc free*(self: LayoutIter) =
  pango_layout_iter_free(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_get_baseline*(self: ptr LayoutIter00): int32 {.
    importc: "pango_layout_iter_get_baseline", libprag.}

proc getBaseline*(self: LayoutIter): int =
  int(pango_layout_iter_get_baseline(cast[ptr LayoutIter00](self.impl)))

proc baseline*(self: LayoutIter): int =
  int(pango_layout_iter_get_baseline(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_get_char_extents*(self: ptr LayoutIter00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_char_extents", libprag.}

proc getCharExtents*(self: ptr LayoutIter00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_char_extents", libprag.}

proc charExtents*(self: ptr LayoutIter00; logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_char_extents", libprag.}

proc pango_layout_iter_get_cluster_extents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_cluster_extents", libprag.}

proc getClusterExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_cluster_extents", libprag.}

proc clusterExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_cluster_extents", libprag.}

proc pango_layout_iter_get_index*(self: ptr LayoutIter00): int32 {.
    importc: "pango_layout_iter_get_index", libprag.}

proc getIndex*(self: LayoutIter): int =
  int(pango_layout_iter_get_index(cast[ptr LayoutIter00](self.impl)))

proc index*(self: LayoutIter): int =
  int(pango_layout_iter_get_index(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_get_layout*(self: ptr LayoutIter00): ptr Layout00 {.
    importc: "pango_layout_iter_get_layout", libprag.}

proc getLayout*(self: LayoutIter): Layout =
  let gobj = pango_layout_iter_get_layout(cast[ptr LayoutIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Layout](g_object_get_qdata(gobj, Quark))
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

proc layout*(self: LayoutIter): Layout =
  let gobj = pango_layout_iter_get_layout(cast[ptr LayoutIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Layout](g_object_get_qdata(gobj, Quark))
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

proc pango_layout_iter_get_layout_extents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_layout_extents", libprag.}

proc getLayoutExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_layout_extents", libprag.}

proc layoutExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_layout_extents", libprag.}

proc pango_layout_iter_get_line_extents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_line_extents", libprag.}

proc getLineExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_line_extents", libprag.}

proc lineExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_line_extents", libprag.}

proc pango_layout_iter_get_line_yrange*(self: ptr LayoutIter00; y0: var int32; y1: var int32) {.
    importc: "pango_layout_iter_get_line_yrange", libprag.}

proc getLineYrange*(self: LayoutIter; y0: var int; y1: var int) =
  var y1_00 = int32(y1)
  var y0_00 = int32(y0)
  pango_layout_iter_get_line_yrange(cast[ptr LayoutIter00](self.impl), y0_00, y1_00)
  y1 = int(y1_00)
  y0 = int(y0_00)

proc lineYrange*(self: LayoutIter; y0: var int; y1: var int) =
  var y1_00 = int32(y1)
  var y0_00 = int32(y0)
  pango_layout_iter_get_line_yrange(cast[ptr LayoutIter00](self.impl), y0_00, y1_00)
  y1 = int(y1_00)
  y0 = int(y0_00)

proc pango_layout_iter_get_run*(self: ptr LayoutIter00): ptr GlyphItem00 {.
    importc: "pango_layout_iter_get_run", libprag.}

proc getRun*(self: LayoutIter): GlyphItem =
  new(result)
  result.impl = pango_layout_iter_get_run(cast[ptr LayoutIter00](self.impl))

proc run*(self: LayoutIter): GlyphItem =
  new(result)
  result.impl = pango_layout_iter_get_run(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_get_run_extents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_run_extents", libprag.}

proc getRunExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_run_extents", libprag.}

proc runExtents*(self: ptr LayoutIter00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_iter_get_run_extents", libprag.}

proc pango_layout_iter_get_run_readonly*(self: ptr LayoutIter00): ptr GlyphItem00 {.
    importc: "pango_layout_iter_get_run_readonly", libprag.}

proc getRunReadonly*(self: LayoutIter): GlyphItem =
  new(result)
  result.impl = pango_layout_iter_get_run_readonly(cast[ptr LayoutIter00](self.impl))

proc runReadonly*(self: LayoutIter): GlyphItem =
  new(result)
  result.impl = pango_layout_iter_get_run_readonly(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_next_char*(self: ptr LayoutIter00): gboolean {.
    importc: "pango_layout_iter_next_char", libprag.}

proc nextChar*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_char(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_cluster*(self: ptr LayoutIter00): gboolean {.
    importc: "pango_layout_iter_next_cluster", libprag.}

proc nextCluster*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_cluster(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_line*(self: ptr LayoutIter00): gboolean {.
    importc: "pango_layout_iter_next_line", libprag.}

proc nextLine*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_line(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_iter_next_run*(self: ptr LayoutIter00): gboolean {.
    importc: "pango_layout_iter_next_run", libprag.}

proc nextRun*(self: LayoutIter): bool =
  toBool(pango_layout_iter_next_run(cast[ptr LayoutIter00](self.impl)))

proc pango_layout_get_iter*(self: ptr Layout00): ptr LayoutIter00 {.
    importc: "pango_layout_get_iter", libprag.}

proc getIter*(self: Layout): LayoutIter =
  new(result)
  result.impl = pango_layout_get_iter(cast[ptr Layout00](self.impl))

proc iter*(self: Layout): LayoutIter =
  new(result)
  result.impl = pango_layout_get_iter(cast[ptr Layout00](self.impl))

type
  LayoutLine00* {.pure.} = object
    layout*: ptr Layout00
    startIndex*: int32
    length*: int32
    runs*: ptr pointer
    isParagraphStart*: uint32
    resolvedDir*: uint32
  LayoutLine* = ref object
    impl*: ptr LayoutLine00

proc pango_layout_line_get_extents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_extents", libprag.}

proc getExtents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_extents", libprag.}

proc extents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_extents", libprag.}

proc pango_layout_line_get_pixel_extents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_pixel_extents", libprag.}

proc getPixelExtents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_pixel_extents", libprag.}

proc pixelExtents*(self: ptr LayoutLine00; inkRect: var Rectangle00; 
    logicalRect: var Rectangle00) {.
    importc: "pango_layout_line_get_pixel_extents", libprag.}

proc pango_layout_line_get_x_ranges*(self: ptr LayoutLine00; startIndex: int32; endIndex: int32; 
    ranges: var int32Array; nRanges: var int32) {.
    importc: "pango_layout_line_get_x_ranges", libprag.}

proc getXRanges*(self: LayoutLine; startIndex: int; endIndex: int; 
    ranges: var int32Array; nRanges: var int) =
  var nRanges_00 = int32(nRanges)
  pango_layout_line_get_x_ranges(cast[ptr LayoutLine00](self.impl), int32(startIndex), int32(endIndex), ranges, nRanges_00)
  nRanges = int(nRanges_00)

proc xRanges*(self: LayoutLine; startIndex: int; endIndex: int; 
    ranges: var int32Array; nRanges: var int) =
  var nRanges_00 = int32(nRanges)
  pango_layout_line_get_x_ranges(cast[ptr LayoutLine00](self.impl), int32(startIndex), int32(endIndex), ranges, nRanges_00)
  nRanges = int(nRanges_00)

proc pango_layout_line_index_to_x*(self: ptr LayoutLine00; index: int32; trailing: gboolean; 
    xPos: var int32) {.
    importc: "pango_layout_line_index_to_x", libprag.}

proc indexToX*(self: LayoutLine; index: int; trailing: bool; xPos: var int) =
  var xPos_00 = int32(xPos)
  pango_layout_line_index_to_x(cast[ptr LayoutLine00](self.impl), int32(index), gboolean(trailing), xPos_00)
  xPos = int(xPos_00)

proc pango_layout_line_ref*(self: ptr LayoutLine00): ptr LayoutLine00 {.
    importc: "pango_layout_line_ref", libprag.}

proc `ref`*(self: LayoutLine): LayoutLine =
  new(result)
  result.impl = pango_layout_line_ref(cast[ptr LayoutLine00](self.impl))

proc pango_layout_line_unref*(self: ptr LayoutLine00) {.
    importc: "pango_layout_line_unref", libprag.}

proc unref*(self: LayoutLine) =
  pango_layout_line_unref(cast[ptr LayoutLine00](self.impl))

proc pango_layout_line_x_to_index*(self: ptr LayoutLine00; xPos: int32; index: var int32; 
    trailing: var int32): gboolean {.
    importc: "pango_layout_line_x_to_index", libprag.}

proc xToIndex*(self: LayoutLine; xPos: int; index: var int; trailing: var int): bool =
  var index_00 = int32(index)
  var trailing_00 = int32(trailing)
  result = toBool(pango_layout_line_x_to_index(cast[ptr LayoutLine00](self.impl), int32(xPos), index_00, trailing_00))
  index = int(index_00)
  trailing = int(trailing_00)

proc pango_layout_get_line*(self: ptr Layout00; line: int32): ptr LayoutLine00 {.
    importc: "pango_layout_get_line", libprag.}

proc getLine*(self: Layout; line: int): LayoutLine =
  new(result)
  result.impl = pango_layout_get_line(cast[ptr Layout00](self.impl), int32(line))

proc line*(self: Layout; line: int): LayoutLine =
  new(result)
  result.impl = pango_layout_get_line(cast[ptr Layout00](self.impl), int32(line))

proc pango_layout_get_line_readonly*(self: ptr Layout00; line: int32): ptr LayoutLine00 {.
    importc: "pango_layout_get_line_readonly", libprag.}

proc getLineReadonly*(self: Layout; line: int): LayoutLine =
  new(result)
  result.impl = pango_layout_get_line_readonly(cast[ptr Layout00](self.impl), int32(line))

proc lineReadonly*(self: Layout; line: int): LayoutLine =
  new(result)
  result.impl = pango_layout_get_line_readonly(cast[ptr Layout00](self.impl), int32(line))

proc pango_layout_iter_get_line*(self: ptr LayoutIter00): ptr LayoutLine00 {.
    importc: "pango_layout_iter_get_line", libprag.}

proc getLine*(self: LayoutIter): LayoutLine =
  new(result)
  result.impl = pango_layout_iter_get_line(cast[ptr LayoutIter00](self.impl))

proc line*(self: LayoutIter): LayoutLine =
  new(result)
  result.impl = pango_layout_iter_get_line(cast[ptr LayoutIter00](self.impl))

proc pango_layout_iter_get_line_readonly*(self: ptr LayoutIter00): ptr LayoutLine00 {.
    importc: "pango_layout_iter_get_line_readonly", libprag.}

proc getLineReadonly*(self: LayoutIter): LayoutLine =
  new(result)
  result.impl = pango_layout_iter_get_line_readonly(cast[ptr LayoutIter00](self.impl))

proc lineReadonly*(self: LayoutIter): LayoutLine =
  new(result)
  result.impl = pango_layout_iter_get_line_readonly(cast[ptr LayoutIter00](self.impl))

type
  TabArray00* {.pure.} = object
  TabArray* = ref object
    impl*: ptr TabArray00

proc pango_tab_array_new*(initialSize: int32; positionsInPixels: gboolean): ptr TabArray00 {.
    importc: "pango_tab_array_new", libprag.}

proc newTabArray*(initialSize: int; positionsInPixels: bool): TabArray =
  new(result)
  result.impl = pango_tab_array_new(int32(initialSize), gboolean(positionsInPixels))

proc initTabArray*[T](result: var T; initialSize: int; positionsInPixels: bool) =
  assert(result is TabArray)
  new(result)
  result.impl = pango_tab_array_new(int32(initialSize), gboolean(positionsInPixels))

proc pango_tab_array_copy*(self: ptr TabArray00): ptr TabArray00 {.
    importc: "pango_tab_array_copy", libprag.}

proc copy*(self: TabArray): TabArray =
  new(result)
  result.impl = pango_tab_array_copy(cast[ptr TabArray00](self.impl))

proc pango_tab_array_free*(self: ptr TabArray00) {.
    importc: "pango_tab_array_free", libprag.}

proc free*(self: TabArray) =
  pango_tab_array_free(cast[ptr TabArray00](self.impl))

proc pango_tab_array_get_positions_in_pixels*(self: ptr TabArray00): gboolean {.
    importc: "pango_tab_array_get_positions_in_pixels", libprag.}

proc getPositionsInPixels*(self: TabArray): bool =
  toBool(pango_tab_array_get_positions_in_pixels(cast[ptr TabArray00](self.impl)))

proc positionsInPixels*(self: TabArray): bool =
  toBool(pango_tab_array_get_positions_in_pixels(cast[ptr TabArray00](self.impl)))

proc pango_tab_array_get_size*(self: ptr TabArray00): int32 {.
    importc: "pango_tab_array_get_size", libprag.}

proc getSize*(self: TabArray): int =
  int(pango_tab_array_get_size(cast[ptr TabArray00](self.impl)))

proc size*(self: TabArray): int =
  int(pango_tab_array_get_size(cast[ptr TabArray00](self.impl)))

proc pango_tab_array_resize*(self: ptr TabArray00; newSize: int32) {.
    importc: "pango_tab_array_resize", libprag.}

proc resize*(self: TabArray; newSize: int) =
  pango_tab_array_resize(cast[ptr TabArray00](self.impl), int32(newSize))

proc pango_layout_get_tabs*(self: ptr Layout00): ptr TabArray00 {.
    importc: "pango_layout_get_tabs", libprag.}

proc getTabs*(self: Layout): TabArray =
  new(result)
  result.impl = pango_layout_get_tabs(cast[ptr Layout00](self.impl))

proc tabs*(self: Layout): TabArray =
  new(result)
  result.impl = pango_layout_get_tabs(cast[ptr Layout00](self.impl))

proc pango_layout_set_tabs*(self: ptr Layout00; tabs: ptr TabArray00) {.
    importc: "pango_layout_set_tabs", libprag.}

proc setTabs*(self: Layout; tabs: TabArray) =
  pango_layout_set_tabs(cast[ptr Layout00](self.impl), cast[ptr TabArray00](tabs.impl))

proc `tabs=`*(self: Layout; tabs: TabArray) =
  pango_layout_set_tabs(cast[ptr Layout00](self.impl), cast[ptr TabArray00](tabs.impl))

type
  TabAlign* {.size: sizeof(cint), pure.} = enum
    left = 0

proc pango_tab_array_get_tab*(self: ptr TabArray00; tabIndex: int32; alignment: var TabAlign; 
    location: var int32) {.
    importc: "pango_tab_array_get_tab", libprag.}

proc getTab*(self: TabArray; tabIndex: int; alignment: var TabAlign; 
    location: var int) =
  var location_00 = int32(location)
  pango_tab_array_get_tab(cast[ptr TabArray00](self.impl), int32(tabIndex), alignment, location_00)
  location = int(location_00)

proc tab*(self: TabArray; tabIndex: int; alignment: var TabAlign; 
    location: var int) =
  var location_00 = int32(location)
  pango_tab_array_get_tab(cast[ptr TabArray00](self.impl), int32(tabIndex), alignment, location_00)
  location = int(location_00)

proc pango_tab_array_get_tabs*(self: ptr TabArray00; alignments: var ptr TabAlign; 
    locations: var int32Array) {.
    importc: "pango_tab_array_get_tabs", libprag.}

proc getTabs*(self: TabArray; alignments: var ptr TabAlign; locations: var int32Array) =
  pango_tab_array_get_tabs(cast[ptr TabArray00](self.impl), alignments, locations)

proc tabs*(self: TabArray; alignments: var ptr TabAlign; locations: var int32Array) =
  pango_tab_array_get_tabs(cast[ptr TabArray00](self.impl), alignments, locations)

proc pango_tab_array_set_tab*(self: ptr TabArray00; tabIndex: int32; alignment: TabAlign; 
    location: int32) {.
    importc: "pango_tab_array_set_tab", libprag.}

proc setTab*(self: TabArray; tabIndex: int; alignment: TabAlign; 
    location: int) =
  pango_tab_array_set_tab(cast[ptr TabArray00](self.impl), int32(tabIndex), alignment, int32(location))

type
  WrapMode* {.size: sizeof(cint), pure.} = enum
    word = 0
    char = 1
    wordChar = 2

proc pango_layout_get_wrap*(self: ptr Layout00): WrapMode {.
    importc: "pango_layout_get_wrap", libprag.}

proc getWrap*(self: Layout): WrapMode =
  pango_layout_get_wrap(cast[ptr Layout00](self.impl))

proc wrap*(self: Layout): WrapMode =
  pango_layout_get_wrap(cast[ptr Layout00](self.impl))

proc pango_layout_set_wrap*(self: ptr Layout00; wrap: WrapMode) {.
    importc: "pango_layout_set_wrap", libprag.}

proc setWrap*(self: Layout; wrap: WrapMode) =
  pango_layout_set_wrap(cast[ptr Layout00](self.impl), wrap)

proc `wrap=`*(self: Layout; wrap: WrapMode) =
  pango_layout_set_wrap(cast[ptr Layout00](self.impl), wrap)

type
  LayoutClass00* {.pure.} = object
  LayoutClass* = ref object
    impl*: ptr LayoutClass00

type
  Map00* {.pure.} = object
  Map* = ref object
    impl*: ptr Map00

type
  MapEntry00* {.pure.} = object
  MapEntry* = ref object
    impl*: ptr MapEntry00

const RENDER_TYPE_NONE* = "PangoRenderNone"

type
  RenderPart* {.size: sizeof(cint), pure.} = enum
    foreground = 0
    background = 1
    underline = 2
    strikethrough = 3

type
  Underline* {.size: sizeof(cint), pure.} = enum
    none = 0
    single = 1
    double = 2
    low = 3
    error = 4

type
  RendererPrivate00* {.pure.} = object
  RendererPrivate* = ref object
    impl*: ptr RendererPrivate00

type
  Renderer* = ref object of gobject.Object
  Renderer00* = object of gobject.Object00
    underline*: Underline
    strikethrough*: gboolean
    activeCount*: int32
    matrix*: ptr Matrix00
    priv1: ptr RendererPrivate00

proc pango_renderer_activate*(self: ptr Renderer00) {.
    importc: "pango_renderer_activate", libprag.}

proc activate*(self: Renderer) =
  pango_renderer_activate(cast[ptr Renderer00](self.impl))

proc pango_renderer_deactivate*(self: ptr Renderer00) {.
    importc: "pango_renderer_deactivate", libprag.}

proc deactivate*(self: Renderer) =
  pango_renderer_deactivate(cast[ptr Renderer00](self.impl))

proc pango_renderer_draw_error_underline*(self: ptr Renderer00; x: int32; y: int32; width: int32; 
    height: int32) {.
    importc: "pango_renderer_draw_error_underline", libprag.}

proc drawErrorUnderline*(self: Renderer; x: int; y: int; width: int; height: int) =
  pango_renderer_draw_error_underline(cast[ptr Renderer00](self.impl), int32(x), int32(y), int32(width), int32(height))

proc pango_renderer_draw_glyph*(self: ptr Renderer00; font: ptr Font00; glyph: uint32; 
    x: cdouble; y: cdouble) {.
    importc: "pango_renderer_draw_glyph", libprag.}

proc drawGlyph*(self: Renderer; font: Font; glyph: int; x: cdouble; 
    y: cdouble) =
  pango_renderer_draw_glyph(cast[ptr Renderer00](self.impl), cast[ptr Font00](font.impl), uint32(glyph), x, y)

proc pango_renderer_draw_glyph_item*(self: ptr Renderer00; text: cstring; glyphItem: ptr GlyphItem00; 
    x: int32; y: int32) {.
    importc: "pango_renderer_draw_glyph_item", libprag.}

proc drawGlyphItem*(self: Renderer; text: string; glyphItem: GlyphItem; 
    x: int; y: int) =
  pango_renderer_draw_glyph_item(cast[ptr Renderer00](self.impl), cstring(text), cast[ptr GlyphItem00](glyphItem.impl), int32(x), int32(y))

proc pango_renderer_draw_glyphs*(self: ptr Renderer00; font: ptr Font00; glyphs: ptr GlyphString00; 
    x: int32; y: int32) {.
    importc: "pango_renderer_draw_glyphs", libprag.}

proc drawGlyphs*(self: Renderer; font: Font; glyphs: GlyphString; x: int; 
    y: int) =
  pango_renderer_draw_glyphs(cast[ptr Renderer00](self.impl), cast[ptr Font00](font.impl), cast[ptr GlyphString00](glyphs.impl), int32(x), int32(y))

proc pango_renderer_draw_layout*(self: ptr Renderer00; layout: ptr Layout00; x: int32; 
    y: int32) {.
    importc: "pango_renderer_draw_layout", libprag.}

proc drawLayout*(self: Renderer; layout: Layout; x: int; y: int) =
  pango_renderer_draw_layout(cast[ptr Renderer00](self.impl), cast[ptr Layout00](layout.impl), int32(x), int32(y))

proc pango_renderer_draw_layout_line*(self: ptr Renderer00; line: ptr LayoutLine00; x: int32; 
    y: int32) {.
    importc: "pango_renderer_draw_layout_line", libprag.}

proc drawLayoutLine*(self: Renderer; line: LayoutLine; x: int; y: int) =
  pango_renderer_draw_layout_line(cast[ptr Renderer00](self.impl), cast[ptr LayoutLine00](line.impl), int32(x), int32(y))

proc pango_renderer_draw_rectangle*(self: ptr Renderer00; part: RenderPart; x: int32; 
    y: int32; width: int32; height: int32) {.
    importc: "pango_renderer_draw_rectangle", libprag.}

proc drawRectangle*(self: Renderer; part: RenderPart; x: int; y: int; 
    width: int; height: int) =
  pango_renderer_draw_rectangle(cast[ptr Renderer00](self.impl), part, int32(x), int32(y), int32(width), int32(height))

proc pango_renderer_draw_trapezoid*(self: ptr Renderer00; part: RenderPart; y1: cdouble; 
    x11: cdouble; x21: cdouble; y2: cdouble; x12: cdouble; x22: cdouble) {.
    importc: "pango_renderer_draw_trapezoid", libprag.}

proc drawTrapezoid*(self: Renderer; part: RenderPart; y1: cdouble; x11: cdouble; 
    x21: cdouble; y2: cdouble; x12: cdouble; x22: cdouble) =
  pango_renderer_draw_trapezoid(cast[ptr Renderer00](self.impl), part, y1, x11, x21, y2, x12, x22)

proc pango_renderer_get_alpha*(self: ptr Renderer00; part: RenderPart): uint16 {.
    importc: "pango_renderer_get_alpha", libprag.}

proc getAlpha*(self: Renderer; part: RenderPart): uint16 =
  pango_renderer_get_alpha(cast[ptr Renderer00](self.impl), part)

proc alpha*(self: Renderer; part: RenderPart): uint16 =
  pango_renderer_get_alpha(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_get_color*(self: ptr Renderer00; part: RenderPart): ptr Color00 {.
    importc: "pango_renderer_get_color", libprag.}

proc getColor*(self: Renderer; part: RenderPart): Color =
  new(result)
  result.impl = pango_renderer_get_color(cast[ptr Renderer00](self.impl), part)

proc color*(self: Renderer; part: RenderPart): Color =
  new(result)
  result.impl = pango_renderer_get_color(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_get_layout*(self: ptr Renderer00): ptr Layout00 {.
    importc: "pango_renderer_get_layout", libprag.}

proc getLayout*(self: Renderer): Layout =
  let gobj = pango_renderer_get_layout(cast[ptr Renderer00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Layout](g_object_get_qdata(gobj, Quark))
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

proc layout*(self: Renderer): Layout =
  let gobj = pango_renderer_get_layout(cast[ptr Renderer00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Layout](g_object_get_qdata(gobj, Quark))
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

proc pango_renderer_get_layout_line*(self: ptr Renderer00): ptr LayoutLine00 {.
    importc: "pango_renderer_get_layout_line", libprag.}

proc getLayoutLine*(self: Renderer): LayoutLine =
  new(result)
  result.impl = pango_renderer_get_layout_line(cast[ptr Renderer00](self.impl))

proc layoutLine*(self: Renderer): LayoutLine =
  new(result)
  result.impl = pango_renderer_get_layout_line(cast[ptr Renderer00](self.impl))

proc pango_renderer_get_matrix*(self: ptr Renderer00): ptr Matrix00 {.
    importc: "pango_renderer_get_matrix", libprag.}

proc getMatrix*(self: Renderer): Matrix =
  new(result)
  result.impl = pango_renderer_get_matrix(cast[ptr Renderer00](self.impl))

proc matrix*(self: Renderer): Matrix =
  new(result)
  result.impl = pango_renderer_get_matrix(cast[ptr Renderer00](self.impl))

proc pango_renderer_part_changed*(self: ptr Renderer00; part: RenderPart) {.
    importc: "pango_renderer_part_changed", libprag.}

proc partChanged*(self: Renderer; part: RenderPart) =
  pango_renderer_part_changed(cast[ptr Renderer00](self.impl), part)

proc pango_renderer_set_alpha*(self: ptr Renderer00; part: RenderPart; alpha: uint16) {.
    importc: "pango_renderer_set_alpha", libprag.}

proc setAlpha*(self: Renderer; part: RenderPart; alpha: uint16) =
  pango_renderer_set_alpha(cast[ptr Renderer00](self.impl), part, alpha)

proc pango_renderer_set_color*(self: ptr Renderer00; part: RenderPart; color: ptr Color00) {.
    importc: "pango_renderer_set_color", libprag.}

proc setColor*(self: Renderer; part: RenderPart; color: Color) =
  pango_renderer_set_color(cast[ptr Renderer00](self.impl), part, cast[ptr Color00](color.impl))

proc pango_renderer_set_matrix*(self: ptr Renderer00; matrix: ptr Matrix00) {.
    importc: "pango_renderer_set_matrix", libprag.}

proc setMatrix*(self: Renderer; matrix: Matrix) =
  pango_renderer_set_matrix(cast[ptr Renderer00](self.impl), cast[ptr Matrix00](matrix.impl))

proc `matrix=`*(self: Renderer; matrix: Matrix) =
  pango_renderer_set_matrix(cast[ptr Renderer00](self.impl), cast[ptr Matrix00](matrix.impl))

type
  RendererClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    drawGlyphs*: proc(renderer: ptr Renderer00; font: ptr Font00; glyphs: ptr GlyphString00; 
    x: int32; y: int32) {.cdecl.}
    drawRectangle*: proc(renderer: ptr Renderer00; part: RenderPart; x: int32; 
    y: int32; width: int32; height: int32) {.cdecl.}
    drawErrorUnderline*: proc(renderer: ptr Renderer00; x: int32; y: int32; width: int32; 
    height: int32) {.cdecl.}
    drawShape*: proc(renderer: ptr Renderer00; attr: ptr AttrShape00; x: int32; 
    y: int32) {.cdecl.}
    drawTrapezoid*: proc(renderer: ptr Renderer00; part: RenderPart; y1: cdouble; 
    x11: cdouble; x21: cdouble; y2: cdouble; x12: cdouble; x22: cdouble) {.cdecl.}
    drawGlyph*: proc(renderer: ptr Renderer00; font: ptr Font00; glyph: uint32; 
    x: cdouble; y: cdouble) {.cdecl.}
    partChanged*: proc(renderer: ptr Renderer00; part: RenderPart) {.cdecl.}
    begin*: proc(renderer: ptr Renderer00) {.cdecl.}
    `end`*: proc(renderer: ptr Renderer00) {.cdecl.}
    prepareRun*: proc(renderer: ptr Renderer00; run: ptr GlyphItem00) {.cdecl.}
    drawGlyphItem*: proc(renderer: ptr Renderer00; text: cstring; glyphItem: ptr GlyphItem00; 
    x: int32; y: int32) {.cdecl.}
    pangoReserved2*: pointer
    pangoReserved3*: pointer
    pangoReserved4*: pointer
  RendererClass* = ref object
    impl*: ptr RendererClass00

const SCALE* = 1024'i32

type
  ScriptForLang00* {.pure.} = object
    lang*: array[7, int8]
    scripts*: array[3, Script]
  ScriptForLang* = ref object
    impl*: ptr ScriptForLang00

type
  ScriptIter00* {.pure.} = object
  ScriptIter* = ref object
    impl*: ptr ScriptIter00

proc pango_script_iter_free*(self: ptr ScriptIter00) {.
    importc: "pango_script_iter_free", libprag.}

proc free*(self: ScriptIter) =
  pango_script_iter_free(cast[ptr ScriptIter00](self.impl))

proc pango_script_iter_get_range*(self: ptr ScriptIter00; start: var cstring; `end`: var cstring; 
    script: var Script) {.
    importc: "pango_script_iter_get_range", libprag.}

proc getRange*(self: ScriptIter; start: var string; `end`: var string; 
    script: var Script) =
  var end_00 = cstring(`end`)
  var start_00 = cstring(start)
  pango_script_iter_get_range(cast[ptr ScriptIter00](self.impl), start_00, end_00, script)
  `end` = $(end_00)
  start = $(start_00)

proc range*(self: ScriptIter; start: var string; `end`: var string; 
    script: var Script) =
  var end_00 = cstring(`end`)
  var start_00 = cstring(start)
  pango_script_iter_get_range(cast[ptr ScriptIter00](self.impl), start_00, end_00, script)
  `end` = $(end_00)
  start = $(start_00)

proc pango_script_iter_next*(self: ptr ScriptIter00): gboolean {.
    importc: "pango_script_iter_next", libprag.}

proc next*(self: ScriptIter): bool =
  toBool(pango_script_iter_next(cast[ptr ScriptIter00](self.impl)))

const UNKNOWN_GLYPH_HEIGHT* = 14'i32

const UNKNOWN_GLYPH_WIDTH* = 10'i32

const VERSION_MIN_REQUIRED* = 2'i32

proc pango_break*(text: cstring; length: int32; analysis: ptr Analysis00; 
    attrs: LogAttr00Array; attrsLen: int32) {.
    importc: "pango_break", libprag.}

proc `break`*(text: string; length: int; analysis: Analysis; attrs: LogAttr00Array; 
    attrsLen: int) =
  pango_break(cstring(text), int32(length), cast[ptr Analysis00](analysis.impl), attrs, int32(attrsLen))

proc pango_config_key_get*(key: cstring): cstring {.
    importc: "pango_config_key_get", libprag.}

proc configKeyGet*(key: string): string =
  let resul0 = pango_config_key_get(cstring(key))
  result = $resul0
  cogfree(resul0)

proc pango_config_key_get_system*(key: cstring): cstring {.
    importc: "pango_config_key_get_system", libprag.}

proc configKeyGetSystem*(key: string): string =
  let resul0 = pango_config_key_get_system(cstring(key))
  result = $resul0
  cogfree(resul0)

proc pango_default_break*(text: cstring; length: int32; analysis: ptr Analysis00; 
    attrs: ptr LogAttr00; attrsLen: int32) {.
    importc: "pango_default_break", libprag.}

proc defaultBreak*(text: string; length: int; analysis: Analysis; attrs: LogAttr; 
    attrsLen: int) =
  pango_default_break(cstring(text), int32(length), cast[ptr Analysis00](analysis.impl), cast[ptr LogAttr00](attrs.impl), int32(attrsLen))

proc pango_extents_to_pixels*(inclusive: ptr Rectangle00; nearest: ptr Rectangle00) {.
    importc: "pango_extents_to_pixels", libprag.}

proc extentsToPixels*(inclusive: Rectangle; nearest: Rectangle) =
  pango_extents_to_pixels(cast[ptr Rectangle00](inclusive.impl), cast[ptr Rectangle00](nearest.impl))

proc pango_find_base_dir*(text: cstring; length: int32): Direction {.
    importc: "pango_find_base_dir", libprag.}

proc findBaseDir*(text: cstring; length: int32): Direction {.
    importc: "pango_find_base_dir", libprag.}

proc pango_find_paragraph_boundary*(text: cstring; length: int32; paragraphDelimiterIndex: var int32; 
    nextParagraphStart: var int32) {.
    importc: "pango_find_paragraph_boundary", libprag.}

proc findParagraphBoundary*(text: cstring; length: int32; paragraphDelimiterIndex: var int32; 
    nextParagraphStart: var int32) {.
    importc: "pango_find_paragraph_boundary", libprag.}

proc pango_get_lib_subdirectory*(): cstring {.
    importc: "pango_get_lib_subdirectory", libprag.}

proc getLibSubdirectory*(): string =
  let resul0 = pango_get_lib_subdirectory()
  result = $resul0

proc libSubdirectory*(): string =
  let resul0 = pango_get_lib_subdirectory()
  result = $resul0

proc pango_get_log_attrs*(text: cstring; length: int32; level: int32; language: ptr Language00; 
    logAttrs: LogAttr00Array; attrsLen: int32) {.
    importc: "pango_get_log_attrs", libprag.}

proc getLogAttrs*(text: string; length: int; level: int; language: Language; 
    logAttrs: LogAttr00Array; attrsLen: int) =
  pango_get_log_attrs(cstring(text), int32(length), int32(level), cast[ptr Language00](language.impl), logAttrs, int32(attrsLen))

proc logAttrs*(text: string; length: int; level: int; language: Language; 
    logAttrs: LogAttr00Array; attrsLen: int) =
  pango_get_log_attrs(cstring(text), int32(length), int32(level), cast[ptr Language00](language.impl), logAttrs, int32(attrsLen))

proc pango_get_mirror_char*(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc: "pango_get_mirror_char", libprag.}

proc getMirrorChar*(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc: "pango_get_mirror_char", libprag.}

proc mirrorChar*(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc: "pango_get_mirror_char", libprag.}

proc pango_get_sysconf_subdirectory*(): cstring {.
    importc: "pango_get_sysconf_subdirectory", libprag.}

proc getSysconfSubdirectory*(): string =
  let resul0 = pango_get_sysconf_subdirectory()
  result = $resul0

proc sysconfSubdirectory*(): string =
  let resul0 = pango_get_sysconf_subdirectory()
  result = $resul0

proc pango_is_zero_width*(ch: gunichar): gboolean {.
    importc: "pango_is_zero_width", libprag.}

proc isZeroWidth*(ch: gunichar): gboolean {.
    importc: "pango_is_zero_width", libprag.}

proc pango_itemize*(context: ptr Context00; text: cstring; startIndex: int32; 
    length: int32; attrs: ptr AttrList00; cachedIter: ptr AttrIterator00): ptr pointer {.
    importc: "pango_itemize", libprag.}

proc itemize*(context: Context; text: string; startIndex: int; length: int; 
    attrs: AttrList; cachedIter: AttrIterator): ptr pointer =
  pango_itemize(cast[ptr Context00](context.impl), cstring(text), int32(startIndex), int32(length), cast[ptr AttrList00](attrs.impl), cast[ptr AttrIterator00](cachedIter.impl))

proc pango_itemize_with_base_dir*(context: ptr Context00; baseDir: Direction; text: cstring; 
    startIndex: int32; length: int32; attrs: ptr AttrList00; cachedIter: ptr AttrIterator00): ptr pointer {.
    importc: "pango_itemize_with_base_dir", libprag.}

proc itemizeWithBaseDir*(context: Context; baseDir: Direction; text: string; 
    startIndex: int; length: int; attrs: AttrList; cachedIter: AttrIterator): ptr pointer =
  pango_itemize_with_base_dir(cast[ptr Context00](context.impl), baseDir, cstring(text), int32(startIndex), int32(length), cast[ptr AttrList00](attrs.impl), cast[ptr AttrIterator00](cachedIter.impl))

proc pango_log2vis_get_embedding_levels*(text: cstring; length: int32; pbaseDir: ptr Direction): ptr uint8 {.
    importc: "pango_log2vis_get_embedding_levels", libprag.}

proc log2visGetEmbeddingLevels*(text: cstring; length: int32; pbaseDir: ptr Direction): ptr uint8 {.
    importc: "pango_log2vis_get_embedding_levels", libprag.}

proc pango_lookup_aliases*(fontname: cstring; families: var cstringArray; nFamilies: var int32) {.
    importc: "pango_lookup_aliases", libprag.}

proc lookupAliases*(fontname: cstring; families: var cstringArray; nFamilies: var int32) {.
    importc: "pango_lookup_aliases", libprag.}

proc pango_markup_parser_finish*(context: ptr glib.MarkupParseContext00; attrList: var ptr AttrList00; 
    text: var cstring; accelChar: var gunichar): gboolean {.
    importc: "pango_markup_parser_finish", libprag.}

proc markupParserFinish*(context: ptr glib.MarkupParseContext00; attrList: var ptr AttrList00; 
    text: var cstring; accelChar: var gunichar): gboolean {.
    importc: "pango_markup_parser_finish", libprag.}

proc pango_markup_parser_new*(accelMarker: gunichar): ptr glib.MarkupParseContext00 {.
    importc: "pango_markup_parser_new", libprag.}

proc markupParserNew*(accelMarker: gunichar): glib.MarkupParseContext =
  new(result)
  result.impl = pango_markup_parser_new(accelMarker)

proc pango_module_register*(module: ptr IncludedModule00) {.
    importc: "pango_module_register", libprag.}

proc moduleRegister*(module: IncludedModule) =
  pango_module_register(cast[ptr IncludedModule00](module.impl))

proc pango_parse_enum*(`type`: GType; str: cstring; value: var int32; warn: gboolean; 
    possibleValues: var cstring): gboolean {.
    importc: "pango_parse_enum", libprag.}

proc parseEnum*(`type`: GType; str: cstring; value: var int32; warn: gboolean; 
    possibleValues: var cstring): gboolean {.
    importc: "pango_parse_enum", libprag.}

proc pango_parse_markup*(markupText: cstring; length: int32; accelMarker: gunichar; 
    attrList: var ptr AttrList00; text: var cstring; accelChar: var gunichar): gboolean {.
    importc: "pango_parse_markup", libprag.}

proc parseMarkup*(markupText: cstring; length: int32; accelMarker: gunichar; 
    attrList: var ptr AttrList00; text: var cstring; accelChar: var gunichar): gboolean {.
    importc: "pango_parse_markup", libprag.}

proc pango_parse_stretch*(str: cstring; stretch: var Stretch; warn: gboolean): gboolean {.
    importc: "pango_parse_stretch", libprag.}

proc parseStretch*(str: cstring; stretch: var Stretch; warn: gboolean): gboolean {.
    importc: "pango_parse_stretch", libprag.}

proc pango_parse_style*(str: cstring; style: var Style; warn: gboolean): gboolean {.
    importc: "pango_parse_style", libprag.}

proc parseStyle*(str: cstring; style: var Style; warn: gboolean): gboolean {.
    importc: "pango_parse_style", libprag.}

proc pango_parse_variant*(str: cstring; variant: var Variant; warn: gboolean): gboolean {.
    importc: "pango_parse_variant", libprag.}

proc parseVariant*(str: cstring; variant: var Variant; warn: gboolean): gboolean {.
    importc: "pango_parse_variant", libprag.}

proc pango_parse_weight*(str: cstring; weight: var Weight; warn: gboolean): gboolean {.
    importc: "pango_parse_weight", libprag.}

proc parseWeight*(str: cstring; weight: var Weight; warn: gboolean): gboolean {.
    importc: "pango_parse_weight", libprag.}

proc pango_quantize_line_geometry*(thickness: int32; position: int32) {.
    importc: "pango_quantize_line_geometry", libprag.}

proc quantizeLineGeometry*(thickness: int32; position: int32) {.
    importc: "pango_quantize_line_geometry", libprag.}

proc pango_read_line*(stream: pointer; str: var glib.String00): int32 {.
    importc: "pango_read_line", libprag.}

proc readLine*(stream: pointer; str: var glib.String00): int32 {.
    importc: "pango_read_line", libprag.}

proc pango_reorder_items*(logicalItems: ptr pointer): ptr pointer {.
    importc: "pango_reorder_items", libprag.}

proc reorderItems*(logicalItems: ptr pointer): ptr pointer {.
    importc: "pango_reorder_items", libprag.}

proc pango_scan_int*(pos: cstring; `out`: var int32): gboolean {.
    importc: "pango_scan_int", libprag.}

proc scanInt*(pos: cstring; `out`: var int32): gboolean {.
    importc: "pango_scan_int", libprag.}

proc pango_scan_string*(pos: cstring; `out`: var glib.String00): gboolean {.
    importc: "pango_scan_string", libprag.}

proc scanString*(pos: cstring; `out`: var glib.String00): gboolean {.
    importc: "pango_scan_string", libprag.}

proc pango_scan_word*(pos: cstring; `out`: var glib.String00): gboolean {.
    importc: "pango_scan_word", libprag.}

proc scanWord*(pos: cstring; `out`: var glib.String00): gboolean {.
    importc: "pango_scan_word", libprag.}

proc pango_shape*(text: cstring; length: int32; analysis: ptr Analysis00; 
    glyphs: ptr GlyphString00) {.
    importc: "pango_shape", libprag.}

proc shape*(text: string; length: int; analysis: Analysis; glyphs: GlyphString) =
  pango_shape(cstring(text), int32(length), cast[ptr Analysis00](analysis.impl), cast[ptr GlyphString00](glyphs.impl))

proc pango_shape_full*(itemText: cstring; itemLength: int32; paragraphText: cstring; 
    paragraphLength: int32; analysis: ptr Analysis00; glyphs: ptr GlyphString00) {.
    importc: "pango_shape_full", libprag.}

proc shapeFull*(itemText: string; itemLength: int; paragraphText: string; 
    paragraphLength: int; analysis: Analysis; glyphs: GlyphString) =
  pango_shape_full(cstring(itemText), int32(itemLength), cstring(paragraphText), int32(paragraphLength), cast[ptr Analysis00](analysis.impl), cast[ptr GlyphString00](glyphs.impl))

proc pango_skip_space*(pos: cstring): gboolean {.
    importc: "pango_skip_space", libprag.}

proc skipSpace*(pos: cstring): gboolean {.
    importc: "pango_skip_space", libprag.}

proc pango_split_file_list*(str: cstring): cstringArray {.
    importc: "pango_split_file_list", libprag.}

proc splitFileList*(str: cstring): cstringArray {.
    importc: "pango_split_file_list", libprag.}

proc pango_trim_string*(str: cstring): cstring {.
    importc: "pango_trim_string", libprag.}

proc trimString*(str: string): string =
  let resul0 = pango_trim_string(cstring(str))
  result = $resul0
  cogfree(resul0)

proc pango_unichar_direction*(ch: gunichar): Direction {.
    importc: "pango_unichar_direction", libprag.}

proc unicharDirection*(ch: gunichar): Direction {.
    importc: "pango_unichar_direction", libprag.}

proc pango_units_from_double*(d: cdouble): int32 {.
    importc: "pango_units_from_double", libprag.}

proc unitsFromDouble*(d: cdouble): int32 {.
    importc: "pango_units_from_double", libprag.}

proc pango_units_to_double*(i: int32): cdouble {.
    importc: "pango_units_to_double", libprag.}

proc unitsToDouble*(i: int32): cdouble {.
    importc: "pango_units_to_double", libprag.}

proc pango_version*(): int32 {.
    importc: "pango_version", libprag.}

proc version*(): int32 {.
    importc: "pango_version", libprag.}

proc pango_version_check*(requiredMajor: int32; requiredMinor: int32; requiredMicro: int32): cstring {.
    importc: "pango_version_check", libprag.}

proc versionCheck*(requiredMajor: int; requiredMinor: int; requiredMicro: int): string =
  let resul0 = pango_version_check(int32(requiredMajor), int32(requiredMinor), int32(requiredMicro))
  result = $resul0

proc pango_version_string*(): cstring {.
    importc: "pango_version_string", libprag.}

proc versionString*(): string =
  let resul0 = pango_version_string()
  result = $resul0
# === remaining symbols:

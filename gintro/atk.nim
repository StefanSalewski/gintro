# dependencies:
# GLib-2.0
# GObject-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libatk-1.0.so.0
{.deadCodeElim: on.}
import glib, gobject
const Lib* = "libatk-1.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  StateTypeArray* = pointer
type
  TextRange00Array* = pointer
type
  PtrArray* = pointer
let Quark = g_quark_from_static_string("NimGIQuark")

type
  Action00* {.pure.} = object
  Action* = ref object
    impl*: ptr Action00

proc atk_action_do_action*(self: ptr Action00; i: int32): gboolean {.
    importc: "atk_action_do_action", libprag.}

proc doAction*(self: Action; i: int): bool =
  toBool(atk_action_do_action(cast[ptr Action00](self.impl), int32(i)))

proc atk_action_get_description*(self: ptr Action00; i: int32): cstring {.
    importc: "atk_action_get_description", libprag.}

proc getDescription*(self: Action; i: int): string =
  let resul0 = atk_action_get_description(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc description*(self: Action; i: int): string =
  let resul0 = atk_action_get_description(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc atk_action_get_keybinding*(self: ptr Action00; i: int32): cstring {.
    importc: "atk_action_get_keybinding", libprag.}

proc getKeybinding*(self: Action; i: int): string =
  let resul0 = atk_action_get_keybinding(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc keybinding*(self: Action; i: int): string =
  let resul0 = atk_action_get_keybinding(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc atk_action_get_localized_name*(self: ptr Action00; i: int32): cstring {.
    importc: "atk_action_get_localized_name", libprag.}

proc getLocalizedName*(self: Action; i: int): string =
  let resul0 = atk_action_get_localized_name(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc localizedName*(self: Action; i: int): string =
  let resul0 = atk_action_get_localized_name(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc atk_action_get_n_actions*(self: ptr Action00): int32 {.
    importc: "atk_action_get_n_actions", libprag.}

proc getNActions*(self: Action): int =
  int(atk_action_get_n_actions(cast[ptr Action00](self.impl)))

proc nActions*(self: Action): int =
  int(atk_action_get_n_actions(cast[ptr Action00](self.impl)))

proc atk_action_get_name*(self: ptr Action00; i: int32): cstring {.
    importc: "atk_action_get_name", libprag.}

proc getName*(self: Action; i: int): string =
  let resul0 = atk_action_get_name(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc name*(self: Action; i: int): string =
  let resul0 = atk_action_get_name(cast[ptr Action00](self.impl), int32(i))
  result = $resul0

proc atk_action_set_description*(self: ptr Action00; i: int32; desc: cstring): gboolean {.
    importc: "atk_action_set_description", libprag.}

proc setDescription*(self: Action; i: int; desc: string): bool =
  toBool(atk_action_set_description(cast[ptr Action00](self.impl), int32(i), cstring(desc)))

type
  ActionIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    doAction*: proc(action: ptr Action00; i: int32): gboolean {.cdecl.}
    getNActions*: proc(action: ptr Action00): int32 {.cdecl.}
    getDescription*: proc(action: ptr Action00; i: int32): cstring {.cdecl.}
    getName*: proc(action: ptr Action00; i: int32): cstring {.cdecl.}
    getKeybinding*: proc(action: ptr Action00; i: int32): cstring {.cdecl.}
    setDescription*: proc(action: ptr Action00; i: int32; desc: cstring): gboolean {.cdecl.}
    getLocalizedName*: proc(action: ptr Action00; i: int32): cstring {.cdecl.}
  ActionIface* = ref object
    impl*: ptr ActionIface00

type
  Attribute00* {.pure.} = object
    name*: cstring
    value*: cstring
  Attribute* = ref object
    impl*: ptr Attribute00

proc atk_attribute_set_free*(attribSet: ptr pointer) {.
    importc: "atk_attribute_set_free", libprag.}

proc setFree*(attribSet: ptr pointer) {.
    importc: "atk_attribute_set_free", libprag.}

proc `free=`*(attribSet: ptr pointer) {.
    importc: "atk_attribute_set_free", libprag.}

const BINARY_AGE* = 22210'i32

type
  Component00* {.pure.} = object
  Component* = ref object
    impl*: ptr Component00

proc atk_component_get_alpha*(self: ptr Component00): cdouble {.
    importc: "atk_component_get_alpha", libprag.}

proc getAlpha*(self: Component): cdouble =
  atk_component_get_alpha(cast[ptr Component00](self.impl))

proc alpha*(self: Component): cdouble =
  atk_component_get_alpha(cast[ptr Component00](self.impl))

proc atk_component_get_mdi_zorder*(self: ptr Component00): int32 {.
    importc: "atk_component_get_mdi_zorder", libprag.}

proc getMdiZorder*(self: Component): int =
  int(atk_component_get_mdi_zorder(cast[ptr Component00](self.impl)))

proc mdiZorder*(self: Component): int =
  int(atk_component_get_mdi_zorder(cast[ptr Component00](self.impl)))

proc atk_component_get_size*(self: ptr Component00; width: var int32; height: var int32) {.
    importc: "atk_component_get_size", libprag.}

proc getSize*(self: Component; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  atk_component_get_size(cast[ptr Component00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc size*(self: Component; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  atk_component_get_size(cast[ptr Component00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc atk_component_grab_focus*(self: ptr Component00): gboolean {.
    importc: "atk_component_grab_focus", libprag.}

proc grabFocus*(self: Component): bool =
  toBool(atk_component_grab_focus(cast[ptr Component00](self.impl)))

proc atk_component_remove_focus_handler*(self: ptr Component00; handlerId: uint32) {.
    importc: "atk_component_remove_focus_handler", libprag.}

proc removeFocusHandler*(self: Component; handlerId: int) =
  atk_component_remove_focus_handler(cast[ptr Component00](self.impl), uint32(handlerId))

proc atk_component_set_size*(self: ptr Component00; width: int32; height: int32): gboolean {.
    importc: "atk_component_set_size", libprag.}

proc setSize*(self: Component; width: int; height: int): bool =
  toBool(atk_component_set_size(cast[ptr Component00](self.impl), int32(width), int32(height)))

type
  Layer* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    background = 1
    canvas = 2
    widget = 3
    mdi = 4
    popup = 5
    overlay = 6
    window = 7

proc atk_component_get_layer*(self: ptr Component00): Layer {.
    importc: "atk_component_get_layer", libprag.}

proc getLayer*(self: Component): Layer =
  atk_component_get_layer(cast[ptr Component00](self.impl))

proc layer*(self: Component): Layer =
  atk_component_get_layer(cast[ptr Component00](self.impl))

type
  CoordType* {.size: sizeof(cint), pure.} = enum
    screen = 0
    window = 1

proc atk_component_contains*(self: ptr Component00; x: int32; y: int32; coordType: CoordType): gboolean {.
    importc: "atk_component_contains", libprag.}

proc contains*(self: Component; x: int; y: int; coordType: CoordType): bool =
  toBool(atk_component_contains(cast[ptr Component00](self.impl), int32(x), int32(y), coordType))

proc atk_component_get_extents*(self: ptr Component00; x: var int32; y: var int32; 
    width: var int32; height: var int32; coordType: CoordType) {.
    importc: "atk_component_get_extents", libprag.}

proc getExtents*(self: Component; x: var int; y: var int; width: var int; 
    height: var int; coordType: CoordType) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  atk_component_get_extents(cast[ptr Component00](self.impl), x_00, y_00, width_00, height_00, coordType)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc extents*(self: Component; x: var int; y: var int; width: var int; 
    height: var int; coordType: CoordType) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  atk_component_get_extents(cast[ptr Component00](self.impl), x_00, y_00, width_00, height_00, coordType)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc atk_component_get_position*(self: ptr Component00; x: var int32; y: var int32; 
    coordType: CoordType) {.
    importc: "atk_component_get_position", libprag.}

proc getPosition*(self: Component; x: var int; y: var int; coordType: CoordType) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  atk_component_get_position(cast[ptr Component00](self.impl), x_00, y_00, coordType)
  y = int(y_00)
  x = int(x_00)

proc position*(self: Component; x: var int; y: var int; coordType: CoordType) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  atk_component_get_position(cast[ptr Component00](self.impl), x_00, y_00, coordType)
  y = int(y_00)
  x = int(x_00)

proc atk_component_set_extents*(self: ptr Component00; x: int32; y: int32; width: int32; 
    height: int32; coordType: CoordType): gboolean {.
    importc: "atk_component_set_extents", libprag.}

proc setExtents*(self: Component; x: int; y: int; width: int; height: int; 
    coordType: CoordType): bool =
  toBool(atk_component_set_extents(cast[ptr Component00](self.impl), int32(x), int32(y), int32(width), int32(height), coordType))

proc atk_component_set_position*(self: ptr Component00; x: int32; y: int32; coordType: CoordType): gboolean {.
    importc: "atk_component_set_position", libprag.}

proc setPosition*(self: Component; x: int; y: int; coordType: CoordType): bool =
  toBool(atk_component_set_position(cast[ptr Component00](self.impl), int32(x), int32(y), coordType))

type
  Role* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    acceleratorLabel = 1
    alert = 2
    animation = 3
    arrow = 4
    calendar = 5
    canvas = 6
    checkBox = 7
    checkMenuItem = 8
    colorChooser = 9
    columnHeader = 10
    comboBox = 11
    dateEditor = 12
    desktopIcon = 13
    desktopFrame = 14
    dial = 15
    dialog = 16
    directoryPane = 17
    drawingArea = 18
    fileChooser = 19
    filler = 20
    fontChooser = 21
    frame = 22
    glassPane = 23
    htmlContainer = 24
    icon = 25
    image = 26
    internalFrame = 27
    label = 28
    layeredPane = 29
    list = 30
    listItem = 31
    menu = 32
    menuBar = 33
    menuItem = 34
    optionPane = 35
    pageTab = 36
    pageTabList = 37
    panel = 38
    passwordText = 39
    popupMenu = 40
    progressBar = 41
    pushButton = 42
    radioButton = 43
    radioMenuItem = 44
    rootPane = 45
    rowHeader = 46
    scrollBar = 47
    scrollPane = 48
    separator = 49
    slider = 50
    splitPane = 51
    spinButton = 52
    statusbar = 53
    table = 54
    tableCell = 55
    tableColumnHeader = 56
    tableRowHeader = 57
    tearOffMenuItem = 58
    terminal = 59
    text = 60
    toggleButton = 61
    toolBar = 62
    toolTip = 63
    tree = 64
    treeTable = 65
    unknown = 66
    viewport = 67
    window = 68
    header = 69
    footer = 70
    paragraph = 71
    ruler = 72
    application = 73
    autocomplete = 74
    editBar = 75
    embedded = 76
    entry = 77
    chart = 78
    caption = 79
    documentFrame = 80
    heading = 81
    page = 82
    section = 83
    redundantObject = 84
    form = 85
    link = 86
    inputMethodWindow = 87
    tableRow = 88
    treeItem = 89
    documentSpreadsheet = 90
    documentPresentation = 91
    documentText = 92
    documentWeb = 93
    documentEmail = 94
    comment = 95
    listBox = 96
    grouping = 97
    imageMap = 98
    notification = 99
    infoBar = 100
    levelBar = 101
    titleBar = 102
    blockQuote = 103
    audio = 104
    video = 105
    definition = 106
    article = 107
    landmark = 108
    log = 109
    marquee = 110
    math = 111
    rating = 112
    timer = 113
    descriptionList = 114
    descriptionTerm = 115
    descriptionValue = 116
    `static` = 117
    mathFraction = 118
    mathRoot = 119
    subscript = 120
    superscript = 121
    lastDefined = 122

proc atk_role_for_name*(name: cstring): Role {.
    importc: "atk_role_for_name", libprag.}

proc forName*(name: cstring): Role {.
    importc: "atk_role_for_name", libprag.}

proc atk_role_get_localized_name*(role: Role): cstring {.
    importc: "atk_role_get_localized_name", libprag.}

proc getLocalizedName*(role: Role): string =
  let resul0 = atk_role_get_localized_name(role)
  result = $resul0

proc localizedName*(role: Role): string =
  let resul0 = atk_role_get_localized_name(role)
  result = $resul0

proc atk_role_get_name*(role: Role): cstring {.
    importc: "atk_role_get_name", libprag.}

proc getName*(role: Role): string =
  let resul0 = atk_role_get_name(role)
  result = $resul0

proc name*(role: Role): string =
  let resul0 = atk_role_get_name(role)
  result = $resul0

proc atk_role_register*(name: cstring): Role {.
    importc: "atk_role_register", libprag.}

proc register*(name: cstring): Role {.
    importc: "atk_role_register", libprag.}

type
  RelationSet* = ref object of gobject.Object
  RelationSet00* = object of gobject.Object00
    relations*: ptr PtrArray

proc atk_relation_set_new*(): ptr RelationSet00 {.
    importc: "atk_relation_set_new", libprag.}

proc newRelationSet*(): RelationSet =
  new(result, finalizeGObject)
  result.impl = atk_relation_set_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRelationSet*[T](result: var T) =
  assert(result is RelationSet)
  new(result, finalizeGObject)
  result.impl = atk_relation_set_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_set_get_n_relations*(self: ptr RelationSet00): int32 {.
    importc: "atk_relation_set_get_n_relations", libprag.}

proc getNRelations*(self: RelationSet): int =
  int(atk_relation_set_get_n_relations(cast[ptr RelationSet00](self.impl)))

proc nRelations*(self: RelationSet): int =
  int(atk_relation_set_get_n_relations(cast[ptr RelationSet00](self.impl)))

type
  Object* = ref object of gobject.Object
  Object00* = object of gobject.Object00
    description*: cstring
    name*: cstring
    accessibleParent*: ptr Object00
    role*: Role
    relationSet*: ptr RelationSet00
    layer*: Layer

proc scActiveDescendantChanged*(self: Object;  p: proc (self: ptr gobject.Object00; arg1: pointer; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "active-descendant-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scChildrenChanged*(self: Object;  p: proc (self: ptr gobject.Object00; arg1: uint32; arg2: pointer; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "children-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scFocusEvent*(self: Object;  p: proc (self: ptr gobject.Object00; arg1: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "focus-event", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scPropertyChange*(self: Object;  p: proc (self: ptr gobject.Object00; arg1: pointer; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "property-change", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scStateChange*(self: Object;  p: proc (self: ptr gobject.Object00; arg1: cstring; arg2: gboolean; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "state-change", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scVisibleDataChanged*(self: Object;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "visible-data-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc atk_object_get_attributes*(self: ptr Object00): ptr pointer {.
    importc: "atk_object_get_attributes", libprag.}

proc getAttributes*(self: Object): ptr pointer =
  atk_object_get_attributes(cast[ptr Object00](self.impl))

proc attributes*(self: Object): ptr pointer =
  atk_object_get_attributes(cast[ptr Object00](self.impl))

proc atk_object_get_description*(self: ptr Object00): cstring {.
    importc: "atk_object_get_description", libprag.}

proc getDescription*(self: Object): string =
  let resul0 = atk_object_get_description(cast[ptr Object00](self.impl))
  result = $resul0

proc description*(self: Object): string =
  let resul0 = atk_object_get_description(cast[ptr Object00](self.impl))
  result = $resul0

proc atk_object_get_index_in_parent*(self: ptr Object00): int32 {.
    importc: "atk_object_get_index_in_parent", libprag.}

proc getIndexInParent*(self: Object): int =
  int(atk_object_get_index_in_parent(cast[ptr Object00](self.impl)))

proc indexInParent*(self: Object): int =
  int(atk_object_get_index_in_parent(cast[ptr Object00](self.impl)))

proc atk_object_get_layer*(self: ptr Object00): Layer {.
    importc: "atk_object_get_layer", libprag.}

proc getLayer*(self: Object): Layer =
  atk_object_get_layer(cast[ptr Object00](self.impl))

proc layer*(self: Object): Layer =
  atk_object_get_layer(cast[ptr Object00](self.impl))

proc atk_object_get_mdi_zorder*(self: ptr Object00): int32 {.
    importc: "atk_object_get_mdi_zorder", libprag.}

proc getMdiZorder*(self: Object): int =
  int(atk_object_get_mdi_zorder(cast[ptr Object00](self.impl)))

proc mdiZorder*(self: Object): int =
  int(atk_object_get_mdi_zorder(cast[ptr Object00](self.impl)))

proc atk_object_get_n_accessible_children*(self: ptr Object00): int32 {.
    importc: "atk_object_get_n_accessible_children", libprag.}

proc getNAccessibleChildren*(self: Object): int =
  int(atk_object_get_n_accessible_children(cast[ptr Object00](self.impl)))

proc nAccessibleChildren*(self: Object): int =
  int(atk_object_get_n_accessible_children(cast[ptr Object00](self.impl)))

proc atk_object_get_name*(self: ptr Object00): cstring {.
    importc: "atk_object_get_name", libprag.}

proc getName*(self: Object): string =
  let resul0 = atk_object_get_name(cast[ptr Object00](self.impl))
  result = $resul0

proc name*(self: Object): string =
  let resul0 = atk_object_get_name(cast[ptr Object00](self.impl))
  result = $resul0

proc atk_object_get_object_locale*(self: ptr Object00): cstring {.
    importc: "atk_object_get_object_locale", libprag.}

proc getObjectLocale*(self: Object): string =
  let resul0 = atk_object_get_object_locale(cast[ptr Object00](self.impl))
  result = $resul0

proc objectLocale*(self: Object): string =
  let resul0 = atk_object_get_object_locale(cast[ptr Object00](self.impl))
  result = $resul0

proc atk_object_get_parent*(self: ptr Object00): ptr Object00 {.
    importc: "atk_object_get_parent", libprag.}

proc getParent*(self: Object): Object =
  let gobj = atk_object_get_parent(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc parent*(self: Object): Object =
  let gobj = atk_object_get_parent(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_object_get_role*(self: ptr Object00): Role {.
    importc: "atk_object_get_role", libprag.}

proc getRole*(self: Object): Role =
  atk_object_get_role(cast[ptr Object00](self.impl))

proc role*(self: Object): Role =
  atk_object_get_role(cast[ptr Object00](self.impl))

proc atk_object_initialize*(self: ptr Object00; data: pointer) {.
    importc: "atk_object_initialize", libprag.}

proc initialize*(self: Object; data: pointer) =
  atk_object_initialize(cast[ptr Object00](self.impl), data)

proc atk_object_notify_state_change*(self: ptr Object00; state: uint64; value: gboolean) {.
    importc: "atk_object_notify_state_change", libprag.}

proc notifyStateChange*(self: Object; state: uint64; value: bool) =
  atk_object_notify_state_change(cast[ptr Object00](self.impl), state, gboolean(value))

proc atk_object_peek_parent*(self: ptr Object00): ptr Object00 {.
    importc: "atk_object_peek_parent", libprag.}

proc peekParent*(self: Object): Object =
  let gobj = atk_object_peek_parent(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_object_ref_accessible_child*(self: ptr Object00; i: int32): ptr Object00 {.
    importc: "atk_object_ref_accessible_child", libprag.}

proc refAccessibleChild*(self: Object; i: int): Object =
  let gobj = atk_object_ref_accessible_child(cast[ptr Object00](self.impl), int32(i))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_object_ref_relation_set*(self: ptr Object00): ptr RelationSet00 {.
    importc: "atk_object_ref_relation_set", libprag.}

proc refRelationSet*(self: Object): RelationSet =
  let gobj = atk_object_ref_relation_set(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[RelationSet](g_object_get_qdata(gobj, Quark))
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

proc atk_object_remove_property_change_handler*(self: ptr Object00; handlerId: uint32) {.
    importc: "atk_object_remove_property_change_handler", libprag.}

proc removePropertyChangeHandler*(self: Object; handlerId: int) =
  atk_object_remove_property_change_handler(cast[ptr Object00](self.impl), uint32(handlerId))

proc atk_object_set_description*(self: ptr Object00; description: cstring) {.
    importc: "atk_object_set_description", libprag.}

proc setDescription*(self: Object; description: string) =
  atk_object_set_description(cast[ptr Object00](self.impl), cstring(description))

proc `description=`*(self: Object; description: string) =
  atk_object_set_description(cast[ptr Object00](self.impl), cstring(description))

proc atk_object_set_name*(self: ptr Object00; name: cstring) {.
    importc: "atk_object_set_name", libprag.}

proc setName*(self: Object; name: string) =
  atk_object_set_name(cast[ptr Object00](self.impl), cstring(name))

proc `name=`*(self: Object; name: string) =
  atk_object_set_name(cast[ptr Object00](self.impl), cstring(name))

proc atk_object_set_parent*(self: ptr Object00; parent: ptr Object00) {.
    importc: "atk_object_set_parent", libprag.}

proc setParent*(self: Object; parent: Object) =
  atk_object_set_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl))

proc `parent=`*(self: Object; parent: Object) =
  atk_object_set_parent(cast[ptr Object00](self.impl), cast[ptr Object00](parent.impl))

proc atk_object_set_role*(self: ptr Object00; role: Role) {.
    importc: "atk_object_set_role", libprag.}

proc setRole*(self: Object; role: Role) =
  atk_object_set_role(cast[ptr Object00](self.impl), role)

proc `role=`*(self: Object; role: Role) =
  atk_object_set_role(cast[ptr Object00](self.impl), role)

proc atk_component_ref_accessible_at_point*(self: ptr Component00; x: int32; y: int32; coordType: CoordType): ptr Object00 {.
    importc: "atk_component_ref_accessible_at_point", libprag.}

proc refAccessibleAtPoint*(self: Component; x: int; y: int; coordType: CoordType): Object =
  let gobj = atk_component_ref_accessible_at_point(cast[ptr Component00](self.impl), int32(x), int32(y), coordType)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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
  StateSet* = ref object of gobject.Object
  StateSet00* = object of gobject.Object00

proc atk_state_set_new*(): ptr StateSet00 {.
    importc: "atk_state_set_new", libprag.}

proc newStateSet*(): StateSet =
  new(result, finalizeGObject)
  result.impl = atk_state_set_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initStateSet*[T](result: var T) =
  assert(result is StateSet)
  new(result, finalizeGObject)
  result.impl = atk_state_set_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_state_set_and_sets*(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc: "atk_state_set_and_sets", libprag.}

proc andSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_and_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[StateSet](g_object_get_qdata(gobj, Quark))
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

proc atk_state_set_clear_states*(self: ptr StateSet00) {.
    importc: "atk_state_set_clear_states", libprag.}

proc clearStates*(self: StateSet) =
  atk_state_set_clear_states(cast[ptr StateSet00](self.impl))

proc atk_state_set_is_empty*(self: ptr StateSet00): gboolean {.
    importc: "atk_state_set_is_empty", libprag.}

proc isEmpty*(self: StateSet): bool =
  toBool(atk_state_set_is_empty(cast[ptr StateSet00](self.impl)))

proc atk_state_set_or_sets*(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc: "atk_state_set_or_sets", libprag.}

proc orSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_or_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[StateSet](g_object_get_qdata(gobj, Quark))
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

proc atk_state_set_xor_sets*(self: ptr StateSet00; compareSet: ptr StateSet00): ptr StateSet00 {.
    importc: "atk_state_set_xor_sets", libprag.}

proc xorSets*(self: StateSet; compareSet: StateSet): StateSet =
  let gobj = atk_state_set_xor_sets(cast[ptr StateSet00](self.impl), cast[ptr StateSet00](compareSet.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[StateSet](g_object_get_qdata(gobj, Quark))
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

proc atk_object_ref_state_set*(self: ptr Object00): ptr StateSet00 {.
    importc: "atk_object_ref_state_set", libprag.}

proc refStateSet*(self: Object): StateSet =
  let gobj = atk_object_ref_state_set(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[StateSet](g_object_get_qdata(gobj, Quark))
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
  StateType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    active = 1
    armed = 2
    busy = 3
    checked = 4
    defunct = 5
    editable = 6
    enabled = 7
    expandable = 8
    expanded = 9
    focusable = 10
    focused = 11
    horizontal = 12
    iconified = 13
    modal = 14
    multiLine = 15
    multiselectable = 16
    opaque = 17
    pressed = 18
    resizable = 19
    selectable = 20
    selected = 21
    sensitive = 22
    showing = 23
    singleLine = 24
    stale = 25
    transient = 26
    vertical = 27
    visible = 28
    managesDescendants = 29
    indeterminate = 30
    truncated = 31
    required = 32
    invalidEntry = 33
    supportsAutocompletion = 34
    selectableText = 35
    default = 36
    animated = 37
    visited = 38
    checkable = 39
    hasPopup = 40
    hasTooltip = 41
    readOnly = 42
    lastDefined = 43

proc atk_state_type_for_name*(name: cstring): StateType {.
    importc: "atk_state_type_for_name", libprag.}

proc forName*(name: cstring): StateType {.
    importc: "atk_state_type_for_name", libprag.}

proc atk_state_type_get_name*(`type`: StateType): cstring {.
    importc: "atk_state_type_get_name", libprag.}

proc getName*(`type`: StateType): string =
  let resul0 = atk_state_type_get_name(`type`)
  result = $resul0

proc name*(`type`: StateType): string =
  let resul0 = atk_state_type_get_name(`type`)
  result = $resul0

proc atk_state_type_register*(name: cstring): StateType {.
    importc: "atk_state_type_register", libprag.}

proc register*(name: cstring): StateType {.
    importc: "atk_state_type_register", libprag.}

proc atk_state_set_add_state*(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc: "atk_state_set_add_state", libprag.}

proc addState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_add_state(cast[ptr StateSet00](self.impl), `type`))

proc atk_state_set_add_states*(self: ptr StateSet00; types: StateTypeArray; nTypes: int32) {.
    importc: "atk_state_set_add_states", libprag.}

proc addStates*(self: StateSet; types: StateTypeArray; nTypes: int) =
  atk_state_set_add_states(cast[ptr StateSet00](self.impl), types, int32(nTypes))

proc atk_state_set_contains_state*(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc: "atk_state_set_contains_state", libprag.}

proc containsState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_contains_state(cast[ptr StateSet00](self.impl), `type`))

proc atk_state_set_contains_states*(self: ptr StateSet00; types: StateTypeArray; nTypes: int32): gboolean {.
    importc: "atk_state_set_contains_states", libprag.}

proc containsStates*(self: StateSet; types: StateTypeArray; nTypes: int): bool =
  toBool(atk_state_set_contains_states(cast[ptr StateSet00](self.impl), types, int32(nTypes)))

proc atk_state_set_remove_state*(self: ptr StateSet00; `type`: StateType): gboolean {.
    importc: "atk_state_set_remove_state", libprag.}

proc removeState*(self: StateSet; `type`: StateType): bool =
  toBool(atk_state_set_remove_state(cast[ptr StateSet00](self.impl), `type`))

type
  RelationType* {.size: sizeof(cint), pure.} = enum
    null = 0
    controlledBy = 1
    controllerFor = 2
    labelFor = 3
    labelledBy = 4
    memberOf = 5
    nodeChildOf = 6
    flowsTo = 7
    flowsFrom = 8
    subwindowOf = 9
    embeds = 10
    embeddedBy = 11
    popupFor = 12
    parentWindowOf = 13
    describedBy = 14
    descriptionFor = 15
    nodeParentOf = 16
    lastDefined = 17

proc atk_relation_type_for_name*(name: cstring): RelationType {.
    importc: "atk_relation_type_for_name", libprag.}

proc forName*(name: cstring): RelationType {.
    importc: "atk_relation_type_for_name", libprag.}

proc atk_relation_type_get_name*(`type`: RelationType): cstring {.
    importc: "atk_relation_type_get_name", libprag.}

proc getName*(`type`: RelationType): string =
  let resul0 = atk_relation_type_get_name(`type`)
  result = $resul0

proc name*(`type`: RelationType): string =
  let resul0 = atk_relation_type_get_name(`type`)
  result = $resul0

proc atk_relation_type_register*(name: cstring): RelationType {.
    importc: "atk_relation_type_register", libprag.}

proc register*(name: cstring): RelationType {.
    importc: "atk_relation_type_register", libprag.}

type
  Relation* = ref object of gobject.Object
  Relation00* = object of gobject.Object00
    target*: ptr PtrArray
    relationship*: RelationType

proc atk_relation_new*(targets: ptr Object00Array; nTargets: int32; relationship: RelationType): ptr Relation00 {.
    importc: "atk_relation_new", libprag.}

proc newRelation*(targets: ptr Object00Array; nTargets: int; relationship: RelationType): Relation =
  new(result, finalizeGObject)
  result.impl = atk_relation_new(targets, int32(nTargets), relationship)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initRelation*[T](result: var T; targets: ptr Object00Array; nTargets: int; relationship: RelationType) =
  assert(result is Relation)
  new(result, finalizeGObject)
  result.impl = atk_relation_new(targets, int32(nTargets), relationship)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_relation_add_target*(self: ptr Relation00; target: ptr Object00) {.
    importc: "atk_relation_add_target", libprag.}

proc addTarget*(self: Relation; target: Object) =
  atk_relation_add_target(cast[ptr Relation00](self.impl), cast[ptr Object00](target.impl))

proc atk_relation_get_relation_type*(self: ptr Relation00): RelationType {.
    importc: "atk_relation_get_relation_type", libprag.}

proc getRelationType*(self: Relation): RelationType =
  atk_relation_get_relation_type(cast[ptr Relation00](self.impl))

proc relationType*(self: Relation): RelationType =
  atk_relation_get_relation_type(cast[ptr Relation00](self.impl))

proc atk_relation_get_target*(self: ptr Relation00): ptr PtrArray {.
    importc: "atk_relation_get_target", libprag.}

proc getTarget*(self: Relation): ptr PtrArray =
  atk_relation_get_target(cast[ptr Relation00](self.impl))

proc target*(self: Relation): ptr PtrArray =
  atk_relation_get_target(cast[ptr Relation00](self.impl))

proc atk_relation_remove_target*(self: ptr Relation00; target: ptr Object00): gboolean {.
    importc: "atk_relation_remove_target", libprag.}

proc removeTarget*(self: Relation; target: Object): bool =
  toBool(atk_relation_remove_target(cast[ptr Relation00](self.impl), cast[ptr Object00](target.impl)))

proc atk_relation_set_add*(self: ptr RelationSet00; relation: ptr Relation00) {.
    importc: "atk_relation_set_add", libprag.}

proc add*(self: RelationSet; relation: Relation) =
  atk_relation_set_add(cast[ptr RelationSet00](self.impl), cast[ptr Relation00](relation.impl))

proc atk_relation_set_add_relation_by_type*(self: ptr RelationSet00; relationship: RelationType; 
    target: ptr Object00) {.
    importc: "atk_relation_set_add_relation_by_type", libprag.}

proc addRelationByType*(self: RelationSet; relationship: RelationType; target: Object) =
  atk_relation_set_add_relation_by_type(cast[ptr RelationSet00](self.impl), relationship, cast[ptr Object00](target.impl))

proc atk_relation_set_contains*(self: ptr RelationSet00; relationship: RelationType): gboolean {.
    importc: "atk_relation_set_contains", libprag.}

proc contains*(self: RelationSet; relationship: RelationType): bool =
  toBool(atk_relation_set_contains(cast[ptr RelationSet00](self.impl), relationship))

proc atk_relation_set_contains_target*(self: ptr RelationSet00; relationship: RelationType; 
    target: ptr Object00): gboolean {.
    importc: "atk_relation_set_contains_target", libprag.}

proc containsTarget*(self: RelationSet; relationship: RelationType; target: Object): bool =
  toBool(atk_relation_set_contains_target(cast[ptr RelationSet00](self.impl), relationship, cast[ptr Object00](target.impl)))

proc atk_relation_set_get_relation*(self: ptr RelationSet00; i: int32): ptr Relation00 {.
    importc: "atk_relation_set_get_relation", libprag.}

proc getRelation*(self: RelationSet; i: int): Relation =
  let gobj = atk_relation_set_get_relation(cast[ptr RelationSet00](self.impl), int32(i))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Relation](g_object_get_qdata(gobj, Quark))
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

proc relation*(self: RelationSet; i: int): Relation =
  let gobj = atk_relation_set_get_relation(cast[ptr RelationSet00](self.impl), int32(i))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Relation](g_object_get_qdata(gobj, Quark))
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

proc atk_relation_set_get_relation_by_type*(self: ptr RelationSet00; relationship: RelationType): ptr Relation00 {.
    importc: "atk_relation_set_get_relation_by_type", libprag.}

proc getRelationByType*(self: RelationSet; relationship: RelationType): Relation =
  let gobj = atk_relation_set_get_relation_by_type(cast[ptr RelationSet00](self.impl), relationship)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Relation](g_object_get_qdata(gobj, Quark))
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

proc relationByType*(self: RelationSet; relationship: RelationType): Relation =
  let gobj = atk_relation_set_get_relation_by_type(cast[ptr RelationSet00](self.impl), relationship)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Relation](g_object_get_qdata(gobj, Quark))
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

proc atk_relation_set_remove*(self: ptr RelationSet00; relation: ptr Relation00) {.
    importc: "atk_relation_set_remove", libprag.}

proc remove*(self: RelationSet; relation: Relation) =
  atk_relation_set_remove(cast[ptr RelationSet00](self.impl), cast[ptr Relation00](relation.impl))

proc atk_object_add_relationship*(self: ptr Object00; relationship: RelationType; target: ptr Object00): gboolean {.
    importc: "atk_object_add_relationship", libprag.}

proc addRelationship*(self: Object; relationship: RelationType; target: Object): bool =
  toBool(atk_object_add_relationship(cast[ptr Object00](self.impl), relationship, cast[ptr Object00](target.impl)))

proc atk_object_remove_relationship*(self: ptr Object00; relationship: RelationType; target: ptr Object00): gboolean {.
    importc: "atk_object_remove_relationship", libprag.}

proc removeRelationship*(self: Object; relationship: RelationType; target: Object): bool =
  toBool(atk_object_remove_relationship(cast[ptr Object00](self.impl), relationship, cast[ptr Object00](target.impl)))

type
  Rectangle00* {.pure.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  Rectangle* = ref object
    impl*: ptr Rectangle00

type
  ComponentIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    addFocusHandler*: pointer
    contains*: proc(component: ptr Component00; x: int32; y: int32; coordType: CoordType): gboolean {.cdecl.}
    refAccessibleAtPoint*: proc(component: ptr Component00; x: int32; y: int32; coordType: CoordType): ptr Object00 {.cdecl.}
    getExtents*: proc(component: ptr Component00; x: var int32; y: var int32; 
    width: var int32; height: var int32; coordType: CoordType) {.cdecl.}
    getPosition*: proc(component: ptr Component00; x: var int32; y: var int32; 
    coordType: CoordType) {.cdecl.}
    getSize*: proc(component: ptr Component00; width: var int32; height: var int32) {.cdecl.}
    grabFocus*: proc(component: ptr Component00): gboolean {.cdecl.}
    removeFocusHandler*: proc(component: ptr Component00; handlerId: uint32) {.cdecl.}
    setExtents*: proc(component: ptr Component00; x: int32; y: int32; width: int32; 
    height: int32; coordType: CoordType): gboolean {.cdecl.}
    setPosition*: proc(component: ptr Component00; x: int32; y: int32; coordType: CoordType): gboolean {.cdecl.}
    setSize*: proc(component: ptr Component00; width: int32; height: int32): gboolean {.cdecl.}
    getLayer*: proc(component: ptr Component00): Layer {.cdecl.}
    getMdiZorder*: proc(component: ptr Component00): int32 {.cdecl.}
    boundsChanged*: proc(component: ptr Component00; bounds: ptr Rectangle00) {.cdecl.}
    getAlpha*: proc(component: ptr Component00): cdouble {.cdecl.}
  ComponentIface* = ref object
    impl*: ptr ComponentIface00

type
  Document00* {.pure.} = object
  Document* = ref object
    impl*: ptr Document00

proc atk_document_get_attribute_value*(self: ptr Document00; attributeName: cstring): cstring {.
    importc: "atk_document_get_attribute_value", libprag.}

proc getAttributeValue*(self: Document; attributeName: string): string =
  let resul0 = atk_document_get_attribute_value(cast[ptr Document00](self.impl), cstring(attributeName))
  result = $resul0

proc attributeValue*(self: Document; attributeName: string): string =
  let resul0 = atk_document_get_attribute_value(cast[ptr Document00](self.impl), cstring(attributeName))
  result = $resul0

proc atk_document_get_attributes*(self: ptr Document00): ptr pointer {.
    importc: "atk_document_get_attributes", libprag.}

proc getAttributes*(self: Document): ptr pointer =
  atk_document_get_attributes(cast[ptr Document00](self.impl))

proc attributes*(self: Document): ptr pointer =
  atk_document_get_attributes(cast[ptr Document00](self.impl))

proc atk_document_get_current_page_number*(self: ptr Document00): int32 {.
    importc: "atk_document_get_current_page_number", libprag.}

proc getCurrentPageNumber*(self: Document): int =
  int(atk_document_get_current_page_number(cast[ptr Document00](self.impl)))

proc currentPageNumber*(self: Document): int =
  int(atk_document_get_current_page_number(cast[ptr Document00](self.impl)))

proc atk_document_get_document*(self: ptr Document00): pointer {.
    importc: "atk_document_get_document", libprag.}

proc getDocument*(self: Document): pointer =
  atk_document_get_document(cast[ptr Document00](self.impl))

proc document*(self: Document): pointer =
  atk_document_get_document(cast[ptr Document00](self.impl))

proc atk_document_get_document_type*(self: ptr Document00): cstring {.
    importc: "atk_document_get_document_type", libprag.}

proc getDocumentType*(self: Document): string =
  let resul0 = atk_document_get_document_type(cast[ptr Document00](self.impl))
  result = $resul0

proc documentType*(self: Document): string =
  let resul0 = atk_document_get_document_type(cast[ptr Document00](self.impl))
  result = $resul0

proc atk_document_get_locale*(self: ptr Document00): cstring {.
    importc: "atk_document_get_locale", libprag.}

proc getLocale*(self: Document): string =
  let resul0 = atk_document_get_locale(cast[ptr Document00](self.impl))
  result = $resul0

proc locale*(self: Document): string =
  let resul0 = atk_document_get_locale(cast[ptr Document00](self.impl))
  result = $resul0

proc atk_document_get_page_count*(self: ptr Document00): int32 {.
    importc: "atk_document_get_page_count", libprag.}

proc getPageCount*(self: Document): int =
  int(atk_document_get_page_count(cast[ptr Document00](self.impl)))

proc pageCount*(self: Document): int =
  int(atk_document_get_page_count(cast[ptr Document00](self.impl)))

proc atk_document_set_attribute_value*(self: ptr Document00; attributeName: cstring; attributeValue: cstring): gboolean {.
    importc: "atk_document_set_attribute_value", libprag.}

proc setAttributeValue*(self: Document; attributeName: string; attributeValue: string): bool =
  toBool(atk_document_set_attribute_value(cast[ptr Document00](self.impl), cstring(attributeName), cstring(attributeValue)))

type
  DocumentIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getDocumentType*: proc(document: ptr Document00): cstring {.cdecl.}
    getDocument*: proc(document: ptr Document00): pointer {.cdecl.}
    getDocumentLocale*: proc(document: ptr Document00): cstring {.cdecl.}
    getDocumentAttributes*: pointer
    getDocumentAttributeValue*: proc(document: ptr Document00; attributeName: cstring): cstring {.cdecl.}
    setDocumentAttribute*: proc(document: ptr Document00; attributeName: cstring; 
    attributeValue: cstring): gboolean {.cdecl.}
    getCurrentPageNumber*: proc(document: ptr Document00): int32 {.cdecl.}
    getPageCount*: proc(document: ptr Document00): int32 {.cdecl.}
  DocumentIface* = ref object
    impl*: ptr DocumentIface00

type
  EditableText00* {.pure.} = object
  EditableText* = ref object
    impl*: ptr EditableText00

proc atk_editable_text_copy_text*(self: ptr EditableText00; startPos: int32; endPos: int32) {.
    importc: "atk_editable_text_copy_text", libprag.}

proc copyText*(self: EditableText; startPos: int; endPos: int) =
  atk_editable_text_copy_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_cut_text*(self: ptr EditableText00; startPos: int32; endPos: int32) {.
    importc: "atk_editable_text_cut_text", libprag.}

proc cutText*(self: EditableText; startPos: int; endPos: int) =
  atk_editable_text_cut_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_delete_text*(self: ptr EditableText00; startPos: int32; endPos: int32) {.
    importc: "atk_editable_text_delete_text", libprag.}

proc deleteText*(self: EditableText; startPos: int; endPos: int) =
  atk_editable_text_delete_text(cast[ptr EditableText00](self.impl), int32(startPos), int32(endPos))

proc atk_editable_text_insert_text*(self: ptr EditableText00; string: cstring; length: int32; 
    position: ptr int32) {.
    importc: "atk_editable_text_insert_text", libprag.}

proc insertText*(self: EditableText; string: string; length: int; position: ptr int32) =
  atk_editable_text_insert_text(cast[ptr EditableText00](self.impl), cstring(string), int32(length), position)

proc atk_editable_text_paste_text*(self: ptr EditableText00; position: int32) {.
    importc: "atk_editable_text_paste_text", libprag.}

proc pasteText*(self: EditableText; position: int) =
  atk_editable_text_paste_text(cast[ptr EditableText00](self.impl), int32(position))

proc atk_editable_text_set_run_attributes*(self: ptr EditableText00; attribSet: ptr pointer; 
    startOffset: int32; endOffset: int32): gboolean {.
    importc: "atk_editable_text_set_run_attributes", libprag.}

proc setRunAttributes*(self: EditableText; attribSet: ptr pointer; startOffset: int; 
    endOffset: int): bool =
  toBool(atk_editable_text_set_run_attributes(cast[ptr EditableText00](self.impl), attribSet, int32(startOffset), int32(endOffset)))

proc atk_editable_text_set_text_contents*(self: ptr EditableText00; string: cstring) {.
    importc: "atk_editable_text_set_text_contents", libprag.}

proc setTextContents*(self: EditableText; string: string) =
  atk_editable_text_set_text_contents(cast[ptr EditableText00](self.impl), cstring(string))

proc `textContents=`*(self: EditableText; string: string) =
  atk_editable_text_set_text_contents(cast[ptr EditableText00](self.impl), cstring(string))

type
  EditableTextIface00* {.pure.} = object
    parentInterface*: gobject.TypeInterface00
    setRunAttributes*: proc(text: ptr EditableText00; attribSet: ptr pointer; 
    startOffset: int32; endOffset: int32): gboolean {.cdecl.}
    setTextContents*: proc(text: ptr EditableText00; string: cstring) {.cdecl.}
    insertText*: proc(text: ptr EditableText00; string: cstring; length: int32; 
    position: ptr int32) {.cdecl.}
    copyText*: proc(text: ptr EditableText00; startPos: int32; endPos: int32) {.cdecl.}
    cutText*: proc(text: ptr EditableText00; startPos: int32; endPos: int32) {.cdecl.}
    deleteText*: proc(text: ptr EditableText00; startPos: int32; endPos: int32) {.cdecl.}
    pasteText*: proc(text: ptr EditableText00; position: int32) {.cdecl.}
  EditableTextIface* = ref object
    impl*: ptr EditableTextIface00

type
  EventListener* = proc (obj: ptr Object00) {.cdecl.}

type
  EventListenerInit* = proc () {.cdecl.}

type
  FocusHandler* = proc (`object`: ptr Object00; focusIn: gboolean) {.cdecl.}

type
  Function* = proc (userData: pointer): gboolean {.cdecl.}

type
  GObjectAccessible* = ref object of Object
  GObjectAccessible00* = object of Object00

proc atk_gobject_accessible_for_object*(obj: ptr gobject.Object00): ptr Object00 {.
    importc: "atk_gobject_accessible_for_object", libprag.}

proc forObject*(obj: gobject.Object): Object =
  let gobj = atk_gobject_accessible_for_object(cast[ptr gobject.Object00](obj.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_gobject_accessible_get_object*(self: ptr GObjectAccessible00): ptr gobject.Object00 {.
    importc: "atk_gobject_accessible_get_object", libprag.}

proc getObject*(self: GObjectAccessible): gobject.Object =
  let gobj = atk_gobject_accessible_get_object(cast[ptr GObjectAccessible00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[gobject.Object](g_object_get_qdata(gobj, Quark))
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
  PropertyValues00* {.pure.} = object
    propertyName*: cstring
    oldValue*: gobject.Value00
    newValue*: gobject.Value00
  PropertyValues* = ref object
    impl*: ptr PropertyValues00

type
  ObjectClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    getName*: proc(accessible: ptr Object00): cstring {.cdecl.}
    getDescription*: proc(accessible: ptr Object00): cstring {.cdecl.}
    getParent*: proc(accessible: ptr Object00): ptr Object00 {.cdecl.}
    getNChildren*: proc(accessible: ptr Object00): int32 {.cdecl.}
    refChild*: pointer
    getIndexInParent*: proc(accessible: ptr Object00): int32 {.cdecl.}
    refRelationSet*: proc(accessible: ptr Object00): ptr RelationSet00 {.cdecl.}
    getRole*: proc(accessible: ptr Object00): Role {.cdecl.}
    getLayer*: proc(accessible: ptr Object00): Layer {.cdecl.}
    getMdiZorder*: proc(accessible: ptr Object00): int32 {.cdecl.}
    refStateSet*: proc(accessible: ptr Object00): ptr StateSet00 {.cdecl.}
    setName*: proc(accessible: ptr Object00; name: cstring) {.cdecl.}
    setDescription*: proc(accessible: ptr Object00; description: cstring) {.cdecl.}
    setParent*: proc(accessible: ptr Object00; parent: ptr Object00) {.cdecl.}
    setRole*: proc(accessible: ptr Object00; role: Role) {.cdecl.}
    connectPropertyChangeHandler*: pointer
    removePropertyChangeHandler*: proc(accessible: ptr Object00; handlerId: uint32) {.cdecl.}
    initialize*: proc(accessible: ptr Object00; data: pointer) {.cdecl.}
    childrenChanged*: proc(accessible: ptr Object00; changeIndex: uint32; changedChild: pointer) {.cdecl.}
    focusEvent*: proc(accessible: ptr Object00; focusIn: gboolean) {.cdecl.}
    propertyChange*: proc(accessible: ptr Object00; values: ptr PropertyValues00) {.cdecl.}
    stateChange*: proc(accessible: ptr Object00; name: cstring; stateSet: gboolean) {.cdecl.}
    visibleDataChanged*: proc(accessible: ptr Object00) {.cdecl.}
    activeDescendantChanged*: proc(accessible: ptr Object00; child: pointer) {.cdecl.}
    getAttributes*: proc(accessible: ptr Object00): ptr pointer {.cdecl.}
    getObjectLocale*: proc(accessible: ptr Object00): cstring {.cdecl.}
    pad1*: Function
  ObjectClass* = ref object
    impl*: ptr ObjectClass00

type
  GObjectAccessibleClass00* {.pure.} = object
    parentClass*: ObjectClass00
    pad1*: Function
    pad2*: Function
  GObjectAccessibleClass* = ref object
    impl*: ptr GObjectAccessibleClass00

type
  Hyperlink* = ref object of gobject.Object
  Hyperlink00* = object of gobject.Object00

proc scLinkActivated*(self: Hyperlink;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "link-activated", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc atk_hyperlink_get_end_index*(self: ptr Hyperlink00): int32 {.
    importc: "atk_hyperlink_get_end_index", libprag.}

proc getEndIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_end_index(cast[ptr Hyperlink00](self.impl)))

proc endIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_end_index(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_n_anchors*(self: ptr Hyperlink00): int32 {.
    importc: "atk_hyperlink_get_n_anchors", libprag.}

proc getNAnchors*(self: Hyperlink): int =
  int(atk_hyperlink_get_n_anchors(cast[ptr Hyperlink00](self.impl)))

proc nAnchors*(self: Hyperlink): int =
  int(atk_hyperlink_get_n_anchors(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_object*(self: ptr Hyperlink00; i: int32): ptr Object00 {.
    importc: "atk_hyperlink_get_object", libprag.}

proc getObject*(self: Hyperlink; i: int): Object =
  let gobj = atk_hyperlink_get_object(cast[ptr Hyperlink00](self.impl), int32(i))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_hyperlink_get_start_index*(self: ptr Hyperlink00): int32 {.
    importc: "atk_hyperlink_get_start_index", libprag.}

proc getStartIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_start_index(cast[ptr Hyperlink00](self.impl)))

proc startIndex*(self: Hyperlink): int =
  int(atk_hyperlink_get_start_index(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_get_uri*(self: ptr Hyperlink00; i: int32): cstring {.
    importc: "atk_hyperlink_get_uri", libprag.}

proc getUri*(self: Hyperlink; i: int): string =
  let resul0 = atk_hyperlink_get_uri(cast[ptr Hyperlink00](self.impl), int32(i))
  result = $resul0
  cogfree(resul0)

proc uri*(self: Hyperlink; i: int): string =
  let resul0 = atk_hyperlink_get_uri(cast[ptr Hyperlink00](self.impl), int32(i))
  result = $resul0
  cogfree(resul0)

proc atk_hyperlink_is_inline*(self: ptr Hyperlink00): gboolean {.
    importc: "atk_hyperlink_is_inline", libprag.}

proc isInline*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_inline(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_is_selected_link*(self: ptr Hyperlink00): gboolean {.
    importc: "atk_hyperlink_is_selected_link", libprag.}

proc isSelectedLink*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_selected_link(cast[ptr Hyperlink00](self.impl)))

proc atk_hyperlink_is_valid*(self: ptr Hyperlink00): gboolean {.
    importc: "atk_hyperlink_is_valid", libprag.}

proc isValid*(self: Hyperlink): bool =
  toBool(atk_hyperlink_is_valid(cast[ptr Hyperlink00](self.impl)))

type
  HyperlinkClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    getUri*: proc(link: ptr Hyperlink00; i: int32): cstring {.cdecl.}
    getObject*: proc(link: ptr Hyperlink00; i: int32): ptr Object00 {.cdecl.}
    getEndIndex*: proc(link: ptr Hyperlink00): int32 {.cdecl.}
    getStartIndex*: proc(link: ptr Hyperlink00): int32 {.cdecl.}
    isValid*: proc(link: ptr Hyperlink00): gboolean {.cdecl.}
    getNAnchors*: proc(link: ptr Hyperlink00): int32 {.cdecl.}
    linkState*: proc(link: ptr Hyperlink00): uint32 {.cdecl.}
    isSelectedLink*: proc(link: ptr Hyperlink00): gboolean {.cdecl.}
    linkActivated*: proc(link: ptr Hyperlink00) {.cdecl.}
    pad1*: Function
  HyperlinkClass* = ref object
    impl*: ptr HyperlinkClass00

type
  HyperlinkImpl00* {.pure.} = object
  HyperlinkImpl* = ref object
    impl*: ptr HyperlinkImpl00

proc atk_hyperlink_impl_get_hyperlink*(self: ptr HyperlinkImpl00): ptr Hyperlink00 {.
    importc: "atk_hyperlink_impl_get_hyperlink", libprag.}

proc getHyperlink*(self: HyperlinkImpl): Hyperlink =
  let gobj = atk_hyperlink_impl_get_hyperlink(cast[ptr HyperlinkImpl00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Hyperlink](g_object_get_qdata(gobj, Quark))
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

proc hyperlink*(self: HyperlinkImpl): Hyperlink =
  let gobj = atk_hyperlink_impl_get_hyperlink(cast[ptr HyperlinkImpl00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Hyperlink](g_object_get_qdata(gobj, Quark))
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
  HyperlinkImplIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getHyperlink*: proc(impl: ptr HyperlinkImpl00): ptr Hyperlink00 {.cdecl.}
  HyperlinkImplIface* = ref object
    impl*: ptr HyperlinkImplIface00

type
  HyperlinkStateFlags* {.size: sizeof(cint), pure.} = enum
    inline = 1

type
  Hypertext00* {.pure.} = object
  Hypertext* = ref object
    impl*: ptr Hypertext00

proc atk_hypertext_get_link*(self: ptr Hypertext00; linkIndex: int32): ptr Hyperlink00 {.
    importc: "atk_hypertext_get_link", libprag.}

proc getLink*(self: Hypertext; linkIndex: int): Hyperlink =
  let gobj = atk_hypertext_get_link(cast[ptr Hypertext00](self.impl), int32(linkIndex))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Hyperlink](g_object_get_qdata(gobj, Quark))
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

proc link*(self: Hypertext; linkIndex: int): Hyperlink =
  let gobj = atk_hypertext_get_link(cast[ptr Hypertext00](self.impl), int32(linkIndex))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Hyperlink](g_object_get_qdata(gobj, Quark))
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

proc atk_hypertext_get_link_index*(self: ptr Hypertext00; charIndex: int32): int32 {.
    importc: "atk_hypertext_get_link_index", libprag.}

proc getLinkIndex*(self: Hypertext; charIndex: int): int =
  int(atk_hypertext_get_link_index(cast[ptr Hypertext00](self.impl), int32(charIndex)))

proc linkIndex*(self: Hypertext; charIndex: int): int =
  int(atk_hypertext_get_link_index(cast[ptr Hypertext00](self.impl), int32(charIndex)))

proc atk_hypertext_get_n_links*(self: ptr Hypertext00): int32 {.
    importc: "atk_hypertext_get_n_links", libprag.}

proc getNLinks*(self: Hypertext): int =
  int(atk_hypertext_get_n_links(cast[ptr Hypertext00](self.impl)))

proc nLinks*(self: Hypertext): int =
  int(atk_hypertext_get_n_links(cast[ptr Hypertext00](self.impl)))

type
  HypertextIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getLink*: proc(hypertext: ptr Hypertext00; linkIndex: int32): ptr Hyperlink00 {.cdecl.}
    getNLinks*: proc(hypertext: ptr Hypertext00): int32 {.cdecl.}
    getLinkIndex*: proc(hypertext: ptr Hypertext00; charIndex: int32): int32 {.cdecl.}
    linkSelected*: proc(hypertext: ptr Hypertext00; linkIndex: int32) {.cdecl.}
  HypertextIface* = ref object
    impl*: ptr HypertextIface00

const INTERFACE_AGE* = 1'i32

type
  Image00* {.pure.} = object
  Image* = ref object
    impl*: ptr Image00

proc atk_image_get_image_description*(self: ptr Image00): cstring {.
    importc: "atk_image_get_image_description", libprag.}

proc getImageDescription*(self: Image): string =
  let resul0 = atk_image_get_image_description(cast[ptr Image00](self.impl))
  result = $resul0

proc imageDescription*(self: Image): string =
  let resul0 = atk_image_get_image_description(cast[ptr Image00](self.impl))
  result = $resul0

proc atk_image_get_image_locale*(self: ptr Image00): cstring {.
    importc: "atk_image_get_image_locale", libprag.}

proc getImageLocale*(self: Image): string =
  let resul0 = atk_image_get_image_locale(cast[ptr Image00](self.impl))
  result = $resul0

proc imageLocale*(self: Image): string =
  let resul0 = atk_image_get_image_locale(cast[ptr Image00](self.impl))
  result = $resul0

proc atk_image_get_image_position*(self: ptr Image00; x: var int32; y: var int32; coordType: CoordType) {.
    importc: "atk_image_get_image_position", libprag.}

proc getImagePosition*(self: Image; x: var int; y: var int; coordType: CoordType) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  atk_image_get_image_position(cast[ptr Image00](self.impl), x_00, y_00, coordType)
  y = int(y_00)
  x = int(x_00)

proc imagePosition*(self: Image; x: var int; y: var int; coordType: CoordType) =
  var y_00 = int32(y)
  var x_00 = int32(x)
  atk_image_get_image_position(cast[ptr Image00](self.impl), x_00, y_00, coordType)
  y = int(y_00)
  x = int(x_00)

proc atk_image_get_image_size*(self: ptr Image00; width: var int32; height: var int32) {.
    importc: "atk_image_get_image_size", libprag.}

proc getImageSize*(self: Image; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  atk_image_get_image_size(cast[ptr Image00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc imageSize*(self: Image; width: var int; height: var int) =
  var height_00 = int32(height)
  var width_00 = int32(width)
  atk_image_get_image_size(cast[ptr Image00](self.impl), width_00, height_00)
  height = int(height_00)
  width = int(width_00)

proc atk_image_set_image_description*(self: ptr Image00; description: cstring): gboolean {.
    importc: "atk_image_set_image_description", libprag.}

proc setImageDescription*(self: Image; description: string): bool =
  toBool(atk_image_set_image_description(cast[ptr Image00](self.impl), cstring(description)))

proc `imageDescription=`*(self: Image; description: string): bool =
  toBool(atk_image_set_image_description(cast[ptr Image00](self.impl), cstring(description)))

type
  ImageIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getImagePosition*: proc(image: ptr Image00; x: var int32; y: var int32; coordType: CoordType) {.cdecl.}
    getImageDescription*: proc(image: ptr Image00): cstring {.cdecl.}
    getImageSize*: proc(image: ptr Image00; width: var int32; height: var int32) {.cdecl.}
    setImageDescription*: proc(image: ptr Image00; description: cstring): gboolean {.cdecl.}
    getImageLocale*: proc(image: ptr Image00): cstring {.cdecl.}
  ImageIface* = ref object
    impl*: ptr ImageIface00

type
  Implementor00* {.pure.} = object
  Implementor* = ref object
    impl*: ptr Implementor00

proc atk_implementor_ref_accessible*(self: ptr Implementor00): ptr Object00 {.
    importc: "atk_implementor_ref_accessible", libprag.}

proc refAccessible*(self: Implementor): Object =
  let gobj = atk_implementor_ref_accessible(cast[ptr Implementor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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
  KeyEventStruct00* {.pure.} = object
    `type`*: int32
    state*: uint32
    keyval*: uint32
    length*: int32
    string*: cstring
    keycode*: uint16
    timestamp*: uint32
  KeyEventStruct* = ref object
    impl*: ptr KeyEventStruct00

type
  KeyEventType* {.size: sizeof(cint), pure.} = enum
    press = 0
    release = 1
    lastDefined = 2

type
  KeySnoopFunc* = proc (event: ptr KeyEventStruct00; userData: pointer): int32 {.cdecl.}

const MAJOR_VERSION* = 2'i32

const MICRO_VERSION* = 0'i32

const MINOR_VERSION* = 22'i32

type
  Misc* = ref object of gobject.Object
  Misc00* = object of gobject.Object00

proc atk_misc_get_instance*(): ptr Misc00 {.
    importc: "atk_misc_get_instance", libprag.}

proc getInstance*(): Misc =
  let gobj = atk_misc_get_instance()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Misc](g_object_get_qdata(gobj, Quark))
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

proc instance*(): Misc =
  let gobj = atk_misc_get_instance()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Misc](g_object_get_qdata(gobj, Quark))
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

proc atk_misc_threads_enter*(self: ptr Misc00) {.
    importc: "atk_misc_threads_enter", libprag.}

proc threadsEnter*(self: Misc) =
  atk_misc_threads_enter(cast[ptr Misc00](self.impl))

proc atk_misc_threads_leave*(self: ptr Misc00) {.
    importc: "atk_misc_threads_leave", libprag.}

proc threadsLeave*(self: Misc) =
  atk_misc_threads_leave(cast[ptr Misc00](self.impl))

type
  MiscClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    threadsEnter*: proc(misc: ptr Misc00) {.cdecl.}
    threadsLeave*: proc(misc: ptr Misc00) {.cdecl.}
    vfuncs*: array[32, pointer]
  MiscClass* = ref object
    impl*: ptr MiscClass00

type
  NoOpObject* = ref object of Object
  NoOpObject00* = object of Object00

proc atk_no_op_object_new*(obj: ptr gobject.Object00): ptr NoOpObject00 {.
    importc: "atk_no_op_object_new", libprag.}

proc newNoOpObject*(obj: gobject.Object): NoOpObject =
  new(result, finalizeGObject)
  result.impl = atk_no_op_object_new(cast[ptr gobject.Object00](obj.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNoOpObject*[T](result: var T; obj: gobject.Object) =
  assert(result is NoOpObject)
  new(result, finalizeGObject)
  result.impl = atk_no_op_object_new(cast[ptr gobject.Object00](obj.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  NoOpObjectClass00* {.pure.} = object
    parentClass*: ObjectClass00
  NoOpObjectClass* = ref object
    impl*: ptr NoOpObjectClass00

type
  ObjectFactory* = ref object of gobject.Object
  ObjectFactory00* = object of gobject.Object00

proc atk_object_factory_create_accessible*(self: ptr ObjectFactory00; obj: ptr gobject.Object00): ptr Object00 {.
    importc: "atk_object_factory_create_accessible", libprag.}

proc createAccessible*(self: ObjectFactory; obj: gobject.Object): Object =
  let gobj = atk_object_factory_create_accessible(cast[ptr ObjectFactory00](self.impl), cast[ptr gobject.Object00](obj.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_object_factory_get_accessible_type*(self: ptr ObjectFactory00): GType {.
    importc: "atk_object_factory_get_accessible_type", libprag.}

proc getAccessibleType*(self: ObjectFactory): GType =
  atk_object_factory_get_accessible_type(cast[ptr ObjectFactory00](self.impl))

proc accessibleType*(self: ObjectFactory): GType =
  atk_object_factory_get_accessible_type(cast[ptr ObjectFactory00](self.impl))

proc atk_object_factory_invalidate*(self: ptr ObjectFactory00) {.
    importc: "atk_object_factory_invalidate", libprag.}

proc invalidate*(self: ObjectFactory) =
  atk_object_factory_invalidate(cast[ptr ObjectFactory00](self.impl))

type
  NoOpObjectFactory* = ref object of ObjectFactory
  NoOpObjectFactory00* = object of ObjectFactory00

proc atk_no_op_object_factory_new*(): ptr NoOpObjectFactory00 {.
    importc: "atk_no_op_object_factory_new", libprag.}

proc newNoOpObjectFactory*(): NoOpObjectFactory =
  new(result, finalizeGObject)
  result.impl = atk_no_op_object_factory_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNoOpObjectFactory*[T](result: var T) =
  assert(result is NoOpObjectFactory)
  new(result, finalizeGObject)
  result.impl = atk_no_op_object_factory_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ObjectFactoryClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    createAccessible*: pointer
    invalidate*: proc(factory: ptr ObjectFactory00) {.cdecl.}
    getAccessibleType*: proc(): GType {.cdecl.}
    pad1*: Function
    pad2*: Function
  ObjectFactoryClass* = ref object
    impl*: ptr ObjectFactoryClass00

type
  NoOpObjectFactoryClass00* {.pure.} = object
    parentClass*: ObjectFactoryClass00
  NoOpObjectFactoryClass* = ref object
    impl*: ptr NoOpObjectFactoryClass00

type
  Plug* = ref object of Object
  Plug00* = object of Object00

proc atk_plug_new*(): ptr Plug00 {.
    importc: "atk_plug_new", libprag.}

proc newPlug*(): Plug =
  new(result, finalizeGObject)
  result.impl = atk_plug_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPlug*[T](result: var T) =
  assert(result is Plug)
  new(result, finalizeGObject)
  result.impl = atk_plug_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_plug_get_id*(self: ptr Plug00): cstring {.
    importc: "atk_plug_get_id", libprag.}

proc getId*(self: Plug): string =
  let resul0 = atk_plug_get_id(cast[ptr Plug00](self.impl))
  result = $resul0
  cogfree(resul0)

proc id*(self: Plug): string =
  let resul0 = atk_plug_get_id(cast[ptr Plug00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  PlugClass00* {.pure.} = object
    parentClass*: ObjectClass00
    getObjectId*: proc(obj: ptr Plug00): cstring {.cdecl.}
  PlugClass* = ref object
    impl*: ptr PlugClass00

type
  PropertyChangeHandler* = proc (obj: ptr Object00; vals: ptr PropertyValues00) {.cdecl.}

type
  Range00* {.pure.} = object
  Range* = ref object
    impl*: ptr Range00

proc atk_range_new*(lowerLimit: cdouble; upperLimit: cdouble; description: cstring): ptr Range00 {.
    importc: "atk_range_new", libprag.}

proc newRange*(lowerLimit: cdouble; upperLimit: cdouble; description: string): Range =
  new(result)
  result.impl = atk_range_new(lowerLimit, upperLimit, cstring(description))

proc initRange*[T](result: var T; lowerLimit: cdouble; upperLimit: cdouble; description: string) =
  assert(result is Range)
  new(result)
  result.impl = atk_range_new(lowerLimit, upperLimit, cstring(description))

proc atk_range_copy*(self: ptr Range00): ptr Range00 {.
    importc: "atk_range_copy", libprag.}

proc copy*(self: Range): Range =
  new(result)
  result.impl = atk_range_copy(cast[ptr Range00](self.impl))

proc atk_range_free*(self: ptr Range00) {.
    importc: "atk_range_free", libprag.}

proc free*(self: Range) =
  atk_range_free(cast[ptr Range00](self.impl))

proc atk_range_get_description*(self: ptr Range00): cstring {.
    importc: "atk_range_get_description", libprag.}

proc getDescription*(self: Range): string =
  let resul0 = atk_range_get_description(cast[ptr Range00](self.impl))
  result = $resul0

proc description*(self: Range): string =
  let resul0 = atk_range_get_description(cast[ptr Range00](self.impl))
  result = $resul0

proc atk_range_get_lower_limit*(self: ptr Range00): cdouble {.
    importc: "atk_range_get_lower_limit", libprag.}

proc getLowerLimit*(self: Range): cdouble =
  atk_range_get_lower_limit(cast[ptr Range00](self.impl))

proc lowerLimit*(self: Range): cdouble =
  atk_range_get_lower_limit(cast[ptr Range00](self.impl))

proc atk_range_get_upper_limit*(self: ptr Range00): cdouble {.
    importc: "atk_range_get_upper_limit", libprag.}

proc getUpperLimit*(self: Range): cdouble =
  atk_range_get_upper_limit(cast[ptr Range00](self.impl))

proc upperLimit*(self: Range): cdouble =
  atk_range_get_upper_limit(cast[ptr Range00](self.impl))

type
  Registry* = ref object of gobject.Object
  Registry00* = object of gobject.Object00
    factoryTypeRegistry*: ptr HashTable00
    factorySingletonCache*: ptr HashTable00

proc atk_registry_get_factory*(self: ptr Registry00; `type`: GType): ptr ObjectFactory00 {.
    importc: "atk_registry_get_factory", libprag.}

proc getFactory*(self: Registry; `type`: GType): ObjectFactory =
  let gobj = atk_registry_get_factory(cast[ptr Registry00](self.impl), `type`)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[ObjectFactory](g_object_get_qdata(gobj, Quark))
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

proc factory*(self: Registry; `type`: GType): ObjectFactory =
  let gobj = atk_registry_get_factory(cast[ptr Registry00](self.impl), `type`)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[ObjectFactory](g_object_get_qdata(gobj, Quark))
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

proc atk_registry_get_factory_type*(self: ptr Registry00; `type`: GType): GType {.
    importc: "atk_registry_get_factory_type", libprag.}

proc getFactoryType*(self: Registry; `type`: GType): GType =
  atk_registry_get_factory_type(cast[ptr Registry00](self.impl), `type`)

proc factoryType*(self: Registry; `type`: GType): GType =
  atk_registry_get_factory_type(cast[ptr Registry00](self.impl), `type`)

proc atk_registry_set_factory_type*(self: ptr Registry00; `type`: GType; factoryType: GType) {.
    importc: "atk_registry_set_factory_type", libprag.}

proc setFactoryType*(self: Registry; `type`: GType; factoryType: GType) =
  atk_registry_set_factory_type(cast[ptr Registry00](self.impl), `type`, factoryType)

type
  RegistryClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  RegistryClass* = ref object
    impl*: ptr RegistryClass00

type
  RelationClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
  RelationClass* = ref object
    impl*: ptr RelationClass00

type
  RelationSetClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    pad1*: Function
    pad2*: Function
  RelationSetClass* = ref object
    impl*: ptr RelationSetClass00

type
  Selection00* {.pure.} = object
  Selection* = ref object
    impl*: ptr Selection00

proc atk_selection_add_selection*(self: ptr Selection00; i: int32): gboolean {.
    importc: "atk_selection_add_selection", libprag.}

proc addSelection*(self: Selection; i: int): bool =
  toBool(atk_selection_add_selection(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_clear_selection*(self: ptr Selection00): gboolean {.
    importc: "atk_selection_clear_selection", libprag.}

proc clearSelection*(self: Selection): bool =
  toBool(atk_selection_clear_selection(cast[ptr Selection00](self.impl)))

proc atk_selection_get_selection_count*(self: ptr Selection00): int32 {.
    importc: "atk_selection_get_selection_count", libprag.}

proc getSelectionCount*(self: Selection): int =
  int(atk_selection_get_selection_count(cast[ptr Selection00](self.impl)))

proc selectionCount*(self: Selection): int =
  int(atk_selection_get_selection_count(cast[ptr Selection00](self.impl)))

proc atk_selection_is_child_selected*(self: ptr Selection00; i: int32): gboolean {.
    importc: "atk_selection_is_child_selected", libprag.}

proc isChildSelected*(self: Selection; i: int): bool =
  toBool(atk_selection_is_child_selected(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_ref_selection*(self: ptr Selection00; i: int32): ptr Object00 {.
    importc: "atk_selection_ref_selection", libprag.}

proc refSelection*(self: Selection; i: int): Object =
  let gobj = atk_selection_ref_selection(cast[ptr Selection00](self.impl), int32(i))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_selection_remove_selection*(self: ptr Selection00; i: int32): gboolean {.
    importc: "atk_selection_remove_selection", libprag.}

proc removeSelection*(self: Selection; i: int): bool =
  toBool(atk_selection_remove_selection(cast[ptr Selection00](self.impl), int32(i)))

proc atk_selection_select_all_selection*(self: ptr Selection00): gboolean {.
    importc: "atk_selection_select_all_selection", libprag.}

proc selectAllSelection*(self: Selection): bool =
  toBool(atk_selection_select_all_selection(cast[ptr Selection00](self.impl)))

type
  SelectionIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    addSelection*: proc(selection: ptr Selection00; i: int32): gboolean {.cdecl.}
    clearSelection*: proc(selection: ptr Selection00): gboolean {.cdecl.}
    refSelection*: proc(selection: ptr Selection00; i: int32): ptr Object00 {.cdecl.}
    getSelectionCount*: proc(selection: ptr Selection00): int32 {.cdecl.}
    isChildSelected*: proc(selection: ptr Selection00; i: int32): gboolean {.cdecl.}
    removeSelection*: proc(selection: ptr Selection00; i: int32): gboolean {.cdecl.}
    selectAllSelection*: proc(selection: ptr Selection00): gboolean {.cdecl.}
    selectionChanged*: proc(selection: ptr Selection00) {.cdecl.}
  SelectionIface* = ref object
    impl*: ptr SelectionIface00

type
  Socket* = ref object of Object
  Socket00* = object of Object00
    embeddedPlugId*: cstring

proc atk_socket_new*(): ptr Socket00 {.
    importc: "atk_socket_new", libprag.}

proc newSocket*(): Socket =
  new(result, finalizeGObject)
  result.impl = atk_socket_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocket*[T](result: var T) =
  assert(result is Socket)
  new(result, finalizeGObject)
  result.impl = atk_socket_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc atk_socket_embed*(self: ptr Socket00; plugId: cstring) {.
    importc: "atk_socket_embed", libprag.}

proc embed*(self: Socket; plugId: string) =
  atk_socket_embed(cast[ptr Socket00](self.impl), cstring(plugId))

proc atk_socket_is_occupied*(self: ptr Socket00): gboolean {.
    importc: "atk_socket_is_occupied", libprag.}

proc isOccupied*(self: Socket): bool =
  toBool(atk_socket_is_occupied(cast[ptr Socket00](self.impl)))

type
  SocketClass00* {.pure.} = object
    parentClass*: ObjectClass00
    embed*: proc(obj: ptr Socket00; plugId: cstring) {.cdecl.}
  SocketClass* = ref object
    impl*: ptr SocketClass00

type
  StateSetClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
  StateSetClass* = ref object
    impl*: ptr StateSetClass00

type
  StreamableContent00* {.pure.} = object
  StreamableContent* = ref object
    impl*: ptr StreamableContent00

proc atk_streamable_content_get_mime_type*(self: ptr StreamableContent00; i: int32): cstring {.
    importc: "atk_streamable_content_get_mime_type", libprag.}

proc getMimeType*(self: StreamableContent; i: int): string =
  let resul0 = atk_streamable_content_get_mime_type(cast[ptr StreamableContent00](self.impl), int32(i))
  result = $resul0

proc mimeType*(self: StreamableContent; i: int): string =
  let resul0 = atk_streamable_content_get_mime_type(cast[ptr StreamableContent00](self.impl), int32(i))
  result = $resul0

proc atk_streamable_content_get_n_mime_types*(self: ptr StreamableContent00): int32 {.
    importc: "atk_streamable_content_get_n_mime_types", libprag.}

proc getNMimeTypes*(self: StreamableContent): int =
  int(atk_streamable_content_get_n_mime_types(cast[ptr StreamableContent00](self.impl)))

proc nMimeTypes*(self: StreamableContent): int =
  int(atk_streamable_content_get_n_mime_types(cast[ptr StreamableContent00](self.impl)))

proc atk_streamable_content_get_stream*(self: ptr StreamableContent00; mimeType: cstring): ptr glib.IOChannel00 {.
    importc: "atk_streamable_content_get_stream", libprag.}

proc getStream*(self: StreamableContent; mimeType: string): glib.IOChannel =
  new(result)
  result.impl = atk_streamable_content_get_stream(cast[ptr StreamableContent00](self.impl), cstring(mimeType))

proc stream*(self: StreamableContent; mimeType: string): glib.IOChannel =
  new(result)
  result.impl = atk_streamable_content_get_stream(cast[ptr StreamableContent00](self.impl), cstring(mimeType))

proc atk_streamable_content_get_uri*(self: ptr StreamableContent00; mimeType: cstring): cstring {.
    importc: "atk_streamable_content_get_uri", libprag.}

proc getUri*(self: StreamableContent; mimeType: string): string =
  let resul0 = atk_streamable_content_get_uri(cast[ptr StreamableContent00](self.impl), cstring(mimeType))
  result = $resul0

proc uri*(self: StreamableContent; mimeType: string): string =
  let resul0 = atk_streamable_content_get_uri(cast[ptr StreamableContent00](self.impl), cstring(mimeType))
  result = $resul0

type
  StreamableContentIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getNMimeTypes*: proc(streamable: ptr StreamableContent00): int32 {.cdecl.}
    getMimeType*: proc(streamable: ptr StreamableContent00; i: int32): cstring {.cdecl.}
    getStream*: proc(streamable: ptr StreamableContent00; mimeType: cstring): ptr glib.IOChannel00 {.cdecl.}
    getUri*: proc(streamable: ptr StreamableContent00; mimeType: cstring): cstring {.cdecl.}
    pad1*: Function
    pad2*: Function
    pad3*: Function
  StreamableContentIface* = ref object
    impl*: ptr StreamableContentIface00

type
  Table00* {.pure.} = object
  Table* = ref object
    impl*: ptr Table00

proc atk_table_add_column_selection*(self: ptr Table00; column: int32): gboolean {.
    importc: "atk_table_add_column_selection", libprag.}

proc addColumnSelection*(self: Table; column: int): bool =
  toBool(atk_table_add_column_selection(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_add_row_selection*(self: ptr Table00; row: int32): gboolean {.
    importc: "atk_table_add_row_selection", libprag.}

proc addRowSelection*(self: Table; row: int): bool =
  toBool(atk_table_add_row_selection(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_get_caption*(self: ptr Table00): ptr Object00 {.
    importc: "atk_table_get_caption", libprag.}

proc getCaption*(self: Table): Object =
  let gobj = atk_table_get_caption(cast[ptr Table00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc caption*(self: Table): Object =
  let gobj = atk_table_get_caption(cast[ptr Table00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_table_get_column_at_index*(self: ptr Table00; index: int32): int32 {.
    importc: "atk_table_get_column_at_index", libprag.}

proc getColumnAtIndex*(self: Table; index: int): int =
  int(atk_table_get_column_at_index(cast[ptr Table00](self.impl), int32(index)))

proc columnAtIndex*(self: Table; index: int): int =
  int(atk_table_get_column_at_index(cast[ptr Table00](self.impl), int32(index)))

proc atk_table_get_column_description*(self: ptr Table00; column: int32): cstring {.
    importc: "atk_table_get_column_description", libprag.}

proc getColumnDescription*(self: Table; column: int): string =
  let resul0 = atk_table_get_column_description(cast[ptr Table00](self.impl), int32(column))
  result = $resul0

proc columnDescription*(self: Table; column: int): string =
  let resul0 = atk_table_get_column_description(cast[ptr Table00](self.impl), int32(column))
  result = $resul0

proc atk_table_get_column_extent_at*(self: ptr Table00; row: int32; column: int32): int32 {.
    importc: "atk_table_get_column_extent_at", libprag.}

proc getColumnExtentAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_column_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc columnExtentAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_column_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_column_header*(self: ptr Table00; column: int32): ptr Object00 {.
    importc: "atk_table_get_column_header", libprag.}

proc getColumnHeader*(self: Table; column: int): Object =
  let gobj = atk_table_get_column_header(cast[ptr Table00](self.impl), int32(column))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc columnHeader*(self: Table; column: int): Object =
  let gobj = atk_table_get_column_header(cast[ptr Table00](self.impl), int32(column))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_table_get_index_at*(self: ptr Table00; row: int32; column: int32): int32 {.
    importc: "atk_table_get_index_at", libprag.}

proc getIndexAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_index_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc indexAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_index_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_n_columns*(self: ptr Table00): int32 {.
    importc: "atk_table_get_n_columns", libprag.}

proc getNColumns*(self: Table): int =
  int(atk_table_get_n_columns(cast[ptr Table00](self.impl)))

proc nColumns*(self: Table): int =
  int(atk_table_get_n_columns(cast[ptr Table00](self.impl)))

proc atk_table_get_n_rows*(self: ptr Table00): int32 {.
    importc: "atk_table_get_n_rows", libprag.}

proc getNRows*(self: Table): int =
  int(atk_table_get_n_rows(cast[ptr Table00](self.impl)))

proc nRows*(self: Table): int =
  int(atk_table_get_n_rows(cast[ptr Table00](self.impl)))

proc atk_table_get_row_at_index*(self: ptr Table00; index: int32): int32 {.
    importc: "atk_table_get_row_at_index", libprag.}

proc getRowAtIndex*(self: Table; index: int): int =
  int(atk_table_get_row_at_index(cast[ptr Table00](self.impl), int32(index)))

proc rowAtIndex*(self: Table; index: int): int =
  int(atk_table_get_row_at_index(cast[ptr Table00](self.impl), int32(index)))

proc atk_table_get_row_description*(self: ptr Table00; row: int32): cstring {.
    importc: "atk_table_get_row_description", libprag.}

proc getRowDescription*(self: Table; row: int): string =
  let resul0 = atk_table_get_row_description(cast[ptr Table00](self.impl), int32(row))
  result = $resul0

proc rowDescription*(self: Table; row: int): string =
  let resul0 = atk_table_get_row_description(cast[ptr Table00](self.impl), int32(row))
  result = $resul0

proc atk_table_get_row_extent_at*(self: ptr Table00; row: int32; column: int32): int32 {.
    importc: "atk_table_get_row_extent_at", libprag.}

proc getRowExtentAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_row_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc rowExtentAt*(self: Table; row: int; column: int): int =
  int(atk_table_get_row_extent_at(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_get_row_header*(self: ptr Table00; row: int32): ptr Object00 {.
    importc: "atk_table_get_row_header", libprag.}

proc getRowHeader*(self: Table; row: int): Object =
  let gobj = atk_table_get_row_header(cast[ptr Table00](self.impl), int32(row))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc rowHeader*(self: Table; row: int): Object =
  let gobj = atk_table_get_row_header(cast[ptr Table00](self.impl), int32(row))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_table_get_selected_columns*(self: ptr Table00; selected: ptr int32): int32 {.
    importc: "atk_table_get_selected_columns", libprag.}

proc getSelectedColumns*(self: Table; selected: ptr int32): int =
  int(atk_table_get_selected_columns(cast[ptr Table00](self.impl), selected))

proc selectedColumns*(self: Table; selected: ptr int32): int =
  int(atk_table_get_selected_columns(cast[ptr Table00](self.impl), selected))

proc atk_table_get_selected_rows*(self: ptr Table00; selected: ptr int32): int32 {.
    importc: "atk_table_get_selected_rows", libprag.}

proc getSelectedRows*(self: Table; selected: ptr int32): int =
  int(atk_table_get_selected_rows(cast[ptr Table00](self.impl), selected))

proc selectedRows*(self: Table; selected: ptr int32): int =
  int(atk_table_get_selected_rows(cast[ptr Table00](self.impl), selected))

proc atk_table_get_summary*(self: ptr Table00): ptr Object00 {.
    importc: "atk_table_get_summary", libprag.}

proc getSummary*(self: Table): Object =
  let gobj = atk_table_get_summary(cast[ptr Table00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc summary*(self: Table): Object =
  let gobj = atk_table_get_summary(cast[ptr Table00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_table_is_column_selected*(self: ptr Table00; column: int32): gboolean {.
    importc: "atk_table_is_column_selected", libprag.}

proc isColumnSelected*(self: Table; column: int): bool =
  toBool(atk_table_is_column_selected(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_is_row_selected*(self: ptr Table00; row: int32): gboolean {.
    importc: "atk_table_is_row_selected", libprag.}

proc isRowSelected*(self: Table; row: int): bool =
  toBool(atk_table_is_row_selected(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_is_selected*(self: ptr Table00; row: int32; column: int32): gboolean {.
    importc: "atk_table_is_selected", libprag.}

proc isSelected*(self: Table; row: int; column: int): bool =
  toBool(atk_table_is_selected(cast[ptr Table00](self.impl), int32(row), int32(column)))

proc atk_table_ref_at*(self: ptr Table00; row: int32; column: int32): ptr Object00 {.
    importc: "atk_table_ref_at", libprag.}

proc refAt*(self: Table; row: int; column: int): Object =
  let gobj = atk_table_ref_at(cast[ptr Table00](self.impl), int32(row), int32(column))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_table_remove_column_selection*(self: ptr Table00; column: int32): gboolean {.
    importc: "atk_table_remove_column_selection", libprag.}

proc removeColumnSelection*(self: Table; column: int): bool =
  toBool(atk_table_remove_column_selection(cast[ptr Table00](self.impl), int32(column)))

proc atk_table_remove_row_selection*(self: ptr Table00; row: int32): gboolean {.
    importc: "atk_table_remove_row_selection", libprag.}

proc removeRowSelection*(self: Table; row: int): bool =
  toBool(atk_table_remove_row_selection(cast[ptr Table00](self.impl), int32(row)))

proc atk_table_set_caption*(self: ptr Table00; caption: ptr Object00) {.
    importc: "atk_table_set_caption", libprag.}

proc setCaption*(self: Table; caption: Object) =
  atk_table_set_caption(cast[ptr Table00](self.impl), cast[ptr Object00](caption.impl))

proc `caption=`*(self: Table; caption: Object) =
  atk_table_set_caption(cast[ptr Table00](self.impl), cast[ptr Object00](caption.impl))

proc atk_table_set_column_description*(self: ptr Table00; column: int32; description: cstring) {.
    importc: "atk_table_set_column_description", libprag.}

proc setColumnDescription*(self: Table; column: int; description: string) =
  atk_table_set_column_description(cast[ptr Table00](self.impl), int32(column), cstring(description))

proc atk_table_set_column_header*(self: ptr Table00; column: int32; header: ptr Object00) {.
    importc: "atk_table_set_column_header", libprag.}

proc setColumnHeader*(self: Table; column: int; header: Object) =
  atk_table_set_column_header(cast[ptr Table00](self.impl), int32(column), cast[ptr Object00](header.impl))

proc atk_table_set_row_description*(self: ptr Table00; row: int32; description: cstring) {.
    importc: "atk_table_set_row_description", libprag.}

proc setRowDescription*(self: Table; row: int; description: string) =
  atk_table_set_row_description(cast[ptr Table00](self.impl), int32(row), cstring(description))

proc atk_table_set_row_header*(self: ptr Table00; row: int32; header: ptr Object00) {.
    importc: "atk_table_set_row_header", libprag.}

proc setRowHeader*(self: Table; row: int; header: Object) =
  atk_table_set_row_header(cast[ptr Table00](self.impl), int32(row), cast[ptr Object00](header.impl))

proc atk_table_set_summary*(self: ptr Table00; accessible: ptr Object00) {.
    importc: "atk_table_set_summary", libprag.}

proc setSummary*(self: Table; accessible: Object) =
  atk_table_set_summary(cast[ptr Table00](self.impl), cast[ptr Object00](accessible.impl))

proc `summary=`*(self: Table; accessible: Object) =
  atk_table_set_summary(cast[ptr Table00](self.impl), cast[ptr Object00](accessible.impl))

type
  TableCell00* {.pure.} = object
  TableCell* = ref object
    impl*: ptr TableCell00

proc atk_table_cell_get_column_header_cells*(self: ptr TableCell00): ptr PtrArray {.
    importc: "atk_table_cell_get_column_header_cells", libprag.}

proc getColumnHeaderCells*(self: TableCell): ptr PtrArray =
  atk_table_cell_get_column_header_cells(cast[ptr TableCell00](self.impl))

proc columnHeaderCells*(self: TableCell): ptr PtrArray =
  atk_table_cell_get_column_header_cells(cast[ptr TableCell00](self.impl))

proc atk_table_cell_get_column_span*(self: ptr TableCell00): int32 {.
    importc: "atk_table_cell_get_column_span", libprag.}

proc getColumnSpan*(self: TableCell): int =
  int(atk_table_cell_get_column_span(cast[ptr TableCell00](self.impl)))

proc columnSpan*(self: TableCell): int =
  int(atk_table_cell_get_column_span(cast[ptr TableCell00](self.impl)))

proc atk_table_cell_get_position*(self: ptr TableCell00; row: var int32; column: var int32): gboolean {.
    importc: "atk_table_cell_get_position", libprag.}

proc getPosition*(self: TableCell; row: var int; column: var int): bool =
  var column_00 = int32(column)
  var row_00 = int32(row)
  result = toBool(atk_table_cell_get_position(cast[ptr TableCell00](self.impl), row_00, column_00))
  column = int(column_00)
  row = int(row_00)

proc position*(self: TableCell; row: var int; column: var int): bool =
  var column_00 = int32(column)
  var row_00 = int32(row)
  result = toBool(atk_table_cell_get_position(cast[ptr TableCell00](self.impl), row_00, column_00))
  column = int(column_00)
  row = int(row_00)

proc atk_table_cell_get_row_column_span*(self: ptr TableCell00; row: var int32; column: var int32; 
    rowSpan: var int32; columnSpan: var int32): gboolean {.
    importc: "atk_table_cell_get_row_column_span", libprag.}

proc getRowColumnSpan*(self: TableCell; row: var int; column: var int; rowSpan: var int; 
    columnSpan: var int): bool =
  var column_00 = int32(column)
  var row_00 = int32(row)
  var columnSpan_00 = int32(columnSpan)
  var rowSpan_00 = int32(rowSpan)
  result = toBool(atk_table_cell_get_row_column_span(cast[ptr TableCell00](self.impl), row_00, column_00, rowSpan_00, columnSpan_00))
  column = int(column_00)
  row = int(row_00)
  columnSpan = int(columnSpan_00)
  rowSpan = int(rowSpan_00)

proc rowColumnSpan*(self: TableCell; row: var int; column: var int; rowSpan: var int; 
    columnSpan: var int): bool =
  var column_00 = int32(column)
  var row_00 = int32(row)
  var columnSpan_00 = int32(columnSpan)
  var rowSpan_00 = int32(rowSpan)
  result = toBool(atk_table_cell_get_row_column_span(cast[ptr TableCell00](self.impl), row_00, column_00, rowSpan_00, columnSpan_00))
  column = int(column_00)
  row = int(row_00)
  columnSpan = int(columnSpan_00)
  rowSpan = int(rowSpan_00)

proc atk_table_cell_get_row_header_cells*(self: ptr TableCell00): ptr PtrArray {.
    importc: "atk_table_cell_get_row_header_cells", libprag.}

proc getRowHeaderCells*(self: TableCell): ptr PtrArray =
  atk_table_cell_get_row_header_cells(cast[ptr TableCell00](self.impl))

proc rowHeaderCells*(self: TableCell): ptr PtrArray =
  atk_table_cell_get_row_header_cells(cast[ptr TableCell00](self.impl))

proc atk_table_cell_get_row_span*(self: ptr TableCell00): int32 {.
    importc: "atk_table_cell_get_row_span", libprag.}

proc getRowSpan*(self: TableCell): int =
  int(atk_table_cell_get_row_span(cast[ptr TableCell00](self.impl)))

proc rowSpan*(self: TableCell): int =
  int(atk_table_cell_get_row_span(cast[ptr TableCell00](self.impl)))

proc atk_table_cell_get_table*(self: ptr TableCell00): ptr Object00 {.
    importc: "atk_table_cell_get_table", libprag.}

proc getTable*(self: TableCell): Object =
  let gobj = atk_table_cell_get_table(cast[ptr TableCell00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc table*(self: TableCell): Object =
  let gobj = atk_table_cell_get_table(cast[ptr TableCell00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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
  TableCellIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getColumnSpan*: proc(cell: ptr TableCell00): int32 {.cdecl.}
    getColumnHeaderCells*: proc(cell: ptr TableCell00): ptr PtrArray {.cdecl.}
    getPosition*: proc(cell: ptr TableCell00; row: var int32; column: var int32): gboolean {.cdecl.}
    getRowSpan*: proc(cell: ptr TableCell00): int32 {.cdecl.}
    getRowHeaderCells*: proc(cell: ptr TableCell00): ptr PtrArray {.cdecl.}
    getRowColumnSpan*: proc(cell: ptr TableCell00; row: var int32; column: var int32; 
    rowSpan: var int32; columnSpan: var int32): gboolean {.cdecl.}
    getTable*: proc(cell: ptr TableCell00): ptr Object00 {.cdecl.}
  TableCellIface* = ref object
    impl*: ptr TableCellIface00

type
  TableIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    refAt*: proc(table: ptr Table00; row: int32; column: int32): ptr Object00 {.cdecl.}
    getIndexAt*: proc(table: ptr Table00; row: int32; column: int32): int32 {.cdecl.}
    getColumnAtIndex*: proc(table: ptr Table00; index: int32): int32 {.cdecl.}
    getRowAtIndex*: proc(table: ptr Table00; index: int32): int32 {.cdecl.}
    getNColumns*: proc(table: ptr Table00): int32 {.cdecl.}
    getNRows*: proc(table: ptr Table00): int32 {.cdecl.}
    getColumnExtentAt*: proc(table: ptr Table00; row: int32; column: int32): int32 {.cdecl.}
    getRowExtentAt*: proc(table: ptr Table00; row: int32; column: int32): int32 {.cdecl.}
    getCaption*: proc(table: ptr Table00): ptr Object00 {.cdecl.}
    getColumnDescription*: proc(table: ptr Table00; column: int32): cstring {.cdecl.}
    getColumnHeader*: proc(table: ptr Table00; column: int32): ptr Object00 {.cdecl.}
    getRowDescription*: proc(table: ptr Table00; row: int32): cstring {.cdecl.}
    getRowHeader*: proc(table: ptr Table00; row: int32): ptr Object00 {.cdecl.}
    getSummary*: proc(table: ptr Table00): ptr Object00 {.cdecl.}
    setCaption*: proc(table: ptr Table00; caption: ptr Object00) {.cdecl.}
    setColumnDescription*: proc(table: ptr Table00; column: int32; description: cstring) {.cdecl.}
    setColumnHeader*: proc(table: ptr Table00; column: int32; header: ptr Object00) {.cdecl.}
    setRowDescription*: proc(table: ptr Table00; row: int32; description: cstring) {.cdecl.}
    setRowHeader*: proc(table: ptr Table00; row: int32; header: ptr Object00) {.cdecl.}
    setSummary*: proc(table: ptr Table00; accessible: ptr Object00) {.cdecl.}
    getSelectedColumns*: proc(table: ptr Table00; selected: ptr int32): int32 {.cdecl.}
    getSelectedRows*: proc(table: ptr Table00; selected: ptr int32): int32 {.cdecl.}
    isColumnSelected*: proc(table: ptr Table00; column: int32): gboolean {.cdecl.}
    isRowSelected*: proc(table: ptr Table00; row: int32): gboolean {.cdecl.}
    isSelected*: proc(table: ptr Table00; row: int32; column: int32): gboolean {.cdecl.}
    addRowSelection*: proc(table: ptr Table00; row: int32): gboolean {.cdecl.}
    removeRowSelection*: proc(table: ptr Table00; row: int32): gboolean {.cdecl.}
    addColumnSelection*: proc(table: ptr Table00; column: int32): gboolean {.cdecl.}
    removeColumnSelection*: proc(table: ptr Table00; column: int32): gboolean {.cdecl.}
    rowInserted*: proc(table: ptr Table00; row: int32; numInserted: int32) {.cdecl.}
    columnInserted*: proc(table: ptr Table00; column: int32; numInserted: int32) {.cdecl.}
    rowDeleted*: proc(table: ptr Table00; row: int32; numDeleted: int32) {.cdecl.}
    columnDeleted*: proc(table: ptr Table00; column: int32; numDeleted: int32) {.cdecl.}
    rowReordered*: proc(table: ptr Table00) {.cdecl.}
    columnReordered*: proc(table: ptr Table00) {.cdecl.}
    modelChanged*: proc(table: ptr Table00) {.cdecl.}
  TableIface* = ref object
    impl*: ptr TableIface00

type
  Text00* {.pure.} = object
  Text* = ref object
    impl*: ptr Text00

proc atk_text_add_selection*(self: ptr Text00; startOffset: int32; endOffset: int32): gboolean {.
    importc: "atk_text_add_selection", libprag.}

proc addSelection*(self: Text; startOffset: int; endOffset: int): bool =
  toBool(atk_text_add_selection(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset)))

proc atk_text_get_caret_offset*(self: ptr Text00): int32 {.
    importc: "atk_text_get_caret_offset", libprag.}

proc getCaretOffset*(self: Text): int =
  int(atk_text_get_caret_offset(cast[ptr Text00](self.impl)))

proc caretOffset*(self: Text): int =
  int(atk_text_get_caret_offset(cast[ptr Text00](self.impl)))

proc atk_text_get_character_at_offset*(self: ptr Text00; offset: int32): gunichar {.
    importc: "atk_text_get_character_at_offset", libprag.}

proc getCharacterAtOffset*(self: Text; offset: int): gunichar =
  atk_text_get_character_at_offset(cast[ptr Text00](self.impl), int32(offset))

proc characterAtOffset*(self: Text; offset: int): gunichar =
  atk_text_get_character_at_offset(cast[ptr Text00](self.impl), int32(offset))

proc atk_text_get_character_count*(self: ptr Text00): int32 {.
    importc: "atk_text_get_character_count", libprag.}

proc getCharacterCount*(self: Text): int =
  int(atk_text_get_character_count(cast[ptr Text00](self.impl)))

proc characterCount*(self: Text): int =
  int(atk_text_get_character_count(cast[ptr Text00](self.impl)))

proc atk_text_get_character_extents*(self: ptr Text00; offset: int32; x: var int32; y: var int32; 
    width: var int32; height: var int32; coords: CoordType) {.
    importc: "atk_text_get_character_extents", libprag.}

proc getCharacterExtents*(self: Text; offset: int; x: var int; y: var int; width: var int; 
    height: var int; coords: CoordType) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  atk_text_get_character_extents(cast[ptr Text00](self.impl), int32(offset), x_00, y_00, width_00, height_00, coords)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc characterExtents*(self: Text; offset: int; x: var int; y: var int; width: var int; 
    height: var int; coords: CoordType) =
  var height_00 = int32(height)
  var y_00 = int32(y)
  var width_00 = int32(width)
  var x_00 = int32(x)
  atk_text_get_character_extents(cast[ptr Text00](self.impl), int32(offset), x_00, y_00, width_00, height_00, coords)
  height = int(height_00)
  y = int(y_00)
  width = int(width_00)
  x = int(x_00)

proc atk_text_get_default_attributes*(self: ptr Text00): ptr pointer {.
    importc: "atk_text_get_default_attributes", libprag.}

proc getDefaultAttributes*(self: Text): ptr pointer =
  atk_text_get_default_attributes(cast[ptr Text00](self.impl))

proc defaultAttributes*(self: Text): ptr pointer =
  atk_text_get_default_attributes(cast[ptr Text00](self.impl))

proc atk_text_get_n_selections*(self: ptr Text00): int32 {.
    importc: "atk_text_get_n_selections", libprag.}

proc getNSelections*(self: Text): int =
  int(atk_text_get_n_selections(cast[ptr Text00](self.impl)))

proc nSelections*(self: Text): int =
  int(atk_text_get_n_selections(cast[ptr Text00](self.impl)))

proc atk_text_get_offset_at_point*(self: ptr Text00; x: int32; y: int32; coords: CoordType): int32 {.
    importc: "atk_text_get_offset_at_point", libprag.}

proc getOffsetAtPoint*(self: Text; x: int; y: int; coords: CoordType): int =
  int(atk_text_get_offset_at_point(cast[ptr Text00](self.impl), int32(x), int32(y), coords))

proc offsetAtPoint*(self: Text; x: int; y: int; coords: CoordType): int =
  int(atk_text_get_offset_at_point(cast[ptr Text00](self.impl), int32(x), int32(y), coords))

proc atk_text_get_run_attributes*(self: ptr Text00; offset: int32; startOffset: var int32; 
    endOffset: var int32): ptr pointer {.
    importc: "atk_text_get_run_attributes", libprag.}

proc getRunAttributes*(self: Text; offset: int; startOffset: var int; endOffset: var int): ptr pointer =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  result = atk_text_get_run_attributes(cast[ptr Text00](self.impl), int32(offset), startOffset_00, endOffset_00)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc runAttributes*(self: Text; offset: int; startOffset: var int; endOffset: var int): ptr pointer =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  result = atk_text_get_run_attributes(cast[ptr Text00](self.impl), int32(offset), startOffset_00, endOffset_00)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc atk_text_get_selection*(self: ptr Text00; selectionNum: int32; startOffset: var int32; 
    endOffset: var int32): cstring {.
    importc: "atk_text_get_selection", libprag.}

proc getSelection*(self: Text; selectionNum: int; startOffset: var int; 
    endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_selection(cast[ptr Text00](self.impl), int32(selectionNum), startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc selection*(self: Text; selectionNum: int; startOffset: var int; 
    endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_selection(cast[ptr Text00](self.impl), int32(selectionNum), startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc atk_text_get_text*(self: ptr Text00; startOffset: int32; endOffset: int32): cstring {.
    importc: "atk_text_get_text", libprag.}

proc getText*(self: Text; startOffset: int; endOffset: int): string =
  let resul0 = atk_text_get_text(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset))
  result = $resul0
  cogfree(resul0)

proc text*(self: Text; startOffset: int; endOffset: int): string =
  let resul0 = atk_text_get_text(cast[ptr Text00](self.impl), int32(startOffset), int32(endOffset))
  result = $resul0
  cogfree(resul0)

proc atk_text_remove_selection*(self: ptr Text00; selectionNum: int32): gboolean {.
    importc: "atk_text_remove_selection", libprag.}

proc removeSelection*(self: Text; selectionNum: int): bool =
  toBool(atk_text_remove_selection(cast[ptr Text00](self.impl), int32(selectionNum)))

proc atk_text_set_caret_offset*(self: ptr Text00; offset: int32): gboolean {.
    importc: "atk_text_set_caret_offset", libprag.}

proc setCaretOffset*(self: Text; offset: int): bool =
  toBool(atk_text_set_caret_offset(cast[ptr Text00](self.impl), int32(offset)))

proc `caretOffset=`*(self: Text; offset: int): bool =
  toBool(atk_text_set_caret_offset(cast[ptr Text00](self.impl), int32(offset)))

proc atk_text_set_selection*(self: ptr Text00; selectionNum: int32; startOffset: int32; 
    endOffset: int32): gboolean {.
    importc: "atk_text_set_selection", libprag.}

proc setSelection*(self: Text; selectionNum: int; startOffset: int; endOffset: int): bool =
  toBool(atk_text_set_selection(cast[ptr Text00](self.impl), int32(selectionNum), int32(startOffset), int32(endOffset)))

type
  TextRectangle00* {.pure.} = object
    x*: int32
    y*: int32
    width*: int32
    height*: int32
  TextRectangle* = ref object
    impl*: ptr TextRectangle00

type
  TextRange00* {.pure.} = object
    bounds*: TextRectangle00
    startOffset*: int32
    endOffset*: int32
    content*: cstring
  TextRange* = ref object
    impl*: ptr TextRange00

proc atk_text_free_ranges*(ranges: ptr TextRange00Array) {.
    importc: "atk_text_free_ranges", libprag.}

proc freeRanges*(ranges: ptr TextRange00Array) {.
    importc: "atk_text_free_ranges", libprag.}

proc atk_text_get_range_extents*(self: ptr Text00; startOffset: int32; endOffset: int32; 
    coordType: CoordType; rect: var TextRectangle00) {.
    importc: "atk_text_get_range_extents", libprag.}

proc getRangeExtents*(self: ptr Text00; startOffset: int32; endOffset: int32; 
    coordType: CoordType; rect: var TextRectangle00) {.
    importc: "atk_text_get_range_extents", libprag.}

proc rangeExtents*(self: ptr Text00; startOffset: int32; endOffset: int32; 
    coordType: CoordType; rect: var TextRectangle00) {.
    importc: "atk_text_get_range_extents", libprag.}

type
  TextClipType* {.size: sizeof(cint), pure.} = enum
    none = 0
    min = 1
    max = 2
    both = 3

proc atk_text_get_bounded_ranges*(self: ptr Text00; rect: ptr TextRectangle00; coordType: CoordType; 
    xClipType: TextClipType; yClipType: TextClipType): ptr TextRange00Array {.
    importc: "atk_text_get_bounded_ranges", libprag.}

proc getBoundedRanges*(self: Text; rect: TextRectangle; coordType: CoordType; 
    xClipType: TextClipType; yClipType: TextClipType): ptr TextRange00Array =
  atk_text_get_bounded_ranges(cast[ptr Text00](self.impl), cast[ptr TextRectangle00](rect.impl), coordType, xClipType, yClipType)

proc boundedRanges*(self: Text; rect: TextRectangle; coordType: CoordType; 
    xClipType: TextClipType; yClipType: TextClipType): ptr TextRange00Array =
  atk_text_get_bounded_ranges(cast[ptr Text00](self.impl), cast[ptr TextRectangle00](rect.impl), coordType, xClipType, yClipType)

type
  TextGranularity* {.size: sizeof(cint), pure.} = enum
    char = 0
    word = 1
    sentence = 2
    line = 3
    paragraph = 4

proc atk_text_get_string_at_offset*(self: ptr Text00; offset: int32; granularity: TextGranularity; 
    startOffset: var int32; endOffset: var int32): cstring {.
    importc: "atk_text_get_string_at_offset", libprag.}

proc getStringAtOffset*(self: Text; offset: int; granularity: TextGranularity; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_string_at_offset(cast[ptr Text00](self.impl), int32(offset), granularity, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc stringAtOffset*(self: Text; offset: int; granularity: TextGranularity; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_string_at_offset(cast[ptr Text00](self.impl), int32(offset), granularity, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

type
  TextBoundary* {.size: sizeof(cint), pure.} = enum
    char = 0
    wordStart = 1
    wordEnd = 2
    sentenceStart = 3
    sentenceEnd = 4
    lineStart = 5
    lineEnd = 6

proc atk_text_get_text_after_offset*(self: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.
    importc: "atk_text_get_text_after_offset", libprag.}

proc getTextAfterOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_after_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc textAfterOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_after_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc atk_text_get_text_at_offset*(self: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.
    importc: "atk_text_get_text_at_offset", libprag.}

proc getTextAtOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_at_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc textAtOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_at_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc atk_text_get_text_before_offset*(self: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.
    importc: "atk_text_get_text_before_offset", libprag.}

proc getTextBeforeOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_before_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

proc textBeforeOffset*(self: Text; offset: int; boundaryType: TextBoundary; 
    startOffset: var int; endOffset: var int): string =
  var startOffset_00 = int32(startOffset)
  var endOffset_00 = int32(endOffset)
  let resul0 = atk_text_get_text_before_offset(cast[ptr Text00](self.impl), int32(offset), boundaryType, startOffset_00, endOffset_00)
  result = $resul0
  cogfree(resul0)
  startOffset = int(startOffset_00)
  endOffset = int(endOffset_00)

type
  TextAttribute* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    leftMargin = 1
    rightMargin = 2
    indent = 3
    invisible = 4
    editable = 5
    pixelsAboveLines = 6
    pixelsBelowLines = 7
    pixelsInsideWrap = 8
    bgFullHeight = 9
    rise = 10
    underline = 11
    strikethrough = 12
    size = 13
    scale = 14
    weight = 15
    language = 16
    familyName = 17
    bgColor = 18
    fgColor = 19
    bgStipple = 20
    fgStipple = 21
    wrapMode = 22
    direction = 23
    justification = 24
    stretch = 25
    variant = 26
    style = 27
    lastDefined = 28

proc atk_text_attribute_for_name*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_for_name", libprag.}

proc forName*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_for_name", libprag.}

proc atk_text_attribute_get_name*(attr: TextAttribute): cstring {.
    importc: "atk_text_attribute_get_name", libprag.}

proc getName*(attr: TextAttribute): string =
  let resul0 = atk_text_attribute_get_name(attr)
  result = $resul0

proc name*(attr: TextAttribute): string =
  let resul0 = atk_text_attribute_get_name(attr)
  result = $resul0

proc atk_text_attribute_get_value*(attr: TextAttribute; index: int32): cstring {.
    importc: "atk_text_attribute_get_value", libprag.}

proc getValue*(attr: TextAttribute; index: int): string =
  let resul0 = atk_text_attribute_get_value(attr, int32(index))
  result = $resul0

proc value*(attr: TextAttribute; index: int): string =
  let resul0 = atk_text_attribute_get_value(attr, int32(index))
  result = $resul0

proc atk_text_attribute_register*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_register", libprag.}

proc register*(name: cstring): TextAttribute {.
    importc: "atk_text_attribute_register", libprag.}

type
  TextIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getText*: proc(text: ptr Text00; startOffset: int32; endOffset: int32): cstring {.cdecl.}
    getTextAfterOffset*: proc(text: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.cdecl.}
    getTextAtOffset*: proc(text: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.cdecl.}
    getCharacterAtOffset*: proc(text: ptr Text00; offset: int32): gunichar {.cdecl.}
    getTextBeforeOffset*: proc(text: ptr Text00; offset: int32; boundaryType: TextBoundary; 
    startOffset: var int32; endOffset: var int32): cstring {.cdecl.}
    getCaretOffset*: proc(text: ptr Text00): int32 {.cdecl.}
    getRunAttributes*: proc(text: ptr Text00; offset: int32; startOffset: var int32; 
    endOffset: var int32): ptr pointer {.cdecl.}
    getDefaultAttributes*: proc(text: ptr Text00): ptr pointer {.cdecl.}
    getCharacterExtents*: proc(text: ptr Text00; offset: int32; x: var int32; y: var int32; 
    width: var int32; height: var int32; coords: CoordType) {.cdecl.}
    getCharacterCount*: proc(text: ptr Text00): int32 {.cdecl.}
    getOffsetAtPoint*: proc(text: ptr Text00; x: int32; y: int32; coords: CoordType): int32 {.cdecl.}
    getNSelections*: proc(text: ptr Text00): int32 {.cdecl.}
    getSelection*: proc(text: ptr Text00; selectionNum: int32; startOffset: var int32; 
    endOffset: var int32): cstring {.cdecl.}
    addSelection*: proc(text: ptr Text00; startOffset: int32; endOffset: int32): gboolean {.cdecl.}
    removeSelection*: proc(text: ptr Text00; selectionNum: int32): gboolean {.cdecl.}
    setSelection*: proc(text: ptr Text00; selectionNum: int32; startOffset: int32; 
    endOffset: int32): gboolean {.cdecl.}
    setCaretOffset*: proc(text: ptr Text00; offset: int32): gboolean {.cdecl.}
    textChanged*: proc(text: ptr Text00; position: int32; length: int32) {.cdecl.}
    textCaretMoved*: proc(text: ptr Text00; location: int32) {.cdecl.}
    textSelectionChanged*: proc(text: ptr Text00) {.cdecl.}
    textAttributesChanged*: proc(text: ptr Text00) {.cdecl.}
    getRangeExtents*: proc(text: ptr Text00; startOffset: int32; endOffset: int32; 
    coordType: CoordType; rect: var TextRectangle00) {.cdecl.}
    getBoundedRanges*: proc(text: ptr Text00; rect: ptr TextRectangle00; coordType: CoordType; 
    xClipType: TextClipType; yClipType: TextClipType): ptr TextRange00 {.cdecl.}
    getStringAtOffset*: proc(text: ptr Text00; offset: int32; granularity: TextGranularity; 
    startOffset: var int32; endOffset: var int32): cstring {.cdecl.}
  TextIface* = ref object
    impl*: ptr TextIface00

type
  Util* = ref object of gobject.Object
  Util00* = object of gobject.Object00

type
  UtilClass00* {.pure.} = object
    parent*: gobject.ObjectClass00
    addGlobalEventListener*: pointer
    removeGlobalEventListener*: proc(listenerId: uint32) {.cdecl.}
    addKeyEventListener*: pointer
    removeKeyEventListener*: proc(listenerId: uint32) {.cdecl.}
    getRoot*: pointer
    getToolkitName*: proc(): cstring {.cdecl.}
    getToolkitVersion*: proc(): cstring {.cdecl.}
  UtilClass* = ref object
    impl*: ptr UtilClass00

const VERSION_MIN_REQUIRED* = 2'i32

type
  Value00* {.pure.} = object
  Value* = ref object
    impl*: ptr Value00

proc atk_value_get_current_value*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_current_value", libprag.}

proc getCurrentValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_current_value", libprag.}

proc currentValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_current_value", libprag.}

proc atk_value_get_increment*(self: ptr Value00): cdouble {.
    importc: "atk_value_get_increment", libprag.}

proc getIncrement*(self: Value): cdouble =
  atk_value_get_increment(cast[ptr Value00](self.impl))

proc increment*(self: Value): cdouble =
  atk_value_get_increment(cast[ptr Value00](self.impl))

proc atk_value_get_maximum_value*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_maximum_value", libprag.}

proc getMaximumValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_maximum_value", libprag.}

proc maximumValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_maximum_value", libprag.}

proc atk_value_get_minimum_increment*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_increment", libprag.}

proc getMinimumIncrement*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_increment", libprag.}

proc minimumIncrement*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_increment", libprag.}

proc atk_value_get_minimum_value*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_value", libprag.}

proc getMinimumValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_value", libprag.}

proc minimumValue*(self: ptr Value00; value: var gobject.Value00) {.
    importc: "atk_value_get_minimum_value", libprag.}

proc atk_value_get_range*(self: ptr Value00): ptr Range00 {.
    importc: "atk_value_get_range", libprag.}

proc getRange*(self: Value): Range =
  new(result)
  result.impl = atk_value_get_range(cast[ptr Value00](self.impl))

proc range*(self: Value): Range =
  new(result)
  result.impl = atk_value_get_range(cast[ptr Value00](self.impl))

proc atk_value_get_sub_ranges*(self: ptr Value00): ptr pointer {.
    importc: "atk_value_get_sub_ranges", libprag.}

proc getSubRanges*(self: Value): ptr pointer =
  atk_value_get_sub_ranges(cast[ptr Value00](self.impl))

proc subRanges*(self: Value): ptr pointer =
  atk_value_get_sub_ranges(cast[ptr Value00](self.impl))

proc atk_value_get_value_and_text*(self: ptr Value00; value: var cdouble; text: var cstring) {.
    importc: "atk_value_get_value_and_text", libprag.}

proc getValueAndText*(self: Value; value: var cdouble; text: var string) =
  var text_00 = cstring(text)
  atk_value_get_value_and_text(cast[ptr Value00](self.impl), value, text_00)
  text = $(text_00)

proc valueAndText*(self: Value; value: var cdouble; text: var string) =
  var text_00 = cstring(text)
  atk_value_get_value_and_text(cast[ptr Value00](self.impl), value, text_00)
  text = $(text_00)

proc atk_value_set_current_value*(self: ptr Value00; value: ptr gobject.Value00): gboolean {.
    importc: "atk_value_set_current_value", libprag.}

proc setCurrentValue*(self: Value; value: gobject.Value): bool =
  toBool(atk_value_set_current_value(cast[ptr Value00](self.impl), cast[ptr gobject.Value00](value.impl)))

proc `currentValue=`*(self: Value; value: gobject.Value): bool =
  toBool(atk_value_set_current_value(cast[ptr Value00](self.impl), cast[ptr gobject.Value00](value.impl)))

proc atk_value_set_value*(self: ptr Value00; newValue: cdouble) {.
    importc: "atk_value_set_value", libprag.}

proc setValue*(self: Value; newValue: cdouble) =
  atk_value_set_value(cast[ptr Value00](self.impl), newValue)

proc `value=`*(self: Value; newValue: cdouble) =
  atk_value_set_value(cast[ptr Value00](self.impl), newValue)

type
  ValueIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
    getCurrentValue*: proc(obj: ptr Value00; value: var gobject.Value00) {.cdecl.}
    getMaximumValue*: proc(obj: ptr Value00; value: var gobject.Value00) {.cdecl.}
    getMinimumValue*: proc(obj: ptr Value00; value: var gobject.Value00) {.cdecl.}
    setCurrentValue*: proc(obj: ptr Value00; value: ptr gobject.Value00): gboolean {.cdecl.}
    getMinimumIncrement*: proc(obj: ptr Value00; value: var gobject.Value00) {.cdecl.}
    getValueAndText*: proc(obj: ptr Value00; value: var cdouble; text: var cstring) {.cdecl.}
    getRange*: proc(obj: ptr Value00): ptr Range00 {.cdecl.}
    getIncrement*: proc(obj: ptr Value00): cdouble {.cdecl.}
    getSubRanges*: proc(obj: ptr Value00): ptr pointer {.cdecl.}
    setValue*: proc(obj: ptr Value00; newValue: cdouble) {.cdecl.}
  ValueIface* = ref object
    impl*: ptr ValueIface00

type
  ValueType* {.size: sizeof(cint), pure.} = enum
    veryWeak = 0
    weak = 1
    acceptable = 2
    strong = 3
    veryStrong = 4
    veryLow = 5
    low = 6
    medium = 7
    high = 8
    veryHigh = 9
    veryBad = 10
    bad = 11
    good = 12
    veryGood = 13
    best = 14
    lastDefined = 15

proc atk_value_type_get_localized_name*(valueType: ValueType): cstring {.
    importc: "atk_value_type_get_localized_name", libprag.}

proc getLocalizedName*(valueType: ValueType): string =
  let resul0 = atk_value_type_get_localized_name(valueType)
  result = $resul0

proc localizedName*(valueType: ValueType): string =
  let resul0 = atk_value_type_get_localized_name(valueType)
  result = $resul0

proc atk_value_type_get_name*(valueType: ValueType): cstring {.
    importc: "atk_value_type_get_name", libprag.}

proc getName*(valueType: ValueType): string =
  let resul0 = atk_value_type_get_name(valueType)
  result = $resul0

proc name*(valueType: ValueType): string =
  let resul0 = atk_value_type_get_name(valueType)
  result = $resul0

type
  Window00* {.pure.} = object
  Window* = ref object
    impl*: ptr Window00

type
  WindowIface00* {.pure.} = object
    parent*: gobject.TypeInterface00
  WindowIface* = ref object
    impl*: ptr WindowIface00

proc atk_focus_tracker_notify*(`object`: ptr Object00) {.
    importc: "atk_focus_tracker_notify", libprag.}

proc focusTrackerNotify*(`object`: Object) =
  atk_focus_tracker_notify(cast[ptr Object00](`object`.impl))

proc atk_get_binary_age*(): uint32 {.
    importc: "atk_get_binary_age", libprag.}

proc getBinaryAge*(): uint32 {.
    importc: "atk_get_binary_age", libprag.}

proc binaryAge*(): uint32 {.
    importc: "atk_get_binary_age", libprag.}

proc atk_get_default_registry*(): ptr Registry00 {.
    importc: "atk_get_default_registry", libprag.}

proc getDefaultRegistry*(): Registry =
  let gobj = atk_get_default_registry()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Registry](g_object_get_qdata(gobj, Quark))
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

proc defaultRegistry*(): Registry =
  let gobj = atk_get_default_registry()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Registry](g_object_get_qdata(gobj, Quark))
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

proc atk_get_focus_object*(): ptr Object00 {.
    importc: "atk_get_focus_object", libprag.}

proc getFocusObject*(): Object =
  let gobj = atk_get_focus_object()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc focusObject*(): Object =
  let gobj = atk_get_focus_object()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_get_interface_age*(): uint32 {.
    importc: "atk_get_interface_age", libprag.}

proc getInterfaceAge*(): uint32 {.
    importc: "atk_get_interface_age", libprag.}

proc interfaceAge*(): uint32 {.
    importc: "atk_get_interface_age", libprag.}

proc atk_get_major_version*(): uint32 {.
    importc: "atk_get_major_version", libprag.}

proc getMajorVersion*(): uint32 {.
    importc: "atk_get_major_version", libprag.}

proc majorVersion*(): uint32 {.
    importc: "atk_get_major_version", libprag.}

proc atk_get_micro_version*(): uint32 {.
    importc: "atk_get_micro_version", libprag.}

proc getMicroVersion*(): uint32 {.
    importc: "atk_get_micro_version", libprag.}

proc microVersion*(): uint32 {.
    importc: "atk_get_micro_version", libprag.}

proc atk_get_minor_version*(): uint32 {.
    importc: "atk_get_minor_version", libprag.}

proc getMinorVersion*(): uint32 {.
    importc: "atk_get_minor_version", libprag.}

proc minorVersion*(): uint32 {.
    importc: "atk_get_minor_version", libprag.}

proc atk_get_root*(): ptr Object00 {.
    importc: "atk_get_root", libprag.}

proc getRoot*(): Object =
  let gobj = atk_get_root()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc root*(): Object =
  let gobj = atk_get_root()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
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

proc atk_get_toolkit_name*(): cstring {.
    importc: "atk_get_toolkit_name", libprag.}

proc getToolkitName*(): string =
  let resul0 = atk_get_toolkit_name()
  result = $resul0

proc toolkitName*(): string =
  let resul0 = atk_get_toolkit_name()
  result = $resul0

proc atk_get_toolkit_version*(): cstring {.
    importc: "atk_get_toolkit_version", libprag.}

proc getToolkitVersion*(): string =
  let resul0 = atk_get_toolkit_version()
  result = $resul0

proc toolkitVersion*(): string =
  let resul0 = atk_get_toolkit_version()
  result = $resul0

proc atk_get_version*(): cstring {.
    importc: "atk_get_version", libprag.}

proc getVersion*(): string =
  let resul0 = atk_get_version()
  result = $resul0

proc version*(): string =
  let resul0 = atk_get_version()
  result = $resul0

proc atk_remove_focus_tracker*(trackerId: uint32) {.
    importc: "atk_remove_focus_tracker", libprag.}

proc removeFocusTracker*(trackerId: uint32) {.
    importc: "atk_remove_focus_tracker", libprag.}

proc atk_remove_global_event_listener*(listenerId: uint32) {.
    importc: "atk_remove_global_event_listener", libprag.}

proc removeGlobalEventListener*(listenerId: uint32) {.
    importc: "atk_remove_global_event_listener", libprag.}

proc atk_remove_key_event_listener*(listenerId: uint32) {.
    importc: "atk_remove_key_event_listener", libprag.}

proc removeKeyEventListener*(listenerId: uint32) {.
    importc: "atk_remove_key_event_listener", libprag.}
# === remaining symbols:

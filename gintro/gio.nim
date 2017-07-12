# dependencies:
# GLib-2.0
# GObject-2.0
# immediate dependencies:
# GObject-2.0
# libraries:
# libgio-2.0.so.0
{.deadCodeElim: on.}
import glib, gobject
const Lib* = "libgio-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  ActionEntry00Array* = pointer
type
  DBusAnnotationInfo00Array* = pointer
type
  DBusArgInfo00Array* = pointer
type
  DBusMethodInfo00Array* = pointer
type
  DBusSignalInfo00Array* = pointer
type
  DBusPropertyInfo00Array* = pointer
type
  DBusInterfaceInfo00Array* = pointer
type
  DBusNodeInfo00Array* = pointer
type
  InputVector00Array* = pointer
type
  SocketControlMessage00Array* = pointer
type
  InputMessage00Array* = pointer
type
  OutputMessage00Array* = pointer
type
  utf8ArrayArray* = pointer
type
  cstringArrayArray* = pointer
type
  File00Array* = pointer
type
  Array* = pointer
type
  OutputVector00Array* = pointer
let Quark = g_quark_from_static_string("NimGIQuark")

type
  Action00* {.pure.} = object
  Action* = ref object
    impl*: ptr Action00

proc g_action_name_is_valid*(actionName: cstring): gboolean {.
    importc: "g_action_name_is_valid", libprag.}

proc nameIsValid*(actionName: cstring): gboolean {.
    importc: "g_action_name_is_valid", libprag.}

proc g_action_parse_detailed_name*(detailedName: cstring; actionName: var cstring; targetValue: var ptr glib.Variant00): gboolean {.
    importc: "g_action_parse_detailed_name", libprag.}

proc parseDetailedName*(detailedName: cstring; actionName: var cstring; targetValue: var ptr glib.Variant00): gboolean {.
    importc: "g_action_parse_detailed_name", libprag.}

proc g_action_print_detailed_name*(actionName: cstring; targetValue: ptr glib.Variant00): cstring {.
    importc: "g_action_print_detailed_name", libprag.}

proc printDetailedName*(actionName: string; targetValue: glib.Variant): string =
  let resul0 = g_action_print_detailed_name(cstring(actionName), cast[ptr glib.Variant00](targetValue.impl))
  result = $resul0
  cogfree(resul0)

proc g_action_activate*(self: ptr Action00; parameter: ptr glib.Variant00) {.
    importc: "g_action_activate", libprag.}

proc activate*(self: Action; parameter: glib.Variant) =
  g_action_activate(cast[ptr Action00](self.impl), cast[ptr glib.Variant00](parameter.impl))

proc g_action_change_state*(self: ptr Action00; value: ptr glib.Variant00) {.
    importc: "g_action_change_state", libprag.}

proc changeState*(self: Action; value: glib.Variant) =
  g_action_change_state(cast[ptr Action00](self.impl), cast[ptr glib.Variant00](value.impl))

proc g_action_get_enabled*(self: ptr Action00): gboolean {.
    importc: "g_action_get_enabled", libprag.}

proc getEnabled*(self: Action): bool =
  toBool(g_action_get_enabled(cast[ptr Action00](self.impl)))

proc enabled*(self: Action): bool =
  toBool(g_action_get_enabled(cast[ptr Action00](self.impl)))

proc g_action_get_name*(self: ptr Action00): cstring {.
    importc: "g_action_get_name", libprag.}

proc getName*(self: Action): string =
  let resul0 = g_action_get_name(cast[ptr Action00](self.impl))
  result = $resul0

proc name*(self: Action): string =
  let resul0 = g_action_get_name(cast[ptr Action00](self.impl))
  result = $resul0

proc g_action_get_parameter_type*(self: ptr Action00): ptr glib.VariantType00 {.
    importc: "g_action_get_parameter_type", libprag.}

proc getParameterType*(self: Action): glib.VariantType =
  new(result)
  result.impl = g_action_get_parameter_type(cast[ptr Action00](self.impl))

proc parameterType*(self: Action): glib.VariantType =
  new(result)
  result.impl = g_action_get_parameter_type(cast[ptr Action00](self.impl))

proc g_action_get_state*(self: ptr Action00): ptr glib.Variant00 {.
    importc: "g_action_get_state", libprag.}

proc getState*(self: Action): glib.Variant =
  new(result)
  result.impl = g_action_get_state(cast[ptr Action00](self.impl))

proc state*(self: Action): glib.Variant =
  new(result)
  result.impl = g_action_get_state(cast[ptr Action00](self.impl))

proc g_action_get_state_hint*(self: ptr Action00): ptr glib.Variant00 {.
    importc: "g_action_get_state_hint", libprag.}

proc getStateHint*(self: Action): glib.Variant =
  new(result)
  result.impl = g_action_get_state_hint(cast[ptr Action00](self.impl))

proc stateHint*(self: Action): glib.Variant =
  new(result)
  result.impl = g_action_get_state_hint(cast[ptr Action00](self.impl))

proc g_action_get_state_type*(self: ptr Action00): ptr glib.VariantType00 {.
    importc: "g_action_get_state_type", libprag.}

proc getStateType*(self: Action): glib.VariantType =
  new(result)
  result.impl = g_action_get_state_type(cast[ptr Action00](self.impl))

proc stateType*(self: Action): glib.VariantType =
  new(result)
  result.impl = g_action_get_state_type(cast[ptr Action00](self.impl))

type
  SimpleAction* = ref object of gobject.Object
  SimpleAction00* = object of gobject.Object00

proc scActivate*(self: SimpleAction;  p: proc (self: ptr gobject.Object00; parameter: glib.Variant00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scChangeState*(self: SimpleAction;  p: proc (self: ptr gobject.Object00; value: glib.Variant00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "change-state", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_simple_action_new*(name: cstring; parameterType: ptr glib.VariantType00): ptr SimpleAction00 {.
    importc: "g_simple_action_new", libprag.}

proc newSimpleAction*(name: string; parameterType: glib.VariantType): SimpleAction =
  new(result, finalizeGObject)
  result.impl = g_simple_action_new(cstring(name), cast[ptr glib.VariantType00](parameterType.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleAction*[T](result: var T; name: string; parameterType: glib.VariantType) =
  assert(result is SimpleAction)
  new(result, finalizeGObject)
  result.impl = g_simple_action_new(cstring(name), cast[ptr glib.VariantType00](parameterType.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_simple_action_new_stateful*(name: cstring; parameterType: ptr glib.VariantType00; 
    state: ptr glib.Variant00): ptr SimpleAction00 {.
    importc: "g_simple_action_new_stateful", libprag.}

proc newSimpleActionStateful*(name: string; parameterType: glib.VariantType; state: glib.Variant): SimpleAction =
  new(result, finalizeGObject)
  result.impl = g_simple_action_new_stateful(cstring(name), cast[ptr glib.VariantType00](parameterType.impl), cast[ptr glib.Variant00](state.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleActionStateful*[T](result: var T; name: string; parameterType: glib.VariantType; state: glib.Variant) =
  assert(result is SimpleAction)
  new(result, finalizeGObject)
  result.impl = g_simple_action_new_stateful(cstring(name), cast[ptr glib.VariantType00](parameterType.impl), cast[ptr glib.Variant00](state.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_simple_action_set_enabled*(self: ptr SimpleAction00; enabled: gboolean) {.
    importc: "g_simple_action_set_enabled", libprag.}

proc setEnabled*(self: SimpleAction; enabled: bool) =
  g_simple_action_set_enabled(cast[ptr SimpleAction00](self.impl), gboolean(enabled))

proc `enabled=`*(self: SimpleAction; enabled: bool) =
  g_simple_action_set_enabled(cast[ptr SimpleAction00](self.impl), gboolean(enabled))

proc g_simple_action_set_state*(self: ptr SimpleAction00; value: ptr glib.Variant00) {.
    importc: "g_simple_action_set_state", libprag.}

proc setState*(self: SimpleAction; value: glib.Variant) =
  g_simple_action_set_state(cast[ptr SimpleAction00](self.impl), cast[ptr glib.Variant00](value.impl))

proc `state=`*(self: SimpleAction; value: glib.Variant) =
  g_simple_action_set_state(cast[ptr SimpleAction00](self.impl), cast[ptr glib.Variant00](value.impl))

proc g_simple_action_set_state_hint*(self: ptr SimpleAction00; stateHint: ptr glib.Variant00) {.
    importc: "g_simple_action_set_state_hint", libprag.}

proc setStateHint*(self: SimpleAction; stateHint: glib.Variant) =
  g_simple_action_set_state_hint(cast[ptr SimpleAction00](self.impl), cast[ptr glib.Variant00](stateHint.impl))

proc `stateHint=`*(self: SimpleAction; stateHint: glib.Variant) =
  g_simple_action_set_state_hint(cast[ptr SimpleAction00](self.impl), cast[ptr glib.Variant00](stateHint.impl))

type
  ActionEntry00* {.pure.} = object
    name*: cstring
    activate*: proc(action: ptr SimpleAction00; parameter: ptr glib.Variant00; 
    userData: pointer) {.cdecl.}
    parameterType*: cstring
    state*: cstring
    changeState*: proc(action: ptr SimpleAction00; value: ptr glib.Variant00; 
    userData: pointer) {.cdecl.}
    padding*: array[3, uint64]
  ActionEntry* = ref object
    impl*: ptr ActionEntry00

type
  ActionGroup00* {.pure.} = object
  ActionGroup* = ref object
    impl*: ptr ActionGroup00

proc g_action_group_action_added*(self: ptr ActionGroup00; actionName: cstring) {.
    importc: "g_action_group_action_added", libprag.}

proc actionAdded*(self: ActionGroup; actionName: string) =
  g_action_group_action_added(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_action_enabled_changed*(self: ptr ActionGroup00; actionName: cstring; enabled: gboolean) {.
    importc: "g_action_group_action_enabled_changed", libprag.}

proc actionEnabledChanged*(self: ActionGroup; actionName: string; enabled: bool) =
  g_action_group_action_enabled_changed(cast[ptr ActionGroup00](self.impl), cstring(actionName), gboolean(enabled))

proc g_action_group_action_removed*(self: ptr ActionGroup00; actionName: cstring) {.
    importc: "g_action_group_action_removed", libprag.}

proc actionRemoved*(self: ActionGroup; actionName: string) =
  g_action_group_action_removed(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_action_state_changed*(self: ptr ActionGroup00; actionName: cstring; state: ptr glib.Variant00) {.
    importc: "g_action_group_action_state_changed", libprag.}

proc actionStateChanged*(self: ActionGroup; actionName: string; state: glib.Variant) =
  g_action_group_action_state_changed(cast[ptr ActionGroup00](self.impl), cstring(actionName), cast[ptr glib.Variant00](state.impl))

proc g_action_group_activate_action*(self: ptr ActionGroup00; actionName: cstring; parameter: ptr glib.Variant00) {.
    importc: "g_action_group_activate_action", libprag.}

proc activateAction*(self: ActionGroup; actionName: string; parameter: glib.Variant) =
  g_action_group_activate_action(cast[ptr ActionGroup00](self.impl), cstring(actionName), cast[ptr glib.Variant00](parameter.impl))

proc g_action_group_change_action_state*(self: ptr ActionGroup00; actionName: cstring; value: ptr glib.Variant00) {.
    importc: "g_action_group_change_action_state", libprag.}

proc changeActionState*(self: ActionGroup; actionName: string; value: glib.Variant) =
  g_action_group_change_action_state(cast[ptr ActionGroup00](self.impl), cstring(actionName), cast[ptr glib.Variant00](value.impl))

proc g_action_group_get_action_enabled*(self: ptr ActionGroup00; actionName: cstring): gboolean {.
    importc: "g_action_group_get_action_enabled", libprag.}

proc getActionEnabled*(self: ActionGroup; actionName: string): bool =
  toBool(g_action_group_get_action_enabled(cast[ptr ActionGroup00](self.impl), cstring(actionName)))

proc actionEnabled*(self: ActionGroup; actionName: string): bool =
  toBool(g_action_group_get_action_enabled(cast[ptr ActionGroup00](self.impl), cstring(actionName)))

proc g_action_group_get_action_parameter_type*(self: ptr ActionGroup00; actionName: cstring): ptr glib.VariantType00 {.
    importc: "g_action_group_get_action_parameter_type", libprag.}

proc getActionParameterType*(self: ActionGroup; actionName: string): glib.VariantType =
  new(result)
  result.impl = g_action_group_get_action_parameter_type(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc actionParameterType*(self: ActionGroup; actionName: string): glib.VariantType =
  new(result)
  result.impl = g_action_group_get_action_parameter_type(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_get_action_state*(self: ptr ActionGroup00; actionName: cstring): ptr glib.Variant00 {.
    importc: "g_action_group_get_action_state", libprag.}

proc getActionState*(self: ActionGroup; actionName: string): glib.Variant =
  new(result)
  result.impl = g_action_group_get_action_state(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc actionState*(self: ActionGroup; actionName: string): glib.Variant =
  new(result)
  result.impl = g_action_group_get_action_state(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_get_action_state_hint*(self: ptr ActionGroup00; actionName: cstring): ptr glib.Variant00 {.
    importc: "g_action_group_get_action_state_hint", libprag.}

proc getActionStateHint*(self: ActionGroup; actionName: string): glib.Variant =
  new(result)
  result.impl = g_action_group_get_action_state_hint(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc actionStateHint*(self: ActionGroup; actionName: string): glib.Variant =
  new(result)
  result.impl = g_action_group_get_action_state_hint(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_get_action_state_type*(self: ptr ActionGroup00; actionName: cstring): ptr glib.VariantType00 {.
    importc: "g_action_group_get_action_state_type", libprag.}

proc getActionStateType*(self: ActionGroup; actionName: string): glib.VariantType =
  new(result)
  result.impl = g_action_group_get_action_state_type(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc actionStateType*(self: ActionGroup; actionName: string): glib.VariantType =
  new(result)
  result.impl = g_action_group_get_action_state_type(cast[ptr ActionGroup00](self.impl), cstring(actionName))

proc g_action_group_has_action*(self: ptr ActionGroup00; actionName: cstring): gboolean {.
    importc: "g_action_group_has_action", libprag.}

proc hasAction*(self: ActionGroup; actionName: string): bool =
  toBool(g_action_group_has_action(cast[ptr ActionGroup00](self.impl), cstring(actionName)))

proc g_action_group_list_actions*(self: ptr ActionGroup00): cstringArray {.
    importc: "g_action_group_list_actions", libprag.}

proc listActions*(self: ActionGroup): cstringArray =
  g_action_group_list_actions(cast[ptr ActionGroup00](self.impl))

proc g_action_group_query_action*(self: ptr ActionGroup00; actionName: cstring; enabled: var gboolean; 
    parameterType: var ptr glib.VariantType00; stateType: var ptr glib.VariantType00; 
    stateHint: var ptr glib.Variant00; state: var ptr glib.Variant00): gboolean {.
    importc: "g_action_group_query_action", libprag.}

proc queryAction*(self: ptr ActionGroup00; actionName: cstring; enabled: var gboolean; 
    parameterType: var ptr glib.VariantType00; stateType: var ptr glib.VariantType00; 
    stateHint: var ptr glib.Variant00; state: var ptr glib.Variant00): gboolean {.
    importc: "g_action_group_query_action", libprag.}

type
  ActionGroupInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    hasAction*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): gboolean {.cdecl.}
    listActions*: proc(actionGroup: ptr ActionGroup00): cstringArray {.cdecl.}
    getActionEnabled*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): gboolean {.cdecl.}
    getActionParameterType*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): ptr glib.VariantType00 {.cdecl.}
    getActionStateType*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): ptr glib.VariantType00 {.cdecl.}
    getActionStateHint*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): ptr glib.Variant00 {.cdecl.}
    getActionState*: proc(actionGroup: ptr ActionGroup00; actionName: cstring): ptr glib.Variant00 {.cdecl.}
    changeActionState*: proc(actionGroup: ptr ActionGroup00; actionName: cstring; 
    value: ptr glib.Variant00) {.cdecl.}
    activateAction*: proc(actionGroup: ptr ActionGroup00; actionName: cstring; 
    parameter: ptr glib.Variant00) {.cdecl.}
    actionAdded*: proc(actionGroup: ptr ActionGroup00; actionName: cstring) {.cdecl.}
    actionRemoved*: proc(actionGroup: ptr ActionGroup00; actionName: cstring) {.cdecl.}
    actionEnabledChanged*: proc(actionGroup: ptr ActionGroup00; actionName: cstring; 
    enabled: gboolean) {.cdecl.}
    actionStateChanged*: proc(actionGroup: ptr ActionGroup00; actionName: cstring; 
    state: ptr glib.Variant00) {.cdecl.}
    queryAction*: proc(actionGroup: ptr ActionGroup00; actionName: cstring; 
    enabled: var gboolean; parameterType: var ptr glib.VariantType00; stateType: var ptr glib.VariantType00; 
    stateHint: var ptr glib.Variant00; state: var ptr glib.Variant00): gboolean {.cdecl.}
  ActionGroupInterface* = ref object
    impl*: ptr ActionGroupInterface00

type
  ActionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    getName*: proc(action: ptr Action00): cstring {.cdecl.}
    getParameterType*: proc(action: ptr Action00): ptr glib.VariantType00 {.cdecl.}
    getStateType*: proc(action: ptr Action00): ptr glib.VariantType00 {.cdecl.}
    getStateHint*: proc(action: ptr Action00): ptr glib.Variant00 {.cdecl.}
    getEnabled*: proc(action: ptr Action00): gboolean {.cdecl.}
    getState*: proc(action: ptr Action00): ptr glib.Variant00 {.cdecl.}
    changeState*: proc(action: ptr Action00; value: ptr glib.Variant00) {.cdecl.}
    activate*: proc(action: ptr Action00; parameter: ptr glib.Variant00) {.cdecl.}
  ActionInterface* = ref object
    impl*: ptr ActionInterface00

type
  ActionMap00* {.pure.} = object
  ActionMap* = ref object
    impl*: ptr ActionMap00

proc g_action_map_add_action*(self: ptr ActionMap00; action: ptr Action00) {.
    importc: "g_action_map_add_action", libprag.}

proc addAction*(self: ActionMap; action: Action) =
  g_action_map_add_action(cast[ptr ActionMap00](self.impl), cast[ptr Action00](action.impl))

proc g_action_map_add_action_entries*(self: ptr ActionMap00; entries: ActionEntry00Array; 
    nEntries: int32; userData: pointer) {.
    importc: "g_action_map_add_action_entries", libprag.}

proc addActionEntries*(self: ActionMap; entries: ActionEntry00Array; nEntries: int; 
    userData: pointer) =
  g_action_map_add_action_entries(cast[ptr ActionMap00](self.impl), entries, int32(nEntries), userData)

proc g_action_map_lookup_action*(self: ptr ActionMap00; actionName: cstring): ptr Action00 {.
    importc: "g_action_map_lookup_action", libprag.}

proc lookupAction*(self: ActionMap; actionName: string): Action =
  new(result)
  result.impl = g_action_map_lookup_action(cast[ptr ActionMap00](self.impl), cstring(actionName))

proc g_action_map_remove_action*(self: ptr ActionMap00; actionName: cstring) {.
    importc: "g_action_map_remove_action", libprag.}

proc removeAction*(self: ActionMap; actionName: string) =
  g_action_map_remove_action(cast[ptr ActionMap00](self.impl), cstring(actionName))

type
  ActionMapInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    lookupAction*: proc(actionMap: ptr ActionMap00; actionName: cstring): ptr Action00 {.cdecl.}
    addAction*: proc(actionMap: ptr ActionMap00; action: ptr Action00) {.cdecl.}
    removeAction*: proc(actionMap: ptr ActionMap00; actionName: cstring) {.cdecl.}
  ActionMapInterface* = ref object
    impl*: ptr ActionMapInterface00

type
  AppInfo00* {.pure.} = object
  AppInfo* = ref object
    impl*: ptr AppInfo00

proc g_app_info_get_all*(): ptr pointer {.
    importc: "g_app_info_get_all", libprag.}

proc getAll*(): ptr pointer {.
    importc: "g_app_info_get_all", libprag.}

proc all*(): ptr pointer {.
    importc: "g_app_info_get_all", libprag.}

proc g_app_info_get_all_for_type*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_all_for_type", libprag.}

proc getAllForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_all_for_type", libprag.}

proc allForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_all_for_type", libprag.}

proc g_app_info_get_default_for_type*(contentType: cstring; mustSupportUris: gboolean): ptr AppInfo00 {.
    importc: "g_app_info_get_default_for_type", libprag.}

proc getDefaultForType*(contentType: string; mustSupportUris: bool): AppInfo =
  new(result)
  result.impl = g_app_info_get_default_for_type(cstring(contentType), gboolean(mustSupportUris))

proc defaultForType*(contentType: string; mustSupportUris: bool): AppInfo =
  new(result)
  result.impl = g_app_info_get_default_for_type(cstring(contentType), gboolean(mustSupportUris))

proc g_app_info_get_default_for_uri_scheme*(uriScheme: cstring): ptr AppInfo00 {.
    importc: "g_app_info_get_default_for_uri_scheme", libprag.}

proc getDefaultForUriScheme*(uriScheme: string): AppInfo =
  new(result)
  result.impl = g_app_info_get_default_for_uri_scheme(cstring(uriScheme))

proc defaultForUriScheme*(uriScheme: string): AppInfo =
  new(result)
  result.impl = g_app_info_get_default_for_uri_scheme(cstring(uriScheme))

proc g_app_info_get_fallback_for_type*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_fallback_for_type", libprag.}

proc getFallbackForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_fallback_for_type", libprag.}

proc fallbackForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_fallback_for_type", libprag.}

proc g_app_info_get_recommended_for_type*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_recommended_for_type", libprag.}

proc getRecommendedForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_recommended_for_type", libprag.}

proc recommendedForType*(contentType: cstring): ptr pointer {.
    importc: "g_app_info_get_recommended_for_type", libprag.}

proc g_app_info_reset_type_associations*(contentType: cstring) {.
    importc: "g_app_info_reset_type_associations", libprag.}

proc resetTypeAssociations*(contentType: cstring) {.
    importc: "g_app_info_reset_type_associations", libprag.}

proc g_app_info_add_supports_type*(self: ptr AppInfo00; contentType: cstring): gboolean {.
    importc: "g_app_info_add_supports_type", libprag.}

proc addSupportsType*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_add_supports_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc g_app_info_can_delete*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_can_delete", libprag.}

proc canDelete*(self: AppInfo): bool =
  toBool(g_app_info_can_delete(cast[ptr AppInfo00](self.impl)))

proc g_app_info_can_remove_supports_type*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_can_remove_supports_type", libprag.}

proc canRemoveSupportsType*(self: AppInfo): bool =
  toBool(g_app_info_can_remove_supports_type(cast[ptr AppInfo00](self.impl)))

proc g_app_info_delete*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_delete", libprag.}

proc delete*(self: AppInfo): bool =
  toBool(g_app_info_delete(cast[ptr AppInfo00](self.impl)))

proc g_app_info_dup*(self: ptr AppInfo00): ptr AppInfo00 {.
    importc: "g_app_info_dup", libprag.}

proc dup*(self: AppInfo): AppInfo =
  new(result)
  result.impl = g_app_info_dup(cast[ptr AppInfo00](self.impl))

proc g_app_info_equal*(self: ptr AppInfo00; appinfo2: ptr AppInfo00): gboolean {.
    importc: "g_app_info_equal", libprag.}

proc equal*(self: AppInfo; appinfo2: AppInfo): bool =
  toBool(g_app_info_equal(cast[ptr AppInfo00](self.impl), cast[ptr AppInfo00](appinfo2.impl)))

proc g_app_info_get_commandline*(self: ptr AppInfo00): ucstring {.
    importc: "g_app_info_get_commandline", libprag.}

proc getCommandline*(self: AppInfo): ucstring =
  g_app_info_get_commandline(cast[ptr AppInfo00](self.impl))

proc commandline*(self: AppInfo): ucstring =
  g_app_info_get_commandline(cast[ptr AppInfo00](self.impl))

proc g_app_info_get_description*(self: ptr AppInfo00): cstring {.
    importc: "g_app_info_get_description", libprag.}

proc getDescription*(self: AppInfo): string =
  let resul0 = g_app_info_get_description(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc description*(self: AppInfo): string =
  let resul0 = g_app_info_get_description(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc g_app_info_get_display_name*(self: ptr AppInfo00): cstring {.
    importc: "g_app_info_get_display_name", libprag.}

proc getDisplayName*(self: AppInfo): string =
  let resul0 = g_app_info_get_display_name(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc displayName*(self: AppInfo): string =
  let resul0 = g_app_info_get_display_name(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc g_app_info_get_executable*(self: ptr AppInfo00): ucstring {.
    importc: "g_app_info_get_executable", libprag.}

proc getExecutable*(self: AppInfo): ucstring =
  g_app_info_get_executable(cast[ptr AppInfo00](self.impl))

proc executable*(self: AppInfo): ucstring =
  g_app_info_get_executable(cast[ptr AppInfo00](self.impl))

proc g_app_info_get_id*(self: ptr AppInfo00): cstring {.
    importc: "g_app_info_get_id", libprag.}

proc getId*(self: AppInfo): string =
  let resul0 = g_app_info_get_id(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc id*(self: AppInfo): string =
  let resul0 = g_app_info_get_id(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc g_app_info_get_name*(self: ptr AppInfo00): cstring {.
    importc: "g_app_info_get_name", libprag.}

proc getName*(self: AppInfo): string =
  let resul0 = g_app_info_get_name(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc name*(self: AppInfo): string =
  let resul0 = g_app_info_get_name(cast[ptr AppInfo00](self.impl))
  result = $resul0

proc g_app_info_get_supported_types*(self: ptr AppInfo00): cstringArray {.
    importc: "g_app_info_get_supported_types", libprag.}

proc getSupportedTypes*(self: AppInfo): cstringArray =
  g_app_info_get_supported_types(cast[ptr AppInfo00](self.impl))

proc supportedTypes*(self: AppInfo): cstringArray =
  g_app_info_get_supported_types(cast[ptr AppInfo00](self.impl))

proc g_app_info_remove_supports_type*(self: ptr AppInfo00; contentType: cstring): gboolean {.
    importc: "g_app_info_remove_supports_type", libprag.}

proc removeSupportsType*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_remove_supports_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc g_app_info_set_as_default_for_extension*(self: ptr AppInfo00; extension: ucstring): gboolean {.
    importc: "g_app_info_set_as_default_for_extension", libprag.}

proc setAsDefaultForExtension*(self: AppInfo; extension: ucstring): bool =
  toBool(g_app_info_set_as_default_for_extension(cast[ptr AppInfo00](self.impl), extension))

proc `asDefaultForExtension=`*(self: AppInfo; extension: ucstring): bool =
  toBool(g_app_info_set_as_default_for_extension(cast[ptr AppInfo00](self.impl), extension))

proc g_app_info_set_as_default_for_type*(self: ptr AppInfo00; contentType: cstring): gboolean {.
    importc: "g_app_info_set_as_default_for_type", libprag.}

proc setAsDefaultForType*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_set_as_default_for_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc `asDefaultForType=`*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_set_as_default_for_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc g_app_info_set_as_last_used_for_type*(self: ptr AppInfo00; contentType: cstring): gboolean {.
    importc: "g_app_info_set_as_last_used_for_type", libprag.}

proc setAsLastUsedForType*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_set_as_last_used_for_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc `asLastUsedForType=`*(self: AppInfo; contentType: string): bool =
  toBool(g_app_info_set_as_last_used_for_type(cast[ptr AppInfo00](self.impl), cstring(contentType)))

proc g_app_info_should_show*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_should_show", libprag.}

proc shouldShow*(self: AppInfo): bool =
  toBool(g_app_info_should_show(cast[ptr AppInfo00](self.impl)))

proc g_app_info_supports_files*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_supports_files", libprag.}

proc supportsFiles*(self: AppInfo): bool =
  toBool(g_app_info_supports_files(cast[ptr AppInfo00](self.impl)))

proc g_app_info_supports_uris*(self: ptr AppInfo00): gboolean {.
    importc: "g_app_info_supports_uris", libprag.}

proc supportsUris*(self: AppInfo): bool =
  toBool(g_app_info_supports_uris(cast[ptr AppInfo00](self.impl)))

type
  AppInfoCreateFlag* {.size: sizeof(cint), pure.} = enum
    needsTerminal = 1
    supportsUris = 2
    supportsStartupNotification = 3

  AppInfoCreateFlags* {.size: sizeof(cint).} = set[AppInfoCreateFlag]

proc g_app_info_create_from_commandline*(commandline: cstring; applicationName: cstring; flags: AppInfoCreateFlags): ptr AppInfo00 {.
    importc: "g_app_info_create_from_commandline", libprag.}

proc createFromCommandline*(commandline: string; applicationName: string; flags: AppInfoCreateFlags): AppInfo =
  new(result)
  result.impl = g_app_info_create_from_commandline(cstring(commandline), cstring(applicationName), flags)

type
  AsyncResult00* {.pure.} = object
  AsyncResult* = ref object
    impl*: ptr AsyncResult00

proc g_async_result_get_source_object*(self: ptr AsyncResult00): ptr gobject.Object00 {.
    importc: "g_async_result_get_source_object", libprag.}

proc getSourceObject*(self: AsyncResult): gobject.Object =
  let gobj = g_async_result_get_source_object(cast[ptr AsyncResult00](self.impl))
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

proc sourceObject*(self: AsyncResult): gobject.Object =
  let gobj = g_async_result_get_source_object(cast[ptr AsyncResult00](self.impl))
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

proc g_async_result_get_user_data*(self: ptr AsyncResult00): pointer {.
    importc: "g_async_result_get_user_data", libprag.}

proc getUserData*(self: AsyncResult): pointer =
  g_async_result_get_user_data(cast[ptr AsyncResult00](self.impl))

proc userData*(self: AsyncResult): pointer =
  g_async_result_get_user_data(cast[ptr AsyncResult00](self.impl))

proc g_async_result_is_tagged*(self: ptr AsyncResult00; sourceTag: pointer): gboolean {.
    importc: "g_async_result_is_tagged", libprag.}

proc isTagged*(self: AsyncResult; sourceTag: pointer): bool =
  toBool(g_async_result_is_tagged(cast[ptr AsyncResult00](self.impl), sourceTag))

proc g_async_result_legacy_propagate_error*(self: ptr AsyncResult00): gboolean {.
    importc: "g_async_result_legacy_propagate_error", libprag.}

proc legacyPropagateError*(self: AsyncResult): bool =
  toBool(g_async_result_legacy_propagate_error(cast[ptr AsyncResult00](self.impl)))

proc g_app_info_launch_default_for_uri_finish*(resu: ptr AsyncResult00): gboolean {.
    importc: "g_app_info_launch_default_for_uri_finish", libprag.}

proc launchDefaultForUriFinish*(resu: AsyncResult): bool =
  toBool(g_app_info_launch_default_for_uri_finish(cast[ptr AsyncResult00](resu.impl)))

type
  Icon00* {.pure.} = object
  Icon* = ref object
    impl*: ptr Icon00

proc g_icon_deserialize*(value: ptr glib.Variant00): ptr Icon00 {.
    importc: "g_icon_deserialize", libprag.}

proc deserialize*(value: glib.Variant): Icon =
  new(result)
  result.impl = g_icon_deserialize(cast[ptr glib.Variant00](value.impl))

proc g_icon_hash*(icon: pointer): uint32 {.
    importc: "g_icon_hash", libprag.}

proc hash*(icon: pointer): uint32 {.
    importc: "g_icon_hash", libprag.}

proc g_icon_new_for_string*(str: cstring): ptr Icon00 {.
    importc: "g_icon_new_for_string", libprag.}

proc newIconForString*(str: string): Icon =
  new(result)
  result.impl = g_icon_new_for_string(cstring(str))

proc g_icon_equal*(self: ptr Icon00; icon2: ptr Icon00): gboolean {.
    importc: "g_icon_equal", libprag.}

proc equal*(self: Icon; icon2: Icon): bool =
  toBool(g_icon_equal(cast[ptr Icon00](self.impl), cast[ptr Icon00](icon2.impl)))

proc g_icon_serialize*(self: ptr Icon00): ptr glib.Variant00 {.
    importc: "g_icon_serialize", libprag.}

proc serialize*(self: Icon): glib.Variant =
  new(result)
  result.impl = g_icon_serialize(cast[ptr Icon00](self.impl))

proc g_icon_to_string*(self: ptr Icon00): cstring {.
    importc: "g_icon_to_string", libprag.}

proc toString*(self: Icon): string =
  let resul0 = g_icon_to_string(cast[ptr Icon00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_app_info_get_icon*(self: ptr AppInfo00): ptr Icon00 {.
    importc: "g_app_info_get_icon", libprag.}

proc getIcon*(self: AppInfo): Icon =
  new(result)
  result.impl = g_app_info_get_icon(cast[ptr AppInfo00](self.impl))

proc icon*(self: AppInfo): Icon =
  new(result)
  result.impl = g_app_info_get_icon(cast[ptr AppInfo00](self.impl))

type
  AppLaunchContextPrivate00* {.pure.} = object
  AppLaunchContextPrivate* = ref object
    impl*: ptr AppLaunchContextPrivate00

type
  AppLaunchContext* = ref object of gobject.Object
  AppLaunchContext00* = object of gobject.Object00
    priv1: ptr AppLaunchContextPrivate00

proc scLaunchFailed*(self: AppLaunchContext;  p: proc (self: ptr gobject.Object00; startupNotifyId: cstring; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "launch-failed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scLaunched*(self: AppLaunchContext;  p: proc (self: ptr gobject.Object00; info: AppInfo00; platformData: glib.Variant00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "launched", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_app_launch_context_new*(): ptr AppLaunchContext00 {.
    importc: "g_app_launch_context_new", libprag.}

proc newAppLaunchContext*(): AppLaunchContext =
  new(result, finalizeGObject)
  result.impl = g_app_launch_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initAppLaunchContext*[T](result: var T) =
  assert(result is AppLaunchContext)
  new(result, finalizeGObject)
  result.impl = g_app_launch_context_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_app_launch_context_get_display*(self: ptr AppLaunchContext00; info: ptr AppInfo00; 
    files: ptr pointer): cstring {.
    importc: "g_app_launch_context_get_display", libprag.}

proc getDisplay*(self: AppLaunchContext; info: AppInfo; files: ptr pointer): string =
  let resul0 = g_app_launch_context_get_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr AppInfo00](info.impl), files)
  result = $resul0
  cogfree(resul0)

proc display*(self: AppLaunchContext; info: AppInfo; files: ptr pointer): string =
  let resul0 = g_app_launch_context_get_display(cast[ptr AppLaunchContext00](self.impl), cast[ptr AppInfo00](info.impl), files)
  result = $resul0
  cogfree(resul0)

proc g_app_launch_context_get_environment*(self: ptr AppLaunchContext00): cstringArray {.
    importc: "g_app_launch_context_get_environment", libprag.}

proc getEnvironment*(self: AppLaunchContext): cstringArray =
  g_app_launch_context_get_environment(cast[ptr AppLaunchContext00](self.impl))

proc environment*(self: AppLaunchContext): cstringArray =
  g_app_launch_context_get_environment(cast[ptr AppLaunchContext00](self.impl))

proc g_app_launch_context_get_startup_notify_id*(self: ptr AppLaunchContext00; info: ptr AppInfo00; 
    files: ptr pointer): cstring {.
    importc: "g_app_launch_context_get_startup_notify_id", libprag.}

proc getStartupNotifyId*(self: AppLaunchContext; info: AppInfo; files: ptr pointer): string =
  let resul0 = g_app_launch_context_get_startup_notify_id(cast[ptr AppLaunchContext00](self.impl), cast[ptr AppInfo00](info.impl), files)
  result = $resul0
  cogfree(resul0)

proc startupNotifyId*(self: AppLaunchContext; info: AppInfo; files: ptr pointer): string =
  let resul0 = g_app_launch_context_get_startup_notify_id(cast[ptr AppLaunchContext00](self.impl), cast[ptr AppInfo00](info.impl), files)
  result = $resul0
  cogfree(resul0)

proc g_app_launch_context_launch_failed*(self: ptr AppLaunchContext00; startupNotifyId: cstring) {.
    importc: "g_app_launch_context_launch_failed", libprag.}

proc launchFailed*(self: AppLaunchContext; startupNotifyId: string) =
  g_app_launch_context_launch_failed(cast[ptr AppLaunchContext00](self.impl), cstring(startupNotifyId))

proc g_app_launch_context_setenv*(self: ptr AppLaunchContext00; variable: cstring; value: cstring) {.
    importc: "g_app_launch_context_setenv", libprag.}

proc setenv*(self: AppLaunchContext; variable: string; value: string) =
  g_app_launch_context_setenv(cast[ptr AppLaunchContext00](self.impl), cstring(variable), cstring(value))

proc g_app_launch_context_unsetenv*(self: ptr AppLaunchContext00; variable: cstring) {.
    importc: "g_app_launch_context_unsetenv", libprag.}

proc unsetenv*(self: AppLaunchContext; variable: string) =
  g_app_launch_context_unsetenv(cast[ptr AppLaunchContext00](self.impl), cstring(variable))

proc g_app_info_launch_default_for_uri*(uri: cstring; launchContext: ptr AppLaunchContext00): gboolean {.
    importc: "g_app_info_launch_default_for_uri", libprag.}

proc launchDefaultForUri*(uri: string; launchContext: AppLaunchContext): bool =
  toBool(g_app_info_launch_default_for_uri(cstring(uri), cast[ptr AppLaunchContext00](launchContext.impl)))

proc g_app_info_launch*(self: ptr AppInfo00; files: ptr pointer; launchContext: ptr AppLaunchContext00): gboolean {.
    importc: "g_app_info_launch", libprag.}

proc launch*(self: AppInfo; files: ptr pointer; launchContext: AppLaunchContext): bool =
  toBool(g_app_info_launch(cast[ptr AppInfo00](self.impl), files, cast[ptr AppLaunchContext00](launchContext.impl)))

proc g_app_info_launch_uris*(self: ptr AppInfo00; uris: ptr pointer; launchContext: ptr AppLaunchContext00): gboolean {.
    importc: "g_app_info_launch_uris", libprag.}

proc launchUris*(self: AppInfo; uris: ptr pointer; launchContext: AppLaunchContext): bool =
  toBool(g_app_info_launch_uris(cast[ptr AppInfo00](self.impl), uris, cast[ptr AppLaunchContext00](launchContext.impl)))

type
  CancellablePrivate00* {.pure.} = object
  CancellablePrivate* = ref object
    impl*: ptr CancellablePrivate00

type
  Cancellable* = ref object of gobject.Object
  Cancellable00* = object of gobject.Object00
    priv1: ptr CancellablePrivate00

proc scCancelled*(self: Cancellable;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "cancelled", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_cancellable_new*(): ptr Cancellable00 {.
    importc: "g_cancellable_new", libprag.}

proc newCancellable*(): Cancellable =
  new(result, finalizeGObject)
  result.impl = g_cancellable_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCancellable*[T](result: var T) =
  assert(result is Cancellable)
  new(result, finalizeGObject)
  result.impl = g_cancellable_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_cancellable_get_current*(): ptr Cancellable00 {.
    importc: "g_cancellable_get_current", libprag.}

proc getCurrent*(): Cancellable =
  let gobj = g_cancellable_get_current()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cancellable](g_object_get_qdata(gobj, Quark))
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

proc current*(): Cancellable =
  let gobj = g_cancellable_get_current()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cancellable](g_object_get_qdata(gobj, Quark))
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

proc g_cancellable_cancel*(self: ptr Cancellable00) {.
    importc: "g_cancellable_cancel", libprag.}

proc cancel*(self: Cancellable) =
  g_cancellable_cancel(cast[ptr Cancellable00](self.impl))

proc g_cancellable_connect*(self: ptr Cancellable00; callback: Callback; data: pointer; 
    dataDestroyFunc: DestroyNotify): uint64 {.
    importc: "g_cancellable_connect", libprag.}

proc connect*(self: Cancellable; callback: Callback; data: pointer; 
    dataDestroyFunc: DestroyNotify): uint64 =
  g_cancellable_connect(cast[ptr Cancellable00](self.impl), callback, data, dataDestroyFunc)

proc g_cancellable_disconnect*(self: ptr Cancellable00; handlerId: uint64) {.
    importc: "g_cancellable_disconnect", libprag.}

proc disconnect*(self: Cancellable; handlerId: uint64) =
  g_cancellable_disconnect(cast[ptr Cancellable00](self.impl), handlerId)

proc g_cancellable_get_fd*(self: ptr Cancellable00): int32 {.
    importc: "g_cancellable_get_fd", libprag.}

proc getFd*(self: Cancellable): int =
  int(g_cancellable_get_fd(cast[ptr Cancellable00](self.impl)))

proc fd*(self: Cancellable): int =
  int(g_cancellable_get_fd(cast[ptr Cancellable00](self.impl)))

proc g_cancellable_is_cancelled*(self: ptr Cancellable00): gboolean {.
    importc: "g_cancellable_is_cancelled", libprag.}

proc isCancelled*(self: Cancellable): bool =
  toBool(g_cancellable_is_cancelled(cast[ptr Cancellable00](self.impl)))

proc g_cancellable_make_pollfd*(self: ptr Cancellable00; pollfd: ptr glib.PollFD00): gboolean {.
    importc: "g_cancellable_make_pollfd", libprag.}

proc makePollfd*(self: Cancellable; pollfd: glib.PollFD): bool =
  toBool(g_cancellable_make_pollfd(cast[ptr Cancellable00](self.impl), cast[ptr glib.PollFD00](pollfd.impl)))

proc g_cancellable_pop_current*(self: ptr Cancellable00) {.
    importc: "g_cancellable_pop_current", libprag.}

proc popCurrent*(self: Cancellable) =
  g_cancellable_pop_current(cast[ptr Cancellable00](self.impl))

proc g_cancellable_push_current*(self: ptr Cancellable00) {.
    importc: "g_cancellable_push_current", libprag.}

proc pushCurrent*(self: Cancellable) =
  g_cancellable_push_current(cast[ptr Cancellable00](self.impl))

proc g_cancellable_release_fd*(self: ptr Cancellable00) {.
    importc: "g_cancellable_release_fd", libprag.}

proc releaseFd*(self: Cancellable) =
  g_cancellable_release_fd(cast[ptr Cancellable00](self.impl))

proc g_cancellable_reset*(self: ptr Cancellable00) {.
    importc: "g_cancellable_reset", libprag.}

proc reset*(self: Cancellable) =
  g_cancellable_reset(cast[ptr Cancellable00](self.impl))

proc g_cancellable_set_error_if_cancelled*(self: ptr Cancellable00): gboolean {.
    importc: "g_cancellable_set_error_if_cancelled", libprag.}

proc setErrorIfCancelled*(self: Cancellable): bool =
  toBool(g_cancellable_set_error_if_cancelled(cast[ptr Cancellable00](self.impl)))

proc `errorIfCancelled=`*(self: Cancellable): bool =
  toBool(g_cancellable_set_error_if_cancelled(cast[ptr Cancellable00](self.impl)))

type
  AppInfoIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    dup*: proc(appinfo: ptr AppInfo00): ptr AppInfo00 {.cdecl.}
    equal*: proc(appinfo1: ptr AppInfo00; appinfo2: ptr AppInfo00): gboolean {.cdecl.}
    getId*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    getName*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    getDescription*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    getExecutable*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    getIcon*: proc(appinfo: ptr AppInfo00): ptr Icon00 {.cdecl.}
    launch*: proc(appinfo: ptr AppInfo00; files: ptr pointer; launchContext: ptr AppLaunchContext00): gboolean {.cdecl.}
    supportsUris*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    supportsFiles*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    launchUris*: proc(appinfo: ptr AppInfo00; uris: ptr pointer; launchContext: ptr AppLaunchContext00): gboolean {.cdecl.}
    shouldShow*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    setAsDefaultForType*: proc(appinfo: ptr AppInfo00; contentType: cstring): gboolean {.cdecl.}
    setAsDefaultForExtension*: proc(appinfo: ptr AppInfo00; extension: ucstring): gboolean {.cdecl.}
    addSupportsType*: proc(appinfo: ptr AppInfo00; contentType: cstring): gboolean {.cdecl.}
    canRemoveSupportsType*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    removeSupportsType*: proc(appinfo: ptr AppInfo00; contentType: cstring): gboolean {.cdecl.}
    canDelete*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    doDelete*: proc(appinfo: ptr AppInfo00): gboolean {.cdecl.}
    getCommandline*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    getDisplayName*: proc(appinfo: ptr AppInfo00): cstring {.cdecl.}
    setAsLastUsedForType*: proc(appinfo: ptr AppInfo00; contentType: cstring): gboolean {.cdecl.}
    getSupportedTypes*: proc(appinfo: ptr AppInfo00): cstringArray {.cdecl.}
  AppInfoIface* = ref object
    impl*: ptr AppInfoIface00

type
  AppInfoMonitor* = ref object of gobject.Object
  AppInfoMonitor00* = object of gobject.Object00

proc scChanged*(self: AppInfoMonitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_app_info_monitor_get*(): ptr AppInfoMonitor00 {.
    importc: "g_app_info_monitor_get", libprag.}

proc get*(): AppInfoMonitor =
  let gobj = g_app_info_monitor_get()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[AppInfoMonitor](g_object_get_qdata(gobj, Quark))
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
  AppLaunchContextClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getDisplay*: proc(context: ptr AppLaunchContext00; info: ptr AppInfo00; 
    files: ptr pointer): cstring {.cdecl.}
    getStartupNotifyId*: proc(context: ptr AppLaunchContext00; info: ptr AppInfo00; 
    files: ptr pointer): cstring {.cdecl.}
    launchFailed*: proc(context: ptr AppLaunchContext00; startupNotifyId: cstring) {.cdecl.}
    launched*: proc(context: ptr AppLaunchContext00; info: ptr AppInfo00; 
    platformData: ptr glib.Variant00) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
  AppLaunchContextClass* = ref object
    impl*: ptr AppLaunchContextClass00

type
  ApplicationPrivate00* {.pure.} = object
  ApplicationPrivate* = ref object
    impl*: ptr ApplicationPrivate00

type
  ApplicationCommandLinePrivate00* {.pure.} = object
  ApplicationCommandLinePrivate* = ref object
    impl*: ptr ApplicationCommandLinePrivate00

type
  ApplicationCommandLine* = ref object of gobject.Object
  ApplicationCommandLine00* = object of gobject.Object00
    priv1: ptr ApplicationCommandLinePrivate00

proc g_application_command_line_get_arguments*(self: ptr ApplicationCommandLine00; argc: var int32): cstringArray {.
    importc: "g_application_command_line_get_arguments", libprag.}

proc getArguments*(self: ApplicationCommandLine; argc: var int): cstringArray =
  var argc_00 = int32(argc)
  result = g_application_command_line_get_arguments(cast[ptr ApplicationCommandLine00](self.impl), argc_00)
  argc = int(argc_00)

proc arguments*(self: ApplicationCommandLine; argc: var int): cstringArray =
  var argc_00 = int32(argc)
  result = g_application_command_line_get_arguments(cast[ptr ApplicationCommandLine00](self.impl), argc_00)
  argc = int(argc_00)

proc g_application_command_line_get_cwd*(self: ptr ApplicationCommandLine00): ucstring {.
    importc: "g_application_command_line_get_cwd", libprag.}

proc getCwd*(self: ApplicationCommandLine): ucstring =
  g_application_command_line_get_cwd(cast[ptr ApplicationCommandLine00](self.impl))

proc cwd*(self: ApplicationCommandLine): ucstring =
  g_application_command_line_get_cwd(cast[ptr ApplicationCommandLine00](self.impl))

proc g_application_command_line_get_environ*(self: ptr ApplicationCommandLine00): cstringArray {.
    importc: "g_application_command_line_get_environ", libprag.}

proc getEnviron*(self: ApplicationCommandLine): cstringArray =
  g_application_command_line_get_environ(cast[ptr ApplicationCommandLine00](self.impl))

proc environ*(self: ApplicationCommandLine): cstringArray =
  g_application_command_line_get_environ(cast[ptr ApplicationCommandLine00](self.impl))

proc g_application_command_line_get_exit_status*(self: ptr ApplicationCommandLine00): int32 {.
    importc: "g_application_command_line_get_exit_status", libprag.}

proc getExitStatus*(self: ApplicationCommandLine): int =
  int(g_application_command_line_get_exit_status(cast[ptr ApplicationCommandLine00](self.impl)))

proc exitStatus*(self: ApplicationCommandLine): int =
  int(g_application_command_line_get_exit_status(cast[ptr ApplicationCommandLine00](self.impl)))

proc g_application_command_line_get_is_remote*(self: ptr ApplicationCommandLine00): gboolean {.
    importc: "g_application_command_line_get_is_remote", libprag.}

proc getIsRemote*(self: ApplicationCommandLine): bool =
  toBool(g_application_command_line_get_is_remote(cast[ptr ApplicationCommandLine00](self.impl)))

proc isRemote*(self: ApplicationCommandLine): bool =
  toBool(g_application_command_line_get_is_remote(cast[ptr ApplicationCommandLine00](self.impl)))

proc g_application_command_line_get_options_dict*(self: ptr ApplicationCommandLine00): ptr glib.VariantDict00 {.
    importc: "g_application_command_line_get_options_dict", libprag.}

proc getOptionsDict*(self: ApplicationCommandLine): glib.VariantDict =
  new(result)
  result.impl = g_application_command_line_get_options_dict(cast[ptr ApplicationCommandLine00](self.impl))

proc optionsDict*(self: ApplicationCommandLine): glib.VariantDict =
  new(result)
  result.impl = g_application_command_line_get_options_dict(cast[ptr ApplicationCommandLine00](self.impl))

proc g_application_command_line_get_platform_data*(self: ptr ApplicationCommandLine00): ptr glib.Variant00 {.
    importc: "g_application_command_line_get_platform_data", libprag.}

proc getPlatformData*(self: ApplicationCommandLine): glib.Variant =
  new(result)
  result.impl = g_application_command_line_get_platform_data(cast[ptr ApplicationCommandLine00](self.impl))

proc platformData*(self: ApplicationCommandLine): glib.Variant =
  new(result)
  result.impl = g_application_command_line_get_platform_data(cast[ptr ApplicationCommandLine00](self.impl))

proc g_application_command_line_getenv*(self: ptr ApplicationCommandLine00; name: cstring): cstring {.
    importc: "g_application_command_line_getenv", libprag.}

proc getenv*(self: ApplicationCommandLine; name: string): string =
  let resul0 = g_application_command_line_getenv(cast[ptr ApplicationCommandLine00](self.impl), cstring(name))
  result = $resul0

proc env*(self: ApplicationCommandLine; name: string): string =
  let resul0 = g_application_command_line_getenv(cast[ptr ApplicationCommandLine00](self.impl), cstring(name))
  result = $resul0

proc g_application_command_line_set_exit_status*(self: ptr ApplicationCommandLine00; exitStatus: int32) {.
    importc: "g_application_command_line_set_exit_status", libprag.}

proc setExitStatus*(self: ApplicationCommandLine; exitStatus: int) =
  g_application_command_line_set_exit_status(cast[ptr ApplicationCommandLine00](self.impl), int32(exitStatus))

proc `exitStatus=`*(self: ApplicationCommandLine; exitStatus: int) =
  g_application_command_line_set_exit_status(cast[ptr ApplicationCommandLine00](self.impl), int32(exitStatus))

type
  File00* {.pure.} = object
  File* = ref object
    impl*: ptr File00

proc g_file_new_for_commandline_arg*(arg: cstring): ptr File00 {.
    importc: "g_file_new_for_commandline_arg", libprag.}

proc newFileForCommandlineArg*(arg: string): File =
  new(result)
  result.impl = g_file_new_for_commandline_arg(cstring(arg))

proc g_file_new_for_commandline_arg_and_cwd*(arg: cstring; cwd: ucstring): ptr File00 {.
    importc: "g_file_new_for_commandline_arg_and_cwd", libprag.}

proc newFileForCommandlineArgAndCwd*(arg: string; cwd: ucstring): File =
  new(result)
  result.impl = g_file_new_for_commandline_arg_and_cwd(cstring(arg), cwd)

proc g_file_new_for_path*(path: ucstring): ptr File00 {.
    importc: "g_file_new_for_path", libprag.}

proc newFileForPath*(path: ucstring): File =
  new(result)
  result.impl = g_file_new_for_path(path)

proc g_file_new_for_uri*(uri: cstring): ptr File00 {.
    importc: "g_file_new_for_uri", libprag.}

proc newFileForUri*(uri: string): File =
  new(result)
  result.impl = g_file_new_for_uri(cstring(uri))

proc g_file_parse_name*(parseName: cstring): ptr File00 {.
    importc: "g_file_parse_name", libprag.}

proc parseName*(parseName: string): File =
  new(result)
  result.impl = g_file_parse_name(cstring(parseName))

proc g_file_copy_finish*(self: ptr File00; res: ptr AsyncResult00): gboolean {.
    importc: "g_file_copy_finish", libprag.}

proc copyFinish*(self: File; res: AsyncResult): bool =
  toBool(g_file_copy_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl)))

proc g_file_delete*(self: ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_delete", libprag.}

proc delete*(self: File; cancellable: Cancellable): bool =
  toBool(g_file_delete(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_delete_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_delete_finish", libprag.}

proc deleteFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_delete_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_dup*(self: ptr File00): ptr File00 {.
    importc: "g_file_dup", libprag.}

proc dup*(self: File): File =
  new(result)
  result.impl = g_file_dup(cast[ptr File00](self.impl))

proc g_file_eject_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_eject_mountable_finish", libprag.}

proc ejectMountableFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_eject_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_eject_mountable_with_operation_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_eject_mountable_with_operation_finish", libprag.}

proc ejectMountableWithOperationFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_eject_mountable_with_operation_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_equal*(self: ptr File00; file2: ptr File00): gboolean {.
    importc: "g_file_equal", libprag.}

proc equal*(self: File; file2: File): bool =
  toBool(g_file_equal(cast[ptr File00](self.impl), cast[ptr File00](file2.impl)))

proc g_file_get_basename*(self: ptr File00): ucstring {.
    importc: "g_file_get_basename", libprag.}

proc getBasename*(self: File): ucstring =
  g_file_get_basename(cast[ptr File00](self.impl))

proc basename*(self: File): ucstring =
  g_file_get_basename(cast[ptr File00](self.impl))

proc g_file_get_child*(self: ptr File00; name: ucstring): ptr File00 {.
    importc: "g_file_get_child", libprag.}

proc getChild*(self: File; name: ucstring): File =
  new(result)
  result.impl = g_file_get_child(cast[ptr File00](self.impl), name)

proc child*(self: File; name: ucstring): File =
  new(result)
  result.impl = g_file_get_child(cast[ptr File00](self.impl), name)

proc g_file_get_child_for_display_name*(self: ptr File00; displayName: cstring): ptr File00 {.
    importc: "g_file_get_child_for_display_name", libprag.}

proc getChildForDisplayName*(self: File; displayName: string): File =
  new(result)
  result.impl = g_file_get_child_for_display_name(cast[ptr File00](self.impl), cstring(displayName))

proc childForDisplayName*(self: File; displayName: string): File =
  new(result)
  result.impl = g_file_get_child_for_display_name(cast[ptr File00](self.impl), cstring(displayName))

proc g_file_get_parent*(self: ptr File00): ptr File00 {.
    importc: "g_file_get_parent", libprag.}

proc getParent*(self: File): File =
  new(result)
  result.impl = g_file_get_parent(cast[ptr File00](self.impl))

proc parent*(self: File): File =
  new(result)
  result.impl = g_file_get_parent(cast[ptr File00](self.impl))

proc g_file_get_parse_name*(self: ptr File00): cstring {.
    importc: "g_file_get_parse_name", libprag.}

proc getParseName*(self: File): string =
  let resul0 = g_file_get_parse_name(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc parseName*(self: File): string =
  let resul0 = g_file_get_parse_name(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_get_path*(self: ptr File00): ucstring {.
    importc: "g_file_get_path", libprag.}

proc getPath*(self: File): ucstring =
  g_file_get_path(cast[ptr File00](self.impl))

proc path*(self: File): ucstring =
  g_file_get_path(cast[ptr File00](self.impl))

proc g_file_get_relative_path*(self: ptr File00; descendant: ptr File00): ucstring {.
    importc: "g_file_get_relative_path", libprag.}

proc getRelativePath*(self: File; descendant: File): ucstring =
  g_file_get_relative_path(cast[ptr File00](self.impl), cast[ptr File00](descendant.impl))

proc relativePath*(self: File; descendant: File): ucstring =
  g_file_get_relative_path(cast[ptr File00](self.impl), cast[ptr File00](descendant.impl))

proc g_file_get_uri*(self: ptr File00): cstring {.
    importc: "g_file_get_uri", libprag.}

proc getUri*(self: File): string =
  let resul0 = g_file_get_uri(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc uri*(self: File): string =
  let resul0 = g_file_get_uri(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_get_uri_scheme*(self: ptr File00): cstring {.
    importc: "g_file_get_uri_scheme", libprag.}

proc getUriScheme*(self: File): string =
  let resul0 = g_file_get_uri_scheme(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc uriScheme*(self: File): string =
  let resul0 = g_file_get_uri_scheme(cast[ptr File00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_has_parent*(self: ptr File00; parent: ptr File00): gboolean {.
    importc: "g_file_has_parent", libprag.}

proc hasParent*(self: File; parent: File): bool =
  toBool(g_file_has_parent(cast[ptr File00](self.impl), cast[ptr File00](parent.impl)))

proc g_file_has_prefix*(self: ptr File00; prefix: ptr File00): gboolean {.
    importc: "g_file_has_prefix", libprag.}

proc hasPrefix*(self: File; prefix: File): bool =
  toBool(g_file_has_prefix(cast[ptr File00](self.impl), cast[ptr File00](prefix.impl)))

proc g_file_has_uri_scheme*(self: ptr File00; uriScheme: cstring): gboolean {.
    importc: "g_file_has_uri_scheme", libprag.}

proc hasUriScheme*(self: File; uriScheme: string): bool =
  toBool(g_file_has_uri_scheme(cast[ptr File00](self.impl), cstring(uriScheme)))

proc g_file_hash*(self: ptr File00): uint32 {.
    importc: "g_file_hash", libprag.}

proc hash*(self: File): int =
  int(g_file_hash(cast[ptr File00](self.impl)))

proc g_file_is_native*(self: ptr File00): gboolean {.
    importc: "g_file_is_native", libprag.}

proc isNative*(self: File): bool =
  toBool(g_file_is_native(cast[ptr File00](self.impl)))

proc g_file_load_contents*(self: ptr File00; cancellable: ptr Cancellable00; 
    contents: var uint8Array; length: var uint64; etagOut: var cstring): gboolean {.
    importc: "g_file_load_contents", libprag.}

proc loadContents*(self: File; cancellable: Cancellable; contents: var uint8Array; 
    length: var uint64; etagOut: var string): bool =
  var etagOut_00 = cstring(etagOut)
  result = toBool(g_file_load_contents(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl), contents, length, etagOut_00))
  etagOut = $(etagOut_00)

proc g_file_load_contents_finish*(self: ptr File00; res: ptr AsyncResult00; contents: var uint8Array; 
    length: var uint64; etagOut: var cstring): gboolean {.
    importc: "g_file_load_contents_finish", libprag.}

proc loadContentsFinish*(self: File; res: AsyncResult; contents: var uint8Array; 
    length: var uint64; etagOut: var string): bool =
  var etagOut_00 = cstring(etagOut)
  result = toBool(g_file_load_contents_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl), contents, length, etagOut_00))
  etagOut = $(etagOut_00)

proc g_file_load_partial_contents_finish*(self: ptr File00; res: ptr AsyncResult00; contents: var uint8Array; 
    length: var uint64; etagOut: var cstring): gboolean {.
    importc: "g_file_load_partial_contents_finish", libprag.}

proc loadPartialContentsFinish*(self: File; res: AsyncResult; contents: var uint8Array; 
    length: var uint64; etagOut: var string): bool =
  var etagOut_00 = cstring(etagOut)
  result = toBool(g_file_load_partial_contents_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl), contents, length, etagOut_00))
  etagOut = $(etagOut_00)

proc g_file_make_directory*(self: ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_make_directory", libprag.}

proc makeDirectory*(self: File; cancellable: Cancellable): bool =
  toBool(g_file_make_directory(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_make_directory_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_make_directory_finish", libprag.}

proc makeDirectoryFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_make_directory_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_make_directory_with_parents*(self: ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_make_directory_with_parents", libprag.}

proc makeDirectoryWithParents*(self: File; cancellable: Cancellable): bool =
  toBool(g_file_make_directory_with_parents(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_make_symbolic_link*(self: ptr File00; symlinkValue: ucstring; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_make_symbolic_link", libprag.}

proc makeSymbolicLink*(self: File; symlinkValue: ucstring; cancellable: Cancellable): bool =
  toBool(g_file_make_symbolic_link(cast[ptr File00](self.impl), symlinkValue, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_measure_disk_usage_finish*(self: ptr File00; resu: ptr AsyncResult00; diskUsage: var uint64; 
    numDirs: var uint64; numFiles: var uint64): gboolean {.
    importc: "g_file_measure_disk_usage_finish", libprag.}

proc measureDiskUsageFinish*(self: File; resu: AsyncResult; diskUsage: var uint64; 
    numDirs: var uint64; numFiles: var uint64): bool =
  toBool(g_file_measure_disk_usage_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl), diskUsage, numDirs, numFiles))

proc g_file_mount_enclosing_volume_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_mount_enclosing_volume_finish", libprag.}

proc mountEnclosingVolumeFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_mount_enclosing_volume_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_mount_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): ptr File00 {.
    importc: "g_file_mount_mountable_finish", libprag.}

proc mountMountableFinish*(self: File; resu: AsyncResult): File =
  new(result)
  result.impl = g_file_mount_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_file_poll_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_poll_mountable_finish", libprag.}

proc pollMountableFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_poll_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_query_default_handler*(self: ptr File00; cancellable: ptr Cancellable00): ptr AppInfo00 {.
    importc: "g_file_query_default_handler", libprag.}

proc queryDefaultHandler*(self: File; cancellable: Cancellable): AppInfo =
  new(result)
  result.impl = g_file_query_default_handler(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_file_query_exists*(self: ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_query_exists", libprag.}

proc queryExists*(self: File; cancellable: Cancellable): bool =
  toBool(g_file_query_exists(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_replace_contents_finish*(self: ptr File00; res: ptr AsyncResult00; newEtag: var cstring): gboolean {.
    importc: "g_file_replace_contents_finish", libprag.}

proc replaceContentsFinish*(self: File; res: AsyncResult; newEtag: var string): bool =
  var newEtag_00 = cstring(newEtag)
  result = toBool(g_file_replace_contents_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl), newEtag_00))
  newEtag = $(newEtag_00)

proc g_file_resolve_relative_path*(self: ptr File00; relativePath: ucstring): ptr File00 {.
    importc: "g_file_resolve_relative_path", libprag.}

proc resolveRelativePath*(self: File; relativePath: ucstring): File =
  new(result)
  result.impl = g_file_resolve_relative_path(cast[ptr File00](self.impl), relativePath)

proc g_file_set_display_name*(self: ptr File00; displayName: cstring; cancellable: ptr Cancellable00): ptr File00 {.
    importc: "g_file_set_display_name", libprag.}

proc setDisplayName*(self: File; displayName: string; cancellable: Cancellable): File =
  new(result)
  result.impl = g_file_set_display_name(cast[ptr File00](self.impl), cstring(displayName), cast[ptr Cancellable00](cancellable.impl))

proc g_file_set_display_name_finish*(self: ptr File00; res: ptr AsyncResult00): ptr File00 {.
    importc: "g_file_set_display_name_finish", libprag.}

proc setDisplayNameFinish*(self: File; res: AsyncResult): File =
  new(result)
  result.impl = g_file_set_display_name_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))

proc `displayNameFinish=`*(self: File; res: AsyncResult): File =
  new(result)
  result.impl = g_file_set_display_name_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))

proc g_file_start_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_start_mountable_finish", libprag.}

proc startMountableFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_start_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_stop_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_stop_mountable_finish", libprag.}

proc stopMountableFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_stop_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_supports_thread_contexts*(self: ptr File00): gboolean {.
    importc: "g_file_supports_thread_contexts", libprag.}

proc supportsThreadContexts*(self: File): bool =
  toBool(g_file_supports_thread_contexts(cast[ptr File00](self.impl)))

proc g_file_trash*(self: ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_trash", libprag.}

proc trash*(self: File; cancellable: Cancellable): bool =
  toBool(g_file_trash(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_trash_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_trash_finish", libprag.}

proc trashFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_trash_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_unmount_mountable_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_unmount_mountable_finish", libprag.}

proc unmountMountableFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_unmount_mountable_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_unmount_mountable_with_operation_finish*(self: ptr File00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_unmount_mountable_with_operation_finish", libprag.}

proc unmountMountableWithOperationFinish*(self: File; resu: AsyncResult): bool =
  toBool(g_file_unmount_mountable_with_operation_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](resu.impl)))

type
  Application* = ref object of gobject.Object
  Application00* = object of gobject.Object00
    priv1: ptr ApplicationPrivate00

proc scActivate*(self: Application;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "activate", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scCommandLine*(self: Application;  p: proc (self: ptr gobject.Object00; commandLine: ApplicationCommandLine00; xdata: pointer): int32 {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "command-line", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scHandleLocalOptions*(self: Application;  p: proc (self: ptr gobject.Object00; options: glib.VariantDict00; xdata: pointer): int32 {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "handle-local-options", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scOpen*(self: Application;  p: proc (self: ptr gobject.Object00; files: File00Array; nFiles: int32; hint: cstring; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "open", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scShutdown*(self: Application;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "shutdown", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scStartup*(self: Application;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "startup", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_application_get_default*(): ptr Application00 {.
    importc: "g_application_get_default", libprag.}

proc getDefault*(): Application =
  let gobj = g_application_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Application](g_object_get_qdata(gobj, Quark))
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

proc default*(): Application =
  let gobj = g_application_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Application](g_object_get_qdata(gobj, Quark))
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

proc g_application_id_is_valid*(applicationId: cstring): gboolean {.
    importc: "g_application_id_is_valid", libprag.}

proc idIsValid*(applicationId: cstring): gboolean {.
    importc: "g_application_id_is_valid", libprag.}

proc g_application_activate*(self: ptr Application00) {.
    importc: "g_application_activate", libprag.}

proc activate*(self: Application) =
  g_application_activate(cast[ptr Application00](self.impl))

proc g_application_add_main_option*(self: ptr Application00; longName: cstring; shortName: int8; 
    flags: glib.OptionFlags; arg: glib.OptionArg; description: cstring; argDescription: cstring) {.
    importc: "g_application_add_main_option", libprag.}

proc addMainOption*(self: Application; longName: string; shortName: int8; 
    flags: glib.OptionFlags; arg: glib.OptionArg; description: string; argDescription: string) =
  g_application_add_main_option(cast[ptr Application00](self.impl), cstring(longName), shortName, flags, arg, cstring(description), cstring(argDescription))

proc g_application_add_main_option_entries*(self: ptr Application00; entries: glib.OptionEntry00Array) {.
    importc: "g_application_add_main_option_entries", libprag.}

proc addMainOptionEntries*(self: Application; entries: glib.OptionEntry00Array) =
  g_application_add_main_option_entries(cast[ptr Application00](self.impl), entries)

proc g_application_add_option_group*(self: ptr Application00; group: ptr glib.OptionGroup00) {.
    importc: "g_application_add_option_group", libprag.}

proc addOptionGroup*(self: Application; group: glib.OptionGroup) =
  g_application_add_option_group(cast[ptr Application00](self.impl), cast[ptr glib.OptionGroup00](group.impl))

proc g_application_bind_busy_property*(self: ptr Application00; `object`: ptr gobject.Object00; 
    property: cstring) {.
    importc: "g_application_bind_busy_property", libprag.}

proc bindBusyProperty*(self: Application; `object`: gobject.Object; property: string) =
  g_application_bind_busy_property(cast[ptr Application00](self.impl), cast[ptr gobject.Object00](`object`.impl), cstring(property))

proc g_application_get_application_id*(self: ptr Application00): cstring {.
    importc: "g_application_get_application_id", libprag.}

proc getApplicationId*(self: Application): string =
  let resul0 = g_application_get_application_id(cast[ptr Application00](self.impl))
  result = $resul0

proc applicationId*(self: Application): string =
  let resul0 = g_application_get_application_id(cast[ptr Application00](self.impl))
  result = $resul0

proc g_application_get_dbus_object_path*(self: ptr Application00): cstring {.
    importc: "g_application_get_dbus_object_path", libprag.}

proc getDbusObjectPath*(self: Application): string =
  let resul0 = g_application_get_dbus_object_path(cast[ptr Application00](self.impl))
  result = $resul0

proc dbusObjectPath*(self: Application): string =
  let resul0 = g_application_get_dbus_object_path(cast[ptr Application00](self.impl))
  result = $resul0

proc g_application_get_inactivity_timeout*(self: ptr Application00): uint32 {.
    importc: "g_application_get_inactivity_timeout", libprag.}

proc getInactivityTimeout*(self: Application): int =
  int(g_application_get_inactivity_timeout(cast[ptr Application00](self.impl)))

proc inactivityTimeout*(self: Application): int =
  int(g_application_get_inactivity_timeout(cast[ptr Application00](self.impl)))

proc g_application_get_is_busy*(self: ptr Application00): gboolean {.
    importc: "g_application_get_is_busy", libprag.}

proc getIsBusy*(self: Application): bool =
  toBool(g_application_get_is_busy(cast[ptr Application00](self.impl)))

proc isBusy*(self: Application): bool =
  toBool(g_application_get_is_busy(cast[ptr Application00](self.impl)))

proc g_application_get_is_registered*(self: ptr Application00): gboolean {.
    importc: "g_application_get_is_registered", libprag.}

proc getIsRegistered*(self: Application): bool =
  toBool(g_application_get_is_registered(cast[ptr Application00](self.impl)))

proc isRegistered*(self: Application): bool =
  toBool(g_application_get_is_registered(cast[ptr Application00](self.impl)))

proc g_application_get_is_remote*(self: ptr Application00): gboolean {.
    importc: "g_application_get_is_remote", libprag.}

proc getIsRemote*(self: Application): bool =
  toBool(g_application_get_is_remote(cast[ptr Application00](self.impl)))

proc isRemote*(self: Application): bool =
  toBool(g_application_get_is_remote(cast[ptr Application00](self.impl)))

proc g_application_get_resource_base_path*(self: ptr Application00): cstring {.
    importc: "g_application_get_resource_base_path", libprag.}

proc getResourceBasePath*(self: Application): string =
  let resul0 = g_application_get_resource_base_path(cast[ptr Application00](self.impl))
  result = $resul0

proc resourceBasePath*(self: Application): string =
  let resul0 = g_application_get_resource_base_path(cast[ptr Application00](self.impl))
  result = $resul0

proc g_application_hold*(self: ptr Application00) {.
    importc: "g_application_hold", libprag.}

proc hold*(self: Application) =
  g_application_hold(cast[ptr Application00](self.impl))

proc g_application_mark_busy*(self: ptr Application00) {.
    importc: "g_application_mark_busy", libprag.}

proc markBusy*(self: Application) =
  g_application_mark_busy(cast[ptr Application00](self.impl))

proc g_application_open*(self: ptr Application00; files: ptr File00Array; nFiles: int32; 
    hint: cstring) {.
    importc: "g_application_open", libprag.}

proc open*(self: Application; files: ptr File00Array; nFiles: int; 
    hint: string) =
  g_application_open(cast[ptr Application00](self.impl), files, int32(nFiles), cstring(hint))

proc g_application_quit*(self: ptr Application00) {.
    importc: "g_application_quit", libprag.}

proc quit*(self: Application) =
  g_application_quit(cast[ptr Application00](self.impl))

proc g_application_register*(self: ptr Application00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_application_register", libprag.}

proc register*(self: Application; cancellable: Cancellable): bool =
  toBool(g_application_register(cast[ptr Application00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_application_release*(self: ptr Application00) {.
    importc: "g_application_release", libprag.}

proc release*(self: Application) =
  g_application_release(cast[ptr Application00](self.impl))

proc g_application_run*(self: ptr Application00; argc: int32; argv: cstringArray): int32 {.
    importc: "g_application_run", libprag.}

proc run*(self: Application; argc: int; argv: cstringArray): int =
  int(g_application_run(cast[ptr Application00](self.impl), int32(argc), argv))

proc g_application_set_action_group*(self: ptr Application00; actionGroup: ptr ActionGroup00) {.
    importc: "g_application_set_action_group", libprag.}

proc setActionGroup*(self: Application; actionGroup: ActionGroup) =
  g_application_set_action_group(cast[ptr Application00](self.impl), cast[ptr ActionGroup00](actionGroup.impl))

proc `actionGroup=`*(self: Application; actionGroup: ActionGroup) =
  g_application_set_action_group(cast[ptr Application00](self.impl), cast[ptr ActionGroup00](actionGroup.impl))

proc g_application_set_application_id*(self: ptr Application00; applicationId: cstring) {.
    importc: "g_application_set_application_id", libprag.}

proc setApplicationId*(self: Application; applicationId: string) =
  g_application_set_application_id(cast[ptr Application00](self.impl), cstring(applicationId))

proc `applicationId=`*(self: Application; applicationId: string) =
  g_application_set_application_id(cast[ptr Application00](self.impl), cstring(applicationId))

proc g_application_set_default*(self: ptr Application00) {.
    importc: "g_application_set_default", libprag.}

proc setDefault*(self: Application) =
  g_application_set_default(cast[ptr Application00](self.impl))

proc `default=`*(self: Application) =
  g_application_set_default(cast[ptr Application00](self.impl))

proc g_application_set_inactivity_timeout*(self: ptr Application00; inactivityTimeout: uint32) {.
    importc: "g_application_set_inactivity_timeout", libprag.}

proc setInactivityTimeout*(self: Application; inactivityTimeout: int) =
  g_application_set_inactivity_timeout(cast[ptr Application00](self.impl), uint32(inactivityTimeout))

proc `inactivityTimeout=`*(self: Application; inactivityTimeout: int) =
  g_application_set_inactivity_timeout(cast[ptr Application00](self.impl), uint32(inactivityTimeout))

proc g_application_set_resource_base_path*(self: ptr Application00; resourcePath: cstring) {.
    importc: "g_application_set_resource_base_path", libprag.}

proc setResourceBasePath*(self: Application; resourcePath: string) =
  g_application_set_resource_base_path(cast[ptr Application00](self.impl), cstring(resourcePath))

proc `resourceBasePath=`*(self: Application; resourcePath: string) =
  g_application_set_resource_base_path(cast[ptr Application00](self.impl), cstring(resourcePath))

proc g_application_unbind_busy_property*(self: ptr Application00; `object`: ptr gobject.Object00; 
    property: cstring) {.
    importc: "g_application_unbind_busy_property", libprag.}

proc unbindBusyProperty*(self: Application; `object`: gobject.Object; property: string) =
  g_application_unbind_busy_property(cast[ptr Application00](self.impl), cast[ptr gobject.Object00](`object`.impl), cstring(property))

proc g_application_unmark_busy*(self: ptr Application00) {.
    importc: "g_application_unmark_busy", libprag.}

proc unmarkBusy*(self: Application) =
  g_application_unmark_busy(cast[ptr Application00](self.impl))

proc g_application_withdraw_notification*(self: ptr Application00; id: cstring) {.
    importc: "g_application_withdraw_notification", libprag.}

proc withdrawNotification*(self: Application; id: string) =
  g_application_withdraw_notification(cast[ptr Application00](self.impl), cstring(id))

proc g_application_command_line_create_file_for_arg*(self: ptr ApplicationCommandLine00; arg: cstring): ptr File00 {.
    importc: "g_application_command_line_create_file_for_arg", libprag.}

proc createFileForArg*(self: ApplicationCommandLine; arg: string): File =
  new(result)
  result.impl = g_application_command_line_create_file_for_arg(cast[ptr ApplicationCommandLine00](self.impl), cstring(arg))

type
  FileEnumeratorPrivate00* {.pure.} = object
  FileEnumeratorPrivate* = ref object
    impl*: ptr FileEnumeratorPrivate00

type
  FileEnumerator* = ref object of gobject.Object
  FileEnumerator00* = object of gobject.Object00
    priv1: ptr FileEnumeratorPrivate00

proc g_file_enumerator_close*(self: ptr FileEnumerator00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_enumerator_close", libprag.}

proc close*(self: FileEnumerator; cancellable: Cancellable): bool =
  toBool(g_file_enumerator_close(cast[ptr FileEnumerator00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_file_enumerator_close_finish*(self: ptr FileEnumerator00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_file_enumerator_close_finish", libprag.}

proc closeFinish*(self: FileEnumerator; resu: AsyncResult): bool =
  toBool(g_file_enumerator_close_finish(cast[ptr FileEnumerator00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_file_enumerator_get_container*(self: ptr FileEnumerator00): ptr File00 {.
    importc: "g_file_enumerator_get_container", libprag.}

proc getContainer*(self: FileEnumerator): File =
  new(result)
  result.impl = g_file_enumerator_get_container(cast[ptr FileEnumerator00](self.impl))

proc container*(self: FileEnumerator): File =
  new(result)
  result.impl = g_file_enumerator_get_container(cast[ptr FileEnumerator00](self.impl))

proc g_file_enumerator_has_pending*(self: ptr FileEnumerator00): gboolean {.
    importc: "g_file_enumerator_has_pending", libprag.}

proc hasPending*(self: FileEnumerator): bool =
  toBool(g_file_enumerator_has_pending(cast[ptr FileEnumerator00](self.impl)))

proc g_file_enumerator_is_closed*(self: ptr FileEnumerator00): gboolean {.
    importc: "g_file_enumerator_is_closed", libprag.}

proc isClosed*(self: FileEnumerator): bool =
  toBool(g_file_enumerator_is_closed(cast[ptr FileEnumerator00](self.impl)))

proc g_file_enumerator_next_files_finish*(self: ptr FileEnumerator00; resu: ptr AsyncResult00): ptr pointer {.
    importc: "g_file_enumerator_next_files_finish", libprag.}

proc nextFilesFinish*(self: FileEnumerator; resu: AsyncResult): ptr pointer =
  g_file_enumerator_next_files_finish(cast[ptr FileEnumerator00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_file_enumerator_set_pending*(self: ptr FileEnumerator00; pending: gboolean) {.
    importc: "g_file_enumerator_set_pending", libprag.}

proc setPending*(self: FileEnumerator; pending: bool) =
  g_file_enumerator_set_pending(cast[ptr FileEnumerator00](self.impl), gboolean(pending))

proc `pending=`*(self: FileEnumerator; pending: bool) =
  g_file_enumerator_set_pending(cast[ptr FileEnumerator00](self.impl), gboolean(pending))

proc g_file_enumerate_children_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileEnumerator00 {.
    importc: "g_file_enumerate_children_finish", libprag.}

proc enumerateChildrenFinish*(self: File; res: AsyncResult): FileEnumerator =
  let gobj = g_file_enumerate_children_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileEnumerator](g_object_get_qdata(gobj, Quark))
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
  Mount00* {.pure.} = object
  Mount* = ref object
    impl*: ptr Mount00

proc g_mount_can_eject*(self: ptr Mount00): gboolean {.
    importc: "g_mount_can_eject", libprag.}

proc canEject*(self: Mount): bool =
  toBool(g_mount_can_eject(cast[ptr Mount00](self.impl)))

proc g_mount_can_unmount*(self: ptr Mount00): gboolean {.
    importc: "g_mount_can_unmount", libprag.}

proc canUnmount*(self: Mount): bool =
  toBool(g_mount_can_unmount(cast[ptr Mount00](self.impl)))

proc g_mount_eject_finish*(self: ptr Mount00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_mount_eject_finish", libprag.}

proc ejectFinish*(self: Mount; resu: AsyncResult): bool =
  toBool(g_mount_eject_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_eject_with_operation_finish*(self: ptr Mount00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_mount_eject_with_operation_finish", libprag.}

proc ejectWithOperationFinish*(self: Mount; resu: AsyncResult): bool =
  toBool(g_mount_eject_with_operation_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_get_default_location*(self: ptr Mount00): ptr File00 {.
    importc: "g_mount_get_default_location", libprag.}

proc getDefaultLocation*(self: Mount): File =
  new(result)
  result.impl = g_mount_get_default_location(cast[ptr Mount00](self.impl))

proc defaultLocation*(self: Mount): File =
  new(result)
  result.impl = g_mount_get_default_location(cast[ptr Mount00](self.impl))

proc g_mount_get_icon*(self: ptr Mount00): ptr Icon00 {.
    importc: "g_mount_get_icon", libprag.}

proc getIcon*(self: Mount): Icon =
  new(result)
  result.impl = g_mount_get_icon(cast[ptr Mount00](self.impl))

proc icon*(self: Mount): Icon =
  new(result)
  result.impl = g_mount_get_icon(cast[ptr Mount00](self.impl))

proc g_mount_get_name*(self: ptr Mount00): cstring {.
    importc: "g_mount_get_name", libprag.}

proc getName*(self: Mount): string =
  let resul0 = g_mount_get_name(cast[ptr Mount00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: Mount): string =
  let resul0 = g_mount_get_name(cast[ptr Mount00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_mount_get_root*(self: ptr Mount00): ptr File00 {.
    importc: "g_mount_get_root", libprag.}

proc getRoot*(self: Mount): File =
  new(result)
  result.impl = g_mount_get_root(cast[ptr Mount00](self.impl))

proc root*(self: Mount): File =
  new(result)
  result.impl = g_mount_get_root(cast[ptr Mount00](self.impl))

proc g_mount_get_sort_key*(self: ptr Mount00): cstring {.
    importc: "g_mount_get_sort_key", libprag.}

proc getSortKey*(self: Mount): string =
  let resul0 = g_mount_get_sort_key(cast[ptr Mount00](self.impl))
  result = $resul0

proc sortKey*(self: Mount): string =
  let resul0 = g_mount_get_sort_key(cast[ptr Mount00](self.impl))
  result = $resul0

proc g_mount_get_symbolic_icon*(self: ptr Mount00): ptr Icon00 {.
    importc: "g_mount_get_symbolic_icon", libprag.}

proc getSymbolicIcon*(self: Mount): Icon =
  new(result)
  result.impl = g_mount_get_symbolic_icon(cast[ptr Mount00](self.impl))

proc symbolicIcon*(self: Mount): Icon =
  new(result)
  result.impl = g_mount_get_symbolic_icon(cast[ptr Mount00](self.impl))

proc g_mount_get_uuid*(self: ptr Mount00): cstring {.
    importc: "g_mount_get_uuid", libprag.}

proc getUuid*(self: Mount): string =
  let resul0 = g_mount_get_uuid(cast[ptr Mount00](self.impl))
  result = $resul0
  cogfree(resul0)

proc uuid*(self: Mount): string =
  let resul0 = g_mount_get_uuid(cast[ptr Mount00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_mount_guess_content_type_finish*(self: ptr Mount00; resu: ptr AsyncResult00): cstringArray {.
    importc: "g_mount_guess_content_type_finish", libprag.}

proc guessContentTypeFinish*(self: Mount; resu: AsyncResult): cstringArray =
  g_mount_guess_content_type_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_mount_guess_content_type_sync*(self: ptr Mount00; forceRescan: gboolean; cancellable: ptr Cancellable00): cstringArray {.
    importc: "g_mount_guess_content_type_sync", libprag.}

proc guessContentTypeSync*(self: Mount; forceRescan: bool; cancellable: Cancellable): cstringArray =
  g_mount_guess_content_type_sync(cast[ptr Mount00](self.impl), gboolean(forceRescan), cast[ptr Cancellable00](cancellable.impl))

proc g_mount_is_shadowed*(self: ptr Mount00): gboolean {.
    importc: "g_mount_is_shadowed", libprag.}

proc isShadowed*(self: Mount): bool =
  toBool(g_mount_is_shadowed(cast[ptr Mount00](self.impl)))

proc g_mount_remount_finish*(self: ptr Mount00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_mount_remount_finish", libprag.}

proc remountFinish*(self: Mount; resu: AsyncResult): bool =
  toBool(g_mount_remount_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_shadow*(self: ptr Mount00) {.
    importc: "g_mount_shadow", libprag.}

proc shadow*(self: Mount) =
  g_mount_shadow(cast[ptr Mount00](self.impl))

proc g_mount_unmount_finish*(self: ptr Mount00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_mount_unmount_finish", libprag.}

proc unmountFinish*(self: Mount; resu: AsyncResult): bool =
  toBool(g_mount_unmount_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_unmount_with_operation_finish*(self: ptr Mount00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_mount_unmount_with_operation_finish", libprag.}

proc unmountWithOperationFinish*(self: Mount; resu: AsyncResult): bool =
  toBool(g_mount_unmount_with_operation_finish(cast[ptr Mount00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_unshadow*(self: ptr Mount00) {.
    importc: "g_mount_unshadow", libprag.}

proc unshadow*(self: Mount) =
  g_mount_unshadow(cast[ptr Mount00](self.impl))

proc g_file_find_enclosing_mount*(self: ptr File00; cancellable: ptr Cancellable00): ptr Mount00 {.
    importc: "g_file_find_enclosing_mount", libprag.}

proc findEnclosingMount*(self: File; cancellable: Cancellable): Mount =
  new(result)
  result.impl = g_file_find_enclosing_mount(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_file_find_enclosing_mount_finish*(self: ptr File00; res: ptr AsyncResult00): ptr Mount00 {.
    importc: "g_file_find_enclosing_mount_finish", libprag.}

proc findEnclosingMountFinish*(self: File; res: AsyncResult): Mount =
  new(result)
  result.impl = g_file_find_enclosing_mount_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))

type
  Drive00* {.pure.} = object
  Drive* = ref object
    impl*: ptr Drive00

proc g_drive_can_eject*(self: ptr Drive00): gboolean {.
    importc: "g_drive_can_eject", libprag.}

proc canEject*(self: Drive): bool =
  toBool(g_drive_can_eject(cast[ptr Drive00](self.impl)))

proc g_drive_can_poll_for_media*(self: ptr Drive00): gboolean {.
    importc: "g_drive_can_poll_for_media", libprag.}

proc canPollForMedia*(self: Drive): bool =
  toBool(g_drive_can_poll_for_media(cast[ptr Drive00](self.impl)))

proc g_drive_can_start*(self: ptr Drive00): gboolean {.
    importc: "g_drive_can_start", libprag.}

proc canStart*(self: Drive): bool =
  toBool(g_drive_can_start(cast[ptr Drive00](self.impl)))

proc g_drive_can_start_degraded*(self: ptr Drive00): gboolean {.
    importc: "g_drive_can_start_degraded", libprag.}

proc canStartDegraded*(self: Drive): bool =
  toBool(g_drive_can_start_degraded(cast[ptr Drive00](self.impl)))

proc g_drive_can_stop*(self: ptr Drive00): gboolean {.
    importc: "g_drive_can_stop", libprag.}

proc canStop*(self: Drive): bool =
  toBool(g_drive_can_stop(cast[ptr Drive00](self.impl)))

proc g_drive_eject_finish*(self: ptr Drive00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_drive_eject_finish", libprag.}

proc ejectFinish*(self: Drive; resu: AsyncResult): bool =
  toBool(g_drive_eject_finish(cast[ptr Drive00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_drive_eject_with_operation_finish*(self: ptr Drive00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_drive_eject_with_operation_finish", libprag.}

proc ejectWithOperationFinish*(self: Drive; resu: AsyncResult): bool =
  toBool(g_drive_eject_with_operation_finish(cast[ptr Drive00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_drive_enumerate_identifiers*(self: ptr Drive00): cstringArray {.
    importc: "g_drive_enumerate_identifiers", libprag.}

proc enumerateIdentifiers*(self: Drive): cstringArray =
  g_drive_enumerate_identifiers(cast[ptr Drive00](self.impl))

proc g_drive_get_icon*(self: ptr Drive00): ptr Icon00 {.
    importc: "g_drive_get_icon", libprag.}

proc getIcon*(self: Drive): Icon =
  new(result)
  result.impl = g_drive_get_icon(cast[ptr Drive00](self.impl))

proc icon*(self: Drive): Icon =
  new(result)
  result.impl = g_drive_get_icon(cast[ptr Drive00](self.impl))

proc g_drive_get_identifier*(self: ptr Drive00; kind: cstring): cstring {.
    importc: "g_drive_get_identifier", libprag.}

proc getIdentifier*(self: Drive; kind: string): string =
  let resul0 = g_drive_get_identifier(cast[ptr Drive00](self.impl), cstring(kind))
  result = $resul0
  cogfree(resul0)

proc identifier*(self: Drive; kind: string): string =
  let resul0 = g_drive_get_identifier(cast[ptr Drive00](self.impl), cstring(kind))
  result = $resul0
  cogfree(resul0)

proc g_drive_get_name*(self: ptr Drive00): cstring {.
    importc: "g_drive_get_name", libprag.}

proc getName*(self: Drive): string =
  let resul0 = g_drive_get_name(cast[ptr Drive00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: Drive): string =
  let resul0 = g_drive_get_name(cast[ptr Drive00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_drive_get_sort_key*(self: ptr Drive00): cstring {.
    importc: "g_drive_get_sort_key", libprag.}

proc getSortKey*(self: Drive): string =
  let resul0 = g_drive_get_sort_key(cast[ptr Drive00](self.impl))
  result = $resul0

proc sortKey*(self: Drive): string =
  let resul0 = g_drive_get_sort_key(cast[ptr Drive00](self.impl))
  result = $resul0

proc g_drive_get_symbolic_icon*(self: ptr Drive00): ptr Icon00 {.
    importc: "g_drive_get_symbolic_icon", libprag.}

proc getSymbolicIcon*(self: Drive): Icon =
  new(result)
  result.impl = g_drive_get_symbolic_icon(cast[ptr Drive00](self.impl))

proc symbolicIcon*(self: Drive): Icon =
  new(result)
  result.impl = g_drive_get_symbolic_icon(cast[ptr Drive00](self.impl))

proc g_drive_get_volumes*(self: ptr Drive00): ptr pointer {.
    importc: "g_drive_get_volumes", libprag.}

proc getVolumes*(self: Drive): ptr pointer =
  g_drive_get_volumes(cast[ptr Drive00](self.impl))

proc volumes*(self: Drive): ptr pointer =
  g_drive_get_volumes(cast[ptr Drive00](self.impl))

proc g_drive_has_media*(self: ptr Drive00): gboolean {.
    importc: "g_drive_has_media", libprag.}

proc hasMedia*(self: Drive): bool =
  toBool(g_drive_has_media(cast[ptr Drive00](self.impl)))

proc g_drive_has_volumes*(self: ptr Drive00): gboolean {.
    importc: "g_drive_has_volumes", libprag.}

proc hasVolumes*(self: Drive): bool =
  toBool(g_drive_has_volumes(cast[ptr Drive00](self.impl)))

proc g_drive_is_media_check_automatic*(self: ptr Drive00): gboolean {.
    importc: "g_drive_is_media_check_automatic", libprag.}

proc isMediaCheckAutomatic*(self: Drive): bool =
  toBool(g_drive_is_media_check_automatic(cast[ptr Drive00](self.impl)))

proc g_drive_is_media_removable*(self: ptr Drive00): gboolean {.
    importc: "g_drive_is_media_removable", libprag.}

proc isMediaRemovable*(self: Drive): bool =
  toBool(g_drive_is_media_removable(cast[ptr Drive00](self.impl)))

proc g_drive_is_removable*(self: ptr Drive00): gboolean {.
    importc: "g_drive_is_removable", libprag.}

proc isRemovable*(self: Drive): bool =
  toBool(g_drive_is_removable(cast[ptr Drive00](self.impl)))

proc g_drive_poll_for_media_finish*(self: ptr Drive00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_drive_poll_for_media_finish", libprag.}

proc pollForMediaFinish*(self: Drive; resu: AsyncResult): bool =
  toBool(g_drive_poll_for_media_finish(cast[ptr Drive00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_drive_start_finish*(self: ptr Drive00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_drive_start_finish", libprag.}

proc startFinish*(self: Drive; resu: AsyncResult): bool =
  toBool(g_drive_start_finish(cast[ptr Drive00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_drive_stop_finish*(self: ptr Drive00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_drive_stop_finish", libprag.}

proc stopFinish*(self: Drive; resu: AsyncResult): bool =
  toBool(g_drive_stop_finish(cast[ptr Drive00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_mount_get_drive*(self: ptr Mount00): ptr Drive00 {.
    importc: "g_mount_get_drive", libprag.}

proc getDrive*(self: Mount): Drive =
  new(result)
  result.impl = g_mount_get_drive(cast[ptr Mount00](self.impl))

proc drive*(self: Mount): Drive =
  new(result)
  result.impl = g_mount_get_drive(cast[ptr Mount00](self.impl))

type
  DriveStartStopType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    shutdown = 1
    network = 2
    multidisk = 3
    password = 4

proc g_drive_get_start_stop_type*(self: ptr Drive00): DriveStartStopType {.
    importc: "g_drive_get_start_stop_type", libprag.}

proc getStartStopType*(self: Drive): DriveStartStopType =
  g_drive_get_start_stop_type(cast[ptr Drive00](self.impl))

proc startStopType*(self: Drive): DriveStartStopType =
  g_drive_get_start_stop_type(cast[ptr Drive00](self.impl))

type
  Volume00* {.pure.} = object
  Volume* = ref object
    impl*: ptr Volume00

proc g_volume_can_eject*(self: ptr Volume00): gboolean {.
    importc: "g_volume_can_eject", libprag.}

proc canEject*(self: Volume): bool =
  toBool(g_volume_can_eject(cast[ptr Volume00](self.impl)))

proc g_volume_can_mount*(self: ptr Volume00): gboolean {.
    importc: "g_volume_can_mount", libprag.}

proc canMount*(self: Volume): bool =
  toBool(g_volume_can_mount(cast[ptr Volume00](self.impl)))

proc g_volume_eject_finish*(self: ptr Volume00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_volume_eject_finish", libprag.}

proc ejectFinish*(self: Volume; resu: AsyncResult): bool =
  toBool(g_volume_eject_finish(cast[ptr Volume00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_volume_eject_with_operation_finish*(self: ptr Volume00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_volume_eject_with_operation_finish", libprag.}

proc ejectWithOperationFinish*(self: Volume; resu: AsyncResult): bool =
  toBool(g_volume_eject_with_operation_finish(cast[ptr Volume00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_volume_enumerate_identifiers*(self: ptr Volume00): cstringArray {.
    importc: "g_volume_enumerate_identifiers", libprag.}

proc enumerateIdentifiers*(self: Volume): cstringArray =
  g_volume_enumerate_identifiers(cast[ptr Volume00](self.impl))

proc g_volume_get_activation_root*(self: ptr Volume00): ptr File00 {.
    importc: "g_volume_get_activation_root", libprag.}

proc getActivationRoot*(self: Volume): File =
  new(result)
  result.impl = g_volume_get_activation_root(cast[ptr Volume00](self.impl))

proc activationRoot*(self: Volume): File =
  new(result)
  result.impl = g_volume_get_activation_root(cast[ptr Volume00](self.impl))

proc g_volume_get_drive*(self: ptr Volume00): ptr Drive00 {.
    importc: "g_volume_get_drive", libprag.}

proc getDrive*(self: Volume): Drive =
  new(result)
  result.impl = g_volume_get_drive(cast[ptr Volume00](self.impl))

proc drive*(self: Volume): Drive =
  new(result)
  result.impl = g_volume_get_drive(cast[ptr Volume00](self.impl))

proc g_volume_get_icon*(self: ptr Volume00): ptr Icon00 {.
    importc: "g_volume_get_icon", libprag.}

proc getIcon*(self: Volume): Icon =
  new(result)
  result.impl = g_volume_get_icon(cast[ptr Volume00](self.impl))

proc icon*(self: Volume): Icon =
  new(result)
  result.impl = g_volume_get_icon(cast[ptr Volume00](self.impl))

proc g_volume_get_identifier*(self: ptr Volume00; kind: cstring): cstring {.
    importc: "g_volume_get_identifier", libprag.}

proc getIdentifier*(self: Volume; kind: string): string =
  let resul0 = g_volume_get_identifier(cast[ptr Volume00](self.impl), cstring(kind))
  result = $resul0
  cogfree(resul0)

proc identifier*(self: Volume; kind: string): string =
  let resul0 = g_volume_get_identifier(cast[ptr Volume00](self.impl), cstring(kind))
  result = $resul0
  cogfree(resul0)

proc g_volume_get_mount*(self: ptr Volume00): ptr Mount00 {.
    importc: "g_volume_get_mount", libprag.}

proc getMount*(self: Volume): Mount =
  new(result)
  result.impl = g_volume_get_mount(cast[ptr Volume00](self.impl))

proc mount*(self: Volume): Mount =
  new(result)
  result.impl = g_volume_get_mount(cast[ptr Volume00](self.impl))

proc g_volume_get_name*(self: ptr Volume00): cstring {.
    importc: "g_volume_get_name", libprag.}

proc getName*(self: Volume): string =
  let resul0 = g_volume_get_name(cast[ptr Volume00](self.impl))
  result = $resul0
  cogfree(resul0)

proc name*(self: Volume): string =
  let resul0 = g_volume_get_name(cast[ptr Volume00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_volume_get_sort_key*(self: ptr Volume00): cstring {.
    importc: "g_volume_get_sort_key", libprag.}

proc getSortKey*(self: Volume): string =
  let resul0 = g_volume_get_sort_key(cast[ptr Volume00](self.impl))
  result = $resul0

proc sortKey*(self: Volume): string =
  let resul0 = g_volume_get_sort_key(cast[ptr Volume00](self.impl))
  result = $resul0

proc g_volume_get_symbolic_icon*(self: ptr Volume00): ptr Icon00 {.
    importc: "g_volume_get_symbolic_icon", libprag.}

proc getSymbolicIcon*(self: Volume): Icon =
  new(result)
  result.impl = g_volume_get_symbolic_icon(cast[ptr Volume00](self.impl))

proc symbolicIcon*(self: Volume): Icon =
  new(result)
  result.impl = g_volume_get_symbolic_icon(cast[ptr Volume00](self.impl))

proc g_volume_get_uuid*(self: ptr Volume00): cstring {.
    importc: "g_volume_get_uuid", libprag.}

proc getUuid*(self: Volume): string =
  let resul0 = g_volume_get_uuid(cast[ptr Volume00](self.impl))
  result = $resul0
  cogfree(resul0)

proc uuid*(self: Volume): string =
  let resul0 = g_volume_get_uuid(cast[ptr Volume00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_volume_mount_finish*(self: ptr Volume00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_volume_mount_finish", libprag.}

proc mountFinish*(self: Volume; resu: AsyncResult): bool =
  toBool(g_volume_mount_finish(cast[ptr Volume00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_volume_should_automount*(self: ptr Volume00): gboolean {.
    importc: "g_volume_should_automount", libprag.}

proc shouldAutomount*(self: Volume): bool =
  toBool(g_volume_should_automount(cast[ptr Volume00](self.impl)))

proc g_mount_get_volume*(self: ptr Mount00): ptr Volume00 {.
    importc: "g_mount_get_volume", libprag.}

proc getVolume*(self: Mount): Volume =
  new(result)
  result.impl = g_mount_get_volume(cast[ptr Mount00](self.impl))

proc volume*(self: Mount): Volume =
  new(result)
  result.impl = g_mount_get_volume(cast[ptr Mount00](self.impl))

type
  FileMonitorFlag* {.size: sizeof(cint), pure.} = enum
    watchMounts = 1
    sendMoved = 2
    watchHardLinks = 3
    watchMoves = 4

  FileMonitorFlags* {.size: sizeof(cint).} = set[FileMonitorFlag]

type
  FileMonitorPrivate00* {.pure.} = object
  FileMonitorPrivate* = ref object
    impl*: ptr FileMonitorPrivate00

type
  FileMonitorEvent* {.size: sizeof(cint), pure.} = enum
    changed = 0
    changesDoneHint = 1
    deleted = 2
    created = 3
    attributeChanged = 4
    preUnmount = 5
    unmounted = 6
    moved = 7
    renamed = 8
    movedIn = 9
    movedOut = 10

type
  FileMonitor* = ref object of gobject.Object
  FileMonitor00* = object of gobject.Object00
    priv1: ptr FileMonitorPrivate00

proc scChanged*(self: FileMonitor;  p: proc (self: ptr gobject.Object00; file: File00; otherFile: File00; eventType: FileMonitorEvent; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_file_monitor_cancel*(self: ptr FileMonitor00): gboolean {.
    importc: "g_file_monitor_cancel", libprag.}

proc cancel*(self: FileMonitor): bool =
  toBool(g_file_monitor_cancel(cast[ptr FileMonitor00](self.impl)))

proc g_file_monitor_emit_event*(self: ptr FileMonitor00; child: ptr File00; otherFile: ptr File00; 
    eventType: FileMonitorEvent) {.
    importc: "g_file_monitor_emit_event", libprag.}

proc emitEvent*(self: FileMonitor; child: File; otherFile: File; eventType: FileMonitorEvent) =
  g_file_monitor_emit_event(cast[ptr FileMonitor00](self.impl), cast[ptr File00](child.impl), cast[ptr File00](otherFile.impl), eventType)

proc g_file_monitor_is_cancelled*(self: ptr FileMonitor00): gboolean {.
    importc: "g_file_monitor_is_cancelled", libprag.}

proc isCancelled*(self: FileMonitor): bool =
  toBool(g_file_monitor_is_cancelled(cast[ptr FileMonitor00](self.impl)))

proc g_file_monitor_set_rate_limit*(self: ptr FileMonitor00; limitMsecs: int32) {.
    importc: "g_file_monitor_set_rate_limit", libprag.}

proc setRateLimit*(self: FileMonitor; limitMsecs: int) =
  g_file_monitor_set_rate_limit(cast[ptr FileMonitor00](self.impl), int32(limitMsecs))

proc `rateLimit=`*(self: FileMonitor; limitMsecs: int) =
  g_file_monitor_set_rate_limit(cast[ptr FileMonitor00](self.impl), int32(limitMsecs))

proc g_file_monitor*(self: ptr File00; flags: FileMonitorFlags; cancellable: ptr Cancellable00): ptr FileMonitor00 {.
    importc: "g_file_monitor", libprag.}

proc monitor*(self: File; flags: FileMonitorFlags; cancellable: Cancellable): FileMonitor =
  let gobj = g_file_monitor(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileMonitor](g_object_get_qdata(gobj, Quark))
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

proc g_file_monitor_directory*(self: ptr File00; flags: FileMonitorFlags; cancellable: ptr Cancellable00): ptr FileMonitor00 {.
    importc: "g_file_monitor_directory", libprag.}

proc monitorDirectory*(self: File; flags: FileMonitorFlags; cancellable: Cancellable): FileMonitor =
  let gobj = g_file_monitor_directory(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileMonitor](g_object_get_qdata(gobj, Quark))
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

proc g_file_monitor_file*(self: ptr File00; flags: FileMonitorFlags; cancellable: ptr Cancellable00): ptr FileMonitor00 {.
    importc: "g_file_monitor_file", libprag.}

proc monitorFile*(self: File; flags: FileMonitorFlags; cancellable: Cancellable): FileMonitor =
  let gobj = g_file_monitor_file(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileMonitor](g_object_get_qdata(gobj, Quark))
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
  MountMountFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

type
  MountOperationPrivate00* {.pure.} = object
  MountOperationPrivate* = ref object
    impl*: ptr MountOperationPrivate00

type
  AskPasswordFlag* {.size: sizeof(cint), pure.} = enum
    needPassword = 1
    needUsername = 2
    needDomain = 3
    savingSupported = 4
    anonymousSupported = 5

  AskPasswordFlags* {.size: sizeof(cint).} = set[AskPasswordFlag]

type
  MountOperationResult* {.size: sizeof(cint), pure.} = enum
    handled = 0
    aborted = 1
    unhandled = 2

type
  MountOperation* = ref object of gobject.Object
  MountOperation00* = object of gobject.Object00
    priv1: ptr MountOperationPrivate00

proc scAborted*(self: MountOperation;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "aborted", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scAskPassword*(self: MountOperation;  p: proc (self: ptr gobject.Object00; message: cstring; defaultUser: cstring; defaultDomain: cstring; 
    flags: AskPasswordFlags; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "ask-password", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scAskQuestion*(self: MountOperation;  p: proc (self: ptr gobject.Object00; message: cstring; choices: cstringArray; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "ask-question", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scReply*(self: MountOperation;  p: proc (self: ptr gobject.Object00; resu: MountOperationResult; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "reply", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scShowProcesses*(self: MountOperation;  p: proc (self: ptr gobject.Object00; message: cstring; processes: ptr Array; choices: cstringArray; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "show-processes", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scShowUnmountProgress*(self: MountOperation;  p: proc (self: ptr gobject.Object00; message: cstring; timeLeft: int64; bytesLeft: int64; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "show-unmount-progress", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_mount_operation_new*(): ptr MountOperation00 {.
    importc: "g_mount_operation_new", libprag.}

proc newMountOperation*(): MountOperation =
  new(result, finalizeGObject)
  result.impl = g_mount_operation_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMountOperation*[T](result: var T) =
  assert(result is MountOperation)
  new(result, finalizeGObject)
  result.impl = g_mount_operation_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_mount_operation_get_anonymous*(self: ptr MountOperation00): gboolean {.
    importc: "g_mount_operation_get_anonymous", libprag.}

proc getAnonymous*(self: MountOperation): bool =
  toBool(g_mount_operation_get_anonymous(cast[ptr MountOperation00](self.impl)))

proc anonymous*(self: MountOperation): bool =
  toBool(g_mount_operation_get_anonymous(cast[ptr MountOperation00](self.impl)))

proc g_mount_operation_get_choice*(self: ptr MountOperation00): int32 {.
    importc: "g_mount_operation_get_choice", libprag.}

proc getChoice*(self: MountOperation): int =
  int(g_mount_operation_get_choice(cast[ptr MountOperation00](self.impl)))

proc choice*(self: MountOperation): int =
  int(g_mount_operation_get_choice(cast[ptr MountOperation00](self.impl)))

proc g_mount_operation_get_domain*(self: ptr MountOperation00): cstring {.
    importc: "g_mount_operation_get_domain", libprag.}

proc getDomain*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_domain(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc domain*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_domain(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc g_mount_operation_get_password*(self: ptr MountOperation00): cstring {.
    importc: "g_mount_operation_get_password", libprag.}

proc getPassword*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_password(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc password*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_password(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc g_mount_operation_get_username*(self: ptr MountOperation00): cstring {.
    importc: "g_mount_operation_get_username", libprag.}

proc getUsername*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_username(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc username*(self: MountOperation): string =
  let resul0 = g_mount_operation_get_username(cast[ptr MountOperation00](self.impl))
  result = $resul0

proc g_mount_operation_reply*(self: ptr MountOperation00; resu: MountOperationResult) {.
    importc: "g_mount_operation_reply", libprag.}

proc reply*(self: MountOperation; resu: MountOperationResult) =
  g_mount_operation_reply(cast[ptr MountOperation00](self.impl), resu)

proc g_mount_operation_set_anonymous*(self: ptr MountOperation00; anonymous: gboolean) {.
    importc: "g_mount_operation_set_anonymous", libprag.}

proc setAnonymous*(self: MountOperation; anonymous: bool) =
  g_mount_operation_set_anonymous(cast[ptr MountOperation00](self.impl), gboolean(anonymous))

proc `anonymous=`*(self: MountOperation; anonymous: bool) =
  g_mount_operation_set_anonymous(cast[ptr MountOperation00](self.impl), gboolean(anonymous))

proc g_mount_operation_set_choice*(self: ptr MountOperation00; choice: int32) {.
    importc: "g_mount_operation_set_choice", libprag.}

proc setChoice*(self: MountOperation; choice: int) =
  g_mount_operation_set_choice(cast[ptr MountOperation00](self.impl), int32(choice))

proc `choice=`*(self: MountOperation; choice: int) =
  g_mount_operation_set_choice(cast[ptr MountOperation00](self.impl), int32(choice))

proc g_mount_operation_set_domain*(self: ptr MountOperation00; domain: cstring) {.
    importc: "g_mount_operation_set_domain", libprag.}

proc setDomain*(self: MountOperation; domain: string) =
  g_mount_operation_set_domain(cast[ptr MountOperation00](self.impl), cstring(domain))

proc `domain=`*(self: MountOperation; domain: string) =
  g_mount_operation_set_domain(cast[ptr MountOperation00](self.impl), cstring(domain))

proc g_mount_operation_set_password*(self: ptr MountOperation00; password: cstring) {.
    importc: "g_mount_operation_set_password", libprag.}

proc setPassword*(self: MountOperation; password: string) =
  g_mount_operation_set_password(cast[ptr MountOperation00](self.impl), cstring(password))

proc `password=`*(self: MountOperation; password: string) =
  g_mount_operation_set_password(cast[ptr MountOperation00](self.impl), cstring(password))

proc g_mount_operation_set_username*(self: ptr MountOperation00; username: cstring) {.
    importc: "g_mount_operation_set_username", libprag.}

proc setUsername*(self: MountOperation; username: string) =
  g_mount_operation_set_username(cast[ptr MountOperation00](self.impl), cstring(username))

proc `username=`*(self: MountOperation; username: string) =
  g_mount_operation_set_username(cast[ptr MountOperation00](self.impl), cstring(username))

type
  PasswordSave* {.size: sizeof(cint), pure.} = enum
    never = 0
    forSession = 1
    permanently = 2

proc g_mount_operation_get_password_save*(self: ptr MountOperation00): PasswordSave {.
    importc: "g_mount_operation_get_password_save", libprag.}

proc getPasswordSave*(self: MountOperation): PasswordSave =
  g_mount_operation_get_password_save(cast[ptr MountOperation00](self.impl))

proc passwordSave*(self: MountOperation): PasswordSave =
  g_mount_operation_get_password_save(cast[ptr MountOperation00](self.impl))

proc g_mount_operation_set_password_save*(self: ptr MountOperation00; save: PasswordSave) {.
    importc: "g_mount_operation_set_password_save", libprag.}

proc setPasswordSave*(self: MountOperation; save: PasswordSave) =
  g_mount_operation_set_password_save(cast[ptr MountOperation00](self.impl), save)

proc `passwordSave=`*(self: MountOperation; save: PasswordSave) =
  g_mount_operation_set_password_save(cast[ptr MountOperation00](self.impl), save)

type
  FileCopyFlag* {.size: sizeof(cint), pure.} = enum
    overwrite = 1
    backup = 2
    nofollowSymlinks = 3
    allMetadata = 4
    noFallbackForMove = 5
    targetDefaultPerms = 6

  FileCopyFlags* {.size: sizeof(cint).} = set[FileCopyFlag]

proc g_file_copy_attributes*(self: ptr File00; destination: ptr File00; flags: FileCopyFlags; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_copy_attributes", libprag.}

proc copyAttributes*(self: File; destination: File; flags: FileCopyFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_copy_attributes(cast[ptr File00](self.impl), cast[ptr File00](destination.impl), flags, cast[ptr Cancellable00](cancellable.impl)))

type
  OutputStreamPrivate00* {.pure.} = object
  OutputStreamPrivate* = ref object
    impl*: ptr OutputStreamPrivate00

type
  OutputStream* = ref object of gobject.Object
  OutputStream00* = object of gobject.Object00
    priv1: ptr OutputStreamPrivate00

proc g_output_stream_clear_pending*(self: ptr OutputStream00) {.
    importc: "g_output_stream_clear_pending", libprag.}

proc clearPending*(self: OutputStream) =
  g_output_stream_clear_pending(cast[ptr OutputStream00](self.impl))

proc g_output_stream_close*(self: ptr OutputStream00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_output_stream_close", libprag.}

proc close*(self: OutputStream; cancellable: Cancellable): bool =
  toBool(g_output_stream_close(cast[ptr OutputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_output_stream_close_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_output_stream_close_finish", libprag.}

proc closeFinish*(self: OutputStream; resu: AsyncResult): bool =
  toBool(g_output_stream_close_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_output_stream_flush*(self: ptr OutputStream00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_output_stream_flush", libprag.}

proc flush*(self: OutputStream; cancellable: Cancellable): bool =
  toBool(g_output_stream_flush(cast[ptr OutputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_output_stream_flush_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_output_stream_flush_finish", libprag.}

proc flushFinish*(self: OutputStream; resu: AsyncResult): bool =
  toBool(g_output_stream_flush_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_output_stream_has_pending*(self: ptr OutputStream00): gboolean {.
    importc: "g_output_stream_has_pending", libprag.}

proc hasPending*(self: OutputStream): bool =
  toBool(g_output_stream_has_pending(cast[ptr OutputStream00](self.impl)))

proc g_output_stream_is_closed*(self: ptr OutputStream00): gboolean {.
    importc: "g_output_stream_is_closed", libprag.}

proc isClosed*(self: OutputStream): bool =
  toBool(g_output_stream_is_closed(cast[ptr OutputStream00](self.impl)))

proc g_output_stream_is_closing*(self: ptr OutputStream00): gboolean {.
    importc: "g_output_stream_is_closing", libprag.}

proc isClosing*(self: OutputStream): bool =
  toBool(g_output_stream_is_closing(cast[ptr OutputStream00](self.impl)))

proc g_output_stream_set_pending*(self: ptr OutputStream00): gboolean {.
    importc: "g_output_stream_set_pending", libprag.}

proc setPending*(self: OutputStream): bool =
  toBool(g_output_stream_set_pending(cast[ptr OutputStream00](self.impl)))

proc `pending=`*(self: OutputStream): bool =
  toBool(g_output_stream_set_pending(cast[ptr OutputStream00](self.impl)))

proc g_output_stream_splice_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_output_stream_splice_finish", libprag.}

proc spliceFinish*(self: OutputStream; resu: AsyncResult): int64 =
  g_output_stream_splice_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_output_stream_write*(self: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    cancellable: ptr Cancellable00): int64 {.
    importc: "g_output_stream_write", libprag.}

proc write*(self: OutputStream; buffer: uint8Array; count: uint64; 
    cancellable: Cancellable): int64 =
  g_output_stream_write(cast[ptr OutputStream00](self.impl), buffer, count, cast[ptr Cancellable00](cancellable.impl))

proc g_output_stream_write_all*(self: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    bytesWritten: var uint64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_output_stream_write_all", libprag.}

proc writeAll*(self: OutputStream; buffer: uint8Array; count: uint64; 
    bytesWritten: var uint64; cancellable: Cancellable): bool =
  toBool(g_output_stream_write_all(cast[ptr OutputStream00](self.impl), buffer, count, bytesWritten, cast[ptr Cancellable00](cancellable.impl)))

proc g_output_stream_write_all_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00; 
    bytesWritten: var uint64): gboolean {.
    importc: "g_output_stream_write_all_finish", libprag.}

proc writeAllFinish*(self: OutputStream; resu: AsyncResult; bytesWritten: var uint64): bool =
  toBool(g_output_stream_write_all_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), bytesWritten))

proc g_output_stream_write_bytes*(self: ptr OutputStream00; bytes: ptr glib.Bytes00; 
    cancellable: ptr Cancellable00): int64 {.
    importc: "g_output_stream_write_bytes", libprag.}

proc writeBytes*(self: OutputStream; bytes: glib.Bytes; cancellable: Cancellable): int64 =
  g_output_stream_write_bytes(cast[ptr OutputStream00](self.impl), cast[ptr glib.Bytes00](bytes.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_output_stream_write_bytes_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_output_stream_write_bytes_finish", libprag.}

proc writeBytesFinish*(self: OutputStream; resu: AsyncResult): int64 =
  g_output_stream_write_bytes_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_output_stream_write_finish*(self: ptr OutputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_output_stream_write_finish", libprag.}

proc writeFinish*(self: OutputStream; resu: AsyncResult): int64 =
  g_output_stream_write_finish(cast[ptr OutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

type
  FileOutputStreamPrivate00* {.pure.} = object
  FileOutputStreamPrivate* = ref object
    impl*: ptr FileOutputStreamPrivate00

type
  FileOutputStream* = ref object of OutputStream
  FileOutputStream00* = object of OutputStream00
    priv2: ptr FileOutputStreamPrivate00

proc g_file_output_stream_get_etag*(self: ptr FileOutputStream00): cstring {.
    importc: "g_file_output_stream_get_etag", libprag.}

proc getEtag*(self: FileOutputStream): string =
  let resul0 = g_file_output_stream_get_etag(cast[ptr FileOutputStream00](self.impl))
  result = $resul0
  cogfree(resul0)

proc etag*(self: FileOutputStream): string =
  let resul0 = g_file_output_stream_get_etag(cast[ptr FileOutputStream00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_append_to_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.
    importc: "g_file_append_to_finish", libprag.}

proc appendToFinish*(self: File; res: AsyncResult): FileOutputStream =
  let gobj = g_file_append_to_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_create_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.
    importc: "g_file_create_finish", libprag.}

proc createFinish*(self: File; res: AsyncResult): FileOutputStream =
  let gobj = g_file_create_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_replace_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.
    importc: "g_file_replace_finish", libprag.}

proc replaceFinish*(self: File; res: AsyncResult): FileOutputStream =
  let gobj = g_file_replace_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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
  FileCreateFlag* {.size: sizeof(cint), pure.} = enum
    private = 1
    replaceDestination = 2

  FileCreateFlags* {.size: sizeof(cint).} = set[FileCreateFlag]

proc g_file_append_to*(self: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.
    importc: "g_file_append_to", libprag.}

proc appendTo*(self: File; flags: FileCreateFlags; cancellable: Cancellable): FileOutputStream =
  let gobj = g_file_append_to(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_create*(self: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.
    importc: "g_file_create", libprag.}

proc create*(self: File; flags: FileCreateFlags; cancellable: Cancellable): FileOutputStream =
  let gobj = g_file_create(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_replace*(self: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.
    importc: "g_file_replace", libprag.}

proc replace*(self: File; etag: string; makeBackup: bool; flags: FileCreateFlags; 
    cancellable: Cancellable): FileOutputStream =
  let gobj = g_file_replace(cast[ptr File00](self.impl), cstring(etag), gboolean(makeBackup), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileOutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_replace_contents*(self: ptr File00; contents: uint8Array; length: uint64; 
    etag: cstring; makeBackup: gboolean; flags: FileCreateFlags; newEtag: var cstring; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_replace_contents", libprag.}

proc replaceContents*(self: File; contents: uint8Array; length: uint64; 
    etag: string; makeBackup: bool; flags: FileCreateFlags; newEtag: var string; cancellable: Cancellable): bool =
  var newEtag_00 = cstring(newEtag)
  result = toBool(g_file_replace_contents(cast[ptr File00](self.impl), contents, length, cstring(etag), gboolean(makeBackup), flags, newEtag_00, cast[ptr Cancellable00](cancellable.impl)))
  newEtag = $(newEtag_00)

type
  IOStreamPrivate00* {.pure.} = object
  IOStreamPrivate* = ref object
    impl*: ptr IOStreamPrivate00

type
  IOStream* = ref object of gobject.Object
  IOStream00* = object of gobject.Object00
    priv1: ptr IOStreamPrivate00

proc g_io_stream_splice_finish*(resu: ptr AsyncResult00): gboolean {.
    importc: "g_io_stream_splice_finish", libprag.}

proc spliceFinish*(resu: AsyncResult): bool =
  toBool(g_io_stream_splice_finish(cast[ptr AsyncResult00](resu.impl)))

proc g_io_stream_clear_pending*(self: ptr IOStream00) {.
    importc: "g_io_stream_clear_pending", libprag.}

proc clearPending*(self: IOStream) =
  g_io_stream_clear_pending(cast[ptr IOStream00](self.impl))

proc g_io_stream_close*(self: ptr IOStream00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_io_stream_close", libprag.}

proc close*(self: IOStream; cancellable: Cancellable): bool =
  toBool(g_io_stream_close(cast[ptr IOStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_io_stream_close_finish*(self: ptr IOStream00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_io_stream_close_finish", libprag.}

proc closeFinish*(self: IOStream; resu: AsyncResult): bool =
  toBool(g_io_stream_close_finish(cast[ptr IOStream00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_io_stream_get_output_stream*(self: ptr IOStream00): ptr OutputStream00 {.
    importc: "g_io_stream_get_output_stream", libprag.}

proc getOutputStream*(self: IOStream): OutputStream =
  let gobj = g_io_stream_get_output_stream(cast[ptr IOStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc outputStream*(self: IOStream): OutputStream =
  let gobj = g_io_stream_get_output_stream(cast[ptr IOStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_io_stream_has_pending*(self: ptr IOStream00): gboolean {.
    importc: "g_io_stream_has_pending", libprag.}

proc hasPending*(self: IOStream): bool =
  toBool(g_io_stream_has_pending(cast[ptr IOStream00](self.impl)))

proc g_io_stream_is_closed*(self: ptr IOStream00): gboolean {.
    importc: "g_io_stream_is_closed", libprag.}

proc isClosed*(self: IOStream): bool =
  toBool(g_io_stream_is_closed(cast[ptr IOStream00](self.impl)))

proc g_io_stream_set_pending*(self: ptr IOStream00): gboolean {.
    importc: "g_io_stream_set_pending", libprag.}

proc setPending*(self: IOStream): bool =
  toBool(g_io_stream_set_pending(cast[ptr IOStream00](self.impl)))

proc `pending=`*(self: IOStream): bool =
  toBool(g_io_stream_set_pending(cast[ptr IOStream00](self.impl)))

type
  FileIOStreamPrivate00* {.pure.} = object
  FileIOStreamPrivate* = ref object
    impl*: ptr FileIOStreamPrivate00

type
  FileIOStream* = ref object of IOStream
  FileIOStream00* = object of IOStream00
    priv2: ptr FileIOStreamPrivate00

proc g_file_io_stream_get_etag*(self: ptr FileIOStream00): cstring {.
    importc: "g_file_io_stream_get_etag", libprag.}

proc getEtag*(self: FileIOStream): string =
  let resul0 = g_file_io_stream_get_etag(cast[ptr FileIOStream00](self.impl))
  result = $resul0
  cogfree(resul0)

proc etag*(self: FileIOStream): string =
  let resul0 = g_file_io_stream_get_etag(cast[ptr FileIOStream00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_new_tmp*(tmpl: ucstring; iostream: var ptr FileIOStream00): ptr File00 {.
    importc: "g_file_new_tmp", libprag.}

proc newTmp*(tmpl: ucstring; iostream: var ptr FileIOStream00): ptr File00 {.
    importc: "g_file_new_tmp", libprag.}

proc g_file_create_readwrite*(self: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileIOStream00 {.
    importc: "g_file_create_readwrite", libprag.}

proc createReadwrite*(self: File; flags: FileCreateFlags; cancellable: Cancellable): FileIOStream =
  let gobj = g_file_create_readwrite(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_create_readwrite_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.
    importc: "g_file_create_readwrite_finish", libprag.}

proc createReadwriteFinish*(self: File; res: AsyncResult): FileIOStream =
  let gobj = g_file_create_readwrite_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_open_readwrite*(self: ptr File00; cancellable: ptr Cancellable00): ptr FileIOStream00 {.
    importc: "g_file_open_readwrite", libprag.}

proc openReadwrite*(self: File; cancellable: Cancellable): FileIOStream =
  let gobj = g_file_open_readwrite(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_open_readwrite_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.
    importc: "g_file_open_readwrite_finish", libprag.}

proc openReadwriteFinish*(self: File; res: AsyncResult): FileIOStream =
  let gobj = g_file_open_readwrite_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_replace_readwrite*(self: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileIOStream00 {.
    importc: "g_file_replace_readwrite", libprag.}

proc replaceReadwrite*(self: File; etag: string; makeBackup: bool; flags: FileCreateFlags; 
    cancellable: Cancellable): FileIOStream =
  let gobj = g_file_replace_readwrite(cast[ptr File00](self.impl), cstring(etag), gboolean(makeBackup), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_replace_readwrite_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.
    importc: "g_file_replace_readwrite_finish", libprag.}

proc replaceReadwriteFinish*(self: File; res: AsyncResult): FileIOStream =
  let gobj = g_file_replace_readwrite_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileIOStream](g_object_get_qdata(gobj, Quark))
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
  IOStreamSpliceFlag* {.size: sizeof(cint), pure.} = enum
    closeStream1 = 1
    closeStream2 = 2
    waitForBoth = 3

  IOStreamSpliceFlags* {.size: sizeof(cint).} = set[IOStreamSpliceFlag]

type
  FileAttributeType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    string = 1
    byteString = 2
    boolean = 3
    uint32 = 4
    int32 = 5
    uint64 = 6
    int64 = 7
    `object` = 8
    stringv = 9

type
  FileAttributeInfoFlag* {.size: sizeof(cint), pure.} = enum
    copyWithFile = 1
    copyWhenMoved = 2

  FileAttributeInfoFlags* {.size: sizeof(cint).} = set[FileAttributeInfoFlag]

type
  FileAttributeInfo00* {.pure.} = object
    name*: cstring
    `type`*: FileAttributeType
    flags*: FileAttributeInfoFlags
  FileAttributeInfo* = ref object
    impl*: ptr FileAttributeInfo00

type
  FileAttributeInfoList00* {.pure.} = object
    infos*: ptr FileAttributeInfo00
    nInfos*: int32
  FileAttributeInfoList* = ref object
    impl*: ptr FileAttributeInfoList00

proc g_file_attribute_info_list_new*(): ptr FileAttributeInfoList00 {.
    importc: "g_file_attribute_info_list_new", libprag.}

proc newFileAttributeInfoList*(): FileAttributeInfoList =
  new(result)
  result.impl = g_file_attribute_info_list_new()

proc initFileAttributeInfoList*[T](result: var T) =
  assert(result is FileAttributeInfoList)
  new(result)
  result.impl = g_file_attribute_info_list_new()

proc g_file_attribute_info_list_add*(self: ptr FileAttributeInfoList00; name: cstring; 
    `type`: FileAttributeType; flags: FileAttributeInfoFlags) {.
    importc: "g_file_attribute_info_list_add", libprag.}

proc add*(self: FileAttributeInfoList; name: string; `type`: FileAttributeType; 
    flags: FileAttributeInfoFlags) =
  g_file_attribute_info_list_add(cast[ptr FileAttributeInfoList00](self.impl), cstring(name), `type`, flags)

proc g_file_attribute_info_list_dup*(self: ptr FileAttributeInfoList00): ptr FileAttributeInfoList00 {.
    importc: "g_file_attribute_info_list_dup", libprag.}

proc dup*(self: FileAttributeInfoList): FileAttributeInfoList =
  new(result)
  result.impl = g_file_attribute_info_list_dup(cast[ptr FileAttributeInfoList00](self.impl))

proc g_file_attribute_info_list_lookup*(self: ptr FileAttributeInfoList00; name: cstring): ptr FileAttributeInfo00 {.
    importc: "g_file_attribute_info_list_lookup", libprag.}

proc lookup*(self: FileAttributeInfoList; name: string): FileAttributeInfo =
  new(result)
  result.impl = g_file_attribute_info_list_lookup(cast[ptr FileAttributeInfoList00](self.impl), cstring(name))

proc g_file_attribute_info_list_ref*(self: ptr FileAttributeInfoList00): ptr FileAttributeInfoList00 {.
    importc: "g_file_attribute_info_list_ref", libprag.}

proc `ref`*(self: FileAttributeInfoList): FileAttributeInfoList =
  new(result)
  result.impl = g_file_attribute_info_list_ref(cast[ptr FileAttributeInfoList00](self.impl))

proc g_file_attribute_info_list_unref*(self: ptr FileAttributeInfoList00) {.
    importc: "g_file_attribute_info_list_unref", libprag.}

proc unref*(self: FileAttributeInfoList) =
  g_file_attribute_info_list_unref(cast[ptr FileAttributeInfoList00](self.impl))

proc g_file_query_settable_attributes*(self: ptr File00; cancellable: ptr Cancellable00): ptr FileAttributeInfoList00 {.
    importc: "g_file_query_settable_attributes", libprag.}

proc querySettableAttributes*(self: File; cancellable: Cancellable): FileAttributeInfoList =
  new(result)
  result.impl = g_file_query_settable_attributes(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_file_query_writable_namespaces*(self: ptr File00; cancellable: ptr Cancellable00): ptr FileAttributeInfoList00 {.
    importc: "g_file_query_writable_namespaces", libprag.}

proc queryWritableNamespaces*(self: File; cancellable: Cancellable): FileAttributeInfoList =
  new(result)
  result.impl = g_file_query_writable_namespaces(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))

type
  FileQueryInfoFlag* {.size: sizeof(cint), pure.} = enum
    nofollowSymlinks = 1

  FileQueryInfoFlags* {.size: sizeof(cint).} = set[FileQueryInfoFlag]

proc g_file_enumerate_children*(self: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): ptr FileEnumerator00 {.
    importc: "g_file_enumerate_children", libprag.}

proc enumerateChildren*(self: File; attributes: string; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): FileEnumerator =
  let gobj = g_file_enumerate_children(cast[ptr File00](self.impl), cstring(attributes), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileEnumerator](g_object_get_qdata(gobj, Quark))
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

proc g_file_set_attribute*(self: ptr File00; attribute: cstring; `type`: FileAttributeType; 
    valueP: pointer; flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute", libprag.}

proc setAttribute*(self: File; attribute: string; `type`: FileAttributeType; 
    valueP: pointer; flags: FileQueryInfoFlags; cancellable: Cancellable): bool =
  toBool(g_file_set_attribute(cast[ptr File00](self.impl), cstring(attribute), `type`, valueP, flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_byte_string*(self: ptr File00; attribute: cstring; value: cstring; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_byte_string", libprag.}

proc setAttributeByteString*(self: File; attribute: string; value: string; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_byte_string(cast[ptr File00](self.impl), cstring(attribute), cstring(value), flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_int32*(self: ptr File00; attribute: cstring; value: int32; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_int32", libprag.}

proc setAttributeInt32*(self: File; attribute: string; value: int; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_int32(cast[ptr File00](self.impl), cstring(attribute), int32(value), flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_int64*(self: ptr File00; attribute: cstring; value: int64; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_int64", libprag.}

proc setAttributeInt64*(self: File; attribute: string; value: int64; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_int64(cast[ptr File00](self.impl), cstring(attribute), value, flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_string*(self: ptr File00; attribute: cstring; value: cstring; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_string", libprag.}

proc setAttributeString*(self: File; attribute: string; value: string; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_string(cast[ptr File00](self.impl), cstring(attribute), cstring(value), flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_uint32*(self: ptr File00; attribute: cstring; value: uint32; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_uint32", libprag.}

proc setAttributeUint32*(self: File; attribute: string; value: int; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_uint32(cast[ptr File00](self.impl), cstring(attribute), uint32(value), flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_set_attribute_uint64*(self: ptr File00; attribute: cstring; value: uint64; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attribute_uint64", libprag.}

proc setAttributeUint64*(self: File; attribute: string; value: uint64; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attribute_uint64(cast[ptr File00](self.impl), cstring(attribute), value, flags, cast[ptr Cancellable00](cancellable.impl)))

type
  FileType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    regular = 1
    directory = 2
    symbolicLink = 3
    special = 4
    shortcut = 5
    mountable = 6

proc g_file_query_file_type*(self: ptr File00; flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): FileType {.
    importc: "g_file_query_file_type", libprag.}

proc queryFileType*(self: File; flags: FileQueryInfoFlags; cancellable: Cancellable): FileType =
  g_file_query_file_type(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl))

type
  FileInfo* = ref object of gobject.Object
  FileInfo00* = object of gobject.Object00

proc g_file_info_new*(): ptr FileInfo00 {.
    importc: "g_file_info_new", libprag.}

proc newFileInfo*(): FileInfo =
  new(result, finalizeGObject)
  result.impl = g_file_info_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileInfo*[T](result: var T) =
  assert(result is FileInfo)
  new(result, finalizeGObject)
  result.impl = g_file_info_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_file_info_clear_status*(self: ptr FileInfo00) {.
    importc: "g_file_info_clear_status", libprag.}

proc clearStatus*(self: FileInfo) =
  g_file_info_clear_status(cast[ptr FileInfo00](self.impl))

proc g_file_info_copy_into*(self: ptr FileInfo00; destInfo: ptr FileInfo00) {.
    importc: "g_file_info_copy_into", libprag.}

proc copyInto*(self: FileInfo; destInfo: FileInfo) =
  g_file_info_copy_into(cast[ptr FileInfo00](self.impl), cast[ptr FileInfo00](destInfo.impl))

proc g_file_info_dup*(self: ptr FileInfo00): ptr FileInfo00 {.
    importc: "g_file_info_dup", libprag.}

proc dup*(self: FileInfo): FileInfo =
  let gobj = g_file_info_dup(cast[ptr FileInfo00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_info_get_attribute_as_string*(self: ptr FileInfo00; attribute: cstring): cstring {.
    importc: "g_file_info_get_attribute_as_string", libprag.}

proc getAttributeAsString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_as_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0
  cogfree(resul0)

proc attributeAsString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_as_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0
  cogfree(resul0)

proc g_file_info_get_attribute_boolean*(self: ptr FileInfo00; attribute: cstring): gboolean {.
    importc: "g_file_info_get_attribute_boolean", libprag.}

proc getAttributeBoolean*(self: FileInfo; attribute: string): bool =
  toBool(g_file_info_get_attribute_boolean(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc attributeBoolean*(self: FileInfo; attribute: string): bool =
  toBool(g_file_info_get_attribute_boolean(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc g_file_info_get_attribute_byte_string*(self: ptr FileInfo00; attribute: cstring): cstring {.
    importc: "g_file_info_get_attribute_byte_string", libprag.}

proc getAttributeByteString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_byte_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0

proc attributeByteString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_byte_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0

proc g_file_info_get_attribute_int32*(self: ptr FileInfo00; attribute: cstring): int32 {.
    importc: "g_file_info_get_attribute_int32", libprag.}

proc getAttributeInt32*(self: FileInfo; attribute: string): int =
  int(g_file_info_get_attribute_int32(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc attributeInt32*(self: FileInfo; attribute: string): int =
  int(g_file_info_get_attribute_int32(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc g_file_info_get_attribute_int64*(self: ptr FileInfo00; attribute: cstring): int64 {.
    importc: "g_file_info_get_attribute_int64", libprag.}

proc getAttributeInt64*(self: FileInfo; attribute: string): int64 =
  g_file_info_get_attribute_int64(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc attributeInt64*(self: FileInfo; attribute: string): int64 =
  g_file_info_get_attribute_int64(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_get_attribute_object*(self: ptr FileInfo00; attribute: cstring): ptr gobject.Object00 {.
    importc: "g_file_info_get_attribute_object", libprag.}

proc getAttributeObject*(self: FileInfo; attribute: string): gobject.Object =
  let gobj = g_file_info_get_attribute_object(cast[ptr FileInfo00](self.impl), cstring(attribute))
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

proc attributeObject*(self: FileInfo; attribute: string): gobject.Object =
  let gobj = g_file_info_get_attribute_object(cast[ptr FileInfo00](self.impl), cstring(attribute))
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

proc g_file_info_get_attribute_string*(self: ptr FileInfo00; attribute: cstring): cstring {.
    importc: "g_file_info_get_attribute_string", libprag.}

proc getAttributeString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0

proc attributeString*(self: FileInfo; attribute: string): string =
  let resul0 = g_file_info_get_attribute_string(cast[ptr FileInfo00](self.impl), cstring(attribute))
  result = $resul0

proc g_file_info_get_attribute_stringv*(self: ptr FileInfo00; attribute: cstring): cstringArray {.
    importc: "g_file_info_get_attribute_stringv", libprag.}

proc getAttributeStringv*(self: FileInfo; attribute: string): cstringArray =
  g_file_info_get_attribute_stringv(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc attributeStringv*(self: FileInfo; attribute: string): cstringArray =
  g_file_info_get_attribute_stringv(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_get_attribute_type*(self: ptr FileInfo00; attribute: cstring): FileAttributeType {.
    importc: "g_file_info_get_attribute_type", libprag.}

proc getAttributeType*(self: FileInfo; attribute: string): FileAttributeType =
  g_file_info_get_attribute_type(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc attributeType*(self: FileInfo; attribute: string): FileAttributeType =
  g_file_info_get_attribute_type(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_get_attribute_uint32*(self: ptr FileInfo00; attribute: cstring): uint32 {.
    importc: "g_file_info_get_attribute_uint32", libprag.}

proc getAttributeUint32*(self: FileInfo; attribute: string): int =
  int(g_file_info_get_attribute_uint32(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc attributeUint32*(self: FileInfo; attribute: string): int =
  int(g_file_info_get_attribute_uint32(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc g_file_info_get_attribute_uint64*(self: ptr FileInfo00; attribute: cstring): uint64 {.
    importc: "g_file_info_get_attribute_uint64", libprag.}

proc getAttributeUint64*(self: FileInfo; attribute: string): uint64 =
  g_file_info_get_attribute_uint64(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc attributeUint64*(self: FileInfo; attribute: string): uint64 =
  g_file_info_get_attribute_uint64(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_get_content_type*(self: ptr FileInfo00): cstring {.
    importc: "g_file_info_get_content_type", libprag.}

proc getContentType*(self: FileInfo): string =
  let resul0 = g_file_info_get_content_type(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc contentType*(self: FileInfo): string =
  let resul0 = g_file_info_get_content_type(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc g_file_info_get_deletion_date*(self: ptr FileInfo00): ptr glib.DateTime00 {.
    importc: "g_file_info_get_deletion_date", libprag.}

proc getDeletionDate*(self: FileInfo): glib.DateTime =
  new(result)
  result.impl = g_file_info_get_deletion_date(cast[ptr FileInfo00](self.impl))

proc deletionDate*(self: FileInfo): glib.DateTime =
  new(result)
  result.impl = g_file_info_get_deletion_date(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_display_name*(self: ptr FileInfo00): cstring {.
    importc: "g_file_info_get_display_name", libprag.}

proc getDisplayName*(self: FileInfo): string =
  let resul0 = g_file_info_get_display_name(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc displayName*(self: FileInfo): string =
  let resul0 = g_file_info_get_display_name(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc g_file_info_get_edit_name*(self: ptr FileInfo00): cstring {.
    importc: "g_file_info_get_edit_name", libprag.}

proc getEditName*(self: FileInfo): string =
  let resul0 = g_file_info_get_edit_name(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc editName*(self: FileInfo): string =
  let resul0 = g_file_info_get_edit_name(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc g_file_info_get_etag*(self: ptr FileInfo00): cstring {.
    importc: "g_file_info_get_etag", libprag.}

proc getEtag*(self: FileInfo): string =
  let resul0 = g_file_info_get_etag(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc etag*(self: FileInfo): string =
  let resul0 = g_file_info_get_etag(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc g_file_info_get_file_type*(self: ptr FileInfo00): FileType {.
    importc: "g_file_info_get_file_type", libprag.}

proc getFileType*(self: FileInfo): FileType =
  g_file_info_get_file_type(cast[ptr FileInfo00](self.impl))

proc fileType*(self: FileInfo): FileType =
  g_file_info_get_file_type(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_icon*(self: ptr FileInfo00): ptr Icon00 {.
    importc: "g_file_info_get_icon", libprag.}

proc getIcon*(self: FileInfo): Icon =
  new(result)
  result.impl = g_file_info_get_icon(cast[ptr FileInfo00](self.impl))

proc icon*(self: FileInfo): Icon =
  new(result)
  result.impl = g_file_info_get_icon(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_is_backup*(self: ptr FileInfo00): gboolean {.
    importc: "g_file_info_get_is_backup", libprag.}

proc getIsBackup*(self: FileInfo): bool =
  toBool(g_file_info_get_is_backup(cast[ptr FileInfo00](self.impl)))

proc isBackup*(self: FileInfo): bool =
  toBool(g_file_info_get_is_backup(cast[ptr FileInfo00](self.impl)))

proc g_file_info_get_is_hidden*(self: ptr FileInfo00): gboolean {.
    importc: "g_file_info_get_is_hidden", libprag.}

proc getIsHidden*(self: FileInfo): bool =
  toBool(g_file_info_get_is_hidden(cast[ptr FileInfo00](self.impl)))

proc isHidden*(self: FileInfo): bool =
  toBool(g_file_info_get_is_hidden(cast[ptr FileInfo00](self.impl)))

proc g_file_info_get_is_symlink*(self: ptr FileInfo00): gboolean {.
    importc: "g_file_info_get_is_symlink", libprag.}

proc getIsSymlink*(self: FileInfo): bool =
  toBool(g_file_info_get_is_symlink(cast[ptr FileInfo00](self.impl)))

proc isSymlink*(self: FileInfo): bool =
  toBool(g_file_info_get_is_symlink(cast[ptr FileInfo00](self.impl)))

proc g_file_info_get_modification_time*(self: ptr FileInfo00; resu: var glib.TimeVal00) {.
    importc: "g_file_info_get_modification_time", libprag.}

proc getModificationTime*(self: ptr FileInfo00; resu: var glib.TimeVal00) {.
    importc: "g_file_info_get_modification_time", libprag.}

proc modificationTime*(self: ptr FileInfo00; resu: var glib.TimeVal00) {.
    importc: "g_file_info_get_modification_time", libprag.}

proc g_file_info_get_name*(self: ptr FileInfo00): ucstring {.
    importc: "g_file_info_get_name", libprag.}

proc getName*(self: FileInfo): ucstring =
  g_file_info_get_name(cast[ptr FileInfo00](self.impl))

proc name*(self: FileInfo): ucstring =
  g_file_info_get_name(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_size*(self: ptr FileInfo00): int64 {.
    importc: "g_file_info_get_size", libprag.}

proc getSize*(self: FileInfo): int64 =
  g_file_info_get_size(cast[ptr FileInfo00](self.impl))

proc size*(self: FileInfo): int64 =
  g_file_info_get_size(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_sort_order*(self: ptr FileInfo00): int32 {.
    importc: "g_file_info_get_sort_order", libprag.}

proc getSortOrder*(self: FileInfo): int =
  int(g_file_info_get_sort_order(cast[ptr FileInfo00](self.impl)))

proc sortOrder*(self: FileInfo): int =
  int(g_file_info_get_sort_order(cast[ptr FileInfo00](self.impl)))

proc g_file_info_get_symbolic_icon*(self: ptr FileInfo00): ptr Icon00 {.
    importc: "g_file_info_get_symbolic_icon", libprag.}

proc getSymbolicIcon*(self: FileInfo): Icon =
  new(result)
  result.impl = g_file_info_get_symbolic_icon(cast[ptr FileInfo00](self.impl))

proc symbolicIcon*(self: FileInfo): Icon =
  new(result)
  result.impl = g_file_info_get_symbolic_icon(cast[ptr FileInfo00](self.impl))

proc g_file_info_get_symlink_target*(self: ptr FileInfo00): cstring {.
    importc: "g_file_info_get_symlink_target", libprag.}

proc getSymlinkTarget*(self: FileInfo): string =
  let resul0 = g_file_info_get_symlink_target(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc symlinkTarget*(self: FileInfo): string =
  let resul0 = g_file_info_get_symlink_target(cast[ptr FileInfo00](self.impl))
  result = $resul0

proc g_file_info_has_attribute*(self: ptr FileInfo00; attribute: cstring): gboolean {.
    importc: "g_file_info_has_attribute", libprag.}

proc hasAttribute*(self: FileInfo; attribute: string): bool =
  toBool(g_file_info_has_attribute(cast[ptr FileInfo00](self.impl), cstring(attribute)))

proc g_file_info_has_namespace*(self: ptr FileInfo00; nameSpace: cstring): gboolean {.
    importc: "g_file_info_has_namespace", libprag.}

proc hasNamespace*(self: FileInfo; nameSpace: string): bool =
  toBool(g_file_info_has_namespace(cast[ptr FileInfo00](self.impl), cstring(nameSpace)))

proc g_file_info_list_attributes*(self: ptr FileInfo00; nameSpace: cstring): cstringArray {.
    importc: "g_file_info_list_attributes", libprag.}

proc listAttributes*(self: FileInfo; nameSpace: string): cstringArray =
  g_file_info_list_attributes(cast[ptr FileInfo00](self.impl), cstring(nameSpace))

proc g_file_info_remove_attribute*(self: ptr FileInfo00; attribute: cstring) {.
    importc: "g_file_info_remove_attribute", libprag.}

proc removeAttribute*(self: FileInfo; attribute: string) =
  g_file_info_remove_attribute(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_set_attribute*(self: ptr FileInfo00; attribute: cstring; `type`: FileAttributeType; 
    valueP: pointer) {.
    importc: "g_file_info_set_attribute", libprag.}

proc setAttribute*(self: FileInfo; attribute: string; `type`: FileAttributeType; 
    valueP: pointer) =
  g_file_info_set_attribute(cast[ptr FileInfo00](self.impl), cstring(attribute), `type`, valueP)

proc g_file_info_set_attribute_boolean*(self: ptr FileInfo00; attribute: cstring; attrValue: gboolean) {.
    importc: "g_file_info_set_attribute_boolean", libprag.}

proc setAttributeBoolean*(self: FileInfo; attribute: string; attrValue: bool) =
  g_file_info_set_attribute_boolean(cast[ptr FileInfo00](self.impl), cstring(attribute), gboolean(attrValue))

proc g_file_info_set_attribute_byte_string*(self: ptr FileInfo00; attribute: cstring; attrValue: cstring) {.
    importc: "g_file_info_set_attribute_byte_string", libprag.}

proc setAttributeByteString*(self: FileInfo; attribute: string; attrValue: string) =
  g_file_info_set_attribute_byte_string(cast[ptr FileInfo00](self.impl), cstring(attribute), cstring(attrValue))

proc g_file_info_set_attribute_int32*(self: ptr FileInfo00; attribute: cstring; attrValue: int32) {.
    importc: "g_file_info_set_attribute_int32", libprag.}

proc setAttributeInt32*(self: FileInfo; attribute: string; attrValue: int) =
  g_file_info_set_attribute_int32(cast[ptr FileInfo00](self.impl), cstring(attribute), int32(attrValue))

proc g_file_info_set_attribute_int64*(self: ptr FileInfo00; attribute: cstring; attrValue: int64) {.
    importc: "g_file_info_set_attribute_int64", libprag.}

proc setAttributeInt64*(self: FileInfo; attribute: string; attrValue: int64) =
  g_file_info_set_attribute_int64(cast[ptr FileInfo00](self.impl), cstring(attribute), attrValue)

proc g_file_info_set_attribute_object*(self: ptr FileInfo00; attribute: cstring; attrValue: ptr gobject.Object00) {.
    importc: "g_file_info_set_attribute_object", libprag.}

proc setAttributeObject*(self: FileInfo; attribute: string; attrValue: gobject.Object) =
  g_file_info_set_attribute_object(cast[ptr FileInfo00](self.impl), cstring(attribute), cast[ptr gobject.Object00](attrValue.impl))

proc g_file_info_set_attribute_string*(self: ptr FileInfo00; attribute: cstring; attrValue: cstring) {.
    importc: "g_file_info_set_attribute_string", libprag.}

proc setAttributeString*(self: FileInfo; attribute: string; attrValue: string) =
  g_file_info_set_attribute_string(cast[ptr FileInfo00](self.impl), cstring(attribute), cstring(attrValue))

proc g_file_info_set_attribute_stringv*(self: ptr FileInfo00; attribute: cstring; attrValue: cstringArray) {.
    importc: "g_file_info_set_attribute_stringv", libprag.}

proc setAttributeStringv*(self: FileInfo; attribute: string; attrValue: cstringArray) =
  g_file_info_set_attribute_stringv(cast[ptr FileInfo00](self.impl), cstring(attribute), attrValue)

proc g_file_info_set_attribute_uint32*(self: ptr FileInfo00; attribute: cstring; attrValue: uint32) {.
    importc: "g_file_info_set_attribute_uint32", libprag.}

proc setAttributeUint32*(self: FileInfo; attribute: string; attrValue: int) =
  g_file_info_set_attribute_uint32(cast[ptr FileInfo00](self.impl), cstring(attribute), uint32(attrValue))

proc g_file_info_set_attribute_uint64*(self: ptr FileInfo00; attribute: cstring; attrValue: uint64) {.
    importc: "g_file_info_set_attribute_uint64", libprag.}

proc setAttributeUint64*(self: FileInfo; attribute: string; attrValue: uint64) =
  g_file_info_set_attribute_uint64(cast[ptr FileInfo00](self.impl), cstring(attribute), attrValue)

proc g_file_info_set_content_type*(self: ptr FileInfo00; contentType: cstring) {.
    importc: "g_file_info_set_content_type", libprag.}

proc setContentType*(self: FileInfo; contentType: string) =
  g_file_info_set_content_type(cast[ptr FileInfo00](self.impl), cstring(contentType))

proc `contentType=`*(self: FileInfo; contentType: string) =
  g_file_info_set_content_type(cast[ptr FileInfo00](self.impl), cstring(contentType))

proc g_file_info_set_display_name*(self: ptr FileInfo00; displayName: cstring) {.
    importc: "g_file_info_set_display_name", libprag.}

proc setDisplayName*(self: FileInfo; displayName: string) =
  g_file_info_set_display_name(cast[ptr FileInfo00](self.impl), cstring(displayName))

proc `displayName=`*(self: FileInfo; displayName: string) =
  g_file_info_set_display_name(cast[ptr FileInfo00](self.impl), cstring(displayName))

proc g_file_info_set_edit_name*(self: ptr FileInfo00; editName: cstring) {.
    importc: "g_file_info_set_edit_name", libprag.}

proc setEditName*(self: FileInfo; editName: string) =
  g_file_info_set_edit_name(cast[ptr FileInfo00](self.impl), cstring(editName))

proc `editName=`*(self: FileInfo; editName: string) =
  g_file_info_set_edit_name(cast[ptr FileInfo00](self.impl), cstring(editName))

proc g_file_info_set_file_type*(self: ptr FileInfo00; `type`: FileType) {.
    importc: "g_file_info_set_file_type", libprag.}

proc setFileType*(self: FileInfo; `type`: FileType) =
  g_file_info_set_file_type(cast[ptr FileInfo00](self.impl), `type`)

proc `fileType=`*(self: FileInfo; `type`: FileType) =
  g_file_info_set_file_type(cast[ptr FileInfo00](self.impl), `type`)

proc g_file_info_set_icon*(self: ptr FileInfo00; icon: ptr Icon00) {.
    importc: "g_file_info_set_icon", libprag.}

proc setIcon*(self: FileInfo; icon: Icon) =
  g_file_info_set_icon(cast[ptr FileInfo00](self.impl), cast[ptr Icon00](icon.impl))

proc `icon=`*(self: FileInfo; icon: Icon) =
  g_file_info_set_icon(cast[ptr FileInfo00](self.impl), cast[ptr Icon00](icon.impl))

proc g_file_info_set_is_hidden*(self: ptr FileInfo00; isHidden: gboolean) {.
    importc: "g_file_info_set_is_hidden", libprag.}

proc setIsHidden*(self: FileInfo; isHidden: bool) =
  g_file_info_set_is_hidden(cast[ptr FileInfo00](self.impl), gboolean(isHidden))

proc `isHidden=`*(self: FileInfo; isHidden: bool) =
  g_file_info_set_is_hidden(cast[ptr FileInfo00](self.impl), gboolean(isHidden))

proc g_file_info_set_is_symlink*(self: ptr FileInfo00; isSymlink: gboolean) {.
    importc: "g_file_info_set_is_symlink", libprag.}

proc setIsSymlink*(self: FileInfo; isSymlink: bool) =
  g_file_info_set_is_symlink(cast[ptr FileInfo00](self.impl), gboolean(isSymlink))

proc `isSymlink=`*(self: FileInfo; isSymlink: bool) =
  g_file_info_set_is_symlink(cast[ptr FileInfo00](self.impl), gboolean(isSymlink))

proc g_file_info_set_modification_time*(self: ptr FileInfo00; mtime: ptr glib.TimeVal00) {.
    importc: "g_file_info_set_modification_time", libprag.}

proc setModificationTime*(self: FileInfo; mtime: glib.TimeVal) =
  g_file_info_set_modification_time(cast[ptr FileInfo00](self.impl), cast[ptr glib.TimeVal00](mtime.impl))

proc `modificationTime=`*(self: FileInfo; mtime: glib.TimeVal) =
  g_file_info_set_modification_time(cast[ptr FileInfo00](self.impl), cast[ptr glib.TimeVal00](mtime.impl))

proc g_file_info_set_name*(self: ptr FileInfo00; name: ucstring) {.
    importc: "g_file_info_set_name", libprag.}

proc setName*(self: FileInfo; name: ucstring) =
  g_file_info_set_name(cast[ptr FileInfo00](self.impl), name)

proc `name=`*(self: FileInfo; name: ucstring) =
  g_file_info_set_name(cast[ptr FileInfo00](self.impl), name)

proc g_file_info_set_size*(self: ptr FileInfo00; size: int64) {.
    importc: "g_file_info_set_size", libprag.}

proc setSize*(self: FileInfo; size: int64) =
  g_file_info_set_size(cast[ptr FileInfo00](self.impl), size)

proc `size=`*(self: FileInfo; size: int64) =
  g_file_info_set_size(cast[ptr FileInfo00](self.impl), size)

proc g_file_info_set_sort_order*(self: ptr FileInfo00; sortOrder: int32) {.
    importc: "g_file_info_set_sort_order", libprag.}

proc setSortOrder*(self: FileInfo; sortOrder: int) =
  g_file_info_set_sort_order(cast[ptr FileInfo00](self.impl), int32(sortOrder))

proc `sortOrder=`*(self: FileInfo; sortOrder: int) =
  g_file_info_set_sort_order(cast[ptr FileInfo00](self.impl), int32(sortOrder))

proc g_file_info_set_symbolic_icon*(self: ptr FileInfo00; icon: ptr Icon00) {.
    importc: "g_file_info_set_symbolic_icon", libprag.}

proc setSymbolicIcon*(self: FileInfo; icon: Icon) =
  g_file_info_set_symbolic_icon(cast[ptr FileInfo00](self.impl), cast[ptr Icon00](icon.impl))

proc `symbolicIcon=`*(self: FileInfo; icon: Icon) =
  g_file_info_set_symbolic_icon(cast[ptr FileInfo00](self.impl), cast[ptr Icon00](icon.impl))

proc g_file_info_set_symlink_target*(self: ptr FileInfo00; symlinkTarget: cstring) {.
    importc: "g_file_info_set_symlink_target", libprag.}

proc setSymlinkTarget*(self: FileInfo; symlinkTarget: string) =
  g_file_info_set_symlink_target(cast[ptr FileInfo00](self.impl), cstring(symlinkTarget))

proc `symlinkTarget=`*(self: FileInfo; symlinkTarget: string) =
  g_file_info_set_symlink_target(cast[ptr FileInfo00](self.impl), cstring(symlinkTarget))

proc g_file_info_unset_attribute_mask*(self: ptr FileInfo00) {.
    importc: "g_file_info_unset_attribute_mask", libprag.}

proc unsetAttributeMask*(self: FileInfo) =
  g_file_info_unset_attribute_mask(cast[ptr FileInfo00](self.impl))

proc g_file_query_filesystem_info*(self: ptr File00; attributes: cstring; cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_query_filesystem_info", libprag.}

proc queryFilesystemInfo*(self: File; attributes: string; cancellable: Cancellable): FileInfo =
  let gobj = g_file_query_filesystem_info(cast[ptr File00](self.impl), cstring(attributes), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_query_filesystem_info_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileInfo00 {.
    importc: "g_file_query_filesystem_info_finish", libprag.}

proc queryFilesystemInfoFinish*(self: File; res: AsyncResult): FileInfo =
  let gobj = g_file_query_filesystem_info_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_query_info*(self: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_query_info", libprag.}

proc queryInfo*(self: File; attributes: string; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): FileInfo =
  let gobj = g_file_query_info(cast[ptr File00](self.impl), cstring(attributes), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_query_info_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileInfo00 {.
    importc: "g_file_query_info_finish", libprag.}

proc queryInfoFinish*(self: File; res: AsyncResult): FileInfo =
  let gobj = g_file_query_info_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_set_attributes_finish*(self: ptr File00; resu: ptr AsyncResult00; info: var ptr FileInfo00): gboolean {.
    importc: "g_file_set_attributes_finish", libprag.}

proc setAttributesFinish*(self: ptr File00; resu: ptr AsyncResult00; info: var ptr FileInfo00): gboolean {.
    importc: "g_file_set_attributes_finish", libprag.}

proc g_file_set_attributes_from_info*(self: ptr File00; info: ptr FileInfo00; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_set_attributes_from_info", libprag.}

proc setAttributesFromInfo*(self: File; info: FileInfo; flags: FileQueryInfoFlags; 
    cancellable: Cancellable): bool =
  toBool(g_file_set_attributes_from_info(cast[ptr File00](self.impl), cast[ptr FileInfo00](info.impl), flags, cast[ptr Cancellable00](cancellable.impl)))

proc g_file_enumerator_get_child*(self: ptr FileEnumerator00; info: ptr FileInfo00): ptr File00 {.
    importc: "g_file_enumerator_get_child", libprag.}

proc getChild*(self: FileEnumerator; info: FileInfo): File =
  new(result)
  result.impl = g_file_enumerator_get_child(cast[ptr FileEnumerator00](self.impl), cast[ptr FileInfo00](info.impl))

proc child*(self: FileEnumerator; info: FileInfo): File =
  new(result)
  result.impl = g_file_enumerator_get_child(cast[ptr FileEnumerator00](self.impl), cast[ptr FileInfo00](info.impl))

proc g_file_enumerator_iterate*(self: ptr FileEnumerator00; outInfo: var ptr FileInfo00; 
    outChild: var ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_enumerator_iterate", libprag.}

proc iterate*(self: ptr FileEnumerator00; outInfo: var ptr FileInfo00; 
    outChild: var ptr File00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_file_enumerator_iterate", libprag.}

proc g_file_enumerator_next_file*(self: ptr FileEnumerator00; cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_enumerator_next_file", libprag.}

proc nextFile*(self: FileEnumerator; cancellable: Cancellable): FileInfo =
  let gobj = g_file_enumerator_next_file(cast[ptr FileEnumerator00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_output_stream_query_info*(self: ptr FileOutputStream00; attributes: cstring; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_output_stream_query_info", libprag.}

proc queryInfo*(self: FileOutputStream; attributes: string; cancellable: Cancellable): FileInfo =
  let gobj = g_file_output_stream_query_info(cast[ptr FileOutputStream00](self.impl), cstring(attributes), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_output_stream_query_info_finish*(self: ptr FileOutputStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.
    importc: "g_file_output_stream_query_info_finish", libprag.}

proc queryInfoFinish*(self: FileOutputStream; resu: AsyncResult): FileInfo =
  let gobj = g_file_output_stream_query_info_finish(cast[ptr FileOutputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_io_stream_query_info*(self: ptr FileIOStream00; attributes: cstring; cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_io_stream_query_info", libprag.}

proc queryInfo*(self: FileIOStream; attributes: string; cancellable: Cancellable): FileInfo =
  let gobj = g_file_io_stream_query_info(cast[ptr FileIOStream00](self.impl), cstring(attributes), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_io_stream_query_info_finish*(self: ptr FileIOStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.
    importc: "g_file_io_stream_query_info_finish", libprag.}

proc queryInfoFinish*(self: FileIOStream; resu: AsyncResult): FileInfo =
  let gobj = g_file_io_stream_query_info_finish(cast[ptr FileIOStream00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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
  FileAttributeMatcher00* {.pure.} = object
  FileAttributeMatcher* = ref object
    impl*: ptr FileAttributeMatcher00

proc g_file_attribute_matcher_new*(attributes: cstring): ptr FileAttributeMatcher00 {.
    importc: "g_file_attribute_matcher_new", libprag.}

proc newFileAttributeMatcher*(attributes: string): FileAttributeMatcher =
  new(result)
  result.impl = g_file_attribute_matcher_new(cstring(attributes))

proc initFileAttributeMatcher*[T](result: var T; attributes: string) =
  assert(result is FileAttributeMatcher)
  new(result)
  result.impl = g_file_attribute_matcher_new(cstring(attributes))

proc g_file_attribute_matcher_enumerate_namespace*(self: ptr FileAttributeMatcher00; ns: cstring): gboolean {.
    importc: "g_file_attribute_matcher_enumerate_namespace", libprag.}

proc enumerateNamespace*(self: FileAttributeMatcher; ns: string): bool =
  toBool(g_file_attribute_matcher_enumerate_namespace(cast[ptr FileAttributeMatcher00](self.impl), cstring(ns)))

proc g_file_attribute_matcher_enumerate_next*(self: ptr FileAttributeMatcher00): cstring {.
    importc: "g_file_attribute_matcher_enumerate_next", libprag.}

proc enumerateNext*(self: FileAttributeMatcher): string =
  let resul0 = g_file_attribute_matcher_enumerate_next(cast[ptr FileAttributeMatcher00](self.impl))
  result = $resul0

proc g_file_attribute_matcher_matches*(self: ptr FileAttributeMatcher00; attribute: cstring): gboolean {.
    importc: "g_file_attribute_matcher_matches", libprag.}

proc matches*(self: FileAttributeMatcher; attribute: string): bool =
  toBool(g_file_attribute_matcher_matches(cast[ptr FileAttributeMatcher00](self.impl), cstring(attribute)))

proc g_file_attribute_matcher_matches_only*(self: ptr FileAttributeMatcher00; attribute: cstring): gboolean {.
    importc: "g_file_attribute_matcher_matches_only", libprag.}

proc matchesOnly*(self: FileAttributeMatcher; attribute: string): bool =
  toBool(g_file_attribute_matcher_matches_only(cast[ptr FileAttributeMatcher00](self.impl), cstring(attribute)))

proc g_file_attribute_matcher_ref*(self: ptr FileAttributeMatcher00): ptr FileAttributeMatcher00 {.
    importc: "g_file_attribute_matcher_ref", libprag.}

proc `ref`*(self: FileAttributeMatcher): FileAttributeMatcher =
  new(result)
  result.impl = g_file_attribute_matcher_ref(cast[ptr FileAttributeMatcher00](self.impl))

proc g_file_attribute_matcher_subtract*(self: ptr FileAttributeMatcher00; subtract: ptr FileAttributeMatcher00): ptr FileAttributeMatcher00 {.
    importc: "g_file_attribute_matcher_subtract", libprag.}

proc subtract*(self: FileAttributeMatcher; subtract: FileAttributeMatcher): FileAttributeMatcher =
  new(result)
  result.impl = g_file_attribute_matcher_subtract(cast[ptr FileAttributeMatcher00](self.impl), cast[ptr FileAttributeMatcher00](subtract.impl))

proc g_file_attribute_matcher_to_string*(self: ptr FileAttributeMatcher00): cstring {.
    importc: "g_file_attribute_matcher_to_string", libprag.}

proc toString*(self: FileAttributeMatcher): string =
  let resul0 = g_file_attribute_matcher_to_string(cast[ptr FileAttributeMatcher00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_file_attribute_matcher_unref*(self: ptr FileAttributeMatcher00) {.
    importc: "g_file_attribute_matcher_unref", libprag.}

proc unref*(self: FileAttributeMatcher) =
  g_file_attribute_matcher_unref(cast[ptr FileAttributeMatcher00](self.impl))

proc g_file_info_set_attribute_mask*(self: ptr FileInfo00; mask: ptr FileAttributeMatcher00) {.
    importc: "g_file_info_set_attribute_mask", libprag.}

proc setAttributeMask*(self: FileInfo; mask: FileAttributeMatcher) =
  g_file_info_set_attribute_mask(cast[ptr FileInfo00](self.impl), cast[ptr FileAttributeMatcher00](mask.impl))

proc `attributeMask=`*(self: FileInfo; mask: FileAttributeMatcher) =
  g_file_info_set_attribute_mask(cast[ptr FileInfo00](self.impl), cast[ptr FileAttributeMatcher00](mask.impl))

type
  FileAttributeStatus* {.size: sizeof(cint), pure.} = enum
    unset = 0
    set = 1
    errorSetting = 2

proc g_file_info_get_attribute_data*(self: ptr FileInfo00; attribute: cstring; `type`: var FileAttributeType; 
    valuePp: var pointer; status: var FileAttributeStatus): gboolean {.
    importc: "g_file_info_get_attribute_data", libprag.}

proc getAttributeData*(self: FileInfo; attribute: string; `type`: var FileAttributeType; 
    valuePp: var pointer; status: var FileAttributeStatus): bool =
  toBool(g_file_info_get_attribute_data(cast[ptr FileInfo00](self.impl), cstring(attribute), `type`, valuePp, status))

proc attributeData*(self: FileInfo; attribute: string; `type`: var FileAttributeType; 
    valuePp: var pointer; status: var FileAttributeStatus): bool =
  toBool(g_file_info_get_attribute_data(cast[ptr FileInfo00](self.impl), cstring(attribute), `type`, valuePp, status))

proc g_file_info_get_attribute_status*(self: ptr FileInfo00; attribute: cstring): FileAttributeStatus {.
    importc: "g_file_info_get_attribute_status", libprag.}

proc getAttributeStatus*(self: FileInfo; attribute: string): FileAttributeStatus =
  g_file_info_get_attribute_status(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc attributeStatus*(self: FileInfo; attribute: string): FileAttributeStatus =
  g_file_info_get_attribute_status(cast[ptr FileInfo00](self.impl), cstring(attribute))

proc g_file_info_set_attribute_status*(self: ptr FileInfo00; attribute: cstring; status: FileAttributeStatus): gboolean {.
    importc: "g_file_info_set_attribute_status", libprag.}

proc setAttributeStatus*(self: FileInfo; attribute: string; status: FileAttributeStatus): bool =
  toBool(g_file_info_set_attribute_status(cast[ptr FileInfo00](self.impl), cstring(attribute), status))

type
  DriveStartFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

type
  MountUnmountFlag* {.size: sizeof(cint), pure.} = enum
    force = 1

  MountUnmountFlags* {.size: sizeof(cint).} = set[MountUnmountFlag]

type
  DBusConnection* = ref object of gobject.Object
  DBusConnection00* = object of gobject.Object00

proc scClosed*(self: DBusConnection;  p: proc (self: ptr gobject.Object00; remotePeerVanished: gboolean; error: ptr Error00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "closed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_connection_new_finish*(res: ptr AsyncResult00): ptr DBusConnection00 {.
    importc: "g_dbus_connection_new_finish", libprag.}

proc newDBusConnectionFinish*(res: AsyncResult): DBusConnection =
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusConnectionFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusConnection)
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_connection_new_for_address_finish*(res: ptr AsyncResult00): ptr DBusConnection00 {.
    importc: "g_dbus_connection_new_for_address_finish", libprag.}

proc newDBusConnectionForAddressFinish*(res: AsyncResult): DBusConnection =
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_for_address_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusConnectionForAddressFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusConnection)
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_for_address_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_connection_call_finish*(self: ptr DBusConnection00; res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_finish", libprag.}

proc callFinish*(self: DBusConnection; res: AsyncResult): glib.Variant =
  new(result)
  result.impl = g_dbus_connection_call_finish(cast[ptr DBusConnection00](self.impl), cast[ptr AsyncResult00](res.impl))

proc g_dbus_connection_close_finish*(self: ptr DBusConnection00; res: ptr AsyncResult00): gboolean {.
    importc: "g_dbus_connection_close_finish", libprag.}

proc closeFinish*(self: DBusConnection; res: AsyncResult): bool =
  toBool(g_dbus_connection_close_finish(cast[ptr DBusConnection00](self.impl), cast[ptr AsyncResult00](res.impl)))

proc g_dbus_connection_close_sync*(self: ptr DBusConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_dbus_connection_close_sync", libprag.}

proc closeSync*(self: DBusConnection; cancellable: Cancellable): bool =
  toBool(g_dbus_connection_close_sync(cast[ptr DBusConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_dbus_connection_emit_signal*(self: ptr DBusConnection00; destinationBusName: cstring; 
    objectPath: cstring; interfaceName: cstring; signalName: cstring; parameters: ptr glib.Variant00): gboolean {.
    importc: "g_dbus_connection_emit_signal", libprag.}

proc emitSignal*(self: DBusConnection; destinationBusName: string; 
    objectPath: string; interfaceName: string; signalName: string; parameters: glib.Variant): bool =
  toBool(g_dbus_connection_emit_signal(cast[ptr DBusConnection00](self.impl), cstring(destinationBusName), cstring(objectPath), cstring(interfaceName), cstring(signalName), cast[ptr glib.Variant00](parameters.impl)))

proc g_dbus_connection_export_action_group*(self: ptr DBusConnection00; objectPath: cstring; actionGroup: ptr ActionGroup00): uint32 {.
    importc: "g_dbus_connection_export_action_group", libprag.}

proc exportActionGroup*(self: DBusConnection; objectPath: string; actionGroup: ActionGroup): int =
  int(g_dbus_connection_export_action_group(cast[ptr DBusConnection00](self.impl), cstring(objectPath), cast[ptr ActionGroup00](actionGroup.impl)))

proc g_dbus_connection_flush_finish*(self: ptr DBusConnection00; res: ptr AsyncResult00): gboolean {.
    importc: "g_dbus_connection_flush_finish", libprag.}

proc flushFinish*(self: DBusConnection; res: AsyncResult): bool =
  toBool(g_dbus_connection_flush_finish(cast[ptr DBusConnection00](self.impl), cast[ptr AsyncResult00](res.impl)))

proc g_dbus_connection_flush_sync*(self: ptr DBusConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_dbus_connection_flush_sync", libprag.}

proc flushSync*(self: DBusConnection; cancellable: Cancellable): bool =
  toBool(g_dbus_connection_flush_sync(cast[ptr DBusConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_dbus_connection_get_exit_on_close*(self: ptr DBusConnection00): gboolean {.
    importc: "g_dbus_connection_get_exit_on_close", libprag.}

proc getExitOnClose*(self: DBusConnection): bool =
  toBool(g_dbus_connection_get_exit_on_close(cast[ptr DBusConnection00](self.impl)))

proc exitOnClose*(self: DBusConnection): bool =
  toBool(g_dbus_connection_get_exit_on_close(cast[ptr DBusConnection00](self.impl)))

proc g_dbus_connection_get_guid*(self: ptr DBusConnection00): cstring {.
    importc: "g_dbus_connection_get_guid", libprag.}

proc getGuid*(self: DBusConnection): string =
  let resul0 = g_dbus_connection_get_guid(cast[ptr DBusConnection00](self.impl))
  result = $resul0

proc guid*(self: DBusConnection): string =
  let resul0 = g_dbus_connection_get_guid(cast[ptr DBusConnection00](self.impl))
  result = $resul0

proc g_dbus_connection_get_last_serial*(self: ptr DBusConnection00): uint32 {.
    importc: "g_dbus_connection_get_last_serial", libprag.}

proc getLastSerial*(self: DBusConnection): int =
  int(g_dbus_connection_get_last_serial(cast[ptr DBusConnection00](self.impl)))

proc lastSerial*(self: DBusConnection): int =
  int(g_dbus_connection_get_last_serial(cast[ptr DBusConnection00](self.impl)))

proc g_dbus_connection_get_stream*(self: ptr DBusConnection00): ptr IOStream00 {.
    importc: "g_dbus_connection_get_stream", libprag.}

proc getStream*(self: DBusConnection): IOStream =
  let gobj = g_dbus_connection_get_stream(cast[ptr DBusConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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

proc stream*(self: DBusConnection): IOStream =
  let gobj = g_dbus_connection_get_stream(cast[ptr DBusConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_connection_get_unique_name*(self: ptr DBusConnection00): cstring {.
    importc: "g_dbus_connection_get_unique_name", libprag.}

proc getUniqueName*(self: DBusConnection): string =
  let resul0 = g_dbus_connection_get_unique_name(cast[ptr DBusConnection00](self.impl))
  result = $resul0

proc uniqueName*(self: DBusConnection): string =
  let resul0 = g_dbus_connection_get_unique_name(cast[ptr DBusConnection00](self.impl))
  result = $resul0

proc g_dbus_connection_is_closed*(self: ptr DBusConnection00): gboolean {.
    importc: "g_dbus_connection_is_closed", libprag.}

proc isClosed*(self: DBusConnection): bool =
  toBool(g_dbus_connection_is_closed(cast[ptr DBusConnection00](self.impl)))

proc g_dbus_connection_remove_filter*(self: ptr DBusConnection00; filterId: uint32) {.
    importc: "g_dbus_connection_remove_filter", libprag.}

proc removeFilter*(self: DBusConnection; filterId: int) =
  g_dbus_connection_remove_filter(cast[ptr DBusConnection00](self.impl), uint32(filterId))

proc g_dbus_connection_set_exit_on_close*(self: ptr DBusConnection00; exitOnClose: gboolean) {.
    importc: "g_dbus_connection_set_exit_on_close", libprag.}

proc setExitOnClose*(self: DBusConnection; exitOnClose: bool) =
  g_dbus_connection_set_exit_on_close(cast[ptr DBusConnection00](self.impl), gboolean(exitOnClose))

proc `exitOnClose=`*(self: DBusConnection; exitOnClose: bool) =
  g_dbus_connection_set_exit_on_close(cast[ptr DBusConnection00](self.impl), gboolean(exitOnClose))

proc g_dbus_connection_signal_unsubscribe*(self: ptr DBusConnection00; subscriptionId: uint32) {.
    importc: "g_dbus_connection_signal_unsubscribe", libprag.}

proc signalUnsubscribe*(self: DBusConnection; subscriptionId: int) =
  g_dbus_connection_signal_unsubscribe(cast[ptr DBusConnection00](self.impl), uint32(subscriptionId))

proc g_dbus_connection_start_message_processing*(self: ptr DBusConnection00) {.
    importc: "g_dbus_connection_start_message_processing", libprag.}

proc startMessageProcessing*(self: DBusConnection) =
  g_dbus_connection_start_message_processing(cast[ptr DBusConnection00](self.impl))

proc g_dbus_connection_unexport_action_group*(self: ptr DBusConnection00; exportId: uint32) {.
    importc: "g_dbus_connection_unexport_action_group", libprag.}

proc unexportActionGroup*(self: DBusConnection; exportId: int) =
  g_dbus_connection_unexport_action_group(cast[ptr DBusConnection00](self.impl), uint32(exportId))

proc g_dbus_connection_unexport_menu_model*(self: ptr DBusConnection00; exportId: uint32) {.
    importc: "g_dbus_connection_unexport_menu_model", libprag.}

proc unexportMenuModel*(self: DBusConnection; exportId: int) =
  g_dbus_connection_unexport_menu_model(cast[ptr DBusConnection00](self.impl), uint32(exportId))

proc g_dbus_connection_unregister_object*(self: ptr DBusConnection00; registrationId: uint32): gboolean {.
    importc: "g_dbus_connection_unregister_object", libprag.}

proc unregisterObject*(self: DBusConnection; registrationId: int): bool =
  toBool(g_dbus_connection_unregister_object(cast[ptr DBusConnection00](self.impl), uint32(registrationId)))

proc g_dbus_connection_unregister_subtree*(self: ptr DBusConnection00; registrationId: uint32): gboolean {.
    importc: "g_dbus_connection_unregister_subtree", libprag.}

proc unregisterSubtree*(self: DBusConnection; registrationId: int): bool =
  toBool(g_dbus_connection_unregister_subtree(cast[ptr DBusConnection00](self.impl), uint32(registrationId)))

proc g_application_get_dbus_connection*(self: ptr Application00): ptr DBusConnection00 {.
    importc: "g_application_get_dbus_connection", libprag.}

proc getDbusConnection*(self: Application): DBusConnection =
  let gobj = g_application_get_dbus_connection(cast[ptr Application00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc dbusConnection*(self: Application): DBusConnection =
  let gobj = g_application_get_dbus_connection(cast[ptr Application00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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
  DBusConnectionFlag* {.size: sizeof(cint), pure.} = enum
    authenticationClient = 1
    authenticationServer = 2
    authenticationAllowAnonymous = 3
    messageBusConnection = 4
    delayMessageProcessing = 5

  DBusConnectionFlags* {.size: sizeof(cint).} = set[DBusConnectionFlag]

type
  UnixFDListPrivate00* {.pure.} = object
  UnixFDListPrivate* = ref object
    impl*: ptr UnixFDListPrivate00

type
  UnixFDList* = ref object of gobject.Object
  UnixFDList00* = object of gobject.Object00
    priv1: ptr UnixFDListPrivate00

proc g_unix_fd_list_new*(): ptr UnixFDList00 {.
    importc: "g_unix_fd_list_new", libprag.}

proc newUnixFDList*(): UnixFDList =
  new(result, finalizeGObject)
  result.impl = g_unix_fd_list_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixFDList*[T](result: var T) =
  assert(result is UnixFDList)
  new(result, finalizeGObject)
  result.impl = g_unix_fd_list_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_fd_list_new_from_array*(fds: int32Array; nFds: int32): ptr UnixFDList00 {.
    importc: "g_unix_fd_list_new_from_array", libprag.}

proc newUnixFDListFromArray*(fds: int32Array; nFds: int): UnixFDList =
  new(result, finalizeGObject)
  result.impl = g_unix_fd_list_new_from_array(fds, int32(nFds))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixFDListFromArray*[T](result: var T; fds: int32Array; nFds: int) =
  assert(result is UnixFDList)
  new(result, finalizeGObject)
  result.impl = g_unix_fd_list_new_from_array(fds, int32(nFds))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_fd_list_append*(self: ptr UnixFDList00; fd: int32): int32 {.
    importc: "g_unix_fd_list_append", libprag.}

proc append*(self: UnixFDList; fd: int): int =
  int(g_unix_fd_list_append(cast[ptr UnixFDList00](self.impl), int32(fd)))

proc g_unix_fd_list_get*(self: ptr UnixFDList00; index: int32): int32 {.
    importc: "g_unix_fd_list_get", libprag.}

proc get*(self: UnixFDList; index: int): int =
  int(g_unix_fd_list_get(cast[ptr UnixFDList00](self.impl), int32(index)))

proc g_unix_fd_list_get_length*(self: ptr UnixFDList00): int32 {.
    importc: "g_unix_fd_list_get_length", libprag.}

proc getLength*(self: UnixFDList): int =
  int(g_unix_fd_list_get_length(cast[ptr UnixFDList00](self.impl)))

proc length*(self: UnixFDList): int =
  int(g_unix_fd_list_get_length(cast[ptr UnixFDList00](self.impl)))

proc g_unix_fd_list_peek_fds*(self: ptr UnixFDList00; length: var int32): int32Array {.
    importc: "g_unix_fd_list_peek_fds", libprag.}

proc peekFds*(self: UnixFDList; length: var int): int32Array =
  var length_00 = int32(length)
  result = g_unix_fd_list_peek_fds(cast[ptr UnixFDList00](self.impl), length_00)
  length = int(length_00)

proc g_unix_fd_list_steal_fds*(self: ptr UnixFDList00; length: var int32): int32Array {.
    importc: "g_unix_fd_list_steal_fds", libprag.}

proc stealFds*(self: UnixFDList; length: var int): int32Array =
  var length_00 = int32(length)
  result = g_unix_fd_list_steal_fds(cast[ptr UnixFDList00](self.impl), length_00)
  length = int(length_00)

proc g_dbus_connection_call_with_unix_fd_list_finish*(self: ptr DBusConnection00; outFdList: var ptr UnixFDList00; 
    res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_with_unix_fd_list_finish", libprag.}

proc callWithUnixFdListFinish*(self: ptr DBusConnection00; outFdList: var ptr UnixFDList00; 
    res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_with_unix_fd_list_finish", libprag.}

type
  DBusCallFlag* {.size: sizeof(cint), pure.} = enum
    noAutoStart = 1
    allowInteractiveAuthorization = 2

  DBusCallFlags* {.size: sizeof(cint).} = set[DBusCallFlag]

proc g_dbus_connection_call_sync*(self: ptr DBusConnection00; busName: cstring; objectPath: cstring; 
    interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; replyType: ptr glib.VariantType00; 
    flags: DBusCallFlags; timeoutMsec: int32; cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_sync", libprag.}

proc callSync*(self: DBusConnection; busName: string; objectPath: string; 
    interfaceName: string; methodName: string; parameters: glib.Variant; replyType: glib.VariantType; 
    flags: DBusCallFlags; timeoutMsec: int; cancellable: Cancellable): glib.Variant =
  new(result)
  result.impl = g_dbus_connection_call_sync(cast[ptr DBusConnection00](self.impl), cstring(busName), cstring(objectPath), cstring(interfaceName), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), cast[ptr glib.VariantType00](replyType.impl), flags, int32(timeoutMsec), cast[ptr Cancellable00](cancellable.impl))

proc g_dbus_connection_call_with_unix_fd_list_sync*(self: ptr DBusConnection00; busName: cstring; objectPath: cstring; 
    interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; replyType: ptr glib.VariantType00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; outFdList: var ptr UnixFDList00; cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_with_unix_fd_list_sync", libprag.}

proc callWithUnixFdListSync*(self: ptr DBusConnection00; busName: cstring; objectPath: cstring; 
    interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; replyType: ptr glib.VariantType00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; outFdList: var ptr UnixFDList00; cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_connection_call_with_unix_fd_list_sync", libprag.}

type
  MenuModelPrivate00* {.pure.} = object
  MenuModelPrivate* = ref object
    impl*: ptr MenuModelPrivate00

type
  MenuModel* = ref object of gobject.Object
  MenuModel00* = object of gobject.Object00
    priv1: ptr MenuModelPrivate00

proc scItemsChanged*(self: MenuModel;  p: proc (self: ptr gobject.Object00; position: int32; removed: int32; added: int32; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "items-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_menu_model_get_item_attribute_value*(self: ptr MenuModel00; itemIndex: int32; attribute: cstring; 
    expectedType: ptr glib.VariantType00): ptr glib.Variant00 {.
    importc: "g_menu_model_get_item_attribute_value", libprag.}

proc getItemAttributeValue*(self: MenuModel; itemIndex: int; attribute: string; 
    expectedType: glib.VariantType): glib.Variant =
  new(result)
  result.impl = g_menu_model_get_item_attribute_value(cast[ptr MenuModel00](self.impl), int32(itemIndex), cstring(attribute), cast[ptr glib.VariantType00](expectedType.impl))

proc itemAttributeValue*(self: MenuModel; itemIndex: int; attribute: string; 
    expectedType: glib.VariantType): glib.Variant =
  new(result)
  result.impl = g_menu_model_get_item_attribute_value(cast[ptr MenuModel00](self.impl), int32(itemIndex), cstring(attribute), cast[ptr glib.VariantType00](expectedType.impl))

proc g_menu_model_get_item_link*(self: ptr MenuModel00; itemIndex: int32; link: cstring): ptr MenuModel00 {.
    importc: "g_menu_model_get_item_link", libprag.}

proc getItemLink*(self: MenuModel; itemIndex: int; link: string): MenuModel =
  let gobj = g_menu_model_get_item_link(cast[ptr MenuModel00](self.impl), int32(itemIndex), cstring(link))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc itemLink*(self: MenuModel; itemIndex: int; link: string): MenuModel =
  let gobj = g_menu_model_get_item_link(cast[ptr MenuModel00](self.impl), int32(itemIndex), cstring(link))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc g_menu_model_get_n_items*(self: ptr MenuModel00): int32 {.
    importc: "g_menu_model_get_n_items", libprag.}

proc getNItems*(self: MenuModel): int =
  int(g_menu_model_get_n_items(cast[ptr MenuModel00](self.impl)))

proc nItems*(self: MenuModel): int =
  int(g_menu_model_get_n_items(cast[ptr MenuModel00](self.impl)))

proc g_menu_model_is_mutable*(self: ptr MenuModel00): gboolean {.
    importc: "g_menu_model_is_mutable", libprag.}

proc isMutable*(self: MenuModel): bool =
  toBool(g_menu_model_is_mutable(cast[ptr MenuModel00](self.impl)))

proc g_menu_model_items_changed*(self: ptr MenuModel00; position: int32; removed: int32; 
    added: int32) {.
    importc: "g_menu_model_items_changed", libprag.}

proc itemsChanged*(self: MenuModel; position: int; removed: int; added: int) =
  g_menu_model_items_changed(cast[ptr MenuModel00](self.impl), int32(position), int32(removed), int32(added))

proc g_dbus_connection_export_menu_model*(self: ptr DBusConnection00; objectPath: cstring; menu: ptr MenuModel00): uint32 {.
    importc: "g_dbus_connection_export_menu_model", libprag.}

proc exportMenuModel*(self: DBusConnection; objectPath: string; menu: MenuModel): int =
  int(g_dbus_connection_export_menu_model(cast[ptr DBusConnection00](self.impl), cstring(objectPath), cast[ptr MenuModel00](menu.impl)))

type
  MenuAttributeIterPrivate00* {.pure.} = object
  MenuAttributeIterPrivate* = ref object
    impl*: ptr MenuAttributeIterPrivate00

type
  MenuAttributeIter* = ref object of gobject.Object
  MenuAttributeIter00* = object of gobject.Object00
    priv1: ptr MenuAttributeIterPrivate00

proc g_menu_attribute_iter_get_name*(self: ptr MenuAttributeIter00): cstring {.
    importc: "g_menu_attribute_iter_get_name", libprag.}

proc getName*(self: MenuAttributeIter): string =
  let resul0 = g_menu_attribute_iter_get_name(cast[ptr MenuAttributeIter00](self.impl))
  result = $resul0

proc name*(self: MenuAttributeIter): string =
  let resul0 = g_menu_attribute_iter_get_name(cast[ptr MenuAttributeIter00](self.impl))
  result = $resul0

proc g_menu_attribute_iter_get_next*(self: ptr MenuAttributeIter00; outName: var cstring; 
    value: var ptr glib.Variant00): gboolean {.
    importc: "g_menu_attribute_iter_get_next", libprag.}

proc getNext*(self: ptr MenuAttributeIter00; outName: var cstring; 
    value: var ptr glib.Variant00): gboolean {.
    importc: "g_menu_attribute_iter_get_next", libprag.}

proc next*(self: ptr MenuAttributeIter00; outName: var cstring; 
    value: var ptr glib.Variant00): gboolean {.
    importc: "g_menu_attribute_iter_get_next", libprag.}

proc g_menu_attribute_iter_get_value*(self: ptr MenuAttributeIter00): ptr glib.Variant00 {.
    importc: "g_menu_attribute_iter_get_value", libprag.}

proc getValue*(self: MenuAttributeIter): glib.Variant =
  new(result)
  result.impl = g_menu_attribute_iter_get_value(cast[ptr MenuAttributeIter00](self.impl))

proc value*(self: MenuAttributeIter): glib.Variant =
  new(result)
  result.impl = g_menu_attribute_iter_get_value(cast[ptr MenuAttributeIter00](self.impl))

proc g_menu_attribute_iter_next*(self: ptr MenuAttributeIter00): gboolean {.
    importc: "g_menu_attribute_iter_next", libprag.}

proc next*(self: MenuAttributeIter): bool =
  toBool(g_menu_attribute_iter_next(cast[ptr MenuAttributeIter00](self.impl)))

proc g_menu_model_iterate_item_attributes*(self: ptr MenuModel00; itemIndex: int32): ptr MenuAttributeIter00 {.
    importc: "g_menu_model_iterate_item_attributes", libprag.}

proc iterateItemAttributes*(self: MenuModel; itemIndex: int): MenuAttributeIter =
  let gobj = g_menu_model_iterate_item_attributes(cast[ptr MenuModel00](self.impl), int32(itemIndex))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuAttributeIter](g_object_get_qdata(gobj, Quark))
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
  MenuLinkIterPrivate00* {.pure.} = object
  MenuLinkIterPrivate* = ref object
    impl*: ptr MenuLinkIterPrivate00

type
  MenuLinkIter* = ref object of gobject.Object
  MenuLinkIter00* = object of gobject.Object00
    priv1: ptr MenuLinkIterPrivate00

proc g_menu_link_iter_get_name*(self: ptr MenuLinkIter00): cstring {.
    importc: "g_menu_link_iter_get_name", libprag.}

proc getName*(self: MenuLinkIter): string =
  let resul0 = g_menu_link_iter_get_name(cast[ptr MenuLinkIter00](self.impl))
  result = $resul0

proc name*(self: MenuLinkIter): string =
  let resul0 = g_menu_link_iter_get_name(cast[ptr MenuLinkIter00](self.impl))
  result = $resul0

proc g_menu_link_iter_get_next*(self: ptr MenuLinkIter00; outLink: var cstring; value: var ptr MenuModel00): gboolean {.
    importc: "g_menu_link_iter_get_next", libprag.}

proc getNext*(self: ptr MenuLinkIter00; outLink: var cstring; value: var ptr MenuModel00): gboolean {.
    importc: "g_menu_link_iter_get_next", libprag.}

proc next*(self: ptr MenuLinkIter00; outLink: var cstring; value: var ptr MenuModel00): gboolean {.
    importc: "g_menu_link_iter_get_next", libprag.}

proc g_menu_link_iter_get_value*(self: ptr MenuLinkIter00): ptr MenuModel00 {.
    importc: "g_menu_link_iter_get_value", libprag.}

proc getValue*(self: MenuLinkIter): MenuModel =
  let gobj = g_menu_link_iter_get_value(cast[ptr MenuLinkIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc value*(self: MenuLinkIter): MenuModel =
  let gobj = g_menu_link_iter_get_value(cast[ptr MenuLinkIter00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc g_menu_link_iter_next*(self: ptr MenuLinkIter00): gboolean {.
    importc: "g_menu_link_iter_next", libprag.}

proc next*(self: MenuLinkIter): bool =
  toBool(g_menu_link_iter_next(cast[ptr MenuLinkIter00](self.impl)))

proc g_menu_model_iterate_item_links*(self: ptr MenuModel00; itemIndex: int32): ptr MenuLinkIter00 {.
    importc: "g_menu_model_iterate_item_links", libprag.}

proc iterateItemLinks*(self: MenuModel; itemIndex: int): MenuLinkIter =
  let gobj = g_menu_model_iterate_item_links(cast[ptr MenuModel00](self.impl), int32(itemIndex))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuLinkIter](g_object_get_qdata(gobj, Quark))
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
  DBusCapabilityFlag* {.size: sizeof(cint), pure.} = enum
    unixFdPassing = 1

  DBusCapabilityFlags* {.size: sizeof(cint).} = set[DBusCapabilityFlag]

proc g_dbus_connection_get_capabilities*(self: ptr DBusConnection00): DBusCapabilityFlags {.
    importc: "g_dbus_connection_get_capabilities", libprag.}

proc getCapabilities*(self: DBusConnection): DBusCapabilityFlags =
  g_dbus_connection_get_capabilities(cast[ptr DBusConnection00](self.impl))

proc capabilities*(self: DBusConnection): DBusCapabilityFlags =
  g_dbus_connection_get_capabilities(cast[ptr DBusConnection00](self.impl))

type
  Credentials* = ref object of gobject.Object
  Credentials00* = object of gobject.Object00

proc g_credentials_new*(): ptr Credentials00 {.
    importc: "g_credentials_new", libprag.}

proc newCredentials*(): Credentials =
  new(result, finalizeGObject)
  result.impl = g_credentials_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCredentials*[T](result: var T) =
  assert(result is Credentials)
  new(result, finalizeGObject)
  result.impl = g_credentials_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_credentials_get_unix_pid*(self: ptr Credentials00): int32 {.
    importc: "g_credentials_get_unix_pid", libprag.}

proc getUnixPid*(self: Credentials): int =
  int(g_credentials_get_unix_pid(cast[ptr Credentials00](self.impl)))

proc unixPid*(self: Credentials): int =
  int(g_credentials_get_unix_pid(cast[ptr Credentials00](self.impl)))

proc g_credentials_get_unix_user*(self: ptr Credentials00): uint32 {.
    importc: "g_credentials_get_unix_user", libprag.}

proc getUnixUser*(self: Credentials): int =
  int(g_credentials_get_unix_user(cast[ptr Credentials00](self.impl)))

proc unixUser*(self: Credentials): int =
  int(g_credentials_get_unix_user(cast[ptr Credentials00](self.impl)))

proc g_credentials_is_same_user*(self: ptr Credentials00; otherCredentials: ptr Credentials00): gboolean {.
    importc: "g_credentials_is_same_user", libprag.}

proc isSameUser*(self: Credentials; otherCredentials: Credentials): bool =
  toBool(g_credentials_is_same_user(cast[ptr Credentials00](self.impl), cast[ptr Credentials00](otherCredentials.impl)))

proc g_credentials_set_unix_user*(self: ptr Credentials00; uid: uint32): gboolean {.
    importc: "g_credentials_set_unix_user", libprag.}

proc setUnixUser*(self: Credentials; uid: int): bool =
  toBool(g_credentials_set_unix_user(cast[ptr Credentials00](self.impl), uint32(uid)))

proc `unixUser=`*(self: Credentials; uid: int): bool =
  toBool(g_credentials_set_unix_user(cast[ptr Credentials00](self.impl), uint32(uid)))

proc g_credentials_to_string*(self: ptr Credentials00): cstring {.
    importc: "g_credentials_to_string", libprag.}

proc toString*(self: Credentials): string =
  let resul0 = g_credentials_to_string(cast[ptr Credentials00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  DBusAuthObserver* = ref object of gobject.Object
  DBusAuthObserver00* = object of gobject.Object00

proc scAllowMechanism*(self: DBusAuthObserver;  p: proc (self: ptr gobject.Object00; mechanism: cstring; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "allow-mechanism", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scAuthorizeAuthenticatedPeer*(self: DBusAuthObserver;  p: proc (self: ptr gobject.Object00; stream: IOStream00; credentials: Credentials00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "authorize-authenticated-peer", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_auth_observer_new*(): ptr DBusAuthObserver00 {.
    importc: "g_dbus_auth_observer_new", libprag.}

proc newDBusAuthObserver*(): DBusAuthObserver =
  new(result, finalizeGObject)
  result.impl = g_dbus_auth_observer_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusAuthObserver*[T](result: var T) =
  assert(result is DBusAuthObserver)
  new(result, finalizeGObject)
  result.impl = g_dbus_auth_observer_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_auth_observer_allow_mechanism*(self: ptr DBusAuthObserver00; mechanism: cstring): gboolean {.
    importc: "g_dbus_auth_observer_allow_mechanism", libprag.}

proc allowMechanism*(self: DBusAuthObserver; mechanism: string): bool =
  toBool(g_dbus_auth_observer_allow_mechanism(cast[ptr DBusAuthObserver00](self.impl), cstring(mechanism)))

proc g_dbus_auth_observer_authorize_authenticated_peer*(self: ptr DBusAuthObserver00; stream: ptr IOStream00; 
    credentials: ptr Credentials00): gboolean {.
    importc: "g_dbus_auth_observer_authorize_authenticated_peer", libprag.}

proc authorizeAuthenticatedPeer*(self: DBusAuthObserver; stream: IOStream; credentials: Credentials): bool =
  toBool(g_dbus_auth_observer_authorize_authenticated_peer(cast[ptr DBusAuthObserver00](self.impl), cast[ptr IOStream00](stream.impl), cast[ptr Credentials00](credentials.impl)))

proc g_dbus_connection_new_for_address_sync*(address: cstring; flags: DBusConnectionFlags; observer: ptr DBusAuthObserver00; 
    cancellable: ptr Cancellable00): ptr DBusConnection00 {.
    importc: "g_dbus_connection_new_for_address_sync", libprag.}

proc newDBusConnectionForAddressSync*(address: string; flags: DBusConnectionFlags; observer: DBusAuthObserver; 
    cancellable: Cancellable): DBusConnection =
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_for_address_sync(cstring(address), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusConnectionForAddressSync*[T](result: var T; address: string; flags: DBusConnectionFlags; observer: DBusAuthObserver; 
    cancellable: Cancellable) =
  assert(result is DBusConnection)
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_for_address_sync(cstring(address), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_connection_new_sync*(stream: ptr IOStream00; guid: cstring; flags: DBusConnectionFlags; 
    observer: ptr DBusAuthObserver00; cancellable: ptr Cancellable00): ptr DBusConnection00 {.
    importc: "g_dbus_connection_new_sync", libprag.}

proc newDBusConnectionSync*(stream: IOStream; guid: string; flags: DBusConnectionFlags; 
    observer: DBusAuthObserver; cancellable: Cancellable): DBusConnection =
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_sync(cast[ptr IOStream00](stream.impl), cstring(guid), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusConnectionSync*[T](result: var T; stream: IOStream; guid: string; flags: DBusConnectionFlags; 
    observer: DBusAuthObserver; cancellable: Cancellable) =
  assert(result is DBusConnection)
  new(result, finalizeGObject)
  result.impl = g_dbus_connection_new_sync(cast[ptr IOStream00](stream.impl), cstring(guid), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_connection_get_peer_credentials*(self: ptr DBusConnection00): ptr Credentials00 {.
    importc: "g_dbus_connection_get_peer_credentials", libprag.}

proc getPeerCredentials*(self: DBusConnection): Credentials =
  let gobj = g_dbus_connection_get_peer_credentials(cast[ptr DBusConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc peerCredentials*(self: DBusConnection): Credentials =
  let gobj = g_dbus_connection_get_peer_credentials(cast[ptr DBusConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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
  CredentialsType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    linuxUcred = 1
    freebsdCmsgcred = 2
    openbsdSockpeercred = 3
    solarisUcred = 4
    netbsdUnpcbid = 5

proc g_credentials_set_native*(self: ptr Credentials00; nativeType: CredentialsType; 
    native: pointer) {.
    importc: "g_credentials_set_native", libprag.}

proc setNative*(self: Credentials; nativeType: CredentialsType; native: pointer) =
  g_credentials_set_native(cast[ptr Credentials00](self.impl), nativeType, native)

type
  DBusAnnotationInfo00* {.pure.} = object
    refCount*: int32
    key*: cstring
    value*: cstring
    annotations*: ptr DBusAnnotationInfo00Array
  DBusAnnotationInfo* = ref object
    impl*: ptr DBusAnnotationInfo00

proc g_dbus_annotation_info_ref*(self: ptr DBusAnnotationInfo00): ptr DBusAnnotationInfo00 {.
    importc: "g_dbus_annotation_info_ref", libprag.}

proc `ref`*(self: DBusAnnotationInfo): DBusAnnotationInfo =
  new(result)
  result.impl = g_dbus_annotation_info_ref(cast[ptr DBusAnnotationInfo00](self.impl))

proc g_dbus_annotation_info_unref*(self: ptr DBusAnnotationInfo00) {.
    importc: "g_dbus_annotation_info_unref", libprag.}

proc unref*(self: DBusAnnotationInfo) =
  g_dbus_annotation_info_unref(cast[ptr DBusAnnotationInfo00](self.impl))

proc g_dbus_annotation_info_lookup*(annotations: ptr DBusAnnotationInfo00Array; name: cstring): cstring {.
    importc: "g_dbus_annotation_info_lookup", libprag.}

proc lookup*(annotations: ptr DBusAnnotationInfo00Array; name: string): string =
  let resul0 = g_dbus_annotation_info_lookup(annotations, cstring(name))
  result = $resul0

type
  DBusArgInfo00* {.pure.} = object
    refCount*: int32
    name*: cstring
    signature*: cstring
    annotations*: ptr DBusAnnotationInfo00Array
  DBusArgInfo* = ref object
    impl*: ptr DBusArgInfo00

proc g_dbus_arg_info_ref*(self: ptr DBusArgInfo00): ptr DBusArgInfo00 {.
    importc: "g_dbus_arg_info_ref", libprag.}

proc `ref`*(self: DBusArgInfo): DBusArgInfo =
  new(result)
  result.impl = g_dbus_arg_info_ref(cast[ptr DBusArgInfo00](self.impl))

proc g_dbus_arg_info_unref*(self: ptr DBusArgInfo00) {.
    importc: "g_dbus_arg_info_unref", libprag.}

proc unref*(self: DBusArgInfo) =
  g_dbus_arg_info_unref(cast[ptr DBusArgInfo00](self.impl))

type
  DBusMethodInfo00* {.pure.} = object
    refCount*: int32
    name*: cstring
    inArgs*: ptr DBusArgInfo00Array
    outArgs*: ptr DBusArgInfo00Array
    annotations*: ptr DBusAnnotationInfo00Array
  DBusMethodInfo* = ref object
    impl*: ptr DBusMethodInfo00

proc g_dbus_method_info_ref*(self: ptr DBusMethodInfo00): ptr DBusMethodInfo00 {.
    importc: "g_dbus_method_info_ref", libprag.}

proc `ref`*(self: DBusMethodInfo): DBusMethodInfo =
  new(result)
  result.impl = g_dbus_method_info_ref(cast[ptr DBusMethodInfo00](self.impl))

proc g_dbus_method_info_unref*(self: ptr DBusMethodInfo00) {.
    importc: "g_dbus_method_info_unref", libprag.}

proc unref*(self: DBusMethodInfo) =
  g_dbus_method_info_unref(cast[ptr DBusMethodInfo00](self.impl))

type
  DBusSignalInfo00* {.pure.} = object
    refCount*: int32
    name*: cstring
    args*: ptr DBusArgInfo00Array
    annotations*: ptr DBusAnnotationInfo00Array
  DBusSignalInfo* = ref object
    impl*: ptr DBusSignalInfo00

proc g_dbus_signal_info_ref*(self: ptr DBusSignalInfo00): ptr DBusSignalInfo00 {.
    importc: "g_dbus_signal_info_ref", libprag.}

proc `ref`*(self: DBusSignalInfo): DBusSignalInfo =
  new(result)
  result.impl = g_dbus_signal_info_ref(cast[ptr DBusSignalInfo00](self.impl))

proc g_dbus_signal_info_unref*(self: ptr DBusSignalInfo00) {.
    importc: "g_dbus_signal_info_unref", libprag.}

proc unref*(self: DBusSignalInfo) =
  g_dbus_signal_info_unref(cast[ptr DBusSignalInfo00](self.impl))

type
  DBusPropertyInfoFlag* {.size: sizeof(cint), pure.} = enum
    readable = 1
    writable = 2

  DBusPropertyInfoFlags* {.size: sizeof(cint).} = set[DBusPropertyInfoFlag]

type
  DBusPropertyInfo00* {.pure.} = object
    refCount*: int32
    name*: cstring
    signature*: cstring
    flags*: DBusPropertyInfoFlags
    annotations*: ptr DBusAnnotationInfo00Array
  DBusPropertyInfo* = ref object
    impl*: ptr DBusPropertyInfo00

proc g_dbus_property_info_ref*(self: ptr DBusPropertyInfo00): ptr DBusPropertyInfo00 {.
    importc: "g_dbus_property_info_ref", libprag.}

proc `ref`*(self: DBusPropertyInfo): DBusPropertyInfo =
  new(result)
  result.impl = g_dbus_property_info_ref(cast[ptr DBusPropertyInfo00](self.impl))

proc g_dbus_property_info_unref*(self: ptr DBusPropertyInfo00) {.
    importc: "g_dbus_property_info_unref", libprag.}

proc unref*(self: DBusPropertyInfo) =
  g_dbus_property_info_unref(cast[ptr DBusPropertyInfo00](self.impl))

type
  DBusInterfaceInfo00* {.pure.} = object
    refCount*: int32
    name*: cstring
    methods*: ptr DBusMethodInfo00Array
    signals*: ptr DBusSignalInfo00Array
    properties*: ptr DBusPropertyInfo00Array
    annotations*: ptr DBusAnnotationInfo00Array
  DBusInterfaceInfo* = ref object
    impl*: ptr DBusInterfaceInfo00

proc g_dbus_interface_info_cache_build*(self: ptr DBusInterfaceInfo00) {.
    importc: "g_dbus_interface_info_cache_build", libprag.}

proc cacheBuild*(self: DBusInterfaceInfo) =
  g_dbus_interface_info_cache_build(cast[ptr DBusInterfaceInfo00](self.impl))

proc g_dbus_interface_info_cache_release*(self: ptr DBusInterfaceInfo00) {.
    importc: "g_dbus_interface_info_cache_release", libprag.}

proc cacheRelease*(self: DBusInterfaceInfo) =
  g_dbus_interface_info_cache_release(cast[ptr DBusInterfaceInfo00](self.impl))

proc g_dbus_interface_info_generate_xml*(self: ptr DBusInterfaceInfo00; indent: uint32; stringBuilder: var glib.String00) {.
    importc: "g_dbus_interface_info_generate_xml", libprag.}

proc generateXml*(self: ptr DBusInterfaceInfo00; indent: uint32; stringBuilder: var glib.String00) {.
    importc: "g_dbus_interface_info_generate_xml", libprag.}

proc g_dbus_interface_info_lookup_method*(self: ptr DBusInterfaceInfo00; name: cstring): ptr DBusMethodInfo00 {.
    importc: "g_dbus_interface_info_lookup_method", libprag.}

proc lookupMethod*(self: DBusInterfaceInfo; name: string): DBusMethodInfo =
  new(result)
  result.impl = g_dbus_interface_info_lookup_method(cast[ptr DBusInterfaceInfo00](self.impl), cstring(name))

proc g_dbus_interface_info_lookup_property*(self: ptr DBusInterfaceInfo00; name: cstring): ptr DBusPropertyInfo00 {.
    importc: "g_dbus_interface_info_lookup_property", libprag.}

proc lookupProperty*(self: DBusInterfaceInfo; name: string): DBusPropertyInfo =
  new(result)
  result.impl = g_dbus_interface_info_lookup_property(cast[ptr DBusInterfaceInfo00](self.impl), cstring(name))

proc g_dbus_interface_info_lookup_signal*(self: ptr DBusInterfaceInfo00; name: cstring): ptr DBusSignalInfo00 {.
    importc: "g_dbus_interface_info_lookup_signal", libprag.}

proc lookupSignal*(self: DBusInterfaceInfo; name: string): DBusSignalInfo =
  new(result)
  result.impl = g_dbus_interface_info_lookup_signal(cast[ptr DBusInterfaceInfo00](self.impl), cstring(name))

proc g_dbus_interface_info_ref*(self: ptr DBusInterfaceInfo00): ptr DBusInterfaceInfo00 {.
    importc: "g_dbus_interface_info_ref", libprag.}

proc `ref`*(self: DBusInterfaceInfo): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_interface_info_ref(cast[ptr DBusInterfaceInfo00](self.impl))

proc g_dbus_interface_info_unref*(self: ptr DBusInterfaceInfo00) {.
    importc: "g_dbus_interface_info_unref", libprag.}

proc unref*(self: DBusInterfaceInfo) =
  g_dbus_interface_info_unref(cast[ptr DBusInterfaceInfo00](self.impl))

proc g_dbus_connection_register_object_with_closures*(self: ptr DBusConnection00; objectPath: cstring; interfaceInfo: ptr DBusInterfaceInfo00; 
    methodCallClosure: ptr gobject.Closure00; getPropertyClosure: ptr gobject.Closure00; 
    setPropertyClosure: ptr gobject.Closure00): uint32 {.
    importc: "g_dbus_connection_register_object_with_closures", libprag.}

proc registerObject*(self: DBusConnection; objectPath: string; interfaceInfo: DBusInterfaceInfo; 
    methodCallClosure: gobject.Closure; getPropertyClosure: gobject.Closure; 
    setPropertyClosure: gobject.Closure): int =
  int(g_dbus_connection_register_object_with_closures(cast[ptr DBusConnection00](self.impl), cstring(objectPath), cast[ptr DBusInterfaceInfo00](interfaceInfo.impl), cast[ptr gobject.Closure00](methodCallClosure.impl), cast[ptr gobject.Closure00](getPropertyClosure.impl), cast[ptr gobject.Closure00](setPropertyClosure.impl)))

type
  DBusMessage* = ref object of gobject.Object
  DBusMessage00* = object of gobject.Object00

proc g_dbus_message_new*(): ptr DBusMessage00 {.
    importc: "g_dbus_message_new", libprag.}

proc newDBusMessage*(): DBusMessage =
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusMessage*[T](result: var T) =
  assert(result is DBusMessage)
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_message_new_from_blob*(blob: uint8Array; blobLen: uint64; capabilities: DBusCapabilityFlags): ptr DBusMessage00 {.
    importc: "g_dbus_message_new_from_blob", libprag.}

proc newDBusMessageFromBlob*(blob: uint8Array; blobLen: uint64; capabilities: DBusCapabilityFlags): DBusMessage =
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_from_blob(blob, blobLen, capabilities)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusMessageFromBlob*[T](result: var T; blob: uint8Array; blobLen: uint64; capabilities: DBusCapabilityFlags) =
  assert(result is DBusMessage)
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_from_blob(blob, blobLen, capabilities)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_message_new_method_call*(name: cstring; path: cstring; `interface`: cstring; 
    `method`: cstring): ptr DBusMessage00 {.
    importc: "g_dbus_message_new_method_call", libprag.}

proc newDBusMessageMethodCall*(name: string; path: string; `interface`: string; `method`: string): DBusMessage =
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_method_call(cstring(name), cstring(path), cstring(`interface`), cstring(`method`))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusMessageMethodCall*[T](result: var T; name: string; path: string; `interface`: string; `method`: string) =
  assert(result is DBusMessage)
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_method_call(cstring(name), cstring(path), cstring(`interface`), cstring(`method`))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_message_new_signal*(path: cstring; `interface`: cstring; signal: cstring): ptr DBusMessage00 {.
    importc: "g_dbus_message_new_signal", libprag.}

proc newDBusMessageSignal*(path: string; `interface`: string; signal: string): DBusMessage =
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_signal(cstring(path), cstring(`interface`), cstring(signal))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusMessageSignal*[T](result: var T; path: string; `interface`: string; signal: string) =
  assert(result is DBusMessage)
  new(result, finalizeGObject)
  result.impl = g_dbus_message_new_signal(cstring(path), cstring(`interface`), cstring(signal))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_message_bytes_needed*(blob: uint8Array; blobLen: uint64): int64 {.
    importc: "g_dbus_message_bytes_needed", libprag.}

proc bytesNeeded*(blob: uint8Array; blobLen: uint64): int64 {.
    importc: "g_dbus_message_bytes_needed", libprag.}

proc g_dbus_message_copy*(self: ptr DBusMessage00): ptr DBusMessage00 {.
    importc: "g_dbus_message_copy", libprag.}

proc copy*(self: DBusMessage): DBusMessage =
  let gobj = g_dbus_message_copy(cast[ptr DBusMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_message_get_arg0*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_arg0", libprag.}

proc getArg0*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_arg0(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc arg0*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_arg0(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_body*(self: ptr DBusMessage00): ptr glib.Variant00 {.
    importc: "g_dbus_message_get_body", libprag.}

proc getBody*(self: DBusMessage): glib.Variant =
  new(result)
  result.impl = g_dbus_message_get_body(cast[ptr DBusMessage00](self.impl))

proc body*(self: DBusMessage): glib.Variant =
  new(result)
  result.impl = g_dbus_message_get_body(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_get_destination*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_destination", libprag.}

proc getDestination*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_destination(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc destination*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_destination(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_error_name*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_error_name", libprag.}

proc getErrorName*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_error_name(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc errorName*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_error_name(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_header_fields*(self: ptr DBusMessage00): uint8Array {.
    importc: "g_dbus_message_get_header_fields", libprag.}

proc getHeaderFields*(self: DBusMessage): uint8Array =
  g_dbus_message_get_header_fields(cast[ptr DBusMessage00](self.impl))

proc headerFields*(self: DBusMessage): uint8Array =
  g_dbus_message_get_header_fields(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_get_interface*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_interface", libprag.}

proc getInterface*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_interface(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_locked*(self: ptr DBusMessage00): gboolean {.
    importc: "g_dbus_message_get_locked", libprag.}

proc getLocked*(self: DBusMessage): bool =
  toBool(g_dbus_message_get_locked(cast[ptr DBusMessage00](self.impl)))

proc locked*(self: DBusMessage): bool =
  toBool(g_dbus_message_get_locked(cast[ptr DBusMessage00](self.impl)))

proc g_dbus_message_get_member*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_member", libprag.}

proc getMember*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_member(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc member*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_member(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_num_unix_fds*(self: ptr DBusMessage00): uint32 {.
    importc: "g_dbus_message_get_num_unix_fds", libprag.}

proc getNumUnixFds*(self: DBusMessage): int =
  int(g_dbus_message_get_num_unix_fds(cast[ptr DBusMessage00](self.impl)))

proc numUnixFds*(self: DBusMessage): int =
  int(g_dbus_message_get_num_unix_fds(cast[ptr DBusMessage00](self.impl)))

proc g_dbus_message_get_path*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_path", libprag.}

proc getPath*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_path(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc path*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_path(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_reply_serial*(self: ptr DBusMessage00): uint32 {.
    importc: "g_dbus_message_get_reply_serial", libprag.}

proc getReplySerial*(self: DBusMessage): int =
  int(g_dbus_message_get_reply_serial(cast[ptr DBusMessage00](self.impl)))

proc replySerial*(self: DBusMessage): int =
  int(g_dbus_message_get_reply_serial(cast[ptr DBusMessage00](self.impl)))

proc g_dbus_message_get_sender*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_sender", libprag.}

proc getSender*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_sender(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc sender*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_sender(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_serial*(self: ptr DBusMessage00): uint32 {.
    importc: "g_dbus_message_get_serial", libprag.}

proc getSerial*(self: DBusMessage): int =
  int(g_dbus_message_get_serial(cast[ptr DBusMessage00](self.impl)))

proc serial*(self: DBusMessage): int =
  int(g_dbus_message_get_serial(cast[ptr DBusMessage00](self.impl)))

proc g_dbus_message_get_signature*(self: ptr DBusMessage00): cstring {.
    importc: "g_dbus_message_get_signature", libprag.}

proc getSignature*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_signature(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc signature*(self: DBusMessage): string =
  let resul0 = g_dbus_message_get_signature(cast[ptr DBusMessage00](self.impl))
  result = $resul0

proc g_dbus_message_get_unix_fd_list*(self: ptr DBusMessage00): ptr UnixFDList00 {.
    importc: "g_dbus_message_get_unix_fd_list", libprag.}

proc getUnixFdList*(self: DBusMessage): UnixFDList =
  let gobj = g_dbus_message_get_unix_fd_list(cast[ptr DBusMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[UnixFDList](g_object_get_qdata(gobj, Quark))
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

proc unixFdList*(self: DBusMessage): UnixFDList =
  let gobj = g_dbus_message_get_unix_fd_list(cast[ptr DBusMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[UnixFDList](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_message_lock*(self: ptr DBusMessage00) {.
    importc: "g_dbus_message_lock", libprag.}

proc lock*(self: DBusMessage) =
  g_dbus_message_lock(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_new_method_error_literal*(self: ptr DBusMessage00; errorName: cstring; errorMessage: cstring): ptr DBusMessage00 {.
    importc: "g_dbus_message_new_method_error_literal", libprag.}

proc newDBusMessageMethodErrorLiteral*(self: DBusMessage; errorName: string; errorMessage: string): DBusMessage =
  let gobj = g_dbus_message_new_method_error_literal(cast[ptr DBusMessage00](self.impl), cstring(errorName), cstring(errorMessage))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_message_new_method_reply*(self: ptr DBusMessage00): ptr DBusMessage00 {.
    importc: "g_dbus_message_new_method_reply", libprag.}

proc newDBusMessageMethodReply*(self: DBusMessage): DBusMessage =
  let gobj = g_dbus_message_new_method_reply(cast[ptr DBusMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_message_print*(self: ptr DBusMessage00; indent: uint32): cstring {.
    importc: "g_dbus_message_print", libprag.}

proc print*(self: DBusMessage; indent: int): string =
  let resul0 = g_dbus_message_print(cast[ptr DBusMessage00](self.impl), uint32(indent))
  result = $resul0
  cogfree(resul0)

proc g_dbus_message_set_body*(self: ptr DBusMessage00; body: ptr glib.Variant00) {.
    importc: "g_dbus_message_set_body", libprag.}

proc setBody*(self: DBusMessage; body: glib.Variant) =
  g_dbus_message_set_body(cast[ptr DBusMessage00](self.impl), cast[ptr glib.Variant00](body.impl))

proc `body=`*(self: DBusMessage; body: glib.Variant) =
  g_dbus_message_set_body(cast[ptr DBusMessage00](self.impl), cast[ptr glib.Variant00](body.impl))

proc g_dbus_message_set_destination*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_destination", libprag.}

proc setDestination*(self: DBusMessage; value: string) =
  g_dbus_message_set_destination(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `destination=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_destination(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_error_name*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_error_name", libprag.}

proc setErrorName*(self: DBusMessage; value: string) =
  g_dbus_message_set_error_name(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `errorName=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_error_name(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_interface*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_interface", libprag.}

proc setInterface*(self: DBusMessage; value: string) =
  g_dbus_message_set_interface(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `interface=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_interface(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_member*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_member", libprag.}

proc setMember*(self: DBusMessage; value: string) =
  g_dbus_message_set_member(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `member=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_member(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_num_unix_fds*(self: ptr DBusMessage00; value: uint32) {.
    importc: "g_dbus_message_set_num_unix_fds", libprag.}

proc setNumUnixFds*(self: DBusMessage; value: int) =
  g_dbus_message_set_num_unix_fds(cast[ptr DBusMessage00](self.impl), uint32(value))

proc `numUnixFds=`*(self: DBusMessage; value: int) =
  g_dbus_message_set_num_unix_fds(cast[ptr DBusMessage00](self.impl), uint32(value))

proc g_dbus_message_set_path*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_path", libprag.}

proc setPath*(self: DBusMessage; value: string) =
  g_dbus_message_set_path(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `path=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_path(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_reply_serial*(self: ptr DBusMessage00; value: uint32) {.
    importc: "g_dbus_message_set_reply_serial", libprag.}

proc setReplySerial*(self: DBusMessage; value: int) =
  g_dbus_message_set_reply_serial(cast[ptr DBusMessage00](self.impl), uint32(value))

proc `replySerial=`*(self: DBusMessage; value: int) =
  g_dbus_message_set_reply_serial(cast[ptr DBusMessage00](self.impl), uint32(value))

proc g_dbus_message_set_sender*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_sender", libprag.}

proc setSender*(self: DBusMessage; value: string) =
  g_dbus_message_set_sender(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `sender=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_sender(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_serial*(self: ptr DBusMessage00; serial: uint32) {.
    importc: "g_dbus_message_set_serial", libprag.}

proc setSerial*(self: DBusMessage; serial: int) =
  g_dbus_message_set_serial(cast[ptr DBusMessage00](self.impl), uint32(serial))

proc `serial=`*(self: DBusMessage; serial: int) =
  g_dbus_message_set_serial(cast[ptr DBusMessage00](self.impl), uint32(serial))

proc g_dbus_message_set_signature*(self: ptr DBusMessage00; value: cstring) {.
    importc: "g_dbus_message_set_signature", libprag.}

proc setSignature*(self: DBusMessage; value: string) =
  g_dbus_message_set_signature(cast[ptr DBusMessage00](self.impl), cstring(value))

proc `signature=`*(self: DBusMessage; value: string) =
  g_dbus_message_set_signature(cast[ptr DBusMessage00](self.impl), cstring(value))

proc g_dbus_message_set_unix_fd_list*(self: ptr DBusMessage00; fdList: ptr UnixFDList00) {.
    importc: "g_dbus_message_set_unix_fd_list", libprag.}

proc setUnixFdList*(self: DBusMessage; fdList: UnixFDList) =
  g_dbus_message_set_unix_fd_list(cast[ptr DBusMessage00](self.impl), cast[ptr UnixFDList00](fdList.impl))

proc `unixFdList=`*(self: DBusMessage; fdList: UnixFDList) =
  g_dbus_message_set_unix_fd_list(cast[ptr DBusMessage00](self.impl), cast[ptr UnixFDList00](fdList.impl))

proc g_dbus_message_to_blob*(self: ptr DBusMessage00; outSize: var uint64; capabilities: DBusCapabilityFlags): uint8Array {.
    importc: "g_dbus_message_to_blob", libprag.}

proc toBlob*(self: DBusMessage; outSize: var uint64; capabilities: DBusCapabilityFlags): uint8Array =
  g_dbus_message_to_blob(cast[ptr DBusMessage00](self.impl), outSize, capabilities)

proc g_dbus_message_to_gerror*(self: ptr DBusMessage00): gboolean {.
    importc: "g_dbus_message_to_gerror", libprag.}

proc toGerror*(self: DBusMessage): bool =
  toBool(g_dbus_message_to_gerror(cast[ptr DBusMessage00](self.impl)))

proc g_dbus_connection_send_message_with_reply_finish*(self: ptr DBusConnection00; res: ptr AsyncResult00): ptr DBusMessage00 {.
    importc: "g_dbus_connection_send_message_with_reply_finish", libprag.}

proc sendMessageWithReplyFinish*(self: DBusConnection; res: AsyncResult): DBusMessage =
  let gobj = g_dbus_connection_send_message_with_reply_finish(cast[ptr DBusConnection00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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
  DBusSendMessageFlag* {.size: sizeof(cint), pure.} = enum
    preserveSerial = 1

  DBusSendMessageFlags* {.size: sizeof(cint).} = set[DBusSendMessageFlag]

proc g_dbus_connection_send_message*(self: ptr DBusConnection00; message: ptr DBusMessage00; 
    flags: DBusSendMessageFlags; outSerial: var uint32): gboolean {.
    importc: "g_dbus_connection_send_message", libprag.}

proc sendMessage*(self: DBusConnection; message: DBusMessage; flags: DBusSendMessageFlags; 
    outSerial: var int): bool =
  var outSerial_00 = uint32(outSerial)
  result = toBool(g_dbus_connection_send_message(cast[ptr DBusConnection00](self.impl), cast[ptr DBusMessage00](message.impl), flags, outSerial_00))
  outSerial = int(outSerial_00)

proc g_dbus_connection_send_message_with_reply_sync*(self: ptr DBusConnection00; message: ptr DBusMessage00; 
    flags: DBusSendMessageFlags; timeoutMsec: int32; outSerial: var uint32; cancellable: ptr Cancellable00): ptr DBusMessage00 {.
    importc: "g_dbus_connection_send_message_with_reply_sync", libprag.}

proc sendMessageWithReplySync*(self: DBusConnection; message: DBusMessage; flags: DBusSendMessageFlags; 
    timeoutMsec: int; outSerial: var int; cancellable: Cancellable): DBusMessage =
  var outSerial_00 = uint32(outSerial)
  let gobj = g_dbus_connection_send_message_with_reply_sync(cast[ptr DBusConnection00](self.impl), cast[ptr DBusMessage00](message.impl), flags, int32(timeoutMsec), outSerial_00, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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
  outSerial = int(outSerial_00)

type
  DBusMessageByteOrder* {.size: sizeof(cint), pure.} = enum
    bigEndian = 66
    littleEndian = 108

proc g_dbus_message_get_byte_order*(self: ptr DBusMessage00): DBusMessageByteOrder {.
    importc: "g_dbus_message_get_byte_order", libprag.}

proc getByteOrder*(self: DBusMessage): DBusMessageByteOrder =
  g_dbus_message_get_byte_order(cast[ptr DBusMessage00](self.impl))

proc byteOrder*(self: DBusMessage): DBusMessageByteOrder =
  g_dbus_message_get_byte_order(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_set_byte_order*(self: ptr DBusMessage00; byteOrder: DBusMessageByteOrder) {.
    importc: "g_dbus_message_set_byte_order", libprag.}

proc setByteOrder*(self: DBusMessage; byteOrder: DBusMessageByteOrder) =
  g_dbus_message_set_byte_order(cast[ptr DBusMessage00](self.impl), byteOrder)

proc `byteOrder=`*(self: DBusMessage; byteOrder: DBusMessageByteOrder) =
  g_dbus_message_set_byte_order(cast[ptr DBusMessage00](self.impl), byteOrder)

type
  DBusMessageFlag* {.size: sizeof(cint), pure.} = enum
    noReplyExpected = 1
    noAutoStart = 2
    allowInteractiveAuthorization = 3

  DBusMessageFlags* {.size: sizeof(cint).} = set[DBusMessageFlag]

proc g_dbus_message_get_flags*(self: ptr DBusMessage00): DBusMessageFlags {.
    importc: "g_dbus_message_get_flags", libprag.}

proc getFlags*(self: DBusMessage): DBusMessageFlags =
  g_dbus_message_get_flags(cast[ptr DBusMessage00](self.impl))

proc flags*(self: DBusMessage): DBusMessageFlags =
  g_dbus_message_get_flags(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_set_flags*(self: ptr DBusMessage00; flags: DBusMessageFlags) {.
    importc: "g_dbus_message_set_flags", libprag.}

proc setFlags*(self: DBusMessage; flags: DBusMessageFlags) =
  g_dbus_message_set_flags(cast[ptr DBusMessage00](self.impl), flags)

proc `flags=`*(self: DBusMessage; flags: DBusMessageFlags) =
  g_dbus_message_set_flags(cast[ptr DBusMessage00](self.impl), flags)

type
  DBusMessageHeaderField* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    path = 1
    `interface` = 2
    member = 3
    errorName = 4
    replySerial = 5
    destination = 6
    sender = 7
    signature = 8
    numUnixFds = 9

proc g_dbus_message_get_header*(self: ptr DBusMessage00; headerField: DBusMessageHeaderField): ptr glib.Variant00 {.
    importc: "g_dbus_message_get_header", libprag.}

proc getHeader*(self: DBusMessage; headerField: DBusMessageHeaderField): glib.Variant =
  new(result)
  result.impl = g_dbus_message_get_header(cast[ptr DBusMessage00](self.impl), headerField)

proc header*(self: DBusMessage; headerField: DBusMessageHeaderField): glib.Variant =
  new(result)
  result.impl = g_dbus_message_get_header(cast[ptr DBusMessage00](self.impl), headerField)

proc g_dbus_message_set_header*(self: ptr DBusMessage00; headerField: DBusMessageHeaderField; 
    value: ptr glib.Variant00) {.
    importc: "g_dbus_message_set_header", libprag.}

proc setHeader*(self: DBusMessage; headerField: DBusMessageHeaderField; 
    value: glib.Variant) =
  g_dbus_message_set_header(cast[ptr DBusMessage00](self.impl), headerField, cast[ptr glib.Variant00](value.impl))

type
  DBusMessageType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    methodCall = 1
    methodReturn = 2
    error = 3
    signal = 4

proc g_dbus_message_get_message_type*(self: ptr DBusMessage00): DBusMessageType {.
    importc: "g_dbus_message_get_message_type", libprag.}

proc getMessageType*(self: DBusMessage): DBusMessageType =
  g_dbus_message_get_message_type(cast[ptr DBusMessage00](self.impl))

proc messageType*(self: DBusMessage): DBusMessageType =
  g_dbus_message_get_message_type(cast[ptr DBusMessage00](self.impl))

proc g_dbus_message_set_message_type*(self: ptr DBusMessage00; `type`: DBusMessageType) {.
    importc: "g_dbus_message_set_message_type", libprag.}

proc setMessageType*(self: DBusMessage; `type`: DBusMessageType) =
  g_dbus_message_set_message_type(cast[ptr DBusMessage00](self.impl), `type`)

proc `messageType=`*(self: DBusMessage; `type`: DBusMessageType) =
  g_dbus_message_set_message_type(cast[ptr DBusMessage00](self.impl), `type`)

type
  DBusSignalFlag* {.size: sizeof(cint), pure.} = enum
    noMatchRule = 1
    matchArg0Namespace = 2
    matchArg0Path = 3

  DBusSignalFlags* {.size: sizeof(cint).} = set[DBusSignalFlag]

type
  Notification* = ref object of gobject.Object
  Notification00* = object of gobject.Object00

proc g_notification_new*(title: cstring): ptr Notification00 {.
    importc: "g_notification_new", libprag.}

proc newNotification*(title: string): Notification =
  new(result, finalizeGObject)
  result.impl = g_notification_new(cstring(title))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNotification*[T](result: var T; title: string) =
  assert(result is Notification)
  new(result, finalizeGObject)
  result.impl = g_notification_new(cstring(title))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_notification_add_button*(self: ptr Notification00; label: cstring; detailedAction: cstring) {.
    importc: "g_notification_add_button", libprag.}

proc addButton*(self: Notification; label: string; detailedAction: string) =
  g_notification_add_button(cast[ptr Notification00](self.impl), cstring(label), cstring(detailedAction))

proc g_notification_add_button_with_target_value*(self: ptr Notification00; label: cstring; action: cstring; 
    target: ptr glib.Variant00) {.
    importc: "g_notification_add_button_with_target_value", libprag.}

proc addButtonWithTarget*(self: Notification; label: string; action: string; 
    target: glib.Variant) =
  g_notification_add_button_with_target_value(cast[ptr Notification00](self.impl), cstring(label), cstring(action), cast[ptr glib.Variant00](target.impl))

proc g_notification_set_body*(self: ptr Notification00; body: cstring) {.
    importc: "g_notification_set_body", libprag.}

proc setBody*(self: Notification; body: string) =
  g_notification_set_body(cast[ptr Notification00](self.impl), cstring(body))

proc `body=`*(self: Notification; body: string) =
  g_notification_set_body(cast[ptr Notification00](self.impl), cstring(body))

proc g_notification_set_default_action*(self: ptr Notification00; detailedAction: cstring) {.
    importc: "g_notification_set_default_action", libprag.}

proc setDefaultAction*(self: Notification; detailedAction: string) =
  g_notification_set_default_action(cast[ptr Notification00](self.impl), cstring(detailedAction))

proc `defaultAction=`*(self: Notification; detailedAction: string) =
  g_notification_set_default_action(cast[ptr Notification00](self.impl), cstring(detailedAction))

proc g_notification_set_default_action_and_target_value*(self: ptr Notification00; action: cstring; target: ptr glib.Variant00) {.
    importc: "g_notification_set_default_action_and_target_value", libprag.}

proc setDefaultActionAndTarget*(self: Notification; action: string; target: glib.Variant) =
  g_notification_set_default_action_and_target_value(cast[ptr Notification00](self.impl), cstring(action), cast[ptr glib.Variant00](target.impl))

proc g_notification_set_icon*(self: ptr Notification00; icon: ptr Icon00) {.
    importc: "g_notification_set_icon", libprag.}

proc setIcon*(self: Notification; icon: Icon) =
  g_notification_set_icon(cast[ptr Notification00](self.impl), cast[ptr Icon00](icon.impl))

proc `icon=`*(self: Notification; icon: Icon) =
  g_notification_set_icon(cast[ptr Notification00](self.impl), cast[ptr Icon00](icon.impl))

proc g_notification_set_title*(self: ptr Notification00; title: cstring) {.
    importc: "g_notification_set_title", libprag.}

proc setTitle*(self: Notification; title: string) =
  g_notification_set_title(cast[ptr Notification00](self.impl), cstring(title))

proc `title=`*(self: Notification; title: string) =
  g_notification_set_title(cast[ptr Notification00](self.impl), cstring(title))

proc g_notification_set_urgent*(self: ptr Notification00; urgent: gboolean) {.
    importc: "g_notification_set_urgent", libprag.}

proc setUrgent*(self: Notification; urgent: bool) =
  g_notification_set_urgent(cast[ptr Notification00](self.impl), gboolean(urgent))

proc `urgent=`*(self: Notification; urgent: bool) =
  g_notification_set_urgent(cast[ptr Notification00](self.impl), gboolean(urgent))

proc g_application_send_notification*(self: ptr Application00; id: cstring; notification: ptr Notification00) {.
    importc: "g_application_send_notification", libprag.}

proc sendNotification*(self: Application; id: string; notification: Notification) =
  g_application_send_notification(cast[ptr Application00](self.impl), cstring(id), cast[ptr Notification00](notification.impl))

type
  NotificationPriority* {.size: sizeof(cint), pure.} = enum
    normal = 0
    low = 1
    high = 2
    urgent = 3

proc g_notification_set_priority*(self: ptr Notification00; priority: NotificationPriority) {.
    importc: "g_notification_set_priority", libprag.}

proc setPriority*(self: Notification; priority: NotificationPriority) =
  g_notification_set_priority(cast[ptr Notification00](self.impl), priority)

proc `priority=`*(self: Notification; priority: NotificationPriority) =
  g_notification_set_priority(cast[ptr Notification00](self.impl), priority)

type
  ApplicationFlag* {.size: sizeof(cint), pure.} = enum
    isService = 1
    isLauncher = 2
    handlesOpen = 3
    handlesCommandLine = 4
    sendEnvironment = 5
    nonUnique = 6
    canOverrideAppId = 7

  ApplicationFlags* {.size: sizeof(cint).} = set[ApplicationFlag]

proc g_application_new*(applicationId: cstring; flags: ApplicationFlags): ptr Application00 {.
    importc: "g_application_new", libprag.}

proc newApplication*(applicationId: string; flags: ApplicationFlags): Application =
  new(result, finalizeGObject)
  result.impl = g_application_new(cstring(applicationId), flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initApplication*[T](result: var T; applicationId: string; flags: ApplicationFlags) =
  assert(result is Application)
  new(result, finalizeGObject)
  result.impl = g_application_new(cstring(applicationId), flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_application_get_flags*(self: ptr Application00): ApplicationFlags {.
    importc: "g_application_get_flags", libprag.}

proc getFlags*(self: Application): ApplicationFlags =
  g_application_get_flags(cast[ptr Application00](self.impl))

proc flags*(self: Application): ApplicationFlags =
  g_application_get_flags(cast[ptr Application00](self.impl))

proc g_application_set_flags*(self: ptr Application00; flags: ApplicationFlags) {.
    importc: "g_application_set_flags", libprag.}

proc setFlags*(self: Application; flags: ApplicationFlags) =
  g_application_set_flags(cast[ptr Application00](self.impl), flags)

proc `flags=`*(self: Application; flags: ApplicationFlags) =
  g_application_set_flags(cast[ptr Application00](self.impl), flags)

type
  InputStreamPrivate00* {.pure.} = object
  InputStreamPrivate* = ref object
    impl*: ptr InputStreamPrivate00

type
  InputStream* = ref object of gobject.Object
  InputStream00* = object of gobject.Object00
    priv1: ptr InputStreamPrivate00

proc g_input_stream_clear_pending*(self: ptr InputStream00) {.
    importc: "g_input_stream_clear_pending", libprag.}

proc clearPending*(self: InputStream) =
  g_input_stream_clear_pending(cast[ptr InputStream00](self.impl))

proc g_input_stream_close*(self: ptr InputStream00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_input_stream_close", libprag.}

proc close*(self: InputStream; cancellable: Cancellable): bool =
  toBool(g_input_stream_close(cast[ptr InputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_input_stream_close_finish*(self: ptr InputStream00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_input_stream_close_finish", libprag.}

proc closeFinish*(self: InputStream; resu: AsyncResult): bool =
  toBool(g_input_stream_close_finish(cast[ptr InputStream00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_input_stream_has_pending*(self: ptr InputStream00): gboolean {.
    importc: "g_input_stream_has_pending", libprag.}

proc hasPending*(self: InputStream): bool =
  toBool(g_input_stream_has_pending(cast[ptr InputStream00](self.impl)))

proc g_input_stream_is_closed*(self: ptr InputStream00): gboolean {.
    importc: "g_input_stream_is_closed", libprag.}

proc isClosed*(self: InputStream): bool =
  toBool(g_input_stream_is_closed(cast[ptr InputStream00](self.impl)))

proc g_input_stream_read*(self: ptr InputStream00; buffer: uint8Array; count: uint64; 
    cancellable: ptr Cancellable00): int64 {.
    importc: "g_input_stream_read", libprag.}

proc read*(self: InputStream; buffer: uint8Array; count: uint64; 
    cancellable: Cancellable): int64 =
  g_input_stream_read(cast[ptr InputStream00](self.impl), buffer, count, cast[ptr Cancellable00](cancellable.impl))

proc g_input_stream_read_all*(self: ptr InputStream00; buffer: uint8Array; count: uint64; 
    bytesRead: var uint64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_input_stream_read_all", libprag.}

proc readAll*(self: InputStream; buffer: uint8Array; count: uint64; 
    bytesRead: var uint64; cancellable: Cancellable): bool =
  toBool(g_input_stream_read_all(cast[ptr InputStream00](self.impl), buffer, count, bytesRead, cast[ptr Cancellable00](cancellable.impl)))

proc g_input_stream_read_all_finish*(self: ptr InputStream00; resu: ptr AsyncResult00; 
    bytesRead: var uint64): gboolean {.
    importc: "g_input_stream_read_all_finish", libprag.}

proc readAllFinish*(self: InputStream; resu: AsyncResult; bytesRead: var uint64): bool =
  toBool(g_input_stream_read_all_finish(cast[ptr InputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), bytesRead))

proc g_input_stream_read_bytes*(self: ptr InputStream00; count: uint64; cancellable: ptr Cancellable00): ptr glib.Bytes00 {.
    importc: "g_input_stream_read_bytes", libprag.}

proc readBytes*(self: InputStream; count: uint64; cancellable: Cancellable): glib.Bytes =
  new(result)
  result.impl = g_input_stream_read_bytes(cast[ptr InputStream00](self.impl), count, cast[ptr Cancellable00](cancellable.impl))

proc g_input_stream_read_bytes_finish*(self: ptr InputStream00; resu: ptr AsyncResult00): ptr glib.Bytes00 {.
    importc: "g_input_stream_read_bytes_finish", libprag.}

proc readBytesFinish*(self: InputStream; resu: AsyncResult): glib.Bytes =
  new(result)
  result.impl = g_input_stream_read_bytes_finish(cast[ptr InputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_input_stream_read_finish*(self: ptr InputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_input_stream_read_finish", libprag.}

proc readFinish*(self: InputStream; resu: AsyncResult): int64 =
  g_input_stream_read_finish(cast[ptr InputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_input_stream_set_pending*(self: ptr InputStream00): gboolean {.
    importc: "g_input_stream_set_pending", libprag.}

proc setPending*(self: InputStream): bool =
  toBool(g_input_stream_set_pending(cast[ptr InputStream00](self.impl)))

proc `pending=`*(self: InputStream): bool =
  toBool(g_input_stream_set_pending(cast[ptr InputStream00](self.impl)))

proc g_input_stream_skip*(self: ptr InputStream00; count: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_input_stream_skip", libprag.}

proc skip*(self: InputStream; count: uint64; cancellable: Cancellable): int64 =
  g_input_stream_skip(cast[ptr InputStream00](self.impl), count, cast[ptr Cancellable00](cancellable.impl))

proc g_input_stream_skip_finish*(self: ptr InputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_input_stream_skip_finish", libprag.}

proc skipFinish*(self: InputStream; resu: AsyncResult): int64 =
  g_input_stream_skip_finish(cast[ptr InputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_application_command_line_get_stdin*(self: ptr ApplicationCommandLine00): ptr InputStream00 {.
    importc: "g_application_command_line_get_stdin", libprag.}

proc getStdin*(self: ApplicationCommandLine): InputStream =
  let gobj = g_application_command_line_get_stdin(cast[ptr ApplicationCommandLine00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc stdin*(self: ApplicationCommandLine): InputStream =
  let gobj = g_application_command_line_get_stdin(cast[ptr ApplicationCommandLine00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc g_io_stream_get_input_stream*(self: ptr IOStream00): ptr InputStream00 {.
    importc: "g_io_stream_get_input_stream", libprag.}

proc getInputStream*(self: IOStream): InputStream =
  let gobj = g_io_stream_get_input_stream(cast[ptr IOStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc inputStream*(self: IOStream): InputStream =
  let gobj = g_io_stream_get_input_stream(cast[ptr IOStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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
  FileInputStreamPrivate00* {.pure.} = object
  FileInputStreamPrivate* = ref object
    impl*: ptr FileInputStreamPrivate00

type
  FileInputStream* = ref object of InputStream
  FileInputStream00* = object of InputStream00
    priv2: ptr FileInputStreamPrivate00

proc g_file_input_stream_query_info*(self: ptr FileInputStream00; attributes: cstring; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.
    importc: "g_file_input_stream_query_info", libprag.}

proc queryInfo*(self: FileInputStream; attributes: string; cancellable: Cancellable): FileInfo =
  let gobj = g_file_input_stream_query_info(cast[ptr FileInputStream00](self.impl), cstring(attributes), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_input_stream_query_info_finish*(self: ptr FileInputStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.
    importc: "g_file_input_stream_query_info_finish", libprag.}

proc queryInfoFinish*(self: FileInputStream; resu: AsyncResult): FileInfo =
  let gobj = g_file_input_stream_query_info_finish(cast[ptr FileInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_file_read*(self: ptr File00; cancellable: ptr Cancellable00): ptr FileInputStream00 {.
    importc: "g_file_read", libprag.}

proc read*(self: File; cancellable: Cancellable): FileInputStream =
  let gobj = g_file_read(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInputStream](g_object_get_qdata(gobj, Quark))
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

proc g_file_read_finish*(self: ptr File00; res: ptr AsyncResult00): ptr FileInputStream00 {.
    importc: "g_file_read_finish", libprag.}

proc readFinish*(self: File; res: AsyncResult): FileInputStream =
  let gobj = g_file_read_finish(cast[ptr File00](self.impl), cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInputStream](g_object_get_qdata(gobj, Quark))
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
  OutputStreamSpliceFlag* {.size: sizeof(cint), pure.} = enum
    closeSource = 1
    closeTarget = 2

  OutputStreamSpliceFlags* {.size: sizeof(cint).} = set[OutputStreamSpliceFlag]

proc g_output_stream_splice*(self: ptr OutputStream00; source: ptr InputStream00; 
    flags: OutputStreamSpliceFlags; cancellable: ptr Cancellable00): int64 {.
    importc: "g_output_stream_splice", libprag.}

proc splice*(self: OutputStream; source: InputStream; flags: OutputStreamSpliceFlags; 
    cancellable: Cancellable): int64 =
  g_output_stream_splice(cast[ptr OutputStream00](self.impl), cast[ptr InputStream00](source.impl), flags, cast[ptr Cancellable00](cancellable.impl))

type
  ApplicationClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    startup*: proc(application: ptr Application00) {.cdecl.}
    activate*: proc(application: ptr Application00) {.cdecl.}
    open*: proc(application: ptr Application00; files: ptr File00Array; 
    nFiles: int32; hint: cstring) {.cdecl.}
    commandLine*: proc(application: ptr Application00; commandLine: ptr ApplicationCommandLine00): int32 {.cdecl.}
    localCommandLine*: proc(application: ptr Application00; arguments: cstringArray; 
    exitStatus: var int32): gboolean {.cdecl.}
    beforeEmit*: proc(application: ptr Application00; platformData: ptr glib.Variant00) {.cdecl.}
    afterEmit*: proc(application: ptr Application00; platformData: ptr glib.Variant00) {.cdecl.}
    addPlatformData*: proc(application: ptr Application00; builder: ptr glib.VariantBuilder00) {.cdecl.}
    quitMainloop*: proc(application: ptr Application00) {.cdecl.}
    runMainloop*: proc(application: ptr Application00) {.cdecl.}
    shutdown*: proc(application: ptr Application00) {.cdecl.}
    dbusRegister*: proc(application: ptr Application00; connection: ptr DBusConnection00; 
    objectPath: cstring): gboolean {.cdecl.}
    dbusUnregister*: proc(application: ptr Application00; connection: ptr DBusConnection00; 
    objectPath: cstring) {.cdecl.}
    handleLocalOptions*: proc(application: ptr Application00; options: ptr glib.VariantDict00): int32 {.cdecl.}
    padding*: array[8, pointer]
  ApplicationClass* = ref object
    impl*: ptr ApplicationClass00

type
  ApplicationCommandLineClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    printLiteral*: proc(cmdline: ptr ApplicationCommandLine00; message: cstring) {.cdecl.}
    printerrLiteral*: proc(cmdline: ptr ApplicationCommandLine00; message: cstring) {.cdecl.}
    getStdin*: proc(cmdline: ptr ApplicationCommandLine00): ptr InputStream00 {.cdecl.}
    padding*: array[11, pointer]
  ApplicationCommandLineClass* = ref object
    impl*: ptr ApplicationCommandLineClass00

type
  AsyncInitable00* {.pure.} = object
  AsyncInitable* = ref object
    impl*: ptr AsyncInitable00

proc g_async_initable_init_finish*(self: ptr AsyncInitable00; res: ptr AsyncResult00): gboolean {.
    importc: "g_async_initable_init_finish", libprag.}

proc initFinish*(self: AsyncInitable; res: AsyncResult): bool =
  toBool(g_async_initable_init_finish(cast[ptr AsyncInitable00](self.impl), cast[ptr AsyncResult00](res.impl)))

proc g_async_initable_new_finish*(self: ptr AsyncInitable00; res: ptr AsyncResult00): ptr gobject.Object00 {.
    importc: "g_async_initable_new_finish", libprag.}

proc newAsyncInitableFinish*(self: AsyncInitable; res: AsyncResult): gobject.Object =
  let gobj = g_async_initable_new_finish(cast[ptr AsyncInitable00](self.impl), cast[ptr AsyncResult00](res.impl))
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
  AsyncReadyCallback* = proc (sourceObject: ptr gobject.Object00; res: ptr AsyncResult00; 
    userData: pointer) {.cdecl.}

type
  AsyncInitableIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    initAsync*: proc(initable: ptr AsyncInitable00; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    initFinish*: proc(initable: ptr AsyncInitable00; res: ptr AsyncResult00): gboolean {.cdecl.}
  AsyncInitableIface* = ref object
    impl*: ptr AsyncInitableIface00

proc g_app_info_launch_default_for_uri_async*(uri: cstring; launchContext: ptr AppLaunchContext00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_app_info_launch_default_for_uri_async", libprag.}

proc launchDefaultForUriAsync*(uri: string; launchContext: AppLaunchContext; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_app_info_launch_default_for_uri_async(cstring(uri), cast[ptr AppLaunchContext00](launchContext.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_append_to_async*(self: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_append_to_async", libprag.}

proc appendToAsync*(self: File; flags: FileCreateFlags; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_append_to_async(cast[ptr File00](self.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_create_async*(self: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_create_async", libprag.}

proc createAsync*(self: File; flags: FileCreateFlags; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_create_async(cast[ptr File00](self.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_create_readwrite_async*(self: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_create_readwrite_async", libprag.}

proc createReadwriteAsync*(self: File; flags: FileCreateFlags; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_create_readwrite_async(cast[ptr File00](self.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_delete_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_delete_async", libprag.}

proc deleteAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_delete_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_eject_mountable*(self: ptr File00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_eject_mountable", libprag.}

proc ejectMountable*(self: File; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_eject_mountable(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_eject_mountable_with_operation*(self: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_eject_mountable_with_operation", libprag.}

proc ejectMountableWithOperation*(self: File; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_eject_mountable_with_operation(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_enumerate_children_async*(self: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_enumerate_children_async", libprag.}

proc enumerateChildrenAsync*(self: File; attributes: string; flags: FileQueryInfoFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_enumerate_children_async(cast[ptr File00](self.impl), cstring(attributes), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_find_enclosing_mount_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_find_enclosing_mount_async", libprag.}

proc findEnclosingMountAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_find_enclosing_mount_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_load_contents_async*(self: ptr File00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_load_contents_async", libprag.}

proc loadContentsAsync*(self: File; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_file_load_contents_async(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_make_directory_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_make_directory_async", libprag.}

proc makeDirectoryAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_make_directory_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_mount_enclosing_volume*(self: ptr File00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_mount_enclosing_volume", libprag.}

proc mountEnclosingVolume*(self: File; flags: MountMountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_mount_enclosing_volume(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_mount_mountable*(self: ptr File00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_mount_mountable", libprag.}

proc mountMountable*(self: File; flags: MountMountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_mount_mountable(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_open_readwrite_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_open_readwrite_async", libprag.}

proc openReadwriteAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_open_readwrite_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_poll_mountable*(self: ptr File00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_poll_mountable", libprag.}

proc pollMountable*(self: File; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_file_poll_mountable(cast[ptr File00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_query_filesystem_info_async*(self: ptr File00; attributes: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_query_filesystem_info_async", libprag.}

proc queryFilesystemInfoAsync*(self: File; attributes: string; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_query_filesystem_info_async(cast[ptr File00](self.impl), cstring(attributes), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_query_info_async*(self: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_query_info_async", libprag.}

proc queryInfoAsync*(self: File; attributes: string; flags: FileQueryInfoFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_query_info_async(cast[ptr File00](self.impl), cstring(attributes), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_read_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_read_async", libprag.}

proc readAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_read_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_replace_async*(self: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_replace_async", libprag.}

proc replaceAsync*(self: File; etag: string; makeBackup: bool; flags: FileCreateFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_replace_async(cast[ptr File00](self.impl), cstring(etag), gboolean(makeBackup), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_replace_contents_async*(self: ptr File00; contents: uint8Array; length: uint64; 
    etag: cstring; makeBackup: gboolean; flags: FileCreateFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_replace_contents_async", libprag.}

proc replaceContentsAsync*(self: File; contents: uint8Array; length: uint64; 
    etag: string; makeBackup: bool; flags: FileCreateFlags; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_file_replace_contents_async(cast[ptr File00](self.impl), contents, length, cstring(etag), gboolean(makeBackup), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_replace_contents_bytes_async*(self: ptr File00; contents: ptr glib.Bytes00; etag: cstring; 
    makeBackup: gboolean; flags: FileCreateFlags; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_replace_contents_bytes_async", libprag.}

proc replaceContentsBytesAsync*(self: File; contents: glib.Bytes; etag: string; makeBackup: bool; 
    flags: FileCreateFlags; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_file_replace_contents_bytes_async(cast[ptr File00](self.impl), cast[ptr glib.Bytes00](contents.impl), cstring(etag), gboolean(makeBackup), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_replace_readwrite_async*(self: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_replace_readwrite_async", libprag.}

proc replaceReadwriteAsync*(self: File; etag: string; makeBackup: bool; flags: FileCreateFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_replace_readwrite_async(cast[ptr File00](self.impl), cstring(etag), gboolean(makeBackup), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_set_attributes_async*(self: ptr File00; info: ptr FileInfo00; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_file_set_attributes_async", libprag.}

proc setAttributesAsync*(self: File; info: FileInfo; flags: FileQueryInfoFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_set_attributes_async(cast[ptr File00](self.impl), cast[ptr FileInfo00](info.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_set_display_name_async*(self: ptr File00; displayName: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_set_display_name_async", libprag.}

proc setDisplayNameAsync*(self: File; displayName: string; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_set_display_name_async(cast[ptr File00](self.impl), cstring(displayName), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_start_mountable*(self: ptr File00; flags: DriveStartFlags; startOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_start_mountable", libprag.}

proc startMountable*(self: File; flags: DriveStartFlags; startOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_start_mountable(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](startOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_stop_mountable*(self: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_stop_mountable", libprag.}

proc stopMountable*(self: File; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_stop_mountable(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_trash_async*(self: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_trash_async", libprag.}

proc trashAsync*(self: File; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_trash_async(cast[ptr File00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_unmount_mountable*(self: ptr File00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_unmount_mountable", libprag.}

proc unmountMountable*(self: File; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_unmount_mountable(cast[ptr File00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_unmount_mountable_with_operation*(self: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_unmount_mountable_with_operation", libprag.}

proc unmountMountableWithOperation*(self: File; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_unmount_mountable_with_operation(cast[ptr File00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_enumerator_close_async*(self: ptr FileEnumerator00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_enumerator_close_async", libprag.}

proc closeAsync*(self: FileEnumerator; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_file_enumerator_close_async(cast[ptr FileEnumerator00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_enumerator_next_files_async*(self: ptr FileEnumerator00; numFiles: int32; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_enumerator_next_files_async", libprag.}

proc nextFilesAsync*(self: FileEnumerator; numFiles: int; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_enumerator_next_files_async(cast[ptr FileEnumerator00](self.impl), int32(numFiles), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_eject*(self: ptr Mount00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_mount_eject", libprag.}

proc eject*(self: Mount; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_mount_eject(cast[ptr Mount00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_eject_with_operation*(self: ptr Mount00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_mount_eject_with_operation", libprag.}

proc ejectWithOperation*(self: Mount; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_mount_eject_with_operation(cast[ptr Mount00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_guess_content_type*(self: ptr Mount00; forceRescan: gboolean; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_mount_guess_content_type", libprag.}

proc guessContentType*(self: Mount; forceRescan: bool; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_mount_guess_content_type(cast[ptr Mount00](self.impl), gboolean(forceRescan), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_remount*(self: ptr Mount00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_mount_remount", libprag.}

proc remount*(self: Mount; flags: MountMountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_mount_remount(cast[ptr Mount00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_unmount*(self: ptr Mount00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_mount_unmount", libprag.}

proc unmount*(self: Mount; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_mount_unmount(cast[ptr Mount00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_mount_unmount_with_operation*(self: ptr Mount00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_mount_unmount_with_operation", libprag.}

proc unmountWithOperation*(self: Mount; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_mount_unmount_with_operation(cast[ptr Mount00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_drive_eject*(self: ptr Drive00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_drive_eject", libprag.}

proc eject*(self: Drive; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_drive_eject(cast[ptr Drive00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_drive_eject_with_operation*(self: ptr Drive00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_drive_eject_with_operation", libprag.}

proc ejectWithOperation*(self: Drive; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_drive_eject_with_operation(cast[ptr Drive00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_drive_poll_for_media*(self: ptr Drive00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_drive_poll_for_media", libprag.}

proc pollForMedia*(self: Drive; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_drive_poll_for_media(cast[ptr Drive00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_drive_start*(self: ptr Drive00; flags: DriveStartFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_drive_start", libprag.}

proc start*(self: Drive; flags: DriveStartFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_drive_start(cast[ptr Drive00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_drive_stop*(self: ptr Drive00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_drive_stop", libprag.}

proc stop*(self: Drive; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_drive_stop(cast[ptr Drive00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_volume_eject*(self: ptr Volume00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_volume_eject", libprag.}

proc eject*(self: Volume; flags: MountUnmountFlags; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_volume_eject(cast[ptr Volume00](self.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_volume_eject_with_operation*(self: ptr Volume00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_volume_eject_with_operation", libprag.}

proc ejectWithOperation*(self: Volume; flags: MountUnmountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_volume_eject_with_operation(cast[ptr Volume00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_volume_mount*(self: ptr Volume00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_volume_mount", libprag.}

proc mount*(self: Volume; flags: MountMountFlags; mountOperation: MountOperation; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_volume_mount(cast[ptr Volume00](self.impl), flags, cast[ptr MountOperation00](mountOperation.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_close_async*(self: ptr OutputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_output_stream_close_async", libprag.}

proc closeAsync*(self: OutputStream; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_output_stream_close_async(cast[ptr OutputStream00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_flush_async*(self: ptr OutputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_output_stream_flush_async", libprag.}

proc flushAsync*(self: OutputStream; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_output_stream_flush_async(cast[ptr OutputStream00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_splice_async*(self: ptr OutputStream00; source: ptr InputStream00; 
    flags: OutputStreamSpliceFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_output_stream_splice_async", libprag.}

proc spliceAsync*(self: OutputStream; source: InputStream; flags: OutputStreamSpliceFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_output_stream_splice_async(cast[ptr OutputStream00](self.impl), cast[ptr InputStream00](source.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_write_all_async*(self: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_output_stream_write_all_async", libprag.}

proc writeAllAsync*(self: OutputStream; buffer: uint8Array; count: uint64; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_output_stream_write_all_async(cast[ptr OutputStream00](self.impl), buffer, count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_write_async*(self: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_output_stream_write_async", libprag.}

proc writeAsync*(self: OutputStream; buffer: uint8Array; count: uint64; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_output_stream_write_async(cast[ptr OutputStream00](self.impl), buffer, count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_output_stream_write_bytes_async*(self: ptr OutputStream00; bytes: ptr glib.Bytes00; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_output_stream_write_bytes_async", libprag.}

proc writeBytesAsync*(self: OutputStream; bytes: glib.Bytes; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_output_stream_write_bytes_async(cast[ptr OutputStream00](self.impl), cast[ptr glib.Bytes00](bytes.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_output_stream_query_info_async*(self: ptr FileOutputStream00; attributes: cstring; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_output_stream_query_info_async", libprag.}

proc queryInfoAsync*(self: FileOutputStream; attributes: string; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_output_stream_query_info_async(cast[ptr FileOutputStream00](self.impl), cstring(attributes), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_io_stream_close_async*(self: ptr IOStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_io_stream_close_async", libprag.}

proc closeAsync*(self: IOStream; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_io_stream_close_async(cast[ptr IOStream00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_io_stream_splice_async*(self: ptr IOStream00; stream2: ptr IOStream00; flags: IOStreamSpliceFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_io_stream_splice_async", libprag.}

proc spliceAsync*(self: IOStream; stream2: IOStream; flags: IOStreamSpliceFlags; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_io_stream_splice_async(cast[ptr IOStream00](self.impl), cast[ptr IOStream00](stream2.impl), flags, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_io_stream_query_info_async*(self: ptr FileIOStream00; attributes: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_io_stream_query_info_async", libprag.}

proc queryInfoAsync*(self: FileIOStream; attributes: string; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_io_stream_query_info_async(cast[ptr FileIOStream00](self.impl), cstring(attributes), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_new*(stream: ptr IOStream00; guid: cstring; flags: DBusConnectionFlags; 
    observer: ptr DBusAuthObserver00; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_dbus_connection_new", libprag.}

proc new*(stream: IOStream; guid: string; flags: DBusConnectionFlags; 
    observer: DBusAuthObserver; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_connection_new(cast[ptr IOStream00](stream.impl), cstring(guid), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_new_for_address*(address: cstring; flags: DBusConnectionFlags; observer: ptr DBusAuthObserver00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_new_for_address", libprag.}

proc newForAddress*(address: string; flags: DBusConnectionFlags; observer: DBusAuthObserver; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_connection_new_for_address(cstring(address), flags, cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_call*(self: ptr DBusConnection00; busName: cstring; objectPath: cstring; 
    interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; replyType: ptr glib.VariantType00; 
    flags: DBusCallFlags; timeoutMsec: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_call", libprag.}

proc call*(self: DBusConnection; busName: string; objectPath: string; 
    interfaceName: string; methodName: string; parameters: glib.Variant; replyType: glib.VariantType; 
    flags: DBusCallFlags; timeoutMsec: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_connection_call(cast[ptr DBusConnection00](self.impl), cstring(busName), cstring(objectPath), cstring(interfaceName), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), cast[ptr glib.VariantType00](replyType.impl), flags, int32(timeoutMsec), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_call_with_unix_fd_list*(self: ptr DBusConnection00; busName: cstring; objectPath: cstring; 
    interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; replyType: ptr glib.VariantType00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_call_with_unix_fd_list", libprag.}

proc callWithUnixFdList*(self: DBusConnection; busName: string; objectPath: string; 
    interfaceName: string; methodName: string; parameters: glib.Variant; replyType: glib.VariantType; 
    flags: DBusCallFlags; timeoutMsec: int; fdList: UnixFDList; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_connection_call_with_unix_fd_list(cast[ptr DBusConnection00](self.impl), cstring(busName), cstring(objectPath), cstring(interfaceName), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), cast[ptr glib.VariantType00](replyType.impl), flags, int32(timeoutMsec), cast[ptr UnixFDList00](fdList.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_close*(self: ptr DBusConnection00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_close", libprag.}

proc close*(self: DBusConnection; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_dbus_connection_close(cast[ptr DBusConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_flush*(self: ptr DBusConnection00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_flush", libprag.}

proc flush*(self: DBusConnection; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_dbus_connection_flush(cast[ptr DBusConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_connection_send_message_with_reply*(self: ptr DBusConnection00; message: ptr DBusMessage00; 
    flags: DBusSendMessageFlags; timeoutMsec: int32; outSerial: var uint32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_connection_send_message_with_reply", libprag.}

proc sendMessageWithReply*(self: DBusConnection; message: DBusMessage; flags: DBusSendMessageFlags; 
    timeoutMsec: int; outSerial: var int; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  var outSerial_00 = uint32(outSerial)
  g_dbus_connection_send_message_with_reply(cast[ptr DBusConnection00](self.impl), cast[ptr DBusMessage00](message.impl), flags, int32(timeoutMsec), outSerial_00, cast[ptr Cancellable00](cancellable.impl), callback, userData)
  outSerial = int(outSerial_00)

proc g_input_stream_close_async*(self: ptr InputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_input_stream_close_async", libprag.}

proc closeAsync*(self: InputStream; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_input_stream_close_async(cast[ptr InputStream00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_input_stream_read_all_async*(self: ptr InputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_input_stream_read_all_async", libprag.}

proc readAllAsync*(self: InputStream; buffer: uint8Array; count: uint64; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_input_stream_read_all_async(cast[ptr InputStream00](self.impl), buffer, count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_input_stream_read_async*(self: ptr InputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_input_stream_read_async", libprag.}

proc readAsync*(self: InputStream; buffer: uint8Array; count: uint64; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_input_stream_read_async(cast[ptr InputStream00](self.impl), buffer, count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_input_stream_read_bytes_async*(self: ptr InputStream00; count: uint64; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_input_stream_read_bytes_async", libprag.}

proc readBytesAsync*(self: InputStream; count: uint64; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_input_stream_read_bytes_async(cast[ptr InputStream00](self.impl), count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_input_stream_skip_async*(self: ptr InputStream00; count: uint64; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_input_stream_skip_async", libprag.}

proc skipAsync*(self: InputStream; count: uint64; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_input_stream_skip_async(cast[ptr InputStream00](self.impl), count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_file_input_stream_query_info_async*(self: ptr FileInputStream00; attributes: cstring; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_file_input_stream_query_info_async", libprag.}

proc queryInfoAsync*(self: FileInputStream; attributes: string; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_file_input_stream_query_info_async(cast[ptr FileInputStream00](self.impl), cstring(attributes), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_async_initable_newv_async*(objectType: GType; nParameters: uint32; parameters: ptr gobject.Parameter00; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_async_initable_newv_async", libprag.}

proc newvAsync*(objectType: GType; nParameters: int; parameters: gobject.Parameter; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_async_initable_newv_async(objectType, uint32(nParameters), cast[ptr gobject.Parameter00](parameters.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_async_initable_init_async*(self: ptr AsyncInitable00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_async_initable_init_async", libprag.}

proc initAsync*(self: AsyncInitable; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_async_initable_init_async(cast[ptr AsyncInitable00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  AsyncResultIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    getUserData*: proc(res: ptr AsyncResult00): pointer {.cdecl.}
    getSourceObject*: proc(res: ptr AsyncResult00): ptr gobject.Object00 {.cdecl.}
    isTagged*: proc(res: ptr AsyncResult00; sourceTag: pointer): gboolean {.cdecl.}
  AsyncResultIface* = ref object
    impl*: ptr AsyncResultIface00

type
  FilterInputStream* = ref object of InputStream
  FilterInputStream00* = object of InputStream00
    baseStream*: ptr InputStream00

proc g_filter_input_stream_get_base_stream*(self: ptr FilterInputStream00): ptr InputStream00 {.
    importc: "g_filter_input_stream_get_base_stream", libprag.}

proc getBaseStream*(self: FilterInputStream): InputStream =
  let gobj = g_filter_input_stream_get_base_stream(cast[ptr FilterInputStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc baseStream*(self: FilterInputStream): InputStream =
  let gobj = g_filter_input_stream_get_base_stream(cast[ptr FilterInputStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc g_filter_input_stream_get_close_base_stream*(self: ptr FilterInputStream00): gboolean {.
    importc: "g_filter_input_stream_get_close_base_stream", libprag.}

proc getCloseBaseStream*(self: FilterInputStream): bool =
  toBool(g_filter_input_stream_get_close_base_stream(cast[ptr FilterInputStream00](self.impl)))

proc closeBaseStream*(self: FilterInputStream): bool =
  toBool(g_filter_input_stream_get_close_base_stream(cast[ptr FilterInputStream00](self.impl)))

proc g_filter_input_stream_set_close_base_stream*(self: ptr FilterInputStream00; closeBase: gboolean) {.
    importc: "g_filter_input_stream_set_close_base_stream", libprag.}

proc setCloseBaseStream*(self: FilterInputStream; closeBase: bool) =
  g_filter_input_stream_set_close_base_stream(cast[ptr FilterInputStream00](self.impl), gboolean(closeBase))

proc `closeBaseStream=`*(self: FilterInputStream; closeBase: bool) =
  g_filter_input_stream_set_close_base_stream(cast[ptr FilterInputStream00](self.impl), gboolean(closeBase))

type
  BufferedInputStreamPrivate00* {.pure.} = object
  BufferedInputStreamPrivate* = ref object
    impl*: ptr BufferedInputStreamPrivate00

type
  BufferedInputStream* = ref object of FilterInputStream
  BufferedInputStream00* = object of FilterInputStream00
    priv3: ptr BufferedInputStreamPrivate00

proc g_buffered_input_stream_new*(baseStream: ptr InputStream00): ptr BufferedInputStream00 {.
    importc: "g_buffered_input_stream_new", libprag.}

proc newBufferedInputStream*(baseStream: InputStream): BufferedInputStream =
  new(result, finalizeGObject)
  result.impl = g_buffered_input_stream_new(cast[ptr InputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferedInputStream*[T](result: var T; baseStream: InputStream) =
  assert(result is BufferedInputStream)
  new(result, finalizeGObject)
  result.impl = g_buffered_input_stream_new(cast[ptr InputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_buffered_input_stream_new_sized*(baseStream: ptr InputStream00; size: uint64): ptr BufferedInputStream00 {.
    importc: "g_buffered_input_stream_new_sized", libprag.}

proc newBufferedInputStreamSized*(baseStream: InputStream; size: uint64): BufferedInputStream =
  new(result, finalizeGObject)
  result.impl = g_buffered_input_stream_new_sized(cast[ptr InputStream00](baseStream.impl), size)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferedInputStreamSized*[T](result: var T; baseStream: InputStream; size: uint64) =
  assert(result is BufferedInputStream)
  new(result, finalizeGObject)
  result.impl = g_buffered_input_stream_new_sized(cast[ptr InputStream00](baseStream.impl), size)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_buffered_input_stream_fill*(self: ptr BufferedInputStream00; count: int64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_buffered_input_stream_fill", libprag.}

proc fill*(self: BufferedInputStream; count: int64; cancellable: Cancellable): int64 =
  g_buffered_input_stream_fill(cast[ptr BufferedInputStream00](self.impl), count, cast[ptr Cancellable00](cancellable.impl))

proc g_buffered_input_stream_fill_async*(self: ptr BufferedInputStream00; count: int64; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_buffered_input_stream_fill_async", libprag.}

proc fillAsync*(self: BufferedInputStream; count: int64; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_buffered_input_stream_fill_async(cast[ptr BufferedInputStream00](self.impl), count, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_buffered_input_stream_fill_finish*(self: ptr BufferedInputStream00; resu: ptr AsyncResult00): int64 {.
    importc: "g_buffered_input_stream_fill_finish", libprag.}

proc fillFinish*(self: BufferedInputStream; resu: AsyncResult): int64 =
  g_buffered_input_stream_fill_finish(cast[ptr BufferedInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_buffered_input_stream_get_available*(self: ptr BufferedInputStream00): uint64 {.
    importc: "g_buffered_input_stream_get_available", libprag.}

proc getAvailable*(self: BufferedInputStream): uint64 =
  g_buffered_input_stream_get_available(cast[ptr BufferedInputStream00](self.impl))

proc available*(self: BufferedInputStream): uint64 =
  g_buffered_input_stream_get_available(cast[ptr BufferedInputStream00](self.impl))

proc g_buffered_input_stream_get_buffer_size*(self: ptr BufferedInputStream00): uint64 {.
    importc: "g_buffered_input_stream_get_buffer_size", libprag.}

proc getBufferSize*(self: BufferedInputStream): uint64 =
  g_buffered_input_stream_get_buffer_size(cast[ptr BufferedInputStream00](self.impl))

proc bufferSize*(self: BufferedInputStream): uint64 =
  g_buffered_input_stream_get_buffer_size(cast[ptr BufferedInputStream00](self.impl))

proc g_buffered_input_stream_peek*(self: ptr BufferedInputStream00; buffer: uint8Array; 
    offset: uint64; count: uint64): uint64 {.
    importc: "g_buffered_input_stream_peek", libprag.}

proc peek*(self: BufferedInputStream; buffer: uint8Array; offset: uint64; 
    count: uint64): uint64 =
  g_buffered_input_stream_peek(cast[ptr BufferedInputStream00](self.impl), buffer, offset, count)

proc g_buffered_input_stream_peek_buffer*(self: ptr BufferedInputStream00; count: var uint64): uint8Array {.
    importc: "g_buffered_input_stream_peek_buffer", libprag.}

proc peekBuffer*(self: BufferedInputStream; count: var uint64): uint8Array =
  g_buffered_input_stream_peek_buffer(cast[ptr BufferedInputStream00](self.impl), count)

proc g_buffered_input_stream_read_byte*(self: ptr BufferedInputStream00; cancellable: ptr Cancellable00): int32 {.
    importc: "g_buffered_input_stream_read_byte", libprag.}

proc readByte*(self: BufferedInputStream; cancellable: Cancellable): int =
  int(g_buffered_input_stream_read_byte(cast[ptr BufferedInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_buffered_input_stream_set_buffer_size*(self: ptr BufferedInputStream00; size: uint64) {.
    importc: "g_buffered_input_stream_set_buffer_size", libprag.}

proc setBufferSize*(self: BufferedInputStream; size: uint64) =
  g_buffered_input_stream_set_buffer_size(cast[ptr BufferedInputStream00](self.impl), size)

proc `bufferSize=`*(self: BufferedInputStream; size: uint64) =
  g_buffered_input_stream_set_buffer_size(cast[ptr BufferedInputStream00](self.impl), size)

type
  InputStreamClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    readFn*: proc(stream: ptr InputStream00; buffer: pointer; count: uint64; 
    cancellable: ptr Cancellable00): int64 {.cdecl.}
    skip*: proc(stream: ptr InputStream00; count: uint64; cancellable: ptr Cancellable00): int64 {.cdecl.}
    closeFn*: proc(stream: ptr InputStream00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    readAsync*: proc(stream: ptr InputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    readFinish*: proc(stream: ptr InputStream00; resu: ptr AsyncResult00): int64 {.cdecl.}
    skipAsync*: proc(stream: ptr InputStream00; count: uint64; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    skipFinish*: proc(stream: ptr InputStream00; resu: ptr AsyncResult00): int64 {.cdecl.}
    closeAsync*: proc(stream: ptr InputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    closeFinish*: proc(stream: ptr InputStream00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  InputStreamClass* = ref object
    impl*: ptr InputStreamClass00

type
  FilterInputStreamClass00* {.pure.} = object
    parentClass*: InputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
  FilterInputStreamClass* = ref object
    impl*: ptr FilterInputStreamClass00

type
  BufferedInputStreamClass00* {.pure.} = object
    parentClass*: FilterInputStreamClass00
    fill*: proc(stream: ptr BufferedInputStream00; count: int64; cancellable: ptr Cancellable00): int64 {.cdecl.}
    fillAsync*: proc(stream: ptr BufferedInputStream00; count: int64; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    fillFinish*: proc(stream: ptr BufferedInputStream00; resu: ptr AsyncResult00): int64 {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  BufferedInputStreamClass* = ref object
    impl*: ptr BufferedInputStreamClass00

type
  FilterOutputStream* = ref object of OutputStream
  FilterOutputStream00* = object of OutputStream00
    baseStream*: ptr OutputStream00

proc g_filter_output_stream_get_base_stream*(self: ptr FilterOutputStream00): ptr OutputStream00 {.
    importc: "g_filter_output_stream_get_base_stream", libprag.}

proc getBaseStream*(self: FilterOutputStream): OutputStream =
  let gobj = g_filter_output_stream_get_base_stream(cast[ptr FilterOutputStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc baseStream*(self: FilterOutputStream): OutputStream =
  let gobj = g_filter_output_stream_get_base_stream(cast[ptr FilterOutputStream00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_filter_output_stream_get_close_base_stream*(self: ptr FilterOutputStream00): gboolean {.
    importc: "g_filter_output_stream_get_close_base_stream", libprag.}

proc getCloseBaseStream*(self: FilterOutputStream): bool =
  toBool(g_filter_output_stream_get_close_base_stream(cast[ptr FilterOutputStream00](self.impl)))

proc closeBaseStream*(self: FilterOutputStream): bool =
  toBool(g_filter_output_stream_get_close_base_stream(cast[ptr FilterOutputStream00](self.impl)))

proc g_filter_output_stream_set_close_base_stream*(self: ptr FilterOutputStream00; closeBase: gboolean) {.
    importc: "g_filter_output_stream_set_close_base_stream", libprag.}

proc setCloseBaseStream*(self: FilterOutputStream; closeBase: bool) =
  g_filter_output_stream_set_close_base_stream(cast[ptr FilterOutputStream00](self.impl), gboolean(closeBase))

proc `closeBaseStream=`*(self: FilterOutputStream; closeBase: bool) =
  g_filter_output_stream_set_close_base_stream(cast[ptr FilterOutputStream00](self.impl), gboolean(closeBase))

type
  BufferedOutputStreamPrivate00* {.pure.} = object
  BufferedOutputStreamPrivate* = ref object
    impl*: ptr BufferedOutputStreamPrivate00

type
  BufferedOutputStream* = ref object of FilterOutputStream
  BufferedOutputStream00* = object of FilterOutputStream00
    priv3: ptr BufferedOutputStreamPrivate00

proc g_buffered_output_stream_new*(baseStream: ptr OutputStream00): ptr BufferedOutputStream00 {.
    importc: "g_buffered_output_stream_new", libprag.}

proc newBufferedOutputStream*(baseStream: OutputStream): BufferedOutputStream =
  new(result, finalizeGObject)
  result.impl = g_buffered_output_stream_new(cast[ptr OutputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferedOutputStream*[T](result: var T; baseStream: OutputStream) =
  assert(result is BufferedOutputStream)
  new(result, finalizeGObject)
  result.impl = g_buffered_output_stream_new(cast[ptr OutputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_buffered_output_stream_new_sized*(baseStream: ptr OutputStream00; size: uint64): ptr BufferedOutputStream00 {.
    importc: "g_buffered_output_stream_new_sized", libprag.}

proc newBufferedOutputStreamSized*(baseStream: OutputStream; size: uint64): BufferedOutputStream =
  new(result, finalizeGObject)
  result.impl = g_buffered_output_stream_new_sized(cast[ptr OutputStream00](baseStream.impl), size)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBufferedOutputStreamSized*[T](result: var T; baseStream: OutputStream; size: uint64) =
  assert(result is BufferedOutputStream)
  new(result, finalizeGObject)
  result.impl = g_buffered_output_stream_new_sized(cast[ptr OutputStream00](baseStream.impl), size)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_buffered_output_stream_get_auto_grow*(self: ptr BufferedOutputStream00): gboolean {.
    importc: "g_buffered_output_stream_get_auto_grow", libprag.}

proc getAutoGrow*(self: BufferedOutputStream): bool =
  toBool(g_buffered_output_stream_get_auto_grow(cast[ptr BufferedOutputStream00](self.impl)))

proc autoGrow*(self: BufferedOutputStream): bool =
  toBool(g_buffered_output_stream_get_auto_grow(cast[ptr BufferedOutputStream00](self.impl)))

proc g_buffered_output_stream_get_buffer_size*(self: ptr BufferedOutputStream00): uint64 {.
    importc: "g_buffered_output_stream_get_buffer_size", libprag.}

proc getBufferSize*(self: BufferedOutputStream): uint64 =
  g_buffered_output_stream_get_buffer_size(cast[ptr BufferedOutputStream00](self.impl))

proc bufferSize*(self: BufferedOutputStream): uint64 =
  g_buffered_output_stream_get_buffer_size(cast[ptr BufferedOutputStream00](self.impl))

proc g_buffered_output_stream_set_auto_grow*(self: ptr BufferedOutputStream00; autoGrow: gboolean) {.
    importc: "g_buffered_output_stream_set_auto_grow", libprag.}

proc setAutoGrow*(self: BufferedOutputStream; autoGrow: bool) =
  g_buffered_output_stream_set_auto_grow(cast[ptr BufferedOutputStream00](self.impl), gboolean(autoGrow))

proc `autoGrow=`*(self: BufferedOutputStream; autoGrow: bool) =
  g_buffered_output_stream_set_auto_grow(cast[ptr BufferedOutputStream00](self.impl), gboolean(autoGrow))

proc g_buffered_output_stream_set_buffer_size*(self: ptr BufferedOutputStream00; size: uint64) {.
    importc: "g_buffered_output_stream_set_buffer_size", libprag.}

proc setBufferSize*(self: BufferedOutputStream; size: uint64) =
  g_buffered_output_stream_set_buffer_size(cast[ptr BufferedOutputStream00](self.impl), size)

proc `bufferSize=`*(self: BufferedOutputStream; size: uint64) =
  g_buffered_output_stream_set_buffer_size(cast[ptr BufferedOutputStream00](self.impl), size)

type
  OutputStreamClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    writeFn*: proc(stream: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    cancellable: ptr Cancellable00): int64 {.cdecl.}
    splice*: proc(stream: ptr OutputStream00; source: ptr InputStream00; 
    flags: OutputStreamSpliceFlags; cancellable: ptr Cancellable00): int64 {.cdecl.}
    flush*: proc(stream: ptr OutputStream00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    closeFn*: proc(stream: ptr OutputStream00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    writeAsync*: proc(stream: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    writeFinish*: proc(stream: ptr OutputStream00; resu: ptr AsyncResult00): int64 {.cdecl.}
    spliceAsync*: proc(stream: ptr OutputStream00; source: ptr InputStream00; 
    flags: OutputStreamSpliceFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    spliceFinish*: proc(stream: ptr OutputStream00; resu: ptr AsyncResult00): int64 {.cdecl.}
    flushAsync*: proc(stream: ptr OutputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    flushFinish*: proc(stream: ptr OutputStream00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    closeAsync*: proc(stream: ptr OutputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    closeFinish*: proc(stream: ptr OutputStream00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
    gReserved8*: pointer
  OutputStreamClass* = ref object
    impl*: ptr OutputStreamClass00

type
  FilterOutputStreamClass00* {.pure.} = object
    parentClass*: OutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
  FilterOutputStreamClass* = ref object
    impl*: ptr FilterOutputStreamClass00

type
  BufferedOutputStreamClass00* {.pure.} = object
    parentClass*: FilterOutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
  BufferedOutputStreamClass* = ref object
    impl*: ptr BufferedOutputStreamClass00

type
  BusAcquiredCallback* = proc (connection: ptr DBusConnection00; name: cstring; userData: pointer) {.cdecl.}

type
  BusNameAcquiredCallback* = proc (connection: ptr DBusConnection00; name: cstring; userData: pointer) {.cdecl.}

type
  BusNameAppearedCallback* = proc (connection: ptr DBusConnection00; name: cstring; nameOwner: cstring; 
    userData: pointer) {.cdecl.}

type
  BusNameLostCallback* = proc (connection: ptr DBusConnection00; name: cstring; userData: pointer) {.cdecl.}

type
  BusNameOwnerFlag* {.size: sizeof(cint), pure.} = enum
    allowReplacement = 1
    replace = 2

  BusNameOwnerFlags* {.size: sizeof(cint).} = set[BusNameOwnerFlag]

type
  BusNameVanishedCallback* = proc (connection: ptr DBusConnection00; name: cstring; userData: pointer) {.cdecl.}

type
  BusNameWatcherFlag* {.size: sizeof(cint), pure.} = enum
    autoStart = 1

  BusNameWatcherFlags* {.size: sizeof(cint).} = set[BusNameWatcherFlag]

type
  BusType* {.size: sizeof(cint), pure.} = enum
    starter = -1
    none = 0
    system = 1
    session = 2

type
  BytesIcon* = ref object of gobject.Object
  BytesIcon00* = object of gobject.Object00

proc g_bytes_icon_new*(bytes: ptr glib.Bytes00): ptr BytesIcon00 {.
    importc: "g_bytes_icon_new", libprag.}

proc newBytesIcon*(bytes: glib.Bytes): BytesIcon =
  new(result, finalizeGObject)
  result.impl = g_bytes_icon_new(cast[ptr glib.Bytes00](bytes.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initBytesIcon*[T](result: var T; bytes: glib.Bytes) =
  assert(result is BytesIcon)
  new(result, finalizeGObject)
  result.impl = g_bytes_icon_new(cast[ptr glib.Bytes00](bytes.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_bytes_icon_get_bytes*(self: ptr BytesIcon00): ptr glib.Bytes00 {.
    importc: "g_bytes_icon_get_bytes", libprag.}

proc getBytes*(self: BytesIcon): glib.Bytes =
  new(result)
  result.impl = g_bytes_icon_get_bytes(cast[ptr BytesIcon00](self.impl))

proc bytes*(self: BytesIcon): glib.Bytes =
  new(result)
  result.impl = g_bytes_icon_get_bytes(cast[ptr BytesIcon00](self.impl))

type
  CancellableClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    cancelled*: proc(cancellable: ptr Cancellable00) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  CancellableClass* = ref object
    impl*: ptr CancellableClass00

type
  CancellableSourceFunc* = proc (cancellable: ptr Cancellable00; userData: pointer): gboolean {.cdecl.}

type
  CharsetConverter* = ref object of gobject.Object
  CharsetConverter00* = object of gobject.Object00

proc g_charset_converter_new*(toCharset: cstring; fromCharset: cstring): ptr CharsetConverter00 {.
    importc: "g_charset_converter_new", libprag.}

proc newCharsetConverter*(toCharset: string; fromCharset: string): CharsetConverter =
  new(result, finalizeGObject)
  result.impl = g_charset_converter_new(cstring(toCharset), cstring(fromCharset))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initCharsetConverter*[T](result: var T; toCharset: string; fromCharset: string) =
  assert(result is CharsetConverter)
  new(result, finalizeGObject)
  result.impl = g_charset_converter_new(cstring(toCharset), cstring(fromCharset))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_charset_converter_get_num_fallbacks*(self: ptr CharsetConverter00): uint32 {.
    importc: "g_charset_converter_get_num_fallbacks", libprag.}

proc getNumFallbacks*(self: CharsetConverter): int =
  int(g_charset_converter_get_num_fallbacks(cast[ptr CharsetConverter00](self.impl)))

proc numFallbacks*(self: CharsetConverter): int =
  int(g_charset_converter_get_num_fallbacks(cast[ptr CharsetConverter00](self.impl)))

proc g_charset_converter_get_use_fallback*(self: ptr CharsetConverter00): gboolean {.
    importc: "g_charset_converter_get_use_fallback", libprag.}

proc getUseFallback*(self: CharsetConverter): bool =
  toBool(g_charset_converter_get_use_fallback(cast[ptr CharsetConverter00](self.impl)))

proc useFallback*(self: CharsetConverter): bool =
  toBool(g_charset_converter_get_use_fallback(cast[ptr CharsetConverter00](self.impl)))

proc g_charset_converter_set_use_fallback*(self: ptr CharsetConverter00; useFallback: gboolean) {.
    importc: "g_charset_converter_set_use_fallback", libprag.}

proc setUseFallback*(self: CharsetConverter; useFallback: bool) =
  g_charset_converter_set_use_fallback(cast[ptr CharsetConverter00](self.impl), gboolean(useFallback))

proc `useFallback=`*(self: CharsetConverter; useFallback: bool) =
  g_charset_converter_set_use_fallback(cast[ptr CharsetConverter00](self.impl), gboolean(useFallback))

type
  CharsetConverterClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  CharsetConverterClass* = ref object
    impl*: ptr CharsetConverterClass00

type
  Converter00* {.pure.} = object
  Converter* = ref object
    impl*: ptr Converter00

proc g_converter_reset*(self: ptr Converter00) {.
    importc: "g_converter_reset", libprag.}

proc reset*(self: Converter) =
  g_converter_reset(cast[ptr Converter00](self.impl))

type
  ConverterFlag* {.size: sizeof(cint), pure.} = enum
    inputAtEnd = 1
    flush = 2

  ConverterFlags* {.size: sizeof(cint).} = set[ConverterFlag]

type
  ConverterResult* {.size: sizeof(cint), pure.} = enum
    error = 0
    converted = 1
    finished = 2
    flushed = 3

proc g_converter_convert*(self: ptr Converter00; inbuf: uint8Array; inbufSize: uint64; 
    outbuf: uint8Array; outbufSize: uint64; flags: ConverterFlags; bytesRead: var uint64; 
    bytesWritten: var uint64): ConverterResult {.
    importc: "g_converter_convert", libprag.}

proc convert*(self: Converter; inbuf: uint8Array; inbufSize: uint64; 
    outbuf: uint8Array; outbufSize: uint64; flags: ConverterFlags; bytesRead: var uint64; bytesWritten: var uint64): ConverterResult =
  g_converter_convert(cast[ptr Converter00](self.impl), inbuf, inbufSize, outbuf, outbufSize, flags, bytesRead, bytesWritten)

type
  ConverterIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    convert*: proc(`converter`: ptr Converter00; inbuf: uint8Array; inbufSize: uint64; 
    outbuf: uint8Array; outbufSize: uint64; flags: ConverterFlags; bytesRead: var uint64; 
    bytesWritten: var uint64): ConverterResult {.cdecl.}
    reset*: proc(`converter`: ptr Converter00) {.cdecl.}
  ConverterIface* = ref object
    impl*: ptr ConverterIface00

type
  ConverterInputStreamPrivate00* {.pure.} = object
  ConverterInputStreamPrivate* = ref object
    impl*: ptr ConverterInputStreamPrivate00

type
  ConverterInputStream* = ref object of FilterInputStream
  ConverterInputStream00* = object of FilterInputStream00
    priv3: ptr ConverterInputStreamPrivate00

proc g_converter_input_stream_new*(baseStream: ptr InputStream00; `converter`: ptr Converter00): ptr ConverterInputStream00 {.
    importc: "g_converter_input_stream_new", libprag.}

proc newConverterInputStream*(baseStream: InputStream; `converter`: Converter): ConverterInputStream =
  new(result, finalizeGObject)
  result.impl = g_converter_input_stream_new(cast[ptr InputStream00](baseStream.impl), cast[ptr Converter00](`converter`.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initConverterInputStream*[T](result: var T; baseStream: InputStream; `converter`: Converter) =
  assert(result is ConverterInputStream)
  new(result, finalizeGObject)
  result.impl = g_converter_input_stream_new(cast[ptr InputStream00](baseStream.impl), cast[ptr Converter00](`converter`.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_converter_input_stream_get_converter*(self: ptr ConverterInputStream00): ptr Converter00 {.
    importc: "g_converter_input_stream_get_converter", libprag.}

proc getConverter*(self: ConverterInputStream): Converter =
  new(result)
  result.impl = g_converter_input_stream_get_converter(cast[ptr ConverterInputStream00](self.impl))

type
  ConverterInputStreamClass00* {.pure.} = object
    parentClass*: FilterInputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  ConverterInputStreamClass* = ref object
    impl*: ptr ConverterInputStreamClass00

type
  ConverterOutputStreamPrivate00* {.pure.} = object
  ConverterOutputStreamPrivate* = ref object
    impl*: ptr ConverterOutputStreamPrivate00

type
  ConverterOutputStream* = ref object of FilterOutputStream
  ConverterOutputStream00* = object of FilterOutputStream00
    priv3: ptr ConverterOutputStreamPrivate00

proc g_converter_output_stream_new*(baseStream: ptr OutputStream00; `converter`: ptr Converter00): ptr ConverterOutputStream00 {.
    importc: "g_converter_output_stream_new", libprag.}

proc newConverterOutputStream*(baseStream: OutputStream; `converter`: Converter): ConverterOutputStream =
  new(result, finalizeGObject)
  result.impl = g_converter_output_stream_new(cast[ptr OutputStream00](baseStream.impl), cast[ptr Converter00](`converter`.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initConverterOutputStream*[T](result: var T; baseStream: OutputStream; `converter`: Converter) =
  assert(result is ConverterOutputStream)
  new(result, finalizeGObject)
  result.impl = g_converter_output_stream_new(cast[ptr OutputStream00](baseStream.impl), cast[ptr Converter00](`converter`.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_converter_output_stream_get_converter*(self: ptr ConverterOutputStream00): ptr Converter00 {.
    importc: "g_converter_output_stream_get_converter", libprag.}

proc getConverter*(self: ConverterOutputStream): Converter =
  new(result)
  result.impl = g_converter_output_stream_get_converter(cast[ptr ConverterOutputStream00](self.impl))

type
  ConverterOutputStreamClass00* {.pure.} = object
    parentClass*: FilterOutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  ConverterOutputStreamClass* = ref object
    impl*: ptr ConverterOutputStreamClass00

type
  CredentialsClass00* {.pure.} = object
  CredentialsClass* = ref object
    impl*: ptr CredentialsClass00

type
  DBusActionGroup* = ref object of gobject.Object
  DBusActionGroup00* = object of gobject.Object00

proc g_dbus_action_group_get*(connection: ptr DBusConnection00; busName: cstring; 
    objectPath: cstring): ptr DBusActionGroup00 {.
    importc: "g_dbus_action_group_get", libprag.}

proc get*(connection: DBusConnection; busName: string; objectPath: string): DBusActionGroup =
  let gobj = g_dbus_action_group_get(cast[ptr DBusConnection00](connection.impl), cstring(busName), cstring(objectPath))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusActionGroup](g_object_get_qdata(gobj, Quark))
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
  DBusError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    noMemory = 1
    serviceUnknown = 2
    nameHasNoOwner = 3
    noReply = 4
    ioError = 5
    badAddress = 6
    notSupported = 7
    limitsExceeded = 8
    accessDenied = 9
    authFailed = 10
    noServer = 11
    timeout = 12
    noNetwork = 13
    addressInUse = 14
    disconnected = 15
    invalidArgs = 16
    fileNotFound = 17
    fileExists = 18
    unknownMethod = 19
    timedOut = 20
    matchRuleNotFound = 21
    matchRuleInvalid = 22
    spawnExecFailed = 23
    spawnForkFailed = 24
    spawnChildExited = 25
    spawnChildSignaled = 26
    spawnFailed = 27
    spawnSetupFailed = 28
    spawnConfigInvalid = 29
    spawnServiceInvalid = 30
    spawnServiceNotFound = 31
    spawnPermissionsInvalid = 32
    spawnFileInvalid = 33
    spawnNoMemory = 34
    unixProcessIdUnknown = 35
    invalidSignature = 36
    invalidFileContent = 37
    selinuxSecurityContextUnknown = 38
    adtAuditDataUnknown = 39
    objectPathInUse = 40
    unknownObject = 41
    unknownInterface = 42
    unknownProperty = 43
    propertyReadOnly = 44

proc g_dbus_error_encode_gerror*(error: ptr Error00): cstring {.
    importc: "g_dbus_error_encode_gerror", libprag.}

proc encodeGerror*(error: ptr Error00): string =
  let resul0 = g_dbus_error_encode_gerror(error)
  result = $resul0
  cogfree(resul0)

proc g_dbus_error_get_remote_error*(error: ptr Error00): cstring {.
    importc: "g_dbus_error_get_remote_error", libprag.}

proc getRemoteError*(error: ptr Error00): string =
  let resul0 = g_dbus_error_get_remote_error(error)
  result = $resul0
  cogfree(resul0)

proc remoteError*(error: ptr Error00): string =
  let resul0 = g_dbus_error_get_remote_error(error)
  result = $resul0
  cogfree(resul0)

proc g_dbus_error_is_remote_error*(error: ptr Error00): gboolean {.
    importc: "g_dbus_error_is_remote_error", libprag.}

proc isRemoteError*(error: ptr Error00): gboolean {.
    importc: "g_dbus_error_is_remote_error", libprag.}

proc g_dbus_error_new_for_dbus_error*(dbusErrorName: cstring; dbusErrorMessage: cstring): ptr Error00 {.
    importc: "g_dbus_error_new_for_dbus_error", libprag.}

proc newForDbusError*(dbusErrorName: cstring; dbusErrorMessage: cstring): ptr Error00 {.
    importc: "g_dbus_error_new_for_dbus_error", libprag.}

proc g_dbus_error_quark*(): uint32 {.
    importc: "g_dbus_error_quark", libprag.}

proc g_dbus_error_register_error*(errorDomain: uint32; errorCode: int32; dbusErrorName: cstring): gboolean {.
    importc: "g_dbus_error_register_error", libprag.}

proc registerError*(errorDomain: uint32; errorCode: int32; dbusErrorName: cstring): gboolean {.
    importc: "g_dbus_error_register_error", libprag.}

proc g_dbus_error_strip_remote_error*(error: ptr Error00): gboolean {.
    importc: "g_dbus_error_strip_remote_error", libprag.}

proc stripRemoteError*(error: ptr Error00): gboolean {.
    importc: "g_dbus_error_strip_remote_error", libprag.}

proc g_dbus_error_unregister_error*(errorDomain: uint32; errorCode: int32; dbusErrorName: cstring): gboolean {.
    importc: "g_dbus_error_unregister_error", libprag.}

proc unregisterError*(errorDomain: uint32; errorCode: int32; dbusErrorName: cstring): gboolean {.
    importc: "g_dbus_error_unregister_error", libprag.}

type
  DBusErrorEntry00* {.pure.} = object
    errorCode*: int32
    dbusErrorName*: cstring
  DBusErrorEntry* = ref object
    impl*: ptr DBusErrorEntry00

proc g_dbus_error_register_error_domain*(errorDomainQuarkName: cstring; quarkVolatile: ptr uint64; 
    entries: ptr DBusErrorEntry00; numEntries: uint32) {.
    importc: "g_dbus_error_register_error_domain", libprag.}

proc registerErrorDomain*(errorDomainQuarkName: string; quarkVolatile: ptr uint64; 
    entries: DBusErrorEntry; numEntries: int) =
  g_dbus_error_register_error_domain(cstring(errorDomainQuarkName), quarkVolatile, cast[ptr DBusErrorEntry00](entries.impl), uint32(numEntries))

type
  DBusInterface00* {.pure.} = object
  DBusInterface* = ref object
    impl*: ptr DBusInterface00

proc g_dbus_interface_get_info*(self: ptr DBusInterface00): ptr DBusInterfaceInfo00 {.
    importc: "g_dbus_interface_get_info", libprag.}

proc getInfo*(self: DBusInterface): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_interface_get_info(cast[ptr DBusInterface00](self.impl))

proc info*(self: DBusInterface): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_interface_get_info(cast[ptr DBusInterface00](self.impl))

type
  DBusObject00* {.pure.} = object
  DBusObject* = ref object
    impl*: ptr DBusObject00

proc g_dbus_object_get_interface*(self: ptr DBusObject00; interfaceName: cstring): ptr DBusInterface00 {.
    importc: "g_dbus_object_get_interface", libprag.}

proc getInterface*(self: DBusObject; interfaceName: string): DBusInterface =
  new(result)
  result.impl = g_dbus_object_get_interface(cast[ptr DBusObject00](self.impl), cstring(interfaceName))

proc g_dbus_object_get_interfaces*(self: ptr DBusObject00): ptr pointer {.
    importc: "g_dbus_object_get_interfaces", libprag.}

proc getInterfaces*(self: DBusObject): ptr pointer =
  g_dbus_object_get_interfaces(cast[ptr DBusObject00](self.impl))

proc interfaces*(self: DBusObject): ptr pointer =
  g_dbus_object_get_interfaces(cast[ptr DBusObject00](self.impl))

proc g_dbus_object_get_object_path*(self: ptr DBusObject00): cstring {.
    importc: "g_dbus_object_get_object_path", libprag.}

proc getObjectPath*(self: DBusObject): string =
  let resul0 = g_dbus_object_get_object_path(cast[ptr DBusObject00](self.impl))
  result = $resul0

proc objectPath*(self: DBusObject): string =
  let resul0 = g_dbus_object_get_object_path(cast[ptr DBusObject00](self.impl))
  result = $resul0

proc g_dbus_interface_dup_object*(self: ptr DBusInterface00): ptr DBusObject00 {.
    importc: "g_dbus_interface_dup_object", libprag.}

proc getObject*(self: DBusInterface): DBusObject =
  new(result)
  result.impl = g_dbus_interface_dup_object(cast[ptr DBusInterface00](self.impl))

proc g_dbus_interface_set_object*(self: ptr DBusInterface00; `object`: ptr DBusObject00) {.
    importc: "g_dbus_interface_set_object", libprag.}

proc setObject*(self: DBusInterface; `object`: DBusObject) =
  g_dbus_interface_set_object(cast[ptr DBusInterface00](self.impl), cast[ptr DBusObject00](`object`.impl))

proc `object=`*(self: DBusInterface; `object`: DBusObject) =
  g_dbus_interface_set_object(cast[ptr DBusInterface00](self.impl), cast[ptr DBusObject00](`object`.impl))

type
  DBusInterfaceGetPropertyFunc* = proc (connection: ptr DBusConnection00; sender: cstring; 
    objectPath: cstring; interfaceName: cstring; propertyName: cstring; error: ptr Error00; userData: pointer): ptr glib.Variant00 {.cdecl.}

type
  DBusInterfaceIface00* {.pure.} = object
    parentIface*: gobject.TypeInterface00
    getInfo*: proc(`interface`: ptr DBusInterface00): ptr DBusInterfaceInfo00 {.cdecl.}
    getObject*: proc(`interface`: ptr DBusInterface00): ptr DBusObject00 {.cdecl.}
    setObject*: proc(`interface`: ptr DBusInterface00; `object`: ptr DBusObject00) {.cdecl.}
    dupObject*: proc(`interface`: ptr DBusInterface00): ptr DBusObject00 {.cdecl.}
  DBusInterfaceIface* = ref object
    impl*: ptr DBusInterfaceIface00

type
  DBusMethodInvocation* = ref object of gobject.Object
  DBusMethodInvocation00* = object of gobject.Object00

proc g_dbus_method_invocation_get_connection*(self: ptr DBusMethodInvocation00): ptr DBusConnection00 {.
    importc: "g_dbus_method_invocation_get_connection", libprag.}

proc getConnection*(self: DBusMethodInvocation): DBusConnection =
  let gobj = g_dbus_method_invocation_get_connection(cast[ptr DBusMethodInvocation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusMethodInvocation): DBusConnection =
  let gobj = g_dbus_method_invocation_get_connection(cast[ptr DBusMethodInvocation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_method_invocation_get_interface_name*(self: ptr DBusMethodInvocation00): cstring {.
    importc: "g_dbus_method_invocation_get_interface_name", libprag.}

proc getInterfaceName*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_interface_name(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc interfaceName*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_interface_name(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc g_dbus_method_invocation_get_message*(self: ptr DBusMethodInvocation00): ptr DBusMessage00 {.
    importc: "g_dbus_method_invocation_get_message", libprag.}

proc getMessage*(self: DBusMethodInvocation): DBusMessage =
  let gobj = g_dbus_method_invocation_get_message(cast[ptr DBusMethodInvocation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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

proc message*(self: DBusMethodInvocation): DBusMessage =
  let gobj = g_dbus_method_invocation_get_message(cast[ptr DBusMethodInvocation00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMessage](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_method_invocation_get_method_info*(self: ptr DBusMethodInvocation00): ptr DBusMethodInfo00 {.
    importc: "g_dbus_method_invocation_get_method_info", libprag.}

proc getMethodInfo*(self: DBusMethodInvocation): DBusMethodInfo =
  new(result)
  result.impl = g_dbus_method_invocation_get_method_info(cast[ptr DBusMethodInvocation00](self.impl))

proc methodInfo*(self: DBusMethodInvocation): DBusMethodInfo =
  new(result)
  result.impl = g_dbus_method_invocation_get_method_info(cast[ptr DBusMethodInvocation00](self.impl))

proc g_dbus_method_invocation_get_method_name*(self: ptr DBusMethodInvocation00): cstring {.
    importc: "g_dbus_method_invocation_get_method_name", libprag.}

proc getMethodName*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_method_name(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc methodName*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_method_name(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc g_dbus_method_invocation_get_object_path*(self: ptr DBusMethodInvocation00): cstring {.
    importc: "g_dbus_method_invocation_get_object_path", libprag.}

proc getObjectPath*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_object_path(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc objectPath*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_object_path(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc g_dbus_method_invocation_get_parameters*(self: ptr DBusMethodInvocation00): ptr glib.Variant00 {.
    importc: "g_dbus_method_invocation_get_parameters", libprag.}

proc getParameters*(self: DBusMethodInvocation): glib.Variant =
  new(result)
  result.impl = g_dbus_method_invocation_get_parameters(cast[ptr DBusMethodInvocation00](self.impl))

proc parameters*(self: DBusMethodInvocation): glib.Variant =
  new(result)
  result.impl = g_dbus_method_invocation_get_parameters(cast[ptr DBusMethodInvocation00](self.impl))

proc g_dbus_method_invocation_get_property_info*(self: ptr DBusMethodInvocation00): ptr DBusPropertyInfo00 {.
    importc: "g_dbus_method_invocation_get_property_info", libprag.}

proc getPropertyInfo*(self: DBusMethodInvocation): DBusPropertyInfo =
  new(result)
  result.impl = g_dbus_method_invocation_get_property_info(cast[ptr DBusMethodInvocation00](self.impl))

proc propertyInfo*(self: DBusMethodInvocation): DBusPropertyInfo =
  new(result)
  result.impl = g_dbus_method_invocation_get_property_info(cast[ptr DBusMethodInvocation00](self.impl))

proc g_dbus_method_invocation_get_sender*(self: ptr DBusMethodInvocation00): cstring {.
    importc: "g_dbus_method_invocation_get_sender", libprag.}

proc getSender*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_sender(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc sender*(self: DBusMethodInvocation): string =
  let resul0 = g_dbus_method_invocation_get_sender(cast[ptr DBusMethodInvocation00](self.impl))
  result = $resul0

proc g_dbus_method_invocation_return_dbus_error*(self: ptr DBusMethodInvocation00; errorName: cstring; 
    errorMessage: cstring) {.
    importc: "g_dbus_method_invocation_return_dbus_error", libprag.}

proc returnDbusError*(self: DBusMethodInvocation; errorName: string; errorMessage: string) =
  g_dbus_method_invocation_return_dbus_error(cast[ptr DBusMethodInvocation00](self.impl), cstring(errorName), cstring(errorMessage))

proc g_dbus_method_invocation_return_error_literal*(self: ptr DBusMethodInvocation00; domain: uint32; 
    code: int32; message: cstring) {.
    importc: "g_dbus_method_invocation_return_error_literal", libprag.}

proc returnErrorLiteral*(self: DBusMethodInvocation; domain: int; code: int; 
    message: string) =
  g_dbus_method_invocation_return_error_literal(cast[ptr DBusMethodInvocation00](self.impl), uint32(domain), int32(code), cstring(message))

proc g_dbus_method_invocation_return_gerror*(self: ptr DBusMethodInvocation00; error: ptr Error00) {.
    importc: "g_dbus_method_invocation_return_gerror", libprag.}

proc returnGerror*(self: DBusMethodInvocation; error: ptr Error00) =
  g_dbus_method_invocation_return_gerror(cast[ptr DBusMethodInvocation00](self.impl), error)

proc g_dbus_method_invocation_return_value*(self: ptr DBusMethodInvocation00; parameters: ptr glib.Variant00) {.
    importc: "g_dbus_method_invocation_return_value", libprag.}

proc returnValue*(self: DBusMethodInvocation; parameters: glib.Variant) =
  g_dbus_method_invocation_return_value(cast[ptr DBusMethodInvocation00](self.impl), cast[ptr glib.Variant00](parameters.impl))

proc g_dbus_method_invocation_return_value_with_unix_fd_list*(self: ptr DBusMethodInvocation00; parameters: ptr glib.Variant00; 
    fdList: ptr UnixFDList00) {.
    importc: "g_dbus_method_invocation_return_value_with_unix_fd_list", libprag.}

proc returnValueWithUnixFdList*(self: DBusMethodInvocation; parameters: glib.Variant; 
    fdList: UnixFDList) =
  g_dbus_method_invocation_return_value_with_unix_fd_list(cast[ptr DBusMethodInvocation00](self.impl), cast[ptr glib.Variant00](parameters.impl), cast[ptr UnixFDList00](fdList.impl))

type
  DBusInterfaceMethodCallFunc* = proc (connection: ptr DBusConnection00; sender: cstring; 
    objectPath: cstring; interfaceName: cstring; methodName: cstring; parameters: ptr glib.Variant00; 
    invocation: ptr DBusMethodInvocation00; userData: pointer) {.cdecl.}

type
  DBusInterfaceSetPropertyFunc* = proc (connection: ptr DBusConnection00; sender: cstring; 
    objectPath: cstring; interfaceName: cstring; propertyName: cstring; value: ptr glib.Variant00; 
    error: ptr Error00; userData: pointer): gboolean {.cdecl.}

type
  DBusInterfaceSkeletonPrivate00* {.pure.} = object
  DBusInterfaceSkeletonPrivate* = ref object
    impl*: ptr DBusInterfaceSkeletonPrivate00

type
  DBusInterfaceSkeleton* = ref object of gobject.Object
  DBusInterfaceSkeleton00* = object of gobject.Object00
    priv1: ptr DBusInterfaceSkeletonPrivate00

proc scGAuthorizeMethod*(self: DBusInterfaceSkeleton;  p: proc (self: ptr gobject.Object00; invocation: DBusMethodInvocation00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "g-authorize-method", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_interface_skeleton_export*(self: ptr DBusInterfaceSkeleton00; connection: ptr DBusConnection00; 
    objectPath: cstring): gboolean {.
    importc: "g_dbus_interface_skeleton_export", libprag.}

proc `export`*(self: DBusInterfaceSkeleton; connection: DBusConnection; 
    objectPath: string): bool =
  toBool(g_dbus_interface_skeleton_export(cast[ptr DBusInterfaceSkeleton00](self.impl), cast[ptr DBusConnection00](connection.impl), cstring(objectPath)))

proc g_dbus_interface_skeleton_flush*(self: ptr DBusInterfaceSkeleton00) {.
    importc: "g_dbus_interface_skeleton_flush", libprag.}

proc flush*(self: DBusInterfaceSkeleton) =
  g_dbus_interface_skeleton_flush(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_get_connection*(self: ptr DBusInterfaceSkeleton00): ptr DBusConnection00 {.
    importc: "g_dbus_interface_skeleton_get_connection", libprag.}

proc getConnection*(self: DBusInterfaceSkeleton): DBusConnection =
  let gobj = g_dbus_interface_skeleton_get_connection(cast[ptr DBusInterfaceSkeleton00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusInterfaceSkeleton): DBusConnection =
  let gobj = g_dbus_interface_skeleton_get_connection(cast[ptr DBusInterfaceSkeleton00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_interface_skeleton_get_connections*(self: ptr DBusInterfaceSkeleton00): ptr pointer {.
    importc: "g_dbus_interface_skeleton_get_connections", libprag.}

proc getConnections*(self: DBusInterfaceSkeleton): ptr pointer =
  g_dbus_interface_skeleton_get_connections(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc connections*(self: DBusInterfaceSkeleton): ptr pointer =
  g_dbus_interface_skeleton_get_connections(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_get_info*(self: ptr DBusInterfaceSkeleton00): ptr DBusInterfaceInfo00 {.
    importc: "g_dbus_interface_skeleton_get_info", libprag.}

proc getInfo*(self: DBusInterfaceSkeleton): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_interface_skeleton_get_info(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc info*(self: DBusInterfaceSkeleton): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_interface_skeleton_get_info(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_get_object_path*(self: ptr DBusInterfaceSkeleton00): cstring {.
    importc: "g_dbus_interface_skeleton_get_object_path", libprag.}

proc getObjectPath*(self: DBusInterfaceSkeleton): string =
  let resul0 = g_dbus_interface_skeleton_get_object_path(cast[ptr DBusInterfaceSkeleton00](self.impl))
  result = $resul0

proc objectPath*(self: DBusInterfaceSkeleton): string =
  let resul0 = g_dbus_interface_skeleton_get_object_path(cast[ptr DBusInterfaceSkeleton00](self.impl))
  result = $resul0

proc g_dbus_interface_skeleton_get_properties*(self: ptr DBusInterfaceSkeleton00): ptr glib.Variant00 {.
    importc: "g_dbus_interface_skeleton_get_properties", libprag.}

proc getProperties*(self: DBusInterfaceSkeleton): glib.Variant =
  new(result)
  result.impl = g_dbus_interface_skeleton_get_properties(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc properties*(self: DBusInterfaceSkeleton): glib.Variant =
  new(result)
  result.impl = g_dbus_interface_skeleton_get_properties(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_has_connection*(self: ptr DBusInterfaceSkeleton00; connection: ptr DBusConnection00): gboolean {.
    importc: "g_dbus_interface_skeleton_has_connection", libprag.}

proc hasConnection*(self: DBusInterfaceSkeleton; connection: DBusConnection): bool =
  toBool(g_dbus_interface_skeleton_has_connection(cast[ptr DBusInterfaceSkeleton00](self.impl), cast[ptr DBusConnection00](connection.impl)))

proc g_dbus_interface_skeleton_unexport*(self: ptr DBusInterfaceSkeleton00) {.
    importc: "g_dbus_interface_skeleton_unexport", libprag.}

proc unexport*(self: DBusInterfaceSkeleton) =
  g_dbus_interface_skeleton_unexport(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_unexport_from_connection*(self: ptr DBusInterfaceSkeleton00; connection: ptr DBusConnection00) {.
    importc: "g_dbus_interface_skeleton_unexport_from_connection", libprag.}

proc unexportFromConnection*(self: DBusInterfaceSkeleton; connection: DBusConnection) =
  g_dbus_interface_skeleton_unexport_from_connection(cast[ptr DBusInterfaceSkeleton00](self.impl), cast[ptr DBusConnection00](connection.impl))

type
  DBusInterfaceSkeletonFlag* {.size: sizeof(cint), pure.} = enum
    handleMethodInvocationsInThread = 1

  DBusInterfaceSkeletonFlags* {.size: sizeof(cint).} = set[DBusInterfaceSkeletonFlag]

proc g_dbus_interface_skeleton_get_flags*(self: ptr DBusInterfaceSkeleton00): DBusInterfaceSkeletonFlags {.
    importc: "g_dbus_interface_skeleton_get_flags", libprag.}

proc getFlags*(self: DBusInterfaceSkeleton): DBusInterfaceSkeletonFlags =
  g_dbus_interface_skeleton_get_flags(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc flags*(self: DBusInterfaceSkeleton): DBusInterfaceSkeletonFlags =
  g_dbus_interface_skeleton_get_flags(cast[ptr DBusInterfaceSkeleton00](self.impl))

proc g_dbus_interface_skeleton_set_flags*(self: ptr DBusInterfaceSkeleton00; flags: DBusInterfaceSkeletonFlags) {.
    importc: "g_dbus_interface_skeleton_set_flags", libprag.}

proc setFlags*(self: DBusInterfaceSkeleton; flags: DBusInterfaceSkeletonFlags) =
  g_dbus_interface_skeleton_set_flags(cast[ptr DBusInterfaceSkeleton00](self.impl), flags)

proc `flags=`*(self: DBusInterfaceSkeleton; flags: DBusInterfaceSkeletonFlags) =
  g_dbus_interface_skeleton_set_flags(cast[ptr DBusInterfaceSkeleton00](self.impl), flags)

type
  DBusInterfaceSkeletonClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getInfo*: proc(`interface`: ptr DBusInterfaceSkeleton00): ptr DBusInterfaceInfo00 {.cdecl.}
    getVtable*: pointer
    getProperties*: proc(`interface`: ptr DBusInterfaceSkeleton00): ptr glib.Variant00 {.cdecl.}
    flush*: proc(`interface`: ptr DBusInterfaceSkeleton00) {.cdecl.}
    vfuncPadding*: array[8, pointer]
    gAuthorizeMethod*: proc(`interface`: ptr DBusInterfaceSkeleton00; invocation: ptr DBusMethodInvocation00): gboolean {.cdecl.}
    signalPadding*: array[8, pointer]
  DBusInterfaceSkeletonClass* = ref object
    impl*: ptr DBusInterfaceSkeletonClass00

type
  DBusInterfaceVTable00* {.pure.} = object
    methodCall*: DBusInterfaceMethodCallFunc
    getProperty*: DBusInterfaceGetPropertyFunc
    setProperty*: DBusInterfaceSetPropertyFunc
    padding*: array[8, pointer]
  DBusInterfaceVTable* = ref object
    impl*: ptr DBusInterfaceVTable00

type
  DBusMenuModel* = ref object of MenuModel
  DBusMenuModel00* = object of MenuModel00

proc g_dbus_menu_model_get*(connection: ptr DBusConnection00; busName: cstring; 
    objectPath: cstring): ptr DBusMenuModel00 {.
    importc: "g_dbus_menu_model_get", libprag.}

proc get*(connection: DBusConnection; busName: string; objectPath: string): DBusMenuModel =
  let gobj = g_dbus_menu_model_get(cast[ptr DBusConnection00](connection.impl), cstring(busName), cstring(objectPath))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusMenuModel](g_object_get_qdata(gobj, Quark))
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
  DBusMessageFilterFunction* = proc (connection: ptr DBusConnection00; message: ptr DBusMessage00; 
    incoming: gboolean; userData: pointer): ptr DBusMessage00 {.cdecl.}

proc g_dbus_connection_add_filter*(self: ptr DBusConnection00; filterFunction: DBusMessageFilterFunction; 
    userData: pointer; userDataFreeFunc: DestroyNotify): uint32 {.
    importc: "g_dbus_connection_add_filter", libprag.}

proc addFilter*(self: DBusConnection; filterFunction: DBusMessageFilterFunction; 
    userData: pointer; userDataFreeFunc: DestroyNotify): int =
  int(g_dbus_connection_add_filter(cast[ptr DBusConnection00](self.impl), filterFunction, userData, userDataFreeFunc))

type
  DBusNodeInfo00* {.pure.} = object
    refCount*: int32
    path*: cstring
    interfaces*: ptr DBusInterfaceInfo00Array
    nodes*: ptr DBusNodeInfo00Array
    annotations*: ptr DBusAnnotationInfo00Array
  DBusNodeInfo* = ref object
    impl*: ptr DBusNodeInfo00

proc g_dbus_node_info_new_for_xml*(xmlData: cstring): ptr DBusNodeInfo00 {.
    importc: "g_dbus_node_info_new_for_xml", libprag.}

proc newDBusNodeInfoForXml*(xmlData: string): DBusNodeInfo =
  new(result)
  result.impl = g_dbus_node_info_new_for_xml(cstring(xmlData))

proc initDBusNodeInfoForXml*[T](result: var T; xmlData: string) =
  assert(result is DBusNodeInfo)
  new(result)
  result.impl = g_dbus_node_info_new_for_xml(cstring(xmlData))

proc g_dbus_node_info_generate_xml*(self: ptr DBusNodeInfo00; indent: uint32; stringBuilder: var glib.String00) {.
    importc: "g_dbus_node_info_generate_xml", libprag.}

proc generateXml*(self: ptr DBusNodeInfo00; indent: uint32; stringBuilder: var glib.String00) {.
    importc: "g_dbus_node_info_generate_xml", libprag.}

proc g_dbus_node_info_lookup_interface*(self: ptr DBusNodeInfo00; name: cstring): ptr DBusInterfaceInfo00 {.
    importc: "g_dbus_node_info_lookup_interface", libprag.}

proc lookupInterface*(self: DBusNodeInfo; name: string): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_node_info_lookup_interface(cast[ptr DBusNodeInfo00](self.impl), cstring(name))

proc g_dbus_node_info_ref*(self: ptr DBusNodeInfo00): ptr DBusNodeInfo00 {.
    importc: "g_dbus_node_info_ref", libprag.}

proc `ref`*(self: DBusNodeInfo): DBusNodeInfo =
  new(result)
  result.impl = g_dbus_node_info_ref(cast[ptr DBusNodeInfo00](self.impl))

proc g_dbus_node_info_unref*(self: ptr DBusNodeInfo00) {.
    importc: "g_dbus_node_info_unref", libprag.}

proc unref*(self: DBusNodeInfo) =
  g_dbus_node_info_unref(cast[ptr DBusNodeInfo00](self.impl))

type
  DBusObjectIface00* {.pure.} = object
    parentIface*: gobject.TypeInterface00
    getObjectPath*: proc(`object`: ptr DBusObject00): cstring {.cdecl.}
    getInterfaces*: proc(`object`: ptr DBusObject00): ptr pointer {.cdecl.}
    getInterface*: proc(`object`: ptr DBusObject00; interfaceName: cstring): ptr DBusInterface00 {.cdecl.}
    interfaceAdded*: proc(`object`: ptr DBusObject00; `interface`: ptr DBusInterface00) {.cdecl.}
    interfaceRemoved*: proc(`object`: ptr DBusObject00; `interface`: ptr DBusInterface00) {.cdecl.}
  DBusObjectIface* = ref object
    impl*: ptr DBusObjectIface00

type
  DBusObjectManager00* {.pure.} = object
  DBusObjectManager* = ref object
    impl*: ptr DBusObjectManager00

proc g_dbus_object_manager_get_interface*(self: ptr DBusObjectManager00; objectPath: cstring; 
    interfaceName: cstring): ptr DBusInterface00 {.
    importc: "g_dbus_object_manager_get_interface", libprag.}

proc getInterface*(self: DBusObjectManager; objectPath: string; interfaceName: string): DBusInterface =
  new(result)
  result.impl = g_dbus_object_manager_get_interface(cast[ptr DBusObjectManager00](self.impl), cstring(objectPath), cstring(interfaceName))

proc g_dbus_object_manager_get_object*(self: ptr DBusObjectManager00; objectPath: cstring): ptr DBusObject00 {.
    importc: "g_dbus_object_manager_get_object", libprag.}

proc getObject*(self: DBusObjectManager; objectPath: string): DBusObject =
  new(result)
  result.impl = g_dbus_object_manager_get_object(cast[ptr DBusObjectManager00](self.impl), cstring(objectPath))

proc g_dbus_object_manager_get_object_path*(self: ptr DBusObjectManager00): cstring {.
    importc: "g_dbus_object_manager_get_object_path", libprag.}

proc getObjectPath*(self: DBusObjectManager): string =
  let resul0 = g_dbus_object_manager_get_object_path(cast[ptr DBusObjectManager00](self.impl))
  result = $resul0

proc objectPath*(self: DBusObjectManager): string =
  let resul0 = g_dbus_object_manager_get_object_path(cast[ptr DBusObjectManager00](self.impl))
  result = $resul0

proc g_dbus_object_manager_get_objects*(self: ptr DBusObjectManager00): ptr pointer {.
    importc: "g_dbus_object_manager_get_objects", libprag.}

proc getObjects*(self: DBusObjectManager): ptr pointer =
  g_dbus_object_manager_get_objects(cast[ptr DBusObjectManager00](self.impl))

proc objects*(self: DBusObjectManager): ptr pointer =
  g_dbus_object_manager_get_objects(cast[ptr DBusObjectManager00](self.impl))

type
  DBusObjectManagerClientPrivate00* {.pure.} = object
  DBusObjectManagerClientPrivate* = ref object
    impl*: ptr DBusObjectManagerClientPrivate00

type
  DBusObjectProxyPrivate00* {.pure.} = object
  DBusObjectProxyPrivate* = ref object
    impl*: ptr DBusObjectProxyPrivate00

type
  DBusObjectProxy* = ref object of gobject.Object
  DBusObjectProxy00* = object of gobject.Object00
    priv1: ptr DBusObjectProxyPrivate00

proc g_dbus_object_proxy_new*(connection: ptr DBusConnection00; objectPath: cstring): ptr DBusObjectProxy00 {.
    importc: "g_dbus_object_proxy_new", libprag.}

proc newDBusObjectProxy*(connection: DBusConnection; objectPath: string): DBusObjectProxy =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_proxy_new(cast[ptr DBusConnection00](connection.impl), cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectProxy*[T](result: var T; connection: DBusConnection; objectPath: string) =
  assert(result is DBusObjectProxy)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_proxy_new(cast[ptr DBusConnection00](connection.impl), cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_proxy_get_connection*(self: ptr DBusObjectProxy00): ptr DBusConnection00 {.
    importc: "g_dbus_object_proxy_get_connection", libprag.}

proc getConnection*(self: DBusObjectProxy): DBusConnection =
  let gobj = g_dbus_object_proxy_get_connection(cast[ptr DBusObjectProxy00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusObjectProxy): DBusConnection =
  let gobj = g_dbus_object_proxy_get_connection(cast[ptr DBusObjectProxy00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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
  DBusProxyPrivate00* {.pure.} = object
  DBusProxyPrivate* = ref object
    impl*: ptr DBusProxyPrivate00

type
  DBusProxy* = ref object of gobject.Object
  DBusProxy00* = object of gobject.Object00
    priv1: ptr DBusProxyPrivate00

proc scGPropertiesChanged*(self: DBusProxy;  p: proc (self: ptr gobject.Object00; changedProperties: glib.Variant00; invalidatedProperties: cstringArray; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "g-properties-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scGSignal*(self: DBusProxy;  p: proc (self: ptr gobject.Object00; senderName: cstring; signalName: cstring; parameters: glib.Variant00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "g-signal", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_proxy_new_finish*(res: ptr AsyncResult00): ptr DBusProxy00 {.
    importc: "g_dbus_proxy_new_finish", libprag.}

proc newDBusProxyFinish*(res: AsyncResult): DBusProxy =
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusProxyFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusProxy)
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_proxy_new_for_bus_finish*(res: ptr AsyncResult00): ptr DBusProxy00 {.
    importc: "g_dbus_proxy_new_for_bus_finish", libprag.}

proc newDBusProxyForBusFinish*(res: AsyncResult): DBusProxy =
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_for_bus_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusProxyForBusFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusProxy)
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_for_bus_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_proxy_call*(self: ptr DBusProxy00; methodName: cstring; parameters: ptr glib.Variant00; 
    flags: DBusCallFlags; timeoutMsec: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_proxy_call", libprag.}

proc call*(self: DBusProxy; methodName: string; parameters: glib.Variant; 
    flags: DBusCallFlags; timeoutMsec: int; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_dbus_proxy_call(cast[ptr DBusProxy00](self.impl), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), flags, int32(timeoutMsec), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_proxy_call_finish*(self: ptr DBusProxy00; res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_finish", libprag.}

proc callFinish*(self: DBusProxy; res: AsyncResult): glib.Variant =
  new(result)
  result.impl = g_dbus_proxy_call_finish(cast[ptr DBusProxy00](self.impl), cast[ptr AsyncResult00](res.impl))

proc g_dbus_proxy_call_sync*(self: ptr DBusProxy00; methodName: cstring; parameters: ptr glib.Variant00; 
    flags: DBusCallFlags; timeoutMsec: int32; cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_sync", libprag.}

proc callSync*(self: DBusProxy; methodName: string; parameters: glib.Variant; 
    flags: DBusCallFlags; timeoutMsec: int; cancellable: Cancellable): glib.Variant =
  new(result)
  result.impl = g_dbus_proxy_call_sync(cast[ptr DBusProxy00](self.impl), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), flags, int32(timeoutMsec), cast[ptr Cancellable00](cancellable.impl))

proc g_dbus_proxy_call_with_unix_fd_list*(self: ptr DBusProxy00; methodName: cstring; parameters: ptr glib.Variant00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_proxy_call_with_unix_fd_list", libprag.}

proc callWithUnixFdList*(self: DBusProxy; methodName: string; parameters: glib.Variant; 
    flags: DBusCallFlags; timeoutMsec: int; fdList: UnixFDList; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_proxy_call_with_unix_fd_list(cast[ptr DBusProxy00](self.impl), cstring(methodName), cast[ptr glib.Variant00](parameters.impl), flags, int32(timeoutMsec), cast[ptr UnixFDList00](fdList.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_proxy_call_with_unix_fd_list_finish*(self: ptr DBusProxy00; outFdList: var ptr UnixFDList00; 
    res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_with_unix_fd_list_finish", libprag.}

proc callWithUnixFdListFinish*(self: ptr DBusProxy00; outFdList: var ptr UnixFDList00; 
    res: ptr AsyncResult00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_with_unix_fd_list_finish", libprag.}

proc g_dbus_proxy_call_with_unix_fd_list_sync*(self: ptr DBusProxy00; methodName: cstring; parameters: ptr glib.Variant00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; outFdList: var ptr UnixFDList00; 
    cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_with_unix_fd_list_sync", libprag.}

proc callWithUnixFdListSync*(self: ptr DBusProxy00; methodName: cstring; parameters: ptr glib.Variant00; 
    flags: DBusCallFlags; timeoutMsec: int32; fdList: ptr UnixFDList00; outFdList: var ptr UnixFDList00; 
    cancellable: ptr Cancellable00): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_call_with_unix_fd_list_sync", libprag.}

proc g_dbus_proxy_get_cached_property*(self: ptr DBusProxy00; propertyName: cstring): ptr glib.Variant00 {.
    importc: "g_dbus_proxy_get_cached_property", libprag.}

proc getCachedProperty*(self: DBusProxy; propertyName: string): glib.Variant =
  new(result)
  result.impl = g_dbus_proxy_get_cached_property(cast[ptr DBusProxy00](self.impl), cstring(propertyName))

proc cachedProperty*(self: DBusProxy; propertyName: string): glib.Variant =
  new(result)
  result.impl = g_dbus_proxy_get_cached_property(cast[ptr DBusProxy00](self.impl), cstring(propertyName))

proc g_dbus_proxy_get_cached_property_names*(self: ptr DBusProxy00): cstringArray {.
    importc: "g_dbus_proxy_get_cached_property_names", libprag.}

proc getCachedPropertyNames*(self: DBusProxy): cstringArray =
  g_dbus_proxy_get_cached_property_names(cast[ptr DBusProxy00](self.impl))

proc cachedPropertyNames*(self: DBusProxy): cstringArray =
  g_dbus_proxy_get_cached_property_names(cast[ptr DBusProxy00](self.impl))

proc g_dbus_proxy_get_connection*(self: ptr DBusProxy00): ptr DBusConnection00 {.
    importc: "g_dbus_proxy_get_connection", libprag.}

proc getConnection*(self: DBusProxy): DBusConnection =
  let gobj = g_dbus_proxy_get_connection(cast[ptr DBusProxy00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusProxy): DBusConnection =
  let gobj = g_dbus_proxy_get_connection(cast[ptr DBusProxy00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_proxy_get_default_timeout*(self: ptr DBusProxy00): int32 {.
    importc: "g_dbus_proxy_get_default_timeout", libprag.}

proc getDefaultTimeout*(self: DBusProxy): int =
  int(g_dbus_proxy_get_default_timeout(cast[ptr DBusProxy00](self.impl)))

proc defaultTimeout*(self: DBusProxy): int =
  int(g_dbus_proxy_get_default_timeout(cast[ptr DBusProxy00](self.impl)))

proc g_dbus_proxy_get_interface_info*(self: ptr DBusProxy00): ptr DBusInterfaceInfo00 {.
    importc: "g_dbus_proxy_get_interface_info", libprag.}

proc getInterfaceInfo*(self: DBusProxy): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_proxy_get_interface_info(cast[ptr DBusProxy00](self.impl))

proc interfaceInfo*(self: DBusProxy): DBusInterfaceInfo =
  new(result)
  result.impl = g_dbus_proxy_get_interface_info(cast[ptr DBusProxy00](self.impl))

proc g_dbus_proxy_get_interface_name*(self: ptr DBusProxy00): cstring {.
    importc: "g_dbus_proxy_get_interface_name", libprag.}

proc getInterfaceName*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_interface_name(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc interfaceName*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_interface_name(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc g_dbus_proxy_get_name*(self: ptr DBusProxy00): cstring {.
    importc: "g_dbus_proxy_get_name", libprag.}

proc getName*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_name(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc name*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_name(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc g_dbus_proxy_get_name_owner*(self: ptr DBusProxy00): cstring {.
    importc: "g_dbus_proxy_get_name_owner", libprag.}

proc getNameOwner*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_name_owner(cast[ptr DBusProxy00](self.impl))
  result = $resul0
  cogfree(resul0)

proc nameOwner*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_name_owner(cast[ptr DBusProxy00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_dbus_proxy_get_object_path*(self: ptr DBusProxy00): cstring {.
    importc: "g_dbus_proxy_get_object_path", libprag.}

proc getObjectPath*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_object_path(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc objectPath*(self: DBusProxy): string =
  let resul0 = g_dbus_proxy_get_object_path(cast[ptr DBusProxy00](self.impl))
  result = $resul0

proc g_dbus_proxy_set_cached_property*(self: ptr DBusProxy00; propertyName: cstring; value: ptr glib.Variant00) {.
    importc: "g_dbus_proxy_set_cached_property", libprag.}

proc setCachedProperty*(self: DBusProxy; propertyName: string; value: glib.Variant) =
  g_dbus_proxy_set_cached_property(cast[ptr DBusProxy00](self.impl), cstring(propertyName), cast[ptr glib.Variant00](value.impl))

proc g_dbus_proxy_set_default_timeout*(self: ptr DBusProxy00; timeoutMsec: int32) {.
    importc: "g_dbus_proxy_set_default_timeout", libprag.}

proc setDefaultTimeout*(self: DBusProxy; timeoutMsec: int) =
  g_dbus_proxy_set_default_timeout(cast[ptr DBusProxy00](self.impl), int32(timeoutMsec))

proc `defaultTimeout=`*(self: DBusProxy; timeoutMsec: int) =
  g_dbus_proxy_set_default_timeout(cast[ptr DBusProxy00](self.impl), int32(timeoutMsec))

proc g_dbus_proxy_set_interface_info*(self: ptr DBusProxy00; info: ptr DBusInterfaceInfo00) {.
    importc: "g_dbus_proxy_set_interface_info", libprag.}

proc setInterfaceInfo*(self: DBusProxy; info: DBusInterfaceInfo) =
  g_dbus_proxy_set_interface_info(cast[ptr DBusProxy00](self.impl), cast[ptr DBusInterfaceInfo00](info.impl))

proc `interfaceInfo=`*(self: DBusProxy; info: DBusInterfaceInfo) =
  g_dbus_proxy_set_interface_info(cast[ptr DBusProxy00](self.impl), cast[ptr DBusInterfaceInfo00](info.impl))

type
  DBusObjectManagerClient* = ref object of gobject.Object
  DBusObjectManagerClient00* = object of gobject.Object00
    priv1: ptr DBusObjectManagerClientPrivate00

proc scInterfaceProxyPropertiesChanged*(self: DBusObjectManagerClient;  p: proc (self: ptr gobject.Object00; objectProxy: DBusObjectProxy00; interfaceProxy: DBusProxy00; 
    changedProperties: glib.Variant00; invalidatedProperties: cstringArray; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "interface-proxy-properties-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scInterfaceProxySignal*(self: DBusObjectManagerClient;  p: proc (self: ptr gobject.Object00; objectProxy: DBusObjectProxy00; interfaceProxy: DBusProxy00; 
    senderName: cstring; signalName: cstring; parameters: glib.Variant00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "interface-proxy-signal", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_object_manager_client_new_finish*(res: ptr AsyncResult00): ptr DBusObjectManagerClient00 {.
    importc: "g_dbus_object_manager_client_new_finish", libprag.}

proc newDBusObjectManagerClientFinish*(res: AsyncResult): DBusObjectManagerClient =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectManagerClientFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusObjectManagerClient)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_manager_client_new_for_bus_finish*(res: ptr AsyncResult00): ptr DBusObjectManagerClient00 {.
    importc: "g_dbus_object_manager_client_new_for_bus_finish", libprag.}

proc newDBusObjectManagerClientForBusFinish*(res: AsyncResult): DBusObjectManagerClient =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_for_bus_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectManagerClientForBusFinish*[T](result: var T; res: AsyncResult) =
  assert(result is DBusObjectManagerClient)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_for_bus_finish(cast[ptr AsyncResult00](res.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_manager_client_get_connection*(self: ptr DBusObjectManagerClient00): ptr DBusConnection00 {.
    importc: "g_dbus_object_manager_client_get_connection", libprag.}

proc getConnection*(self: DBusObjectManagerClient): DBusConnection =
  let gobj = g_dbus_object_manager_client_get_connection(cast[ptr DBusObjectManagerClient00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusObjectManagerClient): DBusConnection =
  let gobj = g_dbus_object_manager_client_get_connection(cast[ptr DBusObjectManagerClient00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_object_manager_client_get_name*(self: ptr DBusObjectManagerClient00): cstring {.
    importc: "g_dbus_object_manager_client_get_name", libprag.}

proc getName*(self: DBusObjectManagerClient): string =
  let resul0 = g_dbus_object_manager_client_get_name(cast[ptr DBusObjectManagerClient00](self.impl))
  result = $resul0

proc name*(self: DBusObjectManagerClient): string =
  let resul0 = g_dbus_object_manager_client_get_name(cast[ptr DBusObjectManagerClient00](self.impl))
  result = $resul0

proc g_dbus_object_manager_client_get_name_owner*(self: ptr DBusObjectManagerClient00): cstring {.
    importc: "g_dbus_object_manager_client_get_name_owner", libprag.}

proc getNameOwner*(self: DBusObjectManagerClient): string =
  let resul0 = g_dbus_object_manager_client_get_name_owner(cast[ptr DBusObjectManagerClient00](self.impl))
  result = $resul0
  cogfree(resul0)

proc nameOwner*(self: DBusObjectManagerClient): string =
  let resul0 = g_dbus_object_manager_client_get_name_owner(cast[ptr DBusObjectManagerClient00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  DBusProxyFlag* {.size: sizeof(cint), pure.} = enum
    doNotLoadProperties = 1
    doNotConnectSignals = 2
    doNotAutoStart = 3
    getInvalidatedProperties = 4
    doNotAutoStartAtConstruction = 5

  DBusProxyFlags* {.size: sizeof(cint).} = set[DBusProxyFlag]

proc g_dbus_proxy_new_for_bus_sync*(busType: BusType; flags: DBusProxyFlags; info: ptr DBusInterfaceInfo00; 
    name: cstring; objectPath: cstring; interfaceName: cstring; cancellable: ptr Cancellable00): ptr DBusProxy00 {.
    importc: "g_dbus_proxy_new_for_bus_sync", libprag.}

proc newDBusProxyForBusSync*(busType: BusType; flags: DBusProxyFlags; info: DBusInterfaceInfo; 
    name: string; objectPath: string; interfaceName: string; cancellable: Cancellable): DBusProxy =
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_for_bus_sync(busType, flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusProxyForBusSync*[T](result: var T; busType: BusType; flags: DBusProxyFlags; info: DBusInterfaceInfo; 
    name: string; objectPath: string; interfaceName: string; cancellable: Cancellable) =
  assert(result is DBusProxy)
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_for_bus_sync(busType, flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_proxy_new_sync*(connection: ptr DBusConnection00; flags: DBusProxyFlags; 
    info: ptr DBusInterfaceInfo00; name: cstring; objectPath: cstring; interfaceName: cstring; 
    cancellable: ptr Cancellable00): ptr DBusProxy00 {.
    importc: "g_dbus_proxy_new_sync", libprag.}

proc newDBusProxySync*(connection: DBusConnection; flags: DBusProxyFlags; 
    info: DBusInterfaceInfo; name: string; objectPath: string; interfaceName: string; cancellable: Cancellable): DBusProxy =
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_sync(cast[ptr DBusConnection00](connection.impl), flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusProxySync*[T](result: var T; connection: DBusConnection; flags: DBusProxyFlags; 
    info: DBusInterfaceInfo; name: string; objectPath: string; interfaceName: string; cancellable: Cancellable) =
  assert(result is DBusProxy)
  new(result, finalizeGObject)
  result.impl = g_dbus_proxy_new_sync(cast[ptr DBusConnection00](connection.impl), flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_proxy_new*(connection: ptr DBusConnection00; flags: DBusProxyFlags; 
    info: ptr DBusInterfaceInfo00; name: cstring; objectPath: cstring; interfaceName: cstring; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_proxy_new", libprag.}

proc new*(connection: DBusConnection; flags: DBusProxyFlags; 
    info: DBusInterfaceInfo; name: string; objectPath: string; interfaceName: string; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_proxy_new(cast[ptr DBusConnection00](connection.impl), flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_proxy_new_for_bus*(busType: BusType; flags: DBusProxyFlags; info: ptr DBusInterfaceInfo00; 
    name: cstring; objectPath: cstring; interfaceName: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_proxy_new_for_bus", libprag.}

proc newForBus*(busType: BusType; flags: DBusProxyFlags; info: DBusInterfaceInfo; 
    name: string; objectPath: string; interfaceName: string; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_proxy_new_for_bus(busType, flags, cast[ptr DBusInterfaceInfo00](info.impl), cstring(name), cstring(objectPath), cstring(interfaceName), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_proxy_get_flags*(self: ptr DBusProxy00): DBusProxyFlags {.
    importc: "g_dbus_proxy_get_flags", libprag.}

proc getFlags*(self: DBusProxy): DBusProxyFlags =
  g_dbus_proxy_get_flags(cast[ptr DBusProxy00](self.impl))

proc flags*(self: DBusProxy): DBusProxyFlags =
  g_dbus_proxy_get_flags(cast[ptr DBusProxy00](self.impl))

type
  DBusObjectManagerClientFlag* {.size: sizeof(cint), pure.} = enum
    doNotAutoStart = 1

  DBusObjectManagerClientFlags* {.size: sizeof(cint).} = set[DBusObjectManagerClientFlag]

proc g_dbus_object_manager_client_get_flags*(self: ptr DBusObjectManagerClient00): DBusObjectManagerClientFlags {.
    importc: "g_dbus_object_manager_client_get_flags", libprag.}

proc getFlags*(self: DBusObjectManagerClient): DBusObjectManagerClientFlags =
  g_dbus_object_manager_client_get_flags(cast[ptr DBusObjectManagerClient00](self.impl))

proc flags*(self: DBusObjectManagerClient): DBusObjectManagerClientFlags =
  g_dbus_object_manager_client_get_flags(cast[ptr DBusObjectManagerClient00](self.impl))

type
  DBusObjectManagerClientClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    interfaceProxySignal*: proc(manager: ptr DBusObjectManagerClient00; objectProxy: ptr DBusObjectProxy00; 
    interfaceProxy: ptr DBusProxy00; senderName: cstring; signalName: cstring; 
    parameters: ptr glib.Variant00) {.cdecl.}
    interfaceProxyPropertiesChanged*: proc(manager: ptr DBusObjectManagerClient00; objectProxy: ptr DBusObjectProxy00; 
    interfaceProxy: ptr DBusProxy00; changedProperties: ptr glib.Variant00; 
    invalidatedProperties: cstring) {.cdecl.}
    padding*: array[8, pointer]
  DBusObjectManagerClientClass* = ref object
    impl*: ptr DBusObjectManagerClientClass00

type
  DBusObjectManagerIface00* {.pure.} = object
    parentIface*: gobject.TypeInterface00
    getObjectPath*: proc(manager: ptr DBusObjectManager00): cstring {.cdecl.}
    getObjects*: proc(manager: ptr DBusObjectManager00): ptr pointer {.cdecl.}
    getObject*: proc(manager: ptr DBusObjectManager00; objectPath: cstring): ptr DBusObject00 {.cdecl.}
    getInterface*: proc(manager: ptr DBusObjectManager00; objectPath: cstring; 
    interfaceName: cstring): ptr DBusInterface00 {.cdecl.}
    objectAdded*: proc(manager: ptr DBusObjectManager00; `object`: ptr DBusObject00) {.cdecl.}
    objectRemoved*: proc(manager: ptr DBusObjectManager00; `object`: ptr DBusObject00) {.cdecl.}
    interfaceAdded*: proc(manager: ptr DBusObjectManager00; `object`: ptr DBusObject00; 
    `interface`: ptr DBusInterface00) {.cdecl.}
    interfaceRemoved*: proc(manager: ptr DBusObjectManager00; `object`: ptr DBusObject00; 
    `interface`: ptr DBusInterface00) {.cdecl.}
  DBusObjectManagerIface* = ref object
    impl*: ptr DBusObjectManagerIface00

type
  DBusObjectManagerServerPrivate00* {.pure.} = object
  DBusObjectManagerServerPrivate* = ref object
    impl*: ptr DBusObjectManagerServerPrivate00

type
  DBusObjectManagerServer* = ref object of gobject.Object
  DBusObjectManagerServer00* = object of gobject.Object00
    priv1: ptr DBusObjectManagerServerPrivate00

proc g_dbus_object_manager_server_new*(objectPath: cstring): ptr DBusObjectManagerServer00 {.
    importc: "g_dbus_object_manager_server_new", libprag.}

proc newDBusObjectManagerServer*(objectPath: string): DBusObjectManagerServer =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_server_new(cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectManagerServer*[T](result: var T; objectPath: string) =
  assert(result is DBusObjectManagerServer)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_server_new(cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_manager_server_get_connection*(self: ptr DBusObjectManagerServer00): ptr DBusConnection00 {.
    importc: "g_dbus_object_manager_server_get_connection", libprag.}

proc getConnection*(self: DBusObjectManagerServer): DBusConnection =
  let gobj = g_dbus_object_manager_server_get_connection(cast[ptr DBusObjectManagerServer00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc connection*(self: DBusObjectManagerServer): DBusConnection =
  let gobj = g_dbus_object_manager_server_get_connection(cast[ptr DBusObjectManagerServer00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_dbus_object_manager_server_set_connection*(self: ptr DBusObjectManagerServer00; connection: ptr DBusConnection00) {.
    importc: "g_dbus_object_manager_server_set_connection", libprag.}

proc setConnection*(self: DBusObjectManagerServer; connection: DBusConnection) =
  g_dbus_object_manager_server_set_connection(cast[ptr DBusObjectManagerServer00](self.impl), cast[ptr DBusConnection00](connection.impl))

proc `connection=`*(self: DBusObjectManagerServer; connection: DBusConnection) =
  g_dbus_object_manager_server_set_connection(cast[ptr DBusObjectManagerServer00](self.impl), cast[ptr DBusConnection00](connection.impl))

proc g_dbus_object_manager_server_unexport*(self: ptr DBusObjectManagerServer00; objectPath: cstring): gboolean {.
    importc: "g_dbus_object_manager_server_unexport", libprag.}

proc unexport*(self: DBusObjectManagerServer; objectPath: string): bool =
  toBool(g_dbus_object_manager_server_unexport(cast[ptr DBusObjectManagerServer00](self.impl), cstring(objectPath)))

type
  DBusObjectSkeletonPrivate00* {.pure.} = object
  DBusObjectSkeletonPrivate* = ref object
    impl*: ptr DBusObjectSkeletonPrivate00

type
  DBusObjectSkeleton* = ref object of gobject.Object
  DBusObjectSkeleton00* = object of gobject.Object00
    priv1: ptr DBusObjectSkeletonPrivate00

proc scAuthorizeMethod*(self: DBusObjectSkeleton;  p: proc (self: ptr gobject.Object00; `interface`: DBusInterfaceSkeleton00; invocation: DBusMethodInvocation00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "authorize-method", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_object_skeleton_new*(objectPath: cstring): ptr DBusObjectSkeleton00 {.
    importc: "g_dbus_object_skeleton_new", libprag.}

proc newDBusObjectSkeleton*(objectPath: string): DBusObjectSkeleton =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_skeleton_new(cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectSkeleton*[T](result: var T; objectPath: string) =
  assert(result is DBusObjectSkeleton)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_skeleton_new(cstring(objectPath))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_skeleton_add_interface*(self: ptr DBusObjectSkeleton00; `interface`: ptr DBusInterfaceSkeleton00) {.
    importc: "g_dbus_object_skeleton_add_interface", libprag.}

proc addInterface*(self: DBusObjectSkeleton; `interface`: DBusInterfaceSkeleton) =
  g_dbus_object_skeleton_add_interface(cast[ptr DBusObjectSkeleton00](self.impl), cast[ptr DBusInterfaceSkeleton00](`interface`.impl))

proc g_dbus_object_skeleton_flush*(self: ptr DBusObjectSkeleton00) {.
    importc: "g_dbus_object_skeleton_flush", libprag.}

proc flush*(self: DBusObjectSkeleton) =
  g_dbus_object_skeleton_flush(cast[ptr DBusObjectSkeleton00](self.impl))

proc g_dbus_object_skeleton_remove_interface*(self: ptr DBusObjectSkeleton00; `interface`: ptr DBusInterfaceSkeleton00) {.
    importc: "g_dbus_object_skeleton_remove_interface", libprag.}

proc removeInterface*(self: DBusObjectSkeleton; `interface`: DBusInterfaceSkeleton) =
  g_dbus_object_skeleton_remove_interface(cast[ptr DBusObjectSkeleton00](self.impl), cast[ptr DBusInterfaceSkeleton00](`interface`.impl))

proc g_dbus_object_skeleton_remove_interface_by_name*(self: ptr DBusObjectSkeleton00; interfaceName: cstring) {.
    importc: "g_dbus_object_skeleton_remove_interface_by_name", libprag.}

proc removeInterfaceByName*(self: DBusObjectSkeleton; interfaceName: string) =
  g_dbus_object_skeleton_remove_interface_by_name(cast[ptr DBusObjectSkeleton00](self.impl), cstring(interfaceName))

proc g_dbus_object_skeleton_set_object_path*(self: ptr DBusObjectSkeleton00; objectPath: cstring) {.
    importc: "g_dbus_object_skeleton_set_object_path", libprag.}

proc setObjectPath*(self: DBusObjectSkeleton; objectPath: string) =
  g_dbus_object_skeleton_set_object_path(cast[ptr DBusObjectSkeleton00](self.impl), cstring(objectPath))

proc `objectPath=`*(self: DBusObjectSkeleton; objectPath: string) =
  g_dbus_object_skeleton_set_object_path(cast[ptr DBusObjectSkeleton00](self.impl), cstring(objectPath))

proc g_dbus_object_manager_server_export*(self: ptr DBusObjectManagerServer00; `object`: ptr DBusObjectSkeleton00) {.
    importc: "g_dbus_object_manager_server_export", libprag.}

proc `export`*(self: DBusObjectManagerServer; `object`: DBusObjectSkeleton) =
  g_dbus_object_manager_server_export(cast[ptr DBusObjectManagerServer00](self.impl), cast[ptr DBusObjectSkeleton00](`object`.impl))

proc g_dbus_object_manager_server_export_uniquely*(self: ptr DBusObjectManagerServer00; `object`: ptr DBusObjectSkeleton00) {.
    importc: "g_dbus_object_manager_server_export_uniquely", libprag.}

proc exportUniquely*(self: DBusObjectManagerServer; `object`: DBusObjectSkeleton) =
  g_dbus_object_manager_server_export_uniquely(cast[ptr DBusObjectManagerServer00](self.impl), cast[ptr DBusObjectSkeleton00](`object`.impl))

proc g_dbus_object_manager_server_is_exported*(self: ptr DBusObjectManagerServer00; `object`: ptr DBusObjectSkeleton00): gboolean {.
    importc: "g_dbus_object_manager_server_is_exported", libprag.}

proc isExported*(self: DBusObjectManagerServer; `object`: DBusObjectSkeleton): bool =
  toBool(g_dbus_object_manager_server_is_exported(cast[ptr DBusObjectManagerServer00](self.impl), cast[ptr DBusObjectSkeleton00](`object`.impl)))

type
  DBusObjectManagerServerClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    padding*: array[8, pointer]
  DBusObjectManagerServerClass* = ref object
    impl*: ptr DBusObjectManagerServerClass00

type
  DBusObjectProxyClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    padding*: array[8, pointer]
  DBusObjectProxyClass* = ref object
    impl*: ptr DBusObjectProxyClass00

type
  DBusObjectSkeletonClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    authorizeMethod*: proc(`object`: ptr DBusObjectSkeleton00; `interface`: ptr DBusInterfaceSkeleton00; 
    invocation: ptr DBusMethodInvocation00): gboolean {.cdecl.}
    padding*: array[8, pointer]
  DBusObjectSkeletonClass* = ref object
    impl*: ptr DBusObjectSkeletonClass00

type
  DBusProxyClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    gPropertiesChanged*: proc(proxy: ptr DBusProxy00; changedProperties: ptr glib.Variant00; 
    invalidatedProperties: cstring) {.cdecl.}
    gSignal*: proc(proxy: ptr DBusProxy00; senderName: cstring; signalName: cstring; 
    parameters: ptr glib.Variant00) {.cdecl.}
    padding*: array[32, pointer]
  DBusProxyClass* = ref object
    impl*: ptr DBusProxyClass00

type
  DBusProxyTypeFunc* = proc (manager: ptr DBusObjectManagerClient00; objectPath: cstring; 
    interfaceName: cstring; userData: pointer): GType {.cdecl.}

proc g_dbus_object_manager_client_new_for_bus_sync*(busType: BusType; flags: DBusObjectManagerClientFlags; 
    name: cstring; objectPath: cstring; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: ptr Cancellable00): ptr DBusObjectManagerClient00 {.
    importc: "g_dbus_object_manager_client_new_for_bus_sync", libprag.}

proc newDBusObjectManagerClientForBusSync*(busType: BusType; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable): DBusObjectManagerClient =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_for_bus_sync(busType, flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectManagerClientForBusSync*[T](result: var T; busType: BusType; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable) =
  assert(result is DBusObjectManagerClient)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_for_bus_sync(busType, flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_manager_client_new_sync*(connection: ptr DBusConnection00; flags: DBusObjectManagerClientFlags; 
    name: cstring; objectPath: cstring; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: ptr Cancellable00): ptr DBusObjectManagerClient00 {.
    importc: "g_dbus_object_manager_client_new_sync", libprag.}

proc newDBusObjectManagerClientSync*(connection: DBusConnection; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable): DBusObjectManagerClient =
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_sync(cast[ptr DBusConnection00](connection.impl), flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusObjectManagerClientSync*[T](result: var T; connection: DBusConnection; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable) =
  assert(result is DBusObjectManagerClient)
  new(result, finalizeGObject)
  result.impl = g_dbus_object_manager_client_new_sync(cast[ptr DBusConnection00](connection.impl), flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_object_manager_client_new*(connection: ptr DBusConnection00; flags: DBusObjectManagerClientFlags; 
    name: cstring; objectPath: cstring; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_object_manager_client_new", libprag.}

proc new*(connection: DBusConnection; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_object_manager_client_new(cast[ptr DBusConnection00](connection.impl), flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_object_manager_client_new_for_bus*(busType: BusType; flags: DBusObjectManagerClientFlags; 
    name: cstring; objectPath: cstring; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_object_manager_client_new_for_bus", libprag.}

proc newForBus*(busType: BusType; flags: DBusObjectManagerClientFlags; 
    name: string; objectPath: string; getProxyTypeFunc: DBusProxyTypeFunc; getProxyTypeUserData: pointer; 
    getProxyTypeDestroyNotify: DestroyNotify; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dbus_object_manager_client_new_for_bus(busType, flags, cstring(name), cstring(objectPath), getProxyTypeFunc, getProxyTypeUserData, getProxyTypeDestroyNotify, cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  DBusServer* = ref object of gobject.Object
  DBusServer00* = object of gobject.Object00

proc scNewConnection*(self: DBusServer;  p: proc (self: ptr gobject.Object00; connection: DBusConnection00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "new-connection", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_dbus_server_get_client_address*(self: ptr DBusServer00): cstring {.
    importc: "g_dbus_server_get_client_address", libprag.}

proc getClientAddress*(self: DBusServer): string =
  let resul0 = g_dbus_server_get_client_address(cast[ptr DBusServer00](self.impl))
  result = $resul0

proc clientAddress*(self: DBusServer): string =
  let resul0 = g_dbus_server_get_client_address(cast[ptr DBusServer00](self.impl))
  result = $resul0

proc g_dbus_server_get_guid*(self: ptr DBusServer00): cstring {.
    importc: "g_dbus_server_get_guid", libprag.}

proc getGuid*(self: DBusServer): string =
  let resul0 = g_dbus_server_get_guid(cast[ptr DBusServer00](self.impl))
  result = $resul0

proc guid*(self: DBusServer): string =
  let resul0 = g_dbus_server_get_guid(cast[ptr DBusServer00](self.impl))
  result = $resul0

proc g_dbus_server_is_active*(self: ptr DBusServer00): gboolean {.
    importc: "g_dbus_server_is_active", libprag.}

proc isActive*(self: DBusServer): bool =
  toBool(g_dbus_server_is_active(cast[ptr DBusServer00](self.impl)))

proc g_dbus_server_start*(self: ptr DBusServer00) {.
    importc: "g_dbus_server_start", libprag.}

proc start*(self: DBusServer) =
  g_dbus_server_start(cast[ptr DBusServer00](self.impl))

proc g_dbus_server_stop*(self: ptr DBusServer00) {.
    importc: "g_dbus_server_stop", libprag.}

proc stop*(self: DBusServer) =
  g_dbus_server_stop(cast[ptr DBusServer00](self.impl))

type
  DBusServerFlag* {.size: sizeof(cint), pure.} = enum
    runInThread = 1
    authenticationAllowAnonymous = 2

  DBusServerFlags* {.size: sizeof(cint).} = set[DBusServerFlag]

proc g_dbus_server_new_sync*(address: cstring; flags: DBusServerFlags; guid: cstring; 
    observer: ptr DBusAuthObserver00; cancellable: ptr Cancellable00): ptr DBusServer00 {.
    importc: "g_dbus_server_new_sync", libprag.}

proc newDBusServerSync*(address: string; flags: DBusServerFlags; guid: string; 
    observer: DBusAuthObserver; cancellable: Cancellable): DBusServer =
  new(result, finalizeGObject)
  result.impl = g_dbus_server_new_sync(cstring(address), flags, cstring(guid), cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDBusServerSync*[T](result: var T; address: string; flags: DBusServerFlags; guid: string; 
    observer: DBusAuthObserver; cancellable: Cancellable) =
  assert(result is DBusServer)
  new(result, finalizeGObject)
  result.impl = g_dbus_server_new_sync(cstring(address), flags, cstring(guid), cast[ptr DBusAuthObserver00](observer.impl), cast[ptr Cancellable00](cancellable.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_dbus_server_get_flags*(self: ptr DBusServer00): DBusServerFlags {.
    importc: "g_dbus_server_get_flags", libprag.}

proc getFlags*(self: DBusServer): DBusServerFlags =
  g_dbus_server_get_flags(cast[ptr DBusServer00](self.impl))

proc flags*(self: DBusServer): DBusServerFlags =
  g_dbus_server_get_flags(cast[ptr DBusServer00](self.impl))

type
  DBusSignalCallback* = proc (connection: ptr DBusConnection00; senderName: cstring; 
    objectPath: cstring; interfaceName: cstring; signalName: cstring; parameters: ptr glib.Variant00; 
    userData: pointer) {.cdecl.}

proc g_dbus_connection_signal_subscribe*(self: ptr DBusConnection00; sender: cstring; interfaceName: cstring; 
    member: cstring; objectPath: cstring; arg0: cstring; flags: DBusSignalFlags; 
    callback: DBusSignalCallback; userData: pointer; userDataFreeFunc: DestroyNotify): uint32 {.
    importc: "g_dbus_connection_signal_subscribe", libprag.}

proc signalSubscribe*(self: DBusConnection; sender: string; interfaceName: string; 
    member: string; objectPath: string; arg0: string; flags: DBusSignalFlags; callback: DBusSignalCallback; 
    userData: pointer; userDataFreeFunc: DestroyNotify): int =
  int(g_dbus_connection_signal_subscribe(cast[ptr DBusConnection00](self.impl), cstring(sender), cstring(interfaceName), cstring(member), cstring(objectPath), cstring(arg0), flags, callback, userData, userDataFreeFunc))

type
  DBusSubtreeDispatchFunc* = proc (connection: ptr DBusConnection00; sender: cstring; 
    objectPath: cstring; interfaceName: cstring; node: cstring; outUserData: pointer; userData: pointer): ptr DBusInterfaceVTable00 {.cdecl.}

type
  DBusSubtreeFlag* {.size: sizeof(cint), pure.} = enum
    dispatchToUnenumeratedNodes = 1

  DBusSubtreeFlags* {.size: sizeof(cint).} = set[DBusSubtreeFlag]

type
  DBusSubtreeIntrospectFunc* = proc (connection: ptr DBusConnection00; sender: cstring; 
    objectPath: cstring; node: cstring; userData: pointer): ptr DBusInterfaceInfo00 {.cdecl.}

type
  DBusSubtreeVTable00* {.pure.} = object
    enumerate*: pointer
    introspect*: DBusSubtreeIntrospectFunc
    dispatch*: DBusSubtreeDispatchFunc
    padding*: array[8, pointer]
  DBusSubtreeVTable* = ref object
    impl*: ptr DBusSubtreeVTable00

proc g_dbus_connection_register_subtree*(self: ptr DBusConnection00; objectPath: cstring; vtable: ptr DBusSubtreeVTable00; 
    flags: DBusSubtreeFlags; userData: pointer; userDataFreeFunc: DestroyNotify): uint32 {.
    importc: "g_dbus_connection_register_subtree", libprag.}

proc registerSubtree*(self: DBusConnection; objectPath: string; vtable: DBusSubtreeVTable; 
    flags: DBusSubtreeFlags; userData: pointer; userDataFreeFunc: DestroyNotify): int =
  int(g_dbus_connection_register_subtree(cast[ptr DBusConnection00](self.impl), cstring(objectPath), cast[ptr DBusSubtreeVTable00](vtable.impl), flags, userData, userDataFreeFunc))

const DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME* = "gio-desktop-app-info-lookup"

type
  DataInputStreamPrivate00* {.pure.} = object
  DataInputStreamPrivate* = ref object
    impl*: ptr DataInputStreamPrivate00

type
  DataInputStream* = ref object of BufferedInputStream
  DataInputStream00* = object of BufferedInputStream00
    priv4: ptr DataInputStreamPrivate00

proc g_data_input_stream_new*(baseStream: ptr InputStream00): ptr DataInputStream00 {.
    importc: "g_data_input_stream_new", libprag.}

proc newDataInputStream*(baseStream: InputStream): DataInputStream =
  new(result, finalizeGObject)
  result.impl = g_data_input_stream_new(cast[ptr InputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDataInputStream*[T](result: var T; baseStream: InputStream) =
  assert(result is DataInputStream)
  new(result, finalizeGObject)
  result.impl = g_data_input_stream_new(cast[ptr InputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_data_input_stream_read_byte*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): uint8 {.
    importc: "g_data_input_stream_read_byte", libprag.}

proc readByte*(self: DataInputStream; cancellable: Cancellable): uint8 =
  g_data_input_stream_read_byte(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_int16*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): int16 {.
    importc: "g_data_input_stream_read_int16", libprag.}

proc readInt16*(self: DataInputStream; cancellable: Cancellable): int16 =
  g_data_input_stream_read_int16(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_int32*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): int32 {.
    importc: "g_data_input_stream_read_int32", libprag.}

proc readInt32*(self: DataInputStream; cancellable: Cancellable): int =
  int(g_data_input_stream_read_int32(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_data_input_stream_read_int64*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): int64 {.
    importc: "g_data_input_stream_read_int64", libprag.}

proc readInt64*(self: DataInputStream; cancellable: Cancellable): int64 =
  g_data_input_stream_read_int64(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_line*(self: ptr DataInputStream00; length: var uint64; cancellable: ptr Cancellable00): uint8Array {.
    importc: "g_data_input_stream_read_line", libprag.}

proc readLine*(self: DataInputStream; length: var uint64; cancellable: Cancellable): uint8Array =
  g_data_input_stream_read_line(cast[ptr DataInputStream00](self.impl), length, cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_line_async*(self: ptr DataInputStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_data_input_stream_read_line_async", libprag.}

proc readLineAsync*(self: DataInputStream; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_data_input_stream_read_line_async(cast[ptr DataInputStream00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_data_input_stream_read_line_finish*(self: ptr DataInputStream00; resu: ptr AsyncResult00; 
    length: var uint64): uint8Array {.
    importc: "g_data_input_stream_read_line_finish", libprag.}

proc readLineFinish*(self: DataInputStream; resu: AsyncResult; length: var uint64): uint8Array =
  g_data_input_stream_read_line_finish(cast[ptr DataInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), length)

proc g_data_input_stream_read_line_finish_utf8*(self: ptr DataInputStream00; resu: ptr AsyncResult00; 
    length: var uint64): cstring {.
    importc: "g_data_input_stream_read_line_finish_utf8", libprag.}

proc readLineFinishUtf8*(self: DataInputStream; resu: AsyncResult; length: var uint64): string =
  let resul0 = g_data_input_stream_read_line_finish_utf8(cast[ptr DataInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_data_input_stream_read_line_utf8*(self: ptr DataInputStream00; length: var uint64; cancellable: ptr Cancellable00): cstring {.
    importc: "g_data_input_stream_read_line_utf8", libprag.}

proc readLineUtf8*(self: DataInputStream; length: var uint64; cancellable: Cancellable): string =
  let resul0 = g_data_input_stream_read_line_utf8(cast[ptr DataInputStream00](self.impl), length, cast[ptr Cancellable00](cancellable.impl))
  result = $resul0
  cogfree(resul0)

proc g_data_input_stream_read_uint16*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): uint16 {.
    importc: "g_data_input_stream_read_uint16", libprag.}

proc readUint16*(self: DataInputStream; cancellable: Cancellable): uint16 =
  g_data_input_stream_read_uint16(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_uint32*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): uint32 {.
    importc: "g_data_input_stream_read_uint32", libprag.}

proc readUint32*(self: DataInputStream; cancellable: Cancellable): int =
  int(g_data_input_stream_read_uint32(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_data_input_stream_read_uint64*(self: ptr DataInputStream00; cancellable: ptr Cancellable00): uint64 {.
    importc: "g_data_input_stream_read_uint64", libprag.}

proc readUint64*(self: DataInputStream; cancellable: Cancellable): uint64 =
  g_data_input_stream_read_uint64(cast[ptr DataInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_data_input_stream_read_until*(self: ptr DataInputStream00; stopChars: cstring; length: var uint64; 
    cancellable: ptr Cancellable00): cstring {.
    importc: "g_data_input_stream_read_until", libprag.}

proc readUntil*(self: DataInputStream; stopChars: string; length: var uint64; 
    cancellable: Cancellable): string =
  let resul0 = g_data_input_stream_read_until(cast[ptr DataInputStream00](self.impl), cstring(stopChars), length, cast[ptr Cancellable00](cancellable.impl))
  result = $resul0
  cogfree(resul0)

proc g_data_input_stream_read_until_async*(self: ptr DataInputStream00; stopChars: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_data_input_stream_read_until_async", libprag.}

proc readUntilAsync*(self: DataInputStream; stopChars: string; ioPriority: int; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_data_input_stream_read_until_async(cast[ptr DataInputStream00](self.impl), cstring(stopChars), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_data_input_stream_read_until_finish*(self: ptr DataInputStream00; resu: ptr AsyncResult00; 
    length: var uint64): cstring {.
    importc: "g_data_input_stream_read_until_finish", libprag.}

proc readUntilFinish*(self: DataInputStream; resu: AsyncResult; length: var uint64): string =
  let resul0 = g_data_input_stream_read_until_finish(cast[ptr DataInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_data_input_stream_read_upto*(self: ptr DataInputStream00; stopChars: cstring; stopCharsLen: int64; 
    length: var uint64; cancellable: ptr Cancellable00): cstring {.
    importc: "g_data_input_stream_read_upto", libprag.}

proc readUpto*(self: DataInputStream; stopChars: string; stopCharsLen: int64; 
    length: var uint64; cancellable: Cancellable): string =
  let resul0 = g_data_input_stream_read_upto(cast[ptr DataInputStream00](self.impl), cstring(stopChars), stopCharsLen, length, cast[ptr Cancellable00](cancellable.impl))
  result = $resul0
  cogfree(resul0)

proc g_data_input_stream_read_upto_async*(self: ptr DataInputStream00; stopChars: cstring; stopCharsLen: int64; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_data_input_stream_read_upto_async", libprag.}

proc readUptoAsync*(self: DataInputStream; stopChars: string; stopCharsLen: int64; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_data_input_stream_read_upto_async(cast[ptr DataInputStream00](self.impl), cstring(stopChars), stopCharsLen, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_data_input_stream_read_upto_finish*(self: ptr DataInputStream00; resu: ptr AsyncResult00; 
    length: var uint64): cstring {.
    importc: "g_data_input_stream_read_upto_finish", libprag.}

proc readUptoFinish*(self: DataInputStream; resu: AsyncResult; length: var uint64): string =
  let resul0 = g_data_input_stream_read_upto_finish(cast[ptr DataInputStream00](self.impl), cast[ptr AsyncResult00](resu.impl), length)
  result = $resul0
  cogfree(resul0)

type
  DataStreamByteOrder* {.size: sizeof(cint), pure.} = enum
    bigEndian = 0
    littleEndian = 1
    hostEndian = 2

proc g_data_input_stream_get_byte_order*(self: ptr DataInputStream00): DataStreamByteOrder {.
    importc: "g_data_input_stream_get_byte_order", libprag.}

proc getByteOrder*(self: DataInputStream): DataStreamByteOrder =
  g_data_input_stream_get_byte_order(cast[ptr DataInputStream00](self.impl))

proc byteOrder*(self: DataInputStream): DataStreamByteOrder =
  g_data_input_stream_get_byte_order(cast[ptr DataInputStream00](self.impl))

proc g_data_input_stream_set_byte_order*(self: ptr DataInputStream00; order: DataStreamByteOrder) {.
    importc: "g_data_input_stream_set_byte_order", libprag.}

proc setByteOrder*(self: DataInputStream; order: DataStreamByteOrder) =
  g_data_input_stream_set_byte_order(cast[ptr DataInputStream00](self.impl), order)

proc `byteOrder=`*(self: DataInputStream; order: DataStreamByteOrder) =
  g_data_input_stream_set_byte_order(cast[ptr DataInputStream00](self.impl), order)

type
  DataStreamNewlineType* {.size: sizeof(cint), pure.} = enum
    lf = 0
    cr = 1
    crLf = 2
    any = 3

proc g_data_input_stream_get_newline_type*(self: ptr DataInputStream00): DataStreamNewlineType {.
    importc: "g_data_input_stream_get_newline_type", libprag.}

proc getNewlineType*(self: DataInputStream): DataStreamNewlineType =
  g_data_input_stream_get_newline_type(cast[ptr DataInputStream00](self.impl))

proc newlineType*(self: DataInputStream): DataStreamNewlineType =
  g_data_input_stream_get_newline_type(cast[ptr DataInputStream00](self.impl))

proc g_data_input_stream_set_newline_type*(self: ptr DataInputStream00; `type`: DataStreamNewlineType) {.
    importc: "g_data_input_stream_set_newline_type", libprag.}

proc setNewlineType*(self: DataInputStream; `type`: DataStreamNewlineType) =
  g_data_input_stream_set_newline_type(cast[ptr DataInputStream00](self.impl), `type`)

proc `newlineType=`*(self: DataInputStream; `type`: DataStreamNewlineType) =
  g_data_input_stream_set_newline_type(cast[ptr DataInputStream00](self.impl), `type`)

type
  DataInputStreamClass00* {.pure.} = object
    parentClass*: BufferedInputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  DataInputStreamClass* = ref object
    impl*: ptr DataInputStreamClass00

type
  DataOutputStreamPrivate00* {.pure.} = object
  DataOutputStreamPrivate* = ref object
    impl*: ptr DataOutputStreamPrivate00

type
  DataOutputStream* = ref object of FilterOutputStream
  DataOutputStream00* = object of FilterOutputStream00
    priv3: ptr DataOutputStreamPrivate00

proc g_data_output_stream_new*(baseStream: ptr OutputStream00): ptr DataOutputStream00 {.
    importc: "g_data_output_stream_new", libprag.}

proc newDataOutputStream*(baseStream: OutputStream): DataOutputStream =
  new(result, finalizeGObject)
  result.impl = g_data_output_stream_new(cast[ptr OutputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDataOutputStream*[T](result: var T; baseStream: OutputStream) =
  assert(result is DataOutputStream)
  new(result, finalizeGObject)
  result.impl = g_data_output_stream_new(cast[ptr OutputStream00](baseStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_data_output_stream_get_byte_order*(self: ptr DataOutputStream00): DataStreamByteOrder {.
    importc: "g_data_output_stream_get_byte_order", libprag.}

proc getByteOrder*(self: DataOutputStream): DataStreamByteOrder =
  g_data_output_stream_get_byte_order(cast[ptr DataOutputStream00](self.impl))

proc byteOrder*(self: DataOutputStream): DataStreamByteOrder =
  g_data_output_stream_get_byte_order(cast[ptr DataOutputStream00](self.impl))

proc g_data_output_stream_put_byte*(self: ptr DataOutputStream00; data: uint8; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_byte", libprag.}

proc putByte*(self: DataOutputStream; data: uint8; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_byte(cast[ptr DataOutputStream00](self.impl), data, cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_int16*(self: ptr DataOutputStream00; data: int16; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_int16", libprag.}

proc putInt16*(self: DataOutputStream; data: int16; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_int16(cast[ptr DataOutputStream00](self.impl), data, cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_int32*(self: ptr DataOutputStream00; data: int32; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_int32", libprag.}

proc putInt32*(self: DataOutputStream; data: int; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_int32(cast[ptr DataOutputStream00](self.impl), int32(data), cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_int64*(self: ptr DataOutputStream00; data: int64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_int64", libprag.}

proc putInt64*(self: DataOutputStream; data: int64; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_int64(cast[ptr DataOutputStream00](self.impl), data, cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_string*(self: ptr DataOutputStream00; str: cstring; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_string", libprag.}

proc putString*(self: DataOutputStream; str: string; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_string(cast[ptr DataOutputStream00](self.impl), cstring(str), cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_uint16*(self: ptr DataOutputStream00; data: uint16; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_uint16", libprag.}

proc putUint16*(self: DataOutputStream; data: uint16; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_uint16(cast[ptr DataOutputStream00](self.impl), data, cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_uint32*(self: ptr DataOutputStream00; data: uint32; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_uint32", libprag.}

proc putUint32*(self: DataOutputStream; data: int; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_uint32(cast[ptr DataOutputStream00](self.impl), uint32(data), cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_put_uint64*(self: ptr DataOutputStream00; data: uint64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_data_output_stream_put_uint64", libprag.}

proc putUint64*(self: DataOutputStream; data: uint64; cancellable: Cancellable): bool =
  toBool(g_data_output_stream_put_uint64(cast[ptr DataOutputStream00](self.impl), data, cast[ptr Cancellable00](cancellable.impl)))

proc g_data_output_stream_set_byte_order*(self: ptr DataOutputStream00; order: DataStreamByteOrder) {.
    importc: "g_data_output_stream_set_byte_order", libprag.}

proc setByteOrder*(self: DataOutputStream; order: DataStreamByteOrder) =
  g_data_output_stream_set_byte_order(cast[ptr DataOutputStream00](self.impl), order)

proc `byteOrder=`*(self: DataOutputStream; order: DataStreamByteOrder) =
  g_data_output_stream_set_byte_order(cast[ptr DataOutputStream00](self.impl), order)

type
  DataOutputStreamClass00* {.pure.} = object
    parentClass*: FilterOutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  DataOutputStreamClass* = ref object
    impl*: ptr DataOutputStreamClass00

type
  DatagramBased00* {.pure.} = object
  DatagramBased* = ref object
    impl*: ptr DatagramBased00

proc g_datagram_based_condition_check*(self: ptr DatagramBased00; condition: glib.IOCondition): glib.IOCondition {.
    importc: "g_datagram_based_condition_check", libprag.}

proc conditionCheck*(self: DatagramBased; condition: glib.IOCondition): glib.IOCondition =
  g_datagram_based_condition_check(cast[ptr DatagramBased00](self.impl), condition)

proc g_datagram_based_condition_wait*(self: ptr DatagramBased00; condition: glib.IOCondition; 
    timeout: int64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_datagram_based_condition_wait", libprag.}

proc conditionWait*(self: DatagramBased; condition: glib.IOCondition; 
    timeout: int64; cancellable: Cancellable): bool =
  toBool(g_datagram_based_condition_wait(cast[ptr DatagramBased00](self.impl), condition, timeout, cast[ptr Cancellable00](cancellable.impl)))

proc g_datagram_based_create_source*(self: ptr DatagramBased00; condition: glib.IOCondition; 
    cancellable: ptr Cancellable00): ptr glib.Source00 {.
    importc: "g_datagram_based_create_source", libprag.}

proc createSource*(self: DatagramBased; condition: glib.IOCondition; 
    cancellable: Cancellable): glib.Source =
  new(result)
  result.impl = g_datagram_based_create_source(cast[ptr DatagramBased00](self.impl), condition, cast[ptr Cancellable00](cancellable.impl))

type
  SocketAddress* = ref object of gobject.Object
  SocketAddress00* = object of gobject.Object00

proc g_socket_address_new_from_native*(native: pointer; len: uint64): ptr SocketAddress00 {.
    importc: "g_socket_address_new_from_native", libprag.}

proc newSocketAddressFromNative*(native: pointer; len: uint64): SocketAddress =
  new(result, finalizeGObject)
  result.impl = g_socket_address_new_from_native(native, len)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocketAddressFromNative*[T](result: var T; native: pointer; len: uint64) =
  assert(result is SocketAddress)
  new(result, finalizeGObject)
  result.impl = g_socket_address_new_from_native(native, len)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_address_get_native_size*(self: ptr SocketAddress00): int64 {.
    importc: "g_socket_address_get_native_size", libprag.}

proc getNativeSize*(self: SocketAddress): int64 =
  g_socket_address_get_native_size(cast[ptr SocketAddress00](self.impl))

proc nativeSize*(self: SocketAddress): int64 =
  g_socket_address_get_native_size(cast[ptr SocketAddress00](self.impl))

proc g_socket_address_to_native*(self: ptr SocketAddress00; dest: pointer; destlen: uint64): gboolean {.
    importc: "g_socket_address_to_native", libprag.}

proc toNative*(self: SocketAddress; dest: pointer; destlen: uint64): bool =
  toBool(g_socket_address_to_native(cast[ptr SocketAddress00](self.impl), dest, destlen))

type
  InputVector00* {.pure.} = object
    buffer*: pointer
    size*: uint64
  InputVector* = ref object
    impl*: ptr InputVector00

type
  SocketControlMessagePrivate00* {.pure.} = object
  SocketControlMessagePrivate* = ref object
    impl*: ptr SocketControlMessagePrivate00

type
  SocketControlMessage* = ref object of gobject.Object
  SocketControlMessage00* = object of gobject.Object00
    priv1: ptr SocketControlMessagePrivate00

proc g_socket_control_message_deserialize*(level: int32; `type`: int32; size: uint64; data: uint8Array): ptr SocketControlMessage00 {.
    importc: "g_socket_control_message_deserialize", libprag.}

proc deserialize*(level: int; `type`: int; size: uint64; data: uint8Array): SocketControlMessage =
  let gobj = g_socket_control_message_deserialize(int32(level), int32(`type`), size, data)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketControlMessage](g_object_get_qdata(gobj, Quark))
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

proc g_socket_control_message_get_level*(self: ptr SocketControlMessage00): int32 {.
    importc: "g_socket_control_message_get_level", libprag.}

proc getLevel*(self: SocketControlMessage): int =
  int(g_socket_control_message_get_level(cast[ptr SocketControlMessage00](self.impl)))

proc level*(self: SocketControlMessage): int =
  int(g_socket_control_message_get_level(cast[ptr SocketControlMessage00](self.impl)))

proc g_socket_control_message_get_msg_type*(self: ptr SocketControlMessage00): int32 {.
    importc: "g_socket_control_message_get_msg_type", libprag.}

proc getMsgType*(self: SocketControlMessage): int =
  int(g_socket_control_message_get_msg_type(cast[ptr SocketControlMessage00](self.impl)))

proc msgType*(self: SocketControlMessage): int =
  int(g_socket_control_message_get_msg_type(cast[ptr SocketControlMessage00](self.impl)))

proc g_socket_control_message_get_size*(self: ptr SocketControlMessage00): uint64 {.
    importc: "g_socket_control_message_get_size", libprag.}

proc getSize*(self: SocketControlMessage): uint64 =
  g_socket_control_message_get_size(cast[ptr SocketControlMessage00](self.impl))

proc size*(self: SocketControlMessage): uint64 =
  g_socket_control_message_get_size(cast[ptr SocketControlMessage00](self.impl))

proc g_socket_control_message_serialize*(self: ptr SocketControlMessage00; data: pointer) {.
    importc: "g_socket_control_message_serialize", libprag.}

proc serialize*(self: SocketControlMessage; data: pointer) =
  g_socket_control_message_serialize(cast[ptr SocketControlMessage00](self.impl), data)

type
  InputMessage00* {.pure.} = object
    address*: ptr SocketAddress00
    vectors*: InputVector00Array
    numVectors*: uint32
    bytesReceived*: uint64
    flags*: int32
    controlMessages*: ptr SocketControlMessage00Array
    numControlMessages*: ptr uint32
  InputMessage* = ref object
    impl*: ptr InputMessage00

proc g_datagram_based_receive_messages*(self: ptr DatagramBased00; messages: InputMessage00Array; 
    numMessages: uint32; flags: int32; timeout: int64; cancellable: ptr Cancellable00): int32 {.
    importc: "g_datagram_based_receive_messages", libprag.}

proc receiveMessages*(self: DatagramBased; messages: InputMessage00Array; 
    numMessages: int; flags: int; timeout: int64; cancellable: Cancellable): int =
  int(g_datagram_based_receive_messages(cast[ptr DatagramBased00](self.impl), messages, uint32(numMessages), int32(flags), timeout, cast[ptr Cancellable00](cancellable.impl)))

type
  SocketFamily* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    unix = 1
    ipv4 = 2
    ipv6 = 10

proc g_socket_address_get_family*(self: ptr SocketAddress00): SocketFamily {.
    importc: "g_socket_address_get_family", libprag.}

proc getFamily*(self: SocketAddress): SocketFamily =
  g_socket_address_get_family(cast[ptr SocketAddress00](self.impl))

proc family*(self: SocketAddress): SocketFamily =
  g_socket_address_get_family(cast[ptr SocketAddress00](self.impl))

type
  OutputVector00* {.pure.} = object
    buffer*: pointer
    size*: uint64
  OutputVector* = ref object
    impl*: ptr OutputVector00

type
  OutputMessage00* {.pure.} = object
    address*: ptr SocketAddress00
    vectors*: ptr OutputVector00
    numVectors*: uint32
    bytesSent*: uint32
    controlMessages*: ptr SocketControlMessage00Array
    numControlMessages*: uint32
  OutputMessage* = ref object
    impl*: ptr OutputMessage00

proc g_datagram_based_send_messages*(self: ptr DatagramBased00; messages: OutputMessage00Array; 
    numMessages: uint32; flags: int32; timeout: int64; cancellable: ptr Cancellable00): int32 {.
    importc: "g_datagram_based_send_messages", libprag.}

proc sendMessages*(self: DatagramBased; messages: OutputMessage00Array; 
    numMessages: int; flags: int; timeout: int64; cancellable: Cancellable): int =
  int(g_datagram_based_send_messages(cast[ptr DatagramBased00](self.impl), messages, uint32(numMessages), int32(flags), timeout, cast[ptr Cancellable00](cancellable.impl)))

type
  DatagramBasedInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    receiveMessages*: proc(datagramBased: ptr DatagramBased00; messages: InputMessage00Array; 
    numMessages: uint32; flags: int32; timeout: int64; cancellable: ptr Cancellable00): int32 {.cdecl.}
    sendMessages*: proc(datagramBased: ptr DatagramBased00; messages: OutputMessage00Array; 
    numMessages: uint32; flags: int32; timeout: int64; cancellable: ptr Cancellable00): int32 {.cdecl.}
    createSource*: proc(datagramBased: ptr DatagramBased00; condition: glib.IOCondition; 
    cancellable: ptr Cancellable00): ptr glib.Source00 {.cdecl.}
    conditionCheck*: proc(datagramBased: ptr DatagramBased00; condition: glib.IOCondition): glib.IOCondition {.cdecl.}
    conditionWait*: proc(datagramBased: ptr DatagramBased00; condition: glib.IOCondition; 
    timeout: int64; cancellable: ptr Cancellable00): gboolean {.cdecl.}
  DatagramBasedInterface* = ref object
    impl*: ptr DatagramBasedInterface00

type
  DatagramBasedSourceFunc* = proc (datagramBased: ptr DatagramBased00; condition: glib.IOCondition; 
    userData: pointer): gboolean {.cdecl.}

type
  DesktopAppInfo* = ref object of gobject.Object
  DesktopAppInfo00* = object of gobject.Object00

proc g_desktop_app_info_new*(desktopId: cstring): ptr DesktopAppInfo00 {.
    importc: "g_desktop_app_info_new", libprag.}

proc newDesktopAppInfo*(desktopId: string): DesktopAppInfo =
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new(cstring(desktopId))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDesktopAppInfo*[T](result: var T; desktopId: string) =
  assert(result is DesktopAppInfo)
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new(cstring(desktopId))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_desktop_app_info_new_from_filename*(filename: ucstring): ptr DesktopAppInfo00 {.
    importc: "g_desktop_app_info_new_from_filename", libprag.}

proc newDesktopAppInfoFromFilename*(filename: ucstring): DesktopAppInfo =
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new_from_filename(filename)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDesktopAppInfoFromFilename*[T](result: var T; filename: ucstring) =
  assert(result is DesktopAppInfo)
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new_from_filename(filename)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_desktop_app_info_new_from_keyfile*(keyFile: ptr glib.KeyFile00): ptr DesktopAppInfo00 {.
    importc: "g_desktop_app_info_new_from_keyfile", libprag.}

proc newDesktopAppInfoFromKeyfile*(keyFile: glib.KeyFile): DesktopAppInfo =
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new_from_keyfile(cast[ptr glib.KeyFile00](keyFile.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initDesktopAppInfoFromKeyfile*[T](result: var T; keyFile: glib.KeyFile) =
  assert(result is DesktopAppInfo)
  new(result, finalizeGObject)
  result.impl = g_desktop_app_info_new_from_keyfile(cast[ptr glib.KeyFile00](keyFile.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_desktop_app_info_get_implementations*(`interface`: cstring): ptr pointer {.
    importc: "g_desktop_app_info_get_implementations", libprag.}

proc getImplementations*(`interface`: cstring): ptr pointer {.
    importc: "g_desktop_app_info_get_implementations", libprag.}

proc implementations*(`interface`: cstring): ptr pointer {.
    importc: "g_desktop_app_info_get_implementations", libprag.}

proc g_desktop_app_info_search*(searchString: cstring): cstringArrayArray {.
    importc: "g_desktop_app_info_search", libprag.}

proc search*(searchString: cstring): cstringArrayArray {.
    importc: "g_desktop_app_info_search", libprag.}

proc g_desktop_app_info_set_desktop_env*(desktopEnv: cstring) {.
    importc: "g_desktop_app_info_set_desktop_env", libprag.}

proc setDesktopEnv*(desktopEnv: cstring) {.
    importc: "g_desktop_app_info_set_desktop_env", libprag.}

proc `desktopEnv=`*(desktopEnv: cstring) {.
    importc: "g_desktop_app_info_set_desktop_env", libprag.}

proc g_desktop_app_info_get_action_name*(self: ptr DesktopAppInfo00; actionName: cstring): cstring {.
    importc: "g_desktop_app_info_get_action_name", libprag.}

proc getActionName*(self: DesktopAppInfo; actionName: string): string =
  let resul0 = g_desktop_app_info_get_action_name(cast[ptr DesktopAppInfo00](self.impl), cstring(actionName))
  result = $resul0
  cogfree(resul0)

proc actionName*(self: DesktopAppInfo; actionName: string): string =
  let resul0 = g_desktop_app_info_get_action_name(cast[ptr DesktopAppInfo00](self.impl), cstring(actionName))
  result = $resul0
  cogfree(resul0)

proc g_desktop_app_info_get_boolean*(self: ptr DesktopAppInfo00; key: cstring): gboolean {.
    importc: "g_desktop_app_info_get_boolean", libprag.}

proc getBoolean*(self: DesktopAppInfo; key: string): bool =
  toBool(g_desktop_app_info_get_boolean(cast[ptr DesktopAppInfo00](self.impl), cstring(key)))

proc boolean*(self: DesktopAppInfo; key: string): bool =
  toBool(g_desktop_app_info_get_boolean(cast[ptr DesktopAppInfo00](self.impl), cstring(key)))

proc g_desktop_app_info_get_categories*(self: ptr DesktopAppInfo00): cstring {.
    importc: "g_desktop_app_info_get_categories", libprag.}

proc getCategories*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_categories(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc categories*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_categories(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc g_desktop_app_info_get_filename*(self: ptr DesktopAppInfo00): ucstring {.
    importc: "g_desktop_app_info_get_filename", libprag.}

proc getFilename*(self: DesktopAppInfo): ucstring =
  g_desktop_app_info_get_filename(cast[ptr DesktopAppInfo00](self.impl))

proc filename*(self: DesktopAppInfo): ucstring =
  g_desktop_app_info_get_filename(cast[ptr DesktopAppInfo00](self.impl))

proc g_desktop_app_info_get_generic_name*(self: ptr DesktopAppInfo00): cstring {.
    importc: "g_desktop_app_info_get_generic_name", libprag.}

proc getGenericName*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_generic_name(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc genericName*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_generic_name(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc g_desktop_app_info_get_is_hidden*(self: ptr DesktopAppInfo00): gboolean {.
    importc: "g_desktop_app_info_get_is_hidden", libprag.}

proc getIsHidden*(self: DesktopAppInfo): bool =
  toBool(g_desktop_app_info_get_is_hidden(cast[ptr DesktopAppInfo00](self.impl)))

proc isHidden*(self: DesktopAppInfo): bool =
  toBool(g_desktop_app_info_get_is_hidden(cast[ptr DesktopAppInfo00](self.impl)))

proc g_desktop_app_info_get_keywords*(self: ptr DesktopAppInfo00): cstringArray {.
    importc: "g_desktop_app_info_get_keywords", libprag.}

proc getKeywords*(self: DesktopAppInfo): cstringArray =
  g_desktop_app_info_get_keywords(cast[ptr DesktopAppInfo00](self.impl))

proc keywords*(self: DesktopAppInfo): cstringArray =
  g_desktop_app_info_get_keywords(cast[ptr DesktopAppInfo00](self.impl))

proc g_desktop_app_info_get_nodisplay*(self: ptr DesktopAppInfo00): gboolean {.
    importc: "g_desktop_app_info_get_nodisplay", libprag.}

proc getNodisplay*(self: DesktopAppInfo): bool =
  toBool(g_desktop_app_info_get_nodisplay(cast[ptr DesktopAppInfo00](self.impl)))

proc nodisplay*(self: DesktopAppInfo): bool =
  toBool(g_desktop_app_info_get_nodisplay(cast[ptr DesktopAppInfo00](self.impl)))

proc g_desktop_app_info_get_show_in*(self: ptr DesktopAppInfo00; desktopEnv: cstring): gboolean {.
    importc: "g_desktop_app_info_get_show_in", libprag.}

proc getShowIn*(self: DesktopAppInfo; desktopEnv: string): bool =
  toBool(g_desktop_app_info_get_show_in(cast[ptr DesktopAppInfo00](self.impl), cstring(desktopEnv)))

proc showIn*(self: DesktopAppInfo; desktopEnv: string): bool =
  toBool(g_desktop_app_info_get_show_in(cast[ptr DesktopAppInfo00](self.impl), cstring(desktopEnv)))

proc g_desktop_app_info_get_startup_wm_class*(self: ptr DesktopAppInfo00): cstring {.
    importc: "g_desktop_app_info_get_startup_wm_class", libprag.}

proc getStartupWmClass*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_startup_wm_class(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc startupWmClass*(self: DesktopAppInfo): string =
  let resul0 = g_desktop_app_info_get_startup_wm_class(cast[ptr DesktopAppInfo00](self.impl))
  result = $resul0

proc g_desktop_app_info_get_string*(self: ptr DesktopAppInfo00; key: cstring): cstring {.
    importc: "g_desktop_app_info_get_string", libprag.}

proc getString*(self: DesktopAppInfo; key: string): string =
  let resul0 = g_desktop_app_info_get_string(cast[ptr DesktopAppInfo00](self.impl), cstring(key))
  result = $resul0
  cogfree(resul0)

proc string*(self: DesktopAppInfo; key: string): string =
  let resul0 = g_desktop_app_info_get_string(cast[ptr DesktopAppInfo00](self.impl), cstring(key))
  result = $resul0
  cogfree(resul0)

proc g_desktop_app_info_has_key*(self: ptr DesktopAppInfo00; key: cstring): gboolean {.
    importc: "g_desktop_app_info_has_key", libprag.}

proc hasKey*(self: DesktopAppInfo; key: string): bool =
  toBool(g_desktop_app_info_has_key(cast[ptr DesktopAppInfo00](self.impl), cstring(key)))

proc g_desktop_app_info_launch_action*(self: ptr DesktopAppInfo00; actionName: cstring; launchContext: ptr AppLaunchContext00) {.
    importc: "g_desktop_app_info_launch_action", libprag.}

proc launchAction*(self: DesktopAppInfo; actionName: string; launchContext: AppLaunchContext) =
  g_desktop_app_info_launch_action(cast[ptr DesktopAppInfo00](self.impl), cstring(actionName), cast[ptr AppLaunchContext00](launchContext.impl))

proc g_desktop_app_info_list_actions*(self: ptr DesktopAppInfo00): cstringArray {.
    importc: "g_desktop_app_info_list_actions", libprag.}

proc listActions*(self: DesktopAppInfo): cstringArray =
  g_desktop_app_info_list_actions(cast[ptr DesktopAppInfo00](self.impl))

type
  DesktopAppInfoClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  DesktopAppInfoClass* = ref object
    impl*: ptr DesktopAppInfoClass00

type
  DesktopAppInfoLookup00* {.pure.} = object
  DesktopAppInfoLookup* = ref object
    impl*: ptr DesktopAppInfoLookup00

proc g_desktop_app_info_lookup_get_default_for_uri_scheme*(self: ptr DesktopAppInfoLookup00; uriScheme: cstring): ptr AppInfo00 {.
    importc: "g_desktop_app_info_lookup_get_default_for_uri_scheme", libprag.}

proc getDefaultForUriScheme*(self: DesktopAppInfoLookup; uriScheme: string): AppInfo =
  new(result)
  result.impl = g_desktop_app_info_lookup_get_default_for_uri_scheme(cast[ptr DesktopAppInfoLookup00](self.impl), cstring(uriScheme))

proc defaultForUriScheme*(self: DesktopAppInfoLookup; uriScheme: string): AppInfo =
  new(result)
  result.impl = g_desktop_app_info_lookup_get_default_for_uri_scheme(cast[ptr DesktopAppInfoLookup00](self.impl), cstring(uriScheme))

type
  DesktopAppInfoLookupIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    getDefaultForUriScheme*: proc(lookup: ptr DesktopAppInfoLookup00; uriScheme: cstring): ptr AppInfo00 {.cdecl.}
  DesktopAppInfoLookupIface* = ref object
    impl*: ptr DesktopAppInfoLookupIface00

type
  DesktopAppLaunchCallback* = proc (appinfo: ptr DesktopAppInfo00; pid: int32; userData: pointer) {.cdecl.}

proc g_desktop_app_info_launch_uris_as_manager*(self: ptr DesktopAppInfo00; uris: ptr pointer; launchContext: ptr AppLaunchContext00; 
    spawnFlags: glib.SpawnFlags; userSetup: SpawnChildSetupFunc; 
    userSetupData: pointer; pidCallback: DesktopAppLaunchCallback; pidCallbackData: pointer): gboolean {.
    importc: "g_desktop_app_info_launch_uris_as_manager", libprag.}

proc launchUrisAsManager*(self: DesktopAppInfo; uris: ptr pointer; launchContext: AppLaunchContext; 
    spawnFlags: glib.SpawnFlags; userSetup: SpawnChildSetupFunc; userSetupData: pointer; 
    pidCallback: DesktopAppLaunchCallback; pidCallbackData: pointer): bool =
  toBool(g_desktop_app_info_launch_uris_as_manager(cast[ptr DesktopAppInfo00](self.impl), uris, cast[ptr AppLaunchContext00](launchContext.impl), spawnFlags, userSetup, userSetupData, pidCallback, pidCallbackData))

type
  DriveIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    changed*: proc(drive: ptr Drive00) {.cdecl.}
    disconnected*: proc(drive: ptr Drive00) {.cdecl.}
    ejectButton*: proc(drive: ptr Drive00) {.cdecl.}
    getName*: proc(drive: ptr Drive00): cstring {.cdecl.}
    getIcon*: proc(drive: ptr Drive00): ptr Icon00 {.cdecl.}
    hasVolumes*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    getVolumes*: proc(drive: ptr Drive00): ptr pointer {.cdecl.}
    isMediaRemovable*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    hasMedia*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    isMediaCheckAutomatic*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    canEject*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    canPollForMedia*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    eject*: proc(drive: ptr Drive00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    ejectFinish*: proc(drive: ptr Drive00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    pollForMedia*: proc(drive: ptr Drive00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    pollForMediaFinish*: proc(drive: ptr Drive00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    getIdentifier*: proc(drive: ptr Drive00; kind: cstring): cstring {.cdecl.}
    enumerateIdentifiers*: proc(drive: ptr Drive00): cstringArray {.cdecl.}
    getStartStopType*: proc(drive: ptr Drive00): DriveStartStopType {.cdecl.}
    canStart*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    canStartDegraded*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    start*: proc(drive: ptr Drive00; flags: DriveStartFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    startFinish*: proc(drive: ptr Drive00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    canStop*: proc(drive: ptr Drive00): gboolean {.cdecl.}
    stop*: proc(drive: ptr Drive00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    stopFinish*: proc(drive: ptr Drive00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    stopButton*: proc(drive: ptr Drive00) {.cdecl.}
    ejectWithOperation*: proc(drive: ptr Drive00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    ejectWithOperationFinish*: proc(drive: ptr Drive00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    getSortKey*: proc(drive: ptr Drive00): cstring {.cdecl.}
    getSymbolicIcon*: proc(drive: ptr Drive00): ptr Icon00 {.cdecl.}
    isRemovable*: proc(drive: ptr Drive00): gboolean {.cdecl.}
  DriveIface* = ref object
    impl*: ptr DriveIface00

type
  DtlsClientConnection00* {.pure.} = object
  DtlsClientConnection* = ref object
    impl*: ptr DtlsClientConnection00

proc g_dtls_client_connection_get_accepted_cas*(self: ptr DtlsClientConnection00): ptr pointer {.
    importc: "g_dtls_client_connection_get_accepted_cas", libprag.}

proc getAcceptedCas*(self: DtlsClientConnection): ptr pointer =
  g_dtls_client_connection_get_accepted_cas(cast[ptr DtlsClientConnection00](self.impl))

proc acceptedCas*(self: DtlsClientConnection): ptr pointer =
  g_dtls_client_connection_get_accepted_cas(cast[ptr DtlsClientConnection00](self.impl))

type
  SocketConnectable00* {.pure.} = object
  SocketConnectable* = ref object
    impl*: ptr SocketConnectable00

proc g_socket_connectable_to_string*(self: ptr SocketConnectable00): cstring {.
    importc: "g_socket_connectable_to_string", libprag.}

proc toString*(self: SocketConnectable): string =
  let resul0 = g_socket_connectable_to_string(cast[ptr SocketConnectable00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_dtls_client_connection_new*(baseSocket: ptr DatagramBased00; serverIdentity: ptr SocketConnectable00): ptr DtlsClientConnection00 {.
    importc: "g_dtls_client_connection_new", libprag.}

proc newDtlsClientConnection*(baseSocket: DatagramBased; serverIdentity: SocketConnectable): DtlsClientConnection =
  new(result)
  result.impl = g_dtls_client_connection_new(cast[ptr DatagramBased00](baseSocket.impl), cast[ptr SocketConnectable00](serverIdentity.impl))

proc g_dtls_client_connection_get_server_identity*(self: ptr DtlsClientConnection00): ptr SocketConnectable00 {.
    importc: "g_dtls_client_connection_get_server_identity", libprag.}

proc getServerIdentity*(self: DtlsClientConnection): SocketConnectable =
  new(result)
  result.impl = g_dtls_client_connection_get_server_identity(cast[ptr DtlsClientConnection00](self.impl))

proc serverIdentity*(self: DtlsClientConnection): SocketConnectable =
  new(result)
  result.impl = g_dtls_client_connection_get_server_identity(cast[ptr DtlsClientConnection00](self.impl))

proc g_dtls_client_connection_set_server_identity*(self: ptr DtlsClientConnection00; identity: ptr SocketConnectable00) {.
    importc: "g_dtls_client_connection_set_server_identity", libprag.}

proc setServerIdentity*(self: DtlsClientConnection; identity: SocketConnectable) =
  g_dtls_client_connection_set_server_identity(cast[ptr DtlsClientConnection00](self.impl), cast[ptr SocketConnectable00](identity.impl))

proc `serverIdentity=`*(self: DtlsClientConnection; identity: SocketConnectable) =
  g_dtls_client_connection_set_server_identity(cast[ptr DtlsClientConnection00](self.impl), cast[ptr SocketConnectable00](identity.impl))

type
  SocketAddressEnumerator* = ref object of gobject.Object
  SocketAddressEnumerator00* = object of gobject.Object00

proc g_socket_address_enumerator_next*(self: ptr SocketAddressEnumerator00; cancellable: ptr Cancellable00): ptr SocketAddress00 {.
    importc: "g_socket_address_enumerator_next", libprag.}

proc next*(self: SocketAddressEnumerator; cancellable: Cancellable): SocketAddress =
  let gobj = g_socket_address_enumerator_next(cast[ptr SocketAddressEnumerator00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_address_enumerator_next_async*(self: ptr SocketAddressEnumerator00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_address_enumerator_next_async", libprag.}

proc nextAsync*(self: SocketAddressEnumerator; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_socket_address_enumerator_next_async(cast[ptr SocketAddressEnumerator00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_address_enumerator_next_finish*(self: ptr SocketAddressEnumerator00; resu: ptr AsyncResult00): ptr SocketAddress00 {.
    importc: "g_socket_address_enumerator_next_finish", libprag.}

proc nextFinish*(self: SocketAddressEnumerator; resu: AsyncResult): SocketAddress =
  let gobj = g_socket_address_enumerator_next_finish(cast[ptr SocketAddressEnumerator00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_connectable_enumerate*(self: ptr SocketConnectable00): ptr SocketAddressEnumerator00 {.
    importc: "g_socket_connectable_enumerate", libprag.}

proc enumerate*(self: SocketConnectable): SocketAddressEnumerator =
  let gobj = g_socket_connectable_enumerate(cast[ptr SocketConnectable00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddressEnumerator](g_object_get_qdata(gobj, Quark))
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

proc g_socket_connectable_proxy_enumerate*(self: ptr SocketConnectable00): ptr SocketAddressEnumerator00 {.
    importc: "g_socket_connectable_proxy_enumerate", libprag.}

proc proxyEnumerate*(self: SocketConnectable): SocketAddressEnumerator =
  let gobj = g_socket_connectable_proxy_enumerate(cast[ptr SocketConnectable00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddressEnumerator](g_object_get_qdata(gobj, Quark))
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
  TlsCertificateFlags* {.size: sizeof(cint), pure.} = enum
    unknownCa = 1
    badIdentity = 2
    notActivated = 4
    expired = 8
    revoked = 16
    insecure = 32
    genericError = 64
    validateAll = 127

proc g_dtls_client_connection_get_validation_flags*(self: ptr DtlsClientConnection00): TlsCertificateFlags {.
    importc: "g_dtls_client_connection_get_validation_flags", libprag.}

proc getValidationFlags*(self: DtlsClientConnection): TlsCertificateFlags =
  g_dtls_client_connection_get_validation_flags(cast[ptr DtlsClientConnection00](self.impl))

proc validationFlags*(self: DtlsClientConnection): TlsCertificateFlags =
  g_dtls_client_connection_get_validation_flags(cast[ptr DtlsClientConnection00](self.impl))

proc g_dtls_client_connection_set_validation_flags*(self: ptr DtlsClientConnection00; flags: TlsCertificateFlags) {.
    importc: "g_dtls_client_connection_set_validation_flags", libprag.}

proc setValidationFlags*(self: DtlsClientConnection; flags: TlsCertificateFlags) =
  g_dtls_client_connection_set_validation_flags(cast[ptr DtlsClientConnection00](self.impl), flags)

proc `validationFlags=`*(self: DtlsClientConnection; flags: TlsCertificateFlags) =
  g_dtls_client_connection_set_validation_flags(cast[ptr DtlsClientConnection00](self.impl), flags)

type
  DtlsClientConnectionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
  DtlsClientConnectionInterface* = ref object
    impl*: ptr DtlsClientConnectionInterface00

type
  DtlsConnection00* {.pure.} = object
  DtlsConnection* = ref object
    impl*: ptr DtlsConnection00

proc g_dtls_connection_close*(self: ptr DtlsConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_dtls_connection_close", libprag.}

proc close*(self: DtlsConnection; cancellable: Cancellable): bool =
  toBool(g_dtls_connection_close(cast[ptr DtlsConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_dtls_connection_close_async*(self: ptr DtlsConnection00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dtls_connection_close_async", libprag.}

proc closeAsync*(self: DtlsConnection; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_dtls_connection_close_async(cast[ptr DtlsConnection00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dtls_connection_close_finish*(self: ptr DtlsConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_dtls_connection_close_finish", libprag.}

proc closeFinish*(self: DtlsConnection; resu: AsyncResult): bool =
  toBool(g_dtls_connection_close_finish(cast[ptr DtlsConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_dtls_connection_get_peer_certificate_errors*(self: ptr DtlsConnection00): TlsCertificateFlags {.
    importc: "g_dtls_connection_get_peer_certificate_errors", libprag.}

proc getPeerCertificateErrors*(self: DtlsConnection): TlsCertificateFlags =
  g_dtls_connection_get_peer_certificate_errors(cast[ptr DtlsConnection00](self.impl))

proc peerCertificateErrors*(self: DtlsConnection): TlsCertificateFlags =
  g_dtls_connection_get_peer_certificate_errors(cast[ptr DtlsConnection00](self.impl))

proc g_dtls_connection_get_require_close_notify*(self: ptr DtlsConnection00): gboolean {.
    importc: "g_dtls_connection_get_require_close_notify", libprag.}

proc getRequireCloseNotify*(self: DtlsConnection): bool =
  toBool(g_dtls_connection_get_require_close_notify(cast[ptr DtlsConnection00](self.impl)))

proc requireCloseNotify*(self: DtlsConnection): bool =
  toBool(g_dtls_connection_get_require_close_notify(cast[ptr DtlsConnection00](self.impl)))

proc g_dtls_connection_handshake*(self: ptr DtlsConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_dtls_connection_handshake", libprag.}

proc handshake*(self: DtlsConnection; cancellable: Cancellable): bool =
  toBool(g_dtls_connection_handshake(cast[ptr DtlsConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_dtls_connection_handshake_async*(self: ptr DtlsConnection00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dtls_connection_handshake_async", libprag.}

proc handshakeAsync*(self: DtlsConnection; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_dtls_connection_handshake_async(cast[ptr DtlsConnection00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dtls_connection_handshake_finish*(self: ptr DtlsConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_dtls_connection_handshake_finish", libprag.}

proc handshakeFinish*(self: DtlsConnection; resu: AsyncResult): bool =
  toBool(g_dtls_connection_handshake_finish(cast[ptr DtlsConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_dtls_connection_set_require_close_notify*(self: ptr DtlsConnection00; requireCloseNotify: gboolean) {.
    importc: "g_dtls_connection_set_require_close_notify", libprag.}

proc setRequireCloseNotify*(self: DtlsConnection; requireCloseNotify: bool) =
  g_dtls_connection_set_require_close_notify(cast[ptr DtlsConnection00](self.impl), gboolean(requireCloseNotify))

proc `requireCloseNotify=`*(self: DtlsConnection; requireCloseNotify: bool) =
  g_dtls_connection_set_require_close_notify(cast[ptr DtlsConnection00](self.impl), gboolean(requireCloseNotify))

proc g_dtls_connection_shutdown*(self: ptr DtlsConnection00; shutdownRead: gboolean; 
    shutdownWrite: gboolean; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_dtls_connection_shutdown", libprag.}

proc shutdown*(self: DtlsConnection; shutdownRead: bool; shutdownWrite: bool; 
    cancellable: Cancellable): bool =
  toBool(g_dtls_connection_shutdown(cast[ptr DtlsConnection00](self.impl), gboolean(shutdownRead), gboolean(shutdownWrite), cast[ptr Cancellable00](cancellable.impl)))

proc g_dtls_connection_shutdown_async*(self: ptr DtlsConnection00; shutdownRead: gboolean; 
    shutdownWrite: gboolean; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_dtls_connection_shutdown_async", libprag.}

proc shutdownAsync*(self: DtlsConnection; shutdownRead: bool; shutdownWrite: bool; 
    ioPriority: int; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_dtls_connection_shutdown_async(cast[ptr DtlsConnection00](self.impl), gboolean(shutdownRead), gboolean(shutdownWrite), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dtls_connection_shutdown_finish*(self: ptr DtlsConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_dtls_connection_shutdown_finish", libprag.}

proc shutdownFinish*(self: DtlsConnection; resu: AsyncResult): bool =
  toBool(g_dtls_connection_shutdown_finish(cast[ptr DtlsConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

type
  TlsCertificatePrivate00* {.pure.} = object
  TlsCertificatePrivate* = ref object
    impl*: ptr TlsCertificatePrivate00

type
  TlsCertificate* = ref object of gobject.Object
  TlsCertificate00* = object of gobject.Object00
    priv1: ptr TlsCertificatePrivate00

proc g_tls_certificate_new_from_file*(file: ucstring): ptr TlsCertificate00 {.
    importc: "g_tls_certificate_new_from_file", libprag.}

proc newTlsCertificateFromFile*(file: ucstring): TlsCertificate =
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_file(file)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTlsCertificateFromFile*[T](result: var T; file: ucstring) =
  assert(result is TlsCertificate)
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_file(file)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_tls_certificate_new_from_files*(certFile: ucstring; keyFile: ucstring): ptr TlsCertificate00 {.
    importc: "g_tls_certificate_new_from_files", libprag.}

proc newTlsCertificateFromFiles*(certFile: ucstring; keyFile: ucstring): TlsCertificate =
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_files(certFile, keyFile)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTlsCertificateFromFiles*[T](result: var T; certFile: ucstring; keyFile: ucstring) =
  assert(result is TlsCertificate)
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_files(certFile, keyFile)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_tls_certificate_new_from_pem*(data: cstring; length: int64): ptr TlsCertificate00 {.
    importc: "g_tls_certificate_new_from_pem", libprag.}

proc newTlsCertificateFromPem*(data: string; length: int64): TlsCertificate =
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_pem(cstring(data), length)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTlsCertificateFromPem*[T](result: var T; data: string; length: int64) =
  assert(result is TlsCertificate)
  new(result, finalizeGObject)
  result.impl = g_tls_certificate_new_from_pem(cstring(data), length)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_tls_certificate_list_new_from_file*(file: ucstring): ptr pointer {.
    importc: "g_tls_certificate_list_new_from_file", libprag.}

proc listNewFromFile*(file: ucstring): ptr pointer {.
    importc: "g_tls_certificate_list_new_from_file", libprag.}

proc g_tls_certificate_get_issuer*(self: ptr TlsCertificate00): ptr TlsCertificate00 {.
    importc: "g_tls_certificate_get_issuer", libprag.}

proc getIssuer*(self: TlsCertificate): TlsCertificate =
  let gobj = g_tls_certificate_get_issuer(cast[ptr TlsCertificate00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc issuer*(self: TlsCertificate): TlsCertificate =
  let gobj = g_tls_certificate_get_issuer(cast[ptr TlsCertificate00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_certificate_is_same*(self: ptr TlsCertificate00; certTwo: ptr TlsCertificate00): gboolean {.
    importc: "g_tls_certificate_is_same", libprag.}

proc isSame*(self: TlsCertificate; certTwo: TlsCertificate): bool =
  toBool(g_tls_certificate_is_same(cast[ptr TlsCertificate00](self.impl), cast[ptr TlsCertificate00](certTwo.impl)))

proc g_tls_certificate_verify*(self: ptr TlsCertificate00; identity: ptr SocketConnectable00; 
    trustedCa: ptr TlsCertificate00): TlsCertificateFlags {.
    importc: "g_tls_certificate_verify", libprag.}

proc verify*(self: TlsCertificate; identity: SocketConnectable; 
    trustedCa: TlsCertificate): TlsCertificateFlags =
  g_tls_certificate_verify(cast[ptr TlsCertificate00](self.impl), cast[ptr SocketConnectable00](identity.impl), cast[ptr TlsCertificate00](trustedCa.impl))

proc g_dtls_connection_emit_accept_certificate*(self: ptr DtlsConnection00; peerCert: ptr TlsCertificate00; 
    errors: TlsCertificateFlags): gboolean {.
    importc: "g_dtls_connection_emit_accept_certificate", libprag.}

proc emitAcceptCertificate*(self: DtlsConnection; peerCert: TlsCertificate; errors: TlsCertificateFlags): bool =
  toBool(g_dtls_connection_emit_accept_certificate(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsCertificate00](peerCert.impl), errors))

proc g_dtls_connection_get_certificate*(self: ptr DtlsConnection00): ptr TlsCertificate00 {.
    importc: "g_dtls_connection_get_certificate", libprag.}

proc getCertificate*(self: DtlsConnection): TlsCertificate =
  let gobj = g_dtls_connection_get_certificate(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc certificate*(self: DtlsConnection): TlsCertificate =
  let gobj = g_dtls_connection_get_certificate(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_dtls_connection_get_peer_certificate*(self: ptr DtlsConnection00): ptr TlsCertificate00 {.
    importc: "g_dtls_connection_get_peer_certificate", libprag.}

proc getPeerCertificate*(self: DtlsConnection): TlsCertificate =
  let gobj = g_dtls_connection_get_peer_certificate(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc peerCertificate*(self: DtlsConnection): TlsCertificate =
  let gobj = g_dtls_connection_get_peer_certificate(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_dtls_connection_set_certificate*(self: ptr DtlsConnection00; certificate: ptr TlsCertificate00) {.
    importc: "g_dtls_connection_set_certificate", libprag.}

proc setCertificate*(self: DtlsConnection; certificate: TlsCertificate) =
  g_dtls_connection_set_certificate(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsCertificate00](certificate.impl))

proc `certificate=`*(self: DtlsConnection; certificate: TlsCertificate) =
  g_dtls_connection_set_certificate(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsCertificate00](certificate.impl))

type
  TlsDatabasePrivate00* {.pure.} = object
  TlsDatabasePrivate* = ref object
    impl*: ptr TlsDatabasePrivate00

type
  TlsDatabase* = ref object of gobject.Object
  TlsDatabase00* = object of gobject.Object00
    priv1: ptr TlsDatabasePrivate00

proc g_tls_database_create_certificate_handle*(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00): cstring {.
    importc: "g_tls_database_create_certificate_handle", libprag.}

proc createCertificateHandle*(self: TlsDatabase; certificate: TlsCertificate): string =
  let resul0 = g_tls_database_create_certificate_handle(cast[ptr TlsDatabase00](self.impl), cast[ptr TlsCertificate00](certificate.impl))
  result = $resul0
  cogfree(resul0)

proc g_tls_database_lookup_certificate_for_handle_finish*(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr TlsCertificate00 {.
    importc: "g_tls_database_lookup_certificate_for_handle_finish", libprag.}

proc lookupCertificateForHandleFinish*(self: TlsDatabase; resu: AsyncResult): TlsCertificate =
  let gobj = g_tls_database_lookup_certificate_for_handle_finish(cast[ptr TlsDatabase00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_database_lookup_certificate_issuer_finish*(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr TlsCertificate00 {.
    importc: "g_tls_database_lookup_certificate_issuer_finish", libprag.}

proc lookupCertificateIssuerFinish*(self: TlsDatabase; resu: AsyncResult): TlsCertificate =
  let gobj = g_tls_database_lookup_certificate_issuer_finish(cast[ptr TlsDatabase00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_database_lookup_certificates_issued_by_finish*(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr pointer {.
    importc: "g_tls_database_lookup_certificates_issued_by_finish", libprag.}

proc lookupCertificatesIssuedByFinish*(self: TlsDatabase; resu: AsyncResult): ptr pointer =
  g_tls_database_lookup_certificates_issued_by_finish(cast[ptr TlsDatabase00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_tls_database_verify_chain_finish*(self: ptr TlsDatabase00; resu: ptr AsyncResult00): TlsCertificateFlags {.
    importc: "g_tls_database_verify_chain_finish", libprag.}

proc verifyChainFinish*(self: TlsDatabase; resu: AsyncResult): TlsCertificateFlags =
  g_tls_database_verify_chain_finish(cast[ptr TlsDatabase00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_dtls_connection_get_database*(self: ptr DtlsConnection00): ptr TlsDatabase00 {.
    importc: "g_dtls_connection_get_database", libprag.}

proc getDatabase*(self: DtlsConnection): TlsDatabase =
  let gobj = g_dtls_connection_get_database(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc database*(self: DtlsConnection): TlsDatabase =
  let gobj = g_dtls_connection_get_database(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc g_dtls_connection_set_database*(self: ptr DtlsConnection00; database: ptr TlsDatabase00) {.
    importc: "g_dtls_connection_set_database", libprag.}

proc setDatabase*(self: DtlsConnection; database: TlsDatabase) =
  g_dtls_connection_set_database(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsDatabase00](database.impl))

proc `database=`*(self: DtlsConnection; database: TlsDatabase) =
  g_dtls_connection_set_database(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsDatabase00](database.impl))

type
  TlsInteractionPrivate00* {.pure.} = object
  TlsInteractionPrivate* = ref object
    impl*: ptr TlsInteractionPrivate00

type
  TlsInteraction* = ref object of gobject.Object
  TlsInteraction00* = object of gobject.Object00
    priv1: ptr TlsInteractionPrivate00

proc g_dtls_connection_get_interaction*(self: ptr DtlsConnection00): ptr TlsInteraction00 {.
    importc: "g_dtls_connection_get_interaction", libprag.}

proc getInteraction*(self: DtlsConnection): TlsInteraction =
  let gobj = g_dtls_connection_get_interaction(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsInteraction](g_object_get_qdata(gobj, Quark))
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

proc interaction*(self: DtlsConnection): TlsInteraction =
  let gobj = g_dtls_connection_get_interaction(cast[ptr DtlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsInteraction](g_object_get_qdata(gobj, Quark))
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

proc g_dtls_connection_set_interaction*(self: ptr DtlsConnection00; interaction: ptr TlsInteraction00) {.
    importc: "g_dtls_connection_set_interaction", libprag.}

proc setInteraction*(self: DtlsConnection; interaction: TlsInteraction) =
  g_dtls_connection_set_interaction(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsInteraction00](interaction.impl))

proc `interaction=`*(self: DtlsConnection; interaction: TlsInteraction) =
  g_dtls_connection_set_interaction(cast[ptr DtlsConnection00](self.impl), cast[ptr TlsInteraction00](interaction.impl))

type
  TlsDatabaseLookupFlag* {.size: sizeof(cint), pure.} = enum
    keypair = 1

  TlsDatabaseLookupFlags* {.size: sizeof(cint).} = set[TlsDatabaseLookupFlag]

proc g_tls_database_lookup_certificate_for_handle*(self: ptr TlsDatabase00; handle: cstring; interaction: ptr TlsInteraction00; 
    flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr TlsCertificate00 {.
    importc: "g_tls_database_lookup_certificate_for_handle", libprag.}

proc lookupCertificateForHandle*(self: TlsDatabase; handle: string; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable): TlsCertificate =
  let gobj = g_tls_database_lookup_certificate_for_handle(cast[ptr TlsDatabase00](self.impl), cstring(handle), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_database_lookup_certificate_for_handle_async*(self: ptr TlsDatabase00; handle: cstring; interaction: ptr TlsInteraction00; 
    flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_tls_database_lookup_certificate_for_handle_async", libprag.}

proc lookupCertificateForHandleAsync*(self: TlsDatabase; handle: string; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_tls_database_lookup_certificate_for_handle_async(cast[ptr TlsDatabase00](self.impl), cstring(handle), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_tls_database_lookup_certificate_issuer*(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr TlsCertificate00 {.
    importc: "g_tls_database_lookup_certificate_issuer", libprag.}

proc lookupCertificateIssuer*(self: TlsDatabase; certificate: TlsCertificate; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable): TlsCertificate =
  let gobj = g_tls_database_lookup_certificate_issuer(cast[ptr TlsDatabase00](self.impl), cast[ptr TlsCertificate00](certificate.impl), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_database_lookup_certificate_issuer_async*(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_tls_database_lookup_certificate_issuer_async", libprag.}

proc lookupCertificateIssuerAsync*(self: TlsDatabase; certificate: TlsCertificate; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_tls_database_lookup_certificate_issuer_async(cast[ptr TlsDatabase00](self.impl), cast[ptr TlsCertificate00](certificate.impl), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_tls_database_lookup_certificates_issued_by*(self: ptr TlsDatabase00; issuerRawDn: ptr ByteArray00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr pointer {.
    importc: "g_tls_database_lookup_certificates_issued_by", libprag.}

proc lookupCertificatesIssuedBy*(self: TlsDatabase; issuerRawDn: ptr ByteArray00; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable): ptr pointer =
  g_tls_database_lookup_certificates_issued_by(cast[ptr TlsDatabase00](self.impl), issuerRawDn, cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl))

proc g_tls_database_lookup_certificates_issued_by_async*(self: ptr TlsDatabase00; issuerRawDn: ptr ByteArray00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_tls_database_lookup_certificates_issued_by_async", libprag.}

proc lookupCertificatesIssuedByAsync*(self: TlsDatabase; issuerRawDn: ptr ByteArray00; interaction: TlsInteraction; 
    flags: TlsDatabaseLookupFlags; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_tls_database_lookup_certificates_issued_by_async(cast[ptr TlsDatabase00](self.impl), issuerRawDn, cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  TlsDatabaseVerifyFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

proc g_tls_database_verify_chain*(self: ptr TlsDatabase00; chain: ptr TlsCertificate00; 
    purpose: cstring; identity: ptr SocketConnectable00; interaction: ptr TlsInteraction00; flags: TlsDatabaseVerifyFlags; 
    cancellable: ptr Cancellable00): TlsCertificateFlags {.
    importc: "g_tls_database_verify_chain", libprag.}

proc verifyChain*(self: TlsDatabase; chain: TlsCertificate; purpose: string; 
    identity: SocketConnectable; interaction: TlsInteraction; flags: TlsDatabaseVerifyFlags; 
    cancellable: Cancellable): TlsCertificateFlags =
  g_tls_database_verify_chain(cast[ptr TlsDatabase00](self.impl), cast[ptr TlsCertificate00](chain.impl), cstring(purpose), cast[ptr SocketConnectable00](identity.impl), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl))

proc g_tls_database_verify_chain_async*(self: ptr TlsDatabase00; chain: ptr TlsCertificate00; 
    purpose: cstring; identity: ptr SocketConnectable00; interaction: ptr TlsInteraction00; flags: TlsDatabaseVerifyFlags; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_tls_database_verify_chain_async", libprag.}

proc verifyChainAsync*(self: TlsDatabase; chain: TlsCertificate; purpose: string; 
    identity: SocketConnectable; interaction: TlsInteraction; flags: TlsDatabaseVerifyFlags; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_tls_database_verify_chain_async(cast[ptr TlsDatabase00](self.impl), cast[ptr TlsCertificate00](chain.impl), cstring(purpose), cast[ptr SocketConnectable00](identity.impl), cast[ptr TlsInteraction00](interaction.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  TlsPasswordPrivate00* {.pure.} = object
  TlsPasswordPrivate* = ref object
    impl*: ptr TlsPasswordPrivate00

type
  TlsPassword* = ref object of gobject.Object
  TlsPassword00* = object of gobject.Object00
    priv1: ptr TlsPasswordPrivate00

proc g_tls_password_get_description*(self: ptr TlsPassword00): cstring {.
    importc: "g_tls_password_get_description", libprag.}

proc getDescription*(self: TlsPassword): string =
  let resul0 = g_tls_password_get_description(cast[ptr TlsPassword00](self.impl))
  result = $resul0

proc description*(self: TlsPassword): string =
  let resul0 = g_tls_password_get_description(cast[ptr TlsPassword00](self.impl))
  result = $resul0

proc g_tls_password_get_value*(self: ptr TlsPassword00; length: ptr uint64): ptr uint8 {.
    importc: "g_tls_password_get_value", libprag.}

proc getValue*(self: TlsPassword; length: ptr uint64): ptr uint8 =
  g_tls_password_get_value(cast[ptr TlsPassword00](self.impl), length)

proc value*(self: TlsPassword; length: ptr uint64): ptr uint8 =
  g_tls_password_get_value(cast[ptr TlsPassword00](self.impl), length)

proc g_tls_password_get_warning*(self: ptr TlsPassword00): cstring {.
    importc: "g_tls_password_get_warning", libprag.}

proc getWarning*(self: TlsPassword): string =
  let resul0 = g_tls_password_get_warning(cast[ptr TlsPassword00](self.impl))
  result = $resul0

proc warning*(self: TlsPassword): string =
  let resul0 = g_tls_password_get_warning(cast[ptr TlsPassword00](self.impl))
  result = $resul0

proc g_tls_password_set_description*(self: ptr TlsPassword00; description: cstring) {.
    importc: "g_tls_password_set_description", libprag.}

proc setDescription*(self: TlsPassword; description: string) =
  g_tls_password_set_description(cast[ptr TlsPassword00](self.impl), cstring(description))

proc `description=`*(self: TlsPassword; description: string) =
  g_tls_password_set_description(cast[ptr TlsPassword00](self.impl), cstring(description))

proc g_tls_password_set_value*(self: ptr TlsPassword00; value: ptr uint8; length: int64) {.
    importc: "g_tls_password_set_value", libprag.}

proc setValue*(self: TlsPassword; value: ptr uint8; length: int64) =
  g_tls_password_set_value(cast[ptr TlsPassword00](self.impl), value, length)

proc g_tls_password_set_value_full*(self: ptr TlsPassword00; value: ptr uint8; length: int64; 
    destroy: DestroyNotify) {.
    importc: "g_tls_password_set_value_full", libprag.}

proc setValueFull*(self: TlsPassword; value: ptr uint8; length: int64; 
    destroy: DestroyNotify) =
  g_tls_password_set_value_full(cast[ptr TlsPassword00](self.impl), value, length, destroy)

proc g_tls_password_set_warning*(self: ptr TlsPassword00; warning: cstring) {.
    importc: "g_tls_password_set_warning", libprag.}

proc setWarning*(self: TlsPassword; warning: string) =
  g_tls_password_set_warning(cast[ptr TlsPassword00](self.impl), cstring(warning))

proc `warning=`*(self: TlsPassword; warning: string) =
  g_tls_password_set_warning(cast[ptr TlsPassword00](self.impl), cstring(warning))

proc g_tls_interaction_ask_password_async*(self: ptr TlsInteraction00; password: ptr TlsPassword00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_tls_interaction_ask_password_async", libprag.}

proc askPasswordAsync*(self: TlsInteraction; password: TlsPassword; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_tls_interaction_ask_password_async(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsPassword00](password.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  TlsPasswordFlag* {.size: sizeof(cint), pure.} = enum
    retry = 2
    manyTries = 3
    finalTry = 4

  TlsPasswordFlags* {.size: sizeof(cint).} = set[TlsPasswordFlag]

proc g_tls_password_new*(flags: TlsPasswordFlags; description: cstring): ptr TlsPassword00 {.
    importc: "g_tls_password_new", libprag.}

proc newTlsPassword*(flags: TlsPasswordFlags; description: string): TlsPassword =
  new(result, finalizeGObject)
  result.impl = g_tls_password_new(flags, cstring(description))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTlsPassword*[T](result: var T; flags: TlsPasswordFlags; description: string) =
  assert(result is TlsPassword)
  new(result, finalizeGObject)
  result.impl = g_tls_password_new(flags, cstring(description))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_tls_password_get_flags*(self: ptr TlsPassword00): TlsPasswordFlags {.
    importc: "g_tls_password_get_flags", libprag.}

proc getFlags*(self: TlsPassword): TlsPasswordFlags =
  g_tls_password_get_flags(cast[ptr TlsPassword00](self.impl))

proc flags*(self: TlsPassword): TlsPasswordFlags =
  g_tls_password_get_flags(cast[ptr TlsPassword00](self.impl))

proc g_tls_password_set_flags*(self: ptr TlsPassword00; flags: TlsPasswordFlags) {.
    importc: "g_tls_password_set_flags", libprag.}

proc setFlags*(self: TlsPassword; flags: TlsPasswordFlags) =
  g_tls_password_set_flags(cast[ptr TlsPassword00](self.impl), flags)

proc `flags=`*(self: TlsPassword; flags: TlsPasswordFlags) =
  g_tls_password_set_flags(cast[ptr TlsPassword00](self.impl), flags)

type
  TlsConnectionPrivate00* {.pure.} = object
  TlsConnectionPrivate* = ref object
    impl*: ptr TlsConnectionPrivate00

type
  TlsConnection* = ref object of IOStream
  TlsConnection00* = object of IOStream00
    priv2: ptr TlsConnectionPrivate00

proc scAcceptCertificate*(self: TlsConnection;  p: proc (self: ptr gobject.Object00; peerCert: TlsCertificate00; errors: TlsCertificateFlags; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "accept-certificate", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_tls_connection_emit_accept_certificate*(self: ptr TlsConnection00; peerCert: ptr TlsCertificate00; 
    errors: TlsCertificateFlags): gboolean {.
    importc: "g_tls_connection_emit_accept_certificate", libprag.}

proc emitAcceptCertificate*(self: TlsConnection; peerCert: TlsCertificate; errors: TlsCertificateFlags): bool =
  toBool(g_tls_connection_emit_accept_certificate(cast[ptr TlsConnection00](self.impl), cast[ptr TlsCertificate00](peerCert.impl), errors))

proc g_tls_connection_get_certificate*(self: ptr TlsConnection00): ptr TlsCertificate00 {.
    importc: "g_tls_connection_get_certificate", libprag.}

proc getCertificate*(self: TlsConnection): TlsCertificate =
  let gobj = g_tls_connection_get_certificate(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc certificate*(self: TlsConnection): TlsCertificate =
  let gobj = g_tls_connection_get_certificate(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_connection_get_database*(self: ptr TlsConnection00): ptr TlsDatabase00 {.
    importc: "g_tls_connection_get_database", libprag.}

proc getDatabase*(self: TlsConnection): TlsDatabase =
  let gobj = g_tls_connection_get_database(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc database*(self: TlsConnection): TlsDatabase =
  let gobj = g_tls_connection_get_database(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc g_tls_connection_get_interaction*(self: ptr TlsConnection00): ptr TlsInteraction00 {.
    importc: "g_tls_connection_get_interaction", libprag.}

proc getInteraction*(self: TlsConnection): TlsInteraction =
  let gobj = g_tls_connection_get_interaction(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsInteraction](g_object_get_qdata(gobj, Quark))
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

proc interaction*(self: TlsConnection): TlsInteraction =
  let gobj = g_tls_connection_get_interaction(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsInteraction](g_object_get_qdata(gobj, Quark))
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

proc g_tls_connection_get_peer_certificate*(self: ptr TlsConnection00): ptr TlsCertificate00 {.
    importc: "g_tls_connection_get_peer_certificate", libprag.}

proc getPeerCertificate*(self: TlsConnection): TlsCertificate =
  let gobj = g_tls_connection_get_peer_certificate(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc peerCertificate*(self: TlsConnection): TlsCertificate =
  let gobj = g_tls_connection_get_peer_certificate(cast[ptr TlsConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsCertificate](g_object_get_qdata(gobj, Quark))
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

proc g_tls_connection_get_peer_certificate_errors*(self: ptr TlsConnection00): TlsCertificateFlags {.
    importc: "g_tls_connection_get_peer_certificate_errors", libprag.}

proc getPeerCertificateErrors*(self: TlsConnection): TlsCertificateFlags =
  g_tls_connection_get_peer_certificate_errors(cast[ptr TlsConnection00](self.impl))

proc peerCertificateErrors*(self: TlsConnection): TlsCertificateFlags =
  g_tls_connection_get_peer_certificate_errors(cast[ptr TlsConnection00](self.impl))

proc g_tls_connection_get_require_close_notify*(self: ptr TlsConnection00): gboolean {.
    importc: "g_tls_connection_get_require_close_notify", libprag.}

proc getRequireCloseNotify*(self: TlsConnection): bool =
  toBool(g_tls_connection_get_require_close_notify(cast[ptr TlsConnection00](self.impl)))

proc requireCloseNotify*(self: TlsConnection): bool =
  toBool(g_tls_connection_get_require_close_notify(cast[ptr TlsConnection00](self.impl)))

proc g_tls_connection_get_use_system_certdb*(self: ptr TlsConnection00): gboolean {.
    importc: "g_tls_connection_get_use_system_certdb", libprag.}

proc getUseSystemCertdb*(self: TlsConnection): bool =
  toBool(g_tls_connection_get_use_system_certdb(cast[ptr TlsConnection00](self.impl)))

proc useSystemCertdb*(self: TlsConnection): bool =
  toBool(g_tls_connection_get_use_system_certdb(cast[ptr TlsConnection00](self.impl)))

proc g_tls_connection_handshake*(self: ptr TlsConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_tls_connection_handshake", libprag.}

proc handshake*(self: TlsConnection; cancellable: Cancellable): bool =
  toBool(g_tls_connection_handshake(cast[ptr TlsConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_tls_connection_handshake_async*(self: ptr TlsConnection00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_tls_connection_handshake_async", libprag.}

proc handshakeAsync*(self: TlsConnection; ioPriority: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_tls_connection_handshake_async(cast[ptr TlsConnection00](self.impl), int32(ioPriority), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_tls_connection_handshake_finish*(self: ptr TlsConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_tls_connection_handshake_finish", libprag.}

proc handshakeFinish*(self: TlsConnection; resu: AsyncResult): bool =
  toBool(g_tls_connection_handshake_finish(cast[ptr TlsConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_tls_connection_set_certificate*(self: ptr TlsConnection00; certificate: ptr TlsCertificate00) {.
    importc: "g_tls_connection_set_certificate", libprag.}

proc setCertificate*(self: TlsConnection; certificate: TlsCertificate) =
  g_tls_connection_set_certificate(cast[ptr TlsConnection00](self.impl), cast[ptr TlsCertificate00](certificate.impl))

proc `certificate=`*(self: TlsConnection; certificate: TlsCertificate) =
  g_tls_connection_set_certificate(cast[ptr TlsConnection00](self.impl), cast[ptr TlsCertificate00](certificate.impl))

proc g_tls_connection_set_database*(self: ptr TlsConnection00; database: ptr TlsDatabase00) {.
    importc: "g_tls_connection_set_database", libprag.}

proc setDatabase*(self: TlsConnection; database: TlsDatabase) =
  g_tls_connection_set_database(cast[ptr TlsConnection00](self.impl), cast[ptr TlsDatabase00](database.impl))

proc `database=`*(self: TlsConnection; database: TlsDatabase) =
  g_tls_connection_set_database(cast[ptr TlsConnection00](self.impl), cast[ptr TlsDatabase00](database.impl))

proc g_tls_connection_set_interaction*(self: ptr TlsConnection00; interaction: ptr TlsInteraction00) {.
    importc: "g_tls_connection_set_interaction", libprag.}

proc setInteraction*(self: TlsConnection; interaction: TlsInteraction) =
  g_tls_connection_set_interaction(cast[ptr TlsConnection00](self.impl), cast[ptr TlsInteraction00](interaction.impl))

proc `interaction=`*(self: TlsConnection; interaction: TlsInteraction) =
  g_tls_connection_set_interaction(cast[ptr TlsConnection00](self.impl), cast[ptr TlsInteraction00](interaction.impl))

proc g_tls_connection_set_require_close_notify*(self: ptr TlsConnection00; requireCloseNotify: gboolean) {.
    importc: "g_tls_connection_set_require_close_notify", libprag.}

proc setRequireCloseNotify*(self: TlsConnection; requireCloseNotify: bool) =
  g_tls_connection_set_require_close_notify(cast[ptr TlsConnection00](self.impl), gboolean(requireCloseNotify))

proc `requireCloseNotify=`*(self: TlsConnection; requireCloseNotify: bool) =
  g_tls_connection_set_require_close_notify(cast[ptr TlsConnection00](self.impl), gboolean(requireCloseNotify))

proc g_tls_connection_set_use_system_certdb*(self: ptr TlsConnection00; useSystemCertdb: gboolean) {.
    importc: "g_tls_connection_set_use_system_certdb", libprag.}

proc setUseSystemCertdb*(self: TlsConnection; useSystemCertdb: bool) =
  g_tls_connection_set_use_system_certdb(cast[ptr TlsConnection00](self.impl), gboolean(useSystemCertdb))

proc `useSystemCertdb=`*(self: TlsConnection; useSystemCertdb: bool) =
  g_tls_connection_set_use_system_certdb(cast[ptr TlsConnection00](self.impl), gboolean(useSystemCertdb))

type
  TlsCertificateRequestFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

proc g_tls_interaction_request_certificate_async*(self: ptr TlsInteraction00; connection: ptr TlsConnection00; 
    flags: TlsCertificateRequestFlags; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.
    importc: "g_tls_interaction_request_certificate_async", libprag.}

proc requestCertificateAsync*(self: TlsInteraction; connection: TlsConnection; flags: TlsCertificateRequestFlags; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_tls_interaction_request_certificate_async(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsConnection00](connection.impl), flags, cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  TlsInteractionResult* {.size: sizeof(cint), pure.} = enum
    unhandled = 0
    handled = 1
    failed = 2

proc g_tls_interaction_ask_password*(self: ptr TlsInteraction00; password: ptr TlsPassword00; 
    cancellable: ptr Cancellable00): TlsInteractionResult {.
    importc: "g_tls_interaction_ask_password", libprag.}

proc askPassword*(self: TlsInteraction; password: TlsPassword; cancellable: Cancellable): TlsInteractionResult =
  g_tls_interaction_ask_password(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsPassword00](password.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_tls_interaction_ask_password_finish*(self: ptr TlsInteraction00; resu: ptr AsyncResult00): TlsInteractionResult {.
    importc: "g_tls_interaction_ask_password_finish", libprag.}

proc askPasswordFinish*(self: TlsInteraction; resu: AsyncResult): TlsInteractionResult =
  g_tls_interaction_ask_password_finish(cast[ptr TlsInteraction00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_tls_interaction_invoke_ask_password*(self: ptr TlsInteraction00; password: ptr TlsPassword00; 
    cancellable: ptr Cancellable00): TlsInteractionResult {.
    importc: "g_tls_interaction_invoke_ask_password", libprag.}

proc invokeAskPassword*(self: TlsInteraction; password: TlsPassword; cancellable: Cancellable): TlsInteractionResult =
  g_tls_interaction_invoke_ask_password(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsPassword00](password.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_tls_interaction_invoke_request_certificate*(self: ptr TlsInteraction00; connection: ptr TlsConnection00; 
    flags: TlsCertificateRequestFlags; cancellable: ptr Cancellable00): TlsInteractionResult {.
    importc: "g_tls_interaction_invoke_request_certificate", libprag.}

proc invokeRequestCertificate*(self: TlsInteraction; connection: TlsConnection; flags: TlsCertificateRequestFlags; 
    cancellable: Cancellable): TlsInteractionResult =
  g_tls_interaction_invoke_request_certificate(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsConnection00](connection.impl), flags, cast[ptr Cancellable00](cancellable.impl))

proc g_tls_interaction_request_certificate*(self: ptr TlsInteraction00; connection: ptr TlsConnection00; 
    flags: TlsCertificateRequestFlags; cancellable: ptr Cancellable00): TlsInteractionResult {.
    importc: "g_tls_interaction_request_certificate", libprag.}

proc requestCertificate*(self: TlsInteraction; connection: TlsConnection; flags: TlsCertificateRequestFlags; 
    cancellable: Cancellable): TlsInteractionResult =
  g_tls_interaction_request_certificate(cast[ptr TlsInteraction00](self.impl), cast[ptr TlsConnection00](connection.impl), flags, cast[ptr Cancellable00](cancellable.impl))

proc g_tls_interaction_request_certificate_finish*(self: ptr TlsInteraction00; resu: ptr AsyncResult00): TlsInteractionResult {.
    importc: "g_tls_interaction_request_certificate_finish", libprag.}

proc requestCertificateFinish*(self: TlsInteraction; resu: AsyncResult): TlsInteractionResult =
  g_tls_interaction_request_certificate_finish(cast[ptr TlsInteraction00](self.impl), cast[ptr AsyncResult00](resu.impl))

type
  TlsRehandshakeMode* {.size: sizeof(cint), pure.} = enum
    never = 0
    safely = 1
    unsafely = 2

proc g_dtls_connection_get_rehandshake_mode*(self: ptr DtlsConnection00): TlsRehandshakeMode {.
    importc: "g_dtls_connection_get_rehandshake_mode", libprag.}

proc getRehandshakeMode*(self: DtlsConnection): TlsRehandshakeMode =
  g_dtls_connection_get_rehandshake_mode(cast[ptr DtlsConnection00](self.impl))

proc rehandshakeMode*(self: DtlsConnection): TlsRehandshakeMode =
  g_dtls_connection_get_rehandshake_mode(cast[ptr DtlsConnection00](self.impl))

proc g_dtls_connection_set_rehandshake_mode*(self: ptr DtlsConnection00; mode: TlsRehandshakeMode) {.
    importc: "g_dtls_connection_set_rehandshake_mode", libprag.}

proc setRehandshakeMode*(self: DtlsConnection; mode: TlsRehandshakeMode) =
  g_dtls_connection_set_rehandshake_mode(cast[ptr DtlsConnection00](self.impl), mode)

proc `rehandshakeMode=`*(self: DtlsConnection; mode: TlsRehandshakeMode) =
  g_dtls_connection_set_rehandshake_mode(cast[ptr DtlsConnection00](self.impl), mode)

proc g_tls_connection_get_rehandshake_mode*(self: ptr TlsConnection00): TlsRehandshakeMode {.
    importc: "g_tls_connection_get_rehandshake_mode", libprag.}

proc getRehandshakeMode*(self: TlsConnection): TlsRehandshakeMode =
  g_tls_connection_get_rehandshake_mode(cast[ptr TlsConnection00](self.impl))

proc rehandshakeMode*(self: TlsConnection): TlsRehandshakeMode =
  g_tls_connection_get_rehandshake_mode(cast[ptr TlsConnection00](self.impl))

proc g_tls_connection_set_rehandshake_mode*(self: ptr TlsConnection00; mode: TlsRehandshakeMode) {.
    importc: "g_tls_connection_set_rehandshake_mode", libprag.}

proc setRehandshakeMode*(self: TlsConnection; mode: TlsRehandshakeMode) =
  g_tls_connection_set_rehandshake_mode(cast[ptr TlsConnection00](self.impl), mode)

proc `rehandshakeMode=`*(self: TlsConnection; mode: TlsRehandshakeMode) =
  g_tls_connection_set_rehandshake_mode(cast[ptr TlsConnection00](self.impl), mode)

type
  DtlsConnectionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    acceptCertificate*: proc(connection: ptr DtlsConnection00; peerCert: ptr TlsCertificate00; 
    errors: TlsCertificateFlags): gboolean {.cdecl.}
    handshake*: proc(conn: ptr DtlsConnection00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    handshakeAsync*: proc(conn: ptr DtlsConnection00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    handshakeFinish*: proc(conn: ptr DtlsConnection00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    shutdown*: proc(conn: ptr DtlsConnection00; shutdownRead: gboolean; 
    shutdownWrite: gboolean; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    shutdownAsync*: proc(conn: ptr DtlsConnection00; shutdownRead: gboolean; 
    shutdownWrite: gboolean; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    shutdownFinish*: proc(conn: ptr DtlsConnection00; resu: ptr AsyncResult00): gboolean {.cdecl.}
  DtlsConnectionInterface* = ref object
    impl*: ptr DtlsConnectionInterface00

type
  DtlsServerConnection00* {.pure.} = object
  DtlsServerConnection* = ref object
    impl*: ptr DtlsServerConnection00

proc g_dtls_server_connection_new*(baseSocket: ptr DatagramBased00; certificate: ptr TlsCertificate00): ptr DtlsServerConnection00 {.
    importc: "g_dtls_server_connection_new", libprag.}

proc newDtlsServerConnection*(baseSocket: DatagramBased; certificate: TlsCertificate): DtlsServerConnection =
  new(result)
  result.impl = g_dtls_server_connection_new(cast[ptr DatagramBased00](baseSocket.impl), cast[ptr TlsCertificate00](certificate.impl))

type
  DtlsServerConnectionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
  DtlsServerConnectionInterface* = ref object
    impl*: ptr DtlsServerConnectionInterface00

type
  Emblem* = ref object of gobject.Object
  Emblem00* = object of gobject.Object00

proc g_emblem_new*(icon: ptr Icon00): ptr Emblem00 {.
    importc: "g_emblem_new", libprag.}

proc newEmblem*(icon: Icon): Emblem =
  new(result, finalizeGObject)
  result.impl = g_emblem_new(cast[ptr Icon00](icon.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEmblem*[T](result: var T; icon: Icon) =
  assert(result is Emblem)
  new(result, finalizeGObject)
  result.impl = g_emblem_new(cast[ptr Icon00](icon.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_emblem_get_icon*(self: ptr Emblem00): ptr Icon00 {.
    importc: "g_emblem_get_icon", libprag.}

proc getIcon*(self: Emblem): Icon =
  new(result)
  result.impl = g_emblem_get_icon(cast[ptr Emblem00](self.impl))

proc icon*(self: Emblem): Icon =
  new(result)
  result.impl = g_emblem_get_icon(cast[ptr Emblem00](self.impl))

type
  EmblemOrigin* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    device = 1
    livemetadata = 2
    tag = 3

proc g_emblem_new_with_origin*(icon: ptr Icon00; origin: EmblemOrigin): ptr Emblem00 {.
    importc: "g_emblem_new_with_origin", libprag.}

proc newEmblemWithOrigin*(icon: Icon; origin: EmblemOrigin): Emblem =
  new(result, finalizeGObject)
  result.impl = g_emblem_new_with_origin(cast[ptr Icon00](icon.impl), origin)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEmblemWithOrigin*[T](result: var T; icon: Icon; origin: EmblemOrigin) =
  assert(result is Emblem)
  new(result, finalizeGObject)
  result.impl = g_emblem_new_with_origin(cast[ptr Icon00](icon.impl), origin)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_emblem_get_origin*(self: ptr Emblem00): EmblemOrigin {.
    importc: "g_emblem_get_origin", libprag.}

proc getOrigin*(self: Emblem): EmblemOrigin =
  g_emblem_get_origin(cast[ptr Emblem00](self.impl))

proc origin*(self: Emblem): EmblemOrigin =
  g_emblem_get_origin(cast[ptr Emblem00](self.impl))

type
  EmblemClass00* {.pure.} = object
  EmblemClass* = ref object
    impl*: ptr EmblemClass00

type
  EmblemedIconPrivate00* {.pure.} = object
  EmblemedIconPrivate* = ref object
    impl*: ptr EmblemedIconPrivate00

type
  EmblemedIcon* = ref object of gobject.Object
  EmblemedIcon00* = object of gobject.Object00
    priv1: ptr EmblemedIconPrivate00

proc g_emblemed_icon_new*(icon: ptr Icon00; emblem: ptr Emblem00): ptr EmblemedIcon00 {.
    importc: "g_emblemed_icon_new", libprag.}

proc newEmblemedIcon*(icon: Icon; emblem: Emblem): EmblemedIcon =
  new(result, finalizeGObject)
  result.impl = g_emblemed_icon_new(cast[ptr Icon00](icon.impl), cast[ptr Emblem00](emblem.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initEmblemedIcon*[T](result: var T; icon: Icon; emblem: Emblem) =
  assert(result is EmblemedIcon)
  new(result, finalizeGObject)
  result.impl = g_emblemed_icon_new(cast[ptr Icon00](icon.impl), cast[ptr Emblem00](emblem.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_emblemed_icon_add_emblem*(self: ptr EmblemedIcon00; emblem: ptr Emblem00) {.
    importc: "g_emblemed_icon_add_emblem", libprag.}

proc addEmblem*(self: EmblemedIcon; emblem: Emblem) =
  g_emblemed_icon_add_emblem(cast[ptr EmblemedIcon00](self.impl), cast[ptr Emblem00](emblem.impl))

proc g_emblemed_icon_clear_emblems*(self: ptr EmblemedIcon00) {.
    importc: "g_emblemed_icon_clear_emblems", libprag.}

proc clearEmblems*(self: EmblemedIcon) =
  g_emblemed_icon_clear_emblems(cast[ptr EmblemedIcon00](self.impl))

proc g_emblemed_icon_get_emblems*(self: ptr EmblemedIcon00): ptr pointer {.
    importc: "g_emblemed_icon_get_emblems", libprag.}

proc getEmblems*(self: EmblemedIcon): ptr pointer =
  g_emblemed_icon_get_emblems(cast[ptr EmblemedIcon00](self.impl))

proc emblems*(self: EmblemedIcon): ptr pointer =
  g_emblemed_icon_get_emblems(cast[ptr EmblemedIcon00](self.impl))

proc g_emblemed_icon_get_icon*(self: ptr EmblemedIcon00): ptr Icon00 {.
    importc: "g_emblemed_icon_get_icon", libprag.}

proc getIcon*(self: EmblemedIcon): Icon =
  new(result)
  result.impl = g_emblemed_icon_get_icon(cast[ptr EmblemedIcon00](self.impl))

proc icon*(self: EmblemedIcon): Icon =
  new(result)
  result.impl = g_emblemed_icon_get_icon(cast[ptr EmblemedIcon00](self.impl))

type
  EmblemedIconClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  EmblemedIconClass* = ref object
    impl*: ptr EmblemedIconClass00

const FILE_ATTRIBUTE_ACCESS_CAN_DELETE* = "access::can-delete"

const FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE* = "access::can-execute"

const FILE_ATTRIBUTE_ACCESS_CAN_READ* = "access::can-read"

const FILE_ATTRIBUTE_ACCESS_CAN_RENAME* = "access::can-rename"

const FILE_ATTRIBUTE_ACCESS_CAN_TRASH* = "access::can-trash"

const FILE_ATTRIBUTE_ACCESS_CAN_WRITE* = "access::can-write"

const FILE_ATTRIBUTE_DOS_IS_ARCHIVE* = "dos::is-archive"

const FILE_ATTRIBUTE_DOS_IS_SYSTEM* = "dos::is-system"

const FILE_ATTRIBUTE_ETAG_VALUE* = "etag::value"

const FILE_ATTRIBUTE_FILESYSTEM_FREE* = "filesystem::free"

const FILE_ATTRIBUTE_FILESYSTEM_READONLY* = "filesystem::readonly"

const FILE_ATTRIBUTE_FILESYSTEM_REMOTE* = "filesystem::remote"

const FILE_ATTRIBUTE_FILESYSTEM_SIZE* = "filesystem::size"

const FILE_ATTRIBUTE_FILESYSTEM_TYPE* = "filesystem::type"

const FILE_ATTRIBUTE_FILESYSTEM_USED* = "filesystem::used"

const FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW* = "filesystem::use-preview"

const FILE_ATTRIBUTE_GVFS_BACKEND* = "gvfs::backend"

const FILE_ATTRIBUTE_ID_FILE* = "id::file"

const FILE_ATTRIBUTE_ID_FILESYSTEM* = "id::filesystem"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT* = "mountable::can-eject"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT* = "mountable::can-mount"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL* = "mountable::can-poll"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_START* = "mountable::can-start"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED* = "mountable::can-start-degraded"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP* = "mountable::can-stop"

const FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT* = "mountable::can-unmount"

const FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI* = "mountable::hal-udi"

const FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC* = "mountable::is-media-check-automatic"

const FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE* = "mountable::start-stop-type"

const FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE* = "mountable::unix-device"

const FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE* = "mountable::unix-device-file"

const FILE_ATTRIBUTE_OWNER_GROUP* = "owner::group"

const FILE_ATTRIBUTE_OWNER_USER* = "owner::user"

const FILE_ATTRIBUTE_OWNER_USER_REAL* = "owner::user-real"

const FILE_ATTRIBUTE_PREVIEW_ICON* = "preview::icon"

const FILE_ATTRIBUTE_SELINUX_CONTEXT* = "selinux::context"

const FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE* = "standard::allocated-size"

const FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE* = "standard::content-type"

const FILE_ATTRIBUTE_STANDARD_COPY_NAME* = "standard::copy-name"

const FILE_ATTRIBUTE_STANDARD_DESCRIPTION* = "standard::description"

const FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME* = "standard::display-name"

const FILE_ATTRIBUTE_STANDARD_EDIT_NAME* = "standard::edit-name"

const FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE* = "standard::fast-content-type"

const FILE_ATTRIBUTE_STANDARD_ICON* = "standard::icon"

const FILE_ATTRIBUTE_STANDARD_IS_BACKUP* = "standard::is-backup"

const FILE_ATTRIBUTE_STANDARD_IS_HIDDEN* = "standard::is-hidden"

const FILE_ATTRIBUTE_STANDARD_IS_SYMLINK* = "standard::is-symlink"

const FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL* = "standard::is-virtual"

const FILE_ATTRIBUTE_STANDARD_IS_VOLATILE* = "standard::is-volatile"

const FILE_ATTRIBUTE_STANDARD_NAME* = "standard::name"

const FILE_ATTRIBUTE_STANDARD_SIZE* = "standard::size"

const FILE_ATTRIBUTE_STANDARD_SORT_ORDER* = "standard::sort-order"

const FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON* = "standard::symbolic-icon"

const FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET* = "standard::symlink-target"

const FILE_ATTRIBUTE_STANDARD_TARGET_URI* = "standard::target-uri"

const FILE_ATTRIBUTE_STANDARD_TYPE* = "standard::type"

const FILE_ATTRIBUTE_THUMBNAILING_FAILED* = "thumbnail::failed"

const FILE_ATTRIBUTE_THUMBNAIL_IS_VALID* = "thumbnail::is-valid"

const FILE_ATTRIBUTE_THUMBNAIL_PATH* = "thumbnail::path"

const FILE_ATTRIBUTE_TIME_ACCESS* = "time::access"

const FILE_ATTRIBUTE_TIME_ACCESS_USEC* = "time::access-usec"

const FILE_ATTRIBUTE_TIME_CHANGED* = "time::changed"

const FILE_ATTRIBUTE_TIME_CHANGED_USEC* = "time::changed-usec"

const FILE_ATTRIBUTE_TIME_CREATED* = "time::created"

const FILE_ATTRIBUTE_TIME_CREATED_USEC* = "time::created-usec"

const FILE_ATTRIBUTE_TIME_MODIFIED* = "time::modified"

const FILE_ATTRIBUTE_TIME_MODIFIED_USEC* = "time::modified-usec"

const FILE_ATTRIBUTE_TRASH_DELETION_DATE* = "trash::deletion-date"

const FILE_ATTRIBUTE_TRASH_ITEM_COUNT* = "trash::item-count"

const FILE_ATTRIBUTE_TRASH_ORIG_PATH* = "trash::orig-path"

const FILE_ATTRIBUTE_UNIX_BLOCKS* = "unix::blocks"

const FILE_ATTRIBUTE_UNIX_BLOCK_SIZE* = "unix::block-size"

const FILE_ATTRIBUTE_UNIX_DEVICE* = "unix::device"

const FILE_ATTRIBUTE_UNIX_GID* = "unix::gid"

const FILE_ATTRIBUTE_UNIX_INODE* = "unix::inode"

const FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT* = "unix::is-mountpoint"

const FILE_ATTRIBUTE_UNIX_MODE* = "unix::mode"

const FILE_ATTRIBUTE_UNIX_NLINK* = "unix::nlink"

const FILE_ATTRIBUTE_UNIX_RDEV* = "unix::rdev"

const FILE_ATTRIBUTE_UNIX_UID* = "unix::uid"

type
  FileDescriptorBased00* {.pure.} = object
  FileDescriptorBased* = ref object
    impl*: ptr FileDescriptorBased00

proc g_file_descriptor_based_get_fd*(self: ptr FileDescriptorBased00): int32 {.
    importc: "g_file_descriptor_based_get_fd", libprag.}

proc getFd*(self: FileDescriptorBased): int =
  int(g_file_descriptor_based_get_fd(cast[ptr FileDescriptorBased00](self.impl)))

proc fd*(self: FileDescriptorBased): int =
  int(g_file_descriptor_based_get_fd(cast[ptr FileDescriptorBased00](self.impl)))

type
  FileDescriptorBasedIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    getFd*: proc(fdBased: ptr FileDescriptorBased00): int32 {.cdecl.}
  FileDescriptorBasedIface* = ref object
    impl*: ptr FileDescriptorBasedIface00

type
  FileEnumeratorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    nextFile*: proc(enumerator: ptr FileEnumerator00; cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    closeFn*: proc(enumerator: ptr FileEnumerator00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    nextFilesAsync*: proc(enumerator: ptr FileEnumerator00; numFiles: int32; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    nextFilesFinish*: proc(enumerator: ptr FileEnumerator00; resu: ptr AsyncResult00): ptr pointer {.cdecl.}
    closeAsync*: proc(enumerator: ptr FileEnumerator00; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    closeFinish*: proc(enumerator: ptr FileEnumerator00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
  FileEnumeratorClass* = ref object
    impl*: ptr FileEnumeratorClass00

type
  IOStreamClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getInputStream*: proc(stream: ptr IOStream00): ptr InputStream00 {.cdecl.}
    getOutputStream*: proc(stream: ptr IOStream00): ptr OutputStream00 {.cdecl.}
    closeFn*: proc(stream: ptr IOStream00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    closeAsync*: proc(stream: ptr IOStream00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    closeFinish*: proc(stream: ptr IOStream00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
    gReserved8*: pointer
    gReserved9*: pointer
    gReserved10*: pointer
  IOStreamClass* = ref object
    impl*: ptr IOStreamClass00

type
  FileIOStreamClass00* {.pure.} = object
    parentClass*: IOStreamClass00
    tell*: proc(stream: ptr FileIOStream00): int64 {.cdecl.}
    canSeek*: proc(stream: ptr FileIOStream00): gboolean {.cdecl.}
    seek*: proc(stream: ptr FileIOStream00; offset: int64; `type`: glib.SeekType; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    canTruncate*: proc(stream: ptr FileIOStream00): gboolean {.cdecl.}
    truncateFn*: proc(stream: ptr FileIOStream00; size: int64; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    queryInfo*: proc(stream: ptr FileIOStream00; attributes: cstring; cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    queryInfoAsync*: proc(stream: ptr FileIOStream00; attributes: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    queryInfoFinish*: proc(stream: ptr FileIOStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.cdecl.}
    getEtag*: proc(stream: ptr FileIOStream00): cstring {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  FileIOStreamClass* = ref object
    impl*: ptr FileIOStreamClass00

type
  FileIcon* = ref object of gobject.Object
  FileIcon00* = object of gobject.Object00

proc g_file_icon_new*(file: ptr File00): ptr FileIcon00 {.
    importc: "g_file_icon_new", libprag.}

proc newFileIcon*(file: File): FileIcon =
  new(result, finalizeGObject)
  result.impl = g_file_icon_new(cast[ptr File00](file.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFileIcon*[T](result: var T; file: File) =
  assert(result is FileIcon)
  new(result, finalizeGObject)
  result.impl = g_file_icon_new(cast[ptr File00](file.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_file_icon_get_file*(self: ptr FileIcon00): ptr File00 {.
    importc: "g_file_icon_get_file", libprag.}

proc getFile*(self: FileIcon): File =
  new(result)
  result.impl = g_file_icon_get_file(cast[ptr FileIcon00](self.impl))

proc file*(self: FileIcon): File =
  new(result)
  result.impl = g_file_icon_get_file(cast[ptr FileIcon00](self.impl))

type
  FileIconClass00* {.pure.} = object
  FileIconClass* = ref object
    impl*: ptr FileIconClass00

type
  FileInfoClass00* {.pure.} = object
  FileInfoClass* = ref object
    impl*: ptr FileInfoClass00

type
  FileInputStreamClass00* {.pure.} = object
    parentClass*: InputStreamClass00
    tell*: proc(stream: ptr FileInputStream00): int64 {.cdecl.}
    canSeek*: proc(stream: ptr FileInputStream00): gboolean {.cdecl.}
    seek*: proc(stream: ptr FileInputStream00; offset: int64; `type`: glib.SeekType; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    queryInfo*: proc(stream: ptr FileInputStream00; attributes: cstring; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    queryInfoAsync*: proc(stream: ptr FileInputStream00; attributes: cstring; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    queryInfoFinish*: proc(stream: ptr FileInputStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  FileInputStreamClass* = ref object
    impl*: ptr FileInputStreamClass00

type
  FileMeasureFlag* {.size: sizeof(cint), pure.} = enum
    reportAnyError = 2
    apparentSize = 3
    noXdev = 4

  FileMeasureFlags* {.size: sizeof(cint).} = set[FileMeasureFlag]

type
  FileMeasureProgressCallback* = proc (reporting: gboolean; currentSize: uint64; numDirs: uint64; 
    numFiles: uint64; userData: pointer) {.cdecl.}

type
  FileMonitorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    changed*: proc(monitor: ptr FileMonitor00; file: ptr File00; otherFile: ptr File00; 
    eventType: FileMonitorEvent) {.cdecl.}
    cancel*: proc(monitor: ptr FileMonitor00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  FileMonitorClass* = ref object
    impl*: ptr FileMonitorClass00

type
  FileOutputStreamClass00* {.pure.} = object
    parentClass*: OutputStreamClass00
    tell*: proc(stream: ptr FileOutputStream00): int64 {.cdecl.}
    canSeek*: proc(stream: ptr FileOutputStream00): gboolean {.cdecl.}
    seek*: proc(stream: ptr FileOutputStream00; offset: int64; `type`: glib.SeekType; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    canTruncate*: proc(stream: ptr FileOutputStream00): gboolean {.cdecl.}
    truncateFn*: proc(stream: ptr FileOutputStream00; size: int64; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    queryInfo*: proc(stream: ptr FileOutputStream00; attributes: cstring; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    queryInfoAsync*: proc(stream: ptr FileOutputStream00; attributes: cstring; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    queryInfoFinish*: proc(stream: ptr FileOutputStream00; resu: ptr AsyncResult00): ptr FileInfo00 {.cdecl.}
    getEtag*: proc(stream: ptr FileOutputStream00): cstring {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  FileOutputStreamClass* = ref object
    impl*: ptr FileOutputStreamClass00

type
  FileProgressCallback* = proc (currentNumBytes: int64; totalNumBytes: int64; userData: pointer) {.cdecl.}

type
  FileIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    dup*: proc(file: ptr File00): ptr File00 {.cdecl.}
    hash*: proc(file: ptr File00): uint32 {.cdecl.}
    equal*: proc(file1: ptr File00; file2: ptr File00): gboolean {.cdecl.}
    isNative*: proc(file: ptr File00): gboolean {.cdecl.}
    hasUriScheme*: proc(file: ptr File00; uriScheme: cstring): gboolean {.cdecl.}
    getUriScheme*: proc(file: ptr File00): cstring {.cdecl.}
    getBasename*: proc(file: ptr File00): cstring {.cdecl.}
    getPath*: proc(file: ptr File00): cstring {.cdecl.}
    getUri*: proc(file: ptr File00): cstring {.cdecl.}
    getParseName*: proc(file: ptr File00): cstring {.cdecl.}
    getParent*: proc(file: ptr File00): ptr File00 {.cdecl.}
    prefixMatches*: proc(prefix: ptr File00; file: ptr File00): gboolean {.cdecl.}
    getRelativePath*: proc(parent: ptr File00; descendant: ptr File00): cstring {.cdecl.}
    resolveRelativePath*: proc(file: ptr File00; relativePath: ucstring): ptr File00 {.cdecl.}
    getChildForDisplayName*: proc(file: ptr File00; displayName: cstring): ptr File00 {.cdecl.}
    enumerateChildren*: proc(file: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): ptr FileEnumerator00 {.cdecl.}
    enumerateChildrenAsync*: proc(file: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    enumerateChildrenFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileEnumerator00 {.cdecl.}
    queryInfo*: proc(file: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    queryInfoAsync*: proc(file: ptr File00; attributes: cstring; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    queryInfoFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileInfo00 {.cdecl.}
    queryFilesystemInfo*: proc(file: ptr File00; attributes: cstring; cancellable: ptr Cancellable00): ptr FileInfo00 {.cdecl.}
    queryFilesystemInfoAsync*: proc(file: ptr File00; attributes: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    queryFilesystemInfoFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileInfo00 {.cdecl.}
    findEnclosingMount*: proc(file: ptr File00; cancellable: ptr Cancellable00): ptr Mount00 {.cdecl.}
    findEnclosingMountAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    findEnclosingMountFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr Mount00 {.cdecl.}
    setDisplayName*: proc(file: ptr File00; displayName: cstring; cancellable: ptr Cancellable00): ptr File00 {.cdecl.}
    setDisplayNameAsync*: proc(file: ptr File00; displayName: cstring; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    setDisplayNameFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr File00 {.cdecl.}
    querySettableAttributes*: proc(file: ptr File00; cancellable: ptr Cancellable00): ptr FileAttributeInfoList00 {.cdecl.}
    querySettableAttributesAsync*: pointer
    querySettableAttributesFinish*: pointer
    queryWritableNamespaces*: proc(file: ptr File00; cancellable: ptr Cancellable00): ptr FileAttributeInfoList00 {.cdecl.}
    queryWritableNamespacesAsync*: pointer
    queryWritableNamespacesFinish*: pointer
    setAttribute*: proc(file: ptr File00; attribute: cstring; `type`: FileAttributeType; 
    valueP: pointer; flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    setAttributesFromInfo*: proc(file: ptr File00; info: ptr FileInfo00; flags: FileQueryInfoFlags; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    setAttributesAsync*: proc(file: ptr File00; info: ptr FileInfo00; flags: FileQueryInfoFlags; 
    ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    setAttributesFinish*: proc(file: ptr File00; resu: ptr AsyncResult00; info: var ptr FileInfo00): gboolean {.cdecl.}
    readFn*: proc(file: ptr File00; cancellable: ptr Cancellable00): ptr FileInputStream00 {.cdecl.}
    readAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    readFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileInputStream00 {.cdecl.}
    appendTo*: proc(file: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.cdecl.}
    appendToAsync*: proc(file: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    appendToFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.cdecl.}
    create*: proc(file: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.cdecl.}
    createAsync*: proc(file: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    createFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.cdecl.}
    replace*: proc(file: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileOutputStream00 {.cdecl.}
    replaceAsync*: proc(file: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    replaceFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileOutputStream00 {.cdecl.}
    deleteFile*: proc(file: ptr File00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    deleteFileAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    deleteFileFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    trash*: proc(file: ptr File00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    trashAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    trashFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    makeDirectory*: proc(file: ptr File00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    makeDirectoryAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    makeDirectoryFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    makeSymbolicLink*: proc(file: ptr File00; symlinkValue: ucstring; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    makeSymbolicLinkAsync*: pointer
    makeSymbolicLinkFinish*: pointer
    copy*: proc(source: ptr File00; destination: ptr File00; flags: FileCopyFlags; 
    cancellable: ptr Cancellable00; progressCallback: FileProgressCallback; progressCallbackData: pointer): gboolean {.cdecl.}
    copyAsync*: pointer
    copyFinish*: proc(file: ptr File00; res: ptr AsyncResult00): gboolean {.cdecl.}
    move*: proc(source: ptr File00; destination: ptr File00; flags: FileCopyFlags; 
    cancellable: ptr Cancellable00; progressCallback: FileProgressCallback; progressCallbackData: pointer): gboolean {.cdecl.}
    moveAsync*: pointer
    moveFinish*: pointer
    mountMountable*: proc(file: ptr File00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    mountMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): ptr File00 {.cdecl.}
    unmountMountable*: proc(file: ptr File00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    unmountMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    ejectMountable*: proc(file: ptr File00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    ejectMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    mountEnclosingVolume*: proc(location: ptr File00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    mountEnclosingVolumeFinish*: proc(location: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    monitorDir*: proc(file: ptr File00; flags: FileMonitorFlags; cancellable: ptr Cancellable00): ptr FileMonitor00 {.cdecl.}
    monitorFile*: proc(file: ptr File00; flags: FileMonitorFlags; cancellable: ptr Cancellable00): ptr FileMonitor00 {.cdecl.}
    openReadwrite*: proc(file: ptr File00; cancellable: ptr Cancellable00): ptr FileIOStream00 {.cdecl.}
    openReadwriteAsync*: proc(file: ptr File00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    openReadwriteFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.cdecl.}
    createReadwrite*: proc(file: ptr File00; flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileIOStream00 {.cdecl.}
    createReadwriteAsync*: proc(file: ptr File00; flags: FileCreateFlags; ioPriority: int32; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    createReadwriteFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.cdecl.}
    replaceReadwrite*: proc(file: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; cancellable: ptr Cancellable00): ptr FileIOStream00 {.cdecl.}
    replaceReadwriteAsync*: proc(file: ptr File00; etag: cstring; makeBackup: gboolean; 
    flags: FileCreateFlags; ioPriority: int32; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    replaceReadwriteFinish*: proc(file: ptr File00; res: ptr AsyncResult00): ptr FileIOStream00 {.cdecl.}
    startMountable*: proc(file: ptr File00; flags: DriveStartFlags; startOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    startMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    stopMountable*: proc(file: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    stopMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    supportsThreadContexts*: gboolean
    unmountMountableWithOperation*: proc(file: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    unmountMountableWithOperationFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    ejectMountableWithOperation*: proc(file: ptr File00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    ejectMountableWithOperationFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    pollMountable*: proc(file: ptr File00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    pollMountableFinish*: proc(file: ptr File00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    measureDiskUsage*: pointer
    measureDiskUsageAsync*: pointer
    measureDiskUsageFinish*: proc(file: ptr File00; resu: ptr AsyncResult00; diskUsage: var uint64; 
    numDirs: var uint64; numFiles: var uint64): gboolean {.cdecl.}
  FileIface* = ref object
    impl*: ptr FileIface00

proc g_file_copy*(self: ptr File00; destination: ptr File00; flags: FileCopyFlags; 
    cancellable: ptr Cancellable00; progressCallback: FileProgressCallback; progressCallbackData: pointer): gboolean {.
    importc: "g_file_copy", libprag.}

proc copy*(self: File; destination: File; flags: FileCopyFlags; 
    cancellable: Cancellable; progressCallback: FileProgressCallback; progressCallbackData: pointer): bool =
  toBool(g_file_copy(cast[ptr File00](self.impl), cast[ptr File00](destination.impl), flags, cast[ptr Cancellable00](cancellable.impl), progressCallback, progressCallbackData))

proc g_file_move*(self: ptr File00; destination: ptr File00; flags: FileCopyFlags; 
    cancellable: ptr Cancellable00; progressCallback: FileProgressCallback; progressCallbackData: pointer): gboolean {.
    importc: "g_file_move", libprag.}

proc move*(self: File; destination: File; flags: FileCopyFlags; 
    cancellable: Cancellable; progressCallback: FileProgressCallback; progressCallbackData: pointer): bool =
  toBool(g_file_move(cast[ptr File00](self.impl), cast[ptr File00](destination.impl), flags, cast[ptr Cancellable00](cancellable.impl), progressCallback, progressCallbackData))

type
  FileReadMoreCallback* = proc (fileContents: cstring; fileSize: int64; callbackData: pointer): gboolean {.cdecl.}

type
  FilenameCompleter* = ref object of gobject.Object
  FilenameCompleter00* = object of gobject.Object00

proc scGotCompletionData*(self: FilenameCompleter;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "got-completion-data", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_filename_completer_new*(): ptr FilenameCompleter00 {.
    importc: "g_filename_completer_new", libprag.}

proc newFilenameCompleter*(): FilenameCompleter =
  new(result, finalizeGObject)
  result.impl = g_filename_completer_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initFilenameCompleter*[T](result: var T) =
  assert(result is FilenameCompleter)
  new(result, finalizeGObject)
  result.impl = g_filename_completer_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_filename_completer_get_completion_suffix*(self: ptr FilenameCompleter00; initialText: cstring): cstring {.
    importc: "g_filename_completer_get_completion_suffix", libprag.}

proc getCompletionSuffix*(self: FilenameCompleter; initialText: string): string =
  let resul0 = g_filename_completer_get_completion_suffix(cast[ptr FilenameCompleter00](self.impl), cstring(initialText))
  result = $resul0
  cogfree(resul0)

proc completionSuffix*(self: FilenameCompleter; initialText: string): string =
  let resul0 = g_filename_completer_get_completion_suffix(cast[ptr FilenameCompleter00](self.impl), cstring(initialText))
  result = $resul0
  cogfree(resul0)

proc g_filename_completer_get_completions*(self: ptr FilenameCompleter00; initialText: cstring): cstringArray {.
    importc: "g_filename_completer_get_completions", libprag.}

proc getCompletions*(self: FilenameCompleter; initialText: string): cstringArray =
  g_filename_completer_get_completions(cast[ptr FilenameCompleter00](self.impl), cstring(initialText))

proc completions*(self: FilenameCompleter; initialText: string): cstringArray =
  g_filename_completer_get_completions(cast[ptr FilenameCompleter00](self.impl), cstring(initialText))

proc g_filename_completer_set_dirs_only*(self: ptr FilenameCompleter00; dirsOnly: gboolean) {.
    importc: "g_filename_completer_set_dirs_only", libprag.}

proc setDirsOnly*(self: FilenameCompleter; dirsOnly: bool) =
  g_filename_completer_set_dirs_only(cast[ptr FilenameCompleter00](self.impl), gboolean(dirsOnly))

proc `dirsOnly=`*(self: FilenameCompleter; dirsOnly: bool) =
  g_filename_completer_set_dirs_only(cast[ptr FilenameCompleter00](self.impl), gboolean(dirsOnly))

type
  FilenameCompleterClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    gotCompletionData*: proc(filenameCompleter: ptr FilenameCompleter00) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
  FilenameCompleterClass* = ref object
    impl*: ptr FilenameCompleterClass00

type
  FilesystemPreviewType* {.size: sizeof(cint), pure.} = enum
    ifAlways = 0
    ifLocal = 1
    never = 2

type
  IOErrorEnum* {.size: sizeof(cint), pure.} = enum
    failed = 0
    notFound = 1
    exists = 2
    isDirectory = 3
    notDirectory = 4
    notEmpty = 5
    notRegularFile = 6
    notSymbolicLink = 7
    notMountableFile = 8
    filenameTooLong = 9
    invalidFilename = 10
    tooManyLinks = 11
    noSpace = 12
    invalidArgument = 13
    permissionDenied = 14
    notSupported = 15
    notMounted = 16
    alreadyMounted = 17
    closed = 18
    cancelled = 19
    pending = 20
    readOnly = 21
    cantCreateBackup = 22
    wrongEtag = 23
    timedOut = 24
    wouldRecurse = 25
    busy = 26
    wouldBlock = 27
    hostNotFound = 28
    wouldMerge = 29
    failedHandled = 30
    tooManyOpenFiles = 31
    notInitialized = 32
    addressInUse = 33
    partialInput = 34
    invalidData = 35
    dbusError = 36
    hostUnreachable = 37
    networkUnreachable = 38
    connectionRefused = 39
    proxyFailed = 40
    proxyAuthFailed = 41
    proxyNeedAuth = 42
    proxyNotAllowed = 43
    brokenPipe = 44
    notConnected = 45
    messageTooLarge = 46

const
  IOErrorEnumConnectionClosed* = IOErrorEnum.brokenPipe

type
  IOExtension00* {.pure.} = object
  IOExtension* = ref object
    impl*: ptr IOExtension00

proc g_io_extension_get_name*(self: ptr IOExtension00): cstring {.
    importc: "g_io_extension_get_name", libprag.}

proc getName*(self: IOExtension): string =
  let resul0 = g_io_extension_get_name(cast[ptr IOExtension00](self.impl))
  result = $resul0

proc name*(self: IOExtension): string =
  let resul0 = g_io_extension_get_name(cast[ptr IOExtension00](self.impl))
  result = $resul0

proc g_io_extension_get_priority*(self: ptr IOExtension00): int32 {.
    importc: "g_io_extension_get_priority", libprag.}

proc getPriority*(self: IOExtension): int =
  int(g_io_extension_get_priority(cast[ptr IOExtension00](self.impl)))

proc priority*(self: IOExtension): int =
  int(g_io_extension_get_priority(cast[ptr IOExtension00](self.impl)))

proc g_io_extension_get_type*(self: ptr IOExtension00): GType {.
    importc: "g_io_extension_get_type", libprag.}

proc getType*(self: IOExtension): GType =
  g_io_extension_get_type(cast[ptr IOExtension00](self.impl))

type
  IOExtensionPoint00* {.pure.} = object
  IOExtensionPoint* = ref object
    impl*: ptr IOExtensionPoint00

proc g_io_extension_point_get_extension_by_name*(self: ptr IOExtensionPoint00; name: cstring): ptr IOExtension00 {.
    importc: "g_io_extension_point_get_extension_by_name", libprag.}

proc getExtensionByName*(self: IOExtensionPoint; name: string): IOExtension =
  new(result)
  result.impl = g_io_extension_point_get_extension_by_name(cast[ptr IOExtensionPoint00](self.impl), cstring(name))

proc extensionByName*(self: IOExtensionPoint; name: string): IOExtension =
  new(result)
  result.impl = g_io_extension_point_get_extension_by_name(cast[ptr IOExtensionPoint00](self.impl), cstring(name))

proc g_io_extension_point_get_extensions*(self: ptr IOExtensionPoint00): ptr pointer {.
    importc: "g_io_extension_point_get_extensions", libprag.}

proc getExtensions*(self: IOExtensionPoint): ptr pointer =
  g_io_extension_point_get_extensions(cast[ptr IOExtensionPoint00](self.impl))

proc extensions*(self: IOExtensionPoint): ptr pointer =
  g_io_extension_point_get_extensions(cast[ptr IOExtensionPoint00](self.impl))

proc g_io_extension_point_get_required_type*(self: ptr IOExtensionPoint00): GType {.
    importc: "g_io_extension_point_get_required_type", libprag.}

proc getRequiredType*(self: IOExtensionPoint): GType =
  g_io_extension_point_get_required_type(cast[ptr IOExtensionPoint00](self.impl))

proc requiredType*(self: IOExtensionPoint): GType =
  g_io_extension_point_get_required_type(cast[ptr IOExtensionPoint00](self.impl))

proc g_io_extension_point_set_required_type*(self: ptr IOExtensionPoint00; `type`: GType) {.
    importc: "g_io_extension_point_set_required_type", libprag.}

proc setRequiredType*(self: IOExtensionPoint; `type`: GType) =
  g_io_extension_point_set_required_type(cast[ptr IOExtensionPoint00](self.impl), `type`)

proc `requiredType=`*(self: IOExtensionPoint; `type`: GType) =
  g_io_extension_point_set_required_type(cast[ptr IOExtensionPoint00](self.impl), `type`)

proc g_io_extension_point_implement*(extensionPointName: cstring; `type`: GType; extensionName: cstring; 
    priority: int32): ptr IOExtension00 {.
    importc: "g_io_extension_point_implement", libprag.}

proc implement*(extensionPointName: string; `type`: GType; extensionName: string; 
    priority: int): IOExtension =
  new(result)
  result.impl = g_io_extension_point_implement(cstring(extensionPointName), `type`, cstring(extensionName), int32(priority))

proc g_io_extension_point_lookup*(name: cstring): ptr IOExtensionPoint00 {.
    importc: "g_io_extension_point_lookup", libprag.}

proc lookup*(name: string): IOExtensionPoint =
  new(result)
  result.impl = g_io_extension_point_lookup(cstring(name))

proc g_io_extension_point_register*(name: cstring): ptr IOExtensionPoint00 {.
    importc: "g_io_extension_point_register", libprag.}

proc register*(name: string): IOExtensionPoint =
  new(result)
  result.impl = g_io_extension_point_register(cstring(name))

type
  IOModule* = ref object of gobject.TypeModule
  IOModule00* = object of gobject.TypeModule00

proc g_io_module_new*(filename: ucstring): ptr IOModule00 {.
    importc: "g_io_module_new", libprag.}

proc newIOModule*(filename: ucstring): IOModule =
  new(result, finalizeGObject)
  result.impl = g_io_module_new(filename)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initIOModule*[T](result: var T; filename: ucstring) =
  assert(result is IOModule)
  new(result, finalizeGObject)
  result.impl = g_io_module_new(filename)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_io_module_query*(): cstringArray {.
    importc: "g_io_module_query", libprag.}

proc query*(): cstringArray {.
    importc: "g_io_module_query", libprag.}

proc g_io_module_load*(self: ptr IOModule00) {.
    importc: "g_io_module_load", libprag.}

proc load*(self: IOModule) =
  g_io_module_load(cast[ptr IOModule00](self.impl))

proc g_io_module_unload*(self: ptr IOModule00) {.
    importc: "g_io_module_unload", libprag.}

proc unload*(self: IOModule) =
  g_io_module_unload(cast[ptr IOModule00](self.impl))

type
  IOModuleClass00* {.pure.} = object
  IOModuleClass* = ref object
    impl*: ptr IOModuleClass00

type
  IOModuleScope00* {.pure.} = object
  IOModuleScope* = ref object
    impl*: ptr IOModuleScope00

proc g_io_module_scope_block*(self: ptr IOModuleScope00; basename: cstring) {.
    importc: "g_io_module_scope_block", libprag.}

proc `block`*(self: IOModuleScope; basename: string) =
  g_io_module_scope_block(cast[ptr IOModuleScope00](self.impl), cstring(basename))

proc g_io_module_scope_free*(self: ptr IOModuleScope00) {.
    importc: "g_io_module_scope_free", libprag.}

proc free*(self: IOModuleScope) =
  g_io_module_scope_free(cast[ptr IOModuleScope00](self.impl))

type
  IOModuleScopeFlag* {.size: sizeof(cint), pure.} = enum
    blockDuplicates = 1

  IOModuleScopeFlags* {.size: sizeof(cint).} = set[IOModuleScopeFlag]

type
  IOSchedulerJob00* {.pure.} = object
  IOSchedulerJob* = ref object
    impl*: ptr IOSchedulerJob00

proc g_io_scheduler_job_send_to_mainloop*(self: ptr IOSchedulerJob00; `func`: SourceFunc; userData: pointer; 
    notify: DestroyNotify): gboolean {.
    importc: "g_io_scheduler_job_send_to_mainloop", libprag.}

proc sendToMainloop*(self: IOSchedulerJob; `func`: SourceFunc; userData: pointer; 
    notify: DestroyNotify): bool =
  toBool(g_io_scheduler_job_send_to_mainloop(cast[ptr IOSchedulerJob00](self.impl), `func`, userData, notify))

proc g_io_scheduler_job_send_to_mainloop_async*(self: ptr IOSchedulerJob00; `func`: SourceFunc; userData: pointer; 
    notify: DestroyNotify) {.
    importc: "g_io_scheduler_job_send_to_mainloop_async", libprag.}

proc sendToMainloopAsync*(self: IOSchedulerJob; `func`: SourceFunc; userData: pointer; 
    notify: DestroyNotify) =
  g_io_scheduler_job_send_to_mainloop_async(cast[ptr IOSchedulerJob00](self.impl), `func`, userData, notify)

type
  IOSchedulerJobFunc* = proc (job: ptr IOSchedulerJob00; cancellable: ptr Cancellable00; 
    userData: pointer): gboolean {.cdecl.}

type
  IOStreamAdapter00* {.pure.} = object
  IOStreamAdapter* = ref object
    impl*: ptr IOStreamAdapter00

type
  IconIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    hash*: proc(icon: ptr Icon00): uint32 {.cdecl.}
    equal*: proc(icon1: ptr Icon00; icon2: ptr Icon00): gboolean {.cdecl.}
    toTokens*: pointer
    fromTokens*: pointer
    serialize*: proc(icon: ptr Icon00): ptr glib.Variant00 {.cdecl.}
  IconIface* = ref object
    impl*: ptr IconIface00

type
  InetAddressPrivate00* {.pure.} = object
  InetAddressPrivate* = ref object
    impl*: ptr InetAddressPrivate00

type
  InetAddress* = ref object of gobject.Object
  InetAddress00* = object of gobject.Object00
    priv1: ptr InetAddressPrivate00

proc g_inet_address_new_any*(family: SocketFamily): ptr InetAddress00 {.
    importc: "g_inet_address_new_any", libprag.}

proc newInetAddressAny*(family: SocketFamily): InetAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_any(family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressAny*[T](result: var T; family: SocketFamily) =
  assert(result is InetAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_any(family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_new_from_bytes*(bytes: uint8Array; family: SocketFamily): ptr InetAddress00 {.
    importc: "g_inet_address_new_from_bytes", libprag.}

proc newInetAddressFromBytes*(bytes: uint8Array; family: SocketFamily): InetAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_from_bytes(bytes, family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressFromBytes*[T](result: var T; bytes: uint8Array; family: SocketFamily) =
  assert(result is InetAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_from_bytes(bytes, family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_new_from_string*(string: cstring): ptr InetAddress00 {.
    importc: "g_inet_address_new_from_string", libprag.}

proc newInetAddressFromString*(string: string): InetAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_from_string(cstring(string))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressFromString*[T](result: var T; string: string) =
  assert(result is InetAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_from_string(cstring(string))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_new_loopback*(family: SocketFamily): ptr InetAddress00 {.
    importc: "g_inet_address_new_loopback", libprag.}

proc newInetAddressLoopback*(family: SocketFamily): InetAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_loopback(family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressLoopback*[T](result: var T; family: SocketFamily) =
  assert(result is InetAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_address_new_loopback(family)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_equal*(self: ptr InetAddress00; otherAddress: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_equal", libprag.}

proc equal*(self: InetAddress; otherAddress: InetAddress): bool =
  toBool(g_inet_address_equal(cast[ptr InetAddress00](self.impl), cast[ptr InetAddress00](otherAddress.impl)))

proc g_inet_address_get_family*(self: ptr InetAddress00): SocketFamily {.
    importc: "g_inet_address_get_family", libprag.}

proc getFamily*(self: InetAddress): SocketFamily =
  g_inet_address_get_family(cast[ptr InetAddress00](self.impl))

proc family*(self: InetAddress): SocketFamily =
  g_inet_address_get_family(cast[ptr InetAddress00](self.impl))

proc g_inet_address_get_is_any*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_any", libprag.}

proc getIsAny*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_any(cast[ptr InetAddress00](self.impl)))

proc isAny*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_any(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_link_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_link_local", libprag.}

proc getIsLinkLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_link_local(cast[ptr InetAddress00](self.impl)))

proc isLinkLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_link_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_loopback*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_loopback", libprag.}

proc getIsLoopback*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_loopback(cast[ptr InetAddress00](self.impl)))

proc isLoopback*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_loopback(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_mc_global*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_mc_global", libprag.}

proc getIsMcGlobal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_global(cast[ptr InetAddress00](self.impl)))

proc isMcGlobal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_global(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_mc_link_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_mc_link_local", libprag.}

proc getIsMcLinkLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_link_local(cast[ptr InetAddress00](self.impl)))

proc isMcLinkLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_link_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_mc_node_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_mc_node_local", libprag.}

proc getIsMcNodeLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_node_local(cast[ptr InetAddress00](self.impl)))

proc isMcNodeLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_node_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_mc_org_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_mc_org_local", libprag.}

proc getIsMcOrgLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_org_local(cast[ptr InetAddress00](self.impl)))

proc isMcOrgLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_org_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_mc_site_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_mc_site_local", libprag.}

proc getIsMcSiteLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_site_local(cast[ptr InetAddress00](self.impl)))

proc isMcSiteLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_mc_site_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_multicast*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_multicast", libprag.}

proc getIsMulticast*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_multicast(cast[ptr InetAddress00](self.impl)))

proc isMulticast*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_multicast(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_is_site_local*(self: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_get_is_site_local", libprag.}

proc getIsSiteLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_site_local(cast[ptr InetAddress00](self.impl)))

proc isSiteLocal*(self: InetAddress): bool =
  toBool(g_inet_address_get_is_site_local(cast[ptr InetAddress00](self.impl)))

proc g_inet_address_get_native_size*(self: ptr InetAddress00): uint64 {.
    importc: "g_inet_address_get_native_size", libprag.}

proc getNativeSize*(self: InetAddress): uint64 =
  g_inet_address_get_native_size(cast[ptr InetAddress00](self.impl))

proc nativeSize*(self: InetAddress): uint64 =
  g_inet_address_get_native_size(cast[ptr InetAddress00](self.impl))

proc g_inet_address_to_string*(self: ptr InetAddress00): cstring {.
    importc: "g_inet_address_to_string", libprag.}

proc toString*(self: InetAddress): string =
  let resul0 = g_inet_address_to_string(cast[ptr InetAddress00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  InetAddressClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    toString*: proc(address: ptr InetAddress00): cstring {.cdecl.}
    toBytes*: proc(address: ptr InetAddress00): ptr uint8 {.cdecl.}
  InetAddressClass* = ref object
    impl*: ptr InetAddressClass00

type
  InetAddressMaskPrivate00* {.pure.} = object
  InetAddressMaskPrivate* = ref object
    impl*: ptr InetAddressMaskPrivate00

type
  InetAddressMask* = ref object of gobject.Object
  InetAddressMask00* = object of gobject.Object00
    priv1: ptr InetAddressMaskPrivate00

proc g_inet_address_mask_new*(`addr`: ptr InetAddress00; length: uint32): ptr InetAddressMask00 {.
    importc: "g_inet_address_mask_new", libprag.}

proc newInetAddressMask*(`addr`: InetAddress; length: int): InetAddressMask =
  new(result, finalizeGObject)
  result.impl = g_inet_address_mask_new(cast[ptr InetAddress00](`addr`.impl), uint32(length))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressMask*[T](result: var T; `addr`: InetAddress; length: int) =
  assert(result is InetAddressMask)
  new(result, finalizeGObject)
  result.impl = g_inet_address_mask_new(cast[ptr InetAddress00](`addr`.impl), uint32(length))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_mask_new_from_string*(maskString: cstring): ptr InetAddressMask00 {.
    importc: "g_inet_address_mask_new_from_string", libprag.}

proc newInetAddressMaskFromString*(maskString: string): InetAddressMask =
  new(result, finalizeGObject)
  result.impl = g_inet_address_mask_new_from_string(cstring(maskString))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetAddressMaskFromString*[T](result: var T; maskString: string) =
  assert(result is InetAddressMask)
  new(result, finalizeGObject)
  result.impl = g_inet_address_mask_new_from_string(cstring(maskString))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_address_mask_equal*(self: ptr InetAddressMask00; mask2: ptr InetAddressMask00): gboolean {.
    importc: "g_inet_address_mask_equal", libprag.}

proc equal*(self: InetAddressMask; mask2: InetAddressMask): bool =
  toBool(g_inet_address_mask_equal(cast[ptr InetAddressMask00](self.impl), cast[ptr InetAddressMask00](mask2.impl)))

proc g_inet_address_mask_get_address*(self: ptr InetAddressMask00): ptr InetAddress00 {.
    importc: "g_inet_address_mask_get_address", libprag.}

proc getAddress*(self: InetAddressMask): InetAddress =
  let gobj = g_inet_address_mask_get_address(cast[ptr InetAddressMask00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InetAddress](g_object_get_qdata(gobj, Quark))
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

proc address*(self: InetAddressMask): InetAddress =
  let gobj = g_inet_address_mask_get_address(cast[ptr InetAddressMask00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InetAddress](g_object_get_qdata(gobj, Quark))
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

proc g_inet_address_mask_get_family*(self: ptr InetAddressMask00): SocketFamily {.
    importc: "g_inet_address_mask_get_family", libprag.}

proc getFamily*(self: InetAddressMask): SocketFamily =
  g_inet_address_mask_get_family(cast[ptr InetAddressMask00](self.impl))

proc family*(self: InetAddressMask): SocketFamily =
  g_inet_address_mask_get_family(cast[ptr InetAddressMask00](self.impl))

proc g_inet_address_mask_get_length*(self: ptr InetAddressMask00): uint32 {.
    importc: "g_inet_address_mask_get_length", libprag.}

proc getLength*(self: InetAddressMask): int =
  int(g_inet_address_mask_get_length(cast[ptr InetAddressMask00](self.impl)))

proc length*(self: InetAddressMask): int =
  int(g_inet_address_mask_get_length(cast[ptr InetAddressMask00](self.impl)))

proc g_inet_address_mask_matches*(self: ptr InetAddressMask00; address: ptr InetAddress00): gboolean {.
    importc: "g_inet_address_mask_matches", libprag.}

proc matches*(self: InetAddressMask; address: InetAddress): bool =
  toBool(g_inet_address_mask_matches(cast[ptr InetAddressMask00](self.impl), cast[ptr InetAddress00](address.impl)))

proc g_inet_address_mask_to_string*(self: ptr InetAddressMask00): cstring {.
    importc: "g_inet_address_mask_to_string", libprag.}

proc toString*(self: InetAddressMask): string =
  let resul0 = g_inet_address_mask_to_string(cast[ptr InetAddressMask00](self.impl))
  result = $resul0
  cogfree(resul0)

type
  InetAddressMaskClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  InetAddressMaskClass* = ref object
    impl*: ptr InetAddressMaskClass00

type
  InetSocketAddressPrivate00* {.pure.} = object
  InetSocketAddressPrivate* = ref object
    impl*: ptr InetSocketAddressPrivate00

type
  InetSocketAddress* = ref object of SocketAddress
  InetSocketAddress00* = object of SocketAddress00
    priv2: ptr InetSocketAddressPrivate00

proc g_inet_socket_address_new*(address: ptr InetAddress00; port: uint16): ptr InetSocketAddress00 {.
    importc: "g_inet_socket_address_new", libprag.}

proc newInetSocketAddress*(address: InetAddress; port: uint16): InetSocketAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_socket_address_new(cast[ptr InetAddress00](address.impl), port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetSocketAddress*[T](result: var T; address: InetAddress; port: uint16) =
  assert(result is InetSocketAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_socket_address_new(cast[ptr InetAddress00](address.impl), port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_socket_address_new_from_string*(address: cstring; port: uint32): ptr InetSocketAddress00 {.
    importc: "g_inet_socket_address_new_from_string", libprag.}

proc newInetSocketAddressFromString*(address: string; port: int): InetSocketAddress =
  new(result, finalizeGObject)
  result.impl = g_inet_socket_address_new_from_string(cstring(address), uint32(port))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initInetSocketAddressFromString*[T](result: var T; address: string; port: int) =
  assert(result is InetSocketAddress)
  new(result, finalizeGObject)
  result.impl = g_inet_socket_address_new_from_string(cstring(address), uint32(port))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_inet_socket_address_get_address*(self: ptr InetSocketAddress00): ptr InetAddress00 {.
    importc: "g_inet_socket_address_get_address", libprag.}

proc getAddress*(self: InetSocketAddress): InetAddress =
  let gobj = g_inet_socket_address_get_address(cast[ptr InetSocketAddress00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InetAddress](g_object_get_qdata(gobj, Quark))
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

proc address*(self: InetSocketAddress): InetAddress =
  let gobj = g_inet_socket_address_get_address(cast[ptr InetSocketAddress00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InetAddress](g_object_get_qdata(gobj, Quark))
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

proc g_inet_socket_address_get_flowinfo*(self: ptr InetSocketAddress00): uint32 {.
    importc: "g_inet_socket_address_get_flowinfo", libprag.}

proc getFlowinfo*(self: InetSocketAddress): int =
  int(g_inet_socket_address_get_flowinfo(cast[ptr InetSocketAddress00](self.impl)))

proc flowinfo*(self: InetSocketAddress): int =
  int(g_inet_socket_address_get_flowinfo(cast[ptr InetSocketAddress00](self.impl)))

proc g_inet_socket_address_get_port*(self: ptr InetSocketAddress00): uint16 {.
    importc: "g_inet_socket_address_get_port", libprag.}

proc getPort*(self: InetSocketAddress): uint16 =
  g_inet_socket_address_get_port(cast[ptr InetSocketAddress00](self.impl))

proc port*(self: InetSocketAddress): uint16 =
  g_inet_socket_address_get_port(cast[ptr InetSocketAddress00](self.impl))

proc g_inet_socket_address_get_scope_id*(self: ptr InetSocketAddress00): uint32 {.
    importc: "g_inet_socket_address_get_scope_id", libprag.}

proc getScopeId*(self: InetSocketAddress): int =
  int(g_inet_socket_address_get_scope_id(cast[ptr InetSocketAddress00](self.impl)))

proc scopeId*(self: InetSocketAddress): int =
  int(g_inet_socket_address_get_scope_id(cast[ptr InetSocketAddress00](self.impl)))

type
  SocketAddressClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getFamily*: proc(address: ptr SocketAddress00): SocketFamily {.cdecl.}
    getNativeSize*: proc(address: ptr SocketAddress00): int64 {.cdecl.}
    toNative*: proc(address: ptr SocketAddress00; dest: pointer; destlen: uint64): gboolean {.cdecl.}
  SocketAddressClass* = ref object
    impl*: ptr SocketAddressClass00

type
  InetSocketAddressClass00* {.pure.} = object
    parentClass*: SocketAddressClass00
  InetSocketAddressClass* = ref object
    impl*: ptr InetSocketAddressClass00

type
  Initable00* {.pure.} = object
  Initable* = ref object
    impl*: ptr Initable00

proc g_initable_newv*(objectType: GType; nParameters: uint32; parameters: gobject.Parameter00Array; 
    cancellable: ptr Cancellable00): ptr gobject.Object00 {.
    importc: "g_initable_newv", libprag.}

proc newInitablev*(objectType: GType; nParameters: int; parameters: gobject.Parameter00Array; 
    cancellable: Cancellable): gobject.Object =
  let gobj = g_initable_newv(objectType, uint32(nParameters), parameters, cast[ptr Cancellable00](cancellable.impl))
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

proc g_initable_init*(self: ptr Initable00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_initable_init", libprag.}

proc init*(self: Initable; cancellable: Cancellable): bool =
  toBool(g_initable_init(cast[ptr Initable00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

type
  InitableIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    init*: proc(initable: ptr Initable00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
  InitableIface* = ref object
    impl*: ptr InitableIface00

type
  ListModel00* {.pure.} = object
  ListModel* = ref object
    impl*: ptr ListModel00

proc g_list_model_get_item_type*(self: ptr ListModel00): GType {.
    importc: "g_list_model_get_item_type", libprag.}

proc getItemType*(self: ListModel): GType =
  g_list_model_get_item_type(cast[ptr ListModel00](self.impl))

proc itemType*(self: ListModel): GType =
  g_list_model_get_item_type(cast[ptr ListModel00](self.impl))

proc g_list_model_get_n_items*(self: ptr ListModel00): uint32 {.
    importc: "g_list_model_get_n_items", libprag.}

proc getNItems*(self: ListModel): int =
  int(g_list_model_get_n_items(cast[ptr ListModel00](self.impl)))

proc nItems*(self: ListModel): int =
  int(g_list_model_get_n_items(cast[ptr ListModel00](self.impl)))

proc g_list_model_get_object*(self: ptr ListModel00; position: uint32): ptr gobject.Object00 {.
    importc: "g_list_model_get_object", libprag.}

proc getItem*(self: ListModel; position: int): gobject.Object =
  let gobj = g_list_model_get_object(cast[ptr ListModel00](self.impl), uint32(position))
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

proc item*(self: ListModel; position: int): gobject.Object =
  let gobj = g_list_model_get_object(cast[ptr ListModel00](self.impl), uint32(position))
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

proc g_list_model_items_changed*(self: ptr ListModel00; position: uint32; removed: uint32; 
    added: uint32) {.
    importc: "g_list_model_items_changed", libprag.}

proc itemsChanged*(self: ListModel; position: int; removed: int; added: int) =
  g_list_model_items_changed(cast[ptr ListModel00](self.impl), uint32(position), uint32(removed), uint32(added))

type
  ListModelInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    getItemType*: proc(list: ptr ListModel00): GType {.cdecl.}
    getNItems*: proc(list: ptr ListModel00): uint32 {.cdecl.}
    getItem*: proc(list: ptr ListModel00; position: uint32): pointer {.cdecl.}
  ListModelInterface* = ref object
    impl*: ptr ListModelInterface00

type
  ListStore* = ref object of gobject.Object
  ListStore00* = object of gobject.Object00

proc g_list_store_new*(itemType: GType): ptr ListStore00 {.
    importc: "g_list_store_new", libprag.}

proc newListStore*(itemType: GType): ListStore =
  new(result, finalizeGObject)
  result.impl = g_list_store_new(itemType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initListStore*[T](result: var T; itemType: GType) =
  assert(result is ListStore)
  new(result, finalizeGObject)
  result.impl = g_list_store_new(itemType)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_list_store_append*(self: ptr ListStore00; item: ptr gobject.Object00) {.
    importc: "g_list_store_append", libprag.}

proc append*(self: ListStore; item: gobject.Object) =
  g_list_store_append(cast[ptr ListStore00](self.impl), cast[ptr gobject.Object00](item.impl))

proc g_list_store_insert*(self: ptr ListStore00; position: uint32; item: ptr gobject.Object00) {.
    importc: "g_list_store_insert", libprag.}

proc insert*(self: ListStore; position: int; item: gobject.Object) =
  g_list_store_insert(cast[ptr ListStore00](self.impl), uint32(position), cast[ptr gobject.Object00](item.impl))

proc g_list_store_insert_sorted*(self: ptr ListStore00; item: ptr gobject.Object00; 
    compareFunc: CompareDataFunc; userData: pointer): uint32 {.
    importc: "g_list_store_insert_sorted", libprag.}

proc insertSorted*(self: ListStore; item: gobject.Object; compareFunc: CompareDataFunc; 
    userData: pointer): int =
  int(g_list_store_insert_sorted(cast[ptr ListStore00](self.impl), cast[ptr gobject.Object00](item.impl), compareFunc, userData))

proc g_list_store_remove*(self: ptr ListStore00; position: uint32) {.
    importc: "g_list_store_remove", libprag.}

proc remove*(self: ListStore; position: int) =
  g_list_store_remove(cast[ptr ListStore00](self.impl), uint32(position))

proc g_list_store_remove_all*(self: ptr ListStore00) {.
    importc: "g_list_store_remove_all", libprag.}

proc removeAll*(self: ListStore) =
  g_list_store_remove_all(cast[ptr ListStore00](self.impl))

proc g_list_store_sort*(self: ptr ListStore00; compareFunc: CompareDataFunc; 
    userData: pointer) {.
    importc: "g_list_store_sort", libprag.}

proc sort*(self: ListStore; compareFunc: CompareDataFunc; userData: pointer) =
  g_list_store_sort(cast[ptr ListStore00](self.impl), compareFunc, userData)

proc g_list_store_splice*(self: ptr ListStore00; position: uint32; nRemovals: uint32; 
    additions: gobject.Object00Array; nAdditions: uint32) {.
    importc: "g_list_store_splice", libprag.}

proc splice*(self: ListStore; position: int; nRemovals: int; additions: gobject.Object00Array; 
    nAdditions: int) =
  g_list_store_splice(cast[ptr ListStore00](self.impl), uint32(position), uint32(nRemovals), additions, uint32(nAdditions))

type
  ListStoreClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  ListStoreClass* = ref object
    impl*: ptr ListStoreClass00

type
  LoadableIcon00* {.pure.} = object
  LoadableIcon* = ref object
    impl*: ptr LoadableIcon00

proc g_loadable_icon_load*(self: ptr LoadableIcon00; size: int32; `type`: var cstring; 
    cancellable: ptr Cancellable00): ptr InputStream00 {.
    importc: "g_loadable_icon_load", libprag.}

proc load*(self: LoadableIcon; size: int; `type`: var string; 
    cancellable: Cancellable): InputStream =
  var type_00 = cstring(`type`)
  let gobj = g_loadable_icon_load(cast[ptr LoadableIcon00](self.impl), int32(size), type_00, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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
  `type` = $(type_00)

proc g_loadable_icon_load_async*(self: ptr LoadableIcon00; size: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_loadable_icon_load_async", libprag.}

proc loadAsync*(self: LoadableIcon; size: int; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_loadable_icon_load_async(cast[ptr LoadableIcon00](self.impl), int32(size), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_loadable_icon_load_finish*(self: ptr LoadableIcon00; res: ptr AsyncResult00; 
    `type`: var cstring): ptr InputStream00 {.
    importc: "g_loadable_icon_load_finish", libprag.}

proc loadFinish*(self: LoadableIcon; res: AsyncResult; `type`: var string): InputStream =
  var type_00 = cstring(`type`)
  let gobj = g_loadable_icon_load_finish(cast[ptr LoadableIcon00](self.impl), cast[ptr AsyncResult00](res.impl), type_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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
  `type` = $(type_00)

type
  LoadableIconIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    load*: proc(icon: ptr LoadableIcon00; size: int32; `type`: var cstring; 
    cancellable: ptr Cancellable00): ptr InputStream00 {.cdecl.}
    loadAsync*: proc(icon: ptr LoadableIcon00; size: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    loadFinish*: proc(icon: ptr LoadableIcon00; res: ptr AsyncResult00; 
    `type`: var cstring): ptr InputStream00 {.cdecl.}
  LoadableIconIface* = ref object
    impl*: ptr LoadableIconIface00

const MENU_ATTRIBUTE_ACTION* = "action"

const MENU_ATTRIBUTE_ACTION_NAMESPACE* = "action-namespace"

const MENU_ATTRIBUTE_ICON* = "icon"

const MENU_ATTRIBUTE_LABEL* = "label"

const MENU_ATTRIBUTE_TARGET* = "target"

const MENU_LINK_SECTION* = "section"

const MENU_LINK_SUBMENU* = "submenu"

type
  MemoryInputStreamPrivate00* {.pure.} = object
  MemoryInputStreamPrivate* = ref object
    impl*: ptr MemoryInputStreamPrivate00

type
  MemoryInputStream* = ref object of InputStream
  MemoryInputStream00* = object of InputStream00
    priv2: ptr MemoryInputStreamPrivate00

proc g_memory_input_stream_new*(): ptr MemoryInputStream00 {.
    importc: "g_memory_input_stream_new", libprag.}

proc newMemoryInputStream*(): MemoryInputStream =
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMemoryInputStream*[T](result: var T) =
  assert(result is MemoryInputStream)
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_memory_input_stream_new_from_bytes*(bytes: ptr glib.Bytes00): ptr MemoryInputStream00 {.
    importc: "g_memory_input_stream_new_from_bytes", libprag.}

proc newMemoryInputStreamFromBytes*(bytes: glib.Bytes): MemoryInputStream =
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMemoryInputStreamFromBytes*[T](result: var T; bytes: glib.Bytes) =
  assert(result is MemoryInputStream)
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new_from_bytes(cast[ptr glib.Bytes00](bytes.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_memory_input_stream_new_from_data*(data: uint8Array; len: int64; destroy: DestroyNotify): ptr MemoryInputStream00 {.
    importc: "g_memory_input_stream_new_from_data", libprag.}

proc newMemoryInputStreamFromData*(data: uint8Array; len: int64; destroy: DestroyNotify): MemoryInputStream =
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new_from_data(data, len, destroy)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMemoryInputStreamFromData*[T](result: var T; data: uint8Array; len: int64; destroy: DestroyNotify) =
  assert(result is MemoryInputStream)
  new(result, finalizeGObject)
  result.impl = g_memory_input_stream_new_from_data(data, len, destroy)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_memory_input_stream_add_bytes*(self: ptr MemoryInputStream00; bytes: ptr glib.Bytes00) {.
    importc: "g_memory_input_stream_add_bytes", libprag.}

proc addBytes*(self: MemoryInputStream; bytes: glib.Bytes) =
  g_memory_input_stream_add_bytes(cast[ptr MemoryInputStream00](self.impl), cast[ptr glib.Bytes00](bytes.impl))

proc g_memory_input_stream_add_data*(self: ptr MemoryInputStream00; data: uint8Array; len: int64; 
    destroy: DestroyNotify) {.
    importc: "g_memory_input_stream_add_data", libprag.}

proc addData*(self: MemoryInputStream; data: uint8Array; len: int64; 
    destroy: DestroyNotify) =
  g_memory_input_stream_add_data(cast[ptr MemoryInputStream00](self.impl), data, len, destroy)

type
  MemoryInputStreamClass00* {.pure.} = object
    parentClass*: InputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  MemoryInputStreamClass* = ref object
    impl*: ptr MemoryInputStreamClass00

type
  MemoryOutputStreamPrivate00* {.pure.} = object
  MemoryOutputStreamPrivate* = ref object
    impl*: ptr MemoryOutputStreamPrivate00

type
  MemoryOutputStream* = ref object of OutputStream
  MemoryOutputStream00* = object of OutputStream00
    priv2: ptr MemoryOutputStreamPrivate00

proc g_memory_output_stream_new_resizable*(): ptr MemoryOutputStream00 {.
    importc: "g_memory_output_stream_new_resizable", libprag.}

proc newMemoryOutputStreamResizable*(): MemoryOutputStream =
  new(result, finalizeGObject)
  result.impl = g_memory_output_stream_new_resizable()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMemoryOutputStreamResizable*[T](result: var T) =
  assert(result is MemoryOutputStream)
  new(result, finalizeGObject)
  result.impl = g_memory_output_stream_new_resizable()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_memory_output_stream_get_data*(self: ptr MemoryOutputStream00): pointer {.
    importc: "g_memory_output_stream_get_data", libprag.}

proc getData*(self: MemoryOutputStream): pointer =
  g_memory_output_stream_get_data(cast[ptr MemoryOutputStream00](self.impl))

proc data*(self: MemoryOutputStream): pointer =
  g_memory_output_stream_get_data(cast[ptr MemoryOutputStream00](self.impl))

proc g_memory_output_stream_get_data_size*(self: ptr MemoryOutputStream00): uint64 {.
    importc: "g_memory_output_stream_get_data_size", libprag.}

proc getDataSize*(self: MemoryOutputStream): uint64 =
  g_memory_output_stream_get_data_size(cast[ptr MemoryOutputStream00](self.impl))

proc dataSize*(self: MemoryOutputStream): uint64 =
  g_memory_output_stream_get_data_size(cast[ptr MemoryOutputStream00](self.impl))

proc g_memory_output_stream_get_size*(self: ptr MemoryOutputStream00): uint64 {.
    importc: "g_memory_output_stream_get_size", libprag.}

proc getSize*(self: MemoryOutputStream): uint64 =
  g_memory_output_stream_get_size(cast[ptr MemoryOutputStream00](self.impl))

proc size*(self: MemoryOutputStream): uint64 =
  g_memory_output_stream_get_size(cast[ptr MemoryOutputStream00](self.impl))

proc g_memory_output_stream_steal_as_bytes*(self: ptr MemoryOutputStream00): ptr glib.Bytes00 {.
    importc: "g_memory_output_stream_steal_as_bytes", libprag.}

proc stealAsBytes*(self: MemoryOutputStream): glib.Bytes =
  new(result)
  result.impl = g_memory_output_stream_steal_as_bytes(cast[ptr MemoryOutputStream00](self.impl))

proc g_memory_output_stream_steal_data*(self: ptr MemoryOutputStream00): pointer {.
    importc: "g_memory_output_stream_steal_data", libprag.}

proc stealData*(self: MemoryOutputStream): pointer =
  g_memory_output_stream_steal_data(cast[ptr MemoryOutputStream00](self.impl))

type
  MemoryOutputStreamClass00* {.pure.} = object
    parentClass*: OutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  MemoryOutputStreamClass* = ref object
    impl*: ptr MemoryOutputStreamClass00

type
  Menu* = ref object of MenuModel
  Menu00* = object of MenuModel00

proc g_menu_new*(): ptr Menu00 {.
    importc: "g_menu_new", libprag.}

proc newMenu*(): Menu =
  new(result, finalizeGObject)
  result.impl = g_menu_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMenu*[T](result: var T) =
  assert(result is Menu)
  new(result, finalizeGObject)
  result.impl = g_menu_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_menu_append*(self: ptr Menu00; label: cstring; detailedAction: cstring) {.
    importc: "g_menu_append", libprag.}

proc append*(self: Menu; label: string; detailedAction: string) =
  g_menu_append(cast[ptr Menu00](self.impl), cstring(label), cstring(detailedAction))

proc g_menu_append_section*(self: ptr Menu00; label: cstring; section: ptr MenuModel00) {.
    importc: "g_menu_append_section", libprag.}

proc appendSection*(self: Menu; label: string; section: MenuModel) =
  g_menu_append_section(cast[ptr Menu00](self.impl), cstring(label), cast[ptr MenuModel00](section.impl))

proc g_menu_append_submenu*(self: ptr Menu00; label: cstring; submenu: ptr MenuModel00) {.
    importc: "g_menu_append_submenu", libprag.}

proc appendSubmenu*(self: Menu; label: string; submenu: MenuModel) =
  g_menu_append_submenu(cast[ptr Menu00](self.impl), cstring(label), cast[ptr MenuModel00](submenu.impl))

proc g_menu_freeze*(self: ptr Menu00) {.
    importc: "g_menu_freeze", libprag.}

proc freeze*(self: Menu) =
  g_menu_freeze(cast[ptr Menu00](self.impl))

proc g_menu_insert*(self: ptr Menu00; position: int32; label: cstring; 
    detailedAction: cstring) {.
    importc: "g_menu_insert", libprag.}

proc insert*(self: Menu; position: int; label: string; detailedAction: string) =
  g_menu_insert(cast[ptr Menu00](self.impl), int32(position), cstring(label), cstring(detailedAction))

proc g_menu_insert_section*(self: ptr Menu00; position: int32; label: cstring; 
    section: ptr MenuModel00) {.
    importc: "g_menu_insert_section", libprag.}

proc insertSection*(self: Menu; position: int; label: string; section: MenuModel) =
  g_menu_insert_section(cast[ptr Menu00](self.impl), int32(position), cstring(label), cast[ptr MenuModel00](section.impl))

proc g_menu_insert_submenu*(self: ptr Menu00; position: int32; label: cstring; 
    submenu: ptr MenuModel00) {.
    importc: "g_menu_insert_submenu", libprag.}

proc insertSubmenu*(self: Menu; position: int; label: string; submenu: MenuModel) =
  g_menu_insert_submenu(cast[ptr Menu00](self.impl), int32(position), cstring(label), cast[ptr MenuModel00](submenu.impl))

proc g_menu_prepend*(self: ptr Menu00; label: cstring; detailedAction: cstring) {.
    importc: "g_menu_prepend", libprag.}

proc prepend*(self: Menu; label: string; detailedAction: string) =
  g_menu_prepend(cast[ptr Menu00](self.impl), cstring(label), cstring(detailedAction))

proc g_menu_prepend_section*(self: ptr Menu00; label: cstring; section: ptr MenuModel00) {.
    importc: "g_menu_prepend_section", libprag.}

proc prependSection*(self: Menu; label: string; section: MenuModel) =
  g_menu_prepend_section(cast[ptr Menu00](self.impl), cstring(label), cast[ptr MenuModel00](section.impl))

proc g_menu_prepend_submenu*(self: ptr Menu00; label: cstring; submenu: ptr MenuModel00) {.
    importc: "g_menu_prepend_submenu", libprag.}

proc prependSubmenu*(self: Menu; label: string; submenu: MenuModel) =
  g_menu_prepend_submenu(cast[ptr Menu00](self.impl), cstring(label), cast[ptr MenuModel00](submenu.impl))

proc g_menu_remove*(self: ptr Menu00; position: int32) {.
    importc: "g_menu_remove", libprag.}

proc remove*(self: Menu; position: int) =
  g_menu_remove(cast[ptr Menu00](self.impl), int32(position))

proc g_menu_remove_all*(self: ptr Menu00) {.
    importc: "g_menu_remove_all", libprag.}

proc removeAll*(self: Menu) =
  g_menu_remove_all(cast[ptr Menu00](self.impl))

type
  MenuItem* = ref object of gobject.Object
  MenuItem00* = object of gobject.Object00

proc g_menu_item_new*(label: cstring; detailedAction: cstring): ptr MenuItem00 {.
    importc: "g_menu_item_new", libprag.}

proc newMenuItem*(label: string; detailedAction: string): MenuItem =
  new(result, finalizeGObject)
  result.impl = g_menu_item_new(cstring(label), cstring(detailedAction))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMenuItem*[T](result: var T; label: string; detailedAction: string) =
  assert(result is MenuItem)
  new(result, finalizeGObject)
  result.impl = g_menu_item_new(cstring(label), cstring(detailedAction))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_menu_item_new_from_model*(model: ptr MenuModel00; itemIndex: int32): ptr MenuItem00 {.
    importc: "g_menu_item_new_from_model", libprag.}

proc newMenuItemFromModel*(model: MenuModel; itemIndex: int): MenuItem =
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_from_model(cast[ptr MenuModel00](model.impl), int32(itemIndex))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMenuItemFromModel*[T](result: var T; model: MenuModel; itemIndex: int) =
  assert(result is MenuItem)
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_from_model(cast[ptr MenuModel00](model.impl), int32(itemIndex))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_menu_item_new_section*(label: cstring; section: ptr MenuModel00): ptr MenuItem00 {.
    importc: "g_menu_item_new_section", libprag.}

proc newMenuItemSection*(label: string; section: MenuModel): MenuItem =
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_section(cstring(label), cast[ptr MenuModel00](section.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMenuItemSection*[T](result: var T; label: string; section: MenuModel) =
  assert(result is MenuItem)
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_section(cstring(label), cast[ptr MenuModel00](section.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_menu_item_new_submenu*(label: cstring; submenu: ptr MenuModel00): ptr MenuItem00 {.
    importc: "g_menu_item_new_submenu", libprag.}

proc newMenuItemSubmenu*(label: string; submenu: MenuModel): MenuItem =
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_submenu(cstring(label), cast[ptr MenuModel00](submenu.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initMenuItemSubmenu*[T](result: var T; label: string; submenu: MenuModel) =
  assert(result is MenuItem)
  new(result, finalizeGObject)
  result.impl = g_menu_item_new_submenu(cstring(label), cast[ptr MenuModel00](submenu.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_menu_item_get_attribute_value*(self: ptr MenuItem00; attribute: cstring; expectedType: ptr glib.VariantType00): ptr glib.Variant00 {.
    importc: "g_menu_item_get_attribute_value", libprag.}

proc getAttributeValue*(self: MenuItem; attribute: string; expectedType: glib.VariantType): glib.Variant =
  new(result)
  result.impl = g_menu_item_get_attribute_value(cast[ptr MenuItem00](self.impl), cstring(attribute), cast[ptr glib.VariantType00](expectedType.impl))

proc attributeValue*(self: MenuItem; attribute: string; expectedType: glib.VariantType): glib.Variant =
  new(result)
  result.impl = g_menu_item_get_attribute_value(cast[ptr MenuItem00](self.impl), cstring(attribute), cast[ptr glib.VariantType00](expectedType.impl))

proc g_menu_item_get_link*(self: ptr MenuItem00; link: cstring): ptr MenuModel00 {.
    importc: "g_menu_item_get_link", libprag.}

proc getLink*(self: MenuItem; link: string): MenuModel =
  let gobj = g_menu_item_get_link(cast[ptr MenuItem00](self.impl), cstring(link))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc link*(self: MenuItem; link: string): MenuModel =
  let gobj = g_menu_item_get_link(cast[ptr MenuItem00](self.impl), cstring(link))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[MenuModel](g_object_get_qdata(gobj, Quark))
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

proc g_menu_item_set_action_and_target_value*(self: ptr MenuItem00; action: cstring; targetValue: ptr glib.Variant00) {.
    importc: "g_menu_item_set_action_and_target_value", libprag.}

proc setActionAndTargetValue*(self: MenuItem; action: string; targetValue: glib.Variant) =
  g_menu_item_set_action_and_target_value(cast[ptr MenuItem00](self.impl), cstring(action), cast[ptr glib.Variant00](targetValue.impl))

proc g_menu_item_set_attribute_value*(self: ptr MenuItem00; attribute: cstring; value: ptr glib.Variant00) {.
    importc: "g_menu_item_set_attribute_value", libprag.}

proc setAttributeValue*(self: MenuItem; attribute: string; value: glib.Variant) =
  g_menu_item_set_attribute_value(cast[ptr MenuItem00](self.impl), cstring(attribute), cast[ptr glib.Variant00](value.impl))

proc g_menu_item_set_detailed_action*(self: ptr MenuItem00; detailedAction: cstring) {.
    importc: "g_menu_item_set_detailed_action", libprag.}

proc setDetailedAction*(self: MenuItem; detailedAction: string) =
  g_menu_item_set_detailed_action(cast[ptr MenuItem00](self.impl), cstring(detailedAction))

proc `detailedAction=`*(self: MenuItem; detailedAction: string) =
  g_menu_item_set_detailed_action(cast[ptr MenuItem00](self.impl), cstring(detailedAction))

proc g_menu_item_set_icon*(self: ptr MenuItem00; icon: ptr Icon00) {.
    importc: "g_menu_item_set_icon", libprag.}

proc setIcon*(self: MenuItem; icon: Icon) =
  g_menu_item_set_icon(cast[ptr MenuItem00](self.impl), cast[ptr Icon00](icon.impl))

proc `icon=`*(self: MenuItem; icon: Icon) =
  g_menu_item_set_icon(cast[ptr MenuItem00](self.impl), cast[ptr Icon00](icon.impl))

proc g_menu_item_set_label*(self: ptr MenuItem00; label: cstring) {.
    importc: "g_menu_item_set_label", libprag.}

proc setLabel*(self: MenuItem; label: string) =
  g_menu_item_set_label(cast[ptr MenuItem00](self.impl), cstring(label))

proc `label=`*(self: MenuItem; label: string) =
  g_menu_item_set_label(cast[ptr MenuItem00](self.impl), cstring(label))

proc g_menu_item_set_link*(self: ptr MenuItem00; link: cstring; model: ptr MenuModel00) {.
    importc: "g_menu_item_set_link", libprag.}

proc setLink*(self: MenuItem; link: string; model: MenuModel) =
  g_menu_item_set_link(cast[ptr MenuItem00](self.impl), cstring(link), cast[ptr MenuModel00](model.impl))

proc g_menu_item_set_section*(self: ptr MenuItem00; section: ptr MenuModel00) {.
    importc: "g_menu_item_set_section", libprag.}

proc setSection*(self: MenuItem; section: MenuModel) =
  g_menu_item_set_section(cast[ptr MenuItem00](self.impl), cast[ptr MenuModel00](section.impl))

proc `section=`*(self: MenuItem; section: MenuModel) =
  g_menu_item_set_section(cast[ptr MenuItem00](self.impl), cast[ptr MenuModel00](section.impl))

proc g_menu_item_set_submenu*(self: ptr MenuItem00; submenu: ptr MenuModel00) {.
    importc: "g_menu_item_set_submenu", libprag.}

proc setSubmenu*(self: MenuItem; submenu: MenuModel) =
  g_menu_item_set_submenu(cast[ptr MenuItem00](self.impl), cast[ptr MenuModel00](submenu.impl))

proc `submenu=`*(self: MenuItem; submenu: MenuModel) =
  g_menu_item_set_submenu(cast[ptr MenuItem00](self.impl), cast[ptr MenuModel00](submenu.impl))

proc g_menu_append_item*(self: ptr Menu00; item: ptr MenuItem00) {.
    importc: "g_menu_append_item", libprag.}

proc appendItem*(self: Menu; item: MenuItem) =
  g_menu_append_item(cast[ptr Menu00](self.impl), cast[ptr MenuItem00](item.impl))

proc g_menu_insert_item*(self: ptr Menu00; position: int32; item: ptr MenuItem00) {.
    importc: "g_menu_insert_item", libprag.}

proc insertItem*(self: Menu; position: int; item: MenuItem) =
  g_menu_insert_item(cast[ptr Menu00](self.impl), int32(position), cast[ptr MenuItem00](item.impl))

proc g_menu_prepend_item*(self: ptr Menu00; item: ptr MenuItem00) {.
    importc: "g_menu_prepend_item", libprag.}

proc prependItem*(self: Menu; item: MenuItem) =
  g_menu_prepend_item(cast[ptr Menu00](self.impl), cast[ptr MenuItem00](item.impl))

type
  MenuAttributeIterClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getNext*: proc(iter: ptr MenuAttributeIter00; outName: var cstring; 
    value: var ptr glib.Variant00): gboolean {.cdecl.}
  MenuAttributeIterClass* = ref object
    impl*: ptr MenuAttributeIterClass00

type
  MenuLinkIterClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getNext*: proc(iter: ptr MenuLinkIter00; outLink: var cstring; value: var ptr MenuModel00): gboolean {.cdecl.}
  MenuLinkIterClass* = ref object
    impl*: ptr MenuLinkIterClass00

type
  MenuModelClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    isMutable*: proc(model: ptr MenuModel00): gboolean {.cdecl.}
    getNItems*: proc(model: ptr MenuModel00): int32 {.cdecl.}
    getItemAttributes*: proc(model: ptr MenuModel00; itemIndex: int32; attributes: var ptr HashTable00) {.cdecl.}
    iterateItemAttributes*: proc(model: ptr MenuModel00; itemIndex: int32): ptr MenuAttributeIter00 {.cdecl.}
    getItemAttributeValue*: proc(model: ptr MenuModel00; itemIndex: int32; attribute: cstring; 
    expectedType: ptr glib.VariantType00): ptr glib.Variant00 {.cdecl.}
    getItemLinks*: proc(model: ptr MenuModel00; itemIndex: int32; links: var ptr HashTable00) {.cdecl.}
    iterateItemLinks*: proc(model: ptr MenuModel00; itemIndex: int32): ptr MenuLinkIter00 {.cdecl.}
    getItemLink*: proc(model: ptr MenuModel00; itemIndex: int32; link: cstring): ptr MenuModel00 {.cdecl.}
  MenuModelClass* = ref object
    impl*: ptr MenuModelClass00

type
  MountIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    changed*: proc(mount: ptr Mount00) {.cdecl.}
    unmounted*: proc(mount: ptr Mount00) {.cdecl.}
    getRoot*: proc(mount: ptr Mount00): ptr File00 {.cdecl.}
    getName*: proc(mount: ptr Mount00): cstring {.cdecl.}
    getIcon*: proc(mount: ptr Mount00): ptr Icon00 {.cdecl.}
    getUuid*: proc(mount: ptr Mount00): cstring {.cdecl.}
    getVolume*: proc(mount: ptr Mount00): ptr Volume00 {.cdecl.}
    getDrive*: proc(mount: ptr Mount00): ptr Drive00 {.cdecl.}
    canUnmount*: proc(mount: ptr Mount00): gboolean {.cdecl.}
    canEject*: proc(mount: ptr Mount00): gboolean {.cdecl.}
    unmount*: proc(mount: ptr Mount00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    unmountFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    eject*: proc(mount: ptr Mount00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    ejectFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    remount*: proc(mount: ptr Mount00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    remountFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    guessContentType*: proc(mount: ptr Mount00; forceRescan: gboolean; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    guessContentTypeFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): cstringArray {.cdecl.}
    guessContentTypeSync*: proc(mount: ptr Mount00; forceRescan: gboolean; cancellable: ptr Cancellable00): cstringArray {.cdecl.}
    preUnmount*: proc(mount: ptr Mount00) {.cdecl.}
    unmountWithOperation*: proc(mount: ptr Mount00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    unmountWithOperationFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    ejectWithOperation*: proc(mount: ptr Mount00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    ejectWithOperationFinish*: proc(mount: ptr Mount00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    getDefaultLocation*: proc(mount: ptr Mount00): ptr File00 {.cdecl.}
    getSortKey*: proc(mount: ptr Mount00): cstring {.cdecl.}
    getSymbolicIcon*: proc(mount: ptr Mount00): ptr Icon00 {.cdecl.}
  MountIface* = ref object
    impl*: ptr MountIface00

type
  MountOperationClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    askPassword*: proc(op: ptr MountOperation00; message: cstring; defaultUser: cstring; 
    defaultDomain: cstring; flags: AskPasswordFlags) {.cdecl.}
    askQuestion*: proc(op: ptr MountOperation00; message: cstring; choices: cstring) {.cdecl.}
    reply*: proc(op: ptr MountOperation00; resu: MountOperationResult) {.cdecl.}
    aborted*: proc(op: ptr MountOperation00) {.cdecl.}
    showProcesses*: pointer
    showUnmountProgress*: proc(op: ptr MountOperation00; message: cstring; timeLeft: int64; 
    bytesLeft: int64) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
    gReserved8*: pointer
    gReserved9*: pointer
  MountOperationClass* = ref object
    impl*: ptr MountOperationClass00

const NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME* = "gio-native-volume-monitor"

const NETWORK_MONITOR_EXTENSION_POINT_NAME* = "gio-network-monitor"

type
  NativeSocketAddress00* {.pure.} = object
  NativeSocketAddress* = ref object
    impl*: ptr NativeSocketAddress00

type
  VolumeMonitor* = ref object of gobject.Object
  VolumeMonitor00* = object of gobject.Object00
    priv1: pointer

proc scDriveChanged*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; drive: Drive00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drive-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDriveConnected*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; drive: Drive00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drive-connected", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDriveDisconnected*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; drive: Drive00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drive-disconnected", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDriveEjectButton*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; drive: Drive00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drive-eject-button", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scDriveStopButton*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; drive: Drive00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "drive-stop-button", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMountAdded*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; mount: Mount00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mount-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMountChanged*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; mount: Mount00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mount-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMountPreUnmount*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; mount: Mount00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mount-pre-unmount", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMountRemoved*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; mount: Mount00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mount-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scVolumeAdded*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; volume: Volume00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "volume-added", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scVolumeChanged*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; volume: Volume00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "volume-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scVolumeRemoved*(self: VolumeMonitor;  p: proc (self: ptr gobject.Object00; volume: Volume00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "volume-removed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_volume_monitor_adopt_orphan_mount*(mount: ptr Mount00): ptr Volume00 {.
    importc: "g_volume_monitor_adopt_orphan_mount", libprag.}

proc adoptOrphanMount*(mount: Mount): Volume =
  new(result)
  result.impl = g_volume_monitor_adopt_orphan_mount(cast[ptr Mount00](mount.impl))

proc g_volume_monitor_get*(): ptr VolumeMonitor00 {.
    importc: "g_volume_monitor_get", libprag.}

proc get*(): VolumeMonitor =
  let gobj = g_volume_monitor_get()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[VolumeMonitor](g_object_get_qdata(gobj, Quark))
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

proc g_volume_monitor_get_connected_drives*(self: ptr VolumeMonitor00): ptr pointer {.
    importc: "g_volume_monitor_get_connected_drives", libprag.}

proc getConnectedDrives*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_connected_drives(cast[ptr VolumeMonitor00](self.impl))

proc connectedDrives*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_connected_drives(cast[ptr VolumeMonitor00](self.impl))

proc g_volume_monitor_get_mount_for_uuid*(self: ptr VolumeMonitor00; uuid: cstring): ptr Mount00 {.
    importc: "g_volume_monitor_get_mount_for_uuid", libprag.}

proc getMountForUuid*(self: VolumeMonitor; uuid: string): Mount =
  new(result)
  result.impl = g_volume_monitor_get_mount_for_uuid(cast[ptr VolumeMonitor00](self.impl), cstring(uuid))

proc mountForUuid*(self: VolumeMonitor; uuid: string): Mount =
  new(result)
  result.impl = g_volume_monitor_get_mount_for_uuid(cast[ptr VolumeMonitor00](self.impl), cstring(uuid))

proc g_volume_monitor_get_mounts*(self: ptr VolumeMonitor00): ptr pointer {.
    importc: "g_volume_monitor_get_mounts", libprag.}

proc getMounts*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_mounts(cast[ptr VolumeMonitor00](self.impl))

proc mounts*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_mounts(cast[ptr VolumeMonitor00](self.impl))

proc g_volume_monitor_get_volume_for_uuid*(self: ptr VolumeMonitor00; uuid: cstring): ptr Volume00 {.
    importc: "g_volume_monitor_get_volume_for_uuid", libprag.}

proc getVolumeForUuid*(self: VolumeMonitor; uuid: string): Volume =
  new(result)
  result.impl = g_volume_monitor_get_volume_for_uuid(cast[ptr VolumeMonitor00](self.impl), cstring(uuid))

proc volumeForUuid*(self: VolumeMonitor; uuid: string): Volume =
  new(result)
  result.impl = g_volume_monitor_get_volume_for_uuid(cast[ptr VolumeMonitor00](self.impl), cstring(uuid))

proc g_volume_monitor_get_volumes*(self: ptr VolumeMonitor00): ptr pointer {.
    importc: "g_volume_monitor_get_volumes", libprag.}

proc getVolumes*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_volumes(cast[ptr VolumeMonitor00](self.impl))

proc volumes*(self: VolumeMonitor): ptr pointer =
  g_volume_monitor_get_volumes(cast[ptr VolumeMonitor00](self.impl))

type
  NativeVolumeMonitor* = ref object of VolumeMonitor
  NativeVolumeMonitor00* = object of VolumeMonitor00

type
  VolumeMonitorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    volumeAdded*: proc(volumeMonitor: ptr VolumeMonitor00; volume: ptr Volume00) {.cdecl.}
    volumeRemoved*: proc(volumeMonitor: ptr VolumeMonitor00; volume: ptr Volume00) {.cdecl.}
    volumeChanged*: proc(volumeMonitor: ptr VolumeMonitor00; volume: ptr Volume00) {.cdecl.}
    mountAdded*: proc(volumeMonitor: ptr VolumeMonitor00; mount: ptr Mount00) {.cdecl.}
    mountRemoved*: proc(volumeMonitor: ptr VolumeMonitor00; mount: ptr Mount00) {.cdecl.}
    mountPreUnmount*: proc(volumeMonitor: ptr VolumeMonitor00; mount: ptr Mount00) {.cdecl.}
    mountChanged*: proc(volumeMonitor: ptr VolumeMonitor00; mount: ptr Mount00) {.cdecl.}
    driveConnected*: proc(volumeMonitor: ptr VolumeMonitor00; drive: ptr Drive00) {.cdecl.}
    driveDisconnected*: proc(volumeMonitor: ptr VolumeMonitor00; drive: ptr Drive00) {.cdecl.}
    driveChanged*: proc(volumeMonitor: ptr VolumeMonitor00; drive: ptr Drive00) {.cdecl.}
    isSupported*: proc(): gboolean {.cdecl.}
    getConnectedDrives*: proc(volumeMonitor: ptr VolumeMonitor00): ptr pointer {.cdecl.}
    getVolumes*: proc(volumeMonitor: ptr VolumeMonitor00): ptr pointer {.cdecl.}
    getMounts*: proc(volumeMonitor: ptr VolumeMonitor00): ptr pointer {.cdecl.}
    getVolumeForUuid*: proc(volumeMonitor: ptr VolumeMonitor00; uuid: cstring): ptr Volume00 {.cdecl.}
    getMountForUuid*: proc(volumeMonitor: ptr VolumeMonitor00; uuid: cstring): ptr Mount00 {.cdecl.}
    adoptOrphanMount*: pointer
    driveEjectButton*: proc(volumeMonitor: ptr VolumeMonitor00; drive: ptr Drive00) {.cdecl.}
    driveStopButton*: proc(volumeMonitor: ptr VolumeMonitor00; drive: ptr Drive00) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  VolumeMonitorClass* = ref object
    impl*: ptr VolumeMonitorClass00

type
  NativeVolumeMonitorClass00* {.pure.} = object
    parentClass*: VolumeMonitorClass00
    getMountForMountPath*: pointer
  NativeVolumeMonitorClass* = ref object
    impl*: ptr NativeVolumeMonitorClass00

type
  NetworkAddressPrivate00* {.pure.} = object
  NetworkAddressPrivate* = ref object
    impl*: ptr NetworkAddressPrivate00

type
  NetworkAddress* = ref object of gobject.Object
  NetworkAddress00* = object of gobject.Object00
    priv1: ptr NetworkAddressPrivate00

proc g_network_address_new*(hostname: cstring; port: uint16): ptr NetworkAddress00 {.
    importc: "g_network_address_new", libprag.}

proc newNetworkAddress*(hostname: string; port: uint16): NetworkAddress =
  new(result, finalizeGObject)
  result.impl = g_network_address_new(cstring(hostname), port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNetworkAddress*[T](result: var T; hostname: string; port: uint16) =
  assert(result is NetworkAddress)
  new(result, finalizeGObject)
  result.impl = g_network_address_new(cstring(hostname), port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_network_address_new_loopback*(port: uint16): ptr NetworkAddress00 {.
    importc: "g_network_address_new_loopback", libprag.}

proc newNetworkAddressLoopback*(port: uint16): NetworkAddress =
  new(result, finalizeGObject)
  result.impl = g_network_address_new_loopback(port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNetworkAddressLoopback*[T](result: var T; port: uint16) =
  assert(result is NetworkAddress)
  new(result, finalizeGObject)
  result.impl = g_network_address_new_loopback(port)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_network_address_parse*(hostAndPort: cstring; defaultPort: uint16): ptr NetworkAddress00 {.
    importc: "g_network_address_parse", libprag.}

proc parse*(hostAndPort: string; defaultPort: uint16): NetworkAddress =
  let gobj = g_network_address_parse(cstring(hostAndPort), defaultPort)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[NetworkAddress](g_object_get_qdata(gobj, Quark))
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

proc g_network_address_parse_uri*(uri: cstring; defaultPort: uint16): ptr NetworkAddress00 {.
    importc: "g_network_address_parse_uri", libprag.}

proc parseUri*(uri: string; defaultPort: uint16): NetworkAddress =
  let gobj = g_network_address_parse_uri(cstring(uri), defaultPort)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[NetworkAddress](g_object_get_qdata(gobj, Quark))
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

proc g_network_address_get_hostname*(self: ptr NetworkAddress00): cstring {.
    importc: "g_network_address_get_hostname", libprag.}

proc getHostname*(self: NetworkAddress): string =
  let resul0 = g_network_address_get_hostname(cast[ptr NetworkAddress00](self.impl))
  result = $resul0

proc hostname*(self: NetworkAddress): string =
  let resul0 = g_network_address_get_hostname(cast[ptr NetworkAddress00](self.impl))
  result = $resul0

proc g_network_address_get_port*(self: ptr NetworkAddress00): uint16 {.
    importc: "g_network_address_get_port", libprag.}

proc getPort*(self: NetworkAddress): uint16 =
  g_network_address_get_port(cast[ptr NetworkAddress00](self.impl))

proc port*(self: NetworkAddress): uint16 =
  g_network_address_get_port(cast[ptr NetworkAddress00](self.impl))

proc g_network_address_get_scheme*(self: ptr NetworkAddress00): cstring {.
    importc: "g_network_address_get_scheme", libprag.}

proc getScheme*(self: NetworkAddress): string =
  let resul0 = g_network_address_get_scheme(cast[ptr NetworkAddress00](self.impl))
  result = $resul0

proc scheme*(self: NetworkAddress): string =
  let resul0 = g_network_address_get_scheme(cast[ptr NetworkAddress00](self.impl))
  result = $resul0

type
  NetworkAddressClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  NetworkAddressClass* = ref object
    impl*: ptr NetworkAddressClass00

type
  NetworkConnectivity* {.size: sizeof(cint), pure.} = enum
    local = 1
    limited = 2
    portal = 3
    full = 4

type
  NetworkMonitor00* {.pure.} = object
  NetworkMonitor* = ref object
    impl*: ptr NetworkMonitor00

proc g_network_monitor_get_default*(): ptr NetworkMonitor00 {.
    importc: "g_network_monitor_get_default", libprag.}

proc getDefault*(): NetworkMonitor =
  new(result)
  result.impl = g_network_monitor_get_default()

proc default*(): NetworkMonitor =
  new(result)
  result.impl = g_network_monitor_get_default()

proc g_network_monitor_can_reach*(self: ptr NetworkMonitor00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_network_monitor_can_reach", libprag.}

proc canReach*(self: NetworkMonitor; connectable: SocketConnectable; 
    cancellable: Cancellable): bool =
  toBool(g_network_monitor_can_reach(cast[ptr NetworkMonitor00](self.impl), cast[ptr SocketConnectable00](connectable.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_network_monitor_can_reach_async*(self: ptr NetworkMonitor00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_network_monitor_can_reach_async", libprag.}

proc canReachAsync*(self: NetworkMonitor; connectable: SocketConnectable; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_network_monitor_can_reach_async(cast[ptr NetworkMonitor00](self.impl), cast[ptr SocketConnectable00](connectable.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_network_monitor_can_reach_finish*(self: ptr NetworkMonitor00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_network_monitor_can_reach_finish", libprag.}

proc canReachFinish*(self: NetworkMonitor; resu: AsyncResult): bool =
  toBool(g_network_monitor_can_reach_finish(cast[ptr NetworkMonitor00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_network_monitor_get_connectivity*(self: ptr NetworkMonitor00): NetworkConnectivity {.
    importc: "g_network_monitor_get_connectivity", libprag.}

proc getConnectivity*(self: NetworkMonitor): NetworkConnectivity =
  g_network_monitor_get_connectivity(cast[ptr NetworkMonitor00](self.impl))

proc connectivity*(self: NetworkMonitor): NetworkConnectivity =
  g_network_monitor_get_connectivity(cast[ptr NetworkMonitor00](self.impl))

proc g_network_monitor_get_network_available*(self: ptr NetworkMonitor00): gboolean {.
    importc: "g_network_monitor_get_network_available", libprag.}

proc getNetworkAvailable*(self: NetworkMonitor): bool =
  toBool(g_network_monitor_get_network_available(cast[ptr NetworkMonitor00](self.impl)))

proc networkAvailable*(self: NetworkMonitor): bool =
  toBool(g_network_monitor_get_network_available(cast[ptr NetworkMonitor00](self.impl)))

proc g_network_monitor_get_network_metered*(self: ptr NetworkMonitor00): gboolean {.
    importc: "g_network_monitor_get_network_metered", libprag.}

proc getNetworkMetered*(self: NetworkMonitor): bool =
  toBool(g_network_monitor_get_network_metered(cast[ptr NetworkMonitor00](self.impl)))

proc networkMetered*(self: NetworkMonitor): bool =
  toBool(g_network_monitor_get_network_metered(cast[ptr NetworkMonitor00](self.impl)))

type
  NetworkMonitorInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    networkChanged*: proc(monitor: ptr NetworkMonitor00; available: gboolean) {.cdecl.}
    canReach*: proc(monitor: ptr NetworkMonitor00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    canReachAsync*: proc(monitor: ptr NetworkMonitor00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    canReachFinish*: proc(monitor: ptr NetworkMonitor00; resu: ptr AsyncResult00): gboolean {.cdecl.}
  NetworkMonitorInterface* = ref object
    impl*: ptr NetworkMonitorInterface00

type
  NetworkServicePrivate00* {.pure.} = object
  NetworkServicePrivate* = ref object
    impl*: ptr NetworkServicePrivate00

type
  NetworkService* = ref object of gobject.Object
  NetworkService00* = object of gobject.Object00
    priv1: ptr NetworkServicePrivate00

proc g_network_service_new*(service: cstring; protocol: cstring; domain: cstring): ptr NetworkService00 {.
    importc: "g_network_service_new", libprag.}

proc newNetworkService*(service: string; protocol: string; domain: string): NetworkService =
  new(result, finalizeGObject)
  result.impl = g_network_service_new(cstring(service), cstring(protocol), cstring(domain))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initNetworkService*[T](result: var T; service: string; protocol: string; domain: string) =
  assert(result is NetworkService)
  new(result, finalizeGObject)
  result.impl = g_network_service_new(cstring(service), cstring(protocol), cstring(domain))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_network_service_get_domain*(self: ptr NetworkService00): cstring {.
    importc: "g_network_service_get_domain", libprag.}

proc getDomain*(self: NetworkService): string =
  let resul0 = g_network_service_get_domain(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc domain*(self: NetworkService): string =
  let resul0 = g_network_service_get_domain(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc g_network_service_get_protocol*(self: ptr NetworkService00): cstring {.
    importc: "g_network_service_get_protocol", libprag.}

proc getProtocol*(self: NetworkService): string =
  let resul0 = g_network_service_get_protocol(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc protocol*(self: NetworkService): string =
  let resul0 = g_network_service_get_protocol(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc g_network_service_get_scheme*(self: ptr NetworkService00): cstring {.
    importc: "g_network_service_get_scheme", libprag.}

proc getScheme*(self: NetworkService): string =
  let resul0 = g_network_service_get_scheme(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc scheme*(self: NetworkService): string =
  let resul0 = g_network_service_get_scheme(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc g_network_service_get_service*(self: ptr NetworkService00): cstring {.
    importc: "g_network_service_get_service", libprag.}

proc getService*(self: NetworkService): string =
  let resul0 = g_network_service_get_service(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc service*(self: NetworkService): string =
  let resul0 = g_network_service_get_service(cast[ptr NetworkService00](self.impl))
  result = $resul0

proc g_network_service_set_scheme*(self: ptr NetworkService00; scheme: cstring) {.
    importc: "g_network_service_set_scheme", libprag.}

proc setScheme*(self: NetworkService; scheme: string) =
  g_network_service_set_scheme(cast[ptr NetworkService00](self.impl), cstring(scheme))

proc `scheme=`*(self: NetworkService; scheme: string) =
  g_network_service_set_scheme(cast[ptr NetworkService00](self.impl), cstring(scheme))

type
  NetworkServiceClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  NetworkServiceClass* = ref object
    impl*: ptr NetworkServiceClass00

const PROXY_EXTENSION_POINT_NAME* = "gio-proxy"

const PROXY_RESOLVER_EXTENSION_POINT_NAME* = "gio-proxy-resolver"

type
  PermissionPrivate00* {.pure.} = object
  PermissionPrivate* = ref object
    impl*: ptr PermissionPrivate00

type
  Permission* = ref object of gobject.Object
  Permission00* = object of gobject.Object00
    priv1: ptr PermissionPrivate00

proc g_permission_acquire*(self: ptr Permission00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_permission_acquire", libprag.}

proc acquire*(self: Permission; cancellable: Cancellable): bool =
  toBool(g_permission_acquire(cast[ptr Permission00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_permission_acquire_async*(self: ptr Permission00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_permission_acquire_async", libprag.}

proc acquireAsync*(self: Permission; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_permission_acquire_async(cast[ptr Permission00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_permission_acquire_finish*(self: ptr Permission00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_permission_acquire_finish", libprag.}

proc acquireFinish*(self: Permission; resu: AsyncResult): bool =
  toBool(g_permission_acquire_finish(cast[ptr Permission00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_permission_get_allowed*(self: ptr Permission00): gboolean {.
    importc: "g_permission_get_allowed", libprag.}

proc getAllowed*(self: Permission): bool =
  toBool(g_permission_get_allowed(cast[ptr Permission00](self.impl)))

proc allowed*(self: Permission): bool =
  toBool(g_permission_get_allowed(cast[ptr Permission00](self.impl)))

proc g_permission_get_can_acquire*(self: ptr Permission00): gboolean {.
    importc: "g_permission_get_can_acquire", libprag.}

proc getCanAcquire*(self: Permission): bool =
  toBool(g_permission_get_can_acquire(cast[ptr Permission00](self.impl)))

proc canAcquire*(self: Permission): bool =
  toBool(g_permission_get_can_acquire(cast[ptr Permission00](self.impl)))

proc g_permission_get_can_release*(self: ptr Permission00): gboolean {.
    importc: "g_permission_get_can_release", libprag.}

proc getCanRelease*(self: Permission): bool =
  toBool(g_permission_get_can_release(cast[ptr Permission00](self.impl)))

proc canRelease*(self: Permission): bool =
  toBool(g_permission_get_can_release(cast[ptr Permission00](self.impl)))

proc g_permission_impl_update*(self: ptr Permission00; allowed: gboolean; canAcquire: gboolean; 
    canRelease: gboolean) {.
    importc: "g_permission_impl_update", libprag.}

proc implUpdate*(self: Permission; allowed: bool; canAcquire: bool; 
    canRelease: bool) =
  g_permission_impl_update(cast[ptr Permission00](self.impl), gboolean(allowed), gboolean(canAcquire), gboolean(canRelease))

proc g_permission_release*(self: ptr Permission00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_permission_release", libprag.}

proc release*(self: Permission; cancellable: Cancellable): bool =
  toBool(g_permission_release(cast[ptr Permission00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_permission_release_async*(self: ptr Permission00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_permission_release_async", libprag.}

proc releaseAsync*(self: Permission; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_permission_release_async(cast[ptr Permission00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_permission_release_finish*(self: ptr Permission00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_permission_release_finish", libprag.}

proc releaseFinish*(self: Permission; resu: AsyncResult): bool =
  toBool(g_permission_release_finish(cast[ptr Permission00](self.impl), cast[ptr AsyncResult00](resu.impl)))

type
  PermissionClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    acquire*: proc(permission: ptr Permission00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    acquireAsync*: proc(permission: ptr Permission00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    acquireFinish*: proc(permission: ptr Permission00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    release*: proc(permission: ptr Permission00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    releaseAsync*: proc(permission: ptr Permission00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    releaseFinish*: proc(permission: ptr Permission00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    reserved*: array[16, pointer]
  PermissionClass* = ref object
    impl*: ptr PermissionClass00

type
  PollableInputStream00* {.pure.} = object
  PollableInputStream* = ref object
    impl*: ptr PollableInputStream00

proc g_pollable_input_stream_can_poll*(self: ptr PollableInputStream00): gboolean {.
    importc: "g_pollable_input_stream_can_poll", libprag.}

proc canPoll*(self: PollableInputStream): bool =
  toBool(g_pollable_input_stream_can_poll(cast[ptr PollableInputStream00](self.impl)))

proc g_pollable_input_stream_create_source*(self: ptr PollableInputStream00; cancellable: ptr Cancellable00): ptr glib.Source00 {.
    importc: "g_pollable_input_stream_create_source", libprag.}

proc createSource*(self: PollableInputStream; cancellable: Cancellable): glib.Source =
  new(result)
  result.impl = g_pollable_input_stream_create_source(cast[ptr PollableInputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_pollable_input_stream_is_readable*(self: ptr PollableInputStream00): gboolean {.
    importc: "g_pollable_input_stream_is_readable", libprag.}

proc isReadable*(self: PollableInputStream): bool =
  toBool(g_pollable_input_stream_is_readable(cast[ptr PollableInputStream00](self.impl)))

proc g_pollable_input_stream_read_nonblocking*(self: ptr PollableInputStream00; buffer: uint8Array; 
    count: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_pollable_input_stream_read_nonblocking", libprag.}

proc readNonblocking*(self: PollableInputStream; buffer: uint8Array; count: uint64; 
    cancellable: Cancellable): int64 =
  g_pollable_input_stream_read_nonblocking(cast[ptr PollableInputStream00](self.impl), buffer, count, cast[ptr Cancellable00](cancellable.impl))

type
  PollableInputStreamInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    canPoll*: proc(stream: ptr PollableInputStream00): gboolean {.cdecl.}
    isReadable*: proc(stream: ptr PollableInputStream00): gboolean {.cdecl.}
    createSource*: proc(stream: ptr PollableInputStream00; cancellable: ptr Cancellable00): ptr glib.Source00 {.cdecl.}
    readNonblocking*: proc(stream: ptr PollableInputStream00; buffer: uint8Array; 
    count: uint64): int64 {.cdecl.}
  PollableInputStreamInterface* = ref object
    impl*: ptr PollableInputStreamInterface00

type
  PollableOutputStream00* {.pure.} = object
  PollableOutputStream* = ref object
    impl*: ptr PollableOutputStream00

proc g_pollable_output_stream_can_poll*(self: ptr PollableOutputStream00): gboolean {.
    importc: "g_pollable_output_stream_can_poll", libprag.}

proc canPoll*(self: PollableOutputStream): bool =
  toBool(g_pollable_output_stream_can_poll(cast[ptr PollableOutputStream00](self.impl)))

proc g_pollable_output_stream_create_source*(self: ptr PollableOutputStream00; cancellable: ptr Cancellable00): ptr glib.Source00 {.
    importc: "g_pollable_output_stream_create_source", libprag.}

proc createSource*(self: PollableOutputStream; cancellable: Cancellable): glib.Source =
  new(result)
  result.impl = g_pollable_output_stream_create_source(cast[ptr PollableOutputStream00](self.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_pollable_output_stream_is_writable*(self: ptr PollableOutputStream00): gboolean {.
    importc: "g_pollable_output_stream_is_writable", libprag.}

proc isWritable*(self: PollableOutputStream): bool =
  toBool(g_pollable_output_stream_is_writable(cast[ptr PollableOutputStream00](self.impl)))

proc g_pollable_output_stream_write_nonblocking*(self: ptr PollableOutputStream00; buffer: uint8Array; 
    count: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_pollable_output_stream_write_nonblocking", libprag.}

proc writeNonblocking*(self: PollableOutputStream; buffer: uint8Array; count: uint64; 
    cancellable: Cancellable): int64 =
  g_pollable_output_stream_write_nonblocking(cast[ptr PollableOutputStream00](self.impl), buffer, count, cast[ptr Cancellable00](cancellable.impl))

type
  PollableOutputStreamInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    canPoll*: proc(stream: ptr PollableOutputStream00): gboolean {.cdecl.}
    isWritable*: proc(stream: ptr PollableOutputStream00): gboolean {.cdecl.}
    createSource*: proc(stream: ptr PollableOutputStream00; cancellable: ptr Cancellable00): ptr glib.Source00 {.cdecl.}
    writeNonblocking*: proc(stream: ptr PollableOutputStream00; buffer: uint8Array; 
    count: uint64): int64 {.cdecl.}
  PollableOutputStreamInterface* = ref object
    impl*: ptr PollableOutputStreamInterface00

type
  PollableSourceFunc* = proc (pollableStream: ptr gobject.Object00; userData: pointer): gboolean {.cdecl.}

type
  PropertyAction* = ref object of gobject.Object
  PropertyAction00* = object of gobject.Object00

proc g_property_action_new*(name: cstring; `object`: ptr gobject.Object00; propertyName: cstring): ptr PropertyAction00 {.
    importc: "g_property_action_new", libprag.}

proc newPropertyAction*(name: string; `object`: gobject.Object; propertyName: string): PropertyAction =
  new(result, finalizeGObject)
  result.impl = g_property_action_new(cstring(name), cast[ptr gobject.Object00](`object`.impl), cstring(propertyName))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initPropertyAction*[T](result: var T; name: string; `object`: gobject.Object; propertyName: string) =
  assert(result is PropertyAction)
  new(result, finalizeGObject)
  result.impl = g_property_action_new(cstring(name), cast[ptr gobject.Object00](`object`.impl), cstring(propertyName))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  Proxy00* {.pure.} = object
  Proxy* = ref object
    impl*: ptr Proxy00

proc g_proxy_get_default_for_protocol*(protocol: cstring): ptr Proxy00 {.
    importc: "g_proxy_get_default_for_protocol", libprag.}

proc getDefaultForProtocol*(protocol: string): Proxy =
  new(result)
  result.impl = g_proxy_get_default_for_protocol(cstring(protocol))

proc defaultForProtocol*(protocol: string): Proxy =
  new(result)
  result.impl = g_proxy_get_default_for_protocol(cstring(protocol))

proc g_proxy_connect_finish*(self: ptr Proxy00; resu: ptr AsyncResult00): ptr IOStream00 {.
    importc: "g_proxy_connect_finish", libprag.}

proc connectFinish*(self: Proxy; resu: AsyncResult): IOStream =
  let gobj = g_proxy_connect_finish(cast[ptr Proxy00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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

proc g_proxy_supports_hostname*(self: ptr Proxy00): gboolean {.
    importc: "g_proxy_supports_hostname", libprag.}

proc supportsHostname*(self: Proxy): bool =
  toBool(g_proxy_supports_hostname(cast[ptr Proxy00](self.impl)))

type
  ProxyAddressPrivate00* {.pure.} = object
  ProxyAddressPrivate* = ref object
    impl*: ptr ProxyAddressPrivate00

type
  ProxyAddress* = ref object of InetSocketAddress
  ProxyAddress00* = object of InetSocketAddress00
    priv3: ptr ProxyAddressPrivate00

proc g_proxy_address_new*(inetaddr: ptr InetAddress00; port: uint16; protocol: cstring; 
    destHostname: cstring; destPort: uint16; username: cstring; password: cstring): ptr ProxyAddress00 {.
    importc: "g_proxy_address_new", libprag.}

proc newProxyAddress*(inetaddr: InetAddress; port: uint16; protocol: string; 
    destHostname: string; destPort: uint16; username: string; password: string): ProxyAddress =
  new(result, finalizeGObject)
  result.impl = g_proxy_address_new(cast[ptr InetAddress00](inetaddr.impl), port, cstring(protocol), cstring(destHostname), destPort, cstring(username), cstring(password))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initProxyAddress*[T](result: var T; inetaddr: InetAddress; port: uint16; protocol: string; 
    destHostname: string; destPort: uint16; username: string; password: string) =
  assert(result is ProxyAddress)
  new(result, finalizeGObject)
  result.impl = g_proxy_address_new(cast[ptr InetAddress00](inetaddr.impl), port, cstring(protocol), cstring(destHostname), destPort, cstring(username), cstring(password))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_proxy_address_get_destination_hostname*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_destination_hostname", libprag.}

proc getDestinationHostname*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_destination_hostname(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc destinationHostname*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_destination_hostname(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_address_get_destination_port*(self: ptr ProxyAddress00): uint16 {.
    importc: "g_proxy_address_get_destination_port", libprag.}

proc getDestinationPort*(self: ProxyAddress): uint16 =
  g_proxy_address_get_destination_port(cast[ptr ProxyAddress00](self.impl))

proc destinationPort*(self: ProxyAddress): uint16 =
  g_proxy_address_get_destination_port(cast[ptr ProxyAddress00](self.impl))

proc g_proxy_address_get_destination_protocol*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_destination_protocol", libprag.}

proc getDestinationProtocol*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_destination_protocol(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc destinationProtocol*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_destination_protocol(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_address_get_password*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_password", libprag.}

proc getPassword*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_password(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc password*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_password(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_address_get_protocol*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_protocol", libprag.}

proc getProtocol*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_protocol(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc protocol*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_protocol(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_address_get_uri*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_uri", libprag.}

proc getUri*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_uri(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc uri*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_uri(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_address_get_username*(self: ptr ProxyAddress00): cstring {.
    importc: "g_proxy_address_get_username", libprag.}

proc getUsername*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_username(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc username*(self: ProxyAddress): string =
  let resul0 = g_proxy_address_get_username(cast[ptr ProxyAddress00](self.impl))
  result = $resul0

proc g_proxy_connect*(self: ptr Proxy00; connection: ptr IOStream00; proxyAddress: ptr ProxyAddress00; 
    cancellable: ptr Cancellable00): ptr IOStream00 {.
    importc: "g_proxy_connect", libprag.}

proc connect*(self: Proxy; connection: IOStream; proxyAddress: ProxyAddress; 
    cancellable: Cancellable): IOStream =
  let gobj = g_proxy_connect(cast[ptr Proxy00](self.impl), cast[ptr IOStream00](connection.impl), cast[ptr ProxyAddress00](proxyAddress.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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

proc g_proxy_connect_async*(self: ptr Proxy00; connection: ptr IOStream00; proxyAddress: ptr ProxyAddress00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_proxy_connect_async", libprag.}

proc connectAsync*(self: Proxy; connection: IOStream; proxyAddress: ProxyAddress; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_proxy_connect_async(cast[ptr Proxy00](self.impl), cast[ptr IOStream00](connection.impl), cast[ptr ProxyAddress00](proxyAddress.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  ProxyAddressClass00* {.pure.} = object
    parentClass*: InetSocketAddressClass00
  ProxyAddressClass* = ref object
    impl*: ptr ProxyAddressClass00

type
  ProxyAddressEnumeratorPrivate00* {.pure.} = object
  ProxyAddressEnumeratorPrivate* = ref object
    impl*: ptr ProxyAddressEnumeratorPrivate00

type
  ProxyAddressEnumerator* = ref object of SocketAddressEnumerator
  ProxyAddressEnumerator00* = object of SocketAddressEnumerator00
    priv2: ptr ProxyAddressEnumeratorPrivate00

type
  SocketAddressEnumeratorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    next*: proc(enumerator: ptr SocketAddressEnumerator00; cancellable: ptr Cancellable00): ptr SocketAddress00 {.cdecl.}
    nextAsync*: proc(enumerator: ptr SocketAddressEnumerator00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    nextFinish*: proc(enumerator: ptr SocketAddressEnumerator00; resu: ptr AsyncResult00): ptr SocketAddress00 {.cdecl.}
  SocketAddressEnumeratorClass* = ref object
    impl*: ptr SocketAddressEnumeratorClass00

type
  ProxyAddressEnumeratorClass00* {.pure.} = object
    parentClass*: SocketAddressEnumeratorClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
  ProxyAddressEnumeratorClass* = ref object
    impl*: ptr ProxyAddressEnumeratorClass00

type
  ProxyInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    connect*: proc(proxy: ptr Proxy00; connection: ptr IOStream00; proxyAddress: ptr ProxyAddress00; 
    cancellable: ptr Cancellable00): ptr IOStream00 {.cdecl.}
    connectAsync*: proc(proxy: ptr Proxy00; connection: ptr IOStream00; proxyAddress: ptr ProxyAddress00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    connectFinish*: proc(proxy: ptr Proxy00; resu: ptr AsyncResult00): ptr IOStream00 {.cdecl.}
    supportsHostname*: proc(proxy: ptr Proxy00): gboolean {.cdecl.}
  ProxyInterface* = ref object
    impl*: ptr ProxyInterface00

type
  ProxyResolver00* {.pure.} = object
  ProxyResolver* = ref object
    impl*: ptr ProxyResolver00

proc g_proxy_resolver_get_default*(): ptr ProxyResolver00 {.
    importc: "g_proxy_resolver_get_default", libprag.}

proc getDefault*(): ProxyResolver =
  new(result)
  result.impl = g_proxy_resolver_get_default()

proc default*(): ProxyResolver =
  new(result)
  result.impl = g_proxy_resolver_get_default()

proc g_proxy_resolver_is_supported*(self: ptr ProxyResolver00): gboolean {.
    importc: "g_proxy_resolver_is_supported", libprag.}

proc isSupported*(self: ProxyResolver): bool =
  toBool(g_proxy_resolver_is_supported(cast[ptr ProxyResolver00](self.impl)))

proc g_proxy_resolver_lookup*(self: ptr ProxyResolver00; uri: cstring; cancellable: ptr Cancellable00): cstringArray {.
    importc: "g_proxy_resolver_lookup", libprag.}

proc lookup*(self: ProxyResolver; uri: string; cancellable: Cancellable): cstringArray =
  g_proxy_resolver_lookup(cast[ptr ProxyResolver00](self.impl), cstring(uri), cast[ptr Cancellable00](cancellable.impl))

proc g_proxy_resolver_lookup_async*(self: ptr ProxyResolver00; uri: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_proxy_resolver_lookup_async", libprag.}

proc lookupAsync*(self: ProxyResolver; uri: string; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_proxy_resolver_lookup_async(cast[ptr ProxyResolver00](self.impl), cstring(uri), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_proxy_resolver_lookup_finish*(self: ptr ProxyResolver00; resu: ptr AsyncResult00): cstringArray {.
    importc: "g_proxy_resolver_lookup_finish", libprag.}

proc lookupFinish*(self: ProxyResolver; resu: AsyncResult): cstringArray =
  g_proxy_resolver_lookup_finish(cast[ptr ProxyResolver00](self.impl), cast[ptr AsyncResult00](resu.impl))

type
  ProxyResolverInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    isSupported*: proc(resolver: ptr ProxyResolver00): gboolean {.cdecl.}
    lookup*: proc(resolver: ptr ProxyResolver00; uri: cstring; cancellable: ptr Cancellable00): cstringArray {.cdecl.}
    lookupAsync*: proc(resolver: ptr ProxyResolver00; uri: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupFinish*: proc(resolver: ptr ProxyResolver00; resu: ptr AsyncResult00): cstringArray {.cdecl.}
  ProxyResolverInterface* = ref object
    impl*: ptr ProxyResolverInterface00

type
  ReallocFunc* = proc (data: pointer; size: uint64): pointer {.cdecl.}

type
  RemoteActionGroup00* {.pure.} = object
  RemoteActionGroup* = ref object
    impl*: ptr RemoteActionGroup00

proc g_remote_action_group_activate_action_full*(self: ptr RemoteActionGroup00; actionName: cstring; 
    parameter: ptr glib.Variant00; platformData: ptr glib.Variant00) {.
    importc: "g_remote_action_group_activate_action_full", libprag.}

proc activateActionFull*(self: RemoteActionGroup; actionName: string; parameter: glib.Variant; 
    platformData: glib.Variant) =
  g_remote_action_group_activate_action_full(cast[ptr RemoteActionGroup00](self.impl), cstring(actionName), cast[ptr glib.Variant00](parameter.impl), cast[ptr glib.Variant00](platformData.impl))

proc g_remote_action_group_change_action_state_full*(self: ptr RemoteActionGroup00; actionName: cstring; 
    value: ptr glib.Variant00; platformData: ptr glib.Variant00) {.
    importc: "g_remote_action_group_change_action_state_full", libprag.}

proc changeActionStateFull*(self: RemoteActionGroup; actionName: string; value: glib.Variant; 
    platformData: glib.Variant) =
  g_remote_action_group_change_action_state_full(cast[ptr RemoteActionGroup00](self.impl), cstring(actionName), cast[ptr glib.Variant00](value.impl), cast[ptr glib.Variant00](platformData.impl))

type
  RemoteActionGroupInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    activateActionFull*: proc(remote: ptr RemoteActionGroup00; actionName: cstring; 
    parameter: ptr glib.Variant00; platformData: ptr glib.Variant00) {.cdecl.}
    changeActionStateFull*: proc(remote: ptr RemoteActionGroup00; actionName: cstring; 
    value: ptr glib.Variant00; platformData: ptr glib.Variant00) {.cdecl.}
  RemoteActionGroupInterface* = ref object
    impl*: ptr RemoteActionGroupInterface00

type
  ResolverPrivate00* {.pure.} = object
  ResolverPrivate* = ref object
    impl*: ptr ResolverPrivate00

type
  Resolver* = ref object of gobject.Object
  Resolver00* = object of gobject.Object00
    priv1: ptr ResolverPrivate00

proc scReload*(self: Resolver;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "reload", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_resolver_get_default*(): ptr Resolver00 {.
    importc: "g_resolver_get_default", libprag.}

proc getDefault*(): Resolver =
  let gobj = g_resolver_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Resolver](g_object_get_qdata(gobj, Quark))
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

proc default*(): Resolver =
  let gobj = g_resolver_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Resolver](g_object_get_qdata(gobj, Quark))
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

proc g_resolver_lookup_by_address*(self: ptr Resolver00; address: ptr InetAddress00; 
    cancellable: ptr Cancellable00): cstring {.
    importc: "g_resolver_lookup_by_address", libprag.}

proc lookupByAddress*(self: Resolver; address: InetAddress; cancellable: Cancellable): string =
  let resul0 = g_resolver_lookup_by_address(cast[ptr Resolver00](self.impl), cast[ptr InetAddress00](address.impl), cast[ptr Cancellable00](cancellable.impl))
  result = $resul0
  cogfree(resul0)

proc g_resolver_lookup_by_address_async*(self: ptr Resolver00; address: ptr InetAddress00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_resolver_lookup_by_address_async", libprag.}

proc lookupByAddressAsync*(self: Resolver; address: InetAddress; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_resolver_lookup_by_address_async(cast[ptr Resolver00](self.impl), cast[ptr InetAddress00](address.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_resolver_lookup_by_address_finish*(self: ptr Resolver00; resu: ptr AsyncResult00): cstring {.
    importc: "g_resolver_lookup_by_address_finish", libprag.}

proc lookupByAddressFinish*(self: Resolver; resu: AsyncResult): string =
  let resul0 = g_resolver_lookup_by_address_finish(cast[ptr Resolver00](self.impl), cast[ptr AsyncResult00](resu.impl))
  result = $resul0
  cogfree(resul0)

proc g_resolver_lookup_by_name*(self: ptr Resolver00; hostname: cstring; cancellable: ptr Cancellable00): ptr pointer {.
    importc: "g_resolver_lookup_by_name", libprag.}

proc lookupByName*(self: Resolver; hostname: string; cancellable: Cancellable): ptr pointer =
  g_resolver_lookup_by_name(cast[ptr Resolver00](self.impl), cstring(hostname), cast[ptr Cancellable00](cancellable.impl))

proc g_resolver_lookup_by_name_async*(self: ptr Resolver00; hostname: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_resolver_lookup_by_name_async", libprag.}

proc lookupByNameAsync*(self: Resolver; hostname: string; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_resolver_lookup_by_name_async(cast[ptr Resolver00](self.impl), cstring(hostname), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_resolver_lookup_by_name_finish*(self: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.
    importc: "g_resolver_lookup_by_name_finish", libprag.}

proc lookupByNameFinish*(self: Resolver; resu: AsyncResult): ptr pointer =
  g_resolver_lookup_by_name_finish(cast[ptr Resolver00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_resolver_lookup_records_finish*(self: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.
    importc: "g_resolver_lookup_records_finish", libprag.}

proc lookupRecordsFinish*(self: Resolver; resu: AsyncResult): ptr pointer =
  g_resolver_lookup_records_finish(cast[ptr Resolver00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_resolver_lookup_service*(self: ptr Resolver00; service: cstring; protocol: cstring; 
    domain: cstring; cancellable: ptr Cancellable00): ptr pointer {.
    importc: "g_resolver_lookup_service", libprag.}

proc lookupService*(self: Resolver; service: string; protocol: string; 
    domain: string; cancellable: Cancellable): ptr pointer =
  g_resolver_lookup_service(cast[ptr Resolver00](self.impl), cstring(service), cstring(protocol), cstring(domain), cast[ptr Cancellable00](cancellable.impl))

proc g_resolver_lookup_service_async*(self: ptr Resolver00; service: cstring; protocol: cstring; 
    domain: cstring; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_resolver_lookup_service_async", libprag.}

proc lookupServiceAsync*(self: Resolver; service: string; protocol: string; 
    domain: string; cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_resolver_lookup_service_async(cast[ptr Resolver00](self.impl), cstring(service), cstring(protocol), cstring(domain), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_resolver_lookup_service_finish*(self: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.
    importc: "g_resolver_lookup_service_finish", libprag.}

proc lookupServiceFinish*(self: Resolver; resu: AsyncResult): ptr pointer =
  g_resolver_lookup_service_finish(cast[ptr Resolver00](self.impl), cast[ptr AsyncResult00](resu.impl))

proc g_resolver_set_default*(self: ptr Resolver00) {.
    importc: "g_resolver_set_default", libprag.}

proc setDefault*(self: Resolver) =
  g_resolver_set_default(cast[ptr Resolver00](self.impl))

proc `default=`*(self: Resolver) =
  g_resolver_set_default(cast[ptr Resolver00](self.impl))

type
  ResolverRecordType* {.size: sizeof(cint), pure.} = enum
    srv = 1
    mx = 2
    txt = 3
    soa = 4
    ns = 5

proc g_resolver_lookup_records*(self: ptr Resolver00; rrname: cstring; recordType: ResolverRecordType; 
    cancellable: ptr Cancellable00): ptr pointer {.
    importc: "g_resolver_lookup_records", libprag.}

proc lookupRecords*(self: Resolver; rrname: string; recordType: ResolverRecordType; 
    cancellable: Cancellable): ptr pointer =
  g_resolver_lookup_records(cast[ptr Resolver00](self.impl), cstring(rrname), recordType, cast[ptr Cancellable00](cancellable.impl))

proc g_resolver_lookup_records_async*(self: ptr Resolver00; rrname: cstring; recordType: ResolverRecordType; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_resolver_lookup_records_async", libprag.}

proc lookupRecordsAsync*(self: Resolver; rrname: string; recordType: ResolverRecordType; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_resolver_lookup_records_async(cast[ptr Resolver00](self.impl), cstring(rrname), recordType, cast[ptr Cancellable00](cancellable.impl), callback, userData)

type
  ResolverClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    reload*: proc(resolver: ptr Resolver00) {.cdecl.}
    lookupByName*: proc(resolver: ptr Resolver00; hostname: cstring; cancellable: ptr Cancellable00): ptr pointer {.cdecl.}
    lookupByNameAsync*: proc(resolver: ptr Resolver00; hostname: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupByNameFinish*: proc(resolver: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.cdecl.}
    lookupByAddress*: proc(resolver: ptr Resolver00; address: ptr InetAddress00; 
    cancellable: ptr Cancellable00): cstring {.cdecl.}
    lookupByAddressAsync*: proc(resolver: ptr Resolver00; address: ptr InetAddress00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupByAddressFinish*: proc(resolver: ptr Resolver00; resu: ptr AsyncResult00): cstring {.cdecl.}
    lookupService*: pointer
    lookupServiceAsync*: proc(resolver: ptr Resolver00; rrname: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupServiceFinish*: proc(resolver: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.cdecl.}
    lookupRecords*: proc(resolver: ptr Resolver00; rrname: cstring; recordType: ResolverRecordType; 
    cancellable: ptr Cancellable00): ptr pointer {.cdecl.}
    lookupRecordsAsync*: proc(resolver: ptr Resolver00; rrname: cstring; recordType: ResolverRecordType; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupRecordsFinish*: proc(resolver: ptr Resolver00; resu: ptr AsyncResult00): ptr pointer {.cdecl.}
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  ResolverClass* = ref object
    impl*: ptr ResolverClass00

type
  ResolverError* {.size: sizeof(cint), pure.} = enum
    notFound = 0
    temporaryFailure = 1
    internal = 2

proc g_resolver_error_quark*(): uint32 {.
    importc: "g_resolver_error_quark", libprag.}

type
  Resource00* {.pure.} = object
  Resource* = ref object
    impl*: ptr Resource00

proc g_resource_new_from_data*(data: ptr glib.Bytes00): ptr Resource00 {.
    importc: "g_resource_new_from_data", libprag.}

proc newResourceFromData*(data: glib.Bytes): Resource =
  new(result)
  result.impl = g_resource_new_from_data(cast[ptr glib.Bytes00](data.impl))

proc initResourceFromData*[T](result: var T; data: glib.Bytes) =
  assert(result is Resource)
  new(result)
  result.impl = g_resource_new_from_data(cast[ptr glib.Bytes00](data.impl))

proc g_resources_register*(self: ptr Resource00) {.
    importc: "g_resources_register", libprag.}

proc register*(self: Resource) =
  g_resources_register(cast[ptr Resource00](self.impl))

proc g_resources_unregister*(self: ptr Resource00) {.
    importc: "g_resources_unregister", libprag.}

proc unregister*(self: Resource) =
  g_resources_unregister(cast[ptr Resource00](self.impl))

proc g_resource_ref*(self: ptr Resource00): ptr Resource00 {.
    importc: "g_resource_ref", libprag.}

proc `ref`*(self: Resource): Resource =
  new(result)
  result.impl = g_resource_ref(cast[ptr Resource00](self.impl))

proc g_resource_unref*(self: ptr Resource00) {.
    importc: "g_resource_unref", libprag.}

proc unref*(self: Resource) =
  g_resource_unref(cast[ptr Resource00](self.impl))

proc g_resource_load*(filename: ucstring): ptr Resource00 {.
    importc: "g_resource_load", libprag.}

proc load*(filename: ucstring): Resource =
  new(result)
  result.impl = g_resource_load(filename)

type
  ResourceLookupFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

proc g_resource_enumerate_children*(self: ptr Resource00; path: cstring; lookupFlags: ResourceLookupFlags): cstringArray {.
    importc: "g_resource_enumerate_children", libprag.}

proc enumerateChildren*(self: Resource; path: string; lookupFlags: ResourceLookupFlags): cstringArray =
  g_resource_enumerate_children(cast[ptr Resource00](self.impl), cstring(path), lookupFlags)

proc g_resource_get_info*(self: ptr Resource00; path: cstring; lookupFlags: ResourceLookupFlags; 
    size: var uint64; flags: var uint32): gboolean {.
    importc: "g_resource_get_info", libprag.}

proc getInfo*(self: Resource; path: string; lookupFlags: ResourceLookupFlags; 
    size: var uint64; flags: var int): bool =
  var flags_00 = uint32(flags)
  result = toBool(g_resource_get_info(cast[ptr Resource00](self.impl), cstring(path), lookupFlags, size, flags_00))
  flags = int(flags_00)

proc info*(self: Resource; path: string; lookupFlags: ResourceLookupFlags; 
    size: var uint64; flags: var int): bool =
  var flags_00 = uint32(flags)
  result = toBool(g_resource_get_info(cast[ptr Resource00](self.impl), cstring(path), lookupFlags, size, flags_00))
  flags = int(flags_00)

proc g_resource_lookup_data*(self: ptr Resource00; path: cstring; lookupFlags: ResourceLookupFlags): ptr glib.Bytes00 {.
    importc: "g_resource_lookup_data", libprag.}

proc lookupData*(self: Resource; path: string; lookupFlags: ResourceLookupFlags): glib.Bytes =
  new(result)
  result.impl = g_resource_lookup_data(cast[ptr Resource00](self.impl), cstring(path), lookupFlags)

proc g_resource_open_stream*(self: ptr Resource00; path: cstring; lookupFlags: ResourceLookupFlags): ptr InputStream00 {.
    importc: "g_resource_open_stream", libprag.}

proc openStream*(self: Resource; path: string; lookupFlags: ResourceLookupFlags): InputStream =
  let gobj = g_resource_open_stream(cast[ptr Resource00](self.impl), cstring(path), lookupFlags)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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
  ResourceError* {.size: sizeof(cint), pure.} = enum
    notFound = 0
    internal = 1

proc g_resource_error_quark*(): uint32 {.
    importc: "g_resource_error_quark", libprag.}

type
  ResourceFlag* {.size: sizeof(cint), pure.} = enum
    compressed = 1

  ResourceFlags* {.size: sizeof(cint).} = set[ResourceFlag]

type
  Seekable00* {.pure.} = object
  Seekable* = ref object
    impl*: ptr Seekable00

proc g_seekable_can_seek*(self: ptr Seekable00): gboolean {.
    importc: "g_seekable_can_seek", libprag.}

proc canSeek*(self: Seekable): bool =
  toBool(g_seekable_can_seek(cast[ptr Seekable00](self.impl)))

proc g_seekable_can_truncate*(self: ptr Seekable00): gboolean {.
    importc: "g_seekable_can_truncate", libprag.}

proc canTruncate*(self: Seekable): bool =
  toBool(g_seekable_can_truncate(cast[ptr Seekable00](self.impl)))

proc g_seekable_seek*(self: ptr Seekable00; offset: int64; `type`: glib.SeekType; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_seekable_seek", libprag.}

proc seek*(self: Seekable; offset: int64; `type`: glib.SeekType; 
    cancellable: Cancellable): bool =
  toBool(g_seekable_seek(cast[ptr Seekable00](self.impl), offset, `type`, cast[ptr Cancellable00](cancellable.impl)))

proc g_seekable_tell*(self: ptr Seekable00): int64 {.
    importc: "g_seekable_tell", libprag.}

proc tell*(self: Seekable): int64 =
  g_seekable_tell(cast[ptr Seekable00](self.impl))

proc g_seekable_truncate*(self: ptr Seekable00; offset: int64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_seekable_truncate", libprag.}

proc truncate*(self: Seekable; offset: int64; cancellable: Cancellable): bool =
  toBool(g_seekable_truncate(cast[ptr Seekable00](self.impl), offset, cast[ptr Cancellable00](cancellable.impl)))

type
  SeekableIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    tell*: proc(seekable: ptr Seekable00): int64 {.cdecl.}
    canSeek*: proc(seekable: ptr Seekable00): gboolean {.cdecl.}
    seek*: proc(seekable: ptr Seekable00; offset: int64; `type`: glib.SeekType; 
    cancellable: ptr Cancellable00): gboolean {.cdecl.}
    canTruncate*: proc(seekable: ptr Seekable00): gboolean {.cdecl.}
    truncateFn*: proc(seekable: ptr Seekable00; offset: int64; cancellable: ptr Cancellable00): gboolean {.cdecl.}
  SeekableIface* = ref object
    impl*: ptr SeekableIface00

type
  SettingsPrivate00* {.pure.} = object
  SettingsPrivate* = ref object
    impl*: ptr SettingsPrivate00

type
  Settings* = ref object of gobject.Object
  Settings00* = object of gobject.Object00
    priv1: ptr SettingsPrivate00

proc scChangeEvent*(self: Settings;  p: proc (self: ptr gobject.Object00; keys: uint32Array; nKeys: int32; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "change-event", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scChanged*(self: Settings;  p: proc (self: ptr gobject.Object00; key: cstring; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scWritableChangeEvent*(self: Settings;  p: proc (self: ptr gobject.Object00; key: uint32; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "writable-change-event", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scWritableChanged*(self: Settings;  p: proc (self: ptr gobject.Object00; key: cstring; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "writable-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_settings_new*(schemaId: cstring): ptr Settings00 {.
    importc: "g_settings_new", libprag.}

proc newSettings*(schemaId: string): Settings =
  new(result, finalizeGObject)
  result.impl = g_settings_new(cstring(schemaId))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettings*[T](result: var T; schemaId: string) =
  assert(result is Settings)
  new(result, finalizeGObject)
  result.impl = g_settings_new(cstring(schemaId))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_settings_new_with_path*(schemaId: cstring; path: cstring): ptr Settings00 {.
    importc: "g_settings_new_with_path", libprag.}

proc newSettingsWithPath*(schemaId: string; path: string): Settings =
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_path(cstring(schemaId), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettingsWithPath*[T](result: var T; schemaId: string; path: string) =
  assert(result is Settings)
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_path(cstring(schemaId), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_settings_list_relocatable_schemas*(): cstringArray {.
    importc: "g_settings_list_relocatable_schemas", libprag.}

proc listRelocatableSchemas*(): cstringArray {.
    importc: "g_settings_list_relocatable_schemas", libprag.}

proc g_settings_list_schemas*(): cstringArray {.
    importc: "g_settings_list_schemas", libprag.}

proc listSchemas*(): cstringArray {.
    importc: "g_settings_list_schemas", libprag.}

proc g_settings_sync*() {.
    importc: "g_settings_sync", libprag.}

proc sync*() {.
    importc: "g_settings_sync", libprag.}

proc g_settings_unbind*(`object`: ptr gobject.Object00; property: cstring) {.
    importc: "g_settings_unbind", libprag.}

proc unbind*(`object`: gobject.Object; property: string) =
  g_settings_unbind(cast[ptr gobject.Object00](`object`.impl), cstring(property))

proc g_settings_apply*(self: ptr Settings00) {.
    importc: "g_settings_apply", libprag.}

proc apply*(self: Settings) =
  g_settings_apply(cast[ptr Settings00](self.impl))

proc g_settings_bind_writable*(self: ptr Settings00; key: cstring; `object`: ptr gobject.Object00; 
    property: cstring; inverted: gboolean) {.
    importc: "g_settings_bind_writable", libprag.}

proc bindWritable*(self: Settings; key: string; `object`: gobject.Object; 
    property: string; inverted: bool) =
  g_settings_bind_writable(cast[ptr Settings00](self.impl), cstring(key), cast[ptr gobject.Object00](`object`.impl), cstring(property), gboolean(inverted))

proc g_settings_create_action*(self: ptr Settings00; key: cstring): ptr Action00 {.
    importc: "g_settings_create_action", libprag.}

proc createAction*(self: Settings; key: string): Action =
  new(result)
  result.impl = g_settings_create_action(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_delay*(self: ptr Settings00) {.
    importc: "g_settings_delay", libprag.}

proc delay*(self: Settings) =
  g_settings_delay(cast[ptr Settings00](self.impl))

proc g_settings_get_boolean*(self: ptr Settings00; key: cstring): gboolean {.
    importc: "g_settings_get_boolean", libprag.}

proc getBoolean*(self: Settings; key: string): bool =
  toBool(g_settings_get_boolean(cast[ptr Settings00](self.impl), cstring(key)))

proc boolean*(self: Settings; key: string): bool =
  toBool(g_settings_get_boolean(cast[ptr Settings00](self.impl), cstring(key)))

proc g_settings_get_child*(self: ptr Settings00; name: cstring): ptr Settings00 {.
    importc: "g_settings_get_child", libprag.}

proc getChild*(self: Settings; name: string): Settings =
  let gobj = g_settings_get_child(cast[ptr Settings00](self.impl), cstring(name))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Settings](g_object_get_qdata(gobj, Quark))
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

proc child*(self: Settings; name: string): Settings =
  let gobj = g_settings_get_child(cast[ptr Settings00](self.impl), cstring(name))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Settings](g_object_get_qdata(gobj, Quark))
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

proc g_settings_get_default_value*(self: ptr Settings00; key: cstring): ptr glib.Variant00 {.
    importc: "g_settings_get_default_value", libprag.}

proc getDefaultValue*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_default_value(cast[ptr Settings00](self.impl), cstring(key))

proc defaultValue*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_default_value(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_double*(self: ptr Settings00; key: cstring): cdouble {.
    importc: "g_settings_get_double", libprag.}

proc getDouble*(self: Settings; key: string): cdouble =
  g_settings_get_double(cast[ptr Settings00](self.impl), cstring(key))

proc double*(self: Settings; key: string): cdouble =
  g_settings_get_double(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_enum*(self: ptr Settings00; key: cstring): int32 {.
    importc: "g_settings_get_enum", libprag.}

proc getEnum*(self: Settings; key: string): int =
  int(g_settings_get_enum(cast[ptr Settings00](self.impl), cstring(key)))

proc g_settings_get_flags*(self: ptr Settings00; key: cstring): uint32 {.
    importc: "g_settings_get_flags", libprag.}

proc getFlags*(self: Settings; key: string): int =
  int(g_settings_get_flags(cast[ptr Settings00](self.impl), cstring(key)))

proc flags*(self: Settings; key: string): int =
  int(g_settings_get_flags(cast[ptr Settings00](self.impl), cstring(key)))

proc g_settings_get_has_unapplied*(self: ptr Settings00): gboolean {.
    importc: "g_settings_get_has_unapplied", libprag.}

proc getHasUnapplied*(self: Settings): bool =
  toBool(g_settings_get_has_unapplied(cast[ptr Settings00](self.impl)))

proc hasUnapplied*(self: Settings): bool =
  toBool(g_settings_get_has_unapplied(cast[ptr Settings00](self.impl)))

proc g_settings_get_int*(self: ptr Settings00; key: cstring): int32 {.
    importc: "g_settings_get_int", libprag.}

proc getInt*(self: Settings; key: string): int =
  int(g_settings_get_int(cast[ptr Settings00](self.impl), cstring(key)))

proc g_settings_get_int64*(self: ptr Settings00; key: cstring): int64 {.
    importc: "g_settings_get_int64", libprag.}

proc getInt64*(self: Settings; key: string): int64 =
  g_settings_get_int64(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_range*(self: ptr Settings00; key: cstring): ptr glib.Variant00 {.
    importc: "g_settings_get_range", libprag.}

proc getRange*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_range(cast[ptr Settings00](self.impl), cstring(key))

proc range*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_range(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_string*(self: ptr Settings00; key: cstring): cstring {.
    importc: "g_settings_get_string", libprag.}

proc getString*(self: Settings; key: string): string =
  let resul0 = g_settings_get_string(cast[ptr Settings00](self.impl), cstring(key))
  result = $resul0
  cogfree(resul0)

proc string*(self: Settings; key: string): string =
  let resul0 = g_settings_get_string(cast[ptr Settings00](self.impl), cstring(key))
  result = $resul0
  cogfree(resul0)

proc g_settings_get_strv*(self: ptr Settings00; key: cstring): cstringArray {.
    importc: "g_settings_get_strv", libprag.}

proc getStrv*(self: Settings; key: string): cstringArray =
  g_settings_get_strv(cast[ptr Settings00](self.impl), cstring(key))

proc strv*(self: Settings; key: string): cstringArray =
  g_settings_get_strv(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_uint*(self: ptr Settings00; key: cstring): uint32 {.
    importc: "g_settings_get_uint", libprag.}

proc getUint*(self: Settings; key: string): int =
  int(g_settings_get_uint(cast[ptr Settings00](self.impl), cstring(key)))

proc g_settings_get_uint64*(self: ptr Settings00; key: cstring): uint64 {.
    importc: "g_settings_get_uint64", libprag.}

proc getUint64*(self: Settings; key: string): uint64 =
  g_settings_get_uint64(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_user_value*(self: ptr Settings00; key: cstring): ptr glib.Variant00 {.
    importc: "g_settings_get_user_value", libprag.}

proc getUserValue*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_user_value(cast[ptr Settings00](self.impl), cstring(key))

proc userValue*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_user_value(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_get_value*(self: ptr Settings00; key: cstring): ptr glib.Variant00 {.
    importc: "g_settings_get_value", libprag.}

proc getValue*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_value(cast[ptr Settings00](self.impl), cstring(key))

proc value*(self: Settings; key: string): glib.Variant =
  new(result)
  result.impl = g_settings_get_value(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_is_writable*(self: ptr Settings00; name: cstring): gboolean {.
    importc: "g_settings_is_writable", libprag.}

proc isWritable*(self: Settings; name: string): bool =
  toBool(g_settings_is_writable(cast[ptr Settings00](self.impl), cstring(name)))

proc g_settings_list_children*(self: ptr Settings00): cstringArray {.
    importc: "g_settings_list_children", libprag.}

proc listChildren*(self: Settings): cstringArray =
  g_settings_list_children(cast[ptr Settings00](self.impl))

proc g_settings_list_keys*(self: ptr Settings00): cstringArray {.
    importc: "g_settings_list_keys", libprag.}

proc listKeys*(self: Settings): cstringArray =
  g_settings_list_keys(cast[ptr Settings00](self.impl))

proc g_settings_range_check*(self: ptr Settings00; key: cstring; value: ptr glib.Variant00): gboolean {.
    importc: "g_settings_range_check", libprag.}

proc rangeCheck*(self: Settings; key: string; value: glib.Variant): bool =
  toBool(g_settings_range_check(cast[ptr Settings00](self.impl), cstring(key), cast[ptr glib.Variant00](value.impl)))

proc g_settings_reset*(self: ptr Settings00; key: cstring) {.
    importc: "g_settings_reset", libprag.}

proc reset*(self: Settings; key: string) =
  g_settings_reset(cast[ptr Settings00](self.impl), cstring(key))

proc g_settings_revert*(self: ptr Settings00) {.
    importc: "g_settings_revert", libprag.}

proc revert*(self: Settings) =
  g_settings_revert(cast[ptr Settings00](self.impl))

proc g_settings_set_boolean*(self: ptr Settings00; key: cstring; value: gboolean): gboolean {.
    importc: "g_settings_set_boolean", libprag.}

proc setBoolean*(self: Settings; key: string; value: bool): bool =
  toBool(g_settings_set_boolean(cast[ptr Settings00](self.impl), cstring(key), gboolean(value)))

proc g_settings_set_double*(self: ptr Settings00; key: cstring; value: cdouble): gboolean {.
    importc: "g_settings_set_double", libprag.}

proc setDouble*(self: Settings; key: string; value: cdouble): bool =
  toBool(g_settings_set_double(cast[ptr Settings00](self.impl), cstring(key), value))

proc g_settings_set_enum*(self: ptr Settings00; key: cstring; value: int32): gboolean {.
    importc: "g_settings_set_enum", libprag.}

proc setEnum*(self: Settings; key: string; value: int): bool =
  toBool(g_settings_set_enum(cast[ptr Settings00](self.impl), cstring(key), int32(value)))

proc g_settings_set_flags*(self: ptr Settings00; key: cstring; value: uint32): gboolean {.
    importc: "g_settings_set_flags", libprag.}

proc setFlags*(self: Settings; key: string; value: int): bool =
  toBool(g_settings_set_flags(cast[ptr Settings00](self.impl), cstring(key), uint32(value)))

proc g_settings_set_int*(self: ptr Settings00; key: cstring; value: int32): gboolean {.
    importc: "g_settings_set_int", libprag.}

proc setInt*(self: Settings; key: string; value: int): bool =
  toBool(g_settings_set_int(cast[ptr Settings00](self.impl), cstring(key), int32(value)))

proc g_settings_set_int64*(self: ptr Settings00; key: cstring; value: int64): gboolean {.
    importc: "g_settings_set_int64", libprag.}

proc setInt64*(self: Settings; key: string; value: int64): bool =
  toBool(g_settings_set_int64(cast[ptr Settings00](self.impl), cstring(key), value))

proc g_settings_set_string*(self: ptr Settings00; key: cstring; value: cstring): gboolean {.
    importc: "g_settings_set_string", libprag.}

proc setString*(self: Settings; key: string; value: string): bool =
  toBool(g_settings_set_string(cast[ptr Settings00](self.impl), cstring(key), cstring(value)))

proc g_settings_set_strv*(self: ptr Settings00; key: cstring; value: cstringArray): gboolean {.
    importc: "g_settings_set_strv", libprag.}

proc setStrv*(self: Settings; key: string; value: cstringArray): bool =
  toBool(g_settings_set_strv(cast[ptr Settings00](self.impl), cstring(key), value))

proc g_settings_set_uint*(self: ptr Settings00; key: cstring; value: uint32): gboolean {.
    importc: "g_settings_set_uint", libprag.}

proc setUint*(self: Settings; key: string; value: int): bool =
  toBool(g_settings_set_uint(cast[ptr Settings00](self.impl), cstring(key), uint32(value)))

proc g_settings_set_uint64*(self: ptr Settings00; key: cstring; value: uint64): gboolean {.
    importc: "g_settings_set_uint64", libprag.}

proc setUint64*(self: Settings; key: string; value: uint64): bool =
  toBool(g_settings_set_uint64(cast[ptr Settings00](self.impl), cstring(key), value))

proc g_settings_set_value*(self: ptr Settings00; key: cstring; value: ptr glib.Variant00): gboolean {.
    importc: "g_settings_set_value", libprag.}

proc setValue*(self: Settings; key: string; value: glib.Variant): bool =
  toBool(g_settings_set_value(cast[ptr Settings00](self.impl), cstring(key), cast[ptr glib.Variant00](value.impl)))

type
  SettingsSchema00* {.pure.} = object
  SettingsSchema* = ref object
    impl*: ptr SettingsSchema00

proc g_settings_schema_get_id*(self: ptr SettingsSchema00): cstring {.
    importc: "g_settings_schema_get_id", libprag.}

proc getId*(self: SettingsSchema): string =
  let resul0 = g_settings_schema_get_id(cast[ptr SettingsSchema00](self.impl))
  result = $resul0

proc id*(self: SettingsSchema): string =
  let resul0 = g_settings_schema_get_id(cast[ptr SettingsSchema00](self.impl))
  result = $resul0

proc g_settings_schema_get_path*(self: ptr SettingsSchema00): cstring {.
    importc: "g_settings_schema_get_path", libprag.}

proc getPath*(self: SettingsSchema): string =
  let resul0 = g_settings_schema_get_path(cast[ptr SettingsSchema00](self.impl))
  result = $resul0

proc path*(self: SettingsSchema): string =
  let resul0 = g_settings_schema_get_path(cast[ptr SettingsSchema00](self.impl))
  result = $resul0

proc g_settings_schema_has_key*(self: ptr SettingsSchema00; name: cstring): gboolean {.
    importc: "g_settings_schema_has_key", libprag.}

proc hasKey*(self: SettingsSchema; name: string): bool =
  toBool(g_settings_schema_has_key(cast[ptr SettingsSchema00](self.impl), cstring(name)))

proc g_settings_schema_list_children*(self: ptr SettingsSchema00): cstringArray {.
    importc: "g_settings_schema_list_children", libprag.}

proc listChildren*(self: SettingsSchema): cstringArray =
  g_settings_schema_list_children(cast[ptr SettingsSchema00](self.impl))

proc g_settings_schema_list_keys*(self: ptr SettingsSchema00): cstringArray {.
    importc: "g_settings_schema_list_keys", libprag.}

proc listKeys*(self: SettingsSchema): cstringArray =
  g_settings_schema_list_keys(cast[ptr SettingsSchema00](self.impl))

proc g_settings_schema_ref*(self: ptr SettingsSchema00): ptr SettingsSchema00 {.
    importc: "g_settings_schema_ref", libprag.}

proc `ref`*(self: SettingsSchema): SettingsSchema =
  new(result)
  result.impl = g_settings_schema_ref(cast[ptr SettingsSchema00](self.impl))

proc g_settings_schema_unref*(self: ptr SettingsSchema00) {.
    importc: "g_settings_schema_unref", libprag.}

proc unref*(self: SettingsSchema) =
  g_settings_schema_unref(cast[ptr SettingsSchema00](self.impl))

type
  SettingsSchemaKey00* {.pure.} = object
  SettingsSchemaKey* = ref object
    impl*: ptr SettingsSchemaKey00

proc g_settings_schema_key_get_default_value*(self: ptr SettingsSchemaKey00): ptr glib.Variant00 {.
    importc: "g_settings_schema_key_get_default_value", libprag.}

proc getDefaultValue*(self: SettingsSchemaKey): glib.Variant =
  new(result)
  result.impl = g_settings_schema_key_get_default_value(cast[ptr SettingsSchemaKey00](self.impl))

proc defaultValue*(self: SettingsSchemaKey): glib.Variant =
  new(result)
  result.impl = g_settings_schema_key_get_default_value(cast[ptr SettingsSchemaKey00](self.impl))

proc g_settings_schema_key_get_description*(self: ptr SettingsSchemaKey00): cstring {.
    importc: "g_settings_schema_key_get_description", libprag.}

proc getDescription*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_description(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc description*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_description(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc g_settings_schema_key_get_name*(self: ptr SettingsSchemaKey00): cstring {.
    importc: "g_settings_schema_key_get_name", libprag.}

proc getName*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_name(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc name*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_name(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc g_settings_schema_key_get_range*(self: ptr SettingsSchemaKey00): ptr glib.Variant00 {.
    importc: "g_settings_schema_key_get_range", libprag.}

proc getRange*(self: SettingsSchemaKey): glib.Variant =
  new(result)
  result.impl = g_settings_schema_key_get_range(cast[ptr SettingsSchemaKey00](self.impl))

proc range*(self: SettingsSchemaKey): glib.Variant =
  new(result)
  result.impl = g_settings_schema_key_get_range(cast[ptr SettingsSchemaKey00](self.impl))

proc g_settings_schema_key_get_summary*(self: ptr SettingsSchemaKey00): cstring {.
    importc: "g_settings_schema_key_get_summary", libprag.}

proc getSummary*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_summary(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc summary*(self: SettingsSchemaKey): string =
  let resul0 = g_settings_schema_key_get_summary(cast[ptr SettingsSchemaKey00](self.impl))
  result = $resul0

proc g_settings_schema_key_get_value_type*(self: ptr SettingsSchemaKey00): ptr glib.VariantType00 {.
    importc: "g_settings_schema_key_get_value_type", libprag.}

proc getValueType*(self: SettingsSchemaKey): glib.VariantType =
  new(result)
  result.impl = g_settings_schema_key_get_value_type(cast[ptr SettingsSchemaKey00](self.impl))

proc valueType*(self: SettingsSchemaKey): glib.VariantType =
  new(result)
  result.impl = g_settings_schema_key_get_value_type(cast[ptr SettingsSchemaKey00](self.impl))

proc g_settings_schema_key_range_check*(self: ptr SettingsSchemaKey00; value: ptr glib.Variant00): gboolean {.
    importc: "g_settings_schema_key_range_check", libprag.}

proc rangeCheck*(self: SettingsSchemaKey; value: glib.Variant): bool =
  toBool(g_settings_schema_key_range_check(cast[ptr SettingsSchemaKey00](self.impl), cast[ptr glib.Variant00](value.impl)))

proc g_settings_schema_key_ref*(self: ptr SettingsSchemaKey00): ptr SettingsSchemaKey00 {.
    importc: "g_settings_schema_key_ref", libprag.}

proc `ref`*(self: SettingsSchemaKey): SettingsSchemaKey =
  new(result)
  result.impl = g_settings_schema_key_ref(cast[ptr SettingsSchemaKey00](self.impl))

proc g_settings_schema_key_unref*(self: ptr SettingsSchemaKey00) {.
    importc: "g_settings_schema_key_unref", libprag.}

proc unref*(self: SettingsSchemaKey) =
  g_settings_schema_key_unref(cast[ptr SettingsSchemaKey00](self.impl))

proc g_settings_schema_get_key*(self: ptr SettingsSchema00; name: cstring): ptr SettingsSchemaKey00 {.
    importc: "g_settings_schema_get_key", libprag.}

proc getKey*(self: SettingsSchema; name: string): SettingsSchemaKey =
  new(result)
  result.impl = g_settings_schema_get_key(cast[ptr SettingsSchema00](self.impl), cstring(name))

proc key*(self: SettingsSchema; name: string): SettingsSchemaKey =
  new(result)
  result.impl = g_settings_schema_get_key(cast[ptr SettingsSchema00](self.impl), cstring(name))

type
  SettingsBackend00* {.pure.} = object
  SettingsBackend* = ref object
    impl*: ptr SettingsBackend00

proc g_settings_new_full*(schema: ptr SettingsSchema00; backend: ptr SettingsBackend00; 
    path: cstring): ptr Settings00 {.
    importc: "g_settings_new_full", libprag.}

proc newSettingsFull*(schema: SettingsSchema; backend: SettingsBackend; 
    path: string): Settings =
  new(result, finalizeGObject)
  result.impl = g_settings_new_full(cast[ptr SettingsSchema00](schema.impl), cast[ptr SettingsBackend00](backend.impl), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettingsFull*[T](result: var T; schema: SettingsSchema; backend: SettingsBackend; 
    path: string) =
  assert(result is Settings)
  new(result, finalizeGObject)
  result.impl = g_settings_new_full(cast[ptr SettingsSchema00](schema.impl), cast[ptr SettingsBackend00](backend.impl), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_settings_new_with_backend*(schemaId: cstring; backend: ptr SettingsBackend00): ptr Settings00 {.
    importc: "g_settings_new_with_backend", libprag.}

proc newSettingsWithBackend*(schemaId: string; backend: SettingsBackend): Settings =
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_backend(cstring(schemaId), cast[ptr SettingsBackend00](backend.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettingsWithBackend*[T](result: var T; schemaId: string; backend: SettingsBackend) =
  assert(result is Settings)
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_backend(cstring(schemaId), cast[ptr SettingsBackend00](backend.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_settings_new_with_backend_and_path*(schemaId: cstring; backend: ptr SettingsBackend00; 
    path: cstring): ptr Settings00 {.
    importc: "g_settings_new_with_backend_and_path", libprag.}

proc newSettingsWithBackendAndPath*(schemaId: string; backend: SettingsBackend; path: string): Settings =
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_backend_and_path(cstring(schemaId), cast[ptr SettingsBackend00](backend.impl), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSettingsWithBackendAndPath*[T](result: var T; schemaId: string; backend: SettingsBackend; path: string) =
  assert(result is Settings)
  new(result, finalizeGObject)
  result.impl = g_settings_new_with_backend_and_path(cstring(schemaId), cast[ptr SettingsBackend00](backend.impl), cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SettingsBindFlag* {.size: sizeof(cint), pure.} = enum
    get = 1
    set = 2
    noSensitivity = 3
    getNoChanges = 4
    invertBoolean = 5

  SettingsBindFlags* {.size: sizeof(cint).} = set[SettingsBindFlag]

proc g_settings_bind*(self: ptr Settings00; key: cstring; `object`: ptr gobject.Object00; 
    property: cstring; flags: SettingsBindFlags) {.
    importc: "g_settings_bind", libprag.}

proc `bind`*(self: Settings; key: string; `object`: gobject.Object; 
    property: string; flags: SettingsBindFlags) =
  g_settings_bind(cast[ptr Settings00](self.impl), cstring(key), cast[ptr gobject.Object00](`object`.impl), cstring(property), flags)

type
  SettingsBindGetMapping* = proc (value: ptr gobject.Value00; variant: ptr glib.Variant00; 
    userData: pointer): gboolean {.cdecl.}

type
  SettingsBindSetMapping* = proc (value: ptr gobject.Value00; expectedType: ptr glib.VariantType00; 
    userData: pointer): ptr glib.Variant00 {.cdecl.}

type
  SettingsClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    writableChanged*: proc(settings: ptr Settings00; key: cstring) {.cdecl.}
    changed*: proc(settings: ptr Settings00; key: cstring) {.cdecl.}
    writableChangeEvent*: proc(settings: ptr Settings00; key: uint32): gboolean {.cdecl.}
    changeEvent*: proc(settings: ptr Settings00; keys: ptr uint32; nKeys: int32): gboolean {.cdecl.}
    padding*: array[20, pointer]
  SettingsClass* = ref object
    impl*: ptr SettingsClass00

type
  SettingsGetMapping* = proc (value: ptr glib.Variant00; resu: var pointer; userData: pointer): gboolean {.cdecl.}

proc g_settings_get_mapped*(self: ptr Settings00; key: cstring; mapping: SettingsGetMapping; 
    userData: pointer): pointer {.
    importc: "g_settings_get_mapped", libprag.}

proc getMapped*(self: Settings; key: string; mapping: SettingsGetMapping; 
    userData: pointer): pointer =
  g_settings_get_mapped(cast[ptr Settings00](self.impl), cstring(key), mapping, userData)

proc mapped*(self: Settings; key: string; mapping: SettingsGetMapping; 
    userData: pointer): pointer =
  g_settings_get_mapped(cast[ptr Settings00](self.impl), cstring(key), mapping, userData)

type
  SettingsSchemaSource00* {.pure.} = object
  SettingsSchemaSource* = ref object
    impl*: ptr SettingsSchemaSource00

proc g_settings_schema_source_new_from_directory*(directory: ucstring; parent: ptr SettingsSchemaSource00; 
    trusted: gboolean): ptr SettingsSchemaSource00 {.
    importc: "g_settings_schema_source_new_from_directory", libprag.}

proc newSettingsSchemaSourceFromDirectory*(directory: ucstring; parent: SettingsSchemaSource; 
    trusted: bool): SettingsSchemaSource =
  new(result)
  result.impl = g_settings_schema_source_new_from_directory(directory, cast[ptr SettingsSchemaSource00](parent.impl), gboolean(trusted))

proc initSettingsSchemaSourceFromDirectory*[T](result: var T; directory: ucstring; parent: SettingsSchemaSource; 
    trusted: bool) =
  assert(result is SettingsSchemaSource)
  new(result)
  result.impl = g_settings_schema_source_new_from_directory(directory, cast[ptr SettingsSchemaSource00](parent.impl), gboolean(trusted))

proc g_settings_schema_source_list_schemas*(self: ptr SettingsSchemaSource00; recursive: gboolean; 
    nonRelocatable: var cstringArray; relocatable: var cstringArray) {.
    importc: "g_settings_schema_source_list_schemas", libprag.}

proc listSchemas*(self: SettingsSchemaSource; recursive: bool; nonRelocatable: var cstringArray; 
    relocatable: var cstringArray) =
  g_settings_schema_source_list_schemas(cast[ptr SettingsSchemaSource00](self.impl), gboolean(recursive), nonRelocatable, relocatable)

proc g_settings_schema_source_lookup*(self: ptr SettingsSchemaSource00; schemaId: cstring; 
    recursive: gboolean): ptr SettingsSchema00 {.
    importc: "g_settings_schema_source_lookup", libprag.}

proc lookup*(self: SettingsSchemaSource; schemaId: string; recursive: bool): SettingsSchema =
  new(result)
  result.impl = g_settings_schema_source_lookup(cast[ptr SettingsSchemaSource00](self.impl), cstring(schemaId), gboolean(recursive))

proc g_settings_schema_source_ref*(self: ptr SettingsSchemaSource00): ptr SettingsSchemaSource00 {.
    importc: "g_settings_schema_source_ref", libprag.}

proc `ref`*(self: SettingsSchemaSource): SettingsSchemaSource =
  new(result)
  result.impl = g_settings_schema_source_ref(cast[ptr SettingsSchemaSource00](self.impl))

proc g_settings_schema_source_unref*(self: ptr SettingsSchemaSource00) {.
    importc: "g_settings_schema_source_unref", libprag.}

proc unref*(self: SettingsSchemaSource) =
  g_settings_schema_source_unref(cast[ptr SettingsSchemaSource00](self.impl))

proc g_settings_schema_source_get_default*(): ptr SettingsSchemaSource00 {.
    importc: "g_settings_schema_source_get_default", libprag.}

proc getDefault*(): SettingsSchemaSource =
  new(result)
  result.impl = g_settings_schema_source_get_default()

proc default*(): SettingsSchemaSource =
  new(result)
  result.impl = g_settings_schema_source_get_default()

type
  SimpleActionGroupPrivate00* {.pure.} = object
  SimpleActionGroupPrivate* = ref object
    impl*: ptr SimpleActionGroupPrivate00

type
  SimpleActionGroup* = ref object of gobject.Object
  SimpleActionGroup00* = object of gobject.Object00
    priv1: ptr SimpleActionGroupPrivate00

proc g_simple_action_group_new*(): ptr SimpleActionGroup00 {.
    importc: "g_simple_action_group_new", libprag.}

proc newSimpleActionGroup*(): SimpleActionGroup =
  new(result, finalizeGObject)
  result.impl = g_simple_action_group_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleActionGroup*[T](result: var T) =
  assert(result is SimpleActionGroup)
  new(result, finalizeGObject)
  result.impl = g_simple_action_group_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_simple_action_group_add_entries*(self: ptr SimpleActionGroup00; entries: ActionEntry00Array; 
    nEntries: int32; userData: pointer) {.
    importc: "g_simple_action_group_add_entries", libprag.}

proc addEntries*(self: SimpleActionGroup; entries: ActionEntry00Array; 
    nEntries: int; userData: pointer) =
  g_simple_action_group_add_entries(cast[ptr SimpleActionGroup00](self.impl), entries, int32(nEntries), userData)

proc g_simple_action_group_insert*(self: ptr SimpleActionGroup00; action: ptr Action00) {.
    importc: "g_simple_action_group_insert", libprag.}

proc insert*(self: SimpleActionGroup; action: Action) =
  g_simple_action_group_insert(cast[ptr SimpleActionGroup00](self.impl), cast[ptr Action00](action.impl))

proc g_simple_action_group_lookup*(self: ptr SimpleActionGroup00; actionName: cstring): ptr Action00 {.
    importc: "g_simple_action_group_lookup", libprag.}

proc lookup*(self: SimpleActionGroup; actionName: string): Action =
  new(result)
  result.impl = g_simple_action_group_lookup(cast[ptr SimpleActionGroup00](self.impl), cstring(actionName))

proc g_simple_action_group_remove*(self: ptr SimpleActionGroup00; actionName: cstring) {.
    importc: "g_simple_action_group_remove", libprag.}

proc remove*(self: SimpleActionGroup; actionName: string) =
  g_simple_action_group_remove(cast[ptr SimpleActionGroup00](self.impl), cstring(actionName))

type
  SimpleActionGroupClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    padding*: array[12, pointer]
  SimpleActionGroupClass* = ref object
    impl*: ptr SimpleActionGroupClass00

type
  SimpleAsyncResult* = ref object of gobject.Object
  SimpleAsyncResult00* = object of gobject.Object00

proc g_simple_async_result_new*(sourceObject: ptr gobject.Object00; callback: AsyncReadyCallback; 
    userData: pointer; sourceTag: pointer): ptr SimpleAsyncResult00 {.
    importc: "g_simple_async_result_new", libprag.}

proc newSimpleAsyncResult*(sourceObject: gobject.Object; callback: AsyncReadyCallback; 
    userData: pointer; sourceTag: pointer): SimpleAsyncResult =
  new(result, finalizeGObject)
  result.impl = g_simple_async_result_new(cast[ptr gobject.Object00](sourceObject.impl), callback, userData, sourceTag)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleAsyncResult*[T](result: var T; sourceObject: gobject.Object; callback: AsyncReadyCallback; 
    userData: pointer; sourceTag: pointer) =
  assert(result is SimpleAsyncResult)
  new(result, finalizeGObject)
  result.impl = g_simple_async_result_new(cast[ptr gobject.Object00](sourceObject.impl), callback, userData, sourceTag)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_simple_async_result_new_from_error*(sourceObject: ptr gobject.Object00; callback: AsyncReadyCallback; 
    userData: pointer; error: ptr Error00): ptr SimpleAsyncResult00 {.
    importc: "g_simple_async_result_new_from_error", libprag.}

proc newSimpleAsyncResultFromError*(sourceObject: gobject.Object; callback: AsyncReadyCallback; 
    userData: pointer; error: ptr Error00): SimpleAsyncResult =
  new(result, finalizeGObject)
  result.impl = g_simple_async_result_new_from_error(cast[ptr gobject.Object00](sourceObject.impl), callback, userData, error)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleAsyncResultFromError*[T](result: var T; sourceObject: gobject.Object; callback: AsyncReadyCallback; 
    userData: pointer; error: ptr Error00) =
  assert(result is SimpleAsyncResult)
  new(result, finalizeGObject)
  result.impl = g_simple_async_result_new_from_error(cast[ptr gobject.Object00](sourceObject.impl), callback, userData, error)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_simple_async_result_is_valid*(resu: ptr AsyncResult00; source: ptr gobject.Object00; 
    sourceTag: pointer): gboolean {.
    importc: "g_simple_async_result_is_valid", libprag.}

proc isValid*(resu: AsyncResult; source: gobject.Object; sourceTag: pointer): bool =
  toBool(g_simple_async_result_is_valid(cast[ptr AsyncResult00](resu.impl), cast[ptr gobject.Object00](source.impl), sourceTag))

proc g_simple_async_result_complete*(self: ptr SimpleAsyncResult00) {.
    importc: "g_simple_async_result_complete", libprag.}

proc complete*(self: SimpleAsyncResult) =
  g_simple_async_result_complete(cast[ptr SimpleAsyncResult00](self.impl))

proc g_simple_async_result_complete_in_idle*(self: ptr SimpleAsyncResult00) {.
    importc: "g_simple_async_result_complete_in_idle", libprag.}

proc completeInIdle*(self: SimpleAsyncResult) =
  g_simple_async_result_complete_in_idle(cast[ptr SimpleAsyncResult00](self.impl))

proc g_simple_async_result_get_op_res_gboolean*(self: ptr SimpleAsyncResult00): gboolean {.
    importc: "g_simple_async_result_get_op_res_gboolean", libprag.}

proc getOpResGboolean*(self: SimpleAsyncResult): bool =
  toBool(g_simple_async_result_get_op_res_gboolean(cast[ptr SimpleAsyncResult00](self.impl)))

proc opResGboolean*(self: SimpleAsyncResult): bool =
  toBool(g_simple_async_result_get_op_res_gboolean(cast[ptr SimpleAsyncResult00](self.impl)))

proc g_simple_async_result_get_op_res_gssize*(self: ptr SimpleAsyncResult00): int64 {.
    importc: "g_simple_async_result_get_op_res_gssize", libprag.}

proc getOpResGssize*(self: SimpleAsyncResult): int64 =
  g_simple_async_result_get_op_res_gssize(cast[ptr SimpleAsyncResult00](self.impl))

proc opResGssize*(self: SimpleAsyncResult): int64 =
  g_simple_async_result_get_op_res_gssize(cast[ptr SimpleAsyncResult00](self.impl))

proc g_simple_async_result_propagate_error*(self: ptr SimpleAsyncResult00): gboolean {.
    importc: "g_simple_async_result_propagate_error", libprag.}

proc propagateError*(self: SimpleAsyncResult): bool =
  toBool(g_simple_async_result_propagate_error(cast[ptr SimpleAsyncResult00](self.impl)))

proc g_simple_async_result_set_check_cancellable*(self: ptr SimpleAsyncResult00; checkCancellable: ptr Cancellable00) {.
    importc: "g_simple_async_result_set_check_cancellable", libprag.}

proc setCheckCancellable*(self: SimpleAsyncResult; checkCancellable: Cancellable) =
  g_simple_async_result_set_check_cancellable(cast[ptr SimpleAsyncResult00](self.impl), cast[ptr Cancellable00](checkCancellable.impl))

proc `checkCancellable=`*(self: SimpleAsyncResult; checkCancellable: Cancellable) =
  g_simple_async_result_set_check_cancellable(cast[ptr SimpleAsyncResult00](self.impl), cast[ptr Cancellable00](checkCancellable.impl))

proc g_simple_async_result_set_from_error*(self: ptr SimpleAsyncResult00; error: ptr Error00) {.
    importc: "g_simple_async_result_set_from_error", libprag.}

proc setFromError*(self: SimpleAsyncResult; error: ptr Error00) =
  g_simple_async_result_set_from_error(cast[ptr SimpleAsyncResult00](self.impl), error)

proc `fromError=`*(self: SimpleAsyncResult; error: ptr Error00) =
  g_simple_async_result_set_from_error(cast[ptr SimpleAsyncResult00](self.impl), error)

proc g_simple_async_result_set_handle_cancellation*(self: ptr SimpleAsyncResult00; handleCancellation: gboolean) {.
    importc: "g_simple_async_result_set_handle_cancellation", libprag.}

proc setHandleCancellation*(self: SimpleAsyncResult; handleCancellation: bool) =
  g_simple_async_result_set_handle_cancellation(cast[ptr SimpleAsyncResult00](self.impl), gboolean(handleCancellation))

proc `handleCancellation=`*(self: SimpleAsyncResult; handleCancellation: bool) =
  g_simple_async_result_set_handle_cancellation(cast[ptr SimpleAsyncResult00](self.impl), gboolean(handleCancellation))

proc g_simple_async_result_set_op_res_gboolean*(self: ptr SimpleAsyncResult00; opRes: gboolean) {.
    importc: "g_simple_async_result_set_op_res_gboolean", libprag.}

proc setOpResGboolean*(self: SimpleAsyncResult; opRes: bool) =
  g_simple_async_result_set_op_res_gboolean(cast[ptr SimpleAsyncResult00](self.impl), gboolean(opRes))

proc `opResGboolean=`*(self: SimpleAsyncResult; opRes: bool) =
  g_simple_async_result_set_op_res_gboolean(cast[ptr SimpleAsyncResult00](self.impl), gboolean(opRes))

proc g_simple_async_result_set_op_res_gssize*(self: ptr SimpleAsyncResult00; opRes: int64) {.
    importc: "g_simple_async_result_set_op_res_gssize", libprag.}

proc setOpResGssize*(self: SimpleAsyncResult; opRes: int64) =
  g_simple_async_result_set_op_res_gssize(cast[ptr SimpleAsyncResult00](self.impl), opRes)

proc `opResGssize=`*(self: SimpleAsyncResult; opRes: int64) =
  g_simple_async_result_set_op_res_gssize(cast[ptr SimpleAsyncResult00](self.impl), opRes)

type
  SimpleAsyncResultClass00* {.pure.} = object
  SimpleAsyncResultClass* = ref object
    impl*: ptr SimpleAsyncResultClass00

type
  SimpleAsyncThreadFunc* = proc (res: ptr SimpleAsyncResult00; `object`: ptr gobject.Object00; 
    cancellable: ptr Cancellable00) {.cdecl.}

type
  SimpleIOStream* = ref object of IOStream
  SimpleIOStream00* = object of IOStream00

proc g_simple_io_stream_new*(inputStream: ptr InputStream00; outputStream: ptr OutputStream00): ptr SimpleIOStream00 {.
    importc: "g_simple_io_stream_new", libprag.}

proc newSimpleIOStream*(inputStream: InputStream; outputStream: OutputStream): SimpleIOStream =
  new(result, finalizeGObject)
  result.impl = g_simple_io_stream_new(cast[ptr InputStream00](inputStream.impl), cast[ptr OutputStream00](outputStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimpleIOStream*[T](result: var T; inputStream: InputStream; outputStream: OutputStream) =
  assert(result is SimpleIOStream)
  new(result, finalizeGObject)
  result.impl = g_simple_io_stream_new(cast[ptr InputStream00](inputStream.impl), cast[ptr OutputStream00](outputStream.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SimplePermission* = ref object of Permission
  SimplePermission00* = object of Permission00

proc g_simple_permission_new*(allowed: gboolean): ptr SimplePermission00 {.
    importc: "g_simple_permission_new", libprag.}

proc newSimplePermission*(allowed: bool): SimplePermission =
  new(result, finalizeGObject)
  result.impl = g_simple_permission_new(gboolean(allowed))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSimplePermission*[T](result: var T; allowed: bool) =
  assert(result is SimplePermission)
  new(result, finalizeGObject)
  result.impl = g_simple_permission_new(gboolean(allowed))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SimpleProxyResolverPrivate00* {.pure.} = object
  SimpleProxyResolverPrivate* = ref object
    impl*: ptr SimpleProxyResolverPrivate00

type
  SimpleProxyResolver* = ref object of gobject.Object
  SimpleProxyResolver00* = object of gobject.Object00
    priv1: ptr SimpleProxyResolverPrivate00

proc g_simple_proxy_resolver_new*(defaultProxy: cstring; ignoreHosts: cstring): ptr ProxyResolver00 {.
    importc: "g_simple_proxy_resolver_new", libprag.}

proc newSimpleProxyResolver*(defaultProxy: string; ignoreHosts: string): ProxyResolver =
  new(result)
  result.impl = g_simple_proxy_resolver_new(cstring(defaultProxy), cstring(ignoreHosts))

proc g_simple_proxy_resolver_set_default_proxy*(self: ptr SimpleProxyResolver00; defaultProxy: cstring) {.
    importc: "g_simple_proxy_resolver_set_default_proxy", libprag.}

proc setDefaultProxy*(self: SimpleProxyResolver; defaultProxy: string) =
  g_simple_proxy_resolver_set_default_proxy(cast[ptr SimpleProxyResolver00](self.impl), cstring(defaultProxy))

proc `defaultProxy=`*(self: SimpleProxyResolver; defaultProxy: string) =
  g_simple_proxy_resolver_set_default_proxy(cast[ptr SimpleProxyResolver00](self.impl), cstring(defaultProxy))

proc g_simple_proxy_resolver_set_ignore_hosts*(self: ptr SimpleProxyResolver00; ignoreHosts: cstring) {.
    importc: "g_simple_proxy_resolver_set_ignore_hosts", libprag.}

proc setIgnoreHosts*(self: SimpleProxyResolver; ignoreHosts: string) =
  g_simple_proxy_resolver_set_ignore_hosts(cast[ptr SimpleProxyResolver00](self.impl), cstring(ignoreHosts))

proc `ignoreHosts=`*(self: SimpleProxyResolver; ignoreHosts: string) =
  g_simple_proxy_resolver_set_ignore_hosts(cast[ptr SimpleProxyResolver00](self.impl), cstring(ignoreHosts))

proc g_simple_proxy_resolver_set_uri_proxy*(self: ptr SimpleProxyResolver00; uriScheme: cstring; 
    proxy: cstring) {.
    importc: "g_simple_proxy_resolver_set_uri_proxy", libprag.}

proc setUriProxy*(self: SimpleProxyResolver; uriScheme: string; proxy: string) =
  g_simple_proxy_resolver_set_uri_proxy(cast[ptr SimpleProxyResolver00](self.impl), cstring(uriScheme), cstring(proxy))

type
  SimpleProxyResolverClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  SimpleProxyResolverClass* = ref object
    impl*: ptr SimpleProxyResolverClass00

type
  SocketPrivate00* {.pure.} = object
  SocketPrivate* = ref object
    impl*: ptr SocketPrivate00

type
  Socket* = ref object of gobject.Object
  Socket00* = object of gobject.Object00
    priv1: ptr SocketPrivate00

proc g_socket_new_from_fd*(fd: int32): ptr Socket00 {.
    importc: "g_socket_new_from_fd", libprag.}

proc newSocketFromFd*(fd: int): Socket =
  new(result, finalizeGObject)
  result.impl = g_socket_new_from_fd(int32(fd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocketFromFd*[T](result: var T; fd: int) =
  assert(result is Socket)
  new(result, finalizeGObject)
  result.impl = g_socket_new_from_fd(int32(fd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_accept*(self: ptr Socket00; cancellable: ptr Cancellable00): ptr Socket00 {.
    importc: "g_socket_accept", libprag.}

proc accept*(self: Socket; cancellable: Cancellable): Socket =
  let gobj = g_socket_accept(cast[ptr Socket00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Socket](g_object_get_qdata(gobj, Quark))
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

proc g_socket_bind*(self: ptr Socket00; address: ptr SocketAddress00; 
    allowReuse: gboolean): gboolean {.
    importc: "g_socket_bind", libprag.}

proc `bind`*(self: Socket; address: SocketAddress; allowReuse: bool): bool =
  toBool(g_socket_bind(cast[ptr Socket00](self.impl), cast[ptr SocketAddress00](address.impl), gboolean(allowReuse)))

proc g_socket_check_connect_result*(self: ptr Socket00): gboolean {.
    importc: "g_socket_check_connect_result", libprag.}

proc checkConnectResult*(self: Socket): bool =
  toBool(g_socket_check_connect_result(cast[ptr Socket00](self.impl)))

proc g_socket_close*(self: ptr Socket00): gboolean {.
    importc: "g_socket_close", libprag.}

proc close*(self: Socket): bool =
  toBool(g_socket_close(cast[ptr Socket00](self.impl)))

proc g_socket_condition_check*(self: ptr Socket00; condition: glib.IOCondition): glib.IOCondition {.
    importc: "g_socket_condition_check", libprag.}

proc conditionCheck*(self: Socket; condition: glib.IOCondition): glib.IOCondition =
  g_socket_condition_check(cast[ptr Socket00](self.impl), condition)

proc g_socket_condition_timed_wait*(self: ptr Socket00; condition: glib.IOCondition; timeout: int64; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_socket_condition_timed_wait", libprag.}

proc conditionTimedWait*(self: Socket; condition: glib.IOCondition; timeout: int64; 
    cancellable: Cancellable): bool =
  toBool(g_socket_condition_timed_wait(cast[ptr Socket00](self.impl), condition, timeout, cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_condition_wait*(self: ptr Socket00; condition: glib.IOCondition; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_socket_condition_wait", libprag.}

proc conditionWait*(self: Socket; condition: glib.IOCondition; cancellable: Cancellable): bool =
  toBool(g_socket_condition_wait(cast[ptr Socket00](self.impl), condition, cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_connect*(self: ptr Socket00; address: ptr SocketAddress00; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_socket_connect", libprag.}

proc connect*(self: Socket; address: SocketAddress; cancellable: Cancellable): bool =
  toBool(g_socket_connect(cast[ptr Socket00](self.impl), cast[ptr SocketAddress00](address.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_get_available_bytes*(self: ptr Socket00): int64 {.
    importc: "g_socket_get_available_bytes", libprag.}

proc getAvailableBytes*(self: Socket): int64 =
  g_socket_get_available_bytes(cast[ptr Socket00](self.impl))

proc availableBytes*(self: Socket): int64 =
  g_socket_get_available_bytes(cast[ptr Socket00](self.impl))

proc g_socket_get_blocking*(self: ptr Socket00): gboolean {.
    importc: "g_socket_get_blocking", libprag.}

proc getBlocking*(self: Socket): bool =
  toBool(g_socket_get_blocking(cast[ptr Socket00](self.impl)))

proc blocking*(self: Socket): bool =
  toBool(g_socket_get_blocking(cast[ptr Socket00](self.impl)))

proc g_socket_get_broadcast*(self: ptr Socket00): gboolean {.
    importc: "g_socket_get_broadcast", libprag.}

proc getBroadcast*(self: Socket): bool =
  toBool(g_socket_get_broadcast(cast[ptr Socket00](self.impl)))

proc broadcast*(self: Socket): bool =
  toBool(g_socket_get_broadcast(cast[ptr Socket00](self.impl)))

proc g_socket_get_credentials*(self: ptr Socket00): ptr Credentials00 {.
    importc: "g_socket_get_credentials", libprag.}

proc getCredentials*(self: Socket): Credentials =
  let gobj = g_socket_get_credentials(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc credentials*(self: Socket): Credentials =
  let gobj = g_socket_get_credentials(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc g_socket_get_family*(self: ptr Socket00): SocketFamily {.
    importc: "g_socket_get_family", libprag.}

proc getFamily*(self: Socket): SocketFamily =
  g_socket_get_family(cast[ptr Socket00](self.impl))

proc family*(self: Socket): SocketFamily =
  g_socket_get_family(cast[ptr Socket00](self.impl))

proc g_socket_get_fd*(self: ptr Socket00): int32 {.
    importc: "g_socket_get_fd", libprag.}

proc getFd*(self: Socket): int =
  int(g_socket_get_fd(cast[ptr Socket00](self.impl)))

proc fd*(self: Socket): int =
  int(g_socket_get_fd(cast[ptr Socket00](self.impl)))

proc g_socket_get_keepalive*(self: ptr Socket00): gboolean {.
    importc: "g_socket_get_keepalive", libprag.}

proc getKeepalive*(self: Socket): bool =
  toBool(g_socket_get_keepalive(cast[ptr Socket00](self.impl)))

proc keepalive*(self: Socket): bool =
  toBool(g_socket_get_keepalive(cast[ptr Socket00](self.impl)))

proc g_socket_get_listen_backlog*(self: ptr Socket00): int32 {.
    importc: "g_socket_get_listen_backlog", libprag.}

proc getListenBacklog*(self: Socket): int =
  int(g_socket_get_listen_backlog(cast[ptr Socket00](self.impl)))

proc listenBacklog*(self: Socket): int =
  int(g_socket_get_listen_backlog(cast[ptr Socket00](self.impl)))

proc g_socket_get_local_address*(self: ptr Socket00): ptr SocketAddress00 {.
    importc: "g_socket_get_local_address", libprag.}

proc getLocalAddress*(self: Socket): SocketAddress =
  let gobj = g_socket_get_local_address(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc localAddress*(self: Socket): SocketAddress =
  let gobj = g_socket_get_local_address(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_get_multicast_loopback*(self: ptr Socket00): gboolean {.
    importc: "g_socket_get_multicast_loopback", libprag.}

proc getMulticastLoopback*(self: Socket): bool =
  toBool(g_socket_get_multicast_loopback(cast[ptr Socket00](self.impl)))

proc multicastLoopback*(self: Socket): bool =
  toBool(g_socket_get_multicast_loopback(cast[ptr Socket00](self.impl)))

proc g_socket_get_multicast_ttl*(self: ptr Socket00): uint32 {.
    importc: "g_socket_get_multicast_ttl", libprag.}

proc getMulticastTtl*(self: Socket): int =
  int(g_socket_get_multicast_ttl(cast[ptr Socket00](self.impl)))

proc multicastTtl*(self: Socket): int =
  int(g_socket_get_multicast_ttl(cast[ptr Socket00](self.impl)))

proc g_socket_get_option*(self: ptr Socket00; level: int32; optname: int32; 
    value: var int32): gboolean {.
    importc: "g_socket_get_option", libprag.}

proc getOption*(self: Socket; level: int; optname: int; value: var int): bool =
  var value_00 = int32(value)
  result = toBool(g_socket_get_option(cast[ptr Socket00](self.impl), int32(level), int32(optname), value_00))
  value = int(value_00)

proc option*(self: Socket; level: int; optname: int; value: var int): bool =
  var value_00 = int32(value)
  result = toBool(g_socket_get_option(cast[ptr Socket00](self.impl), int32(level), int32(optname), value_00))
  value = int(value_00)

proc g_socket_get_remote_address*(self: ptr Socket00): ptr SocketAddress00 {.
    importc: "g_socket_get_remote_address", libprag.}

proc getRemoteAddress*(self: Socket): SocketAddress =
  let gobj = g_socket_get_remote_address(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc remoteAddress*(self: Socket): SocketAddress =
  let gobj = g_socket_get_remote_address(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_get_timeout*(self: ptr Socket00): uint32 {.
    importc: "g_socket_get_timeout", libprag.}

proc getTimeout*(self: Socket): int =
  int(g_socket_get_timeout(cast[ptr Socket00](self.impl)))

proc timeout*(self: Socket): int =
  int(g_socket_get_timeout(cast[ptr Socket00](self.impl)))

proc g_socket_get_ttl*(self: ptr Socket00): uint32 {.
    importc: "g_socket_get_ttl", libprag.}

proc getTtl*(self: Socket): int =
  int(g_socket_get_ttl(cast[ptr Socket00](self.impl)))

proc ttl*(self: Socket): int =
  int(g_socket_get_ttl(cast[ptr Socket00](self.impl)))

proc g_socket_is_closed*(self: ptr Socket00): gboolean {.
    importc: "g_socket_is_closed", libprag.}

proc isClosed*(self: Socket): bool =
  toBool(g_socket_is_closed(cast[ptr Socket00](self.impl)))

proc g_socket_is_connected*(self: ptr Socket00): gboolean {.
    importc: "g_socket_is_connected", libprag.}

proc isConnected*(self: Socket): bool =
  toBool(g_socket_is_connected(cast[ptr Socket00](self.impl)))

proc g_socket_join_multicast_group*(self: ptr Socket00; group: ptr InetAddress00; sourceSpecific: gboolean; 
    iface: cstring): gboolean {.
    importc: "g_socket_join_multicast_group", libprag.}

proc joinMulticastGroup*(self: Socket; group: InetAddress; sourceSpecific: bool; 
    iface: string): bool =
  toBool(g_socket_join_multicast_group(cast[ptr Socket00](self.impl), cast[ptr InetAddress00](group.impl), gboolean(sourceSpecific), cstring(iface)))

proc g_socket_leave_multicast_group*(self: ptr Socket00; group: ptr InetAddress00; sourceSpecific: gboolean; 
    iface: cstring): gboolean {.
    importc: "g_socket_leave_multicast_group", libprag.}

proc leaveMulticastGroup*(self: Socket; group: InetAddress; sourceSpecific: bool; 
    iface: string): bool =
  toBool(g_socket_leave_multicast_group(cast[ptr Socket00](self.impl), cast[ptr InetAddress00](group.impl), gboolean(sourceSpecific), cstring(iface)))

proc g_socket_listen*(self: ptr Socket00): gboolean {.
    importc: "g_socket_listen", libprag.}

proc listen*(self: Socket): bool =
  toBool(g_socket_listen(cast[ptr Socket00](self.impl)))

proc g_socket_receive*(self: ptr Socket00; buffer: uint8Array; size: uint64; 
    cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive", libprag.}

proc receive*(self: Socket; buffer: uint8Array; size: uint64; cancellable: Cancellable): int64 =
  g_socket_receive(cast[ptr Socket00](self.impl), buffer, size, cast[ptr Cancellable00](cancellable.impl))

proc g_socket_receive_from*(self: ptr Socket00; address: var ptr SocketAddress00; 
    buffer: uint8Array; size: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive_from", libprag.}

proc receiveFrom*(self: ptr Socket00; address: var ptr SocketAddress00; 
    buffer: uint8Array; size: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive_from", libprag.}

proc g_socket_receive_message*(self: ptr Socket00; address: var ptr SocketAddress00; 
    vectors: InputVector00Array; numVectors: int32; messages: var ptr SocketControlMessage00Array; 
    numMessages: var int32; flags: int32; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive_message", libprag.}

proc receiveMessage*(self: ptr Socket00; address: var ptr SocketAddress00; 
    vectors: InputVector00Array; numVectors: int32; messages: var ptr SocketControlMessage00Array; 
    numMessages: var int32; flags: int32; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive_message", libprag.}

proc g_socket_receive_messages*(self: ptr Socket00; messages: InputMessage00Array; 
    numMessages: uint32; flags: int32; cancellable: ptr Cancellable00): int32 {.
    importc: "g_socket_receive_messages", libprag.}

proc receiveMessages*(self: Socket; messages: InputMessage00Array; numMessages: int; 
    flags: int; cancellable: Cancellable): int =
  int(g_socket_receive_messages(cast[ptr Socket00](self.impl), messages, uint32(numMessages), int32(flags), cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_receive_with_blocking*(self: ptr Socket00; buffer: uint8Array; size: uint64; 
    blocking: gboolean; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_receive_with_blocking", libprag.}

proc receiveWithBlocking*(self: Socket; buffer: uint8Array; size: uint64; blocking: bool; 
    cancellable: Cancellable): int64 =
  g_socket_receive_with_blocking(cast[ptr Socket00](self.impl), buffer, size, gboolean(blocking), cast[ptr Cancellable00](cancellable.impl))

proc g_socket_send*(self: ptr Socket00; buffer: uint8Array; size: uint64; 
    cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_send", libprag.}

proc send*(self: Socket; buffer: uint8Array; size: uint64; cancellable: Cancellable): int64 =
  g_socket_send(cast[ptr Socket00](self.impl), buffer, size, cast[ptr Cancellable00](cancellable.impl))

proc g_socket_send_message*(self: ptr Socket00; address: ptr SocketAddress00; 
    vectors: OutputVector00Array; numVectors: int32; messages: ptr SocketControlMessage00Array; numMessages: int32; 
    flags: int32; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_send_message", libprag.}

proc sendMessage*(self: Socket; address: SocketAddress; vectors: OutputVector00Array; 
    numVectors: int; messages: ptr SocketControlMessage00Array; numMessages: int; 
    flags: int; cancellable: Cancellable): int64 =
  g_socket_send_message(cast[ptr Socket00](self.impl), cast[ptr SocketAddress00](address.impl), vectors, int32(numVectors), messages, int32(numMessages), int32(flags), cast[ptr Cancellable00](cancellable.impl))

proc g_socket_send_messages*(self: ptr Socket00; messages: OutputMessage00Array; 
    numMessages: uint32; flags: int32; cancellable: ptr Cancellable00): int32 {.
    importc: "g_socket_send_messages", libprag.}

proc sendMessages*(self: Socket; messages: OutputMessage00Array; numMessages: int; 
    flags: int; cancellable: Cancellable): int =
  int(g_socket_send_messages(cast[ptr Socket00](self.impl), messages, uint32(numMessages), int32(flags), cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_send_to*(self: ptr Socket00; address: ptr SocketAddress00; 
    buffer: uint8Array; size: uint64; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_send_to", libprag.}

proc sendTo*(self: Socket; address: SocketAddress; buffer: uint8Array; 
    size: uint64; cancellable: Cancellable): int64 =
  g_socket_send_to(cast[ptr Socket00](self.impl), cast[ptr SocketAddress00](address.impl), buffer, size, cast[ptr Cancellable00](cancellable.impl))

proc g_socket_send_with_blocking*(self: ptr Socket00; buffer: uint8Array; size: uint64; 
    blocking: gboolean; cancellable: ptr Cancellable00): int64 {.
    importc: "g_socket_send_with_blocking", libprag.}

proc sendWithBlocking*(self: Socket; buffer: uint8Array; size: uint64; blocking: bool; 
    cancellable: Cancellable): int64 =
  g_socket_send_with_blocking(cast[ptr Socket00](self.impl), buffer, size, gboolean(blocking), cast[ptr Cancellable00](cancellable.impl))

proc g_socket_set_blocking*(self: ptr Socket00; blocking: gboolean) {.
    importc: "g_socket_set_blocking", libprag.}

proc setBlocking*(self: Socket; blocking: bool) =
  g_socket_set_blocking(cast[ptr Socket00](self.impl), gboolean(blocking))

proc `blocking=`*(self: Socket; blocking: bool) =
  g_socket_set_blocking(cast[ptr Socket00](self.impl), gboolean(blocking))

proc g_socket_set_broadcast*(self: ptr Socket00; broadcast: gboolean) {.
    importc: "g_socket_set_broadcast", libprag.}

proc setBroadcast*(self: Socket; broadcast: bool) =
  g_socket_set_broadcast(cast[ptr Socket00](self.impl), gboolean(broadcast))

proc `broadcast=`*(self: Socket; broadcast: bool) =
  g_socket_set_broadcast(cast[ptr Socket00](self.impl), gboolean(broadcast))

proc g_socket_set_keepalive*(self: ptr Socket00; keepalive: gboolean) {.
    importc: "g_socket_set_keepalive", libprag.}

proc setKeepalive*(self: Socket; keepalive: bool) =
  g_socket_set_keepalive(cast[ptr Socket00](self.impl), gboolean(keepalive))

proc `keepalive=`*(self: Socket; keepalive: bool) =
  g_socket_set_keepalive(cast[ptr Socket00](self.impl), gboolean(keepalive))

proc g_socket_set_listen_backlog*(self: ptr Socket00; backlog: int32) {.
    importc: "g_socket_set_listen_backlog", libprag.}

proc setListenBacklog*(self: Socket; backlog: int) =
  g_socket_set_listen_backlog(cast[ptr Socket00](self.impl), int32(backlog))

proc `listenBacklog=`*(self: Socket; backlog: int) =
  g_socket_set_listen_backlog(cast[ptr Socket00](self.impl), int32(backlog))

proc g_socket_set_multicast_loopback*(self: ptr Socket00; loopback: gboolean) {.
    importc: "g_socket_set_multicast_loopback", libprag.}

proc setMulticastLoopback*(self: Socket; loopback: bool) =
  g_socket_set_multicast_loopback(cast[ptr Socket00](self.impl), gboolean(loopback))

proc `multicastLoopback=`*(self: Socket; loopback: bool) =
  g_socket_set_multicast_loopback(cast[ptr Socket00](self.impl), gboolean(loopback))

proc g_socket_set_multicast_ttl*(self: ptr Socket00; ttl: uint32) {.
    importc: "g_socket_set_multicast_ttl", libprag.}

proc setMulticastTtl*(self: Socket; ttl: int) =
  g_socket_set_multicast_ttl(cast[ptr Socket00](self.impl), uint32(ttl))

proc `multicastTtl=`*(self: Socket; ttl: int) =
  g_socket_set_multicast_ttl(cast[ptr Socket00](self.impl), uint32(ttl))

proc g_socket_set_option*(self: ptr Socket00; level: int32; optname: int32; 
    value: int32): gboolean {.
    importc: "g_socket_set_option", libprag.}

proc setOption*(self: Socket; level: int; optname: int; value: int): bool =
  toBool(g_socket_set_option(cast[ptr Socket00](self.impl), int32(level), int32(optname), int32(value)))

proc g_socket_set_timeout*(self: ptr Socket00; timeout: uint32) {.
    importc: "g_socket_set_timeout", libprag.}

proc setTimeout*(self: Socket; timeout: int) =
  g_socket_set_timeout(cast[ptr Socket00](self.impl), uint32(timeout))

proc `timeout=`*(self: Socket; timeout: int) =
  g_socket_set_timeout(cast[ptr Socket00](self.impl), uint32(timeout))

proc g_socket_set_ttl*(self: ptr Socket00; ttl: uint32) {.
    importc: "g_socket_set_ttl", libprag.}

proc setTtl*(self: Socket; ttl: int) =
  g_socket_set_ttl(cast[ptr Socket00](self.impl), uint32(ttl))

proc `ttl=`*(self: Socket; ttl: int) =
  g_socket_set_ttl(cast[ptr Socket00](self.impl), uint32(ttl))

proc g_socket_shutdown*(self: ptr Socket00; shutdownRead: gboolean; shutdownWrite: gboolean): gboolean {.
    importc: "g_socket_shutdown", libprag.}

proc shutdown*(self: Socket; shutdownRead: bool; shutdownWrite: bool): bool =
  toBool(g_socket_shutdown(cast[ptr Socket00](self.impl), gboolean(shutdownRead), gboolean(shutdownWrite)))

proc g_socket_speaks_ipv4*(self: ptr Socket00): gboolean {.
    importc: "g_socket_speaks_ipv4", libprag.}

proc speaksIpv4*(self: Socket): bool =
  toBool(g_socket_speaks_ipv4(cast[ptr Socket00](self.impl)))

type
  SocketConnectionPrivate00* {.pure.} = object
  SocketConnectionPrivate* = ref object
    impl*: ptr SocketConnectionPrivate00

type
  SocketConnection* = ref object of IOStream
  SocketConnection00* = object of IOStream00
    priv2: ptr SocketConnectionPrivate00

proc g_socket_connection_connect*(self: ptr SocketConnection00; address: ptr SocketAddress00; 
    cancellable: ptr Cancellable00): gboolean {.
    importc: "g_socket_connection_connect", libprag.}

proc connect*(self: SocketConnection; address: SocketAddress; cancellable: Cancellable): bool =
  toBool(g_socket_connection_connect(cast[ptr SocketConnection00](self.impl), cast[ptr SocketAddress00](address.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_socket_connection_connect_async*(self: ptr SocketConnection00; address: ptr SocketAddress00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_connection_connect_async", libprag.}

proc connectAsync*(self: SocketConnection; address: SocketAddress; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_socket_connection_connect_async(cast[ptr SocketConnection00](self.impl), cast[ptr SocketAddress00](address.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_connection_connect_finish*(self: ptr SocketConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_socket_connection_connect_finish", libprag.}

proc connectFinish*(self: SocketConnection; resu: AsyncResult): bool =
  toBool(g_socket_connection_connect_finish(cast[ptr SocketConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_socket_connection_get_local_address*(self: ptr SocketConnection00): ptr SocketAddress00 {.
    importc: "g_socket_connection_get_local_address", libprag.}

proc getLocalAddress*(self: SocketConnection): SocketAddress =
  let gobj = g_socket_connection_get_local_address(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc localAddress*(self: SocketConnection): SocketAddress =
  let gobj = g_socket_connection_get_local_address(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_connection_get_remote_address*(self: ptr SocketConnection00): ptr SocketAddress00 {.
    importc: "g_socket_connection_get_remote_address", libprag.}

proc getRemoteAddress*(self: SocketConnection): SocketAddress =
  let gobj = g_socket_connection_get_remote_address(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc remoteAddress*(self: SocketConnection): SocketAddress =
  let gobj = g_socket_connection_get_remote_address(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_connection_get_socket*(self: ptr SocketConnection00): ptr Socket00 {.
    importc: "g_socket_connection_get_socket", libprag.}

proc getSocket*(self: SocketConnection): Socket =
  let gobj = g_socket_connection_get_socket(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Socket](g_object_get_qdata(gobj, Quark))
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

proc socket*(self: SocketConnection): Socket =
  let gobj = g_socket_connection_get_socket(cast[ptr SocketConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Socket](g_object_get_qdata(gobj, Quark))
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

proc g_socket_connection_is_connected*(self: ptr SocketConnection00): gboolean {.
    importc: "g_socket_connection_is_connected", libprag.}

proc isConnected*(self: SocketConnection): bool =
  toBool(g_socket_connection_is_connected(cast[ptr SocketConnection00](self.impl)))

proc g_socket_connection_factory_create_connection*(self: ptr Socket00): ptr SocketConnection00 {.
    importc: "g_socket_connection_factory_create_connection", libprag.}

proc connectionFactoryCreateConnection*(self: Socket): SocketConnection =
  let gobj = g_socket_connection_factory_create_connection(cast[ptr Socket00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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
  SocketProtocol* {.size: sizeof(cint), pure.} = enum
    unknown = -1
    default = 0
    tcp = 6
    udp = 17
    sctp = 132

proc g_socket_get_protocol*(self: ptr Socket00): SocketProtocol {.
    importc: "g_socket_get_protocol", libprag.}

proc getProtocol*(self: Socket): SocketProtocol =
  g_socket_get_protocol(cast[ptr Socket00](self.impl))

proc protocol*(self: Socket): SocketProtocol =
  g_socket_get_protocol(cast[ptr Socket00](self.impl))

type
  SocketType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    stream = 1
    datagram = 2
    seqpacket = 3

proc g_socket_new*(family: SocketFamily; `type`: SocketType; protocol: SocketProtocol): ptr Socket00 {.
    importc: "g_socket_new", libprag.}

proc newSocket*(family: SocketFamily; `type`: SocketType; protocol: SocketProtocol): Socket =
  new(result, finalizeGObject)
  result.impl = g_socket_new(family, `type`, protocol)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocket*[T](result: var T; family: SocketFamily; `type`: SocketType; protocol: SocketProtocol) =
  assert(result is Socket)
  new(result, finalizeGObject)
  result.impl = g_socket_new(family, `type`, protocol)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_get_socket_type*(self: ptr Socket00): SocketType {.
    importc: "g_socket_get_socket_type", libprag.}

proc getSocketType*(self: Socket): SocketType =
  g_socket_get_socket_type(cast[ptr Socket00](self.impl))

proc socketType*(self: Socket): SocketType =
  g_socket_get_socket_type(cast[ptr Socket00](self.impl))

proc g_socket_connection_factory_lookup_type*(family: SocketFamily; `type`: SocketType; protocolId: int32): GType {.
    importc: "g_socket_connection_factory_lookup_type", libprag.}

proc factoryLookupType*(family: SocketFamily; `type`: SocketType; protocolId: int32): GType {.
    importc: "g_socket_connection_factory_lookup_type", libprag.}

proc g_socket_connection_factory_register_type*(gType: GType; family: SocketFamily; `type`: SocketType; 
    protocol: int32) {.
    importc: "g_socket_connection_factory_register_type", libprag.}

proc factoryRegisterType*(gType: GType; family: SocketFamily; `type`: SocketType; 
    protocol: int32) {.
    importc: "g_socket_connection_factory_register_type", libprag.}

type
  SocketClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
    gReserved7*: pointer
    gReserved8*: pointer
    gReserved9*: pointer
    gReserved10*: pointer
  SocketClass* = ref object
    impl*: ptr SocketClass00

type
  SocketClientPrivate00* {.pure.} = object
  SocketClientPrivate* = ref object
    impl*: ptr SocketClientPrivate00

type
  SocketClientEvent* {.size: sizeof(cint), pure.} = enum
    resolving = 0
    resolved = 1
    connecting = 2
    connected = 3
    proxyNegotiating = 4
    proxyNegotiated = 5
    tlsHandshaking = 6
    tlsHandshaked = 7
    complete = 8

type
  SocketClient* = ref object of gobject.Object
  SocketClient00* = object of gobject.Object00
    priv1: ptr SocketClientPrivate00

proc scEvent*(self: SocketClient;  p: proc (self: ptr gobject.Object00; event: SocketClientEvent; connectable: SocketConnectable00; 
    connection: IOStream00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "event", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_socket_client_new*(): ptr SocketClient00 {.
    importc: "g_socket_client_new", libprag.}

proc newSocketClient*(): SocketClient =
  new(result, finalizeGObject)
  result.impl = g_socket_client_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocketClient*[T](result: var T) =
  assert(result is SocketClient)
  new(result, finalizeGObject)
  result.impl = g_socket_client_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_client_add_application_proxy*(self: ptr SocketClient00; protocol: cstring) {.
    importc: "g_socket_client_add_application_proxy", libprag.}

proc addApplicationProxy*(self: SocketClient; protocol: string) =
  g_socket_client_add_application_proxy(cast[ptr SocketClient00](self.impl), cstring(protocol))

proc g_socket_client_connect*(self: ptr SocketClient00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect", libprag.}

proc connect*(self: SocketClient; connectable: SocketConnectable; 
    cancellable: Cancellable): SocketConnection =
  let gobj = g_socket_client_connect(cast[ptr SocketClient00](self.impl), cast[ptr SocketConnectable00](connectable.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_async*(self: ptr SocketClient00; connectable: ptr SocketConnectable00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_client_connect_async", libprag.}

proc connectAsync*(self: SocketClient; connectable: SocketConnectable; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_socket_client_connect_async(cast[ptr SocketClient00](self.impl), cast[ptr SocketConnectable00](connectable.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_client_connect_finish*(self: ptr SocketClient00; resu: ptr AsyncResult00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_finish", libprag.}

proc connectFinish*(self: SocketClient; resu: AsyncResult): SocketConnection =
  let gobj = g_socket_client_connect_finish(cast[ptr SocketClient00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_host*(self: ptr SocketClient00; hostAndPort: cstring; defaultPort: uint16; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_host", libprag.}

proc connectToHost*(self: SocketClient; hostAndPort: string; defaultPort: uint16; 
    cancellable: Cancellable): SocketConnection =
  let gobj = g_socket_client_connect_to_host(cast[ptr SocketClient00](self.impl), cstring(hostAndPort), defaultPort, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_host_async*(self: ptr SocketClient00; hostAndPort: cstring; defaultPort: uint16; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_client_connect_to_host_async", libprag.}

proc connectToHostAsync*(self: SocketClient; hostAndPort: string; defaultPort: uint16; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_socket_client_connect_to_host_async(cast[ptr SocketClient00](self.impl), cstring(hostAndPort), defaultPort, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_client_connect_to_host_finish*(self: ptr SocketClient00; resu: ptr AsyncResult00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_host_finish", libprag.}

proc connectToHostFinish*(self: SocketClient; resu: AsyncResult): SocketConnection =
  let gobj = g_socket_client_connect_to_host_finish(cast[ptr SocketClient00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_service*(self: ptr SocketClient00; domain: cstring; service: cstring; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_service", libprag.}

proc connectToService*(self: SocketClient; domain: string; service: string; 
    cancellable: Cancellable): SocketConnection =
  let gobj = g_socket_client_connect_to_service(cast[ptr SocketClient00](self.impl), cstring(domain), cstring(service), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_service_async*(self: ptr SocketClient00; domain: cstring; service: cstring; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_client_connect_to_service_async", libprag.}

proc connectToServiceAsync*(self: SocketClient; domain: string; service: string; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_socket_client_connect_to_service_async(cast[ptr SocketClient00](self.impl), cstring(domain), cstring(service), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_client_connect_to_service_finish*(self: ptr SocketClient00; resu: ptr AsyncResult00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_service_finish", libprag.}

proc connectToServiceFinish*(self: SocketClient; resu: AsyncResult): SocketConnection =
  let gobj = g_socket_client_connect_to_service_finish(cast[ptr SocketClient00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_uri*(self: ptr SocketClient00; uri: cstring; defaultPort: uint16; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_uri", libprag.}

proc connectToUri*(self: SocketClient; uri: string; defaultPort: uint16; 
    cancellable: Cancellable): SocketConnection =
  let gobj = g_socket_client_connect_to_uri(cast[ptr SocketClient00](self.impl), cstring(uri), defaultPort, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_connect_to_uri_async*(self: ptr SocketClient00; uri: cstring; defaultPort: uint16; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_client_connect_to_uri_async", libprag.}

proc connectToUriAsync*(self: SocketClient; uri: string; defaultPort: uint16; 
    cancellable: Cancellable; callback: AsyncReadyCallback; userData: pointer) =
  g_socket_client_connect_to_uri_async(cast[ptr SocketClient00](self.impl), cstring(uri), defaultPort, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_client_connect_to_uri_finish*(self: ptr SocketClient00; resu: ptr AsyncResult00): ptr SocketConnection00 {.
    importc: "g_socket_client_connect_to_uri_finish", libprag.}

proc connectToUriFinish*(self: SocketClient; resu: AsyncResult): SocketConnection =
  let gobj = g_socket_client_connect_to_uri_finish(cast[ptr SocketClient00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketConnection](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_get_enable_proxy*(self: ptr SocketClient00): gboolean {.
    importc: "g_socket_client_get_enable_proxy", libprag.}

proc getEnableProxy*(self: SocketClient): bool =
  toBool(g_socket_client_get_enable_proxy(cast[ptr SocketClient00](self.impl)))

proc enableProxy*(self: SocketClient): bool =
  toBool(g_socket_client_get_enable_proxy(cast[ptr SocketClient00](self.impl)))

proc g_socket_client_get_family*(self: ptr SocketClient00): SocketFamily {.
    importc: "g_socket_client_get_family", libprag.}

proc getFamily*(self: SocketClient): SocketFamily =
  g_socket_client_get_family(cast[ptr SocketClient00](self.impl))

proc family*(self: SocketClient): SocketFamily =
  g_socket_client_get_family(cast[ptr SocketClient00](self.impl))

proc g_socket_client_get_local_address*(self: ptr SocketClient00): ptr SocketAddress00 {.
    importc: "g_socket_client_get_local_address", libprag.}

proc getLocalAddress*(self: SocketClient): SocketAddress =
  let gobj = g_socket_client_get_local_address(cast[ptr SocketClient00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc localAddress*(self: SocketClient): SocketAddress =
  let gobj = g_socket_client_get_local_address(cast[ptr SocketClient00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[SocketAddress](g_object_get_qdata(gobj, Quark))
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

proc g_socket_client_get_protocol*(self: ptr SocketClient00): SocketProtocol {.
    importc: "g_socket_client_get_protocol", libprag.}

proc getProtocol*(self: SocketClient): SocketProtocol =
  g_socket_client_get_protocol(cast[ptr SocketClient00](self.impl))

proc protocol*(self: SocketClient): SocketProtocol =
  g_socket_client_get_protocol(cast[ptr SocketClient00](self.impl))

proc g_socket_client_get_proxy_resolver*(self: ptr SocketClient00): ptr ProxyResolver00 {.
    importc: "g_socket_client_get_proxy_resolver", libprag.}

proc getProxyResolver*(self: SocketClient): ProxyResolver =
  new(result)
  result.impl = g_socket_client_get_proxy_resolver(cast[ptr SocketClient00](self.impl))

proc proxyResolver*(self: SocketClient): ProxyResolver =
  new(result)
  result.impl = g_socket_client_get_proxy_resolver(cast[ptr SocketClient00](self.impl))

proc g_socket_client_get_socket_type*(self: ptr SocketClient00): SocketType {.
    importc: "g_socket_client_get_socket_type", libprag.}

proc getSocketType*(self: SocketClient): SocketType =
  g_socket_client_get_socket_type(cast[ptr SocketClient00](self.impl))

proc socketType*(self: SocketClient): SocketType =
  g_socket_client_get_socket_type(cast[ptr SocketClient00](self.impl))

proc g_socket_client_get_timeout*(self: ptr SocketClient00): uint32 {.
    importc: "g_socket_client_get_timeout", libprag.}

proc getTimeout*(self: SocketClient): int =
  int(g_socket_client_get_timeout(cast[ptr SocketClient00](self.impl)))

proc timeout*(self: SocketClient): int =
  int(g_socket_client_get_timeout(cast[ptr SocketClient00](self.impl)))

proc g_socket_client_get_tls*(self: ptr SocketClient00): gboolean {.
    importc: "g_socket_client_get_tls", libprag.}

proc getTls*(self: SocketClient): bool =
  toBool(g_socket_client_get_tls(cast[ptr SocketClient00](self.impl)))

proc tls*(self: SocketClient): bool =
  toBool(g_socket_client_get_tls(cast[ptr SocketClient00](self.impl)))

proc g_socket_client_get_tls_validation_flags*(self: ptr SocketClient00): TlsCertificateFlags {.
    importc: "g_socket_client_get_tls_validation_flags", libprag.}

proc getTlsValidationFlags*(self: SocketClient): TlsCertificateFlags =
  g_socket_client_get_tls_validation_flags(cast[ptr SocketClient00](self.impl))

proc tlsValidationFlags*(self: SocketClient): TlsCertificateFlags =
  g_socket_client_get_tls_validation_flags(cast[ptr SocketClient00](self.impl))

proc g_socket_client_set_enable_proxy*(self: ptr SocketClient00; enable: gboolean) {.
    importc: "g_socket_client_set_enable_proxy", libprag.}

proc setEnableProxy*(self: SocketClient; enable: bool) =
  g_socket_client_set_enable_proxy(cast[ptr SocketClient00](self.impl), gboolean(enable))

proc `enableProxy=`*(self: SocketClient; enable: bool) =
  g_socket_client_set_enable_proxy(cast[ptr SocketClient00](self.impl), gboolean(enable))

proc g_socket_client_set_family*(self: ptr SocketClient00; family: SocketFamily) {.
    importc: "g_socket_client_set_family", libprag.}

proc setFamily*(self: SocketClient; family: SocketFamily) =
  g_socket_client_set_family(cast[ptr SocketClient00](self.impl), family)

proc `family=`*(self: SocketClient; family: SocketFamily) =
  g_socket_client_set_family(cast[ptr SocketClient00](self.impl), family)

proc g_socket_client_set_local_address*(self: ptr SocketClient00; address: ptr SocketAddress00) {.
    importc: "g_socket_client_set_local_address", libprag.}

proc setLocalAddress*(self: SocketClient; address: SocketAddress) =
  g_socket_client_set_local_address(cast[ptr SocketClient00](self.impl), cast[ptr SocketAddress00](address.impl))

proc `localAddress=`*(self: SocketClient; address: SocketAddress) =
  g_socket_client_set_local_address(cast[ptr SocketClient00](self.impl), cast[ptr SocketAddress00](address.impl))

proc g_socket_client_set_protocol*(self: ptr SocketClient00; protocol: SocketProtocol) {.
    importc: "g_socket_client_set_protocol", libprag.}

proc setProtocol*(self: SocketClient; protocol: SocketProtocol) =
  g_socket_client_set_protocol(cast[ptr SocketClient00](self.impl), protocol)

proc `protocol=`*(self: SocketClient; protocol: SocketProtocol) =
  g_socket_client_set_protocol(cast[ptr SocketClient00](self.impl), protocol)

proc g_socket_client_set_proxy_resolver*(self: ptr SocketClient00; proxyResolver: ptr ProxyResolver00) {.
    importc: "g_socket_client_set_proxy_resolver", libprag.}

proc setProxyResolver*(self: SocketClient; proxyResolver: ProxyResolver) =
  g_socket_client_set_proxy_resolver(cast[ptr SocketClient00](self.impl), cast[ptr ProxyResolver00](proxyResolver.impl))

proc `proxyResolver=`*(self: SocketClient; proxyResolver: ProxyResolver) =
  g_socket_client_set_proxy_resolver(cast[ptr SocketClient00](self.impl), cast[ptr ProxyResolver00](proxyResolver.impl))

proc g_socket_client_set_socket_type*(self: ptr SocketClient00; `type`: SocketType) {.
    importc: "g_socket_client_set_socket_type", libprag.}

proc setSocketType*(self: SocketClient; `type`: SocketType) =
  g_socket_client_set_socket_type(cast[ptr SocketClient00](self.impl), `type`)

proc `socketType=`*(self: SocketClient; `type`: SocketType) =
  g_socket_client_set_socket_type(cast[ptr SocketClient00](self.impl), `type`)

proc g_socket_client_set_timeout*(self: ptr SocketClient00; timeout: uint32) {.
    importc: "g_socket_client_set_timeout", libprag.}

proc setTimeout*(self: SocketClient; timeout: int) =
  g_socket_client_set_timeout(cast[ptr SocketClient00](self.impl), uint32(timeout))

proc `timeout=`*(self: SocketClient; timeout: int) =
  g_socket_client_set_timeout(cast[ptr SocketClient00](self.impl), uint32(timeout))

proc g_socket_client_set_tls*(self: ptr SocketClient00; tls: gboolean) {.
    importc: "g_socket_client_set_tls", libprag.}

proc setTls*(self: SocketClient; tls: bool) =
  g_socket_client_set_tls(cast[ptr SocketClient00](self.impl), gboolean(tls))

proc `tls=`*(self: SocketClient; tls: bool) =
  g_socket_client_set_tls(cast[ptr SocketClient00](self.impl), gboolean(tls))

proc g_socket_client_set_tls_validation_flags*(self: ptr SocketClient00; flags: TlsCertificateFlags) {.
    importc: "g_socket_client_set_tls_validation_flags", libprag.}

proc setTlsValidationFlags*(self: SocketClient; flags: TlsCertificateFlags) =
  g_socket_client_set_tls_validation_flags(cast[ptr SocketClient00](self.impl), flags)

proc `tlsValidationFlags=`*(self: SocketClient; flags: TlsCertificateFlags) =
  g_socket_client_set_tls_validation_flags(cast[ptr SocketClient00](self.impl), flags)

type
  SocketClientClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    event*: proc(client: ptr SocketClient00; event: SocketClientEvent; 
    connectable: ptr SocketConnectable00; connection: ptr IOStream00) {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
  SocketClientClass* = ref object
    impl*: ptr SocketClientClass00

type
  SocketConnectableIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    enumerate*: proc(connectable: ptr SocketConnectable00): ptr SocketAddressEnumerator00 {.cdecl.}
    proxyEnumerate*: proc(connectable: ptr SocketConnectable00): ptr SocketAddressEnumerator00 {.cdecl.}
    toString*: proc(connectable: ptr SocketConnectable00): cstring {.cdecl.}
  SocketConnectableIface* = ref object
    impl*: ptr SocketConnectableIface00

type
  SocketConnectionClass00* {.pure.} = object
    parentClass*: IOStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  SocketConnectionClass* = ref object
    impl*: ptr SocketConnectionClass00

type
  SocketControlMessageClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getSize*: proc(message: ptr SocketControlMessage00): uint64 {.cdecl.}
    getLevel*: proc(message: ptr SocketControlMessage00): int32 {.cdecl.}
    getType*: proc(message: ptr SocketControlMessage00): int32 {.cdecl.}
    serialize*: proc(message: ptr SocketControlMessage00; data: pointer) {.cdecl.}
    deserialize*: pointer
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  SocketControlMessageClass* = ref object
    impl*: ptr SocketControlMessageClass00

type
  SocketListenerPrivate00* {.pure.} = object
  SocketListenerPrivate* = ref object
    impl*: ptr SocketListenerPrivate00

type
  SocketListenerEvent* {.size: sizeof(cint), pure.} = enum
    binding = 0
    bound = 1
    listening = 2
    listened = 3

type
  SocketListener* = ref object of gobject.Object
  SocketListener00* = object of gobject.Object00
    priv1: ptr SocketListenerPrivate00

proc scEvent*(self: SocketListener;  p: proc (self: ptr gobject.Object00; event: SocketListenerEvent; socket: Socket00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "event", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_socket_listener_new*(): ptr SocketListener00 {.
    importc: "g_socket_listener_new", libprag.}

proc newSocketListener*(): SocketListener =
  new(result, finalizeGObject)
  result.impl = g_socket_listener_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocketListener*[T](result: var T) =
  assert(result is SocketListener)
  new(result, finalizeGObject)
  result.impl = g_socket_listener_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_listener_accept*(self: ptr SocketListener00; sourceObject: var ptr gobject.Object00; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_listener_accept", libprag.}

proc accept*(self: ptr SocketListener00; sourceObject: var ptr gobject.Object00; 
    cancellable: ptr Cancellable00): ptr SocketConnection00 {.
    importc: "g_socket_listener_accept", libprag.}

proc g_socket_listener_accept_async*(self: ptr SocketListener00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_listener_accept_async", libprag.}

proc acceptAsync*(self: SocketListener; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_socket_listener_accept_async(cast[ptr SocketListener00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_listener_accept_finish*(self: ptr SocketListener00; resu: ptr AsyncResult00; 
    sourceObject: var ptr gobject.Object00): ptr SocketConnection00 {.
    importc: "g_socket_listener_accept_finish", libprag.}

proc acceptFinish*(self: ptr SocketListener00; resu: ptr AsyncResult00; 
    sourceObject: var ptr gobject.Object00): ptr SocketConnection00 {.
    importc: "g_socket_listener_accept_finish", libprag.}

proc g_socket_listener_accept_socket*(self: ptr SocketListener00; sourceObject: var ptr gobject.Object00; 
    cancellable: ptr Cancellable00): ptr Socket00 {.
    importc: "g_socket_listener_accept_socket", libprag.}

proc acceptSocket*(self: ptr SocketListener00; sourceObject: var ptr gobject.Object00; 
    cancellable: ptr Cancellable00): ptr Socket00 {.
    importc: "g_socket_listener_accept_socket", libprag.}

proc g_socket_listener_accept_socket_async*(self: ptr SocketListener00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_socket_listener_accept_socket_async", libprag.}

proc acceptSocketAsync*(self: SocketListener; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_socket_listener_accept_socket_async(cast[ptr SocketListener00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_socket_listener_accept_socket_finish*(self: ptr SocketListener00; resu: ptr AsyncResult00; 
    sourceObject: var ptr gobject.Object00): ptr Socket00 {.
    importc: "g_socket_listener_accept_socket_finish", libprag.}

proc acceptSocketFinish*(self: ptr SocketListener00; resu: ptr AsyncResult00; 
    sourceObject: var ptr gobject.Object00): ptr Socket00 {.
    importc: "g_socket_listener_accept_socket_finish", libprag.}

proc g_socket_listener_add_address*(self: ptr SocketListener00; address: ptr SocketAddress00; 
    `type`: SocketType; protocol: SocketProtocol; sourceObject: ptr gobject.Object00; effectiveAddress: var ptr SocketAddress00): gboolean {.
    importc: "g_socket_listener_add_address", libprag.}

proc addAddress*(self: ptr SocketListener00; address: ptr SocketAddress00; 
    `type`: SocketType; protocol: SocketProtocol; sourceObject: ptr gobject.Object00; effectiveAddress: var ptr SocketAddress00): gboolean {.
    importc: "g_socket_listener_add_address", libprag.}

proc g_socket_listener_add_any_inet_port*(self: ptr SocketListener00; sourceObject: ptr gobject.Object00): uint16 {.
    importc: "g_socket_listener_add_any_inet_port", libprag.}

proc addAnyInetPort*(self: SocketListener; sourceObject: gobject.Object): uint16 =
  g_socket_listener_add_any_inet_port(cast[ptr SocketListener00](self.impl), cast[ptr gobject.Object00](sourceObject.impl))

proc g_socket_listener_add_inet_port*(self: ptr SocketListener00; port: uint16; sourceObject: ptr gobject.Object00): gboolean {.
    importc: "g_socket_listener_add_inet_port", libprag.}

proc addInetPort*(self: SocketListener; port: uint16; sourceObject: gobject.Object): bool =
  toBool(g_socket_listener_add_inet_port(cast[ptr SocketListener00](self.impl), port, cast[ptr gobject.Object00](sourceObject.impl)))

proc g_socket_listener_add_socket*(self: ptr SocketListener00; socket: ptr Socket00; 
    sourceObject: ptr gobject.Object00): gboolean {.
    importc: "g_socket_listener_add_socket", libprag.}

proc addSocket*(self: SocketListener; socket: Socket; sourceObject: gobject.Object): bool =
  toBool(g_socket_listener_add_socket(cast[ptr SocketListener00](self.impl), cast[ptr Socket00](socket.impl), cast[ptr gobject.Object00](sourceObject.impl)))

proc g_socket_listener_close*(self: ptr SocketListener00) {.
    importc: "g_socket_listener_close", libprag.}

proc close*(self: SocketListener) =
  g_socket_listener_close(cast[ptr SocketListener00](self.impl))

proc g_socket_listener_set_backlog*(self: ptr SocketListener00; listenBacklog: int32) {.
    importc: "g_socket_listener_set_backlog", libprag.}

proc setBacklog*(self: SocketListener; listenBacklog: int) =
  g_socket_listener_set_backlog(cast[ptr SocketListener00](self.impl), int32(listenBacklog))

proc `backlog=`*(self: SocketListener; listenBacklog: int) =
  g_socket_listener_set_backlog(cast[ptr SocketListener00](self.impl), int32(listenBacklog))

type
  SocketListenerClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    changed*: proc(listener: ptr SocketListener00) {.cdecl.}
    event*: proc(listener: ptr SocketListener00; event: ptr SocketListenerEvent; 
    socket: ptr Socket00) {.cdecl.}
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  SocketListenerClass* = ref object
    impl*: ptr SocketListenerClass00

type
  SocketMsgFlag* {.size: sizeof(cint), pure.} = enum
    oob = 1
    peek = 2
    dontroute = 3

  SocketMsgFlags* {.size: sizeof(cint).} = set[SocketMsgFlag]

type
  SocketServicePrivate00* {.pure.} = object
  SocketServicePrivate* = ref object
    impl*: ptr SocketServicePrivate00

type
  SocketService* = ref object of SocketListener
  SocketService00* = object of SocketListener00
    priv2: ptr SocketServicePrivate00

proc scIncoming*(self: SocketService;  p: proc (self: ptr gobject.Object00; connection: SocketConnection00; sourceObject: gobject.Object00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "incoming", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_socket_service_new*(): ptr SocketService00 {.
    importc: "g_socket_service_new", libprag.}

proc newSocketService*(): SocketService =
  new(result, finalizeGObject)
  result.impl = g_socket_service_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSocketService*[T](result: var T) =
  assert(result is SocketService)
  new(result, finalizeGObject)
  result.impl = g_socket_service_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_socket_service_is_active*(self: ptr SocketService00): gboolean {.
    importc: "g_socket_service_is_active", libprag.}

proc isActive*(self: SocketService): bool =
  toBool(g_socket_service_is_active(cast[ptr SocketService00](self.impl)))

proc g_socket_service_start*(self: ptr SocketService00) {.
    importc: "g_socket_service_start", libprag.}

proc start*(self: SocketService) =
  g_socket_service_start(cast[ptr SocketService00](self.impl))

proc g_socket_service_stop*(self: ptr SocketService00) {.
    importc: "g_socket_service_stop", libprag.}

proc stop*(self: SocketService) =
  g_socket_service_stop(cast[ptr SocketService00](self.impl))

type
  SocketServiceClass00* {.pure.} = object
    parentClass*: SocketListenerClass00
    incoming*: proc(service: ptr SocketService00; connection: ptr SocketConnection00; 
    sourceObject: ptr gobject.Object00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  SocketServiceClass* = ref object
    impl*: ptr SocketServiceClass00

type
  SocketSourceFunc* = proc (socket: ptr Socket00; condition: glib.IOCondition; 
    userData: pointer): gboolean {.cdecl.}

type
  SrvTarget00* {.pure.} = object
  SrvTarget* = ref object
    impl*: ptr SrvTarget00

proc g_srv_target_new*(hostname: cstring; port: uint16; priority: uint16; 
    weight: uint16): ptr SrvTarget00 {.
    importc: "g_srv_target_new", libprag.}

proc newSrvTarget*(hostname: string; port: uint16; priority: uint16; 
    weight: uint16): SrvTarget =
  new(result)
  result.impl = g_srv_target_new(cstring(hostname), port, priority, weight)

proc initSrvTarget*[T](result: var T; hostname: string; port: uint16; priority: uint16; 
    weight: uint16) =
  assert(result is SrvTarget)
  new(result)
  result.impl = g_srv_target_new(cstring(hostname), port, priority, weight)

proc g_srv_target_copy*(self: ptr SrvTarget00): ptr SrvTarget00 {.
    importc: "g_srv_target_copy", libprag.}

proc copy*(self: SrvTarget): SrvTarget =
  new(result)
  result.impl = g_srv_target_copy(cast[ptr SrvTarget00](self.impl))

proc g_srv_target_free*(self: ptr SrvTarget00) {.
    importc: "g_srv_target_free", libprag.}

proc free*(self: SrvTarget) =
  g_srv_target_free(cast[ptr SrvTarget00](self.impl))

proc g_srv_target_get_hostname*(self: ptr SrvTarget00): cstring {.
    importc: "g_srv_target_get_hostname", libprag.}

proc getHostname*(self: SrvTarget): string =
  let resul0 = g_srv_target_get_hostname(cast[ptr SrvTarget00](self.impl))
  result = $resul0

proc hostname*(self: SrvTarget): string =
  let resul0 = g_srv_target_get_hostname(cast[ptr SrvTarget00](self.impl))
  result = $resul0

proc g_srv_target_get_port*(self: ptr SrvTarget00): uint16 {.
    importc: "g_srv_target_get_port", libprag.}

proc getPort*(self: SrvTarget): uint16 =
  g_srv_target_get_port(cast[ptr SrvTarget00](self.impl))

proc port*(self: SrvTarget): uint16 =
  g_srv_target_get_port(cast[ptr SrvTarget00](self.impl))

proc g_srv_target_get_priority*(self: ptr SrvTarget00): uint16 {.
    importc: "g_srv_target_get_priority", libprag.}

proc getPriority*(self: SrvTarget): uint16 =
  g_srv_target_get_priority(cast[ptr SrvTarget00](self.impl))

proc priority*(self: SrvTarget): uint16 =
  g_srv_target_get_priority(cast[ptr SrvTarget00](self.impl))

proc g_srv_target_get_weight*(self: ptr SrvTarget00): uint16 {.
    importc: "g_srv_target_get_weight", libprag.}

proc getWeight*(self: SrvTarget): uint16 =
  g_srv_target_get_weight(cast[ptr SrvTarget00](self.impl))

proc weight*(self: SrvTarget): uint16 =
  g_srv_target_get_weight(cast[ptr SrvTarget00](self.impl))

type
  StaticResource00* {.pure.} = object
    data*: ptr uint8
    dataLen*: uint64
    resource*: ptr Resource00
    next*: ptr StaticResource00
    padding*: pointer
  StaticResource* = ref object
    impl*: ptr StaticResource00

proc g_static_resource_fini*(self: ptr StaticResource00) {.
    importc: "g_static_resource_fini", libprag.}

proc fini*(self: StaticResource) =
  g_static_resource_fini(cast[ptr StaticResource00](self.impl))

proc g_static_resource_get_resource*(self: ptr StaticResource00): ptr Resource00 {.
    importc: "g_static_resource_get_resource", libprag.}

proc getResource*(self: StaticResource): Resource =
  new(result)
  result.impl = g_static_resource_get_resource(cast[ptr StaticResource00](self.impl))

proc resource*(self: StaticResource): Resource =
  new(result)
  result.impl = g_static_resource_get_resource(cast[ptr StaticResource00](self.impl))

proc g_static_resource_init*(self: ptr StaticResource00) {.
    importc: "g_static_resource_init", libprag.}

proc init*(self: StaticResource) =
  g_static_resource_init(cast[ptr StaticResource00](self.impl))

type
  Subprocess* = ref object of gobject.Object
  Subprocess00* = object of gobject.Object00

proc g_subprocess_communicate*(self: ptr Subprocess00; stdinBuf: ptr glib.Bytes00; 
    cancellable: ptr Cancellable00; stdoutBuf: var ptr glib.Bytes00; stderrBuf: var ptr glib.Bytes00): gboolean {.
    importc: "g_subprocess_communicate", libprag.}

proc communicate*(self: ptr Subprocess00; stdinBuf: ptr glib.Bytes00; 
    cancellable: ptr Cancellable00; stdoutBuf: var ptr glib.Bytes00; stderrBuf: var ptr glib.Bytes00): gboolean {.
    importc: "g_subprocess_communicate", libprag.}

proc g_subprocess_communicate_async*(self: ptr Subprocess00; stdinBuf: ptr glib.Bytes00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_subprocess_communicate_async", libprag.}

proc communicateAsync*(self: Subprocess; stdinBuf: glib.Bytes; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_subprocess_communicate_async(cast[ptr Subprocess00](self.impl), cast[ptr glib.Bytes00](stdinBuf.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_subprocess_communicate_finish*(self: ptr Subprocess00; resu: ptr AsyncResult00; stdoutBuf: var ptr glib.Bytes00; 
    stderrBuf: var ptr glib.Bytes00): gboolean {.
    importc: "g_subprocess_communicate_finish", libprag.}

proc communicateFinish*(self: ptr Subprocess00; resu: ptr AsyncResult00; stdoutBuf: var ptr glib.Bytes00; 
    stderrBuf: var ptr glib.Bytes00): gboolean {.
    importc: "g_subprocess_communicate_finish", libprag.}

proc g_subprocess_communicate_utf8*(self: ptr Subprocess00; stdinBuf: cstring; cancellable: ptr Cancellable00; 
    stdoutBuf: var cstring; stderrBuf: var cstring): gboolean {.
    importc: "g_subprocess_communicate_utf8", libprag.}

proc communicateUtf8*(self: Subprocess; stdinBuf: string; cancellable: Cancellable; 
    stdoutBuf: var string; stderrBuf: var string): bool =
  var stdoutBuf_00 = cstring(stdoutBuf)
  var stderrBuf_00 = cstring(stderrBuf)
  result = toBool(g_subprocess_communicate_utf8(cast[ptr Subprocess00](self.impl), cstring(stdinBuf), cast[ptr Cancellable00](cancellable.impl), stdoutBuf_00, stderrBuf_00))
  stdoutBuf = $(stdoutBuf_00)
  stderrBuf = $(stderrBuf_00)

proc g_subprocess_communicate_utf8_async*(self: ptr Subprocess00; stdinBuf: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_subprocess_communicate_utf8_async", libprag.}

proc communicateUtf8Async*(self: Subprocess; stdinBuf: string; cancellable: Cancellable; 
    callback: AsyncReadyCallback; userData: pointer) =
  g_subprocess_communicate_utf8_async(cast[ptr Subprocess00](self.impl), cstring(stdinBuf), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_subprocess_communicate_utf8_finish*(self: ptr Subprocess00; resu: ptr AsyncResult00; stdoutBuf: var cstring; 
    stderrBuf: var cstring): gboolean {.
    importc: "g_subprocess_communicate_utf8_finish", libprag.}

proc communicateUtf8Finish*(self: Subprocess; resu: AsyncResult; stdoutBuf: var string; 
    stderrBuf: var string): bool =
  var stdoutBuf_00 = cstring(stdoutBuf)
  var stderrBuf_00 = cstring(stderrBuf)
  result = toBool(g_subprocess_communicate_utf8_finish(cast[ptr Subprocess00](self.impl), cast[ptr AsyncResult00](resu.impl), stdoutBuf_00, stderrBuf_00))
  stdoutBuf = $(stdoutBuf_00)
  stderrBuf = $(stderrBuf_00)

proc g_subprocess_force_exit*(self: ptr Subprocess00) {.
    importc: "g_subprocess_force_exit", libprag.}

proc forceExit*(self: Subprocess) =
  g_subprocess_force_exit(cast[ptr Subprocess00](self.impl))

proc g_subprocess_get_exit_status*(self: ptr Subprocess00): int32 {.
    importc: "g_subprocess_get_exit_status", libprag.}

proc getExitStatus*(self: Subprocess): int =
  int(g_subprocess_get_exit_status(cast[ptr Subprocess00](self.impl)))

proc exitStatus*(self: Subprocess): int =
  int(g_subprocess_get_exit_status(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_get_identifier*(self: ptr Subprocess00): cstring {.
    importc: "g_subprocess_get_identifier", libprag.}

proc getIdentifier*(self: Subprocess): string =
  let resul0 = g_subprocess_get_identifier(cast[ptr Subprocess00](self.impl))
  result = $resul0

proc identifier*(self: Subprocess): string =
  let resul0 = g_subprocess_get_identifier(cast[ptr Subprocess00](self.impl))
  result = $resul0

proc g_subprocess_get_if_exited*(self: ptr Subprocess00): gboolean {.
    importc: "g_subprocess_get_if_exited", libprag.}

proc getIfExited*(self: Subprocess): bool =
  toBool(g_subprocess_get_if_exited(cast[ptr Subprocess00](self.impl)))

proc ifExited*(self: Subprocess): bool =
  toBool(g_subprocess_get_if_exited(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_get_if_signaled*(self: ptr Subprocess00): gboolean {.
    importc: "g_subprocess_get_if_signaled", libprag.}

proc getIfSignaled*(self: Subprocess): bool =
  toBool(g_subprocess_get_if_signaled(cast[ptr Subprocess00](self.impl)))

proc ifSignaled*(self: Subprocess): bool =
  toBool(g_subprocess_get_if_signaled(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_get_status*(self: ptr Subprocess00): int32 {.
    importc: "g_subprocess_get_status", libprag.}

proc getStatus*(self: Subprocess): int =
  int(g_subprocess_get_status(cast[ptr Subprocess00](self.impl)))

proc status*(self: Subprocess): int =
  int(g_subprocess_get_status(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_get_stderr_pipe*(self: ptr Subprocess00): ptr InputStream00 {.
    importc: "g_subprocess_get_stderr_pipe", libprag.}

proc getStderrPipe*(self: Subprocess): InputStream =
  let gobj = g_subprocess_get_stderr_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc stderrPipe*(self: Subprocess): InputStream =
  let gobj = g_subprocess_get_stderr_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc g_subprocess_get_stdin_pipe*(self: ptr Subprocess00): ptr OutputStream00 {.
    importc: "g_subprocess_get_stdin_pipe", libprag.}

proc getStdinPipe*(self: Subprocess): OutputStream =
  let gobj = g_subprocess_get_stdin_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc stdinPipe*(self: Subprocess): OutputStream =
  let gobj = g_subprocess_get_stdin_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[OutputStream](g_object_get_qdata(gobj, Quark))
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

proc g_subprocess_get_stdout_pipe*(self: ptr Subprocess00): ptr InputStream00 {.
    importc: "g_subprocess_get_stdout_pipe", libprag.}

proc getStdoutPipe*(self: Subprocess): InputStream =
  let gobj = g_subprocess_get_stdout_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc stdoutPipe*(self: Subprocess): InputStream =
  let gobj = g_subprocess_get_stdout_pipe(cast[ptr Subprocess00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc g_subprocess_get_successful*(self: ptr Subprocess00): gboolean {.
    importc: "g_subprocess_get_successful", libprag.}

proc getSuccessful*(self: Subprocess): bool =
  toBool(g_subprocess_get_successful(cast[ptr Subprocess00](self.impl)))

proc successful*(self: Subprocess): bool =
  toBool(g_subprocess_get_successful(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_get_term_sig*(self: ptr Subprocess00): int32 {.
    importc: "g_subprocess_get_term_sig", libprag.}

proc getTermSig*(self: Subprocess): int =
  int(g_subprocess_get_term_sig(cast[ptr Subprocess00](self.impl)))

proc termSig*(self: Subprocess): int =
  int(g_subprocess_get_term_sig(cast[ptr Subprocess00](self.impl)))

proc g_subprocess_send_signal*(self: ptr Subprocess00; signalNum: int32) {.
    importc: "g_subprocess_send_signal", libprag.}

proc sendSignal*(self: Subprocess; signalNum: int) =
  g_subprocess_send_signal(cast[ptr Subprocess00](self.impl), int32(signalNum))

proc g_subprocess_wait*(self: ptr Subprocess00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_subprocess_wait", libprag.}

proc wait*(self: Subprocess; cancellable: Cancellable): bool =
  toBool(g_subprocess_wait(cast[ptr Subprocess00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_subprocess_wait_async*(self: ptr Subprocess00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_subprocess_wait_async", libprag.}

proc waitAsync*(self: Subprocess; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_subprocess_wait_async(cast[ptr Subprocess00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_subprocess_wait_check*(self: ptr Subprocess00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_subprocess_wait_check", libprag.}

proc waitCheck*(self: Subprocess; cancellable: Cancellable): bool =
  toBool(g_subprocess_wait_check(cast[ptr Subprocess00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_subprocess_wait_check_async*(self: ptr Subprocess00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_subprocess_wait_check_async", libprag.}

proc waitCheckAsync*(self: Subprocess; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_subprocess_wait_check_async(cast[ptr Subprocess00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_subprocess_wait_check_finish*(self: ptr Subprocess00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_subprocess_wait_check_finish", libprag.}

proc waitCheckFinish*(self: Subprocess; resu: AsyncResult): bool =
  toBool(g_subprocess_wait_check_finish(cast[ptr Subprocess00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_subprocess_wait_finish*(self: ptr Subprocess00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_subprocess_wait_finish", libprag.}

proc waitFinish*(self: Subprocess; resu: AsyncResult): bool =
  toBool(g_subprocess_wait_finish(cast[ptr Subprocess00](self.impl), cast[ptr AsyncResult00](resu.impl)))

type
  SubprocessFlag* {.size: sizeof(cint), pure.} = enum
    stdinPipe = 1
    stdinInherit = 2
    stdoutPipe = 3
    stdoutSilence = 4
    stderrPipe = 5
    stderrSilence = 6
    stderrMerge = 7
    inheritFds = 8

  SubprocessFlags* {.size: sizeof(cint).} = set[SubprocessFlag]

proc g_subprocess_newv*(argv: cstringArray; flags: SubprocessFlags): ptr Subprocess00 {.
    importc: "g_subprocess_newv", libprag.}

proc newSubprocess*(argv: cstringArray; flags: SubprocessFlags): Subprocess =
  new(result, finalizeGObject)
  result.impl = g_subprocess_newv(argv, flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSubprocess*[T](result: var T; argv: cstringArray; flags: SubprocessFlags) =
  assert(result is Subprocess)
  new(result, finalizeGObject)
  result.impl = g_subprocess_newv(argv, flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  SubprocessLauncher* = ref object of gobject.Object
  SubprocessLauncher00* = object of gobject.Object00

proc g_subprocess_launcher_new*(flags: SubprocessFlags): ptr SubprocessLauncher00 {.
    importc: "g_subprocess_launcher_new", libprag.}

proc newSubprocessLauncher*(flags: SubprocessFlags): SubprocessLauncher =
  new(result, finalizeGObject)
  result.impl = g_subprocess_launcher_new(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initSubprocessLauncher*[T](result: var T; flags: SubprocessFlags) =
  assert(result is SubprocessLauncher)
  new(result, finalizeGObject)
  result.impl = g_subprocess_launcher_new(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_subprocess_launcher_getenv*(self: ptr SubprocessLauncher00; variable: cstring): cstring {.
    importc: "g_subprocess_launcher_getenv", libprag.}

proc getenv*(self: SubprocessLauncher; variable: string): string =
  let resul0 = g_subprocess_launcher_getenv(cast[ptr SubprocessLauncher00](self.impl), cstring(variable))
  result = $resul0

proc env*(self: SubprocessLauncher; variable: string): string =
  let resul0 = g_subprocess_launcher_getenv(cast[ptr SubprocessLauncher00](self.impl), cstring(variable))
  result = $resul0

proc g_subprocess_launcher_set_child_setup*(self: ptr SubprocessLauncher00; childSetup: SpawnChildSetupFunc; 
    userData: pointer; destroyNotify: DestroyNotify) {.
    importc: "g_subprocess_launcher_set_child_setup", libprag.}

proc setChildSetup*(self: SubprocessLauncher; childSetup: SpawnChildSetupFunc; 
    userData: pointer; destroyNotify: DestroyNotify) =
  g_subprocess_launcher_set_child_setup(cast[ptr SubprocessLauncher00](self.impl), childSetup, userData, destroyNotify)

proc g_subprocess_launcher_set_cwd*(self: ptr SubprocessLauncher00; cwd: ucstring) {.
    importc: "g_subprocess_launcher_set_cwd", libprag.}

proc setCwd*(self: SubprocessLauncher; cwd: ucstring) =
  g_subprocess_launcher_set_cwd(cast[ptr SubprocessLauncher00](self.impl), cwd)

proc `cwd=`*(self: SubprocessLauncher; cwd: ucstring) =
  g_subprocess_launcher_set_cwd(cast[ptr SubprocessLauncher00](self.impl), cwd)

proc g_subprocess_launcher_set_environ*(self: ptr SubprocessLauncher00; env: cstringArray) {.
    importc: "g_subprocess_launcher_set_environ", libprag.}

proc setEnviron*(self: SubprocessLauncher; env: cstringArray) =
  g_subprocess_launcher_set_environ(cast[ptr SubprocessLauncher00](self.impl), env)

proc `environ=`*(self: SubprocessLauncher; env: cstringArray) =
  g_subprocess_launcher_set_environ(cast[ptr SubprocessLauncher00](self.impl), env)

proc g_subprocess_launcher_set_flags*(self: ptr SubprocessLauncher00; flags: SubprocessFlags) {.
    importc: "g_subprocess_launcher_set_flags", libprag.}

proc setFlags*(self: SubprocessLauncher; flags: SubprocessFlags) =
  g_subprocess_launcher_set_flags(cast[ptr SubprocessLauncher00](self.impl), flags)

proc `flags=`*(self: SubprocessLauncher; flags: SubprocessFlags) =
  g_subprocess_launcher_set_flags(cast[ptr SubprocessLauncher00](self.impl), flags)

proc g_subprocess_launcher_set_stderr_file_path*(self: ptr SubprocessLauncher00; path: ucstring) {.
    importc: "g_subprocess_launcher_set_stderr_file_path", libprag.}

proc setStderrFilePath*(self: SubprocessLauncher; path: ucstring) =
  g_subprocess_launcher_set_stderr_file_path(cast[ptr SubprocessLauncher00](self.impl), path)

proc `stderrFilePath=`*(self: SubprocessLauncher; path: ucstring) =
  g_subprocess_launcher_set_stderr_file_path(cast[ptr SubprocessLauncher00](self.impl), path)

proc g_subprocess_launcher_set_stdin_file_path*(self: ptr SubprocessLauncher00; path: cstring) {.
    importc: "g_subprocess_launcher_set_stdin_file_path", libprag.}

proc setStdinFilePath*(self: SubprocessLauncher; path: string) =
  g_subprocess_launcher_set_stdin_file_path(cast[ptr SubprocessLauncher00](self.impl), cstring(path))

proc `stdinFilePath=`*(self: SubprocessLauncher; path: string) =
  g_subprocess_launcher_set_stdin_file_path(cast[ptr SubprocessLauncher00](self.impl), cstring(path))

proc g_subprocess_launcher_set_stdout_file_path*(self: ptr SubprocessLauncher00; path: ucstring) {.
    importc: "g_subprocess_launcher_set_stdout_file_path", libprag.}

proc setStdoutFilePath*(self: SubprocessLauncher; path: ucstring) =
  g_subprocess_launcher_set_stdout_file_path(cast[ptr SubprocessLauncher00](self.impl), path)

proc `stdoutFilePath=`*(self: SubprocessLauncher; path: ucstring) =
  g_subprocess_launcher_set_stdout_file_path(cast[ptr SubprocessLauncher00](self.impl), path)

proc g_subprocess_launcher_setenv*(self: ptr SubprocessLauncher00; variable: cstring; 
    value: cstring; overwrite: gboolean) {.
    importc: "g_subprocess_launcher_setenv", libprag.}

proc setenv*(self: SubprocessLauncher; variable: string; value: string; 
    overwrite: bool) =
  g_subprocess_launcher_setenv(cast[ptr SubprocessLauncher00](self.impl), cstring(variable), cstring(value), gboolean(overwrite))

proc g_subprocess_launcher_spawnv*(self: ptr SubprocessLauncher00; argv: cstringArray): ptr Subprocess00 {.
    importc: "g_subprocess_launcher_spawnv", libprag.}

proc spawnv*(self: SubprocessLauncher; argv: cstringArray): Subprocess =
  let gobj = g_subprocess_launcher_spawnv(cast[ptr SubprocessLauncher00](self.impl), argv)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Subprocess](g_object_get_qdata(gobj, Quark))
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

proc g_subprocess_launcher_take_fd*(self: ptr SubprocessLauncher00; sourceFd: int32; targetFd: int32) {.
    importc: "g_subprocess_launcher_take_fd", libprag.}

proc takeFd*(self: SubprocessLauncher; sourceFd: int; targetFd: int) =
  g_subprocess_launcher_take_fd(cast[ptr SubprocessLauncher00](self.impl), int32(sourceFd), int32(targetFd))

proc g_subprocess_launcher_take_stderr_fd*(self: ptr SubprocessLauncher00; fd: int32) {.
    importc: "g_subprocess_launcher_take_stderr_fd", libprag.}

proc takeStderrFd*(self: SubprocessLauncher; fd: int) =
  g_subprocess_launcher_take_stderr_fd(cast[ptr SubprocessLauncher00](self.impl), int32(fd))

proc g_subprocess_launcher_take_stdin_fd*(self: ptr SubprocessLauncher00; fd: int32) {.
    importc: "g_subprocess_launcher_take_stdin_fd", libprag.}

proc takeStdinFd*(self: SubprocessLauncher; fd: int) =
  g_subprocess_launcher_take_stdin_fd(cast[ptr SubprocessLauncher00](self.impl), int32(fd))

proc g_subprocess_launcher_take_stdout_fd*(self: ptr SubprocessLauncher00; fd: int32) {.
    importc: "g_subprocess_launcher_take_stdout_fd", libprag.}

proc takeStdoutFd*(self: SubprocessLauncher; fd: int) =
  g_subprocess_launcher_take_stdout_fd(cast[ptr SubprocessLauncher00](self.impl), int32(fd))

proc g_subprocess_launcher_unsetenv*(self: ptr SubprocessLauncher00; variable: cstring) {.
    importc: "g_subprocess_launcher_unsetenv", libprag.}

proc unsetenv*(self: SubprocessLauncher; variable: string) =
  g_subprocess_launcher_unsetenv(cast[ptr SubprocessLauncher00](self.impl), cstring(variable))

const TLS_BACKEND_EXTENSION_POINT_NAME* = "gio-tls-backend"

const TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT* = "1.3.6.1.5.5.7.3.2"

const TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER* = "1.3.6.1.5.5.7.3.1"

type
  Task* = ref object of gobject.Object
  Task00* = object of gobject.Object00

proc g_task_new*(sourceObject: ptr gobject.Object00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; callbackData: pointer): ptr Task00 {.
    importc: "g_task_new", libprag.}

proc newTask*(sourceObject: gobject.Object; cancellable: Cancellable; 
    callback: AsyncReadyCallback; callbackData: pointer): Task =
  new(result, finalizeGObject)
  result.impl = g_task_new(cast[ptr gobject.Object00](sourceObject.impl), cast[ptr Cancellable00](cancellable.impl), callback, callbackData)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTask*[T](result: var T; sourceObject: gobject.Object; cancellable: Cancellable; 
    callback: AsyncReadyCallback; callbackData: pointer) =
  assert(result is Task)
  new(result, finalizeGObject)
  result.impl = g_task_new(cast[ptr gobject.Object00](sourceObject.impl), cast[ptr Cancellable00](cancellable.impl), callback, callbackData)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_task_is_valid*(resu: ptr AsyncResult00; sourceObject: ptr gobject.Object00): gboolean {.
    importc: "g_task_is_valid", libprag.}

proc isValid*(resu: AsyncResult; sourceObject: gobject.Object): bool =
  toBool(g_task_is_valid(cast[ptr AsyncResult00](resu.impl), cast[ptr gobject.Object00](sourceObject.impl)))

proc g_task_report_error*(sourceObject: ptr gobject.Object00; callback: AsyncReadyCallback; 
    callbackData: pointer; sourceTag: pointer; error: ptr Error00) {.
    importc: "g_task_report_error", libprag.}

proc reportError*(sourceObject: gobject.Object; callback: AsyncReadyCallback; 
    callbackData: pointer; sourceTag: pointer; error: ptr Error00) =
  g_task_report_error(cast[ptr gobject.Object00](sourceObject.impl), callback, callbackData, sourceTag, error)

proc g_task_get_cancellable*(self: ptr Task00): ptr Cancellable00 {.
    importc: "g_task_get_cancellable", libprag.}

proc getCancellable*(self: Task): Cancellable =
  let gobj = g_task_get_cancellable(cast[ptr Task00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cancellable](g_object_get_qdata(gobj, Quark))
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

proc cancellable*(self: Task): Cancellable =
  let gobj = g_task_get_cancellable(cast[ptr Task00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Cancellable](g_object_get_qdata(gobj, Quark))
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

proc g_task_get_check_cancellable*(self: ptr Task00): gboolean {.
    importc: "g_task_get_check_cancellable", libprag.}

proc getCheckCancellable*(self: Task): bool =
  toBool(g_task_get_check_cancellable(cast[ptr Task00](self.impl)))

proc checkCancellable*(self: Task): bool =
  toBool(g_task_get_check_cancellable(cast[ptr Task00](self.impl)))

proc g_task_get_completed*(self: ptr Task00): gboolean {.
    importc: "g_task_get_completed", libprag.}

proc getCompleted*(self: Task): bool =
  toBool(g_task_get_completed(cast[ptr Task00](self.impl)))

proc completed*(self: Task): bool =
  toBool(g_task_get_completed(cast[ptr Task00](self.impl)))

proc g_task_get_context*(self: ptr Task00): ptr glib.MainContext00 {.
    importc: "g_task_get_context", libprag.}

proc getContext*(self: Task): glib.MainContext =
  new(result)
  result.impl = g_task_get_context(cast[ptr Task00](self.impl))

proc context*(self: Task): glib.MainContext =
  new(result)
  result.impl = g_task_get_context(cast[ptr Task00](self.impl))

proc g_task_get_priority*(self: ptr Task00): int32 {.
    importc: "g_task_get_priority", libprag.}

proc getPriority*(self: Task): int =
  int(g_task_get_priority(cast[ptr Task00](self.impl)))

proc priority*(self: Task): int =
  int(g_task_get_priority(cast[ptr Task00](self.impl)))

proc g_task_get_return_on_cancel*(self: ptr Task00): gboolean {.
    importc: "g_task_get_return_on_cancel", libprag.}

proc getReturnOnCancel*(self: Task): bool =
  toBool(g_task_get_return_on_cancel(cast[ptr Task00](self.impl)))

proc returnOnCancel*(self: Task): bool =
  toBool(g_task_get_return_on_cancel(cast[ptr Task00](self.impl)))

proc g_task_get_source_object*(self: ptr Task00): ptr gobject.Object00 {.
    importc: "g_task_get_source_object", libprag.}

proc getSourceObject*(self: Task): gobject.Object =
  let gobj = g_task_get_source_object(cast[ptr Task00](self.impl))
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

proc sourceObject*(self: Task): gobject.Object =
  let gobj = g_task_get_source_object(cast[ptr Task00](self.impl))
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

proc g_task_get_source_tag*(self: ptr Task00): pointer {.
    importc: "g_task_get_source_tag", libprag.}

proc getSourceTag*(self: Task): pointer =
  g_task_get_source_tag(cast[ptr Task00](self.impl))

proc sourceTag*(self: Task): pointer =
  g_task_get_source_tag(cast[ptr Task00](self.impl))

proc g_task_get_task_data*(self: ptr Task00): pointer {.
    importc: "g_task_get_task_data", libprag.}

proc getTaskData*(self: Task): pointer =
  g_task_get_task_data(cast[ptr Task00](self.impl))

proc taskData*(self: Task): pointer =
  g_task_get_task_data(cast[ptr Task00](self.impl))

proc g_task_had_error*(self: ptr Task00): gboolean {.
    importc: "g_task_had_error", libprag.}

proc hadError*(self: Task): bool =
  toBool(g_task_had_error(cast[ptr Task00](self.impl)))

proc g_task_propagate_boolean*(self: ptr Task00): gboolean {.
    importc: "g_task_propagate_boolean", libprag.}

proc propagateBoolean*(self: Task): bool =
  toBool(g_task_propagate_boolean(cast[ptr Task00](self.impl)))

proc g_task_propagate_int*(self: ptr Task00): int64 {.
    importc: "g_task_propagate_int", libprag.}

proc propagateInt*(self: Task): int64 =
  g_task_propagate_int(cast[ptr Task00](self.impl))

proc g_task_propagate_pointer*(self: ptr Task00): pointer {.
    importc: "g_task_propagate_pointer", libprag.}

proc propagatePointer*(self: Task): pointer =
  g_task_propagate_pointer(cast[ptr Task00](self.impl))

proc g_task_return_boolean*(self: ptr Task00; resu: gboolean) {.
    importc: "g_task_return_boolean", libprag.}

proc returnBoolean*(self: Task; resu: bool) =
  g_task_return_boolean(cast[ptr Task00](self.impl), gboolean(resu))

proc g_task_return_error*(self: ptr Task00; error: ptr Error00) {.
    importc: "g_task_return_error", libprag.}

proc returnError*(self: Task; error: ptr Error00) =
  g_task_return_error(cast[ptr Task00](self.impl), error)

proc g_task_return_error_if_cancelled*(self: ptr Task00): gboolean {.
    importc: "g_task_return_error_if_cancelled", libprag.}

proc returnErrorIfCancelled*(self: Task): bool =
  toBool(g_task_return_error_if_cancelled(cast[ptr Task00](self.impl)))

proc g_task_return_int*(self: ptr Task00; resu: int64) {.
    importc: "g_task_return_int", libprag.}

proc returnInt*(self: Task; resu: int64) =
  g_task_return_int(cast[ptr Task00](self.impl), resu)

proc g_task_return_pointer*(self: ptr Task00; resu: pointer; resultDestroy: DestroyNotify) {.
    importc: "g_task_return_pointer", libprag.}

proc returnPointer*(self: Task; resu: pointer; resultDestroy: DestroyNotify) =
  g_task_return_pointer(cast[ptr Task00](self.impl), resu, resultDestroy)

proc g_task_set_check_cancellable*(self: ptr Task00; checkCancellable: gboolean) {.
    importc: "g_task_set_check_cancellable", libprag.}

proc setCheckCancellable*(self: Task; checkCancellable: bool) =
  g_task_set_check_cancellable(cast[ptr Task00](self.impl), gboolean(checkCancellable))

proc `checkCancellable=`*(self: Task; checkCancellable: bool) =
  g_task_set_check_cancellable(cast[ptr Task00](self.impl), gboolean(checkCancellable))

proc g_task_set_priority*(self: ptr Task00; priority: int32) {.
    importc: "g_task_set_priority", libprag.}

proc setPriority*(self: Task; priority: int) =
  g_task_set_priority(cast[ptr Task00](self.impl), int32(priority))

proc `priority=`*(self: Task; priority: int) =
  g_task_set_priority(cast[ptr Task00](self.impl), int32(priority))

proc g_task_set_return_on_cancel*(self: ptr Task00; returnOnCancel: gboolean): gboolean {.
    importc: "g_task_set_return_on_cancel", libprag.}

proc setReturnOnCancel*(self: Task; returnOnCancel: bool): bool =
  toBool(g_task_set_return_on_cancel(cast[ptr Task00](self.impl), gboolean(returnOnCancel)))

proc `returnOnCancel=`*(self: Task; returnOnCancel: bool): bool =
  toBool(g_task_set_return_on_cancel(cast[ptr Task00](self.impl), gboolean(returnOnCancel)))

proc g_task_set_source_tag*(self: ptr Task00; sourceTag: pointer) {.
    importc: "g_task_set_source_tag", libprag.}

proc setSourceTag*(self: Task; sourceTag: pointer) =
  g_task_set_source_tag(cast[ptr Task00](self.impl), sourceTag)

proc `sourceTag=`*(self: Task; sourceTag: pointer) =
  g_task_set_source_tag(cast[ptr Task00](self.impl), sourceTag)

proc g_task_set_task_data*(self: ptr Task00; taskData: pointer; taskDataDestroy: DestroyNotify) {.
    importc: "g_task_set_task_data", libprag.}

proc setTaskData*(self: Task; taskData: pointer; taskDataDestroy: DestroyNotify) =
  g_task_set_task_data(cast[ptr Task00](self.impl), taskData, taskDataDestroy)

type
  TaskClass00* {.pure.} = object
  TaskClass* = ref object
    impl*: ptr TaskClass00

type
  TaskThreadFunc* = proc (task: ptr Task00; sourceObject: ptr gobject.Object00; 
    taskData: pointer; cancellable: ptr Cancellable00) {.cdecl.}

type
  TcpConnectionPrivate00* {.pure.} = object
  TcpConnectionPrivate* = ref object
    impl*: ptr TcpConnectionPrivate00

type
  TcpConnection* = ref object of SocketConnection
  TcpConnection00* = object of SocketConnection00
    priv3: ptr TcpConnectionPrivate00

proc g_tcp_connection_get_graceful_disconnect*(self: ptr TcpConnection00): gboolean {.
    importc: "g_tcp_connection_get_graceful_disconnect", libprag.}

proc getGracefulDisconnect*(self: TcpConnection): bool =
  toBool(g_tcp_connection_get_graceful_disconnect(cast[ptr TcpConnection00](self.impl)))

proc gracefulDisconnect*(self: TcpConnection): bool =
  toBool(g_tcp_connection_get_graceful_disconnect(cast[ptr TcpConnection00](self.impl)))

proc g_tcp_connection_set_graceful_disconnect*(self: ptr TcpConnection00; gracefulDisconnect: gboolean) {.
    importc: "g_tcp_connection_set_graceful_disconnect", libprag.}

proc setGracefulDisconnect*(self: TcpConnection; gracefulDisconnect: bool) =
  g_tcp_connection_set_graceful_disconnect(cast[ptr TcpConnection00](self.impl), gboolean(gracefulDisconnect))

proc `gracefulDisconnect=`*(self: TcpConnection; gracefulDisconnect: bool) =
  g_tcp_connection_set_graceful_disconnect(cast[ptr TcpConnection00](self.impl), gboolean(gracefulDisconnect))

type
  TcpConnectionClass00* {.pure.} = object
    parentClass*: SocketConnectionClass00
  TcpConnectionClass* = ref object
    impl*: ptr TcpConnectionClass00

type
  TcpWrapperConnectionPrivate00* {.pure.} = object
  TcpWrapperConnectionPrivate* = ref object
    impl*: ptr TcpWrapperConnectionPrivate00

type
  TcpWrapperConnection* = ref object of TcpConnection
  TcpWrapperConnection00* = object of TcpConnection00
    priv4: ptr TcpWrapperConnectionPrivate00

proc g_tcp_wrapper_connection_new*(baseIoStream: ptr IOStream00; socket: ptr Socket00): ptr TcpWrapperConnection00 {.
    importc: "g_tcp_wrapper_connection_new", libprag.}

proc newTcpWrapperConnection*(baseIoStream: IOStream; socket: Socket): TcpWrapperConnection =
  new(result, finalizeGObject)
  result.impl = g_tcp_wrapper_connection_new(cast[ptr IOStream00](baseIoStream.impl), cast[ptr Socket00](socket.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTcpWrapperConnection*[T](result: var T; baseIoStream: IOStream; socket: Socket) =
  assert(result is TcpWrapperConnection)
  new(result, finalizeGObject)
  result.impl = g_tcp_wrapper_connection_new(cast[ptr IOStream00](baseIoStream.impl), cast[ptr Socket00](socket.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_tcp_wrapper_connection_get_base_io_stream*(self: ptr TcpWrapperConnection00): ptr IOStream00 {.
    importc: "g_tcp_wrapper_connection_get_base_io_stream", libprag.}

proc getBaseIoStream*(self: TcpWrapperConnection): IOStream =
  let gobj = g_tcp_wrapper_connection_get_base_io_stream(cast[ptr TcpWrapperConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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

proc baseIoStream*(self: TcpWrapperConnection): IOStream =
  let gobj = g_tcp_wrapper_connection_get_base_io_stream(cast[ptr TcpWrapperConnection00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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
  TcpWrapperConnectionClass00* {.pure.} = object
    parentClass*: TcpConnectionClass00
  TcpWrapperConnectionClass* = ref object
    impl*: ptr TcpWrapperConnectionClass00

type
  TestDBus* = ref object of gobject.Object
  TestDBus00* = object of gobject.Object00

proc g_test_dbus_unset*() {.
    importc: "g_test_dbus_unset", libprag.}

proc unset*() {.
    importc: "g_test_dbus_unset", libprag.}

proc g_test_dbus_add_service_dir*(self: ptr TestDBus00; path: cstring) {.
    importc: "g_test_dbus_add_service_dir", libprag.}

proc addServiceDir*(self: TestDBus; path: string) =
  g_test_dbus_add_service_dir(cast[ptr TestDBus00](self.impl), cstring(path))

proc g_test_dbus_down*(self: ptr TestDBus00) {.
    importc: "g_test_dbus_down", libprag.}

proc down*(self: TestDBus) =
  g_test_dbus_down(cast[ptr TestDBus00](self.impl))

proc g_test_dbus_get_bus_address*(self: ptr TestDBus00): cstring {.
    importc: "g_test_dbus_get_bus_address", libprag.}

proc getBusAddress*(self: TestDBus): string =
  let resul0 = g_test_dbus_get_bus_address(cast[ptr TestDBus00](self.impl))
  result = $resul0

proc busAddress*(self: TestDBus): string =
  let resul0 = g_test_dbus_get_bus_address(cast[ptr TestDBus00](self.impl))
  result = $resul0

proc g_test_dbus_stop*(self: ptr TestDBus00) {.
    importc: "g_test_dbus_stop", libprag.}

proc stop*(self: TestDBus) =
  g_test_dbus_stop(cast[ptr TestDBus00](self.impl))

proc g_test_dbus_up*(self: ptr TestDBus00) {.
    importc: "g_test_dbus_up", libprag.}

proc up*(self: TestDBus) =
  g_test_dbus_up(cast[ptr TestDBus00](self.impl))

type
  TestDBusFlags* {.size: sizeof(cint), pure.} = enum
    none = 0

proc g_test_dbus_new*(flags: TestDBusFlags): ptr TestDBus00 {.
    importc: "g_test_dbus_new", libprag.}

proc newTestDBus*(flags: TestDBusFlags): TestDBus =
  new(result, finalizeGObject)
  result.impl = g_test_dbus_new(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initTestDBus*[T](result: var T; flags: TestDBusFlags) =
  assert(result is TestDBus)
  new(result, finalizeGObject)
  result.impl = g_test_dbus_new(flags)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_test_dbus_get_flags*(self: ptr TestDBus00): TestDBusFlags {.
    importc: "g_test_dbus_get_flags", libprag.}

proc getFlags*(self: TestDBus): TestDBusFlags =
  g_test_dbus_get_flags(cast[ptr TestDBus00](self.impl))

proc flags*(self: TestDBus): TestDBusFlags =
  g_test_dbus_get_flags(cast[ptr TestDBus00](self.impl))

type
  ThemedIcon* = ref object of gobject.Object
  ThemedIcon00* = object of gobject.Object00

proc g_themed_icon_new*(iconname: cstring): ptr ThemedIcon00 {.
    importc: "g_themed_icon_new", libprag.}

proc newThemedIcon*(iconname: string): ThemedIcon =
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new(cstring(iconname))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initThemedIcon*[T](result: var T; iconname: string) =
  assert(result is ThemedIcon)
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new(cstring(iconname))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_themed_icon_new_from_names*(iconnames: cstringArray; len: int32): ptr ThemedIcon00 {.
    importc: "g_themed_icon_new_from_names", libprag.}

proc newThemedIconFromNames*(iconnames: cstringArray; len: int): ThemedIcon =
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new_from_names(iconnames, int32(len))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initThemedIconFromNames*[T](result: var T; iconnames: cstringArray; len: int) =
  assert(result is ThemedIcon)
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new_from_names(iconnames, int32(len))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_themed_icon_new_with_default_fallbacks*(iconname: cstring): ptr ThemedIcon00 {.
    importc: "g_themed_icon_new_with_default_fallbacks", libprag.}

proc newThemedIconWithDefaultFallbacks*(iconname: string): ThemedIcon =
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new_with_default_fallbacks(cstring(iconname))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initThemedIconWithDefaultFallbacks*[T](result: var T; iconname: string) =
  assert(result is ThemedIcon)
  new(result, finalizeGObject)
  result.impl = g_themed_icon_new_with_default_fallbacks(cstring(iconname))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_themed_icon_append_name*(self: ptr ThemedIcon00; iconname: cstring) {.
    importc: "g_themed_icon_append_name", libprag.}

proc appendName*(self: ThemedIcon; iconname: string) =
  g_themed_icon_append_name(cast[ptr ThemedIcon00](self.impl), cstring(iconname))

proc g_themed_icon_get_names*(self: ptr ThemedIcon00): cstringArray {.
    importc: "g_themed_icon_get_names", libprag.}

proc getNames*(self: ThemedIcon): cstringArray =
  g_themed_icon_get_names(cast[ptr ThemedIcon00](self.impl))

proc names*(self: ThemedIcon): cstringArray =
  g_themed_icon_get_names(cast[ptr ThemedIcon00](self.impl))

proc g_themed_icon_prepend_name*(self: ptr ThemedIcon00; iconname: cstring) {.
    importc: "g_themed_icon_prepend_name", libprag.}

proc prependName*(self: ThemedIcon; iconname: string) =
  g_themed_icon_prepend_name(cast[ptr ThemedIcon00](self.impl), cstring(iconname))

type
  ThemedIconClass00* {.pure.} = object
  ThemedIconClass* = ref object
    impl*: ptr ThemedIconClass00

type
  ThreadedSocketServicePrivate00* {.pure.} = object
  ThreadedSocketServicePrivate* = ref object
    impl*: ptr ThreadedSocketServicePrivate00

type
  ThreadedSocketService* = ref object of SocketService
  ThreadedSocketService00* = object of SocketService00
    priv3: ptr ThreadedSocketServicePrivate00

proc scRun*(self: ThreadedSocketService;  p: proc (self: ptr gobject.Object00; connection: SocketConnection00; sourceObject: gobject.Object00; xdata: pointer): gboolean {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "run", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_threaded_socket_service_new*(maxThreads: int32): ptr ThreadedSocketService00 {.
    importc: "g_threaded_socket_service_new", libprag.}

proc newThreadedSocketService*(maxThreads: int): ThreadedSocketService =
  new(result, finalizeGObject)
  result.impl = g_threaded_socket_service_new(int32(maxThreads))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initThreadedSocketService*[T](result: var T; maxThreads: int) =
  assert(result is ThreadedSocketService)
  new(result, finalizeGObject)
  result.impl = g_threaded_socket_service_new(int32(maxThreads))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ThreadedSocketServiceClass00* {.pure.} = object
    parentClass*: SocketServiceClass00
    run*: proc(service: ptr ThreadedSocketService00; connection: ptr SocketConnection00; 
    sourceObject: ptr gobject.Object00): gboolean {.cdecl.}
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  ThreadedSocketServiceClass* = ref object
    impl*: ptr ThreadedSocketServiceClass00

type
  TlsAuthenticationMode* {.size: sizeof(cint), pure.} = enum
    none = 0
    requested = 1
    required = 2

type
  TlsBackend00* {.pure.} = object
  TlsBackend* = ref object
    impl*: ptr TlsBackend00

proc g_tls_backend_get_default*(): ptr TlsBackend00 {.
    importc: "g_tls_backend_get_default", libprag.}

proc getDefault*(): TlsBackend =
  new(result)
  result.impl = g_tls_backend_get_default()

proc default*(): TlsBackend =
  new(result)
  result.impl = g_tls_backend_get_default()

proc g_tls_backend_get_certificate_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_certificate_type", libprag.}

proc getCertificateType*(self: TlsBackend): GType =
  g_tls_backend_get_certificate_type(cast[ptr TlsBackend00](self.impl))

proc certificateType*(self: TlsBackend): GType =
  g_tls_backend_get_certificate_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_get_client_connection_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_client_connection_type", libprag.}

proc getClientConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_client_connection_type(cast[ptr TlsBackend00](self.impl))

proc clientConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_client_connection_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_get_default_database*(self: ptr TlsBackend00): ptr TlsDatabase00 {.
    importc: "g_tls_backend_get_default_database", libprag.}

proc getDefaultDatabase*(self: TlsBackend): TlsDatabase =
  let gobj = g_tls_backend_get_default_database(cast[ptr TlsBackend00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc defaultDatabase*(self: TlsBackend): TlsDatabase =
  let gobj = g_tls_backend_get_default_database(cast[ptr TlsBackend00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[TlsDatabase](g_object_get_qdata(gobj, Quark))
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

proc g_tls_backend_get_dtls_client_connection_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_dtls_client_connection_type", libprag.}

proc getDtlsClientConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_dtls_client_connection_type(cast[ptr TlsBackend00](self.impl))

proc dtlsClientConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_dtls_client_connection_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_get_dtls_server_connection_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_dtls_server_connection_type", libprag.}

proc getDtlsServerConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_dtls_server_connection_type(cast[ptr TlsBackend00](self.impl))

proc dtlsServerConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_dtls_server_connection_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_get_file_database_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_file_database_type", libprag.}

proc getFileDatabaseType*(self: TlsBackend): GType =
  g_tls_backend_get_file_database_type(cast[ptr TlsBackend00](self.impl))

proc fileDatabaseType*(self: TlsBackend): GType =
  g_tls_backend_get_file_database_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_get_server_connection_type*(self: ptr TlsBackend00): GType {.
    importc: "g_tls_backend_get_server_connection_type", libprag.}

proc getServerConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_server_connection_type(cast[ptr TlsBackend00](self.impl))

proc serverConnectionType*(self: TlsBackend): GType =
  g_tls_backend_get_server_connection_type(cast[ptr TlsBackend00](self.impl))

proc g_tls_backend_supports_dtls*(self: ptr TlsBackend00): gboolean {.
    importc: "g_tls_backend_supports_dtls", libprag.}

proc supportsDtls*(self: TlsBackend): bool =
  toBool(g_tls_backend_supports_dtls(cast[ptr TlsBackend00](self.impl)))

proc g_tls_backend_supports_tls*(self: ptr TlsBackend00): gboolean {.
    importc: "g_tls_backend_supports_tls", libprag.}

proc supportsTls*(self: TlsBackend): bool =
  toBool(g_tls_backend_supports_tls(cast[ptr TlsBackend00](self.impl)))

type
  TlsBackendInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    supportsTls*: proc(backend: ptr TlsBackend00): gboolean {.cdecl.}
    getCertificateType*: proc(): GType {.cdecl.}
    getClientConnectionType*: proc(): GType {.cdecl.}
    getServerConnectionType*: proc(): GType {.cdecl.}
    getFileDatabaseType*: proc(): GType {.cdecl.}
    getDefaultDatabase*: proc(backend: ptr TlsBackend00): ptr TlsDatabase00 {.cdecl.}
    supportsDtls*: proc(backend: ptr TlsBackend00): gboolean {.cdecl.}
    getDtlsClientConnectionType*: proc(): GType {.cdecl.}
    getDtlsServerConnectionType*: proc(): GType {.cdecl.}
  TlsBackendInterface* = ref object
    impl*: ptr TlsBackendInterface00

type
  TlsCertificateClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    verify*: proc(cert: ptr TlsCertificate00; identity: ptr SocketConnectable00; 
    trustedCa: ptr TlsCertificate00): TlsCertificateFlags {.cdecl.}
    padding*: array[8, pointer]
  TlsCertificateClass* = ref object
    impl*: ptr TlsCertificateClass00

type
  TlsClientConnection00* {.pure.} = object
  TlsClientConnection* = ref object
    impl*: ptr TlsClientConnection00

proc g_tls_client_connection_new*(baseIoStream: ptr IOStream00; serverIdentity: ptr SocketConnectable00): ptr TlsClientConnection00 {.
    importc: "g_tls_client_connection_new", libprag.}

proc newTlsClientConnection*(baseIoStream: IOStream; serverIdentity: SocketConnectable): TlsClientConnection =
  new(result)
  result.impl = g_tls_client_connection_new(cast[ptr IOStream00](baseIoStream.impl), cast[ptr SocketConnectable00](serverIdentity.impl))

proc g_tls_client_connection_copy_session_state*(self: ptr TlsClientConnection00; source: ptr TlsClientConnection00) {.
    importc: "g_tls_client_connection_copy_session_state", libprag.}

proc copySessionState*(self: TlsClientConnection; source: TlsClientConnection) =
  g_tls_client_connection_copy_session_state(cast[ptr TlsClientConnection00](self.impl), cast[ptr TlsClientConnection00](source.impl))

proc g_tls_client_connection_get_accepted_cas*(self: ptr TlsClientConnection00): ptr pointer {.
    importc: "g_tls_client_connection_get_accepted_cas", libprag.}

proc getAcceptedCas*(self: TlsClientConnection): ptr pointer =
  g_tls_client_connection_get_accepted_cas(cast[ptr TlsClientConnection00](self.impl))

proc acceptedCas*(self: TlsClientConnection): ptr pointer =
  g_tls_client_connection_get_accepted_cas(cast[ptr TlsClientConnection00](self.impl))

proc g_tls_client_connection_get_server_identity*(self: ptr TlsClientConnection00): ptr SocketConnectable00 {.
    importc: "g_tls_client_connection_get_server_identity", libprag.}

proc getServerIdentity*(self: TlsClientConnection): SocketConnectable =
  new(result)
  result.impl = g_tls_client_connection_get_server_identity(cast[ptr TlsClientConnection00](self.impl))

proc serverIdentity*(self: TlsClientConnection): SocketConnectable =
  new(result)
  result.impl = g_tls_client_connection_get_server_identity(cast[ptr TlsClientConnection00](self.impl))

proc g_tls_client_connection_get_use_ssl3*(self: ptr TlsClientConnection00): gboolean {.
    importc: "g_tls_client_connection_get_use_ssl3", libprag.}

proc getUseSsl3*(self: TlsClientConnection): bool =
  toBool(g_tls_client_connection_get_use_ssl3(cast[ptr TlsClientConnection00](self.impl)))

proc useSsl3*(self: TlsClientConnection): bool =
  toBool(g_tls_client_connection_get_use_ssl3(cast[ptr TlsClientConnection00](self.impl)))

proc g_tls_client_connection_get_validation_flags*(self: ptr TlsClientConnection00): TlsCertificateFlags {.
    importc: "g_tls_client_connection_get_validation_flags", libprag.}

proc getValidationFlags*(self: TlsClientConnection): TlsCertificateFlags =
  g_tls_client_connection_get_validation_flags(cast[ptr TlsClientConnection00](self.impl))

proc validationFlags*(self: TlsClientConnection): TlsCertificateFlags =
  g_tls_client_connection_get_validation_flags(cast[ptr TlsClientConnection00](self.impl))

proc g_tls_client_connection_set_server_identity*(self: ptr TlsClientConnection00; identity: ptr SocketConnectable00) {.
    importc: "g_tls_client_connection_set_server_identity", libprag.}

proc setServerIdentity*(self: TlsClientConnection; identity: SocketConnectable) =
  g_tls_client_connection_set_server_identity(cast[ptr TlsClientConnection00](self.impl), cast[ptr SocketConnectable00](identity.impl))

proc `serverIdentity=`*(self: TlsClientConnection; identity: SocketConnectable) =
  g_tls_client_connection_set_server_identity(cast[ptr TlsClientConnection00](self.impl), cast[ptr SocketConnectable00](identity.impl))

proc g_tls_client_connection_set_use_ssl3*(self: ptr TlsClientConnection00; useSsl3: gboolean) {.
    importc: "g_tls_client_connection_set_use_ssl3", libprag.}

proc setUseSsl3*(self: TlsClientConnection; useSsl3: bool) =
  g_tls_client_connection_set_use_ssl3(cast[ptr TlsClientConnection00](self.impl), gboolean(useSsl3))

proc `useSsl3=`*(self: TlsClientConnection; useSsl3: bool) =
  g_tls_client_connection_set_use_ssl3(cast[ptr TlsClientConnection00](self.impl), gboolean(useSsl3))

proc g_tls_client_connection_set_validation_flags*(self: ptr TlsClientConnection00; flags: TlsCertificateFlags) {.
    importc: "g_tls_client_connection_set_validation_flags", libprag.}

proc setValidationFlags*(self: TlsClientConnection; flags: TlsCertificateFlags) =
  g_tls_client_connection_set_validation_flags(cast[ptr TlsClientConnection00](self.impl), flags)

proc `validationFlags=`*(self: TlsClientConnection; flags: TlsCertificateFlags) =
  g_tls_client_connection_set_validation_flags(cast[ptr TlsClientConnection00](self.impl), flags)

type
  TlsClientConnectionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    copySessionState*: proc(conn: ptr TlsClientConnection00; source: ptr TlsClientConnection00) {.cdecl.}
  TlsClientConnectionInterface* = ref object
    impl*: ptr TlsClientConnectionInterface00

type
  TlsConnectionClass00* {.pure.} = object
    parentClass*: IOStreamClass00
    acceptCertificate*: proc(connection: ptr TlsConnection00; peerCert: ptr TlsCertificate00; 
    errors: TlsCertificateFlags): gboolean {.cdecl.}
    handshake*: proc(conn: ptr TlsConnection00; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    handshakeAsync*: proc(conn: ptr TlsConnection00; ioPriority: int32; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    handshakeFinish*: proc(conn: ptr TlsConnection00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    padding*: array[8, pointer]
  TlsConnectionClass* = ref object
    impl*: ptr TlsConnectionClass00

type
  TlsDatabaseClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    verifyChain*: proc(self: ptr TlsDatabase00; chain: ptr TlsCertificate00; 
    purpose: cstring; identity: ptr SocketConnectable00; interaction: ptr TlsInteraction00; flags: TlsDatabaseVerifyFlags; 
    cancellable: ptr Cancellable00): TlsCertificateFlags {.cdecl.}
    verifyChainAsync*: proc(self: ptr TlsDatabase00; chain: ptr TlsCertificate00; 
    purpose: cstring; identity: ptr SocketConnectable00; interaction: ptr TlsInteraction00; flags: TlsDatabaseVerifyFlags; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    verifyChainFinish*: proc(self: ptr TlsDatabase00; resu: ptr AsyncResult00): TlsCertificateFlags {.cdecl.}
    createCertificateHandle*: proc(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00): cstring {.cdecl.}
    lookupCertificateForHandle*: proc(self: ptr TlsDatabase00; handle: cstring; interaction: ptr TlsInteraction00; 
    flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr TlsCertificate00 {.cdecl.}
    lookupCertificateForHandleAsync*: proc(self: ptr TlsDatabase00; handle: cstring; interaction: ptr TlsInteraction00; 
    flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    lookupCertificateForHandleFinish*: proc(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr TlsCertificate00 {.cdecl.}
    lookupCertificateIssuer*: proc(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr TlsCertificate00 {.cdecl.}
    lookupCertificateIssuerAsync*: proc(self: ptr TlsDatabase00; certificate: ptr TlsCertificate00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupCertificateIssuerFinish*: proc(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr TlsCertificate00 {.cdecl.}
    lookupCertificatesIssuedBy*: proc(self: ptr TlsDatabase00; issuerRawDn: ptr ByteArray00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00): ptr pointer {.cdecl.}
    lookupCertificatesIssuedByAsync*: proc(self: ptr TlsDatabase00; issuerRawDn: ptr ByteArray00; 
    interaction: ptr TlsInteraction00; flags: TlsDatabaseLookupFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    lookupCertificatesIssuedByFinish*: proc(self: ptr TlsDatabase00; resu: ptr AsyncResult00): ptr pointer {.cdecl.}
    padding*: array[16, pointer]
  TlsDatabaseClass* = ref object
    impl*: ptr TlsDatabaseClass00

type
  TlsError* {.size: sizeof(cint), pure.} = enum
    unavailable = 0
    misc = 1
    badCertificate = 2
    notTls = 3
    handshake = 4
    certificateRequired = 5
    eof = 6

proc g_tls_error_quark*(): uint32 {.
    importc: "g_tls_error_quark", libprag.}

type
  TlsFileDatabase00* {.pure.} = object
  TlsFileDatabase* = ref object
    impl*: ptr TlsFileDatabase00

proc g_tls_file_database_new*(anchors: ucstring): ptr TlsFileDatabase00 {.
    importc: "g_tls_file_database_new", libprag.}

proc newTlsFileDatabase*(anchors: ucstring): TlsFileDatabase =
  new(result)
  result.impl = g_tls_file_database_new(anchors)

type
  TlsFileDatabaseInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    padding*: array[8, pointer]
  TlsFileDatabaseInterface* = ref object
    impl*: ptr TlsFileDatabaseInterface00

type
  TlsInteractionClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    askPassword*: proc(interaction: ptr TlsInteraction00; password: ptr TlsPassword00; 
    cancellable: ptr Cancellable00): TlsInteractionResult {.cdecl.}
    askPasswordAsync*: proc(interaction: ptr TlsInteraction00; password: ptr TlsPassword00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    askPasswordFinish*: proc(interaction: ptr TlsInteraction00; resu: ptr AsyncResult00): TlsInteractionResult {.cdecl.}
    requestCertificate*: proc(interaction: ptr TlsInteraction00; connection: ptr TlsConnection00; 
    flags: TlsCertificateRequestFlags; cancellable: ptr Cancellable00): TlsInteractionResult {.cdecl.}
    requestCertificateAsync*: proc(interaction: ptr TlsInteraction00; connection: ptr TlsConnection00; 
    flags: TlsCertificateRequestFlags; cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    requestCertificateFinish*: proc(interaction: ptr TlsInteraction00; resu: ptr AsyncResult00): TlsInteractionResult {.cdecl.}
    padding*: array[21, pointer]
  TlsInteractionClass* = ref object
    impl*: ptr TlsInteractionClass00

type
  TlsPasswordClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    getValue*: proc(password: ptr TlsPassword00; length: ptr uint64): ptr uint8 {.cdecl.}
    setValue*: proc(password: ptr TlsPassword00; value: ptr uint8; length: int64; 
    destroy: DestroyNotify) {.cdecl.}
    getDefaultWarning*: proc(password: ptr TlsPassword00): cstring {.cdecl.}
    padding*: array[4, pointer]
  TlsPasswordClass* = ref object
    impl*: ptr TlsPasswordClass00

type
  TlsServerConnection00* {.pure.} = object
  TlsServerConnection* = ref object
    impl*: ptr TlsServerConnection00

proc g_tls_server_connection_new*(baseIoStream: ptr IOStream00; certificate: ptr TlsCertificate00): ptr TlsServerConnection00 {.
    importc: "g_tls_server_connection_new", libprag.}

proc newTlsServerConnection*(baseIoStream: IOStream; certificate: TlsCertificate): TlsServerConnection =
  new(result)
  result.impl = g_tls_server_connection_new(cast[ptr IOStream00](baseIoStream.impl), cast[ptr TlsCertificate00](certificate.impl))

type
  TlsServerConnectionInterface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
  TlsServerConnectionInterface* = ref object
    impl*: ptr TlsServerConnectionInterface00

type
  UnixConnectionPrivate00* {.pure.} = object
  UnixConnectionPrivate* = ref object
    impl*: ptr UnixConnectionPrivate00

type
  UnixConnection* = ref object of SocketConnection
  UnixConnection00* = object of SocketConnection00
    priv3: ptr UnixConnectionPrivate00

proc g_unix_connection_receive_credentials*(self: ptr UnixConnection00; cancellable: ptr Cancellable00): ptr Credentials00 {.
    importc: "g_unix_connection_receive_credentials", libprag.}

proc receiveCredentials*(self: UnixConnection; cancellable: Cancellable): Credentials =
  let gobj = g_unix_connection_receive_credentials(cast[ptr UnixConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc g_unix_connection_receive_credentials_async*(self: ptr UnixConnection00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_unix_connection_receive_credentials_async", libprag.}

proc receiveCredentialsAsync*(self: UnixConnection; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_unix_connection_receive_credentials_async(cast[ptr UnixConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_unix_connection_receive_credentials_finish*(self: ptr UnixConnection00; resu: ptr AsyncResult00): ptr Credentials00 {.
    importc: "g_unix_connection_receive_credentials_finish", libprag.}

proc receiveCredentialsFinish*(self: UnixConnection; resu: AsyncResult): Credentials =
  let gobj = g_unix_connection_receive_credentials_finish(cast[ptr UnixConnection00](self.impl), cast[ptr AsyncResult00](resu.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc g_unix_connection_receive_fd*(self: ptr UnixConnection00; cancellable: ptr Cancellable00): int32 {.
    importc: "g_unix_connection_receive_fd", libprag.}

proc receiveFd*(self: UnixConnection; cancellable: Cancellable): int =
  int(g_unix_connection_receive_fd(cast[ptr UnixConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_unix_connection_send_credentials*(self: ptr UnixConnection00; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_unix_connection_send_credentials", libprag.}

proc sendCredentials*(self: UnixConnection; cancellable: Cancellable): bool =
  toBool(g_unix_connection_send_credentials(cast[ptr UnixConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl)))

proc g_unix_connection_send_credentials_async*(self: ptr UnixConnection00; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_unix_connection_send_credentials_async", libprag.}

proc sendCredentialsAsync*(self: UnixConnection; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_unix_connection_send_credentials_async(cast[ptr UnixConnection00](self.impl), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_unix_connection_send_credentials_finish*(self: ptr UnixConnection00; resu: ptr AsyncResult00): gboolean {.
    importc: "g_unix_connection_send_credentials_finish", libprag.}

proc sendCredentialsFinish*(self: UnixConnection; resu: AsyncResult): bool =
  toBool(g_unix_connection_send_credentials_finish(cast[ptr UnixConnection00](self.impl), cast[ptr AsyncResult00](resu.impl)))

proc g_unix_connection_send_fd*(self: ptr UnixConnection00; fd: int32; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_unix_connection_send_fd", libprag.}

proc sendFd*(self: UnixConnection; fd: int; cancellable: Cancellable): bool =
  toBool(g_unix_connection_send_fd(cast[ptr UnixConnection00](self.impl), int32(fd), cast[ptr Cancellable00](cancellable.impl)))

type
  UnixConnectionClass00* {.pure.} = object
    parentClass*: SocketConnectionClass00
  UnixConnectionClass* = ref object
    impl*: ptr UnixConnectionClass00

type
  UnixCredentialsMessagePrivate00* {.pure.} = object
  UnixCredentialsMessagePrivate* = ref object
    impl*: ptr UnixCredentialsMessagePrivate00

type
  UnixCredentialsMessage* = ref object of SocketControlMessage
  UnixCredentialsMessage00* = object of SocketControlMessage00
    priv2: ptr UnixCredentialsMessagePrivate00

proc g_unix_credentials_message_new*(): ptr UnixCredentialsMessage00 {.
    importc: "g_unix_credentials_message_new", libprag.}

proc newUnixCredentialsMessage*(): UnixCredentialsMessage =
  new(result, finalizeGObject)
  result.impl = g_unix_credentials_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixCredentialsMessage*[T](result: var T) =
  assert(result is UnixCredentialsMessage)
  new(result, finalizeGObject)
  result.impl = g_unix_credentials_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_credentials_message_new_with_credentials*(credentials: ptr Credentials00): ptr UnixCredentialsMessage00 {.
    importc: "g_unix_credentials_message_new_with_credentials", libprag.}

proc newUnixCredentialsMessageWithCredentials*(credentials: Credentials): UnixCredentialsMessage =
  new(result, finalizeGObject)
  result.impl = g_unix_credentials_message_new_with_credentials(cast[ptr Credentials00](credentials.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixCredentialsMessageWithCredentials*[T](result: var T; credentials: Credentials) =
  assert(result is UnixCredentialsMessage)
  new(result, finalizeGObject)
  result.impl = g_unix_credentials_message_new_with_credentials(cast[ptr Credentials00](credentials.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_credentials_message_is_supported*(): gboolean {.
    importc: "g_unix_credentials_message_is_supported", libprag.}

proc isSupported*(): gboolean {.
    importc: "g_unix_credentials_message_is_supported", libprag.}

proc g_unix_credentials_message_get_credentials*(self: ptr UnixCredentialsMessage00): ptr Credentials00 {.
    importc: "g_unix_credentials_message_get_credentials", libprag.}

proc getCredentials*(self: UnixCredentialsMessage): Credentials =
  let gobj = g_unix_credentials_message_get_credentials(cast[ptr UnixCredentialsMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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

proc credentials*(self: UnixCredentialsMessage): Credentials =
  let gobj = g_unix_credentials_message_get_credentials(cast[ptr UnixCredentialsMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Credentials](g_object_get_qdata(gobj, Quark))
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
  UnixCredentialsMessageClass00* {.pure.} = object
    parentClass*: SocketControlMessageClass00
    gReserved1*: pointer
    gReserved2*: pointer
  UnixCredentialsMessageClass* = ref object
    impl*: ptr UnixCredentialsMessageClass00

type
  UnixFDListClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  UnixFDListClass* = ref object
    impl*: ptr UnixFDListClass00

type
  UnixFDMessagePrivate00* {.pure.} = object
  UnixFDMessagePrivate* = ref object
    impl*: ptr UnixFDMessagePrivate00

type
  UnixFDMessage* = ref object of SocketControlMessage
  UnixFDMessage00* = object of SocketControlMessage00
    priv2: ptr UnixFDMessagePrivate00

proc g_unix_fd_message_new*(): ptr UnixFDMessage00 {.
    importc: "g_unix_fd_message_new", libprag.}

proc newUnixFDMessage*(): UnixFDMessage =
  new(result, finalizeGObject)
  result.impl = g_unix_fd_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixFDMessage*[T](result: var T) =
  assert(result is UnixFDMessage)
  new(result, finalizeGObject)
  result.impl = g_unix_fd_message_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_fd_message_new_with_fd_list*(fdList: ptr UnixFDList00): ptr UnixFDMessage00 {.
    importc: "g_unix_fd_message_new_with_fd_list", libprag.}

proc newUnixFDMessageWithFdList*(fdList: UnixFDList): UnixFDMessage =
  new(result, finalizeGObject)
  result.impl = g_unix_fd_message_new_with_fd_list(cast[ptr UnixFDList00](fdList.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixFDMessageWithFdList*[T](result: var T; fdList: UnixFDList) =
  assert(result is UnixFDMessage)
  new(result, finalizeGObject)
  result.impl = g_unix_fd_message_new_with_fd_list(cast[ptr UnixFDList00](fdList.impl))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_fd_message_append_fd*(self: ptr UnixFDMessage00; fd: int32): gboolean {.
    importc: "g_unix_fd_message_append_fd", libprag.}

proc appendFd*(self: UnixFDMessage; fd: int): bool =
  toBool(g_unix_fd_message_append_fd(cast[ptr UnixFDMessage00](self.impl), int32(fd)))

proc g_unix_fd_message_get_fd_list*(self: ptr UnixFDMessage00): ptr UnixFDList00 {.
    importc: "g_unix_fd_message_get_fd_list", libprag.}

proc getFdList*(self: UnixFDMessage): UnixFDList =
  let gobj = g_unix_fd_message_get_fd_list(cast[ptr UnixFDMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[UnixFDList](g_object_get_qdata(gobj, Quark))
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

proc fdList*(self: UnixFDMessage): UnixFDList =
  let gobj = g_unix_fd_message_get_fd_list(cast[ptr UnixFDMessage00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[UnixFDList](g_object_get_qdata(gobj, Quark))
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

proc g_unix_fd_message_steal_fds*(self: ptr UnixFDMessage00; length: var int32): int32Array {.
    importc: "g_unix_fd_message_steal_fds", libprag.}

proc stealFds*(self: UnixFDMessage; length: var int): int32Array =
  var length_00 = int32(length)
  result = g_unix_fd_message_steal_fds(cast[ptr UnixFDMessage00](self.impl), length_00)
  length = int(length_00)

type
  UnixFDMessageClass00* {.pure.} = object
    parentClass*: SocketControlMessageClass00
    gReserved1*: pointer
    gReserved2*: pointer
  UnixFDMessageClass* = ref object
    impl*: ptr UnixFDMessageClass00

type
  UnixInputStreamPrivate00* {.pure.} = object
  UnixInputStreamPrivate* = ref object
    impl*: ptr UnixInputStreamPrivate00

type
  UnixInputStream* = ref object of InputStream
  UnixInputStream00* = object of InputStream00
    priv2: ptr UnixInputStreamPrivate00

proc g_unix_input_stream_new*(fd: int32; closeFd: gboolean): ptr UnixInputStream00 {.
    importc: "g_unix_input_stream_new", libprag.}

proc newUnixInputStream*(fd: int; closeFd: bool): UnixInputStream =
  new(result, finalizeGObject)
  result.impl = g_unix_input_stream_new(int32(fd), gboolean(closeFd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixInputStream*[T](result: var T; fd: int; closeFd: bool) =
  assert(result is UnixInputStream)
  new(result, finalizeGObject)
  result.impl = g_unix_input_stream_new(int32(fd), gboolean(closeFd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_input_stream_get_close_fd*(self: ptr UnixInputStream00): gboolean {.
    importc: "g_unix_input_stream_get_close_fd", libprag.}

proc getCloseFd*(self: UnixInputStream): bool =
  toBool(g_unix_input_stream_get_close_fd(cast[ptr UnixInputStream00](self.impl)))

proc closeFd*(self: UnixInputStream): bool =
  toBool(g_unix_input_stream_get_close_fd(cast[ptr UnixInputStream00](self.impl)))

proc g_unix_input_stream_get_fd*(self: ptr UnixInputStream00): int32 {.
    importc: "g_unix_input_stream_get_fd", libprag.}

proc getFd*(self: UnixInputStream): int =
  int(g_unix_input_stream_get_fd(cast[ptr UnixInputStream00](self.impl)))

proc fd*(self: UnixInputStream): int =
  int(g_unix_input_stream_get_fd(cast[ptr UnixInputStream00](self.impl)))

proc g_unix_input_stream_set_close_fd*(self: ptr UnixInputStream00; closeFd: gboolean) {.
    importc: "g_unix_input_stream_set_close_fd", libprag.}

proc setCloseFd*(self: UnixInputStream; closeFd: bool) =
  g_unix_input_stream_set_close_fd(cast[ptr UnixInputStream00](self.impl), gboolean(closeFd))

proc `closeFd=`*(self: UnixInputStream; closeFd: bool) =
  g_unix_input_stream_set_close_fd(cast[ptr UnixInputStream00](self.impl), gboolean(closeFd))

type
  UnixInputStreamClass00* {.pure.} = object
    parentClass*: InputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  UnixInputStreamClass* = ref object
    impl*: ptr UnixInputStreamClass00

type
  UnixMountEntry00* {.pure.} = object
  UnixMountEntry* = ref object
    impl*: ptr UnixMountEntry00

type
  UnixMountMonitor* = ref object of gobject.Object
  UnixMountMonitor00* = object of gobject.Object00

proc scMountpointsChanged*(self: UnixMountMonitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mountpoints-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))
proc scMountsChanged*(self: UnixMountMonitor;  p: proc (self: ptr gobject.Object00; xdata: pointer) {.cdecl.}, xdata: pointer = nil) =
  discard g_signal_connect_data(self.impl, "mounts-changed", cast[GCallback](p), xdata, nil, cast[ConnectFlags](0))

proc g_unix_mount_monitor_new*(): ptr UnixMountMonitor00 {.
    importc: "g_unix_mount_monitor_new", libprag.}

proc newUnixMountMonitor*(): UnixMountMonitor =
  new(result, finalizeGObject)
  result.impl = g_unix_mount_monitor_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixMountMonitor*[T](result: var T) =
  assert(result is UnixMountMonitor)
  new(result, finalizeGObject)
  result.impl = g_unix_mount_monitor_new()
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_mount_monitor_get*(): ptr UnixMountMonitor00 {.
    importc: "g_unix_mount_monitor_get", libprag.}

proc get*(): UnixMountMonitor =
  let gobj = g_unix_mount_monitor_get()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[UnixMountMonitor](g_object_get_qdata(gobj, Quark))
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

proc g_unix_mount_monitor_set_rate_limit*(self: ptr UnixMountMonitor00; limitMsec: int32) {.
    importc: "g_unix_mount_monitor_set_rate_limit", libprag.}

proc setRateLimit*(self: UnixMountMonitor; limitMsec: int) =
  g_unix_mount_monitor_set_rate_limit(cast[ptr UnixMountMonitor00](self.impl), int32(limitMsec))

proc `rateLimit=`*(self: UnixMountMonitor; limitMsec: int) =
  g_unix_mount_monitor_set_rate_limit(cast[ptr UnixMountMonitor00](self.impl), int32(limitMsec))

type
  UnixMountMonitorClass00* {.pure.} = object
  UnixMountMonitorClass* = ref object
    impl*: ptr UnixMountMonitorClass00

type
  UnixMountPoint00* {.pure.} = object
  UnixMountPoint* = ref object
    impl*: ptr UnixMountPoint00

proc g_unix_mount_point_compare*(self: ptr UnixMountPoint00; mount2: ptr UnixMountPoint00): int32 {.
    importc: "g_unix_mount_point_compare", libprag.}

proc compare*(self: UnixMountPoint; mount2: UnixMountPoint): int =
  int(g_unix_mount_point_compare(cast[ptr UnixMountPoint00](self.impl), cast[ptr UnixMountPoint00](mount2.impl)))

proc g_unix_mount_point_free*(self: ptr UnixMountPoint00) {.
    importc: "g_unix_mount_point_free", libprag.}

proc free*(self: UnixMountPoint) =
  g_unix_mount_point_free(cast[ptr UnixMountPoint00](self.impl))

proc g_unix_mount_point_get_device_path*(self: ptr UnixMountPoint00): ucstring {.
    importc: "g_unix_mount_point_get_device_path", libprag.}

proc getDevicePath*(self: UnixMountPoint): ucstring =
  g_unix_mount_point_get_device_path(cast[ptr UnixMountPoint00](self.impl))

proc devicePath*(self: UnixMountPoint): ucstring =
  g_unix_mount_point_get_device_path(cast[ptr UnixMountPoint00](self.impl))

proc g_unix_mount_point_get_fs_type*(self: ptr UnixMountPoint00): cstring {.
    importc: "g_unix_mount_point_get_fs_type", libprag.}

proc getFsType*(self: UnixMountPoint): string =
  let resul0 = g_unix_mount_point_get_fs_type(cast[ptr UnixMountPoint00](self.impl))
  result = $resul0

proc fsType*(self: UnixMountPoint): string =
  let resul0 = g_unix_mount_point_get_fs_type(cast[ptr UnixMountPoint00](self.impl))
  result = $resul0

proc g_unix_mount_point_get_mount_path*(self: ptr UnixMountPoint00): ucstring {.
    importc: "g_unix_mount_point_get_mount_path", libprag.}

proc getMountPath*(self: UnixMountPoint): ucstring =
  g_unix_mount_point_get_mount_path(cast[ptr UnixMountPoint00](self.impl))

proc mountPath*(self: UnixMountPoint): ucstring =
  g_unix_mount_point_get_mount_path(cast[ptr UnixMountPoint00](self.impl))

proc g_unix_mount_point_get_options*(self: ptr UnixMountPoint00): cstring {.
    importc: "g_unix_mount_point_get_options", libprag.}

proc getOptions*(self: UnixMountPoint): string =
  let resul0 = g_unix_mount_point_get_options(cast[ptr UnixMountPoint00](self.impl))
  result = $resul0

proc options*(self: UnixMountPoint): string =
  let resul0 = g_unix_mount_point_get_options(cast[ptr UnixMountPoint00](self.impl))
  result = $resul0

proc g_unix_mount_point_guess_can_eject*(self: ptr UnixMountPoint00): gboolean {.
    importc: "g_unix_mount_point_guess_can_eject", libprag.}

proc guessCanEject*(self: UnixMountPoint): bool =
  toBool(g_unix_mount_point_guess_can_eject(cast[ptr UnixMountPoint00](self.impl)))

proc g_unix_mount_point_guess_icon*(self: ptr UnixMountPoint00): ptr Icon00 {.
    importc: "g_unix_mount_point_guess_icon", libprag.}

proc guessIcon*(self: UnixMountPoint): Icon =
  new(result)
  result.impl = g_unix_mount_point_guess_icon(cast[ptr UnixMountPoint00](self.impl))

proc g_unix_mount_point_guess_name*(self: ptr UnixMountPoint00): cstring {.
    importc: "g_unix_mount_point_guess_name", libprag.}

proc guessName*(self: UnixMountPoint): string =
  let resul0 = g_unix_mount_point_guess_name(cast[ptr UnixMountPoint00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_unix_mount_point_guess_symbolic_icon*(self: ptr UnixMountPoint00): ptr Icon00 {.
    importc: "g_unix_mount_point_guess_symbolic_icon", libprag.}

proc guessSymbolicIcon*(self: UnixMountPoint): Icon =
  new(result)
  result.impl = g_unix_mount_point_guess_symbolic_icon(cast[ptr UnixMountPoint00](self.impl))

proc g_unix_mount_point_is_loopback*(self: ptr UnixMountPoint00): gboolean {.
    importc: "g_unix_mount_point_is_loopback", libprag.}

proc isLoopback*(self: UnixMountPoint): bool =
  toBool(g_unix_mount_point_is_loopback(cast[ptr UnixMountPoint00](self.impl)))

proc g_unix_mount_point_is_readonly*(self: ptr UnixMountPoint00): gboolean {.
    importc: "g_unix_mount_point_is_readonly", libprag.}

proc isReadonly*(self: UnixMountPoint): bool =
  toBool(g_unix_mount_point_is_readonly(cast[ptr UnixMountPoint00](self.impl)))

proc g_unix_mount_point_is_user_mountable*(self: ptr UnixMountPoint00): gboolean {.
    importc: "g_unix_mount_point_is_user_mountable", libprag.}

proc isUserMountable*(self: UnixMountPoint): bool =
  toBool(g_unix_mount_point_is_user_mountable(cast[ptr UnixMountPoint00](self.impl)))

type
  UnixOutputStreamPrivate00* {.pure.} = object
  UnixOutputStreamPrivate* = ref object
    impl*: ptr UnixOutputStreamPrivate00

type
  UnixOutputStream* = ref object of OutputStream
  UnixOutputStream00* = object of OutputStream00
    priv2: ptr UnixOutputStreamPrivate00

proc g_unix_output_stream_new*(fd: int32; closeFd: gboolean): ptr UnixOutputStream00 {.
    importc: "g_unix_output_stream_new", libprag.}

proc newUnixOutputStream*(fd: int; closeFd: bool): UnixOutputStream =
  new(result, finalizeGObject)
  result.impl = g_unix_output_stream_new(int32(fd), gboolean(closeFd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixOutputStream*[T](result: var T; fd: int; closeFd: bool) =
  assert(result is UnixOutputStream)
  new(result, finalizeGObject)
  result.impl = g_unix_output_stream_new(int32(fd), gboolean(closeFd))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_output_stream_get_close_fd*(self: ptr UnixOutputStream00): gboolean {.
    importc: "g_unix_output_stream_get_close_fd", libprag.}

proc getCloseFd*(self: UnixOutputStream): bool =
  toBool(g_unix_output_stream_get_close_fd(cast[ptr UnixOutputStream00](self.impl)))

proc closeFd*(self: UnixOutputStream): bool =
  toBool(g_unix_output_stream_get_close_fd(cast[ptr UnixOutputStream00](self.impl)))

proc g_unix_output_stream_get_fd*(self: ptr UnixOutputStream00): int32 {.
    importc: "g_unix_output_stream_get_fd", libprag.}

proc getFd*(self: UnixOutputStream): int =
  int(g_unix_output_stream_get_fd(cast[ptr UnixOutputStream00](self.impl)))

proc fd*(self: UnixOutputStream): int =
  int(g_unix_output_stream_get_fd(cast[ptr UnixOutputStream00](self.impl)))

proc g_unix_output_stream_set_close_fd*(self: ptr UnixOutputStream00; closeFd: gboolean) {.
    importc: "g_unix_output_stream_set_close_fd", libprag.}

proc setCloseFd*(self: UnixOutputStream; closeFd: bool) =
  g_unix_output_stream_set_close_fd(cast[ptr UnixOutputStream00](self.impl), gboolean(closeFd))

proc `closeFd=`*(self: UnixOutputStream; closeFd: bool) =
  g_unix_output_stream_set_close_fd(cast[ptr UnixOutputStream00](self.impl), gboolean(closeFd))

type
  UnixOutputStreamClass00* {.pure.} = object
    parentClass*: OutputStreamClass00
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
  UnixOutputStreamClass* = ref object
    impl*: ptr UnixOutputStreamClass00

type
  UnixSocketAddressPrivate00* {.pure.} = object
  UnixSocketAddressPrivate* = ref object
    impl*: ptr UnixSocketAddressPrivate00

type
  UnixSocketAddress* = ref object of SocketAddress
  UnixSocketAddress00* = object of SocketAddress00
    priv2: ptr UnixSocketAddressPrivate00

proc g_unix_socket_address_new*(path: cstring): ptr UnixSocketAddress00 {.
    importc: "g_unix_socket_address_new", libprag.}

proc newUnixSocketAddress*(path: string): UnixSocketAddress =
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new(cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixSocketAddress*[T](result: var T; path: string) =
  assert(result is UnixSocketAddress)
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new(cstring(path))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_socket_address_new_abstract*(path: int8Array; pathLen: int32): ptr UnixSocketAddress00 {.
    importc: "g_unix_socket_address_new_abstract", libprag.}

proc newUnixSocketAddressAbstract*(path: int8Array; pathLen: int): UnixSocketAddress =
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new_abstract(path, int32(pathLen))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixSocketAddressAbstract*[T](result: var T; path: int8Array; pathLen: int) =
  assert(result is UnixSocketAddress)
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new_abstract(path, int32(pathLen))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_socket_address_abstract_names_supported*(): gboolean {.
    importc: "g_unix_socket_address_abstract_names_supported", libprag.}

proc abstractNamesSupported*(): gboolean {.
    importc: "g_unix_socket_address_abstract_names_supported", libprag.}

proc g_unix_socket_address_get_is_abstract*(self: ptr UnixSocketAddress00): gboolean {.
    importc: "g_unix_socket_address_get_is_abstract", libprag.}

proc getIsAbstract*(self: UnixSocketAddress): bool =
  toBool(g_unix_socket_address_get_is_abstract(cast[ptr UnixSocketAddress00](self.impl)))

proc isAbstract*(self: UnixSocketAddress): bool =
  toBool(g_unix_socket_address_get_is_abstract(cast[ptr UnixSocketAddress00](self.impl)))

proc g_unix_socket_address_get_path*(self: ptr UnixSocketAddress00): cstring {.
    importc: "g_unix_socket_address_get_path", libprag.}

proc getPath*(self: UnixSocketAddress): string =
  let resul0 = g_unix_socket_address_get_path(cast[ptr UnixSocketAddress00](self.impl))
  result = $resul0

proc path*(self: UnixSocketAddress): string =
  let resul0 = g_unix_socket_address_get_path(cast[ptr UnixSocketAddress00](self.impl))
  result = $resul0

proc g_unix_socket_address_get_path_len*(self: ptr UnixSocketAddress00): uint64 {.
    importc: "g_unix_socket_address_get_path_len", libprag.}

proc getPathLen*(self: UnixSocketAddress): uint64 =
  g_unix_socket_address_get_path_len(cast[ptr UnixSocketAddress00](self.impl))

proc pathLen*(self: UnixSocketAddress): uint64 =
  g_unix_socket_address_get_path_len(cast[ptr UnixSocketAddress00](self.impl))

type
  UnixSocketAddressType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    anonymous = 1
    path = 2
    abstract = 3
    abstractPadded = 4

proc g_unix_socket_address_new_with_type*(path: int8Array; pathLen: int32; `type`: UnixSocketAddressType): ptr UnixSocketAddress00 {.
    importc: "g_unix_socket_address_new_with_type", libprag.}

proc newUnixSocketAddressWithType*(path: int8Array; pathLen: int; `type`: UnixSocketAddressType): UnixSocketAddress =
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new_with_type(path, int32(pathLen), `type`)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initUnixSocketAddressWithType*[T](result: var T; path: int8Array; pathLen: int; `type`: UnixSocketAddressType) =
  assert(result is UnixSocketAddress)
  new(result, finalizeGObject)
  result.impl = g_unix_socket_address_new_with_type(path, int32(pathLen), `type`)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_unix_socket_address_get_address_type*(self: ptr UnixSocketAddress00): UnixSocketAddressType {.
    importc: "g_unix_socket_address_get_address_type", libprag.}

proc getAddressType*(self: UnixSocketAddress): UnixSocketAddressType =
  g_unix_socket_address_get_address_type(cast[ptr UnixSocketAddress00](self.impl))

proc addressType*(self: UnixSocketAddress): UnixSocketAddressType =
  g_unix_socket_address_get_address_type(cast[ptr UnixSocketAddress00](self.impl))

type
  UnixSocketAddressClass00* {.pure.} = object
    parentClass*: SocketAddressClass00
  UnixSocketAddressClass* = ref object
    impl*: ptr UnixSocketAddressClass00

const VFS_EXTENSION_POINT_NAME* = "gio-vfs"

const VOLUME_IDENTIFIER_KIND_CLASS* = "class"

const VOLUME_IDENTIFIER_KIND_HAL_UDI* = "hal-udi"

const VOLUME_IDENTIFIER_KIND_LABEL* = "label"

const VOLUME_IDENTIFIER_KIND_NFS_MOUNT* = "nfs-mount"

const VOLUME_IDENTIFIER_KIND_UNIX_DEVICE* = "unix-device"

const VOLUME_IDENTIFIER_KIND_UUID* = "uuid"

const VOLUME_MONITOR_EXTENSION_POINT_NAME* = "gio-volume-monitor"

type
  Vfs* = ref object of gobject.Object
  Vfs00* = object of gobject.Object00

proc g_vfs_get_default*(): ptr Vfs00 {.
    importc: "g_vfs_get_default", libprag.}

proc getDefault*(): Vfs =
  let gobj = g_vfs_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Vfs](g_object_get_qdata(gobj, Quark))
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

proc default*(): Vfs =
  let gobj = g_vfs_get_default()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Vfs](g_object_get_qdata(gobj, Quark))
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

proc g_vfs_get_local*(): ptr Vfs00 {.
    importc: "g_vfs_get_local", libprag.}

proc getLocal*(): Vfs =
  let gobj = g_vfs_get_local()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Vfs](g_object_get_qdata(gobj, Quark))
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

proc local*(): Vfs =
  let gobj = g_vfs_get_local()
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Vfs](g_object_get_qdata(gobj, Quark))
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

proc g_vfs_get_file_for_path*(self: ptr Vfs00; path: cstring): ptr File00 {.
    importc: "g_vfs_get_file_for_path", libprag.}

proc getFileForPath*(self: Vfs; path: string): File =
  new(result)
  result.impl = g_vfs_get_file_for_path(cast[ptr Vfs00](self.impl), cstring(path))

proc fileForPath*(self: Vfs; path: string): File =
  new(result)
  result.impl = g_vfs_get_file_for_path(cast[ptr Vfs00](self.impl), cstring(path))

proc g_vfs_get_file_for_uri*(self: ptr Vfs00; uri: cstring): ptr File00 {.
    importc: "g_vfs_get_file_for_uri", libprag.}

proc getFileForUri*(self: Vfs; uri: string): File =
  new(result)
  result.impl = g_vfs_get_file_for_uri(cast[ptr Vfs00](self.impl), cstring(uri))

proc fileForUri*(self: Vfs; uri: string): File =
  new(result)
  result.impl = g_vfs_get_file_for_uri(cast[ptr Vfs00](self.impl), cstring(uri))

proc g_vfs_get_supported_uri_schemes*(self: ptr Vfs00): cstringArray {.
    importc: "g_vfs_get_supported_uri_schemes", libprag.}

proc getSupportedUriSchemes*(self: Vfs): cstringArray =
  g_vfs_get_supported_uri_schemes(cast[ptr Vfs00](self.impl))

proc supportedUriSchemes*(self: Vfs): cstringArray =
  g_vfs_get_supported_uri_schemes(cast[ptr Vfs00](self.impl))

proc g_vfs_is_active*(self: ptr Vfs00): gboolean {.
    importc: "g_vfs_is_active", libprag.}

proc isActive*(self: Vfs): bool =
  toBool(g_vfs_is_active(cast[ptr Vfs00](self.impl)))

proc g_vfs_parse_name*(self: ptr Vfs00; parseName: cstring): ptr File00 {.
    importc: "g_vfs_parse_name", libprag.}

proc parseName*(self: Vfs; parseName: string): File =
  new(result)
  result.impl = g_vfs_parse_name(cast[ptr Vfs00](self.impl), cstring(parseName))

proc g_vfs_unregister_uri_scheme*(self: ptr Vfs00; scheme: cstring): gboolean {.
    importc: "g_vfs_unregister_uri_scheme", libprag.}

proc unregisterUriScheme*(self: Vfs; scheme: string): bool =
  toBool(g_vfs_unregister_uri_scheme(cast[ptr Vfs00](self.impl), cstring(scheme)))

type
  VfsClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
    isActive*: proc(vfs: ptr Vfs00): gboolean {.cdecl.}
    getFileForPath*: proc(vfs: ptr Vfs00; path: cstring): ptr File00 {.cdecl.}
    getFileForUri*: proc(vfs: ptr Vfs00; uri: cstring): ptr File00 {.cdecl.}
    getSupportedUriSchemes*: proc(vfs: ptr Vfs00): cstringArray {.cdecl.}
    parseName*: proc(vfs: ptr Vfs00; parseName: cstring): ptr File00 {.cdecl.}
    localFileAddInfo*: proc(vfs: ptr Vfs00; filename: cstring; device: uint64; 
    attributeMatcher: ptr FileAttributeMatcher00; info: ptr FileInfo00; cancellable: ptr Cancellable00; 
    extraData: pointer; freeExtraData: ptr DestroyNotify) {.cdecl.}
    addWritableNamespaces*: proc(vfs: ptr Vfs00; list: ptr FileAttributeInfoList00) {.cdecl.}
    localFileSetAttributes*: proc(vfs: ptr Vfs00; filename: cstring; info: ptr FileInfo00; 
    flags: FileQueryInfoFlags; cancellable: ptr Cancellable00): gboolean {.cdecl.}
    localFileRemoved*: proc(vfs: ptr Vfs00; filename: cstring) {.cdecl.}
    localFileMoved*: proc(vfs: ptr Vfs00; source: cstring; dest: cstring) {.cdecl.}
    deserializeIcon*: pointer
    gReserved1*: pointer
    gReserved2*: pointer
    gReserved3*: pointer
    gReserved4*: pointer
    gReserved5*: pointer
    gReserved6*: pointer
  VfsClass* = ref object
    impl*: ptr VfsClass00

type
  VfsFileLookupFunc* = proc (vfs: ptr Vfs00; identifier: cstring; userData: pointer): ptr File00 {.cdecl.}

proc g_vfs_register_uri_scheme*(self: ptr Vfs00; scheme: cstring; uriFunc: VfsFileLookupFunc; 
    uriData: pointer; uriDestroy: DestroyNotify; parseNameFunc: VfsFileLookupFunc; parseNameData: pointer; 
    parseNameDestroy: DestroyNotify): gboolean {.
    importc: "g_vfs_register_uri_scheme", libprag.}

proc registerUriScheme*(self: Vfs; scheme: string; uriFunc: VfsFileLookupFunc; 
    uriData: pointer; uriDestroy: DestroyNotify; parseNameFunc: VfsFileLookupFunc; parseNameData: pointer; 
    parseNameDestroy: DestroyNotify): bool =
  toBool(g_vfs_register_uri_scheme(cast[ptr Vfs00](self.impl), cstring(scheme), uriFunc, uriData, uriDestroy, parseNameFunc, parseNameData, parseNameDestroy))

type
  VolumeIface00* {.pure.} = object
    gIface*: gobject.TypeInterface00
    changed*: proc(volume: ptr Volume00) {.cdecl.}
    removed*: proc(volume: ptr Volume00) {.cdecl.}
    getName*: proc(volume: ptr Volume00): cstring {.cdecl.}
    getIcon*: proc(volume: ptr Volume00): ptr Icon00 {.cdecl.}
    getUuid*: proc(volume: ptr Volume00): cstring {.cdecl.}
    getDrive*: proc(volume: ptr Volume00): ptr Drive00 {.cdecl.}
    getMount*: proc(volume: ptr Volume00): ptr Mount00 {.cdecl.}
    canMount*: proc(volume: ptr Volume00): gboolean {.cdecl.}
    canEject*: proc(volume: ptr Volume00): gboolean {.cdecl.}
    mountFn*: proc(volume: ptr Volume00; flags: MountMountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    mountFinish*: proc(volume: ptr Volume00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    eject*: proc(volume: ptr Volume00; flags: MountUnmountFlags; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.cdecl.}
    ejectFinish*: proc(volume: ptr Volume00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    getIdentifier*: proc(volume: ptr Volume00; kind: cstring): cstring {.cdecl.}
    enumerateIdentifiers*: proc(volume: ptr Volume00): cstringArray {.cdecl.}
    shouldAutomount*: proc(volume: ptr Volume00): gboolean {.cdecl.}
    getActivationRoot*: proc(volume: ptr Volume00): ptr File00 {.cdecl.}
    ejectWithOperation*: proc(volume: ptr Volume00; flags: MountUnmountFlags; mountOperation: ptr MountOperation00; 
    cancellable: ptr Cancellable00; callback: AsyncReadyCallback; 
    userData: pointer) {.cdecl.}
    ejectWithOperationFinish*: proc(volume: ptr Volume00; resu: ptr AsyncResult00): gboolean {.cdecl.}
    getSortKey*: proc(volume: ptr Volume00): cstring {.cdecl.}
    getSymbolicIcon*: proc(volume: ptr Volume00): ptr Icon00 {.cdecl.}
  VolumeIface* = ref object
    impl*: ptr VolumeIface00

type
  ZlibCompressor* = ref object of gobject.Object
  ZlibCompressor00* = object of gobject.Object00

proc g_zlib_compressor_get_file_info*(self: ptr ZlibCompressor00): ptr FileInfo00 {.
    importc: "g_zlib_compressor_get_file_info", libprag.}

proc getFileInfo*(self: ZlibCompressor): FileInfo =
  let gobj = g_zlib_compressor_get_file_info(cast[ptr ZlibCompressor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc fileInfo*(self: ZlibCompressor): FileInfo =
  let gobj = g_zlib_compressor_get_file_info(cast[ptr ZlibCompressor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc g_zlib_compressor_set_file_info*(self: ptr ZlibCompressor00; fileInfo: ptr FileInfo00) {.
    importc: "g_zlib_compressor_set_file_info", libprag.}

proc setFileInfo*(self: ZlibCompressor; fileInfo: FileInfo) =
  g_zlib_compressor_set_file_info(cast[ptr ZlibCompressor00](self.impl), cast[ptr FileInfo00](fileInfo.impl))

proc `fileInfo=`*(self: ZlibCompressor; fileInfo: FileInfo) =
  g_zlib_compressor_set_file_info(cast[ptr ZlibCompressor00](self.impl), cast[ptr FileInfo00](fileInfo.impl))

type
  ZlibCompressorFormat* {.size: sizeof(cint), pure.} = enum
    zlib = 0
    gzip = 1
    raw = 2

proc g_zlib_compressor_new*(format: ZlibCompressorFormat; level: int32): ptr ZlibCompressor00 {.
    importc: "g_zlib_compressor_new", libprag.}

proc newZlibCompressor*(format: ZlibCompressorFormat; level: int): ZlibCompressor =
  new(result, finalizeGObject)
  result.impl = g_zlib_compressor_new(format, int32(level))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initZlibCompressor*[T](result: var T; format: ZlibCompressorFormat; level: int) =
  assert(result is ZlibCompressor)
  new(result, finalizeGObject)
  result.impl = g_zlib_compressor_new(format, int32(level))
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

type
  ZlibCompressorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  ZlibCompressorClass* = ref object
    impl*: ptr ZlibCompressorClass00

type
  ZlibDecompressor* = ref object of gobject.Object
  ZlibDecompressor00* = object of gobject.Object00

proc g_zlib_decompressor_new*(format: ZlibCompressorFormat): ptr ZlibDecompressor00 {.
    importc: "g_zlib_decompressor_new", libprag.}

proc newZlibDecompressor*(format: ZlibCompressorFormat): ZlibDecompressor =
  new(result, finalizeGObject)
  result.impl = g_zlib_decompressor_new(format)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initZlibDecompressor*[T](result: var T; format: ZlibCompressorFormat) =
  assert(result is ZlibDecompressor)
  new(result, finalizeGObject)
  result.impl = g_zlib_decompressor_new(format)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_zlib_decompressor_get_file_info*(self: ptr ZlibDecompressor00): ptr FileInfo00 {.
    importc: "g_zlib_decompressor_get_file_info", libprag.}

proc getFileInfo*(self: ZlibDecompressor): FileInfo =
  let gobj = g_zlib_decompressor_get_file_info(cast[ptr ZlibDecompressor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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

proc fileInfo*(self: ZlibDecompressor): FileInfo =
  let gobj = g_zlib_decompressor_get_file_info(cast[ptr ZlibDecompressor00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[FileInfo](g_object_get_qdata(gobj, Quark))
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
  ZlibDecompressorClass00* {.pure.} = object
    parentClass*: gobject.ObjectClass00
  ZlibDecompressorClass* = ref object
    impl*: ptr ZlibDecompressorClass00

proc g_bus_get*(busType: BusType; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_bus_get", libprag.}

proc busGet*(busType: BusType; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_bus_get(busType, cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_bus_get_finish*(res: ptr AsyncResult00): ptr DBusConnection00 {.
    importc: "g_bus_get_finish", libprag.}

proc busGetFinish*(res: AsyncResult): DBusConnection =
  let gobj = g_bus_get_finish(cast[ptr AsyncResult00](res.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_bus_get_sync*(busType: BusType; cancellable: ptr Cancellable00): ptr DBusConnection00 {.
    importc: "g_bus_get_sync", libprag.}

proc busGetSync*(busType: BusType; cancellable: Cancellable): DBusConnection =
  let gobj = g_bus_get_sync(busType, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[DBusConnection](g_object_get_qdata(gobj, Quark))
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

proc g_bus_own_name_on_connection_with_closures*(connection: ptr DBusConnection00; name: cstring; flags: BusNameOwnerFlags; 
    nameAcquiredClosure: ptr gobject.Closure00; nameLostClosure: ptr gobject.Closure00): uint32 {.
    importc: "g_bus_own_name_on_connection_with_closures", libprag.}

proc busOwnNameOnConnection*(connection: DBusConnection; name: string; flags: BusNameOwnerFlags; 
    nameAcquiredClosure: gobject.Closure; nameLostClosure: gobject.Closure): int =
  int(g_bus_own_name_on_connection_with_closures(cast[ptr DBusConnection00](connection.impl), cstring(name), flags, cast[ptr gobject.Closure00](nameAcquiredClosure.impl), cast[ptr gobject.Closure00](nameLostClosure.impl)))

proc g_bus_own_name_with_closures*(busType: BusType; name: cstring; flags: BusNameOwnerFlags; 
    busAcquiredClosure: ptr gobject.Closure00; nameAcquiredClosure: ptr gobject.Closure00; 
    nameLostClosure: ptr gobject.Closure00): uint32 {.
    importc: "g_bus_own_name_with_closures", libprag.}

proc busOwnName*(busType: BusType; name: string; flags: BusNameOwnerFlags; 
    busAcquiredClosure: gobject.Closure; nameAcquiredClosure: gobject.Closure; nameLostClosure: gobject.Closure): int =
  int(g_bus_own_name_with_closures(busType, cstring(name), flags, cast[ptr gobject.Closure00](busAcquiredClosure.impl), cast[ptr gobject.Closure00](nameAcquiredClosure.impl), cast[ptr gobject.Closure00](nameLostClosure.impl)))

proc g_bus_unown_name*(ownerId: uint32) {.
    importc: "g_bus_unown_name", libprag.}

proc busUnownName*(ownerId: uint32) {.
    importc: "g_bus_unown_name", libprag.}

proc g_bus_unwatch_name*(watcherId: uint32) {.
    importc: "g_bus_unwatch_name", libprag.}

proc busUnwatchName*(watcherId: uint32) {.
    importc: "g_bus_unwatch_name", libprag.}

proc g_bus_watch_name_on_connection_with_closures*(connection: ptr DBusConnection00; name: cstring; flags: BusNameWatcherFlags; 
    nameAppearedClosure: ptr gobject.Closure00; nameVanishedClosure: ptr gobject.Closure00): uint32 {.
    importc: "g_bus_watch_name_on_connection_with_closures", libprag.}

proc busWatchNameOnConnection*(connection: DBusConnection; name: string; flags: BusNameWatcherFlags; 
    nameAppearedClosure: gobject.Closure; nameVanishedClosure: gobject.Closure): int =
  int(g_bus_watch_name_on_connection_with_closures(cast[ptr DBusConnection00](connection.impl), cstring(name), flags, cast[ptr gobject.Closure00](nameAppearedClosure.impl), cast[ptr gobject.Closure00](nameVanishedClosure.impl)))

proc g_bus_watch_name_with_closures*(busType: BusType; name: cstring; flags: BusNameWatcherFlags; 
    nameAppearedClosure: ptr gobject.Closure00; nameVanishedClosure: ptr gobject.Closure00): uint32 {.
    importc: "g_bus_watch_name_with_closures", libprag.}

proc busWatchName*(busType: BusType; name: string; flags: BusNameWatcherFlags; 
    nameAppearedClosure: gobject.Closure; nameVanishedClosure: gobject.Closure): int =
  int(g_bus_watch_name_with_closures(busType, cstring(name), flags, cast[ptr gobject.Closure00](nameAppearedClosure.impl), cast[ptr gobject.Closure00](nameVanishedClosure.impl)))

proc g_content_type_can_be_executable*(`type`: cstring): gboolean {.
    importc: "g_content_type_can_be_executable", libprag.}

proc contentTypeCanBeExecutable*(`type`: cstring): gboolean {.
    importc: "g_content_type_can_be_executable", libprag.}

proc g_content_type_equals*(type1: cstring; type2: cstring): gboolean {.
    importc: "g_content_type_equals", libprag.}

proc contentTypeEquals*(type1: cstring; type2: cstring): gboolean {.
    importc: "g_content_type_equals", libprag.}

proc g_content_type_from_mime_type*(mimeType: cstring): cstring {.
    importc: "g_content_type_from_mime_type", libprag.}

proc contentTypeFromMimeType*(mimeType: string): string =
  let resul0 = g_content_type_from_mime_type(cstring(mimeType))
  result = $resul0
  cogfree(resul0)

proc g_content_type_get_description*(`type`: cstring): cstring {.
    importc: "g_content_type_get_description", libprag.}

proc contentTypeGetDescription*(`type`: string): string =
  let resul0 = g_content_type_get_description(cstring(`type`))
  result = $resul0
  cogfree(resul0)

proc g_content_type_get_generic_icon_name*(`type`: cstring): cstring {.
    importc: "g_content_type_get_generic_icon_name", libprag.}

proc contentTypeGetGenericIconName*(`type`: string): string =
  let resul0 = g_content_type_get_generic_icon_name(cstring(`type`))
  result = $resul0
  cogfree(resul0)

proc g_content_type_get_icon*(`type`: cstring): ptr Icon00 {.
    importc: "g_content_type_get_icon", libprag.}

proc contentTypeGetIcon*(`type`: string): Icon =
  new(result)
  result.impl = g_content_type_get_icon(cstring(`type`))

proc g_content_type_get_mime_type*(`type`: cstring): cstring {.
    importc: "g_content_type_get_mime_type", libprag.}

proc contentTypeGetMimeType*(`type`: string): string =
  let resul0 = g_content_type_get_mime_type(cstring(`type`))
  result = $resul0
  cogfree(resul0)

proc g_content_type_get_symbolic_icon*(`type`: cstring): ptr Icon00 {.
    importc: "g_content_type_get_symbolic_icon", libprag.}

proc contentTypeGetSymbolicIcon*(`type`: string): Icon =
  new(result)
  result.impl = g_content_type_get_symbolic_icon(cstring(`type`))

proc g_content_type_guess*(filename: cstring; data: uint8Array; dataSize: uint64; 
    resultUncertain: var gboolean): cstring {.
    importc: "g_content_type_guess", libprag.}

proc contentTypeGuess*(filename: string; data: uint8Array; dataSize: uint64; 
    resultUncertain: var bool): string =
  var resultUncertain_00 = gboolean(resultUncertain)
  let resul0 = g_content_type_guess(cstring(filename), data, dataSize, resultUncertain_00)
  result = $resul0
  cogfree(resul0)
  resultUncertain = toBool(resultUncertain_00)

proc g_content_type_guess_for_tree*(root: ptr File00): cstringArray {.
    importc: "g_content_type_guess_for_tree", libprag.}

proc contentTypeGuessForTree*(root: File): cstringArray =
  g_content_type_guess_for_tree(cast[ptr File00](root.impl))

proc g_content_type_is_a*(`type`: cstring; supertype: cstring): gboolean {.
    importc: "g_content_type_is_a", libprag.}

proc contentTypeIsA*(`type`: cstring; supertype: cstring): gboolean {.
    importc: "g_content_type_is_a", libprag.}

proc g_content_type_is_unknown*(`type`: cstring): gboolean {.
    importc: "g_content_type_is_unknown", libprag.}

proc contentTypeIsUnknown*(`type`: cstring): gboolean {.
    importc: "g_content_type_is_unknown", libprag.}

proc g_content_types_get_registered*(): ptr pointer {.
    importc: "g_content_types_get_registered", libprag.}

proc contentTypesGetRegistered*(): ptr pointer {.
    importc: "g_content_types_get_registered", libprag.}

proc g_dbus_address_escape_value*(string: cstring): cstring {.
    importc: "g_dbus_address_escape_value", libprag.}

proc dbusAddressEscapeValue*(string: string): string =
  let resul0 = g_dbus_address_escape_value(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_dbus_address_get_for_bus_sync*(busType: BusType; cancellable: ptr Cancellable00): cstring {.
    importc: "g_dbus_address_get_for_bus_sync", libprag.}

proc dbusAddressGetForBusSync*(busType: BusType; cancellable: Cancellable): string =
  let resul0 = g_dbus_address_get_for_bus_sync(busType, cast[ptr Cancellable00](cancellable.impl))
  result = $resul0
  cogfree(resul0)

proc g_dbus_address_get_stream*(address: cstring; cancellable: ptr Cancellable00; 
    callback: AsyncReadyCallback; userData: pointer) {.
    importc: "g_dbus_address_get_stream", libprag.}

proc dbusAddressGetStream*(address: string; cancellable: Cancellable; callback: AsyncReadyCallback; 
    userData: pointer) =
  g_dbus_address_get_stream(cstring(address), cast[ptr Cancellable00](cancellable.impl), callback, userData)

proc g_dbus_address_get_stream_finish*(res: ptr AsyncResult00; outGuid: var cstring): ptr IOStream00 {.
    importc: "g_dbus_address_get_stream_finish", libprag.}

proc dbusAddressGetStreamFinish*(res: AsyncResult; outGuid: var string): IOStream =
  var outGuid_00 = cstring(outGuid)
  let gobj = g_dbus_address_get_stream_finish(cast[ptr AsyncResult00](res.impl), outGuid_00)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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
  outGuid = $(outGuid_00)

proc g_dbus_address_get_stream_sync*(address: cstring; outGuid: var cstring; cancellable: ptr Cancellable00): ptr IOStream00 {.
    importc: "g_dbus_address_get_stream_sync", libprag.}

proc dbusAddressGetStreamSync*(address: string; outGuid: var string; cancellable: Cancellable): IOStream =
  var outGuid_00 = cstring(outGuid)
  let gobj = g_dbus_address_get_stream_sync(cstring(address), outGuid_00, cast[ptr Cancellable00](cancellable.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[IOStream](g_object_get_qdata(gobj, Quark))
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
  outGuid = $(outGuid_00)

proc g_dbus_generate_guid*(): cstring {.
    importc: "g_dbus_generate_guid", libprag.}

proc dbusGenerateGuid*(): string =
  let resul0 = g_dbus_generate_guid()
  result = $resul0
  cogfree(resul0)

proc g_dbus_gvalue_to_gvariant*(gvalue: ptr gobject.Value00; `type`: ptr glib.VariantType00): ptr glib.Variant00 {.
    importc: "g_dbus_gvalue_to_gvariant", libprag.}

proc dbusGvalueToGvariant*(gvalue: gobject.Value; `type`: glib.VariantType): glib.Variant =
  new(result)
  result.impl = g_dbus_gvalue_to_gvariant(cast[ptr gobject.Value00](gvalue.impl), cast[ptr glib.VariantType00](`type`.impl))

proc g_dbus_gvariant_to_gvalue*(value: ptr glib.Variant00; outGvalue: var gobject.Value00) {.
    importc: "g_dbus_gvariant_to_gvalue", libprag.}

proc dbusGvariantToGvalue*(value: ptr glib.Variant00; outGvalue: var gobject.Value00) {.
    importc: "g_dbus_gvariant_to_gvalue", libprag.}

proc g_dbus_is_address*(string: cstring): gboolean {.
    importc: "g_dbus_is_address", libprag.}

proc dbusIsAddress*(string: cstring): gboolean {.
    importc: "g_dbus_is_address", libprag.}

proc g_dbus_is_guid*(string: cstring): gboolean {.
    importc: "g_dbus_is_guid", libprag.}

proc dbusIsGuid*(string: cstring): gboolean {.
    importc: "g_dbus_is_guid", libprag.}

proc g_dbus_is_interface_name*(string: cstring): gboolean {.
    importc: "g_dbus_is_interface_name", libprag.}

proc dbusIsInterfaceName*(string: cstring): gboolean {.
    importc: "g_dbus_is_interface_name", libprag.}

proc g_dbus_is_member_name*(string: cstring): gboolean {.
    importc: "g_dbus_is_member_name", libprag.}

proc dbusIsMemberName*(string: cstring): gboolean {.
    importc: "g_dbus_is_member_name", libprag.}

proc g_dbus_is_name*(string: cstring): gboolean {.
    importc: "g_dbus_is_name", libprag.}

proc dbusIsName*(string: cstring): gboolean {.
    importc: "g_dbus_is_name", libprag.}

proc g_dbus_is_supported_address*(string: cstring): gboolean {.
    importc: "g_dbus_is_supported_address", libprag.}

proc dbusIsSupportedAddress*(string: cstring): gboolean {.
    importc: "g_dbus_is_supported_address", libprag.}

proc g_dbus_is_unique_name*(string: cstring): gboolean {.
    importc: "g_dbus_is_unique_name", libprag.}

proc dbusIsUniqueName*(string: cstring): gboolean {.
    importc: "g_dbus_is_unique_name", libprag.}

proc g_io_error_from_errno*(errNo: int32): IOErrorEnum {.
    importc: "g_io_error_from_errno", libprag.}

proc ioErrorFromErrno*(errNo: int32): IOErrorEnum {.
    importc: "g_io_error_from_errno", libprag.}

proc g_io_error_quark*(): uint32 {.
    importc: "g_io_error_quark", libprag.}

proc ioErrorQuark*(): uint32 {.
    importc: "g_io_error_quark", libprag.}

proc g_io_modules_load_all_in_directory*(dirname: ucstring): ptr pointer {.
    importc: "g_io_modules_load_all_in_directory", libprag.}

proc ioModulesLoadAllInDirectory*(dirname: ucstring): ptr pointer {.
    importc: "g_io_modules_load_all_in_directory", libprag.}

proc g_io_modules_load_all_in_directory_with_scope*(dirname: ucstring; scope: ptr IOModuleScope00): ptr pointer {.
    importc: "g_io_modules_load_all_in_directory_with_scope", libprag.}

proc ioModulesLoadAllInDirectoryWithScope*(dirname: ucstring; scope: IOModuleScope): ptr pointer =
  g_io_modules_load_all_in_directory_with_scope(dirname, cast[ptr IOModuleScope00](scope.impl))

proc g_io_modules_scan_all_in_directory*(dirname: ucstring) {.
    importc: "g_io_modules_scan_all_in_directory", libprag.}

proc ioModulesScanAllInDirectory*(dirname: ucstring) {.
    importc: "g_io_modules_scan_all_in_directory", libprag.}

proc g_io_modules_scan_all_in_directory_with_scope*(dirname: ucstring; scope: ptr IOModuleScope00) {.
    importc: "g_io_modules_scan_all_in_directory_with_scope", libprag.}

proc ioModulesScanAllInDirectoryWithScope*(dirname: ucstring; scope: IOModuleScope) =
  g_io_modules_scan_all_in_directory_with_scope(dirname, cast[ptr IOModuleScope00](scope.impl))

proc g_io_scheduler_cancel_all_jobs*() {.
    importc: "g_io_scheduler_cancel_all_jobs", libprag.}

proc ioSchedulerCancelAllJobs*() {.
    importc: "g_io_scheduler_cancel_all_jobs", libprag.}

proc g_io_scheduler_push_job*(jobFunc: IOSchedulerJobFunc; userData: pointer; notify: DestroyNotify; 
    ioPriority: int32; cancellable: ptr Cancellable00) {.
    importc: "g_io_scheduler_push_job", libprag.}

proc ioSchedulerPushJob*(jobFunc: IOSchedulerJobFunc; userData: pointer; notify: DestroyNotify; 
    ioPriority: int; cancellable: Cancellable) =
  g_io_scheduler_push_job(jobFunc, userData, notify, int32(ioPriority), cast[ptr Cancellable00](cancellable.impl))

proc g_networking_init*() {.
    importc: "g_networking_init", libprag.}

proc networkingInit*() {.
    importc: "g_networking_init", libprag.}

proc g_pollable_source_new*(pollableStream: ptr gobject.Object00): ptr glib.Source00 {.
    importc: "g_pollable_source_new", libprag.}

proc pollableSourceNew*(pollableStream: gobject.Object): glib.Source =
  new(result)
  result.impl = g_pollable_source_new(cast[ptr gobject.Object00](pollableStream.impl))

proc g_pollable_source_new_full*(pollableStream: ptr gobject.Object00; childSource: ptr glib.Source00; 
    cancellable: ptr Cancellable00): ptr glib.Source00 {.
    importc: "g_pollable_source_new_full", libprag.}

proc pollableSourceNewFull*(pollableStream: gobject.Object; childSource: glib.Source; 
    cancellable: Cancellable): glib.Source =
  new(result)
  result.impl = g_pollable_source_new_full(cast[ptr gobject.Object00](pollableStream.impl), cast[ptr glib.Source00](childSource.impl), cast[ptr Cancellable00](cancellable.impl))

proc g_pollable_stream_read*(stream: ptr InputStream00; buffer: uint8Array; count: uint64; 
    blocking: gboolean; cancellable: ptr Cancellable00): int64 {.
    importc: "g_pollable_stream_read", libprag.}

proc pollableStreamRead*(stream: InputStream; buffer: uint8Array; count: uint64; 
    blocking: bool; cancellable: Cancellable): int64 =
  g_pollable_stream_read(cast[ptr InputStream00](stream.impl), buffer, count, gboolean(blocking), cast[ptr Cancellable00](cancellable.impl))

proc g_pollable_stream_write*(stream: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    blocking: gboolean; cancellable: ptr Cancellable00): int64 {.
    importc: "g_pollable_stream_write", libprag.}

proc pollableStreamWrite*(stream: OutputStream; buffer: uint8Array; count: uint64; 
    blocking: bool; cancellable: Cancellable): int64 =
  g_pollable_stream_write(cast[ptr OutputStream00](stream.impl), buffer, count, gboolean(blocking), cast[ptr Cancellable00](cancellable.impl))

proc g_pollable_stream_write_all*(stream: ptr OutputStream00; buffer: uint8Array; count: uint64; 
    blocking: gboolean; bytesWritten: var uint64; cancellable: ptr Cancellable00): gboolean {.
    importc: "g_pollable_stream_write_all", libprag.}

proc pollableStreamWriteAll*(stream: OutputStream; buffer: uint8Array; count: uint64; 
    blocking: bool; bytesWritten: var uint64; cancellable: Cancellable): bool =
  toBool(g_pollable_stream_write_all(cast[ptr OutputStream00](stream.impl), buffer, count, gboolean(blocking), bytesWritten, cast[ptr Cancellable00](cancellable.impl)))

proc g_resources_enumerate_children*(path: cstring; lookupFlags: ResourceLookupFlags): cstringArray {.
    importc: "g_resources_enumerate_children", libprag.}

proc resourcesEnumerateChildren*(path: cstring; lookupFlags: ResourceLookupFlags): cstringArray {.
    importc: "g_resources_enumerate_children", libprag.}

proc g_resources_get_info*(path: cstring; lookupFlags: ResourceLookupFlags; size: var uint64; 
    flags: var uint32): gboolean {.
    importc: "g_resources_get_info", libprag.}

proc resourcesGetInfo*(path: cstring; lookupFlags: ResourceLookupFlags; size: var uint64; 
    flags: var uint32): gboolean {.
    importc: "g_resources_get_info", libprag.}

proc g_resources_lookup_data*(path: cstring; lookupFlags: ResourceLookupFlags): ptr glib.Bytes00 {.
    importc: "g_resources_lookup_data", libprag.}

proc resourcesLookupData*(path: string; lookupFlags: ResourceLookupFlags): glib.Bytes =
  new(result)
  result.impl = g_resources_lookup_data(cstring(path), lookupFlags)

proc g_resources_open_stream*(path: cstring; lookupFlags: ResourceLookupFlags): ptr InputStream00 {.
    importc: "g_resources_open_stream", libprag.}

proc resourcesOpenStream*(path: string; lookupFlags: ResourceLookupFlags): InputStream =
  let gobj = g_resources_open_stream(cstring(path), lookupFlags)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[InputStream](g_object_get_qdata(gobj, Quark))
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

proc g_simple_async_report_gerror_in_idle*(`object`: ptr gobject.Object00; callback: AsyncReadyCallback; 
    userData: pointer; error: ptr Error00) {.
    importc: "g_simple_async_report_gerror_in_idle", libprag.}

proc simpleAsyncReportGerrorInIdle*(`object`: gobject.Object; callback: AsyncReadyCallback; 
    userData: pointer; error: ptr Error00) =
  g_simple_async_report_gerror_in_idle(cast[ptr gobject.Object00](`object`.impl), callback, userData, error)

proc g_unix_is_mount_path_system_internal*(mountPath: ucstring): gboolean {.
    importc: "g_unix_is_mount_path_system_internal", libprag.}

proc unixIsMountPathSystemInternal*(mountPath: ucstring): gboolean {.
    importc: "g_unix_is_mount_path_system_internal", libprag.}

proc g_unix_mount_compare*(mount1: ptr UnixMountEntry00; mount2: ptr UnixMountEntry00): int32 {.
    importc: "g_unix_mount_compare", libprag.}

proc unixMountCompare*(mount1: UnixMountEntry; mount2: UnixMountEntry): int =
  int(g_unix_mount_compare(cast[ptr UnixMountEntry00](mount1.impl), cast[ptr UnixMountEntry00](mount2.impl)))

proc g_unix_mount_free*(mountEntry: ptr UnixMountEntry00) {.
    importc: "g_unix_mount_free", libprag.}

proc unixMountFree*(mountEntry: UnixMountEntry) =
  g_unix_mount_free(cast[ptr UnixMountEntry00](mountEntry.impl))

proc g_unix_mount_get_device_path*(mountEntry: ptr UnixMountEntry00): ucstring {.
    importc: "g_unix_mount_get_device_path", libprag.}

proc unixMountGetDevicePath*(mountEntry: UnixMountEntry): ucstring =
  g_unix_mount_get_device_path(cast[ptr UnixMountEntry00](mountEntry.impl))

proc g_unix_mount_get_fs_type*(mountEntry: ptr UnixMountEntry00): cstring {.
    importc: "g_unix_mount_get_fs_type", libprag.}

proc unixMountGetFsType*(mountEntry: UnixMountEntry): string =
  let resul0 = g_unix_mount_get_fs_type(cast[ptr UnixMountEntry00](mountEntry.impl))
  result = $resul0

proc g_unix_mount_get_mount_path*(mountEntry: ptr UnixMountEntry00): ucstring {.
    importc: "g_unix_mount_get_mount_path", libprag.}

proc unixMountGetMountPath*(mountEntry: UnixMountEntry): ucstring =
  g_unix_mount_get_mount_path(cast[ptr UnixMountEntry00](mountEntry.impl))

proc g_unix_mount_guess_can_eject*(mountEntry: ptr UnixMountEntry00): gboolean {.
    importc: "g_unix_mount_guess_can_eject", libprag.}

proc unixMountGuessCanEject*(mountEntry: UnixMountEntry): bool =
  toBool(g_unix_mount_guess_can_eject(cast[ptr UnixMountEntry00](mountEntry.impl)))

proc g_unix_mount_guess_icon*(mountEntry: ptr UnixMountEntry00): ptr Icon00 {.
    importc: "g_unix_mount_guess_icon", libprag.}

proc unixMountGuessIcon*(mountEntry: UnixMountEntry): Icon =
  new(result)
  result.impl = g_unix_mount_guess_icon(cast[ptr UnixMountEntry00](mountEntry.impl))

proc g_unix_mount_guess_name*(mountEntry: ptr UnixMountEntry00): cstring {.
    importc: "g_unix_mount_guess_name", libprag.}

proc unixMountGuessName*(mountEntry: UnixMountEntry): string =
  let resul0 = g_unix_mount_guess_name(cast[ptr UnixMountEntry00](mountEntry.impl))
  result = $resul0
  cogfree(resul0)

proc g_unix_mount_guess_should_display*(mountEntry: ptr UnixMountEntry00): gboolean {.
    importc: "g_unix_mount_guess_should_display", libprag.}

proc unixMountGuessShouldDisplay*(mountEntry: UnixMountEntry): bool =
  toBool(g_unix_mount_guess_should_display(cast[ptr UnixMountEntry00](mountEntry.impl)))

proc g_unix_mount_guess_symbolic_icon*(mountEntry: ptr UnixMountEntry00): ptr Icon00 {.
    importc: "g_unix_mount_guess_symbolic_icon", libprag.}

proc unixMountGuessSymbolicIcon*(mountEntry: UnixMountEntry): Icon =
  new(result)
  result.impl = g_unix_mount_guess_symbolic_icon(cast[ptr UnixMountEntry00](mountEntry.impl))

proc g_unix_mount_is_readonly*(mountEntry: ptr UnixMountEntry00): gboolean {.
    importc: "g_unix_mount_is_readonly", libprag.}

proc unixMountIsReadonly*(mountEntry: UnixMountEntry): bool =
  toBool(g_unix_mount_is_readonly(cast[ptr UnixMountEntry00](mountEntry.impl)))

proc g_unix_mount_is_system_internal*(mountEntry: ptr UnixMountEntry00): gboolean {.
    importc: "g_unix_mount_is_system_internal", libprag.}

proc unixMountIsSystemInternal*(mountEntry: UnixMountEntry): bool =
  toBool(g_unix_mount_is_system_internal(cast[ptr UnixMountEntry00](mountEntry.impl)))

proc g_unix_mount_points_changed_since*(time: uint64): gboolean {.
    importc: "g_unix_mount_points_changed_since", libprag.}

proc unixMountPointsChangedSince*(time: uint64): gboolean {.
    importc: "g_unix_mount_points_changed_since", libprag.}

proc g_unix_mounts_changed_since*(time: uint64): gboolean {.
    importc: "g_unix_mounts_changed_since", libprag.}

proc unixMountsChangedSince*(time: uint64): gboolean {.
    importc: "g_unix_mounts_changed_since", libprag.}
# === remaining symbols:

proc run*(self: Application): int =
  int(g_application_run(cast[ptr Application00](self.impl), 0, nil))

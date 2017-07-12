# dependencies:
# GLib-2.0
# immediate dependencies:
# GLib-2.0
# libraries:
# libgobject-2.0.so.0
{.deadCodeElim: on.}
import glib
const Lib* = "libgobject-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  GCallback* = proc () {.cdecl.}
type
  Parameter00Array* = pointer
type
  Object00Array* = pointer
type
  Value00Array* = pointer
type
  GTypeArray* = pointer
type
  ParamSpec00Array* = pointer
type
  TypePlugin00Array* = pointer
type
  uint32Array* = pointer
type
  VaClosureMarshal* = pointer
type
  TypePlugin00* = object
let Quark = g_quark_from_static_string("NimGIQuark")

type
  TypeClass00* {.pure.} = object
    gType*: GType
  TypeClass* = ref object
    impl*: ptr TypeClass00

proc g_type_class_add_private*(self: ptr TypeClass00; privateSize: uint64) {.
    importc: "g_type_class_add_private", libprag.}

proc addPrivate*(self: TypeClass; privateSize: uint64) =
  g_type_class_add_private(cast[ptr TypeClass00](self.impl), privateSize)

proc g_type_class_get_private*(self: ptr TypeClass00; privateType: GType): pointer {.
    importc: "g_type_class_get_private", libprag.}

proc getPrivate*(self: TypeClass; privateType: GType): pointer =
  g_type_class_get_private(cast[ptr TypeClass00](self.impl), privateType)

proc private*(self: TypeClass; privateType: GType): pointer =
  g_type_class_get_private(cast[ptr TypeClass00](self.impl), privateType)

proc g_type_class_peek_parent*(self: ptr TypeClass00): ptr TypeClass00 {.
    importc: "g_type_class_peek_parent", libprag.}

proc peekParent*(self: TypeClass): TypeClass =
  new(result)
  result.impl = g_type_class_peek_parent(cast[ptr TypeClass00](self.impl))

proc g_type_class_unref*(self: ptr TypeClass00) {.
    importc: "g_type_class_unref", libprag.}

proc unref*(self: TypeClass) =
  g_type_class_unref(cast[ptr TypeClass00](self.impl))

proc g_type_class_adjust_private_offset*(gClass: pointer; privateSizeOrOffset: ptr int32) {.
    importc: "g_type_class_adjust_private_offset", libprag.}

proc adjustPrivateOffset*(gClass: pointer; privateSizeOrOffset: ptr int32) {.
    importc: "g_type_class_adjust_private_offset", libprag.}

proc g_type_class_peek*(`type`: GType): ptr TypeClass00 {.
    importc: "g_type_class_peek", libprag.}

proc peek*(`type`: GType): TypeClass =
  new(result)
  result.impl = g_type_class_peek(`type`)

proc g_type_class_peek_static*(`type`: GType): ptr TypeClass00 {.
    importc: "g_type_class_peek_static", libprag.}

proc peekStatic*(`type`: GType): TypeClass =
  new(result)
  result.impl = g_type_class_peek_static(`type`)

proc g_type_class_ref*(`type`: GType): ptr TypeClass00 {.
    importc: "g_type_class_ref", libprag.}

proc `ref`*(`type`: GType): TypeClass =
  new(result)
  result.impl = g_type_class_ref(`type`)

type
  BaseFinalizeFunc* = proc (gClass: ptr TypeClass00) {.cdecl.}

type
  BaseInitFunc* = proc (gClass: ptr TypeClass00) {.cdecl.}

type
  TypeInstance00* {.pure.} = object
    gClass*: ptr TypeClass00
  TypeInstance* = ref object
    impl*: ptr TypeInstance00

proc g_type_instance_get_private*(self: ptr TypeInstance00; privateType: GType): pointer {.
    importc: "g_type_instance_get_private", libprag.}

proc getPrivate*(self: TypeInstance; privateType: GType): pointer =
  g_type_instance_get_private(cast[ptr TypeInstance00](self.impl), privateType)

proc private*(self: TypeInstance; privateType: GType): pointer =
  g_type_instance_get_private(cast[ptr TypeInstance00](self.impl), privateType)

type
  Object00*{.inheritable, pure.} = object
    gTypeInstance*: TypeInstance00
    refCount*: uint32
    qdata*: ptr glib.Data00
type
  GToggleNotify* = proc (data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.}

proc g_object_add_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.
    importc: "g_object_add_toggle_ref", libprag.}
proc g_object_remove_toggle_ref*(obj: ptr Object00; notify: GToggleNotify; data: pointer) {.
    importc: "g_object_remove_toggle_ref", libprag.}

proc g_object_set_qdata*(self: ptr Object00; quark: uint32; p: pointer) {.
    importc: "g_object_set_qdata", libprag.}
proc toggleNotify*(data: pointer; obj: ptr Object00; isLastRef: gboolean) {.cdecl.} =
  if isLastRef.int == 0:
    GC_ref(cast[RootRef](data))
    echo "GC_ref(cast[RootRef](data)"
  else:
    GC_unref(cast[RootRef](data))
    echo "GC_unref(cast[RootRef](data)"
  echo "toggleNotify"
  echo obj.ref_count

type
  Object* = ref object of RootRef
    impl*: ptr Object00

proc finalizeGObject*[T](o: T) =
  echo("finalizeGObject")
  g_object_remove_toggle_ref(o.impl, toggleNotify, addr(o[]))

proc g_object_compat_control*(what: uint64; data: pointer): uint64 {.
    importc: "g_object_compat_control", libprag.}

proc compatControl*(what: uint64; data: pointer): uint64 {.
    importc: "g_object_compat_control", libprag.}

proc g_object_force_floating*(self: ptr Object00) {.
    importc: "g_object_force_floating", libprag.}

proc forceFloating*(self: Object) =
  g_object_force_floating(cast[ptr Object00](self.impl))

proc g_object_freeze_notify*(self: ptr Object00) {.
    importc: "g_object_freeze_notify", libprag.}

proc freezeNotify*(self: Object) =
  g_object_freeze_notify(cast[ptr Object00](self.impl))

proc g_object_get_data*(self: ptr Object00; key: cstring): pointer {.
    importc: "g_object_get_data", libprag.}

proc getData*(self: Object; key: string): pointer =
  g_object_get_data(cast[ptr Object00](self.impl), cstring(key))

proc data*(self: Object; key: string): pointer =
  g_object_get_data(cast[ptr Object00](self.impl), cstring(key))

proc g_object_get_qdata*(self: ptr Object00; quark: uint32): pointer {.
    importc: "g_object_get_qdata", libprag.}

proc getQdata*(self: Object; quark: int): pointer =
  g_object_get_qdata(cast[ptr Object00](self.impl), uint32(quark))

proc qdata*(self: Object; quark: int): pointer =
  g_object_get_qdata(cast[ptr Object00](self.impl), uint32(quark))

proc g_object_is_floating*(self: ptr Object00): gboolean {.
    importc: "g_object_is_floating", libprag.}

proc isFloating*(self: Object): bool =
  toBool(g_object_is_floating(cast[ptr Object00](self.impl)))

proc g_object_notify*(self: ptr Object00; propertyName: cstring) {.
    importc: "g_object_notify", libprag.}

proc notify*(self: Object; propertyName: string) =
  g_object_notify(cast[ptr Object00](self.impl), cstring(propertyName))

proc g_object_ref*(self: ptr Object00): ptr Object00 {.
    importc: "g_object_ref", libprag.}

proc `ref`*(self: Object): Object =
  let gobj = g_object_ref(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    assert(false)

proc g_object_ref_sink*(self: ptr Object00): ptr Object00 {.
    importc: "g_object_ref_sink", libprag.}

proc refSink*(self: Object): Object =
  let gobj = g_object_ref_sink(cast[ptr Object00](self.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Object](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    assert(false)

proc g_object_replace_data*(self: ptr Object00; key: cstring; oldval: pointer; 
    newval: pointer; destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): gboolean {.
    importc: "g_object_replace_data", libprag.}

proc replaceData*(self: Object; key: string; oldval: pointer; newval: pointer; 
    destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): bool =
  toBool(g_object_replace_data(cast[ptr Object00](self.impl), cstring(key), oldval, newval, destroy, oldDestroy))

proc g_object_replace_qdata*(self: ptr Object00; quark: uint32; oldval: pointer; 
    newval: pointer; destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): gboolean {.
    importc: "g_object_replace_qdata", libprag.}

proc replaceQdata*(self: Object; quark: int; oldval: pointer; newval: pointer; 
    destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): bool =
  toBool(g_object_replace_qdata(cast[ptr Object00](self.impl), uint32(quark), oldval, newval, destroy, oldDestroy))

proc g_object_run_dispose*(self: ptr Object00) {.
    importc: "g_object_run_dispose", libprag.}

proc runDispose*(self: Object) =
  g_object_run_dispose(cast[ptr Object00](self.impl))

proc g_object_set_data*(self: ptr Object00; key: cstring; data: pointer) {.
    importc: "g_object_set_data", libprag.}

proc setData*(self: Object; key: string; data: pointer) =
  g_object_set_data(cast[ptr Object00](self.impl), cstring(key), data)

proc g_object_steal_data*(self: ptr Object00; key: cstring): pointer {.
    importc: "g_object_steal_data", libprag.}

proc stealData*(self: Object; key: string): pointer =
  g_object_steal_data(cast[ptr Object00](self.impl), cstring(key))

proc g_object_steal_qdata*(self: ptr Object00; quark: uint32): pointer {.
    importc: "g_object_steal_qdata", libprag.}

proc stealQdata*(self: Object; quark: int): pointer =
  g_object_steal_qdata(cast[ptr Object00](self.impl), uint32(quark))

proc g_object_thaw_notify*(self: ptr Object00) {.
    importc: "g_object_thaw_notify", libprag.}

proc thawNotify*(self: Object) =
  g_object_thaw_notify(cast[ptr Object00](self.impl))

proc g_object_unref*(self: ptr Object00) {.
    importc: "g_object_unref", libprag.}

proc unref*(self: Object) =
  g_object_unref(cast[ptr Object00](self.impl))

type
  Binding* = ref object of Object
  Binding00* = object of Object00

proc g_binding_get_source*(self: ptr Binding00): ptr Object00 {.
    importc: "g_binding_get_source", libprag.}

proc getSource*(self: Binding): Object =
  let gobj = g_binding_get_source(cast[ptr Binding00](self.impl))
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

proc source*(self: Binding): Object =
  let gobj = g_binding_get_source(cast[ptr Binding00](self.impl))
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

proc g_binding_get_source_property*(self: ptr Binding00): cstring {.
    importc: "g_binding_get_source_property", libprag.}

proc getSourceProperty*(self: Binding): string =
  let resul0 = g_binding_get_source_property(cast[ptr Binding00](self.impl))
  result = $resul0

proc sourceProperty*(self: Binding): string =
  let resul0 = g_binding_get_source_property(cast[ptr Binding00](self.impl))
  result = $resul0

proc g_binding_get_target*(self: ptr Binding00): ptr Object00 {.
    importc: "g_binding_get_target", libprag.}

proc getTarget*(self: Binding): Object =
  let gobj = g_binding_get_target(cast[ptr Binding00](self.impl))
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

proc target*(self: Binding): Object =
  let gobj = g_binding_get_target(cast[ptr Binding00](self.impl))
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

proc g_binding_get_target_property*(self: ptr Binding00): cstring {.
    importc: "g_binding_get_target_property", libprag.}

proc getTargetProperty*(self: Binding): string =
  let resul0 = g_binding_get_target_property(cast[ptr Binding00](self.impl))
  result = $resul0

proc targetProperty*(self: Binding): string =
  let resul0 = g_binding_get_target_property(cast[ptr Binding00](self.impl))
  result = $resul0

proc g_binding_unbind*(self: ptr Binding00) {.
    importc: "g_binding_unbind", libprag.}

proc unbind*(self: Binding) =
  g_binding_unbind(cast[ptr Binding00](self.impl))

type
  TypeInterface00* {.pure.} = object
    gType*: GType
    gInstanceType*: GType
  TypeInterface* = ref object
    impl*: ptr TypeInterface00

proc g_type_interface_peek_parent*(self: ptr TypeInterface00): ptr TypeInterface00 {.
    importc: "g_type_interface_peek_parent", libprag.}

proc g_type_interface_add_prerequisite*(interfaceType: GType; prerequisiteType: GType) {.
    importc: "g_type_interface_add_prerequisite", libprag.}

proc g_type_interface_peek*(instanceClass: ptr TypeClass00; ifaceType: GType): ptr TypeInterface00 {.
    importc: "g_type_interface_peek", libprag.}

proc g_type_interface_prerequisites*(interfaceType: GType; nPrerequisites: var uint32): GTypeArray {.
    importc: "g_type_interface_prerequisites", libprag.}


proc g_type_interface_get_plugin*(instanceType: GType; interfaceType: GType): ptr TypePlugin00 {.
    importc: "g_type_interface_get_plugin", libprag.}

type
  ParamFlags* {.size: sizeof(cint), pure.} = enum
    readable = 1
    writable = 2
    readwrite = 3
    construct = 4
    constructOnly = 8
    laxValidation = 16
    private = 32
    staticNick = 64
    staticBlurb = 128
    explicitNotify = 1073741824
    deprecated = 2147483648

const
  ParamFlagsStaticName* = ParamFlags.private

type
  ParamSpec* = ref object of RootRef
    impl*: ptr ParamSpec00
  ParamSpec00*{.inheritable, pure.} = object
    gTypeInstance*: TypeInstance00
    name*: cstring
    flags*: ParamFlags
    valueType*: GType
    ownerType*: GType
    nick*: cstring
    blurb*: cstring
    qdata*: ptr glib.Data00
    refCount*: uint32
    paramId*: uint32

proc g_param_spec_get_blurb*(self: ptr ParamSpec00): cstring {.
    importc: "g_param_spec_get_blurb", libprag.}

proc g_param_spec_get_name*(self: ptr ParamSpec00): cstring {.
    importc: "g_param_spec_get_name", libprag.}

proc g_param_spec_get_name_quark*(self: ptr ParamSpec00): uint32 {.
    importc: "g_param_spec_get_name_quark", libprag.}

proc g_param_spec_get_nick*(self: ptr ParamSpec00): cstring {.
    importc: "g_param_spec_get_nick", libprag.}

proc g_param_spec_get_qdata*(self: ptr ParamSpec00; quark: uint32): pointer {.
    importc: "g_param_spec_get_qdata", libprag.}

proc g_param_spec_get_redirect_target*(self: ptr ParamSpec00): ptr ParamSpec00 {.
    importc: "g_param_spec_get_redirect_target", libprag.}

proc g_param_spec_set_qdata*(self: ptr ParamSpec00; quark: uint32; data: pointer) {.
    importc: "g_param_spec_set_qdata", libprag.}

proc g_param_spec_sink*(self: ptr ParamSpec00) {.
    importc: "g_param_spec_sink", libprag.}

proc g_param_spec_steal_qdata*(self: ptr ParamSpec00; quark: uint32): pointer {.
    importc: "g_param_spec_steal_qdata", libprag.}

proc g_object_interface_find_property*(gIface: ptr TypeInterface00; propertyName: cstring): ptr ParamSpec00 {.
    importc: "g_object_interface_find_property", libprag.}

proc g_object_interface_install_property*(gIface: ptr TypeInterface00; pspec: ptr ParamSpec00) {.
    importc: "g_object_interface_install_property", libprag.}

proc g_object_interface_list_properties*(gIface: ptr TypeInterface00; nPropertiesP: var uint32): ptr ParamSpec00Array {.
    importc: "g_object_interface_list_properties", libprag.}

proc g_object_notify_by_pspec*(self: ptr Object00; pspec: ptr ParamSpec00) {.
    importc: "g_object_notify_by_pspec", libprag.}

proc notifyByPspec*(self: Object; pspec: ParamSpec) =
  g_object_notify_by_pspec(cast[ptr Object00](self.impl), cast[ptr ParamSpec00](pspec.impl))

type
  BindingFlag* {.size: sizeof(cint), pure.} = enum
    bidirectional = 1
    syncCreate = 2
    invertBoolean = 3

  BindingFlags* {.size: sizeof(cint).} = set[BindingFlag]

proc g_object_bind_property*(self: ptr Object00; sourceProperty: cstring; target: ptr Object00; 
    targetProperty: cstring; flags: BindingFlags): ptr Binding00 {.
    importc: "g_object_bind_property", libprag.}

proc bindProperty*(self: Object; sourceProperty: string; target: Object; 
    targetProperty: string; flags: BindingFlags): Binding =
  let gobj = g_object_bind_property(cast[ptr Object00](self.impl), cstring(sourceProperty), cast[ptr Object00](target.impl), cstring(targetProperty), flags)
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Binding](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_binding_get_flags*(self: ptr Binding00): BindingFlags {.
    importc: "g_binding_get_flags", libprag.}

proc getFlags*(self: Binding): BindingFlags =
  g_binding_get_flags(cast[ptr Binding00](self.impl))

proc flags*(self: Binding): BindingFlags =
  g_binding_get_flags(cast[ptr Binding00](self.impl))

type
  BoxedCopyFunc* = proc (boxed: pointer): pointer {.cdecl.}

type
  BoxedFreeFunc* = proc (boxed: pointer) {.cdecl.}

type
  Callback* = proc () {.cdecl.}

type
  ClassFinalizeFunc* = proc (gClass: ptr TypeClass00; classData: pointer) {.cdecl.}

type
  ClassInitFunc* = proc (gClass: ptr TypeClass00; classData: pointer) {.cdecl.}

type
  ConnectFlag* {.size: sizeof(cint), pure.} = enum
    after = 1
    swapped = 2

  ConnectFlags* {.size: sizeof(cint).} = set[ConnectFlag]

type
  EnumValue00* {.pure.} = object
    value*: int32
    valueName*: cstring
    valueNick*: cstring
  EnumValue* = ref object
    impl*: ptr EnumValue00

type
  EnumClass00* {.pure.} = object
    gTypeClass*: TypeClass00
    minimum*: int32
    maximum*: int32
    nValues*: uint32
    values*: ptr EnumValue00
  EnumClass* = ref object
    impl*: ptr EnumClass00

type
  FlagsValue00* {.pure.} = object
    value*: uint32
    valueName*: cstring
    valueNick*: cstring
  FlagsValue* = ref object
    impl*: ptr FlagsValue00

type
  FlagsClass00* {.pure.} = object
    gTypeClass*: TypeClass00
    mask*: uint32
    nValues*: uint32
    values*: ptr FlagsValue00
  FlagsClass* = ref object
    impl*: ptr FlagsClass00

type
  InitiallyUnowned* = ref object of Object
  InitiallyUnowned00* = object of Object00

type
  InstanceInitFunc* = proc (instance: ptr TypeInstance00; gClass: ptr TypeClass00) {.cdecl.}

type
  InterfaceFinalizeFunc* = proc (gIface: ptr TypeInterface00; ifaceData: pointer) {.cdecl.}

type
  InterfaceInitFunc* = proc (gIface: ptr TypeInterface00; ifaceData: pointer) {.cdecl.}

type
  InterfaceInfo00* {.pure.} = object
    interfaceInit*: InterfaceInitFunc
    interfaceFinalize*: InterfaceFinalizeFunc
    interfaceData*: pointer
  InterfaceInfo* = ref object
    impl*: ptr InterfaceInfo00

type
  ObjectFinalizeFunc* = proc (`object`: ptr Object00) {.cdecl.}

const PARAM_MASK* = 255'i32

const PARAM_STATIC_STRINGS* = 0'i32

const PARAM_USER_SHIFT* = 8'i32

type
  ParamSpecBoolean* = ref object of ParamSpec
  ParamSpecBoolean00* = object of ParamSpec00
    defaultValue*: gboolean

type
  ParamSpecBoxed* = ref object of ParamSpec
  ParamSpecBoxed00* = object of ParamSpec00

type
  ParamSpecChar* = ref object of ParamSpec
  ParamSpecChar00* = object of ParamSpec00
    minimum*: int8
    maximum*: int8
    defaultValue*: int8

type
  ParamSpecDouble* = ref object of ParamSpec
  ParamSpecDouble00* = object of ParamSpec00
    minimum*: cdouble
    maximum*: cdouble
    defaultValue*: cdouble
    epsilon*: cdouble

type
  ParamSpecEnum* = ref object of ParamSpec
  ParamSpecEnum00* = object of ParamSpec00
    enumClass*: ptr EnumClass00
    defaultValue*: int32

type
  ParamSpecFlags* = ref object of ParamSpec
  ParamSpecFlags00* = object of ParamSpec00
    flagsClass*: ptr FlagsClass00
    defaultValue*: uint32

type
  ParamSpecFloat* = ref object of ParamSpec
  ParamSpecFloat00* = object of ParamSpec00
    minimum*: cfloat
    maximum*: cfloat
    defaultValue*: cfloat
    epsilon*: cfloat

type
  ParamSpecGType* = ref object of ParamSpec
  ParamSpecGType00* = object of ParamSpec00
    isAType*: GType

type
  ParamSpecInt* = ref object of ParamSpec
  ParamSpecInt00* = object of ParamSpec00
    minimum*: int32
    maximum*: int32
    defaultValue*: int32

type
  ParamSpecInt64* = ref object of ParamSpec
  ParamSpecInt6400* = object of ParamSpec00
    minimum*: int64
    maximum*: int64
    defaultValue*: int64

type
  ParamSpecLong* = ref object of ParamSpec
  ParamSpecLong00* = object of ParamSpec00
    minimum*: int64
    maximum*: int64
    defaultValue*: int64

type
  ParamSpecObject* = ref object of ParamSpec
  ParamSpecObject00* = object of ParamSpec00

type
  ParamSpecOverride* = ref object of ParamSpec
  ParamSpecOverride00* = object of ParamSpec00
    overridden*: ptr ParamSpec00

type
  ParamSpecParam* = ref object of ParamSpec
  ParamSpecParam00* = object of ParamSpec00

type
  ParamSpecPointer* = ref object of ParamSpec
  ParamSpecPointer00* = object of ParamSpec00

type
  ParamSpecPool00* {.pure.} = object
  ParamSpecPool* = ref object
    impl*: ptr ParamSpecPool00

proc g_param_spec_pool_insert*(self: ptr ParamSpecPool00; pspec: ptr ParamSpec00; 
    ownerType: GType) {.
    importc: "g_param_spec_pool_insert", libprag.}

proc g_param_spec_pool_list*(self: ptr ParamSpecPool00; ownerType: GType; nPspecsP: var uint32): ptr ParamSpec00Array {.
    importc: "g_param_spec_pool_list", libprag.}

proc g_param_spec_pool_list_owned*(self: ptr ParamSpecPool00; ownerType: GType): ptr pointer {.
    importc: "g_param_spec_pool_list_owned", libprag.}

proc g_param_spec_pool_lookup*(self: ptr ParamSpecPool00; paramName: cstring; ownerType: GType; 
    walkAncestors: gboolean): ptr ParamSpec00 {.
    importc: "g_param_spec_pool_lookup", libprag.}

proc g_param_spec_pool_remove*(self: ptr ParamSpecPool00; pspec: ptr ParamSpec00) {.
    importc: "g_param_spec_pool_remove", libprag.}

proc g_param_spec_pool_new*(typePrefixing: gboolean): ptr ParamSpecPool00 {.
    importc: "g_param_spec_pool_new", libprag.}

type
  ParamSpecString* = ref object of ParamSpec
  ParamSpecString00* = object of ParamSpec00
    defaultValue*: cstring
    csetFirst*: cstring
    csetNth*: cstring
    substitutor*: int8
    nullFoldIfEmpty*: uint32
    ensureNonNull*: uint32

type
  ParamSpecUChar* = ref object of ParamSpec
  ParamSpecUChar00* = object of ParamSpec00
    minimum*: uint8
    maximum*: uint8
    defaultValue*: uint8

type
  ParamSpecUInt* = ref object of ParamSpec
  ParamSpecUInt00* = object of ParamSpec00
    minimum*: uint32
    maximum*: uint32
    defaultValue*: uint32

type
  ParamSpecUInt64* = ref object of ParamSpec
  ParamSpecUInt6400* = object of ParamSpec00
    minimum*: uint64
    maximum*: uint64
    defaultValue*: uint64

type
  ParamSpecULong* = ref object of ParamSpec
  ParamSpecULong00* = object of ParamSpec00
    minimum*: uint64
    maximum*: uint64
    defaultValue*: uint64

type
  ParamSpecUnichar* = ref object of ParamSpec
  ParamSpecUnichar00* = object of ParamSpec00
    defaultValue*: gunichar

type
  ParamSpecValueArray* = ref object of ParamSpec
  ParamSpecValueArray00* = object of ParamSpec00
    elementSpec*: ptr ParamSpec00
    fixedNElements*: uint32

type
  ParamSpecVariant* = ref object of ParamSpec
  ParamSpecVariant00* = object of ParamSpec00
    `type`*: ptr glib.VariantType00
    defaultValue*: ptr glib.Variant00
    padding1: array[4, pointer]

const SIGNAL_FLAGS_MASK* = 511'i32

const SIGNAL_MATCH_MASK* = 63'i32

type
  SignalFlag* {.size: sizeof(cint), pure.} = enum
    runFirst = 1
    runLast = 2
    runCleanup = 3
    noRecurse = 4
    detailed = 5
    action = 6
    noHooks = 7
    mustCollect = 8
    deprecated = 9

  SignalFlags* {.size: sizeof(cint).} = set[SignalFlag]

type
  SignalInvocationHint00* {.pure.} = object
    signalId*: uint32
    detail*: uint32
    runType*: SignalFlags
  SignalInvocationHint* = ref object
    impl*: ptr SignalInvocationHint00

type
  SignalMatchType* {.size: sizeof(cint), pure.} = enum
    id = 1
    detail = 2
    closure = 4
    `func` = 8
    data = 16
    unblocked = 32

type
  SignalQuery00* {.pure.} = object
    signalId*: uint32
    signalName*: cstring
    itype*: GType
    signalFlags*: SignalFlags
    returnType*: GType
    nParams*: uint32
    paramTypes*: GTypeArray
  SignalQuery* = ref object
    impl*: ptr SignalQuery00

const TYPE_FLAG_RESERVED_ID_BIT* = 1'u64

const TYPE_FUNDAMENTAL_MAX* = 255'i32

const TYPE_FUNDAMENTAL_SHIFT* = 2'i32

const TYPE_RESERVED_BSE_FIRST* = 32'i32

const TYPE_RESERVED_BSE_LAST* = 48'i32

const TYPE_RESERVED_GLIB_FIRST* = 22'i32

const TYPE_RESERVED_GLIB_LAST* = 31'i32

const TYPE_RESERVED_USER_FIRST* = 49'i32

type
  ToggleNotify* = proc (data: pointer; `object`: ptr Object00; isLastRef: gboolean) {.cdecl.}

type
  TypeCValue00* = object {.union.}
    vInt*: int32
    vLong*: int64
    vInt64*: int64
    vDouble*: cdouble
    vPointer*: pointer
  TypeCValue* = ref object
    impl*: ptr TypeCValue00

type
  TypeClassCacheFunc* = proc (cacheData: pointer; gClass: ptr TypeClass00): gboolean {.cdecl.}

type
  TypeDebugFlags* {.size: sizeof(cint), pure.} = enum
    none = 0
    objects = 1
    signals = 2
    instanceCount = 4
    mask = 7

type
  TypeFlag* {.size: sizeof(cint), pure.} = enum
    abstract = 5
    valueAbstract = 6

  TypeFlags* {.size: sizeof(cint).} = set[TypeFlag]

type
  TypeFundamentalFlag* {.size: sizeof(cint), pure.} = enum
    classed = 1
    instantiatable = 2
    derivable = 3
    deepDerivable = 4

  TypeFundamentalFlags* {.size: sizeof(cint).} = set[TypeFundamentalFlag]

type
  TypeFundamentalInfo00* {.pure.} = object
    typeFlags*: TypeFundamentalFlags
  TypeFundamentalInfo* = ref object
    impl*: ptr TypeFundamentalInfo00

type
  TypeInterfaceCheckFunc* = proc (checkData: pointer; gIface: ptr TypeInterface00) {.cdecl.}

type
  TypeModule* = ref object of Object
  TypeModule00* = object of Object00
    useCount*: uint32
    typeInfos*: ptr pointer
    interfaceInfos*: ptr pointer
    name*: cstring

proc g_type_module_add_interface*(self: ptr TypeModule00; instanceType: GType; interfaceType: GType; 
    interfaceInfo: ptr InterfaceInfo00) {.
    importc: "g_type_module_add_interface", libprag.}

proc addInterface*(self: TypeModule; instanceType: GType; interfaceType: GType; 
    interfaceInfo: InterfaceInfo) =
  g_type_module_add_interface(cast[ptr TypeModule00](self.impl), instanceType, interfaceType, cast[ptr InterfaceInfo00](interfaceInfo.impl))

proc g_type_module_register_enum*(self: ptr TypeModule00; name: cstring; constStaticValues: ptr EnumValue00): GType {.
    importc: "g_type_module_register_enum", libprag.}

proc registerEnum*(self: TypeModule; name: string; constStaticValues: EnumValue): GType =
  g_type_module_register_enum(cast[ptr TypeModule00](self.impl), cstring(name), cast[ptr EnumValue00](constStaticValues.impl))

proc g_type_module_register_flags*(self: ptr TypeModule00; name: cstring; constStaticValues: ptr FlagsValue00): GType {.
    importc: "g_type_module_register_flags", libprag.}

proc registerFlags*(self: TypeModule; name: string; constStaticValues: FlagsValue): GType =
  g_type_module_register_flags(cast[ptr TypeModule00](self.impl), cstring(name), cast[ptr FlagsValue00](constStaticValues.impl))

proc g_type_module_set_name*(self: ptr TypeModule00; name: cstring) {.
    importc: "g_type_module_set_name", libprag.}

proc setName*(self: TypeModule; name: string) =
  g_type_module_set_name(cast[ptr TypeModule00](self.impl), cstring(name))

proc `name=`*(self: TypeModule; name: string) =
  g_type_module_set_name(cast[ptr TypeModule00](self.impl), cstring(name))

proc g_type_module_unuse*(self: ptr TypeModule00) {.
    importc: "g_type_module_unuse", libprag.}

proc unuse*(self: TypeModule) =
  g_type_module_unuse(cast[ptr TypeModule00](self.impl))

proc g_type_module_use*(self: ptr TypeModule00): gboolean {.
    importc: "g_type_module_use", libprag.}

proc use*(self: TypeModule): bool =
  toBool(g_type_module_use(cast[ptr TypeModule00](self.impl)))

type
  TypePluginCompleteInterfaceInfo* = proc (plugin: ptr TypePlugin00; instanceType: GType; interfaceType: GType; 
    info: ptr InterfaceInfo00) {.cdecl.}

type
  TypePluginUnuse* = proc (plugin: ptr TypePlugin00) {.cdecl.}

type
  TypePluginUse* = proc (plugin: ptr TypePlugin00) {.cdecl.}

type
  TypeQuery00* {.pure.} = object
    `type`*: GType
    typeName*: cstring
    classSize*: uint32
    instanceSize*: uint32
  TypeQuery* = ref object
    impl*: ptr TypeQuery00

const VALUE_COLLECT_FORMAT_MAX_LENGTH* = 8'i32

const VALUE_NOCOPY_CONTENTS* = 134217728'i32

type
  WeakNotify* = proc (data: pointer; whereTheObjectWas: ptr Object00) {.cdecl.}

type
  WeakRef00* {.pure.} = object
  WeakRef* = ref object
    impl*: ptr WeakRef00

type
  ValueDataUnion00* = object {.union.}
    vInt*: int32
    vUint*: uint32
    vLong*: int64
    vUlong*: uint64
    vInt64*: int64
    vUint64*: uint64
    vFloat*: cfloat
    vDouble*: cdouble
    vPointer*: pointer
  ValueDataUnion* = ref object
    impl*: ptr ValueDataUnion00

type
  Value00* {.pure.} = object
    gType*: GType
    data*: array[2, ValueDataUnion00]
  Value* = ref object
    impl*: ptr Value00

proc g_value_copy*(self: ptr Value00; destValue: ptr Value00) {.
    importc: "g_value_copy", libprag.}

proc g_value_dup_object*(self: ptr Value00): ptr Object00 {.
    importc: "g_value_dup_object", libprag.}

proc g_value_dup_string*(self: ptr Value00): cstring {.
    importc: "g_value_dup_string", libprag.}

proc g_value_dup_variant*(self: ptr Value00): ptr glib.Variant00 {.
    importc: "g_value_dup_variant", libprag.}

proc g_value_fits_pointer*(self: ptr Value00): gboolean {.
    importc: "g_value_fits_pointer", libprag.}

proc g_value_get_boolean*(self: ptr Value00): gboolean {.
    importc: "g_value_get_boolean", libprag.}

proc g_value_get_boxed*(self: ptr Value00): pointer {.
    importc: "g_value_get_boxed", libprag.}

proc g_value_get_char*(self: ptr Value00): int8 {.
    importc: "g_value_get_char", libprag.}

proc g_value_get_double*(self: ptr Value00): cdouble {.
    importc: "g_value_get_double", libprag.}

proc g_value_get_enum*(self: ptr Value00): int32 {.
    importc: "g_value_get_enum", libprag.}

proc g_value_get_flags*(self: ptr Value00): uint32 {.
    importc: "g_value_get_flags", libprag.}

proc g_value_get_float*(self: ptr Value00): cfloat {.
    importc: "g_value_get_float", libprag.}

proc g_value_get_gtype*(self: ptr Value00): GType {.
    importc: "g_value_get_gtype", libprag.}

proc g_value_get_int*(self: ptr Value00): int32 {.
    importc: "g_value_get_int", libprag.}

proc g_value_get_int64*(self: ptr Value00): int64 {.
    importc: "g_value_get_int64", libprag.}

proc g_value_get_long*(self: ptr Value00): int64 {.
    importc: "g_value_get_long", libprag.}

proc g_value_get_object*(self: ptr Value00): ptr Object00 {.
    importc: "g_value_get_object", libprag.}

proc g_value_get_param*(self: ptr Value00): ptr ParamSpec00 {.
    importc: "g_value_get_param", libprag.}

proc g_value_get_pointer*(self: ptr Value00): pointer {.
    importc: "g_value_get_pointer", libprag.}

proc g_value_get_schar*(self: ptr Value00): int8 {.
    importc: "g_value_get_schar", libprag.}

proc g_value_get_string*(self: ptr Value00): cstring {.
    importc: "g_value_get_string", libprag.}

proc g_value_get_uchar*(self: ptr Value00): uint8 {.
    importc: "g_value_get_uchar", libprag.}

proc g_value_get_uint*(self: ptr Value00): uint32 {.
    importc: "g_value_get_uint", libprag.}

proc g_value_get_uint64*(self: ptr Value00): uint64 {.
    importc: "g_value_get_uint64", libprag.}

proc g_value_get_ulong*(self: ptr Value00): uint64 {.
    importc: "g_value_get_ulong", libprag.}

proc g_value_get_variant*(self: ptr Value00): ptr glib.Variant00 {.
    importc: "g_value_get_variant", libprag.}

proc g_value_init*(self: ptr Value00; gType: GType): ptr Value00 {.
    importc: "g_value_init", libprag.}

proc g_value_init_from_instance*(self: ptr Value00; instance: ptr TypeInstance00) {.
    importc: "g_value_init_from_instance", libprag.}

proc g_value_peek_pointer*(self: ptr Value00): pointer {.
    importc: "g_value_peek_pointer", libprag.}

proc g_value_reset*(self: ptr Value00): ptr Value00 {.
    importc: "g_value_reset", libprag.}

proc g_value_set_boolean*(self: ptr Value00; vBoolean: gboolean) {.
    importc: "g_value_set_boolean", libprag.}

proc g_value_set_boxed*(self: ptr Value00; vBoxed: pointer) {.
    importc: "g_value_set_boxed", libprag.}

proc g_value_set_boxed_take_ownership*(self: ptr Value00; vBoxed: pointer) {.
    importc: "g_value_set_boxed_take_ownership", libprag.}

proc g_value_set_char*(self: ptr Value00; vChar: int8) {.
    importc: "g_value_set_char", libprag.}

proc g_value_set_double*(self: ptr Value00; vDouble: cdouble) {.
    importc: "g_value_set_double", libprag.}

proc g_value_set_enum*(self: ptr Value00; vEnum: int32) {.
    importc: "g_value_set_enum", libprag.}

proc g_value_set_flags*(self: ptr Value00; vFlags: uint32) {.
    importc: "g_value_set_flags", libprag.}

proc g_value_set_float*(self: ptr Value00; vFloat: cfloat) {.
    importc: "g_value_set_float", libprag.}

proc g_value_set_gtype*(self: ptr Value00; vGtype: GType) {.
    importc: "g_value_set_gtype", libprag.}

proc g_value_set_instance*(self: ptr Value00; instance: pointer) {.
    importc: "g_value_set_instance", libprag.}

proc g_value_set_int*(self: ptr Value00; vInt: int32) {.
    importc: "g_value_set_int", libprag.}

proc g_value_set_int64*(self: ptr Value00; vInt64: int64) {.
    importc: "g_value_set_int64", libprag.}

proc g_value_set_long*(self: ptr Value00; vLong: int64) {.
    importc: "g_value_set_long", libprag.}

proc g_value_set_object*(self: ptr Value00; vObject: ptr Object00) {.
    importc: "g_value_set_object", libprag.}

proc g_value_set_param*(self: ptr Value00; param: ptr ParamSpec00) {.
    importc: "g_value_set_param", libprag.}

proc g_value_set_pointer*(self: ptr Value00; vPointer: pointer) {.
    importc: "g_value_set_pointer", libprag.}

proc g_value_set_schar*(self: ptr Value00; vChar: int8) {.
    importc: "g_value_set_schar", libprag.}

proc g_value_set_static_boxed*(self: ptr Value00; vBoxed: pointer) {.
    importc: "g_value_set_static_boxed", libprag.}

proc g_value_set_static_string*(self: ptr Value00; vString: cstring) {.
    importc: "g_value_set_static_string", libprag.}

proc g_value_set_string*(self: ptr Value00; vString: cstring) {.
    importc: "g_value_set_string", libprag.}

proc g_value_set_string_take_ownership*(self: ptr Value00; vString: cstring) {.
    importc: "g_value_set_string_take_ownership", libprag.}

proc g_value_set_uchar*(self: ptr Value00; vUchar: uint8) {.
    importc: "g_value_set_uchar", libprag.}

proc g_value_set_uint*(self: ptr Value00; vUint: uint32) {.
    importc: "g_value_set_uint", libprag.}

proc g_value_set_uint64*(self: ptr Value00; vUint64: uint64) {.
    importc: "g_value_set_uint64", libprag.}

proc g_value_set_ulong*(self: ptr Value00; vUlong: uint64) {.
    importc: "g_value_set_ulong", libprag.}

proc g_value_set_variant*(self: ptr Value00; variant: ptr glib.Variant00) {.
    importc: "g_value_set_variant", libprag.}

proc g_value_take_boxed*(self: ptr Value00; vBoxed: pointer) {.
    importc: "g_value_take_boxed", libprag.}

proc g_value_take_string*(self: ptr Value00; vString: cstring) {.
    importc: "g_value_take_string", libprag.}

proc g_value_take_variant*(self: ptr Value00; variant: ptr glib.Variant00) {.
    importc: "g_value_take_variant", libprag.}

proc g_value_transform*(self: ptr Value00; destValue: ptr Value00): gboolean {.
    importc: "g_value_transform", libprag.}

proc g_value_unset*(self: ptr Value00) {.
    importc: "g_value_unset", libprag.}

proc g_value_type_compatible*(srcType: GType; destType: GType): gboolean {.
    importc: "g_value_type_compatible", libprag.}

proc g_value_type_transformable*(srcType: GType; destType: GType): gboolean {.
    importc: "g_value_type_transformable", libprag.}

type
  Parameter00* {.pure.} = object
    name*: cstring
    value*: Value00
  Parameter* = ref object
    impl*: ptr Parameter00
type

  ValueTransform* = proc (srcValue: ptr Value00; destValue: ptr Value00) {.cdecl.}

  ValueArray00* {.pure.} = object
    nValues*: uint32
    values*: ptr Value00
    nPrealloced*: uint32
  ValueArray* = ref object
    impl*: ptr ValueArray00

proc g_object_newv*(objectType: GType; nParameters: uint32; parameters: Parameter00Array): ptr Object00 {.
    importc: "g_object_newv", libprag.}

proc newObject*(objectType: GType; nParameters: int; parameters: Parameter00Array): Object =
  new(result, finalizeGObject)
  result.impl = g_object_newv(objectType, uint32(nParameters), parameters)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc initObject*[T](result: var T; objectType: GType; nParameters: int; parameters: Parameter00Array) =
  assert(result is Object)
  new(result, finalizeGObject)
  result.impl = g_object_newv(objectType, uint32(nParameters), parameters)
  GC_ref(result)
  discard g_object_ref_sink(result.impl)
  g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
  g_object_unref(result.impl)
  assert(g_object_get_qdata(result.impl, Quark) == nil)
  g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_object_get_property*(self: ptr Object00; propertyName: cstring; value: ptr Value00) {.
    importc: "g_object_get_property", libprag.}

proc getProperty*(self: Object; propertyName: string; value: Value) =
  g_object_get_property(cast[ptr Object00](self.impl), cstring(propertyName), cast[ptr Value00](value.impl))

proc property*(self: Object; propertyName: string; value: Value) =
  g_object_get_property(cast[ptr Object00](self.impl), cstring(propertyName), cast[ptr Value00](value.impl))

proc g_object_set_property*(self: ptr Object00; propertyName: cstring; value: ptr Value00) {.
    importc: "g_object_set_property", libprag.}

proc setProperty*(self: Object; propertyName: string; value: Value) =
  g_object_set_property(cast[ptr Object00](self.impl), cstring(propertyName), cast[ptr Value00](value.impl))

proc g_param_spec_get_default_value*(self: ptr ParamSpec00): ptr Value00 {.
    importc: "g_param_spec_get_default_value", libprag.}

proc g_boxed_copy*(boxedType: GType; srcBoxed: pointer): pointer {.
    importc: "g_boxed_copy", libprag.}

proc boxedCopy*(boxedType: GType; srcBoxed: pointer): pointer {.
    importc: "g_boxed_copy", libprag.}

type
  TypeValueTable00* {.pure.} = object
    valueInit*: proc(value: ptr Value00) {.cdecl.}
    valueFree*: proc(value: ptr Value00) {.cdecl.}
    valueCopy*: proc(srcValue: ptr Value00; destValue: ptr Value00) {.cdecl.}
    valuePeekPointer*: proc(value: ptr Value00): pointer {.cdecl.}
    collectFormat*: cstring
    collectValue*: proc(value: ptr Value00; nCollectValues: uint32; collectValues: ptr TypeCValue00; 
    collectFlags: uint32): cstring {.cdecl.}
    lcopyFormat*: cstring
    lcopyValue*: proc(value: ptr Value00; nCollectValues: uint32; collectValues: ptr TypeCValue00; 
    collectFlags: uint32): cstring {.cdecl.}
  TypeValueTable* = ref object
    impl*: ptr TypeValueTable00

type
  TypeInfo00* {.pure.} = object
    classSize*: uint16
    baseInit*: BaseInitFunc
    baseFinalize*: BaseFinalizeFunc
    classInit*: ClassInitFunc
    classFinalize*: ClassFinalizeFunc
    classData*: pointer
    instanceSize*: uint16
    nPreallocs*: uint16
    instanceInit*: InstanceInitFunc
    valueTable*: ptr TypeValueTable00
  TypeInfo* = ref object
    impl*: ptr TypeInfo00

type
  SignalEmissionHook* = proc (ihint: ptr SignalInvocationHint00; nParamValues: uint32; 
    paramValues: Value00Array; data: pointer): gboolean {.cdecl.}

type
  SignalAccumulator* = proc (ihint: ptr SignalInvocationHint00; returnAccu: ptr Value00; 
    handlerReturn: ptr Value00; data: pointer): gboolean {.cdecl.}

type
  ParamSpecTypeInfo00* {.pure.} = object
    instanceSize*: uint16
    nPreallocs*: uint16
    instanceInit*: proc(pspec: ptr ParamSpec00) {.cdecl.}
    valueType*: GType
    finalize*: proc(pspec: ptr ParamSpec00) {.cdecl.}
    valueSetDefault*: proc(pspec: ptr ParamSpec00; value: ptr Value00) {.cdecl.}
    valueValidate*: proc(pspec: ptr ParamSpec00; value: ptr Value00): gboolean {.cdecl.}
    valuesCmp*: proc(pspec: ptr ParamSpec00; value1: ptr Value00; value2: ptr Value00): int32 {.cdecl.}
  ParamSpecTypeInfo* = ref object
    impl*: ptr ParamSpecTypeInfo00

type
  ParamSpecClass00* {.pure.} = object
    gTypeClass*: TypeClass00
    valueType*: GType
    finalize*: proc(pspec: ptr ParamSpec00) {.cdecl.}
    valueSetDefault*: proc(pspec: ptr ParamSpec00; value: ptr Value00) {.cdecl.}
    valueValidate*: proc(pspec: ptr ParamSpec00; value: ptr Value00): gboolean {.cdecl.}
    valuesCmp*: proc(pspec: ptr ParamSpec00; value1: ptr Value00; value2: ptr Value00): int32 {.cdecl.}
    dummy*: array[4, pointer]
  ParamSpecClass* = ref object
    impl*: ptr ParamSpecClass00

type
  ObjectSetPropertyFunc* = proc (`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}

type
  ObjectGetPropertyFunc* = proc (`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}

type
  ObjectConstructParam00* {.pure.} = object
    pspec*: ptr ParamSpec00
    value*: ptr Value00
  ObjectConstructParam* = ref object
    impl*: ptr ObjectConstructParam00

type
  ObjectClass00* {.pure.} = object
    gTypeClass*: TypeClass00
    constructProperties*: ptr pointer
    constructor*: pointer
    setProperty*: proc(`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}
    getProperty*: proc(`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}
    dispose*: proc(`object`: ptr Object00) {.cdecl.}
    finalize*: proc(`object`: ptr Object00) {.cdecl.}
    dispatchPropertiesChanged*: proc(`object`: ptr Object00; nPspecs: uint32; pspecs: ptr ParamSpec00) {.cdecl.}
    notify*: proc(`object`: ptr Object00; pspec: ptr ParamSpec00) {.cdecl.}
    constructed*: proc(`object`: ptr Object00) {.cdecl.}
    flags*: uint64
    pdummy*: array[6, pointer]
  ObjectClass* = ref object
    impl*: ptr ObjectClass00

type
  InitiallyUnownedClass00* {.pure.} = object
    gTypeClass*: TypeClass00
    constructProperties*: ptr pointer
    constructor*: pointer
    setProperty*: proc(`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}
    getProperty*: proc(`object`: ptr Object00; propertyId: uint32; value: ptr Value00; 
    pspec: ptr ParamSpec00) {.cdecl.}
    dispose*: proc(`object`: ptr Object00) {.cdecl.}
    finalize*: proc(`object`: ptr Object00) {.cdecl.}
    dispatchPropertiesChanged*: proc(`object`: ptr Object00; nPspecs: uint32; pspecs: ptr ParamSpec00) {.cdecl.}
    notify*: proc(`object`: ptr Object00; pspec: ptr ParamSpec00) {.cdecl.}
    constructed*: proc(`object`: ptr Object00) {.cdecl.}
    flags*: uint64
    pdummy*: array[6, pointer]
  InitiallyUnownedClass* = ref object
    impl*: ptr InitiallyUnownedClass00

type
  BindingTransformFunc* = proc (binding: ptr Binding00; fromValue: ptr Value00; toValue: ptr Value00; 
    userData: pointer): gboolean {.cdecl.}
type

  TypePluginCompleteTypeInfo* = proc (plugin: ptr TypePlugin00; gType: GType; info: ptr TypeInfo00; 
    valueTable: ptr TypeValueTable00) {.cdecl.}

  TypePluginClass00* {.pure.} = object
    baseIface*: TypeInterface00
    usePlugin*: TypePluginUse
    unusePlugin*: TypePluginUnuse
    completeTypeInfo*: TypePluginCompleteTypeInfo
    completeInterfaceInfo*: TypePluginCompleteInterfaceInfo
  TypePluginClass* = ref object
    impl*: ptr TypePluginClass00

proc g_type_module_register_type*(self: ptr TypeModule00; parentType: GType; typeName: cstring; 
    typeInfo: ptr TypeInfo00; flags: TypeFlags): GType {.
    importc: "g_type_module_register_type", libprag.}

proc registerType*(self: TypeModule; parentType: GType; typeName: string; 
    typeInfo: TypeInfo; flags: TypeFlags): GType =
  g_type_module_register_type(cast[ptr TypeModule00](self.impl), parentType, cstring(typeName), cast[ptr TypeInfo00](typeInfo.impl), flags)

proc g_boxed_free*(boxedType: GType; boxed: pointer) {.
    importc: "g_boxed_free", libprag.}

proc boxedFree*(boxedType: GType; boxed: pointer) {.
    importc: "g_boxed_free", libprag.}

type
  TypeModuleClass00* {.pure.} = object
    parentClass*: ObjectClass00
    load*: proc(module: ptr TypeModule00): gboolean {.cdecl.}
    unload*: proc(module: ptr TypeModule00) {.cdecl.}
    reserved1*: proc() {.cdecl.}
    reserved2*: proc() {.cdecl.}
    reserved3*: proc() {.cdecl.}
    reserved4*: proc() {.cdecl.}
  TypeModuleClass* = ref object
    impl*: ptr TypeModuleClass00
type

  ClosureNotify* = proc (data: pointer; closure: ptr Closure00) {.cdecl.}

  ClosureNotifyData00* {.pure.} = object
    data*: pointer
    notify*: ClosureNotify
  ClosureNotifyData* = ref object
    impl*: ptr ClosureNotifyData00

  Closure00* {.pure.} = object
    refCount*: uint32
    metaMarshalNouse*: uint32
    nGuards*: uint32
    nFnotifiers*: uint32
    nInotifiers*: uint32
    inInotify*: uint32
    floating*: uint32
    derivativeFlag*: uint32
    inMarshal*: uint32
    isInvalid*: uint32
    marshal*: proc(closure: ptr Closure00; returnValue: ptr Value00; 
    nParamValues: uint32; paramValues: ptr Value00; invocationHint: pointer; marshalData: pointer) {.cdecl.}
    data*: pointer
    notifiers*: ptr ClosureNotifyData00
  Closure* = ref object
    impl*: ptr Closure00

proc g_closure_new_object*(sizeofClosure: uint32; `object`: ptr Object00): ptr Closure00 {.
    importc: "g_closure_new_object", libprag.}

proc newClosureObject*(sizeofClosure: int; `object`: Object): Closure =
  new(result)
  result.impl = g_closure_new_object(uint32(sizeofClosure), cast[ptr Object00](`object`.impl))

proc initClosureObject*[T](result: var T; sizeofClosure: int; `object`: Object) =
  assert(result is Closure)
  new(result)
  result.impl = g_closure_new_object(uint32(sizeofClosure), cast[ptr Object00](`object`.impl))

proc g_closure_new_simple*(sizeofClosure: uint32; data: pointer): ptr Closure00 {.
    importc: "g_closure_new_simple", libprag.}

proc newClosureSimple*(sizeofClosure: int; data: pointer): Closure =
  new(result)
  result.impl = g_closure_new_simple(uint32(sizeofClosure), data)

proc initClosureSimple*[T](result: var T; sizeofClosure: int; data: pointer) =
  assert(result is Closure)
  new(result)
  result.impl = g_closure_new_simple(uint32(sizeofClosure), data)

proc g_closure_invalidate*(self: ptr Closure00) {.
    importc: "g_closure_invalidate", libprag.}

proc invalidate*(self: Closure) =
  g_closure_invalidate(cast[ptr Closure00](self.impl))

proc g_closure_invoke*(self: ptr Closure00; returnValue: var Value00; nParamValues: uint32; 
    paramValues: Value00Array; invocationHint: pointer) {.
    importc: "g_closure_invoke", libprag.}

proc invoke*(self: ptr Closure00; returnValue: var Value00; nParamValues: uint32; 
    paramValues: Value00Array; invocationHint: pointer) {.
    importc: "g_closure_invoke", libprag.}

proc g_closure_ref*(self: ptr Closure00): ptr Closure00 {.
    importc: "g_closure_ref", libprag.}

proc `ref`*(self: Closure): Closure =
  new(result)
  result.impl = g_closure_ref(cast[ptr Closure00](self.impl))

proc g_closure_sink*(self: ptr Closure00) {.
    importc: "g_closure_sink", libprag.}

proc sink*(self: Closure) =
  g_closure_sink(cast[ptr Closure00](self.impl))

proc g_closure_unref*(self: ptr Closure00) {.
    importc: "g_closure_unref", libprag.}

proc unref*(self: Closure) =
  g_closure_unref(cast[ptr Closure00](self.impl))

proc g_object_bind_property_with_closures*(self: ptr Object00; sourceProperty: cstring; target: ptr Object00; 
    targetProperty: cstring; flags: BindingFlags; transformTo: ptr Closure00; transformFrom: ptr Closure00): ptr Binding00 {.
    importc: "g_object_bind_property_with_closures", libprag.}

proc bindPropertyFull*(self: Object; sourceProperty: string; target: Object; 
    targetProperty: string; flags: BindingFlags; transformTo: Closure; transformFrom: Closure): Binding =
  let gobj = g_object_bind_property_with_closures(cast[ptr Object00](self.impl), cstring(sourceProperty), cast[ptr Object00](target.impl), cstring(targetProperty), flags, cast[ptr Closure00](transformTo.impl), cast[ptr Closure00](transformFrom.impl))
  if g_object_get_qdata(gobj, Quark) != nil:
    result = cast[Binding](g_object_get_qdata(gobj, Quark))
    assert(result.impl == gobj)
  else:
    new(result, finalizeGObject)
    result.impl = gobj
    GC_ref(result)
    discard g_object_ref_sink(result.impl)
    g_object_add_toggle_ref(result.impl, toggleNotify, addr(result[]))
    g_object_unref(result.impl)
    assert(g_object_get_qdata(result.impl, Quark) == nil)
    g_object_set_qdata(result.impl, Quark, addr(result[]))

proc g_object_watch_closure*(self: ptr Object00; closure: ptr Closure00) {.
    importc: "g_object_watch_closure", libprag.}

proc watchClosure*(self: Object; closure: Closure) =
  g_object_watch_closure(cast[ptr Object00](self.impl), cast[ptr Closure00](closure.impl))
proc g_signal_connect_data*(instance: pointer; detailedSignal: cstring; cHandler: GCallback;
    data: pointer; destroyData: ClosureNotify; connectFlags: ConnectFlags): culong {.
    importc: "g_signal_connect_data", libprag.}

type
  ClosureMarshal* = proc (closure: ptr Closure00; returnValue: ptr Value00; 
    nParamValues: uint32; paramValues: Value00Array; invocationHint: pointer; marshalData: pointer) {.cdecl.}

type
  CClosure00* {.pure.} = object
    closure*: Closure00
    callback*: pointer
  CClosure* = ref object
    impl*: ptr CClosure00

proc g_enum_complete_type_info*(gEnumType: GType; info: var TypeInfo00; constValues: ptr EnumValue00) {.
    importc: "g_enum_complete_type_info", libprag.}

proc enumCompleteTypeInfo*(gEnumType: GType; info: var TypeInfo00; constValues: ptr EnumValue00) {.
    importc: "g_enum_complete_type_info", libprag.}

proc g_enum_get_value*(enumClass: ptr EnumClass00; value: int32): ptr EnumValue00 {.
    importc: "g_enum_get_value", libprag.}

proc enumGetValue*(enumClass: EnumClass; value: int): EnumValue =
  new(result)
  result.impl = g_enum_get_value(cast[ptr EnumClass00](enumClass.impl), int32(value))

proc g_enum_get_value_by_name*(enumClass: ptr EnumClass00; name: cstring): ptr EnumValue00 {.
    importc: "g_enum_get_value_by_name", libprag.}

proc enumGetValueByName*(enumClass: EnumClass; name: string): EnumValue =
  new(result)
  result.impl = g_enum_get_value_by_name(cast[ptr EnumClass00](enumClass.impl), cstring(name))

proc g_enum_get_value_by_nick*(enumClass: ptr EnumClass00; nick: cstring): ptr EnumValue00 {.
    importc: "g_enum_get_value_by_nick", libprag.}

proc enumGetValueByNick*(enumClass: EnumClass; nick: string): EnumValue =
  new(result)
  result.impl = g_enum_get_value_by_nick(cast[ptr EnumClass00](enumClass.impl), cstring(nick))

proc g_enum_register_static*(name: cstring; constStaticValues: ptr EnumValue00): GType {.
    importc: "g_enum_register_static", libprag.}

proc enumRegisterStatic*(name: string; constStaticValues: EnumValue): GType =
  g_enum_register_static(cstring(name), cast[ptr EnumValue00](constStaticValues.impl))

proc g_flags_complete_type_info*(gFlagsType: GType; info: var TypeInfo00; constValues: ptr FlagsValue00) {.
    importc: "g_flags_complete_type_info", libprag.}

proc flagsCompleteTypeInfo*(gFlagsType: GType; info: var TypeInfo00; constValues: ptr FlagsValue00) {.
    importc: "g_flags_complete_type_info", libprag.}

proc g_flags_get_first_value*(flagsClass: ptr FlagsClass00; value: uint32): ptr FlagsValue00 {.
    importc: "g_flags_get_first_value", libprag.}

proc flagsGetFirstValue*(flagsClass: FlagsClass; value: int): FlagsValue =
  new(result)
  result.impl = g_flags_get_first_value(cast[ptr FlagsClass00](flagsClass.impl), uint32(value))

proc g_flags_get_value_by_name*(flagsClass: ptr FlagsClass00; name: cstring): ptr FlagsValue00 {.
    importc: "g_flags_get_value_by_name", libprag.}

proc flagsGetValueByName*(flagsClass: FlagsClass; name: string): FlagsValue =
  new(result)
  result.impl = g_flags_get_value_by_name(cast[ptr FlagsClass00](flagsClass.impl), cstring(name))

proc g_flags_get_value_by_nick*(flagsClass: ptr FlagsClass00; nick: cstring): ptr FlagsValue00 {.
    importc: "g_flags_get_value_by_nick", libprag.}

proc flagsGetValueByNick*(flagsClass: FlagsClass; nick: string): FlagsValue =
  new(result)
  result.impl = g_flags_get_value_by_nick(cast[ptr FlagsClass00](flagsClass.impl), cstring(nick))

proc g_flags_register_static*(name: cstring; constStaticValues: ptr FlagsValue00): GType {.
    importc: "g_flags_register_static", libprag.}

proc flagsRegisterStatic*(name: string; constStaticValues: FlagsValue): GType =
  g_flags_register_static(cstring(name), cast[ptr FlagsValue00](constStaticValues.impl))

proc g_gtype_get_type*(): GType {.
    importc: "g_gtype_get_type", libprag.}

proc gtypeGetType*(): GType {.
    importc: "g_gtype_get_type", libprag.}

proc g_param_spec_boolean*(name: cstring; nick: cstring; blurb: cstring; defaultValue: gboolean; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_boolean", libprag.}

proc g_param_spec_boxed*(name: cstring; nick: cstring; blurb: cstring; boxedType: GType; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_boxed", libprag.}

proc g_param_spec_char*(name: cstring; nick: cstring; blurb: cstring; minimum: int8; 
    maximum: int8; defaultValue: int8; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_char", libprag.}

proc g_param_spec_double*(name: cstring; nick: cstring; blurb: cstring; minimum: cdouble; 
    maximum: cdouble; defaultValue: cdouble; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_double", libprag.}

proc g_param_spec_enum*(name: cstring; nick: cstring; blurb: cstring; enumType: GType; 
    defaultValue: int32; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_enum", libprag.}

proc g_param_spec_flags*(name: cstring; nick: cstring; blurb: cstring; flagsType: GType; 
    defaultValue: uint32; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_flags", libprag.}

proc g_param_spec_float*(name: cstring; nick: cstring; blurb: cstring; minimum: cfloat; 
    maximum: cfloat; defaultValue: cfloat; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_float", libprag.}

proc g_param_spec_gtype*(name: cstring; nick: cstring; blurb: cstring; isAType: GType; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_gtype", libprag.}

proc g_param_spec_int*(name: cstring; nick: cstring; blurb: cstring; minimum: int32; 
    maximum: int32; defaultValue: int32; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_int", libprag.}

proc g_param_spec_int64*(name: cstring; nick: cstring; blurb: cstring; minimum: int64; 
    maximum: int64; defaultValue: int64; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_int64", libprag.}

proc g_param_spec_long*(name: cstring; nick: cstring; blurb: cstring; minimum: int64; 
    maximum: int64; defaultValue: int64; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_long", libprag.}

proc g_param_spec_object*(name: cstring; nick: cstring; blurb: cstring; objectType: GType; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_object", libprag.}

proc g_param_spec_param*(name: cstring; nick: cstring; blurb: cstring; paramType: GType; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_param", libprag.}

proc g_param_spec_pointer*(name: cstring; nick: cstring; blurb: cstring; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_pointer", libprag.}

proc g_param_spec_string*(name: cstring; nick: cstring; blurb: cstring; defaultValue: cstring; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_string", libprag.}

proc g_param_spec_uchar*(name: cstring; nick: cstring; blurb: cstring; minimum: uint8; 
    maximum: uint8; defaultValue: uint8; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_uchar", libprag.}

proc g_param_spec_uint*(name: cstring; nick: cstring; blurb: cstring; minimum: uint32; 
    maximum: uint32; defaultValue: uint32; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_uint", libprag.}

proc g_param_spec_uint64*(name: cstring; nick: cstring; blurb: cstring; minimum: uint64; 
    maximum: uint64; defaultValue: uint64; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_uint64", libprag.}

proc g_param_spec_ulong*(name: cstring; nick: cstring; blurb: cstring; minimum: uint64; 
    maximum: uint64; defaultValue: uint64; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_ulong", libprag.}

proc g_param_spec_unichar*(name: cstring; nick: cstring; blurb: cstring; defaultValue: gunichar; 
    flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_unichar", libprag.}

proc g_param_spec_variant*(name: cstring; nick: cstring; blurb: cstring; `type`: ptr glib.VariantType00; 
    defaultValue: ptr glib.Variant00; flags: ParamFlags): ptr ParamSpec00 {.
    importc: "g_param_spec_variant", libprag.}

proc g_param_type_register_static*(name: cstring; pspecInfo: ptr ParamSpecTypeInfo00): GType {.
    importc: "g_param_type_register_static", libprag.}

proc paramTypeRegisterStatic*(name: string; pspecInfo: ParamSpecTypeInfo): GType =
  g_param_type_register_static(cstring(name), cast[ptr ParamSpecTypeInfo00](pspecInfo.impl))

proc g_param_value_convert*(pspec: ptr ParamSpec00; srcValue: ptr Value00; destValue: ptr Value00; 
    strictValidation: gboolean): gboolean {.
    importc: "g_param_value_convert", libprag.}

proc paramValueConvert*(pspec: ParamSpec; srcValue: Value; destValue: Value; 
    strictValidation: bool): bool =
  toBool(g_param_value_convert(cast[ptr ParamSpec00](pspec.impl), cast[ptr Value00](srcValue.impl), cast[ptr Value00](destValue.impl), gboolean(strictValidation)))

proc g_param_value_defaults*(pspec: ptr ParamSpec00; value: ptr Value00): gboolean {.
    importc: "g_param_value_defaults", libprag.}

proc paramValueDefaults*(pspec: ParamSpec; value: Value): bool =
  toBool(g_param_value_defaults(cast[ptr ParamSpec00](pspec.impl), cast[ptr Value00](value.impl)))

proc g_param_value_set_default*(pspec: ptr ParamSpec00; value: ptr Value00) {.
    importc: "g_param_value_set_default", libprag.}

proc paramValueSetDefault*(pspec: ParamSpec; value: Value) =
  g_param_value_set_default(cast[ptr ParamSpec00](pspec.impl), cast[ptr Value00](value.impl))

proc g_param_value_validate*(pspec: ptr ParamSpec00; value: ptr Value00): gboolean {.
    importc: "g_param_value_validate", libprag.}

proc paramValueValidate*(pspec: ParamSpec; value: Value): bool =
  toBool(g_param_value_validate(cast[ptr ParamSpec00](pspec.impl), cast[ptr Value00](value.impl)))

proc g_param_values_cmp*(pspec: ptr ParamSpec00; value1: ptr Value00; value2: ptr Value00): int32 {.
    importc: "g_param_values_cmp", libprag.}

proc paramValuesCmp*(pspec: ParamSpec; value1: Value; value2: Value): int =
  int(g_param_values_cmp(cast[ptr ParamSpec00](pspec.impl), cast[ptr Value00](value1.impl), cast[ptr Value00](value2.impl)))

proc g_pointer_type_register_static*(name: cstring): GType {.
    importc: "g_pointer_type_register_static", libprag.}

proc pointerTypeRegisterStatic*(name: cstring): GType {.
    importc: "g_pointer_type_register_static", libprag.}

proc g_signal_accumulator_first_wins*(ihint: ptr SignalInvocationHint00; returnAccu: ptr Value00; 
    handlerReturn: ptr Value00; dummy: pointer): gboolean {.
    importc: "g_signal_accumulator_first_wins", libprag.}

proc signalAccumulatorFirstWins*(ihint: SignalInvocationHint; returnAccu: Value; handlerReturn: Value; 
    dummy: pointer): bool =
  toBool(g_signal_accumulator_first_wins(cast[ptr SignalInvocationHint00](ihint.impl), cast[ptr Value00](returnAccu.impl), cast[ptr Value00](handlerReturn.impl), dummy))

proc g_signal_accumulator_true_handled*(ihint: ptr SignalInvocationHint00; returnAccu: ptr Value00; 
    handlerReturn: ptr Value00; dummy: pointer): gboolean {.
    importc: "g_signal_accumulator_true_handled", libprag.}

proc signalAccumulatorTrueHandled*(ihint: SignalInvocationHint; returnAccu: Value; handlerReturn: Value; 
    dummy: pointer): bool =
  toBool(g_signal_accumulator_true_handled(cast[ptr SignalInvocationHint00](ihint.impl), cast[ptr Value00](returnAccu.impl), cast[ptr Value00](handlerReturn.impl), dummy))

proc g_signal_add_emission_hook*(signalId: uint32; detail: uint32; hookFunc: SignalEmissionHook; 
    hookData: pointer; dataDestroy: DestroyNotify): uint64 {.
    importc: "g_signal_add_emission_hook", libprag.}

proc signalAddEmissionHook*(signalId: uint32; detail: uint32; hookFunc: SignalEmissionHook; 
    hookData: pointer; dataDestroy: DestroyNotify): uint64 {.
    importc: "g_signal_add_emission_hook", libprag.}

proc g_signal_chain_from_overridden*(instanceAndParams: Value00Array; returnValue: ptr Value00) {.
    importc: "g_signal_chain_from_overridden", libprag.}

proc signalChainFromOverridden*(instanceAndParams: Value00Array; returnValue: Value) =
  g_signal_chain_from_overridden(instanceAndParams, cast[ptr Value00](returnValue.impl))

proc g_signal_connect_closure*(instance: ptr Object00; detailedSignal: cstring; closure: ptr Closure00; 
    after: gboolean): uint64 {.
    importc: "g_signal_connect_closure", libprag.}

proc signalConnectClosure*(instance: Object; detailedSignal: string; closure: Closure; 
    after: bool): uint64 =
  g_signal_connect_closure(cast[ptr Object00](instance.impl), cstring(detailedSignal), cast[ptr Closure00](closure.impl), gboolean(after))

proc g_signal_connect_closure_by_id*(instance: ptr Object00; signalId: uint32; detail: uint32; 
    closure: ptr Closure00; after: gboolean): uint64 {.
    importc: "g_signal_connect_closure_by_id", libprag.}

proc signalConnectClosureById*(instance: Object; signalId: int; detail: int; closure: Closure; 
    after: bool): uint64 =
  g_signal_connect_closure_by_id(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), gboolean(after))

proc g_signal_emitv*(instanceAndParams: Value00Array; signalId: uint32; 
    detail: uint32; returnValue: Value00) {.
    importc: "g_signal_emitv", libprag.}

proc signalEmitv*(instanceAndParams: Value00Array; signalId: uint32; 
    detail: uint32; returnValue: Value00) {.
    importc: "g_signal_emitv", libprag.}

proc g_signal_get_invocation_hint*(instance: ptr Object00): ptr SignalInvocationHint00 {.
    importc: "g_signal_get_invocation_hint", libprag.}

proc signalGetInvocationHint*(instance: Object): SignalInvocationHint =
  new(result)
  result.impl = g_signal_get_invocation_hint(cast[ptr Object00](instance.impl))

proc g_signal_handler_block*(instance: ptr Object00; handlerId: uint64) {.
    importc: "g_signal_handler_block", libprag.}

proc signalHandlerBlock*(instance: Object; handlerId: uint64) =
  g_signal_handler_block(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handler_disconnect*(instance: ptr Object00; handlerId: uint64) {.
    importc: "g_signal_handler_disconnect", libprag.}

proc signalHandlerDisconnect*(instance: Object; handlerId: uint64) =
  g_signal_handler_disconnect(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handler_find*(instance: ptr Object00; mask: SignalMatchType; signalId: uint32; 
    detail: uint32; closure: ptr Closure00; `func`: pointer; data: pointer): uint64 {.
    importc: "g_signal_handler_find", libprag.}

proc signalHandlerFind*(instance: Object; mask: SignalMatchType; signalId: int; 
    detail: int; closure: Closure; `func`: pointer; data: pointer): uint64 =
  g_signal_handler_find(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), `func`, data)

proc g_signal_handler_is_connected*(instance: ptr Object00; handlerId: uint64): gboolean {.
    importc: "g_signal_handler_is_connected", libprag.}

proc signalHandlerIsConnected*(instance: Object; handlerId: uint64): bool =
  toBool(g_signal_handler_is_connected(cast[ptr Object00](instance.impl), handlerId))

proc g_signal_handler_unblock*(instance: ptr Object00; handlerId: uint64) {.
    importc: "g_signal_handler_unblock", libprag.}

proc signalHandlerUnblock*(instance: Object; handlerId: uint64) =
  g_signal_handler_unblock(cast[ptr Object00](instance.impl), handlerId)

proc g_signal_handlers_block_matched*(instance: ptr Object00; mask: SignalMatchType; signalId: uint32; 
    detail: uint32; closure: ptr Closure00; `func`: pointer; data: pointer): uint32 {.
    importc: "g_signal_handlers_block_matched", libprag.}

proc signalHandlersBlockMatched*(instance: Object; mask: SignalMatchType; signalId: int; 
    detail: int; closure: Closure; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_block_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_handlers_destroy*(instance: ptr Object00) {.
    importc: "g_signal_handlers_destroy", libprag.}

proc signalHandlersDestroy*(instance: Object) =
  g_signal_handlers_destroy(cast[ptr Object00](instance.impl))

proc g_signal_handlers_disconnect_matched*(instance: ptr Object00; mask: SignalMatchType; signalId: uint32; 
    detail: uint32; closure: ptr Closure00; `func`: pointer; data: pointer): uint32 {.
    importc: "g_signal_handlers_disconnect_matched", libprag.}

proc signalHandlersDisconnectMatched*(instance: Object; mask: SignalMatchType; signalId: int; 
    detail: int; closure: Closure; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_disconnect_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_handlers_unblock_matched*(instance: ptr Object00; mask: SignalMatchType; signalId: uint32; 
    detail: uint32; closure: ptr Closure00; `func`: pointer; data: pointer): uint32 {.
    importc: "g_signal_handlers_unblock_matched", libprag.}

proc signalHandlersUnblockMatched*(instance: Object; mask: SignalMatchType; signalId: int; 
    detail: int; closure: Closure; `func`: pointer; data: pointer): int =
  int(g_signal_handlers_unblock_matched(cast[ptr Object00](instance.impl), mask, uint32(signalId), uint32(detail), cast[ptr Closure00](closure.impl), `func`, data))

proc g_signal_has_handler_pending*(instance: ptr Object00; signalId: uint32; detail: uint32; 
    mayBeBlocked: gboolean): gboolean {.
    importc: "g_signal_has_handler_pending", libprag.}

proc signalHasHandlerPending*(instance: Object; signalId: int; detail: int; mayBeBlocked: bool): bool =
  toBool(g_signal_has_handler_pending(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail), gboolean(mayBeBlocked)))

proc g_signal_list_ids*(itype: GType; nIds: var uint32): uint32Array {.
    importc: "g_signal_list_ids", libprag.}

proc signalListIds*(itype: GType; nIds: var uint32): uint32Array {.
    importc: "g_signal_list_ids", libprag.}

proc g_signal_lookup*(name: cstring; itype: GType): uint32 {.
    importc: "g_signal_lookup", libprag.}

proc signalLookup*(name: cstring; itype: GType): uint32 {.
    importc: "g_signal_lookup", libprag.}

proc g_signal_name*(signalId: uint32): cstring {.
    importc: "g_signal_name", libprag.}

proc signalName*(signalId: int): string =
  let resul0 = g_signal_name(uint32(signalId))
  result = $resul0

proc g_signal_override_class_closure*(signalId: uint32; instanceType: GType; classClosure: ptr Closure00) {.
    importc: "g_signal_override_class_closure", libprag.}

proc signalOverrideClassClosure*(signalId: int; instanceType: GType; classClosure: Closure) =
  g_signal_override_class_closure(uint32(signalId), instanceType, cast[ptr Closure00](classClosure.impl))

proc g_signal_parse_name*(detailedSignal: cstring; itype: GType; signalIdP: var uint32; 
    detailP: var uint32; forceDetailQuark: gboolean): gboolean {.
    importc: "g_signal_parse_name", libprag.}

proc signalParseName*(detailedSignal: cstring; itype: GType; signalIdP: var uint32; 
    detailP: var uint32; forceDetailQuark: gboolean): gboolean {.
    importc: "g_signal_parse_name", libprag.}

proc g_signal_query*(signalId: uint32; query: var SignalQuery00) {.
    importc: "g_signal_query", libprag.}

proc signalQuery*(signalId: uint32; query: var SignalQuery00) {.
    importc: "g_signal_query", libprag.}

proc g_signal_remove_emission_hook*(signalId: uint32; hookId: uint64) {.
    importc: "g_signal_remove_emission_hook", libprag.}

proc signalRemoveEmissionHook*(signalId: uint32; hookId: uint64) {.
    importc: "g_signal_remove_emission_hook", libprag.}

proc g_signal_set_va_marshaller*(signalId: uint32; instanceType: GType; vaMarshaller: VaClosureMarshal) {.
    importc: "g_signal_set_va_marshaller", libprag.}

proc signalSetVaMarshaller*(signalId: uint32; instanceType: GType; vaMarshaller: VaClosureMarshal) {.
    importc: "g_signal_set_va_marshaller", libprag.}

proc g_signal_stop_emission*(instance: ptr Object00; signalId: uint32; detail: uint32) {.
    importc: "g_signal_stop_emission", libprag.}

proc signalStopEmission*(instance: Object; signalId: int; detail: int) =
  g_signal_stop_emission(cast[ptr Object00](instance.impl), uint32(signalId), uint32(detail))

proc g_signal_stop_emission_by_name*(instance: ptr Object00; detailedSignal: cstring) {.
    importc: "g_signal_stop_emission_by_name", libprag.}

proc signalStopEmissionByName*(instance: Object; detailedSignal: string) =
  g_signal_stop_emission_by_name(cast[ptr Object00](instance.impl), cstring(detailedSignal))

proc g_signal_type_cclosure_new*(itype: GType; structOffset: uint32): ptr Closure00 {.
    importc: "g_signal_type_cclosure_new", libprag.}

proc signalTypeCclosureNew*(itype: GType; structOffset: int): Closure =
  new(result)
  result.impl = g_signal_type_cclosure_new(itype, uint32(structOffset))

proc g_source_set_closure*(source: ptr glib.Source00; closure: ptr Closure00) {.
    importc: "g_source_set_closure", libprag.}

proc sourceSetClosure*(source: glib.Source; closure: Closure) =
  g_source_set_closure(cast[ptr glib.Source00](source.impl), cast[ptr Closure00](closure.impl))

proc g_source_set_dummy_callback*(source: ptr glib.Source00) {.
    importc: "g_source_set_dummy_callback", libprag.}

proc sourceSetDummyCallback*(source: glib.Source) =
  g_source_set_dummy_callback(cast[ptr glib.Source00](source.impl))

proc g_strdup_value_contents*(value: ptr Value00): cstring {.
    importc: "g_strdup_value_contents", libprag.}

proc strdupValueContents*(value: Value): string =
  let resul0 = g_strdup_value_contents(cast[ptr Value00](value.impl))
  result = $resul0
  cogfree(resul0)

proc g_type_add_class_private*(classType: GType; privateSize: uint64) {.
    importc: "g_type_add_class_private", libprag.}

proc typeAddClassPrivate*(classType: GType; privateSize: uint64) {.
    importc: "g_type_add_class_private", libprag.}

proc g_type_add_instance_private*(classType: GType; privateSize: uint64): int32 {.
    importc: "g_type_add_instance_private", libprag.}

proc typeAddInstancePrivate*(classType: GType; privateSize: uint64): int32 {.
    importc: "g_type_add_instance_private", libprag.}

proc g_type_add_interface_static*(instanceType: GType; interfaceType: GType; info: ptr InterfaceInfo00) {.
    importc: "g_type_add_interface_static", libprag.}

proc typeAddInterfaceStatic*(instanceType: GType; interfaceType: GType; info: InterfaceInfo) =
  g_type_add_interface_static(instanceType, interfaceType, cast[ptr InterfaceInfo00](info.impl))

proc g_type_check_class_is_a*(gClass: ptr TypeClass00; isAType: GType): gboolean {.
    importc: "g_type_check_class_is_a", libprag.}

proc typeCheckClassIsA*(gClass: TypeClass; isAType: GType): bool =
  toBool(g_type_check_class_is_a(cast[ptr TypeClass00](gClass.impl), isAType))

proc g_type_check_instance*(instance: ptr TypeInstance00): gboolean {.
    importc: "g_type_check_instance", libprag.}

proc typeCheckInstance*(instance: TypeInstance): bool =
  toBool(g_type_check_instance(cast[ptr TypeInstance00](instance.impl)))

proc g_type_check_instance_is_a*(instance: ptr TypeInstance00; ifaceType: GType): gboolean {.
    importc: "g_type_check_instance_is_a", libprag.}

proc typeCheckInstanceIsA*(instance: TypeInstance; ifaceType: GType): bool =
  toBool(g_type_check_instance_is_a(cast[ptr TypeInstance00](instance.impl), ifaceType))

proc g_type_check_instance_is_fundamentally_a*(instance: ptr TypeInstance00; fundamentalType: GType): gboolean {.
    importc: "g_type_check_instance_is_fundamentally_a", libprag.}

proc typeCheckInstanceIsFundamentallyA*(instance: TypeInstance; fundamentalType: GType): bool =
  toBool(g_type_check_instance_is_fundamentally_a(cast[ptr TypeInstance00](instance.impl), fundamentalType))

proc g_type_check_is_value_type*(`type`: GType): gboolean {.
    importc: "g_type_check_is_value_type", libprag.}

proc typeCheckIsValueType*(`type`: GType): gboolean {.
    importc: "g_type_check_is_value_type", libprag.}

proc g_type_check_value*(value: ptr Value00): gboolean {.
    importc: "g_type_check_value", libprag.}

proc typeCheckValue*(value: Value): bool =
  toBool(g_type_check_value(cast[ptr Value00](value.impl)))

proc g_type_check_value_holds*(value: ptr Value00; `type`: GType): gboolean {.
    importc: "g_type_check_value_holds", libprag.}

proc typeCheckValueHolds*(value: Value; `type`: GType): bool =
  toBool(g_type_check_value_holds(cast[ptr Value00](value.impl), `type`))

proc g_type_children*(`type`: GType; nChildren: var uint32): GTypeArray {.
    importc: "g_type_children", libprag.}

proc typeChildren*(`type`: GType; nChildren: var uint32): GTypeArray {.
    importc: "g_type_children", libprag.}

proc g_type_default_interface_peek*(gType: GType): ptr TypeInterface00 {.
    importc: "g_type_default_interface_peek", libprag.}

proc typeDefaultInterfacePeek*(gType: GType): TypeInterface =
  new(result)
  result.impl = g_type_default_interface_peek(gType)

proc g_type_default_interface_ref*(gType: GType): ptr TypeInterface00 {.
    importc: "g_type_default_interface_ref", libprag.}

proc typeDefaultInterfaceRef*(gType: GType): TypeInterface =
  new(result)
  result.impl = g_type_default_interface_ref(gType)

proc g_type_default_interface_unref*(gIface: ptr TypeInterface00) {.
    importc: "g_type_default_interface_unref", libprag.}

proc typeDefaultInterfaceUnref*(gIface: TypeInterface) =
  g_type_default_interface_unref(cast[ptr TypeInterface00](gIface.impl))

proc g_type_depth*(`type`: GType): uint32 {.
    importc: "g_type_depth", libprag.}

proc typeDepth*(`type`: GType): uint32 {.
    importc: "g_type_depth", libprag.}

proc g_type_ensure*(`type`: GType) {.
    importc: "g_type_ensure", libprag.}

proc typeEnsure*(`type`: GType) {.
    importc: "g_type_ensure", libprag.}

proc g_type_free_instance*(instance: ptr TypeInstance00) {.
    importc: "g_type_free_instance", libprag.}

proc typeFreeInstance*(instance: TypeInstance) =
  g_type_free_instance(cast[ptr TypeInstance00](instance.impl))

proc g_type_from_name*(name: cstring): GType {.
    importc: "g_type_from_name", libprag.}

proc typeFromName*(name: cstring): GType {.
    importc: "g_type_from_name", libprag.}

proc g_type_fundamental*(typeId: GType): GType {.
    importc: "g_type_fundamental", libprag.}

proc typeFundamental*(typeId: GType): GType {.
    importc: "g_type_fundamental", libprag.}

proc g_type_fundamental_next*(): GType {.
    importc: "g_type_fundamental_next", libprag.}

proc typeFundamentalNext*(): GType {.
    importc: "g_type_fundamental_next", libprag.}

proc g_type_get_instance_count*(`type`: GType): int32 {.
    importc: "g_type_get_instance_count", libprag.}

proc typeGetInstanceCount*(`type`: GType): int32 {.
    importc: "g_type_get_instance_count", libprag.}

proc g_type_get_qdata*(`type`: GType; quark: uint32): pointer {.
    importc: "g_type_get_qdata", libprag.}

proc typeGetQdata*(`type`: GType; quark: uint32): pointer {.
    importc: "g_type_get_qdata", libprag.}

proc g_type_get_type_registration_serial*(): uint32 {.
    importc: "g_type_get_type_registration_serial", libprag.}

proc typeGetTypeRegistrationSerial*(): uint32 {.
    importc: "g_type_get_type_registration_serial", libprag.}

proc g_type_init*() {.
    importc: "g_type_init", libprag.}

proc typeInit*() {.
    importc: "g_type_init", libprag.}

proc g_type_init_with_debug_flags*(debugFlags: TypeDebugFlags) {.
    importc: "g_type_init_with_debug_flags", libprag.}

proc typeInitWithDebugFlags*(debugFlags: TypeDebugFlags) {.
    importc: "g_type_init_with_debug_flags", libprag.}

proc g_type_interfaces*(`type`: GType; nInterfaces: var uint32): GTypeArray {.
    importc: "g_type_interfaces", libprag.}

proc typeInterfaces*(`type`: GType; nInterfaces: var uint32): GTypeArray {.
    importc: "g_type_interfaces", libprag.}

proc g_type_is_a*(`type`: GType; isAType: GType): gboolean {.
    importc: "g_type_is_a", libprag.}

proc typeIsA*(`type`: GType; isAType: GType): gboolean {.
    importc: "g_type_is_a", libprag.}

proc g_type_name*(`type`: GType): cstring {.
    importc: "g_type_name", libprag.}

proc typeName*(`type`: GType): string =
  let resul0 = g_type_name(`type`)
  result = $resul0

proc g_type_name_from_class*(gClass: ptr TypeClass00): cstring {.
    importc: "g_type_name_from_class", libprag.}

proc typeNameFromClass*(gClass: TypeClass): string =
  let resul0 = g_type_name_from_class(cast[ptr TypeClass00](gClass.impl))
  result = $resul0

proc g_type_name_from_instance*(instance: ptr TypeInstance00): cstring {.
    importc: "g_type_name_from_instance", libprag.}

proc typeNameFromInstance*(instance: TypeInstance): string =
  let resul0 = g_type_name_from_instance(cast[ptr TypeInstance00](instance.impl))
  result = $resul0

proc g_type_next_base*(leafType: GType; rootType: GType): GType {.
    importc: "g_type_next_base", libprag.}

proc typeNextBase*(leafType: GType; rootType: GType): GType {.
    importc: "g_type_next_base", libprag.}

proc g_type_parent*(`type`: GType): GType {.
    importc: "g_type_parent", libprag.}

proc typeParent*(`type`: GType): GType {.
    importc: "g_type_parent", libprag.}

proc g_type_qname*(`type`: GType): uint32 {.
    importc: "g_type_qname", libprag.}

proc typeQname*(`type`: GType): uint32 {.
    importc: "g_type_qname", libprag.}

proc g_type_query*(`type`: GType; query: var TypeQuery00) {.
    importc: "g_type_query", libprag.}

proc typeQuery*(`type`: GType; query: var TypeQuery00) {.
    importc: "g_type_query", libprag.}

proc g_type_register_fundamental*(typeId: GType; typeName: cstring; info: ptr TypeInfo00; 
    finfo: ptr TypeFundamentalInfo00; flags: TypeFlags): GType {.
    importc: "g_type_register_fundamental", libprag.}

proc typeRegisterFundamental*(typeId: GType; typeName: string; info: TypeInfo; finfo: TypeFundamentalInfo; 
    flags: TypeFlags): GType =
  g_type_register_fundamental(typeId, cstring(typeName), cast[ptr TypeInfo00](info.impl), cast[ptr TypeFundamentalInfo00](finfo.impl), flags)

proc g_type_register_static*(parentType: GType; typeName: cstring; info: ptr TypeInfo00; 
    flags: TypeFlags): GType {.
    importc: "g_type_register_static", libprag.}

proc typeRegisterStatic*(parentType: GType; typeName: string; info: TypeInfo; 
    flags: TypeFlags): GType =
  g_type_register_static(parentType, cstring(typeName), cast[ptr TypeInfo00](info.impl), flags)

proc g_type_set_qdata*(`type`: GType; quark: uint32; data: pointer) {.
    importc: "g_type_set_qdata", libprag.}

proc typeSetQdata*(`type`: GType; quark: uint32; data: pointer) {.
    importc: "g_type_set_qdata", libprag.}

proc g_type_test_flags*(`type`: GType; flags: uint32): gboolean {.
    importc: "g_type_test_flags", libprag.}

proc typeTestFlags*(`type`: GType; flags: uint32): gboolean {.
    importc: "g_type_test_flags", libprag.}
# === remaining symbols:

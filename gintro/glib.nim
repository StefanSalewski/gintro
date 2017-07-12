# dependencies:
# immediate dependencies:
# libraries:
# libglib-2.0.so.0,libgobject-2.0.so.0
{.deadCodeElim: on.}

const Lib* = "libglib-2.0.so.0"
{.pragma: libprag, cdecl, dynlib: Lib.}
type
  OptionEntry00Array* = pointer
type
  int8Array* = pointer
type
  uintArray* = pointer
type
  gbooleanArray* = pointer
type
  cdoubleArray* = pointer
type
  int32Array* = pointer
type
  PollFD00Array* = pointer
type
  Variant00Array* = pointer
type
  LogField00Array* = pointer
type
  VariantType00Array* = pointer
type
  DebugKey00Array* = pointer
type
  utf8Array* = pointer
type
  uint8Array* = pointer
type
  ucstringArray* = pointer
type
  ucstring* = distinct cstring
type
  gboolean* = distinct cint
type
  GType* = distinct cint
type
  gunichar* = uint32
type
  utf8* = char
const GFalse = gboolean(0)
const GTrue = gboolean(1)
proc cogfree*(mem: pointer) {.importc: "g_free", libprag.}
proc toBool*(g: gboolean): bool = g.int != 0

const ANALYZER_ANALYZING* = 1'i32

const ASCII_DTOSTR_BUF_SIZE* = 39'i32

type
  Array00* {.pure.} = object
    data*: cstring
    len*: uint32
  Array* = ref object
    impl*: ptr Array00

type
  AsciiType* {.size: sizeof(cint), pure.} = enum
    alnum = 1
    alpha = 2
    cntrl = 4
    digit = 8
    graph = 16
    lower = 32
    print = 64
    punct = 128
    space = 256
    upper = 512
    xdigit = 1024

type
  AsyncQueue00* {.pure.} = object
  AsyncQueue* = ref object
    impl*: ptr AsyncQueue00

proc g_async_queue_length*(self: ptr AsyncQueue00): int32 {.
    importc: "g_async_queue_length", libprag.}

proc length*(self: AsyncQueue): int =
  int(g_async_queue_length(cast[ptr AsyncQueue00](self.impl)))

proc g_async_queue_length_unlocked*(self: ptr AsyncQueue00): int32 {.
    importc: "g_async_queue_length_unlocked", libprag.}

proc lengthUnlocked*(self: AsyncQueue): int =
  int(g_async_queue_length_unlocked(cast[ptr AsyncQueue00](self.impl)))

proc g_async_queue_lock*(self: ptr AsyncQueue00) {.
    importc: "g_async_queue_lock", libprag.}

proc lock*(self: AsyncQueue) =
  g_async_queue_lock(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_pop*(self: ptr AsyncQueue00): pointer {.
    importc: "g_async_queue_pop", libprag.}

proc pop*(self: AsyncQueue): pointer =
  g_async_queue_pop(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_pop_unlocked*(self: ptr AsyncQueue00): pointer {.
    importc: "g_async_queue_pop_unlocked", libprag.}

proc popUnlocked*(self: AsyncQueue): pointer =
  g_async_queue_pop_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_push*(self: ptr AsyncQueue00; data: pointer) {.
    importc: "g_async_queue_push", libprag.}

proc push*(self: AsyncQueue; data: pointer) =
  g_async_queue_push(cast[ptr AsyncQueue00](self.impl), data)

proc g_async_queue_push_front*(self: ptr AsyncQueue00; item: pointer) {.
    importc: "g_async_queue_push_front", libprag.}

proc pushFront*(self: AsyncQueue; item: pointer) =
  g_async_queue_push_front(cast[ptr AsyncQueue00](self.impl), item)

proc g_async_queue_push_front_unlocked*(self: ptr AsyncQueue00; item: pointer) {.
    importc: "g_async_queue_push_front_unlocked", libprag.}

proc pushFrontUnlocked*(self: AsyncQueue; item: pointer) =
  g_async_queue_push_front_unlocked(cast[ptr AsyncQueue00](self.impl), item)

proc g_async_queue_push_unlocked*(self: ptr AsyncQueue00; data: pointer) {.
    importc: "g_async_queue_push_unlocked", libprag.}

proc pushUnlocked*(self: AsyncQueue; data: pointer) =
  g_async_queue_push_unlocked(cast[ptr AsyncQueue00](self.impl), data)

proc g_async_queue_ref_unlocked*(self: ptr AsyncQueue00) {.
    importc: "g_async_queue_ref_unlocked", libprag.}

proc refUnlocked*(self: AsyncQueue) =
  g_async_queue_ref_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_remove*(self: ptr AsyncQueue00; item: pointer): gboolean {.
    importc: "g_async_queue_remove", libprag.}

proc remove*(self: AsyncQueue; item: pointer): bool =
  toBool(g_async_queue_remove(cast[ptr AsyncQueue00](self.impl), item))

proc g_async_queue_remove_unlocked*(self: ptr AsyncQueue00; item: pointer): gboolean {.
    importc: "g_async_queue_remove_unlocked", libprag.}

proc removeUnlocked*(self: AsyncQueue; item: pointer): bool =
  toBool(g_async_queue_remove_unlocked(cast[ptr AsyncQueue00](self.impl), item))

proc g_async_queue_timeout_pop*(self: ptr AsyncQueue00; timeout: uint64): pointer {.
    importc: "g_async_queue_timeout_pop", libprag.}

proc timeoutPop*(self: AsyncQueue; timeout: uint64): pointer =
  g_async_queue_timeout_pop(cast[ptr AsyncQueue00](self.impl), timeout)

proc g_async_queue_timeout_pop_unlocked*(self: ptr AsyncQueue00; timeout: uint64): pointer {.
    importc: "g_async_queue_timeout_pop_unlocked", libprag.}

proc timeoutPopUnlocked*(self: AsyncQueue; timeout: uint64): pointer =
  g_async_queue_timeout_pop_unlocked(cast[ptr AsyncQueue00](self.impl), timeout)

proc g_async_queue_try_pop*(self: ptr AsyncQueue00): pointer {.
    importc: "g_async_queue_try_pop", libprag.}

proc tryPop*(self: AsyncQueue): pointer =
  g_async_queue_try_pop(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_try_pop_unlocked*(self: ptr AsyncQueue00): pointer {.
    importc: "g_async_queue_try_pop_unlocked", libprag.}

proc tryPopUnlocked*(self: AsyncQueue): pointer =
  g_async_queue_try_pop_unlocked(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_unlock*(self: ptr AsyncQueue00) {.
    importc: "g_async_queue_unlock", libprag.}

proc unlock*(self: AsyncQueue) =
  g_async_queue_unlock(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_unref*(self: ptr AsyncQueue00) {.
    importc: "g_async_queue_unref", libprag.}

proc unref*(self: AsyncQueue) =
  g_async_queue_unref(cast[ptr AsyncQueue00](self.impl))

proc g_async_queue_unref_and_unlock*(self: ptr AsyncQueue00) {.
    importc: "g_async_queue_unref_and_unlock", libprag.}

proc unrefAndUnlock*(self: AsyncQueue) =
  g_async_queue_unref_and_unlock(cast[ptr AsyncQueue00](self.impl))

type
  TimeVal00* {.pure.} = object
    tvSec*: int64
    tvUsec*: int64
  TimeVal* = ref object
    impl*: ptr TimeVal00

proc g_time_val_add*(self: ptr TimeVal00; microseconds: int64) {.
    importc: "g_time_val_add", libprag.}

proc add*(self: TimeVal; microseconds: int64) =
  g_time_val_add(cast[ptr TimeVal00](self.impl), microseconds)

proc g_time_val_to_iso8601*(self: ptr TimeVal00): cstring {.
    importc: "g_time_val_to_iso8601", libprag.}

proc toIso8601*(self: TimeVal): string =
  let resul0 = g_time_val_to_iso8601(cast[ptr TimeVal00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_time_val_from_iso8601*(isoDate: cstring; time: var TimeVal00): gboolean {.
    importc: "g_time_val_from_iso8601", libprag.}

proc fromIso8601*(isoDate: cstring; time: var TimeVal00): gboolean {.
    importc: "g_time_val_from_iso8601", libprag.}

proc g_async_queue_timed_pop*(self: ptr AsyncQueue00; endTime: ptr TimeVal00): pointer {.
    importc: "g_async_queue_timed_pop", libprag.}

proc timedPop*(self: AsyncQueue; endTime: TimeVal): pointer =
  g_async_queue_timed_pop(cast[ptr AsyncQueue00](self.impl), cast[ptr TimeVal00](endTime.impl))

proc g_async_queue_timed_pop_unlocked*(self: ptr AsyncQueue00; endTime: ptr TimeVal00): pointer {.
    importc: "g_async_queue_timed_pop_unlocked", libprag.}

proc timedPopUnlocked*(self: AsyncQueue; endTime: TimeVal): pointer =
  g_async_queue_timed_pop_unlocked(cast[ptr AsyncQueue00](self.impl), cast[ptr TimeVal00](endTime.impl))

const BIG_ENDIAN* = 4321'i32

type
  BookmarkFile00* {.pure.} = object
  BookmarkFile* = ref object
    impl*: ptr BookmarkFile00

proc g_bookmark_file_add_application*(self: ptr BookmarkFile00; uri: cstring; name: cstring; 
    exec: cstring) {.
    importc: "g_bookmark_file_add_application", libprag.}

proc addApplication*(self: BookmarkFile; uri: string; name: string; exec: string) =
  g_bookmark_file_add_application(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name), cstring(exec))

proc g_bookmark_file_add_group*(self: ptr BookmarkFile00; uri: cstring; group: cstring) {.
    importc: "g_bookmark_file_add_group", libprag.}

proc addGroup*(self: BookmarkFile; uri: string; group: string) =
  g_bookmark_file_add_group(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(group))

proc g_bookmark_file_free*(self: ptr BookmarkFile00) {.
    importc: "g_bookmark_file_free", libprag.}

proc free*(self: BookmarkFile) =
  g_bookmark_file_free(cast[ptr BookmarkFile00](self.impl))

proc g_bookmark_file_get_added*(self: ptr BookmarkFile00; uri: cstring): int64 {.
    importc: "g_bookmark_file_get_added", libprag.}

proc getAdded*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_added(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc added*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_added(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc g_bookmark_file_get_app_info*(self: ptr BookmarkFile00; uri: cstring; name: cstring; 
    exec: var cstring; count: var uint32; stamp: var int64): gboolean {.
    importc: "g_bookmark_file_get_app_info", libprag.}

proc getAppInfo*(self: BookmarkFile; uri: string; name: string; exec: var string; 
    count: var int; stamp: var int64): bool =
  var exec_00 = cstring(exec)
  var count_00 = uint32(count)
  result = toBool(g_bookmark_file_get_app_info(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name), exec_00, count_00, stamp))
  exec = $(exec_00)
  count = int(count_00)

proc appInfo*(self: BookmarkFile; uri: string; name: string; exec: var string; 
    count: var int; stamp: var int64): bool =
  var exec_00 = cstring(exec)
  var count_00 = uint32(count)
  result = toBool(g_bookmark_file_get_app_info(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name), exec_00, count_00, stamp))
  exec = $(exec_00)
  count = int(count_00)

proc g_bookmark_file_get_applications*(self: ptr BookmarkFile00; uri: cstring; length: var uint64): cstringArray {.
    importc: "g_bookmark_file_get_applications", libprag.}

proc getApplications*(self: BookmarkFile; uri: string; length: var uint64): cstringArray =
  g_bookmark_file_get_applications(cast[ptr BookmarkFile00](self.impl), cstring(uri), length)

proc applications*(self: BookmarkFile; uri: string; length: var uint64): cstringArray =
  g_bookmark_file_get_applications(cast[ptr BookmarkFile00](self.impl), cstring(uri), length)

proc g_bookmark_file_get_description*(self: ptr BookmarkFile00; uri: cstring): cstring {.
    importc: "g_bookmark_file_get_description", libprag.}

proc getDescription*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_description(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc description*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_description(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_groups*(self: ptr BookmarkFile00; uri: cstring; length: var uint64): cstringArray {.
    importc: "g_bookmark_file_get_groups", libprag.}

proc getGroups*(self: BookmarkFile; uri: string; length: var uint64): cstringArray =
  g_bookmark_file_get_groups(cast[ptr BookmarkFile00](self.impl), cstring(uri), length)

proc groups*(self: BookmarkFile; uri: string; length: var uint64): cstringArray =
  g_bookmark_file_get_groups(cast[ptr BookmarkFile00](self.impl), cstring(uri), length)

proc g_bookmark_file_get_icon*(self: ptr BookmarkFile00; uri: cstring; href: var cstring; 
    mimeType: var cstring): gboolean {.
    importc: "g_bookmark_file_get_icon", libprag.}

proc getIcon*(self: BookmarkFile; uri: string; href: var string; 
    mimeType: var string): bool =
  var href_00 = cstring(href)
  var mimeType_00 = cstring(mimeType)
  result = toBool(g_bookmark_file_get_icon(cast[ptr BookmarkFile00](self.impl), cstring(uri), href_00, mimeType_00))
  href = $(href_00)
  mimeType = $(mimeType_00)

proc icon*(self: BookmarkFile; uri: string; href: var string; 
    mimeType: var string): bool =
  var href_00 = cstring(href)
  var mimeType_00 = cstring(mimeType)
  result = toBool(g_bookmark_file_get_icon(cast[ptr BookmarkFile00](self.impl), cstring(uri), href_00, mimeType_00))
  href = $(href_00)
  mimeType = $(mimeType_00)

proc g_bookmark_file_get_is_private*(self: ptr BookmarkFile00; uri: cstring): gboolean {.
    importc: "g_bookmark_file_get_is_private", libprag.}

proc getIsPrivate*(self: BookmarkFile; uri: string): bool =
  toBool(g_bookmark_file_get_is_private(cast[ptr BookmarkFile00](self.impl), cstring(uri)))

proc isPrivate*(self: BookmarkFile; uri: string): bool =
  toBool(g_bookmark_file_get_is_private(cast[ptr BookmarkFile00](self.impl), cstring(uri)))

proc g_bookmark_file_get_mime_type*(self: ptr BookmarkFile00; uri: cstring): cstring {.
    importc: "g_bookmark_file_get_mime_type", libprag.}

proc getMimeType*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_mime_type(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc mimeType*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_mime_type(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_modified*(self: ptr BookmarkFile00; uri: cstring): int64 {.
    importc: "g_bookmark_file_get_modified", libprag.}

proc getModified*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_modified(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc modified*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_modified(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc g_bookmark_file_get_size*(self: ptr BookmarkFile00): int32 {.
    importc: "g_bookmark_file_get_size", libprag.}

proc getSize*(self: BookmarkFile): int =
  int(g_bookmark_file_get_size(cast[ptr BookmarkFile00](self.impl)))

proc size*(self: BookmarkFile): int =
  int(g_bookmark_file_get_size(cast[ptr BookmarkFile00](self.impl)))

proc g_bookmark_file_get_title*(self: ptr BookmarkFile00; uri: cstring): cstring {.
    importc: "g_bookmark_file_get_title", libprag.}

proc getTitle*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_title(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc title*(self: BookmarkFile; uri: string): string =
  let resul0 = g_bookmark_file_get_title(cast[ptr BookmarkFile00](self.impl), cstring(uri))
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_get_uris*(self: ptr BookmarkFile00; length: var uint64): cstringArray {.
    importc: "g_bookmark_file_get_uris", libprag.}

proc getUris*(self: BookmarkFile; length: var uint64): cstringArray =
  g_bookmark_file_get_uris(cast[ptr BookmarkFile00](self.impl), length)

proc uris*(self: BookmarkFile; length: var uint64): cstringArray =
  g_bookmark_file_get_uris(cast[ptr BookmarkFile00](self.impl), length)

proc g_bookmark_file_get_visited*(self: ptr BookmarkFile00; uri: cstring): int64 {.
    importc: "g_bookmark_file_get_visited", libprag.}

proc getVisited*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_visited(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc visited*(self: BookmarkFile; uri: string): int64 =
  g_bookmark_file_get_visited(cast[ptr BookmarkFile00](self.impl), cstring(uri))

proc g_bookmark_file_has_application*(self: ptr BookmarkFile00; uri: cstring; name: cstring): gboolean {.
    importc: "g_bookmark_file_has_application", libprag.}

proc hasApplication*(self: BookmarkFile; uri: string; name: string): bool =
  toBool(g_bookmark_file_has_application(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name)))

proc g_bookmark_file_has_group*(self: ptr BookmarkFile00; uri: cstring; group: cstring): gboolean {.
    importc: "g_bookmark_file_has_group", libprag.}

proc hasGroup*(self: BookmarkFile; uri: string; group: string): bool =
  toBool(g_bookmark_file_has_group(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(group)))

proc g_bookmark_file_has_item*(self: ptr BookmarkFile00; uri: cstring): gboolean {.
    importc: "g_bookmark_file_has_item", libprag.}

proc hasItem*(self: BookmarkFile; uri: string): bool =
  toBool(g_bookmark_file_has_item(cast[ptr BookmarkFile00](self.impl), cstring(uri)))

proc g_bookmark_file_load_from_data*(self: ptr BookmarkFile00; data: cstring; length: uint64): gboolean {.
    importc: "g_bookmark_file_load_from_data", libprag.}

proc loadFromData*(self: BookmarkFile; data: string; length: uint64): bool =
  toBool(g_bookmark_file_load_from_data(cast[ptr BookmarkFile00](self.impl), cstring(data), length))

proc g_bookmark_file_load_from_data_dirs*(self: ptr BookmarkFile00; file: ucstring; fullPath: ucstring): gboolean {.
    importc: "g_bookmark_file_load_from_data_dirs", libprag.}

proc loadFromDataDirs*(self: BookmarkFile; file: ucstring; fullPath: ucstring): bool =
  toBool(g_bookmark_file_load_from_data_dirs(cast[ptr BookmarkFile00](self.impl), file, fullPath))

proc g_bookmark_file_load_from_file*(self: ptr BookmarkFile00; filename: ucstring): gboolean {.
    importc: "g_bookmark_file_load_from_file", libprag.}

proc loadFromFile*(self: BookmarkFile; filename: ucstring): bool =
  toBool(g_bookmark_file_load_from_file(cast[ptr BookmarkFile00](self.impl), filename))

proc g_bookmark_file_move_item*(self: ptr BookmarkFile00; oldUri: cstring; newUri: cstring): gboolean {.
    importc: "g_bookmark_file_move_item", libprag.}

proc moveItem*(self: BookmarkFile; oldUri: string; newUri: string): bool =
  toBool(g_bookmark_file_move_item(cast[ptr BookmarkFile00](self.impl), cstring(oldUri), cstring(newUri)))

proc g_bookmark_file_remove_application*(self: ptr BookmarkFile00; uri: cstring; name: cstring): gboolean {.
    importc: "g_bookmark_file_remove_application", libprag.}

proc removeApplication*(self: BookmarkFile; uri: string; name: string): bool =
  toBool(g_bookmark_file_remove_application(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name)))

proc g_bookmark_file_remove_group*(self: ptr BookmarkFile00; uri: cstring; group: cstring): gboolean {.
    importc: "g_bookmark_file_remove_group", libprag.}

proc removeGroup*(self: BookmarkFile; uri: string; group: string): bool =
  toBool(g_bookmark_file_remove_group(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(group)))

proc g_bookmark_file_remove_item*(self: ptr BookmarkFile00; uri: cstring): gboolean {.
    importc: "g_bookmark_file_remove_item", libprag.}

proc removeItem*(self: BookmarkFile; uri: string): bool =
  toBool(g_bookmark_file_remove_item(cast[ptr BookmarkFile00](self.impl), cstring(uri)))

proc g_bookmark_file_set_added*(self: ptr BookmarkFile00; uri: cstring; added: int64) {.
    importc: "g_bookmark_file_set_added", libprag.}

proc setAdded*(self: BookmarkFile; uri: string; added: int64) =
  g_bookmark_file_set_added(cast[ptr BookmarkFile00](self.impl), cstring(uri), added)

proc g_bookmark_file_set_app_info*(self: ptr BookmarkFile00; uri: cstring; name: cstring; 
    exec: cstring; count: int32; stamp: int64): gboolean {.
    importc: "g_bookmark_file_set_app_info", libprag.}

proc setAppInfo*(self: BookmarkFile; uri: string; name: string; exec: string; 
    count: int; stamp: int64): bool =
  toBool(g_bookmark_file_set_app_info(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(name), cstring(exec), int32(count), stamp))

proc g_bookmark_file_set_description*(self: ptr BookmarkFile00; uri: cstring; description: cstring) {.
    importc: "g_bookmark_file_set_description", libprag.}

proc setDescription*(self: BookmarkFile; uri: string; description: string) =
  g_bookmark_file_set_description(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(description))

proc g_bookmark_file_set_groups*(self: ptr BookmarkFile00; uri: cstring; groups: cstring; 
    length: uint64) {.
    importc: "g_bookmark_file_set_groups", libprag.}

proc setGroups*(self: BookmarkFile; uri: string; groups: string; length: uint64) =
  g_bookmark_file_set_groups(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(groups), length)

proc g_bookmark_file_set_icon*(self: ptr BookmarkFile00; uri: cstring; href: cstring; 
    mimeType: cstring) {.
    importc: "g_bookmark_file_set_icon", libprag.}

proc setIcon*(self: BookmarkFile; uri: string; href: string; mimeType: string) =
  g_bookmark_file_set_icon(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(href), cstring(mimeType))

proc g_bookmark_file_set_is_private*(self: ptr BookmarkFile00; uri: cstring; isPrivate: gboolean) {.
    importc: "g_bookmark_file_set_is_private", libprag.}

proc setIsPrivate*(self: BookmarkFile; uri: string; isPrivate: bool) =
  g_bookmark_file_set_is_private(cast[ptr BookmarkFile00](self.impl), cstring(uri), gboolean(isPrivate))

proc g_bookmark_file_set_mime_type*(self: ptr BookmarkFile00; uri: cstring; mimeType: cstring) {.
    importc: "g_bookmark_file_set_mime_type", libprag.}

proc setMimeType*(self: BookmarkFile; uri: string; mimeType: string) =
  g_bookmark_file_set_mime_type(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(mimeType))

proc g_bookmark_file_set_modified*(self: ptr BookmarkFile00; uri: cstring; modified: int64) {.
    importc: "g_bookmark_file_set_modified", libprag.}

proc setModified*(self: BookmarkFile; uri: string; modified: int64) =
  g_bookmark_file_set_modified(cast[ptr BookmarkFile00](self.impl), cstring(uri), modified)

proc g_bookmark_file_set_title*(self: ptr BookmarkFile00; uri: cstring; title: cstring) {.
    importc: "g_bookmark_file_set_title", libprag.}

proc setTitle*(self: BookmarkFile; uri: string; title: string) =
  g_bookmark_file_set_title(cast[ptr BookmarkFile00](self.impl), cstring(uri), cstring(title))

proc g_bookmark_file_set_visited*(self: ptr BookmarkFile00; uri: cstring; visited: int64) {.
    importc: "g_bookmark_file_set_visited", libprag.}

proc setVisited*(self: BookmarkFile; uri: string; visited: int64) =
  g_bookmark_file_set_visited(cast[ptr BookmarkFile00](self.impl), cstring(uri), visited)

proc g_bookmark_file_to_data*(self: ptr BookmarkFile00; length: var uint64): cstring {.
    importc: "g_bookmark_file_to_data", libprag.}

proc toData*(self: BookmarkFile; length: var uint64): string =
  let resul0 = g_bookmark_file_to_data(cast[ptr BookmarkFile00](self.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_bookmark_file_to_file*(self: ptr BookmarkFile00; filename: ucstring): gboolean {.
    importc: "g_bookmark_file_to_file", libprag.}

proc toFile*(self: BookmarkFile; filename: ucstring): bool =
  toBool(g_bookmark_file_to_file(cast[ptr BookmarkFile00](self.impl), filename))

proc g_bookmark_file_error_quark*(): uint32 {.
    importc: "g_bookmark_file_error_quark", libprag.}

type
  BookmarkFileError* {.size: sizeof(cint), pure.} = enum
    invalidUri = 0
    invalidValue = 1
    appNotRegistered = 2
    uriNotFound = 3
    read = 4
    unknownEncoding = 5
    write = 6
    fileNotFound = 7

type
  ByteArray00* {.pure.} = object
    data*: ptr uint8
    len*: uint32
  ByteArray* = ref object
    impl*: ptr ByteArray00

proc g_byte_array_free*(array: ptr ByteArray00; freeSegment: gboolean): ptr uint8 {.
    importc: "g_byte_array_free", libprag.}

proc free*(array: ptr ByteArray00; freeSegment: gboolean): ptr uint8 {.
    importc: "g_byte_array_free", libprag.}

proc g_byte_array_new*(): ptr ByteArray00 {.
    importc: "g_byte_array_new", libprag.}

proc new*(): ptr ByteArray00 {.
    importc: "g_byte_array_new", libprag.}

proc g_byte_array_new_take*(data: uint8Array; len: uint64): ptr ByteArray00 {.
    importc: "g_byte_array_new_take", libprag.}

proc newTake*(data: uint8Array; len: uint64): ptr ByteArray00 {.
    importc: "g_byte_array_new_take", libprag.}

proc g_byte_array_unref*(array: ptr ByteArray00) {.
    importc: "g_byte_array_unref", libprag.}

proc unref*(array: ptr ByteArray00) {.
    importc: "g_byte_array_unref", libprag.}

type
  Bytes00* {.pure.} = object
  Bytes* = ref object
    impl*: ptr Bytes00

proc g_bytes_new*(data: uint8Array; size: uint64): ptr Bytes00 {.
    importc: "g_bytes_new", libprag.}

proc newBytes*(data: uint8Array; size: uint64): Bytes =
  new(result)
  result.impl = g_bytes_new(data, size)

proc initBytes*[T](result: var T; data: uint8Array; size: uint64) =
  assert(result is Bytes)
  new(result)
  result.impl = g_bytes_new(data, size)

proc g_bytes_new_take*(data: uint8Array; size: uint64): ptr Bytes00 {.
    importc: "g_bytes_new_take", libprag.}

proc newBytesTake*(data: uint8Array; size: uint64): Bytes =
  new(result)
  result.impl = g_bytes_new_take(data, size)

proc initBytesTake*[T](result: var T; data: uint8Array; size: uint64) =
  assert(result is Bytes)
  new(result)
  result.impl = g_bytes_new_take(data, size)

proc g_bytes_compare*(self: ptr Bytes00; bytes2: ptr Bytes00): int32 {.
    importc: "g_bytes_compare", libprag.}

proc compare*(self: Bytes; bytes2: Bytes): int =
  int(g_bytes_compare(cast[ptr Bytes00](self.impl), cast[ptr Bytes00](bytes2.impl)))

proc g_bytes_equal*(self: ptr Bytes00; bytes2: ptr Bytes00): gboolean {.
    importc: "g_bytes_equal", libprag.}

proc equal*(self: Bytes; bytes2: Bytes): bool =
  toBool(g_bytes_equal(cast[ptr Bytes00](self.impl), cast[ptr Bytes00](bytes2.impl)))

proc g_bytes_get_data*(self: ptr Bytes00; size: var uint64): uint8Array {.
    importc: "g_bytes_get_data", libprag.}

proc getData*(self: Bytes; size: var uint64): uint8Array =
  g_bytes_get_data(cast[ptr Bytes00](self.impl), size)

proc data*(self: Bytes; size: var uint64): uint8Array =
  g_bytes_get_data(cast[ptr Bytes00](self.impl), size)

proc g_bytes_get_size*(self: ptr Bytes00): uint64 {.
    importc: "g_bytes_get_size", libprag.}

proc getSize*(self: Bytes): uint64 =
  g_bytes_get_size(cast[ptr Bytes00](self.impl))

proc size*(self: Bytes): uint64 =
  g_bytes_get_size(cast[ptr Bytes00](self.impl))

proc g_bytes_hash*(self: ptr Bytes00): uint32 {.
    importc: "g_bytes_hash", libprag.}

proc hash*(self: Bytes): int =
  int(g_bytes_hash(cast[ptr Bytes00](self.impl)))

proc g_bytes_new_from_bytes*(self: ptr Bytes00; offset: uint64; length: uint64): ptr Bytes00 {.
    importc: "g_bytes_new_from_bytes", libprag.}

proc newBytesFromBytes*(self: Bytes; offset: uint64; length: uint64): Bytes =
  new(result)
  result.impl = g_bytes_new_from_bytes(cast[ptr Bytes00](self.impl), offset, length)

proc g_bytes_ref*(self: ptr Bytes00): ptr Bytes00 {.
    importc: "g_bytes_ref", libprag.}

proc `ref`*(self: Bytes): Bytes =
  new(result)
  result.impl = g_bytes_ref(cast[ptr Bytes00](self.impl))

proc g_bytes_unref*(self: ptr Bytes00) {.
    importc: "g_bytes_unref", libprag.}

proc unref*(self: Bytes) =
  g_bytes_unref(cast[ptr Bytes00](self.impl))

proc g_bytes_unref_to_array*(self: ptr Bytes00): ptr ByteArray00 {.
    importc: "g_bytes_unref_to_array", libprag.}

proc unrefToArray*(self: Bytes): ptr ByteArray00 =
  g_bytes_unref_to_array(cast[ptr Bytes00](self.impl))

proc g_bytes_unref_to_data*(self: ptr Bytes00; size: var uint64): uint8Array {.
    importc: "g_bytes_unref_to_data", libprag.}

proc unrefToData*(self: Bytes; size: var uint64): uint8Array =
  g_bytes_unref_to_data(cast[ptr Bytes00](self.impl), size)

proc g_byte_array_free_to_bytes*(array: ptr ByteArray00): ptr Bytes00 {.
    importc: "g_byte_array_free_to_bytes", libprag.}

proc freeToBytes*(array: ptr ByteArray00): Bytes =
  new(result)
  result.impl = g_byte_array_free_to_bytes(array)

const CSET_A_2_Z_U* = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

const CSET_DIGITS* = "0123456789"

const CSET_a_2Z* = "abcdefghijklmnopqrstuvwxyz"

type
  Checksum00* {.pure.} = object
  Checksum* = ref object
    impl*: ptr Checksum00

proc g_checksum_copy*(self: ptr Checksum00): ptr Checksum00 {.
    importc: "g_checksum_copy", libprag.}

proc copy*(self: Checksum): Checksum =
  new(result)
  result.impl = g_checksum_copy(cast[ptr Checksum00](self.impl))

proc g_checksum_free*(self: ptr Checksum00) {.
    importc: "g_checksum_free", libprag.}

proc free*(self: Checksum) =
  g_checksum_free(cast[ptr Checksum00](self.impl))

proc g_checksum_get_string*(self: ptr Checksum00): cstring {.
    importc: "g_checksum_get_string", libprag.}

proc getString*(self: Checksum): string =
  let resul0 = g_checksum_get_string(cast[ptr Checksum00](self.impl))
  result = $resul0

proc string*(self: Checksum): string =
  let resul0 = g_checksum_get_string(cast[ptr Checksum00](self.impl))
  result = $resul0

proc g_checksum_reset*(self: ptr Checksum00) {.
    importc: "g_checksum_reset", libprag.}

proc reset*(self: Checksum) =
  g_checksum_reset(cast[ptr Checksum00](self.impl))

proc g_checksum_update*(self: ptr Checksum00; data: uint8Array; length: int64) {.
    importc: "g_checksum_update", libprag.}

proc update*(self: Checksum; data: uint8Array; length: int64) =
  g_checksum_update(cast[ptr Checksum00](self.impl), data, length)

type
  ChecksumType* {.size: sizeof(cint), pure.} = enum
    md5 = 0
    sha1 = 1
    sha256 = 2
    sha512 = 3

proc g_checksum_new*(checksumType: ChecksumType): ptr Checksum00 {.
    importc: "g_checksum_new", libprag.}

proc newChecksum*(checksumType: ChecksumType): Checksum =
  new(result)
  result.impl = g_checksum_new(checksumType)

proc initChecksum*[T](result: var T; checksumType: ChecksumType) =
  assert(result is Checksum)
  new(result)
  result.impl = g_checksum_new(checksumType)

proc g_checksum_type_get_length*(checksumType: ChecksumType): int64 {.
    importc: "g_checksum_type_get_length", libprag.}

proc typeGetLength*(checksumType: ChecksumType): int64 {.
    importc: "g_checksum_type_get_length", libprag.}

type
  ChildWatchFunc* = proc (pid: int32; status: int32; userData: pointer) {.cdecl.}

type
  CompareDataFunc* = proc (a: pointer; b: pointer; userData: pointer): int32 {.cdecl.}

type
  CompareFunc* = proc (a: pointer; b: pointer): int32 {.cdecl.}

type
  Cond00* {.pure.} = object
    p*: pointer
    i*: array[2, uint32]
  Cond* = ref object
    impl*: ptr Cond00

proc g_cond_broadcast*(self: ptr Cond00) {.
    importc: "g_cond_broadcast", libprag.}

proc broadcast*(self: Cond) =
  g_cond_broadcast(cast[ptr Cond00](self.impl))

proc g_cond_clear*(self: ptr Cond00) {.
    importc: "g_cond_clear", libprag.}

proc clear*(self: Cond) =
  g_cond_clear(cast[ptr Cond00](self.impl))

proc g_cond_init*(self: ptr Cond00) {.
    importc: "g_cond_init", libprag.}

proc init*(self: Cond) =
  g_cond_init(cast[ptr Cond00](self.impl))

proc g_cond_signal*(self: ptr Cond00) {.
    importc: "g_cond_signal", libprag.}

proc signal*(self: Cond) =
  g_cond_signal(cast[ptr Cond00](self.impl))

type
  ConvertError* {.size: sizeof(cint), pure.} = enum
    noConversion = 0
    illegalSequence = 1
    failed = 2
    partialInput = 3
    badUri = 4
    notAbsolutePath = 5
    noMemory = 6

type
  CopyFunc* = proc (src: pointer; data: pointer): pointer {.cdecl.}

const DATALIST_FLAGS_MASK* = 3'i32

const DATE_BAD_DAY* = 0'i32

const DATE_BAD_JULIAN* = 0'i32

const DATE_BAD_YEAR* = 0'i32

const DIR_SEPARATOR* = 92'i32

const DIR_SEPARATOR_S* = "\\"

type
  Data00* {.pure.} = object
  Data* = ref object
    impl*: ptr Data00

type
  DataForeachFunc* = proc (keyId: uint32; data: pointer; userData: pointer) {.cdecl.}

type
  Date00* {.pure.} = object
    julianDays*: uint32
    julian*: uint32
    dmy*: uint32
    day*: uint32
    month*: uint32
    year*: uint32
  Date* = ref object
    impl*: ptr Date00

proc g_date_new*(): ptr Date00 {.
    importc: "g_date_new", libprag.}

proc newDate*(): Date =
  new(result)
  result.impl = g_date_new()

proc initDate*[T](result: var T) =
  assert(result is Date)
  new(result)
  result.impl = g_date_new()

proc g_date_new_julian*(julianDay: uint32): ptr Date00 {.
    importc: "g_date_new_julian", libprag.}

proc newDateJulian*(julianDay: int): Date =
  new(result)
  result.impl = g_date_new_julian(uint32(julianDay))

proc initDateJulian*[T](result: var T; julianDay: int) =
  assert(result is Date)
  new(result)
  result.impl = g_date_new_julian(uint32(julianDay))

proc g_date_add_days*(self: ptr Date00; nDays: uint32) {.
    importc: "g_date_add_days", libprag.}

proc addDays*(self: Date; nDays: int) =
  g_date_add_days(cast[ptr Date00](self.impl), uint32(nDays))

proc g_date_add_months*(self: ptr Date00; nMonths: uint32) {.
    importc: "g_date_add_months", libprag.}

proc addMonths*(self: Date; nMonths: int) =
  g_date_add_months(cast[ptr Date00](self.impl), uint32(nMonths))

proc g_date_add_years*(self: ptr Date00; nYears: uint32) {.
    importc: "g_date_add_years", libprag.}

proc addYears*(self: Date; nYears: int) =
  g_date_add_years(cast[ptr Date00](self.impl), uint32(nYears))

proc g_date_clamp*(self: ptr Date00; minDate: ptr Date00; maxDate: ptr Date00) {.
    importc: "g_date_clamp", libprag.}

proc clamp*(self: Date; minDate: Date; maxDate: Date) =
  g_date_clamp(cast[ptr Date00](self.impl), cast[ptr Date00](minDate.impl), cast[ptr Date00](maxDate.impl))

proc g_date_clear*(self: ptr Date00; nDates: uint32) {.
    importc: "g_date_clear", libprag.}

proc clear*(self: Date; nDates: int) =
  g_date_clear(cast[ptr Date00](self.impl), uint32(nDates))

proc g_date_compare*(self: ptr Date00; rhs: ptr Date00): int32 {.
    importc: "g_date_compare", libprag.}

proc compare*(self: Date; rhs: Date): int =
  int(g_date_compare(cast[ptr Date00](self.impl), cast[ptr Date00](rhs.impl)))

proc g_date_days_between*(self: ptr Date00; date2: ptr Date00): int32 {.
    importc: "g_date_days_between", libprag.}

proc daysBetween*(self: Date; date2: Date): int =
  int(g_date_days_between(cast[ptr Date00](self.impl), cast[ptr Date00](date2.impl)))

proc g_date_free*(self: ptr Date00) {.
    importc: "g_date_free", libprag.}

proc free*(self: Date) =
  g_date_free(cast[ptr Date00](self.impl))

proc g_date_get_day*(self: ptr Date00): uint8 {.
    importc: "g_date_get_day", libprag.}

proc getDay*(self: Date): uint8 =
  g_date_get_day(cast[ptr Date00](self.impl))

proc day*(self: Date): uint8 =
  g_date_get_day(cast[ptr Date00](self.impl))

proc g_date_get_day_of_year*(self: ptr Date00): uint32 {.
    importc: "g_date_get_day_of_year", libprag.}

proc getDayOfYear*(self: Date): int =
  int(g_date_get_day_of_year(cast[ptr Date00](self.impl)))

proc dayOfYear*(self: Date): int =
  int(g_date_get_day_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_iso8601_week_of_year*(self: ptr Date00): uint32 {.
    importc: "g_date_get_iso8601_week_of_year", libprag.}

proc getIso8601WeekOfYear*(self: Date): int =
  int(g_date_get_iso8601_week_of_year(cast[ptr Date00](self.impl)))

proc iso8601WeekOfYear*(self: Date): int =
  int(g_date_get_iso8601_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_julian*(self: ptr Date00): uint32 {.
    importc: "g_date_get_julian", libprag.}

proc getJulian*(self: Date): int =
  int(g_date_get_julian(cast[ptr Date00](self.impl)))

proc julian*(self: Date): int =
  int(g_date_get_julian(cast[ptr Date00](self.impl)))

proc g_date_get_monday_week_of_year*(self: ptr Date00): uint32 {.
    importc: "g_date_get_monday_week_of_year", libprag.}

proc getMondayWeekOfYear*(self: Date): int =
  int(g_date_get_monday_week_of_year(cast[ptr Date00](self.impl)))

proc mondayWeekOfYear*(self: Date): int =
  int(g_date_get_monday_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_sunday_week_of_year*(self: ptr Date00): uint32 {.
    importc: "g_date_get_sunday_week_of_year", libprag.}

proc getSundayWeekOfYear*(self: Date): int =
  int(g_date_get_sunday_week_of_year(cast[ptr Date00](self.impl)))

proc sundayWeekOfYear*(self: Date): int =
  int(g_date_get_sunday_week_of_year(cast[ptr Date00](self.impl)))

proc g_date_get_year*(self: ptr Date00): uint16 {.
    importc: "g_date_get_year", libprag.}

proc getYear*(self: Date): uint16 =
  g_date_get_year(cast[ptr Date00](self.impl))

proc year*(self: Date): uint16 =
  g_date_get_year(cast[ptr Date00](self.impl))

proc g_date_is_first_of_month*(self: ptr Date00): gboolean {.
    importc: "g_date_is_first_of_month", libprag.}

proc isFirstOfMonth*(self: Date): bool =
  toBool(g_date_is_first_of_month(cast[ptr Date00](self.impl)))

proc g_date_is_last_of_month*(self: ptr Date00): gboolean {.
    importc: "g_date_is_last_of_month", libprag.}

proc isLastOfMonth*(self: Date): bool =
  toBool(g_date_is_last_of_month(cast[ptr Date00](self.impl)))

proc g_date_order*(self: ptr Date00; date2: ptr Date00) {.
    importc: "g_date_order", libprag.}

proc order*(self: Date; date2: Date) =
  g_date_order(cast[ptr Date00](self.impl), cast[ptr Date00](date2.impl))

proc g_date_set_day*(self: ptr Date00; day: uint8) {.
    importc: "g_date_set_day", libprag.}

proc setDay*(self: Date; day: uint8) =
  g_date_set_day(cast[ptr Date00](self.impl), day)

proc `day=`*(self: Date; day: uint8) =
  g_date_set_day(cast[ptr Date00](self.impl), day)

proc g_date_set_julian*(self: ptr Date00; julianDate: uint32) {.
    importc: "g_date_set_julian", libprag.}

proc setJulian*(self: Date; julianDate: int) =
  g_date_set_julian(cast[ptr Date00](self.impl), uint32(julianDate))

proc `julian=`*(self: Date; julianDate: int) =
  g_date_set_julian(cast[ptr Date00](self.impl), uint32(julianDate))

proc g_date_set_parse*(self: ptr Date00; str: cstring) {.
    importc: "g_date_set_parse", libprag.}

proc setParse*(self: Date; str: string) =
  g_date_set_parse(cast[ptr Date00](self.impl), cstring(str))

proc `parse=`*(self: Date; str: string) =
  g_date_set_parse(cast[ptr Date00](self.impl), cstring(str))

proc g_date_set_time*(self: ptr Date00; time: int32) {.
    importc: "g_date_set_time", libprag.}

proc setTime*(self: Date; time: int) =
  g_date_set_time(cast[ptr Date00](self.impl), int32(time))

proc `time=`*(self: Date; time: int) =
  g_date_set_time(cast[ptr Date00](self.impl), int32(time))

proc g_date_set_time_t*(self: ptr Date00; timet: int64) {.
    importc: "g_date_set_time_t", libprag.}

proc setTimeT*(self: Date; timet: int64) =
  g_date_set_time_t(cast[ptr Date00](self.impl), timet)

proc `timeT=`*(self: Date; timet: int64) =
  g_date_set_time_t(cast[ptr Date00](self.impl), timet)

proc g_date_set_time_val*(self: ptr Date00; timeval: ptr TimeVal00) {.
    importc: "g_date_set_time_val", libprag.}

proc setTimeVal*(self: Date; timeval: TimeVal) =
  g_date_set_time_val(cast[ptr Date00](self.impl), cast[ptr TimeVal00](timeval.impl))

proc `timeVal=`*(self: Date; timeval: TimeVal) =
  g_date_set_time_val(cast[ptr Date00](self.impl), cast[ptr TimeVal00](timeval.impl))

proc g_date_set_year*(self: ptr Date00; year: uint16) {.
    importc: "g_date_set_year", libprag.}

proc setYear*(self: Date; year: uint16) =
  g_date_set_year(cast[ptr Date00](self.impl), year)

proc `year=`*(self: Date; year: uint16) =
  g_date_set_year(cast[ptr Date00](self.impl), year)

proc g_date_subtract_days*(self: ptr Date00; nDays: uint32) {.
    importc: "g_date_subtract_days", libprag.}

proc subtractDays*(self: Date; nDays: int) =
  g_date_subtract_days(cast[ptr Date00](self.impl), uint32(nDays))

proc g_date_subtract_months*(self: ptr Date00; nMonths: uint32) {.
    importc: "g_date_subtract_months", libprag.}

proc subtractMonths*(self: Date; nMonths: int) =
  g_date_subtract_months(cast[ptr Date00](self.impl), uint32(nMonths))

proc g_date_subtract_years*(self: ptr Date00; nYears: uint32) {.
    importc: "g_date_subtract_years", libprag.}

proc subtractYears*(self: Date; nYears: int) =
  g_date_subtract_years(cast[ptr Date00](self.impl), uint32(nYears))

proc g_date_to_struct_tm*(self: ptr Date00; tm: pointer) {.
    importc: "g_date_to_struct_tm", libprag.}

proc toStructTm*(self: Date; tm: pointer) =
  g_date_to_struct_tm(cast[ptr Date00](self.impl), tm)

proc g_date_valid*(self: ptr Date00): gboolean {.
    importc: "g_date_valid", libprag.}

proc valid*(self: Date): bool =
  toBool(g_date_valid(cast[ptr Date00](self.impl)))

proc g_date_get_monday_weeks_in_year*(year: uint16): uint8 {.
    importc: "g_date_get_monday_weeks_in_year", libprag.}

proc getMondayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_monday_weeks_in_year", libprag.}

proc mondayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_monday_weeks_in_year", libprag.}

proc g_date_get_sunday_weeks_in_year*(year: uint16): uint8 {.
    importc: "g_date_get_sunday_weeks_in_year", libprag.}

proc getSundayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_sunday_weeks_in_year", libprag.}

proc sundayWeeksInYear*(year: uint16): uint8 {.
    importc: "g_date_get_sunday_weeks_in_year", libprag.}

proc g_date_is_leap_year*(year: uint16): gboolean {.
    importc: "g_date_is_leap_year", libprag.}

proc isLeapYear*(year: uint16): gboolean {.
    importc: "g_date_is_leap_year", libprag.}

proc g_date_strftime*(s: cstring; slen: uint64; format: cstring; date: ptr Date00): uint64 {.
    importc: "g_date_strftime", libprag.}

proc strftime*(s: string; slen: uint64; format: string; date: Date): uint64 =
  g_date_strftime(cstring(s), slen, cstring(format), cast[ptr Date00](date.impl))

proc g_date_valid_day*(day: uint8): gboolean {.
    importc: "g_date_valid_day", libprag.}

proc validDay*(day: uint8): gboolean {.
    importc: "g_date_valid_day", libprag.}

proc g_date_valid_julian*(julianDate: uint32): gboolean {.
    importc: "g_date_valid_julian", libprag.}

proc validJulian*(julianDate: uint32): gboolean {.
    importc: "g_date_valid_julian", libprag.}

proc g_date_valid_year*(year: uint16): gboolean {.
    importc: "g_date_valid_year", libprag.}

proc validYear*(year: uint16): gboolean {.
    importc: "g_date_valid_year", libprag.}

type
  DateMonth* {.size: sizeof(cint), pure.} = enum
    badMonth = 0
    january = 1
    february = 2
    march = 3
    april = 4
    may = 5
    june = 6
    july = 7
    august = 8
    september = 9
    october = 10
    november = 11
    december = 12

proc g_date_new_dmy*(day: uint8; month: DateMonth; year: uint16): ptr Date00 {.
    importc: "g_date_new_dmy", libprag.}

proc newDateDmy*(day: uint8; month: DateMonth; year: uint16): Date =
  new(result)
  result.impl = g_date_new_dmy(day, month, year)

proc initDateDmy*[T](result: var T; day: uint8; month: DateMonth; year: uint16) =
  assert(result is Date)
  new(result)
  result.impl = g_date_new_dmy(day, month, year)

proc g_date_get_month*(self: ptr Date00): DateMonth {.
    importc: "g_date_get_month", libprag.}

proc getMonth*(self: Date): DateMonth =
  g_date_get_month(cast[ptr Date00](self.impl))

proc month*(self: Date): DateMonth =
  g_date_get_month(cast[ptr Date00](self.impl))

proc g_date_set_dmy*(self: ptr Date00; day: uint8; month: DateMonth; y: uint16) {.
    importc: "g_date_set_dmy", libprag.}

proc setDmy*(self: Date; day: uint8; month: DateMonth; y: uint16) =
  g_date_set_dmy(cast[ptr Date00](self.impl), day, month, y)

proc g_date_set_month*(self: ptr Date00; month: DateMonth) {.
    importc: "g_date_set_month", libprag.}

proc setMonth*(self: Date; month: DateMonth) =
  g_date_set_month(cast[ptr Date00](self.impl), month)

proc `month=`*(self: Date; month: DateMonth) =
  g_date_set_month(cast[ptr Date00](self.impl), month)

proc g_date_get_days_in_month*(month: DateMonth; year: uint16): uint8 {.
    importc: "g_date_get_days_in_month", libprag.}

proc getDaysInMonth*(month: DateMonth; year: uint16): uint8 {.
    importc: "g_date_get_days_in_month", libprag.}

proc daysInMonth*(month: DateMonth; year: uint16): uint8 {.
    importc: "g_date_get_days_in_month", libprag.}

proc g_date_valid_dmy*(day: uint8; month: DateMonth; year: uint16): gboolean {.
    importc: "g_date_valid_dmy", libprag.}

proc validDmy*(day: uint8; month: DateMonth; year: uint16): gboolean {.
    importc: "g_date_valid_dmy", libprag.}

proc g_date_valid_month*(month: DateMonth): gboolean {.
    importc: "g_date_valid_month", libprag.}

proc validMonth*(month: DateMonth): gboolean {.
    importc: "g_date_valid_month", libprag.}

type
  DateWeekday* {.size: sizeof(cint), pure.} = enum
    badWeekday = 0
    monday = 1
    tuesday = 2
    wednesday = 3
    thursday = 4
    friday = 5
    saturday = 6
    sunday = 7

proc g_date_get_weekday*(self: ptr Date00): DateWeekday {.
    importc: "g_date_get_weekday", libprag.}

proc getWeekday*(self: Date): DateWeekday =
  g_date_get_weekday(cast[ptr Date00](self.impl))

proc weekday*(self: Date): DateWeekday =
  g_date_get_weekday(cast[ptr Date00](self.impl))

proc g_date_valid_weekday*(weekday: DateWeekday): gboolean {.
    importc: "g_date_valid_weekday", libprag.}

proc validWeekday*(weekday: DateWeekday): gboolean {.
    importc: "g_date_valid_weekday", libprag.}

type
  DateDMY* {.size: sizeof(cint), pure.} = enum
    day = 0
    month = 1
    year = 2

type
  DateTime00* {.pure.} = object
  DateTime* = ref object
    impl*: ptr DateTime00

proc g_date_time_new_from_timeval_local*(tv: ptr TimeVal00): ptr DateTime00 {.
    importc: "g_date_time_new_from_timeval_local", libprag.}

proc newDateTimeFromTimevalLocal*(tv: TimeVal): DateTime =
  new(result)
  result.impl = g_date_time_new_from_timeval_local(cast[ptr TimeVal00](tv.impl))

proc initDateTimeFromTimevalLocal*[T](result: var T; tv: TimeVal) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_from_timeval_local(cast[ptr TimeVal00](tv.impl))

proc g_date_time_new_from_timeval_utc*(tv: ptr TimeVal00): ptr DateTime00 {.
    importc: "g_date_time_new_from_timeval_utc", libprag.}

proc newDateTimeFromTimevalUtc*(tv: TimeVal): DateTime =
  new(result)
  result.impl = g_date_time_new_from_timeval_utc(cast[ptr TimeVal00](tv.impl))

proc initDateTimeFromTimevalUtc*[T](result: var T; tv: TimeVal) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_from_timeval_utc(cast[ptr TimeVal00](tv.impl))

proc g_date_time_new_from_unix_local*(t: int64): ptr DateTime00 {.
    importc: "g_date_time_new_from_unix_local", libprag.}

proc newDateTimeFromUnixLocal*(t: int64): DateTime =
  new(result)
  result.impl = g_date_time_new_from_unix_local(t)

proc initDateTimeFromUnixLocal*[T](result: var T; t: int64) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_from_unix_local(t)

proc g_date_time_new_from_unix_utc*(t: int64): ptr DateTime00 {.
    importc: "g_date_time_new_from_unix_utc", libprag.}

proc newDateTimeFromUnixUtc*(t: int64): DateTime =
  new(result)
  result.impl = g_date_time_new_from_unix_utc(t)

proc initDateTimeFromUnixUtc*[T](result: var T; t: int64) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_from_unix_utc(t)

proc g_date_time_new_local*(year: int32; month: int32; day: int32; hour: int32; 
    minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc: "g_date_time_new_local", libprag.}

proc newDateTimeLocal*(year: int; month: int; day: int; hour: int; minute: int; 
    seconds: cdouble): DateTime =
  new(result)
  result.impl = g_date_time_new_local(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc initDateTimeLocal*[T](result: var T; year: int; month: int; day: int; hour: int; minute: int; 
    seconds: cdouble) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_local(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc g_date_time_new_now_local*(): ptr DateTime00 {.
    importc: "g_date_time_new_now_local", libprag.}

proc newDateTimeNowLocal*(): DateTime =
  new(result)
  result.impl = g_date_time_new_now_local()

proc initDateTimeNowLocal*[T](result: var T) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_now_local()

proc g_date_time_new_now_utc*(): ptr DateTime00 {.
    importc: "g_date_time_new_now_utc", libprag.}

proc newDateTimeNowUtc*(): DateTime =
  new(result)
  result.impl = g_date_time_new_now_utc()

proc initDateTimeNowUtc*[T](result: var T) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_now_utc()

proc g_date_time_new_utc*(year: int32; month: int32; day: int32; hour: int32; 
    minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc: "g_date_time_new_utc", libprag.}

proc newDateTimeUtc*(year: int; month: int; day: int; hour: int; minute: int; 
    seconds: cdouble): DateTime =
  new(result)
  result.impl = g_date_time_new_utc(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc initDateTimeUtc*[T](result: var T; year: int; month: int; day: int; hour: int; minute: int; 
    seconds: cdouble) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_utc(int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc g_date_time_add*(self: ptr DateTime00; timespan: int64): ptr DateTime00 {.
    importc: "g_date_time_add", libprag.}

proc add*(self: DateTime; timespan: int64): DateTime =
  new(result)
  result.impl = g_date_time_add(cast[ptr DateTime00](self.impl), timespan)

proc g_date_time_add_days*(self: ptr DateTime00; days: int32): ptr DateTime00 {.
    importc: "g_date_time_add_days", libprag.}

proc addDays*(self: DateTime; days: int): DateTime =
  new(result)
  result.impl = g_date_time_add_days(cast[ptr DateTime00](self.impl), int32(days))

proc g_date_time_add_full*(self: ptr DateTime00; years: int32; months: int32; 
    days: int32; hours: int32; minutes: int32; seconds: cdouble): ptr DateTime00 {.
    importc: "g_date_time_add_full", libprag.}

proc addFull*(self: DateTime; years: int; months: int; days: int; 
    hours: int; minutes: int; seconds: cdouble): DateTime =
  new(result)
  result.impl = g_date_time_add_full(cast[ptr DateTime00](self.impl), int32(years), int32(months), int32(days), int32(hours), int32(minutes), seconds)

proc g_date_time_add_hours*(self: ptr DateTime00; hours: int32): ptr DateTime00 {.
    importc: "g_date_time_add_hours", libprag.}

proc addHours*(self: DateTime; hours: int): DateTime =
  new(result)
  result.impl = g_date_time_add_hours(cast[ptr DateTime00](self.impl), int32(hours))

proc g_date_time_add_minutes*(self: ptr DateTime00; minutes: int32): ptr DateTime00 {.
    importc: "g_date_time_add_minutes", libprag.}

proc addMinutes*(self: DateTime; minutes: int): DateTime =
  new(result)
  result.impl = g_date_time_add_minutes(cast[ptr DateTime00](self.impl), int32(minutes))

proc g_date_time_add_months*(self: ptr DateTime00; months: int32): ptr DateTime00 {.
    importc: "g_date_time_add_months", libprag.}

proc addMonths*(self: DateTime; months: int): DateTime =
  new(result)
  result.impl = g_date_time_add_months(cast[ptr DateTime00](self.impl), int32(months))

proc g_date_time_add_seconds*(self: ptr DateTime00; seconds: cdouble): ptr DateTime00 {.
    importc: "g_date_time_add_seconds", libprag.}

proc addSeconds*(self: DateTime; seconds: cdouble): DateTime =
  new(result)
  result.impl = g_date_time_add_seconds(cast[ptr DateTime00](self.impl), seconds)

proc g_date_time_add_weeks*(self: ptr DateTime00; weeks: int32): ptr DateTime00 {.
    importc: "g_date_time_add_weeks", libprag.}

proc addWeeks*(self: DateTime; weeks: int): DateTime =
  new(result)
  result.impl = g_date_time_add_weeks(cast[ptr DateTime00](self.impl), int32(weeks))

proc g_date_time_add_years*(self: ptr DateTime00; years: int32): ptr DateTime00 {.
    importc: "g_date_time_add_years", libprag.}

proc addYears*(self: DateTime; years: int): DateTime =
  new(result)
  result.impl = g_date_time_add_years(cast[ptr DateTime00](self.impl), int32(years))

proc g_date_time_difference*(self: ptr DateTime00; begin: ptr DateTime00): int64 {.
    importc: "g_date_time_difference", libprag.}

proc difference*(self: DateTime; begin: DateTime): int64 =
  g_date_time_difference(cast[ptr DateTime00](self.impl), cast[ptr DateTime00](begin.impl))

proc g_date_time_format*(self: ptr DateTime00; format: cstring): cstring {.
    importc: "g_date_time_format", libprag.}

proc format*(self: DateTime; format: string): string =
  let resul0 = g_date_time_format(cast[ptr DateTime00](self.impl), cstring(format))
  result = $resul0
  cogfree(resul0)

proc g_date_time_get_day_of_month*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_day_of_month", libprag.}

proc getDayOfMonth*(self: DateTime): int =
  int(g_date_time_get_day_of_month(cast[ptr DateTime00](self.impl)))

proc dayOfMonth*(self: DateTime): int =
  int(g_date_time_get_day_of_month(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_day_of_week*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_day_of_week", libprag.}

proc getDayOfWeek*(self: DateTime): int =
  int(g_date_time_get_day_of_week(cast[ptr DateTime00](self.impl)))

proc dayOfWeek*(self: DateTime): int =
  int(g_date_time_get_day_of_week(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_day_of_year*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_day_of_year", libprag.}

proc getDayOfYear*(self: DateTime): int =
  int(g_date_time_get_day_of_year(cast[ptr DateTime00](self.impl)))

proc dayOfYear*(self: DateTime): int =
  int(g_date_time_get_day_of_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_hour*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_hour", libprag.}

proc getHour*(self: DateTime): int =
  int(g_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc hour*(self: DateTime): int =
  int(g_date_time_get_hour(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_microsecond*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_microsecond", libprag.}

proc getMicrosecond*(self: DateTime): int =
  int(g_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc microsecond*(self: DateTime): int =
  int(g_date_time_get_microsecond(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_minute*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_minute", libprag.}

proc getMinute*(self: DateTime): int =
  int(g_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc minute*(self: DateTime): int =
  int(g_date_time_get_minute(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_month*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_month", libprag.}

proc getMonth*(self: DateTime): int =
  int(g_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc month*(self: DateTime): int =
  int(g_date_time_get_month(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_second*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_second", libprag.}

proc getSecond*(self: DateTime): int =
  int(g_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc second*(self: DateTime): int =
  int(g_date_time_get_second(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_seconds*(self: ptr DateTime00): cdouble {.
    importc: "g_date_time_get_seconds", libprag.}

proc getSeconds*(self: DateTime): cdouble =
  g_date_time_get_seconds(cast[ptr DateTime00](self.impl))

proc seconds*(self: DateTime): cdouble =
  g_date_time_get_seconds(cast[ptr DateTime00](self.impl))

proc g_date_time_get_timezone_abbreviation*(self: ptr DateTime00): cstring {.
    importc: "g_date_time_get_timezone_abbreviation", libprag.}

proc getTimezoneAbbreviation*(self: DateTime): string =
  let resul0 = g_date_time_get_timezone_abbreviation(cast[ptr DateTime00](self.impl))
  result = $resul0

proc timezoneAbbreviation*(self: DateTime): string =
  let resul0 = g_date_time_get_timezone_abbreviation(cast[ptr DateTime00](self.impl))
  result = $resul0

proc g_date_time_get_utc_offset*(self: ptr DateTime00): int64 {.
    importc: "g_date_time_get_utc_offset", libprag.}

proc getUtcOffset*(self: DateTime): int64 =
  g_date_time_get_utc_offset(cast[ptr DateTime00](self.impl))

proc utcOffset*(self: DateTime): int64 =
  g_date_time_get_utc_offset(cast[ptr DateTime00](self.impl))

proc g_date_time_get_week_numbering_year*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_week_numbering_year", libprag.}

proc getWeekNumberingYear*(self: DateTime): int =
  int(g_date_time_get_week_numbering_year(cast[ptr DateTime00](self.impl)))

proc weekNumberingYear*(self: DateTime): int =
  int(g_date_time_get_week_numbering_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_week_of_year*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_week_of_year", libprag.}

proc getWeekOfYear*(self: DateTime): int =
  int(g_date_time_get_week_of_year(cast[ptr DateTime00](self.impl)))

proc weekOfYear*(self: DateTime): int =
  int(g_date_time_get_week_of_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_year*(self: ptr DateTime00): int32 {.
    importc: "g_date_time_get_year", libprag.}

proc getYear*(self: DateTime): int =
  int(g_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc year*(self: DateTime): int =
  int(g_date_time_get_year(cast[ptr DateTime00](self.impl)))

proc g_date_time_get_ymd*(self: ptr DateTime00; year: var int32; month: var int32; 
    day: var int32) {.
    importc: "g_date_time_get_ymd", libprag.}

proc getYmd*(self: DateTime; year: var int; month: var int; day: var int) =
  var day_00 = int32(day)
  var month_00 = int32(month)
  var year_00 = int32(year)
  g_date_time_get_ymd(cast[ptr DateTime00](self.impl), year_00, month_00, day_00)
  day = int(day_00)
  month = int(month_00)
  year = int(year_00)

proc ymd*(self: DateTime; year: var int; month: var int; day: var int) =
  var day_00 = int32(day)
  var month_00 = int32(month)
  var year_00 = int32(year)
  g_date_time_get_ymd(cast[ptr DateTime00](self.impl), year_00, month_00, day_00)
  day = int(day_00)
  month = int(month_00)
  year = int(year_00)

proc g_date_time_is_daylight_savings*(self: ptr DateTime00): gboolean {.
    importc: "g_date_time_is_daylight_savings", libprag.}

proc isDaylightSavings*(self: DateTime): bool =
  toBool(g_date_time_is_daylight_savings(cast[ptr DateTime00](self.impl)))

proc g_date_time_ref*(self: ptr DateTime00): ptr DateTime00 {.
    importc: "g_date_time_ref", libprag.}

proc `ref`*(self: DateTime): DateTime =
  new(result)
  result.impl = g_date_time_ref(cast[ptr DateTime00](self.impl))

proc g_date_time_to_local*(self: ptr DateTime00): ptr DateTime00 {.
    importc: "g_date_time_to_local", libprag.}

proc toLocal*(self: DateTime): DateTime =
  new(result)
  result.impl = g_date_time_to_local(cast[ptr DateTime00](self.impl))

proc g_date_time_to_timeval*(self: ptr DateTime00; tv: ptr TimeVal00): gboolean {.
    importc: "g_date_time_to_timeval", libprag.}

proc toTimeval*(self: DateTime; tv: TimeVal): bool =
  toBool(g_date_time_to_timeval(cast[ptr DateTime00](self.impl), cast[ptr TimeVal00](tv.impl)))

proc g_date_time_to_unix*(self: ptr DateTime00): int64 {.
    importc: "g_date_time_to_unix", libprag.}

proc toUnix*(self: DateTime): int64 =
  g_date_time_to_unix(cast[ptr DateTime00](self.impl))

proc g_date_time_to_utc*(self: ptr DateTime00): ptr DateTime00 {.
    importc: "g_date_time_to_utc", libprag.}

proc toUtc*(self: DateTime): DateTime =
  new(result)
  result.impl = g_date_time_to_utc(cast[ptr DateTime00](self.impl))

proc g_date_time_unref*(self: ptr DateTime00) {.
    importc: "g_date_time_unref", libprag.}

proc unref*(self: DateTime) =
  g_date_time_unref(cast[ptr DateTime00](self.impl))

proc g_date_time_compare*(dt1: pointer; dt2: pointer): int32 {.
    importc: "g_date_time_compare", libprag.}

proc compare*(dt1: pointer; dt2: pointer): int32 {.
    importc: "g_date_time_compare", libprag.}

proc g_date_time_equal*(dt1: pointer; dt2: pointer): gboolean {.
    importc: "g_date_time_equal", libprag.}

proc equal*(dt1: pointer; dt2: pointer): gboolean {.
    importc: "g_date_time_equal", libprag.}

proc g_date_time_hash*(datetime: pointer): uint32 {.
    importc: "g_date_time_hash", libprag.}

proc hash*(datetime: pointer): uint32 {.
    importc: "g_date_time_hash", libprag.}

type
  TimeZone00* {.pure.} = object
  TimeZone* = ref object
    impl*: ptr TimeZone00

proc g_time_zone_new*(identifier: cstring): ptr TimeZone00 {.
    importc: "g_time_zone_new", libprag.}

proc newTimeZone*(identifier: string): TimeZone =
  new(result)
  result.impl = g_time_zone_new(cstring(identifier))

proc initTimeZone*[T](result: var T; identifier: string) =
  assert(result is TimeZone)
  new(result)
  result.impl = g_time_zone_new(cstring(identifier))

proc g_time_zone_new_local*(): ptr TimeZone00 {.
    importc: "g_time_zone_new_local", libprag.}

proc newTimeZoneLocal*(): TimeZone =
  new(result)
  result.impl = g_time_zone_new_local()

proc initTimeZoneLocal*[T](result: var T) =
  assert(result is TimeZone)
  new(result)
  result.impl = g_time_zone_new_local()

proc g_time_zone_new_utc*(): ptr TimeZone00 {.
    importc: "g_time_zone_new_utc", libprag.}

proc newTimeZoneUtc*(): TimeZone =
  new(result)
  result.impl = g_time_zone_new_utc()

proc initTimeZoneUtc*[T](result: var T) =
  assert(result is TimeZone)
  new(result)
  result.impl = g_time_zone_new_utc()

proc g_time_zone_get_abbreviation*(self: ptr TimeZone00; interval: int32): cstring {.
    importc: "g_time_zone_get_abbreviation", libprag.}

proc getAbbreviation*(self: TimeZone; interval: int): string =
  let resul0 = g_time_zone_get_abbreviation(cast[ptr TimeZone00](self.impl), int32(interval))
  result = $resul0

proc abbreviation*(self: TimeZone; interval: int): string =
  let resul0 = g_time_zone_get_abbreviation(cast[ptr TimeZone00](self.impl), int32(interval))
  result = $resul0

proc g_time_zone_get_offset*(self: ptr TimeZone00; interval: int32): int32 {.
    importc: "g_time_zone_get_offset", libprag.}

proc getOffset*(self: TimeZone; interval: int): int =
  int(g_time_zone_get_offset(cast[ptr TimeZone00](self.impl), int32(interval)))

proc offset*(self: TimeZone; interval: int): int =
  int(g_time_zone_get_offset(cast[ptr TimeZone00](self.impl), int32(interval)))

proc g_time_zone_is_dst*(self: ptr TimeZone00; interval: int32): gboolean {.
    importc: "g_time_zone_is_dst", libprag.}

proc isDst*(self: TimeZone; interval: int): bool =
  toBool(g_time_zone_is_dst(cast[ptr TimeZone00](self.impl), int32(interval)))

proc g_time_zone_ref*(self: ptr TimeZone00): ptr TimeZone00 {.
    importc: "g_time_zone_ref", libprag.}

proc `ref`*(self: TimeZone): TimeZone =
  new(result)
  result.impl = g_time_zone_ref(cast[ptr TimeZone00](self.impl))

proc g_time_zone_unref*(self: ptr TimeZone00) {.
    importc: "g_time_zone_unref", libprag.}

proc unref*(self: TimeZone) =
  g_time_zone_unref(cast[ptr TimeZone00](self.impl))

proc g_date_time_new*(tz: ptr TimeZone00; year: int32; month: int32; day: int32; 
    hour: int32; minute: int32; seconds: cdouble): ptr DateTime00 {.
    importc: "g_date_time_new", libprag.}

proc newDateTime*(tz: TimeZone; year: int; month: int; day: int; hour: int; 
    minute: int; seconds: cdouble): DateTime =
  new(result)
  result.impl = g_date_time_new(cast[ptr TimeZone00](tz.impl), int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc initDateTime*[T](result: var T; tz: TimeZone; year: int; month: int; day: int; hour: int; 
    minute: int; seconds: cdouble) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new(cast[ptr TimeZone00](tz.impl), int32(year), int32(month), int32(day), int32(hour), int32(minute), seconds)

proc g_date_time_new_now*(tz: ptr TimeZone00): ptr DateTime00 {.
    importc: "g_date_time_new_now", libprag.}

proc newDateTimeNow*(tz: TimeZone): DateTime =
  new(result)
  result.impl = g_date_time_new_now(cast[ptr TimeZone00](tz.impl))

proc initDateTimeNow*[T](result: var T; tz: TimeZone) =
  assert(result is DateTime)
  new(result)
  result.impl = g_date_time_new_now(cast[ptr TimeZone00](tz.impl))

proc g_date_time_to_timezone*(self: ptr DateTime00; tz: ptr TimeZone00): ptr DateTime00 {.
    importc: "g_date_time_to_timezone", libprag.}

proc toTimezone*(self: DateTime; tz: TimeZone): DateTime =
  new(result)
  result.impl = g_date_time_to_timezone(cast[ptr DateTime00](self.impl), cast[ptr TimeZone00](tz.impl))

type
  TimeType* {.size: sizeof(cint), pure.} = enum
    standard = 0
    daylight = 1
    universal = 2

proc g_time_zone_adjust_time*(self: ptr TimeZone00; `type`: TimeType; time: ptr int64): int32 {.
    importc: "g_time_zone_adjust_time", libprag.}

proc adjustTime*(self: TimeZone; `type`: TimeType; time: ptr int64): int =
  int(g_time_zone_adjust_time(cast[ptr TimeZone00](self.impl), `type`, time))

proc g_time_zone_find_interval*(self: ptr TimeZone00; `type`: TimeType; time: int64): int32 {.
    importc: "g_time_zone_find_interval", libprag.}

proc findInterval*(self: TimeZone; `type`: TimeType; time: int64): int =
  int(g_time_zone_find_interval(cast[ptr TimeZone00](self.impl), `type`, time))

type
  DebugKey00* {.pure.} = object
    key*: cstring
    value*: uint32
  DebugKey* = ref object
    impl*: ptr DebugKey00

type
  DestroyNotify* = proc (data: pointer) {.cdecl.}

type
  Dir00* {.pure.} = object
  Dir* = ref object
    impl*: ptr Dir00

proc g_dir_close*(self: ptr Dir00) {.
    importc: "g_dir_close", libprag.}

proc close*(self: Dir) =
  g_dir_close(cast[ptr Dir00](self.impl))

proc g_dir_read_name*(self: ptr Dir00): ucstring {.
    importc: "g_dir_read_name", libprag.}

proc readName*(self: Dir): ucstring =
  g_dir_read_name(cast[ptr Dir00](self.impl))

proc g_dir_rewind*(self: ptr Dir00) {.
    importc: "g_dir_rewind", libprag.}

proc rewind*(self: Dir) =
  g_dir_rewind(cast[ptr Dir00](self.impl))

proc g_dir_make_tmp*(tmpl: ucstring): ucstring {.
    importc: "g_dir_make_tmp", libprag.}

proc makeTmp*(tmpl: ucstring): ucstring {.
    importc: "g_dir_make_tmp", libprag.}

type
  DoubleIEEE75400* = object {.union.}
    vDouble*: cdouble
  DoubleIEEE754* = ref object
    impl*: ptr DoubleIEEE75400

type
  DuplicateFunc* = proc (data: pointer; userData: pointer): pointer {.cdecl.}

const E* = 2.718282'f64

type
  EqualFunc* = proc (a: pointer; b: pointer): gboolean {.cdecl.}

type
  Error00* {.pure.} = object
    domain*: uint32
    code*: int32
    message*: cstring
  Error* = ref object
    impl*: ptr Error00

proc g_error_new_literal*(domain: uint32; code: int32; message: cstring): ptr Error00 {.
    importc: "g_error_new_literal", libprag.}

proc newLiteral*(domain: uint32; code: int32; message: cstring): ptr Error00 {.
    importc: "g_error_new_literal", libprag.}

proc g_error_copy*(self: ptr Error00): ptr Error00 {.
    importc: "g_error_copy", libprag.}

proc copy*(self: Error): ptr Error00 =
  g_error_copy(cast[ptr Error00](self.impl))

proc g_error_free*(self: ptr Error00) {.
    importc: "g_error_free", libprag.}

proc free*(self: Error) =
  g_error_free(cast[ptr Error00](self.impl))

proc g_error_matches*(self: ptr Error00; domain: uint32; code: int32): gboolean {.
    importc: "g_error_matches", libprag.}

proc matches*(self: Error; domain: int; code: int): bool =
  toBool(g_error_matches(cast[ptr Error00](self.impl), uint32(domain), int32(code)))

type
  ErrorType* {.size: sizeof(cint), pure.} = enum
    unknown = 0
    unexpEof = 1
    unexpEofInString = 2
    unexpEofInComment = 3
    nonDigitInConst = 4
    digitRadix = 5
    floatRadix = 6
    floatMalformed = 7

type
  FileError* {.size: sizeof(cint), pure.} = enum
    exist = 0
    isdir = 1
    acces = 2
    nametoolong = 3
    noent = 4
    notdir = 5
    nxio = 6
    nodev = 7
    rofs = 8
    txtbsy = 9
    fault = 10
    loop = 11
    nospc = 12
    nomem = 13
    mfile = 14
    nfile = 15
    badf = 16
    inval = 17
    pipe = 18
    again = 19
    intr = 20
    io = 21
    perm = 22
    nosys = 23
    failed = 24

type
  FileTest* {.size: sizeof(cint), pure.} = enum
    isRegular = 1
    isSymlink = 2
    isDir = 4
    isExecutable = 8
    exists = 16

type
  FloatIEEE75400* = object {.union.}
    vFloat*: cfloat
  FloatIEEE754* = ref object
    impl*: ptr FloatIEEE75400

type
  FormatSizeFlag* {.size: sizeof(cint), pure.} = enum
    longFormat = 1
    iecUnits = 2

  FormatSizeFlags* {.size: sizeof(cint).} = set[FormatSizeFlag]

type
  FreeFunc* = proc (data: pointer) {.cdecl.}

type
  Func* = proc (data: pointer; userData: pointer) {.cdecl.}

const GINT16_FORMAT* = "hi"

const GINT16_MODIFIER* = "h"

const GINT32_FORMAT* = "i"

const GINT32_MODIFIER* = ""

const GINT64_FORMAT* = "li"

const GINT64_MODIFIER* = "l"

const GINTPTR_FORMAT* = "li"

const GINTPTR_MODIFIER* = "l"

const GNUC_FUNCTION* = ""

const GNUC_PRETTY_FUNCTION* = ""

const GSIZE_FORMAT* = "lu"

const GSIZE_MODIFIER* = "l"

const GSSIZE_FORMAT* = "li"

const GSSIZE_MODIFIER* = "l"

const GUINT16_FORMAT* = "hu"

const GUINT32_FORMAT* = "u"

const GUINT64_FORMAT* = "lu"

const GUINTPTR_FORMAT* = "lu"

const HAVE_GINT64* = 1'i32

const HAVE_GNUC_VARARGS* = 1'i32

const HAVE_GNUC_VISIBILITY* = 1'i32

const HAVE_GROWING_STACK* = 0'i32

const HAVE_ISO_VARARGS* = 1'i32

type
  HFunc* = proc (key: pointer; value: pointer; userData: pointer) {.cdecl.}

const HOOK_FLAG_USER_SHIFT* = 4'i32

type
  HRFunc* = proc (key: pointer; value: pointer; userData: pointer): gboolean {.cdecl.}

type
  HashFunc* = proc (key: pointer): uint32 {.cdecl.}

type
  HashTable00* {.pure.} = object
  HashTable* = ref object
    impl*: ptr HashTable00

proc g_hash_table_add*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_add", libprag.}

proc add*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_add", libprag.}

proc g_hash_table_contains*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_contains", libprag.}

proc contains*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_contains", libprag.}

proc g_hash_table_destroy*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_destroy", libprag.}

proc destroy*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_destroy", libprag.}

proc g_hash_table_insert*(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc: "g_hash_table_insert", libprag.}

proc insert*(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc: "g_hash_table_insert", libprag.}

proc g_hash_table_lookup*(hashTable: ptr HashTable00; key: pointer): pointer {.
    importc: "g_hash_table_lookup", libprag.}

proc lookup*(hashTable: ptr HashTable00; key: pointer): pointer {.
    importc: "g_hash_table_lookup", libprag.}

proc g_hash_table_lookup_extended*(hashTable: ptr HashTable00; lookupKey: pointer; origKey: var pointer; 
    value: var pointer): gboolean {.
    importc: "g_hash_table_lookup_extended", libprag.}

proc lookupExtended*(hashTable: ptr HashTable00; lookupKey: pointer; origKey: var pointer; 
    value: var pointer): gboolean {.
    importc: "g_hash_table_lookup_extended", libprag.}

proc g_hash_table_remove*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_remove", libprag.}

proc remove*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_remove", libprag.}

proc g_hash_table_remove_all*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_remove_all", libprag.}

proc removeAll*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_remove_all", libprag.}

proc g_hash_table_replace*(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc: "g_hash_table_replace", libprag.}

proc replace*(hashTable: ptr HashTable00; key: pointer; value: pointer): gboolean {.
    importc: "g_hash_table_replace", libprag.}

proc g_hash_table_size*(hashTable: ptr HashTable00): uint32 {.
    importc: "g_hash_table_size", libprag.}

proc size*(hashTable: ptr HashTable00): uint32 {.
    importc: "g_hash_table_size", libprag.}

proc g_hash_table_steal*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_steal", libprag.}

proc steal*(hashTable: ptr HashTable00; key: pointer): gboolean {.
    importc: "g_hash_table_steal", libprag.}

proc g_hash_table_steal_all*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_steal_all", libprag.}

proc stealAll*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_steal_all", libprag.}

proc g_hash_table_unref*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_unref", libprag.}

proc unref*(hashTable: ptr HashTable00) {.
    importc: "g_hash_table_unref", libprag.}

type
  HashTableIter00* {.pure.} = object
    dummy1*: pointer
    dummy2*: pointer
    dummy3*: pointer
    dummy4*: int32
    dummy5*: gboolean
    dummy6*: pointer
  HashTableIter* = ref object
    impl*: ptr HashTableIter00

proc g_hash_table_iter_init*(self: ptr HashTableIter00; hashTable: ptr HashTable00) {.
    importc: "g_hash_table_iter_init", libprag.}

proc init*(self: HashTableIter; hashTable: ptr HashTable00) =
  g_hash_table_iter_init(cast[ptr HashTableIter00](self.impl), hashTable)

proc g_hash_table_iter_next*(self: ptr HashTableIter00; key: var pointer; value: var pointer): gboolean {.
    importc: "g_hash_table_iter_next", libprag.}

proc next*(self: HashTableIter; key: var pointer; value: var pointer): bool =
  toBool(g_hash_table_iter_next(cast[ptr HashTableIter00](self.impl), key, value))

proc g_hash_table_iter_remove*(self: ptr HashTableIter00) {.
    importc: "g_hash_table_iter_remove", libprag.}

proc remove*(self: HashTableIter) =
  g_hash_table_iter_remove(cast[ptr HashTableIter00](self.impl))

proc g_hash_table_iter_replace*(self: ptr HashTableIter00; value: pointer) {.
    importc: "g_hash_table_iter_replace", libprag.}

proc replace*(self: HashTableIter; value: pointer) =
  g_hash_table_iter_replace(cast[ptr HashTableIter00](self.impl), value)

proc g_hash_table_iter_steal*(self: ptr HashTableIter00) {.
    importc: "g_hash_table_iter_steal", libprag.}

proc steal*(self: HashTableIter) =
  g_hash_table_iter_steal(cast[ptr HashTableIter00](self.impl))

type
  Hmac00* {.pure.} = object
  Hmac* = ref object
    impl*: ptr Hmac00

proc g_hmac_get_digest*(self: ptr Hmac00; buffer: ptr uint8; digestLen: ptr uint64) {.
    importc: "g_hmac_get_digest", libprag.}

proc getDigest*(self: Hmac; buffer: ptr uint8; digestLen: ptr uint64) =
  g_hmac_get_digest(cast[ptr Hmac00](self.impl), buffer, digestLen)

proc digest*(self: Hmac; buffer: ptr uint8; digestLen: ptr uint64) =
  g_hmac_get_digest(cast[ptr Hmac00](self.impl), buffer, digestLen)

proc g_hmac_get_string*(self: ptr Hmac00): cstring {.
    importc: "g_hmac_get_string", libprag.}

proc getString*(self: Hmac): string =
  let resul0 = g_hmac_get_string(cast[ptr Hmac00](self.impl))
  result = $resul0

proc string*(self: Hmac): string =
  let resul0 = g_hmac_get_string(cast[ptr Hmac00](self.impl))
  result = $resul0

proc g_hmac_unref*(self: ptr Hmac00) {.
    importc: "g_hmac_unref", libprag.}

proc unref*(self: Hmac) =
  g_hmac_unref(cast[ptr Hmac00](self.impl))

proc g_hmac_update*(self: ptr Hmac00; data: uint8Array; length: int64) {.
    importc: "g_hmac_update", libprag.}

proc update*(self: Hmac; data: uint8Array; length: int64) =
  g_hmac_update(cast[ptr Hmac00](self.impl), data, length)

type
  Hook00* {.pure.} = object
    data*: pointer
    next*: ptr Hook00
    prev*: ptr Hook00
    refCount*: uint32
    hookId*: uint64
    flags*: uint32
    `func`*: pointer
    destroy*: DestroyNotify
  Hook* = ref object
    impl*: ptr Hook00

proc g_hook_compare_ids*(self: ptr Hook00; sibling: ptr Hook00): int32 {.
    importc: "g_hook_compare_ids", libprag.}

proc compareIds*(self: Hook; sibling: Hook): int =
  int(g_hook_compare_ids(cast[ptr Hook00](self.impl), cast[ptr Hook00](sibling.impl)))

type
  HookCheckFunc* = proc (data: pointer): gboolean {.cdecl.}

type
  HookCheckMarshaller* = proc (hook: ptr Hook00; marshalData: pointer): gboolean {.cdecl.}

type
  HookCompareFunc* = proc (newHook: ptr Hook00; sibling: ptr Hook00): int32 {.cdecl.}
type

  HookFinalizeFunc* = proc (hookList: ptr HookList00; hook: ptr Hook00) {.cdecl.}

  HookList00* {.pure.} = object
    seqId*: uint64
    hookSize*: uint32
    isSetup*: uint32
    hooks*: ptr Hook00
    dummy3*: pointer
    finalizeHook*: HookFinalizeFunc
    dummy*: array[2, pointer]
  HookList* = ref object
    impl*: ptr HookList00

proc g_hook_list_clear*(self: ptr HookList00) {.
    importc: "g_hook_list_clear", libprag.}

proc clear*(self: HookList) =
  g_hook_list_clear(cast[ptr HookList00](self.impl))

proc g_hook_list_init*(self: ptr HookList00; hookSize: uint32) {.
    importc: "g_hook_list_init", libprag.}

proc init*(self: HookList; hookSize: int) =
  g_hook_list_init(cast[ptr HookList00](self.impl), uint32(hookSize))

proc g_hook_list_invoke*(self: ptr HookList00; mayRecurse: gboolean) {.
    importc: "g_hook_list_invoke", libprag.}

proc invoke*(self: HookList; mayRecurse: bool) =
  g_hook_list_invoke(cast[ptr HookList00](self.impl), gboolean(mayRecurse))

proc g_hook_list_invoke_check*(self: ptr HookList00; mayRecurse: gboolean) {.
    importc: "g_hook_list_invoke_check", libprag.}

proc invokeCheck*(self: HookList; mayRecurse: bool) =
  g_hook_list_invoke_check(cast[ptr HookList00](self.impl), gboolean(mayRecurse))

proc g_hook_destroy*(hookList: ptr HookList00; hookId: uint64): gboolean {.
    importc: "g_hook_destroy", libprag.}

proc destroy*(hookList: HookList; hookId: uint64): bool =
  toBool(g_hook_destroy(cast[ptr HookList00](hookList.impl), hookId))

proc g_hook_destroy_link*(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc: "g_hook_destroy_link", libprag.}

proc destroyLink*(hookList: HookList; hook: Hook) =
  g_hook_destroy_link(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_free*(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc: "g_hook_free", libprag.}

proc free*(hookList: HookList; hook: Hook) =
  g_hook_free(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_insert_before*(hookList: ptr HookList00; sibling: ptr Hook00; hook: ptr Hook00) {.
    importc: "g_hook_insert_before", libprag.}

proc insertBefore*(hookList: HookList; sibling: Hook; hook: Hook) =
  g_hook_insert_before(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](sibling.impl), cast[ptr Hook00](hook.impl))

proc g_hook_prepend*(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc: "g_hook_prepend", libprag.}

proc prepend*(hookList: HookList; hook: Hook) =
  g_hook_prepend(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

proc g_hook_unref*(hookList: ptr HookList00; hook: ptr Hook00) {.
    importc: "g_hook_unref", libprag.}

proc unref*(hookList: HookList; hook: Hook) =
  g_hook_unref(cast[ptr HookList00](hookList.impl), cast[ptr Hook00](hook.impl))

type
  HookFindFunc* = proc (hook: ptr Hook00; data: pointer): gboolean {.cdecl.}

type
  HookFlagMask* {.size: sizeof(cint), pure.} = enum
    active = 1
    inCall = 2
    mask = 15

type
  HookFunc* = proc (data: pointer) {.cdecl.}

type
  HookMarshaller* = proc (hook: ptr Hook00; marshalData: pointer) {.cdecl.}

type
  IConv00* {.pure.} = object
  IConv* = ref object
    impl*: ptr IConv00

proc g_iconv_close*(self: ptr IConv00): int32 {.
    importc: "g_iconv_close", libprag.}

proc close*(self: IConv): int =
  int(g_iconv_close(cast[ptr IConv00](self.impl)))

const IEEE754_DOUBLE_BIAS* = 1023'i32

const IEEE754_FLOAT_BIAS* = 127'i32

type
  IOStatus* {.size: sizeof(cint), pure.} = enum
    error = 0
    normal = 1
    eof = 2
    again = 3

type
  SeekType* {.size: sizeof(cint), pure.} = enum
    cur = 0
    set = 1
    `end` = 2

type
  IOCondition* {.size: sizeof(cint), pure.} = enum
    `in` = 1
    pri = 2
    `out` = 4
    err = 8
    hup = 16
    nval = 32

type
  SourceCallbackFuncs00* {.pure.} = object
    `ref`*: proc(cbData: pointer) {.cdecl.}
    unref*: proc(cbData: pointer) {.cdecl.}
    get*: pointer
  SourceCallbackFuncs* = ref object
    impl*: ptr SourceCallbackFuncs00

type
  IOChannelError* {.size: sizeof(cint), pure.} = enum
    fbig = 0
    inval = 1
    io = 2
    isdir = 3
    nospc = 4
    nxio = 5
    overflow = 6
    pipe = 7
    failed = 8

type
  IOError* {.size: sizeof(cint), pure.} = enum
    none = 0
    again = 1
    inval = 2
    unknown = 3

type
  IOFlags* {.size: sizeof(cint), pure.} = enum
    append = 1
    nonblock = 2
    setMask = 3
    isReadable = 4
    isWritable = 8
    isSeekable = 16
    getMask = 31

const
  IOFlagsIsWriteable* = IOFlags.isWritable
  IOFlagsMask* = IOFlags.getMask

const KEY_FILE_DESKTOP_GROUP* = "Desktop Entry"

const KEY_FILE_DESKTOP_KEY_ACTIONS* = "Actions"

const KEY_FILE_DESKTOP_KEY_CATEGORIES* = "Categories"

const KEY_FILE_DESKTOP_KEY_COMMENT* = "Comment"

const KEY_FILE_DESKTOP_KEY_DBUS_ACTIVATABLE* = "DBusActivatable"

const KEY_FILE_DESKTOP_KEY_EXEC* = "Exec"

const KEY_FILE_DESKTOP_KEY_GENERIC_NAME* = "GenericName"

const KEY_FILE_DESKTOP_KEY_HIDDEN* = "Hidden"

const KEY_FILE_DESKTOP_KEY_ICON* = "Icon"

const KEY_FILE_DESKTOP_KEY_MIME_TYPE* = "MimeType"

const KEY_FILE_DESKTOP_KEY_NAME* = "Name"

const KEY_FILE_DESKTOP_KEY_NOT_SHOW_IN* = "NotShowIn"

const KEY_FILE_DESKTOP_KEY_NO_DISPLAY* = "NoDisplay"

const KEY_FILE_DESKTOP_KEY_ONLY_SHOW_IN* = "OnlyShowIn"

const KEY_FILE_DESKTOP_KEY_PATH* = "Path"

const KEY_FILE_DESKTOP_KEY_STARTUP_NOTIFY* = "StartupNotify"

const KEY_FILE_DESKTOP_KEY_STARTUP_WM_CLASS* = "StartupWMClass"

const KEY_FILE_DESKTOP_KEY_TERMINAL* = "Terminal"

const KEY_FILE_DESKTOP_KEY_TRY_EXEC* = "TryExec"

const KEY_FILE_DESKTOP_KEY_TYPE* = "Type"

const KEY_FILE_DESKTOP_KEY_URL* = "URL"

const KEY_FILE_DESKTOP_KEY_VERSION* = "Version"

const KEY_FILE_DESKTOP_TYPE_APPLICATION* = "Application"

const KEY_FILE_DESKTOP_TYPE_DIRECTORY* = "Directory"

const KEY_FILE_DESKTOP_TYPE_LINK* = "Link"

type
  KeyFile00* {.pure.} = object
  KeyFile* = ref object
    impl*: ptr KeyFile00

proc g_key_file_new*(): ptr KeyFile00 {.
    importc: "g_key_file_new", libprag.}

proc newKeyFile*(): KeyFile =
  new(result)
  result.impl = g_key_file_new()

proc initKeyFile*[T](result: var T) =
  assert(result is KeyFile)
  new(result)
  result.impl = g_key_file_new()

proc g_key_file_get_boolean*(self: ptr KeyFile00; groupName: cstring; key: cstring): gboolean {.
    importc: "g_key_file_get_boolean", libprag.}

proc getBoolean*(self: KeyFile; groupName: string; key: string): bool =
  toBool(g_key_file_get_boolean(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc boolean*(self: KeyFile; groupName: string; key: string): bool =
  toBool(g_key_file_get_boolean(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc g_key_file_get_boolean_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    length: var uint64): gbooleanArray {.
    importc: "g_key_file_get_boolean_list", libprag.}

proc getBooleanList*(self: KeyFile; groupName: string; key: string; length: var uint64): gbooleanArray =
  g_key_file_get_boolean_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc booleanList*(self: KeyFile; groupName: string; key: string; length: var uint64): gbooleanArray =
  g_key_file_get_boolean_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc g_key_file_get_comment*(self: ptr KeyFile00; groupName: cstring; key: cstring): cstring {.
    importc: "g_key_file_get_comment", libprag.}

proc getComment*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_comment(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc comment*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_comment(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_double*(self: ptr KeyFile00; groupName: cstring; key: cstring): cdouble {.
    importc: "g_key_file_get_double", libprag.}

proc getDouble*(self: KeyFile; groupName: string; key: string): cdouble =
  g_key_file_get_double(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))

proc double*(self: KeyFile; groupName: string; key: string): cdouble =
  g_key_file_get_double(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))

proc g_key_file_get_double_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    length: var uint64): cdoubleArray {.
    importc: "g_key_file_get_double_list", libprag.}

proc getDoubleList*(self: KeyFile; groupName: string; key: string; length: var uint64): cdoubleArray =
  g_key_file_get_double_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc doubleList*(self: KeyFile; groupName: string; key: string; length: var uint64): cdoubleArray =
  g_key_file_get_double_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc g_key_file_get_groups*(self: ptr KeyFile00; length: var uint64): cstringArray {.
    importc: "g_key_file_get_groups", libprag.}

proc getGroups*(self: KeyFile; length: var uint64): cstringArray =
  g_key_file_get_groups(cast[ptr KeyFile00](self.impl), length)

proc groups*(self: KeyFile; length: var uint64): cstringArray =
  g_key_file_get_groups(cast[ptr KeyFile00](self.impl), length)

proc g_key_file_get_int64*(self: ptr KeyFile00; groupName: cstring; key: cstring): int64 {.
    importc: "g_key_file_get_int64", libprag.}

proc getInt64*(self: KeyFile; groupName: string; key: string): int64 =
  g_key_file_get_int64(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))

proc g_key_file_get_integer*(self: ptr KeyFile00; groupName: cstring; key: cstring): int32 {.
    importc: "g_key_file_get_integer", libprag.}

proc getInteger*(self: KeyFile; groupName: string; key: string): int =
  int(g_key_file_get_integer(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc integer*(self: KeyFile; groupName: string; key: string): int =
  int(g_key_file_get_integer(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc g_key_file_get_integer_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    length: var uint64): int32Array {.
    importc: "g_key_file_get_integer_list", libprag.}

proc getIntegerList*(self: KeyFile; groupName: string; key: string; length: var uint64): int32Array =
  g_key_file_get_integer_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc integerList*(self: KeyFile; groupName: string; key: string; length: var uint64): int32Array =
  g_key_file_get_integer_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc g_key_file_get_keys*(self: ptr KeyFile00; groupName: cstring; length: var uint64): cstringArray {.
    importc: "g_key_file_get_keys", libprag.}

proc getKeys*(self: KeyFile; groupName: string; length: var uint64): cstringArray =
  g_key_file_get_keys(cast[ptr KeyFile00](self.impl), cstring(groupName), length)

proc keys*(self: KeyFile; groupName: string; length: var uint64): cstringArray =
  g_key_file_get_keys(cast[ptr KeyFile00](self.impl), cstring(groupName), length)

proc g_key_file_get_locale_string*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    locale: cstring): cstring {.
    importc: "g_key_file_get_locale_string", libprag.}

proc getLocaleString*(self: KeyFile; groupName: string; key: string; locale: string): string =
  let resul0 = g_key_file_get_locale_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale))
  result = $resul0
  cogfree(resul0)

proc localeString*(self: KeyFile; groupName: string; key: string; locale: string): string =
  let resul0 = g_key_file_get_locale_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale))
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_locale_string_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    locale: cstring; length: var uint64): cstringArray {.
    importc: "g_key_file_get_locale_string_list", libprag.}

proc getLocaleStringList*(self: KeyFile; groupName: string; key: string; locale: string; 
    length: var uint64): cstringArray =
  g_key_file_get_locale_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale), length)

proc localeStringList*(self: KeyFile; groupName: string; key: string; locale: string; 
    length: var uint64): cstringArray =
  g_key_file_get_locale_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale), length)

proc g_key_file_get_start_group*(self: ptr KeyFile00): cstring {.
    importc: "g_key_file_get_start_group", libprag.}

proc getStartGroup*(self: KeyFile): string =
  let resul0 = g_key_file_get_start_group(cast[ptr KeyFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc startGroup*(self: KeyFile): string =
  let resul0 = g_key_file_get_start_group(cast[ptr KeyFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_string*(self: ptr KeyFile00; groupName: cstring; key: cstring): cstring {.
    importc: "g_key_file_get_string", libprag.}

proc getString*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc string*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc g_key_file_get_string_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    length: var uint64): cstringArray {.
    importc: "g_key_file_get_string_list", libprag.}

proc getStringList*(self: KeyFile; groupName: string; key: string; length: var uint64): cstringArray =
  g_key_file_get_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc stringList*(self: KeyFile; groupName: string; key: string; length: var uint64): cstringArray =
  g_key_file_get_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), length)

proc g_key_file_get_uint64*(self: ptr KeyFile00; groupName: cstring; key: cstring): uint64 {.
    importc: "g_key_file_get_uint64", libprag.}

proc getUint64*(self: KeyFile; groupName: string; key: string): uint64 =
  g_key_file_get_uint64(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))

proc g_key_file_get_value*(self: ptr KeyFile00; groupName: cstring; key: cstring): cstring {.
    importc: "g_key_file_get_value", libprag.}

proc getValue*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_value(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc value*(self: KeyFile; groupName: string; key: string): string =
  let resul0 = g_key_file_get_value(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key))
  result = $resul0
  cogfree(resul0)

proc g_key_file_has_group*(self: ptr KeyFile00; groupName: cstring): gboolean {.
    importc: "g_key_file_has_group", libprag.}

proc hasGroup*(self: KeyFile; groupName: string): bool =
  toBool(g_key_file_has_group(cast[ptr KeyFile00](self.impl), cstring(groupName)))

proc g_key_file_remove_comment*(self: ptr KeyFile00; groupName: cstring; key: cstring): gboolean {.
    importc: "g_key_file_remove_comment", libprag.}

proc removeComment*(self: KeyFile; groupName: string; key: string): bool =
  toBool(g_key_file_remove_comment(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc g_key_file_remove_group*(self: ptr KeyFile00; groupName: cstring): gboolean {.
    importc: "g_key_file_remove_group", libprag.}

proc removeGroup*(self: KeyFile; groupName: string): bool =
  toBool(g_key_file_remove_group(cast[ptr KeyFile00](self.impl), cstring(groupName)))

proc g_key_file_remove_key*(self: ptr KeyFile00; groupName: cstring; key: cstring): gboolean {.
    importc: "g_key_file_remove_key", libprag.}

proc removeKey*(self: KeyFile; groupName: string; key: string): bool =
  toBool(g_key_file_remove_key(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key)))

proc g_key_file_save_to_file*(self: ptr KeyFile00; filename: cstring): gboolean {.
    importc: "g_key_file_save_to_file", libprag.}

proc saveToFile*(self: KeyFile; filename: string): bool =
  toBool(g_key_file_save_to_file(cast[ptr KeyFile00](self.impl), cstring(filename)))

proc g_key_file_set_boolean*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: gboolean) {.
    importc: "g_key_file_set_boolean", libprag.}

proc setBoolean*(self: KeyFile; groupName: string; key: string; value: bool) =
  g_key_file_set_boolean(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), gboolean(value))

proc g_key_file_set_boolean_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    list: gbooleanArray; length: uint64) {.
    importc: "g_key_file_set_boolean_list", libprag.}

proc setBooleanList*(self: KeyFile; groupName: string; key: string; list: gbooleanArray; 
    length: uint64) =
  g_key_file_set_boolean_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), list, length)

proc g_key_file_set_comment*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    comment: cstring): gboolean {.
    importc: "g_key_file_set_comment", libprag.}

proc setComment*(self: KeyFile; groupName: string; key: string; comment: string): bool =
  toBool(g_key_file_set_comment(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(comment)))

proc g_key_file_set_double*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: cdouble) {.
    importc: "g_key_file_set_double", libprag.}

proc setDouble*(self: KeyFile; groupName: string; key: string; value: cdouble) =
  g_key_file_set_double(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), value)

proc g_key_file_set_double_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    list: cdoubleArray; length: uint64) {.
    importc: "g_key_file_set_double_list", libprag.}

proc setDoubleList*(self: KeyFile; groupName: string; key: string; list: cdoubleArray; 
    length: uint64) =
  g_key_file_set_double_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), list, length)

proc g_key_file_set_int64*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: int64) {.
    importc: "g_key_file_set_int64", libprag.}

proc setInt64*(self: KeyFile; groupName: string; key: string; value: int64) =
  g_key_file_set_int64(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), value)

proc g_key_file_set_integer*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: int32) {.
    importc: "g_key_file_set_integer", libprag.}

proc setInteger*(self: KeyFile; groupName: string; key: string; value: int) =
  g_key_file_set_integer(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), int32(value))

proc g_key_file_set_integer_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    list: int32Array; length: uint64) {.
    importc: "g_key_file_set_integer_list", libprag.}

proc setIntegerList*(self: KeyFile; groupName: string; key: string; list: int32Array; 
    length: uint64) =
  g_key_file_set_integer_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), list, length)

proc g_key_file_set_list_separator*(self: ptr KeyFile00; separator: int8) {.
    importc: "g_key_file_set_list_separator", libprag.}

proc setListSeparator*(self: KeyFile; separator: int8) =
  g_key_file_set_list_separator(cast[ptr KeyFile00](self.impl), separator)

proc `listSeparator=`*(self: KeyFile; separator: int8) =
  g_key_file_set_list_separator(cast[ptr KeyFile00](self.impl), separator)

proc g_key_file_set_locale_string*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    locale: cstring; string: cstring) {.
    importc: "g_key_file_set_locale_string", libprag.}

proc setLocaleString*(self: KeyFile; groupName: string; key: string; locale: string; 
    string: string) =
  g_key_file_set_locale_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale), cstring(string))

proc g_key_file_set_locale_string_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    locale: cstring; list: cstringArray; length: uint64) {.
    importc: "g_key_file_set_locale_string_list", libprag.}

proc setLocaleStringList*(self: KeyFile; groupName: string; key: string; locale: string; 
    list: cstringArray; length: uint64) =
  g_key_file_set_locale_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(locale), list, length)

proc g_key_file_set_string*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    string: cstring) {.
    importc: "g_key_file_set_string", libprag.}

proc setString*(self: KeyFile; groupName: string; key: string; string: string) =
  g_key_file_set_string(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(string))

proc g_key_file_set_string_list*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    list: cstringArray; length: uint64) {.
    importc: "g_key_file_set_string_list", libprag.}

proc setStringList*(self: KeyFile; groupName: string; key: string; list: cstringArray; 
    length: uint64) =
  g_key_file_set_string_list(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), list, length)

proc g_key_file_set_uint64*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: uint64) {.
    importc: "g_key_file_set_uint64", libprag.}

proc setUint64*(self: KeyFile; groupName: string; key: string; value: uint64) =
  g_key_file_set_uint64(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), value)

proc g_key_file_set_value*(self: ptr KeyFile00; groupName: cstring; key: cstring; 
    value: cstring) {.
    importc: "g_key_file_set_value", libprag.}

proc setValue*(self: KeyFile; groupName: string; key: string; value: string) =
  g_key_file_set_value(cast[ptr KeyFile00](self.impl), cstring(groupName), cstring(key), cstring(value))

proc g_key_file_to_data*(self: ptr KeyFile00; length: var uint64): cstring {.
    importc: "g_key_file_to_data", libprag.}

proc toData*(self: KeyFile; length: var uint64): string =
  let resul0 = g_key_file_to_data(cast[ptr KeyFile00](self.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_key_file_unref*(self: ptr KeyFile00) {.
    importc: "g_key_file_unref", libprag.}

proc unref*(self: KeyFile) =
  g_key_file_unref(cast[ptr KeyFile00](self.impl))

proc g_key_file_error_quark*(): uint32 {.
    importc: "g_key_file_error_quark", libprag.}

type
  KeyFileFlag* {.size: sizeof(cint), pure.} = enum
    keepComments = 1
    keepTranslations = 2

  KeyFileFlags* {.size: sizeof(cint).} = set[KeyFileFlag]

proc g_key_file_load_from_bytes*(self: ptr KeyFile00; bytes: ptr Bytes00; flags: KeyFileFlags): gboolean {.
    importc: "g_key_file_load_from_bytes", libprag.}

proc loadFromBytes*(self: KeyFile; bytes: Bytes; flags: KeyFileFlags): bool =
  toBool(g_key_file_load_from_bytes(cast[ptr KeyFile00](self.impl), cast[ptr Bytes00](bytes.impl), flags))

proc g_key_file_load_from_data*(self: ptr KeyFile00; data: cstring; length: uint64; 
    flags: KeyFileFlags): gboolean {.
    importc: "g_key_file_load_from_data", libprag.}

proc loadFromData*(self: KeyFile; data: string; length: uint64; flags: KeyFileFlags): bool =
  toBool(g_key_file_load_from_data(cast[ptr KeyFile00](self.impl), cstring(data), length, flags))

proc g_key_file_load_from_data_dirs*(self: ptr KeyFile00; file: ucstring; fullPath: var ucstring; 
    flags: KeyFileFlags): gboolean {.
    importc: "g_key_file_load_from_data_dirs", libprag.}

proc loadFromDataDirs*(self: KeyFile; file: ucstring; fullPath: var ucstring; 
    flags: KeyFileFlags): bool =
  toBool(g_key_file_load_from_data_dirs(cast[ptr KeyFile00](self.impl), file, fullPath, flags))

proc g_key_file_load_from_dirs*(self: ptr KeyFile00; file: ucstring; searchDirs: ucstringArray; 
    fullPath: var ucstring; flags: KeyFileFlags): gboolean {.
    importc: "g_key_file_load_from_dirs", libprag.}

proc loadFromDirs*(self: KeyFile; file: ucstring; searchDirs: ucstringArray; 
    fullPath: var ucstring; flags: KeyFileFlags): bool =
  toBool(g_key_file_load_from_dirs(cast[ptr KeyFile00](self.impl), file, searchDirs, fullPath, flags))

proc g_key_file_load_from_file*(self: ptr KeyFile00; file: ucstring; flags: KeyFileFlags): gboolean {.
    importc: "g_key_file_load_from_file", libprag.}

proc loadFromFile*(self: KeyFile; file: ucstring; flags: KeyFileFlags): bool =
  toBool(g_key_file_load_from_file(cast[ptr KeyFile00](self.impl), file, flags))

type
  KeyFileError* {.size: sizeof(cint), pure.} = enum
    unknownEncoding = 0
    parse = 1
    notFound = 2
    keyNotFound = 3
    groupNotFound = 4
    invalidValue = 5

const LITTLE_ENDIAN* = 1234'i32

const LN10* = 2.302585'f64

const LN2* = 0.693147'f64

const LOG_2_BASE_10* = 0.30103'f64

const LOG_DOMAIN* = 0'i8

const LOG_FATAL_MASK* = 0'i32

const LOG_LEVEL_USER_SHIFT* = 8'i32

type
  List00* {.pure.} = object
    data*: pointer
    next*: ptr pointer
    prev*: ptr pointer
  List* = ref object
    impl*: ptr List00

type
  LogField00* {.pure.} = object
    key*: cstring
    value*: pointer
    length*: int64
  LogField* = ref object
    impl*: ptr LogField00

type
  LogLevelFlags* {.size: sizeof(cint), pure.} = enum
    levelMask = -4
    flagRecursion = 1
    flagFatal = 2
    levelError = 4
    levelCritical = 8
    levelWarning = 16
    levelMessage = 32
    levelInfo = 64
    levelDebug = 128

type
  LogFunc* = proc (logDomain: cstring; logLevel: LogLevelFlags; message: cstring; 
    userData: pointer) {.cdecl.}

type
  LogWriterOutput* {.size: sizeof(cint), pure.} = enum
    unhandled = 0
    handled = 1

type
  LogWriterFunc* = proc (logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.cdecl.}

const MAJOR_VERSION* = 2'i32

const MAXINT16* = 32767'i16

const MAXINT32* = 2147483647'i32

const MAXINT64* = 9223372036854775807'i64

const MAXINT8* = 127'i8

const MAXUINT16* = 65535'u16

const MAXUINT32* = 4294967295'u32

const MAXUINT64* = 18446744073709551615'u64

const MAXUINT8* = 255'u8

const MICRO_VERSION* = 3'i32

const MINOR_VERSION* = 50'i32

const MODULE_SUFFIX* = "so"

type
  MainContext00* {.pure.} = object
  MainContext* = ref object
    impl*: ptr MainContext00

proc g_main_context_new*(): ptr MainContext00 {.
    importc: "g_main_context_new", libprag.}

proc newMainContext*(): MainContext =
  new(result)
  result.impl = g_main_context_new()

proc initMainContext*[T](result: var T) =
  assert(result is MainContext)
  new(result)
  result.impl = g_main_context_new()

proc g_main_context_acquire*(self: ptr MainContext00): gboolean {.
    importc: "g_main_context_acquire", libprag.}

proc acquire*(self: MainContext): bool =
  toBool(g_main_context_acquire(cast[ptr MainContext00](self.impl)))

proc g_main_context_dispatch*(self: ptr MainContext00) {.
    importc: "g_main_context_dispatch", libprag.}

proc dispatch*(self: MainContext) =
  g_main_context_dispatch(cast[ptr MainContext00](self.impl))

proc g_main_context_is_owner*(self: ptr MainContext00): gboolean {.
    importc: "g_main_context_is_owner", libprag.}

proc isOwner*(self: MainContext): bool =
  toBool(g_main_context_is_owner(cast[ptr MainContext00](self.impl)))

proc g_main_context_iteration*(self: ptr MainContext00; mayBlock: gboolean): gboolean {.
    importc: "g_main_context_iteration", libprag.}

proc iteration*(self: MainContext; mayBlock: bool): bool =
  toBool(g_main_context_iteration(cast[ptr MainContext00](self.impl), gboolean(mayBlock)))

proc g_main_context_pending*(self: ptr MainContext00): gboolean {.
    importc: "g_main_context_pending", libprag.}

proc pending*(self: MainContext): bool =
  toBool(g_main_context_pending(cast[ptr MainContext00](self.impl)))

proc g_main_context_pop_thread_default*(self: ptr MainContext00) {.
    importc: "g_main_context_pop_thread_default", libprag.}

proc popThreadDefault*(self: MainContext) =
  g_main_context_pop_thread_default(cast[ptr MainContext00](self.impl))

proc g_main_context_prepare*(self: ptr MainContext00; priority: ptr int32): gboolean {.
    importc: "g_main_context_prepare", libprag.}

proc prepare*(self: MainContext; priority: ptr int32): bool =
  toBool(g_main_context_prepare(cast[ptr MainContext00](self.impl), priority))

proc g_main_context_push_thread_default*(self: ptr MainContext00) {.
    importc: "g_main_context_push_thread_default", libprag.}

proc pushThreadDefault*(self: MainContext) =
  g_main_context_push_thread_default(cast[ptr MainContext00](self.impl))

proc g_main_context_ref*(self: ptr MainContext00): ptr MainContext00 {.
    importc: "g_main_context_ref", libprag.}

proc `ref`*(self: MainContext): MainContext =
  new(result)
  result.impl = g_main_context_ref(cast[ptr MainContext00](self.impl))

proc g_main_context_release*(self: ptr MainContext00) {.
    importc: "g_main_context_release", libprag.}

proc release*(self: MainContext) =
  g_main_context_release(cast[ptr MainContext00](self.impl))

proc g_main_context_unref*(self: ptr MainContext00) {.
    importc: "g_main_context_unref", libprag.}

proc unref*(self: MainContext) =
  g_main_context_unref(cast[ptr MainContext00](self.impl))

proc g_main_context_wakeup*(self: ptr MainContext00) {.
    importc: "g_main_context_wakeup", libprag.}

proc wakeup*(self: MainContext) =
  g_main_context_wakeup(cast[ptr MainContext00](self.impl))

proc g_main_context_default*(): ptr MainContext00 {.
    importc: "g_main_context_default", libprag.}

proc default*(): MainContext =
  new(result)
  result.impl = g_main_context_default()

proc g_main_context_get_thread_default*(): ptr MainContext00 {.
    importc: "g_main_context_get_thread_default", libprag.}

proc getThreadDefault*(): MainContext =
  new(result)
  result.impl = g_main_context_get_thread_default()

proc threadDefault*(): MainContext =
  new(result)
  result.impl = g_main_context_get_thread_default()

proc g_main_context_ref_thread_default*(): ptr MainContext00 {.
    importc: "g_main_context_ref_thread_default", libprag.}

proc refThreadDefault*(): MainContext =
  new(result)
  result.impl = g_main_context_ref_thread_default()

type
  PollFD00* {.pure.} = object
    fd*: int32
    events*: uint16
    revents*: uint16
  PollFD* = ref object
    impl*: ptr PollFD00

proc g_main_context_add_poll*(self: ptr MainContext00; fd: ptr PollFD00; priority: int32) {.
    importc: "g_main_context_add_poll", libprag.}

proc addPoll*(self: MainContext; fd: PollFD; priority: int) =
  g_main_context_add_poll(cast[ptr MainContext00](self.impl), cast[ptr PollFD00](fd.impl), int32(priority))

proc g_main_context_check*(self: ptr MainContext00; maxPriority: int32; fds: PollFD00Array; 
    nFds: int32): int32 {.
    importc: "g_main_context_check", libprag.}

proc check*(self: MainContext; maxPriority: int; fds: PollFD00Array; 
    nFds: int): int =
  int(g_main_context_check(cast[ptr MainContext00](self.impl), int32(maxPriority), fds, int32(nFds)))

proc g_main_context_query*(self: ptr MainContext00; maxPriority: int32; timeout: var int32; 
    fds: var PollFD00Array; nFds: int32): int32 {.
    importc: "g_main_context_query", libprag.}

proc query*(self: MainContext; maxPriority: int; timeout: var int; 
    fds: var PollFD00Array; nFds: int): int =
  var timeout_00 = int32(timeout)
  result = int(g_main_context_query(cast[ptr MainContext00](self.impl), int32(maxPriority), timeout_00, fds, int32(nFds)))
  timeout = int(timeout_00)

proc g_main_context_remove_poll*(self: ptr MainContext00; fd: ptr PollFD00) {.
    importc: "g_main_context_remove_poll", libprag.}

proc removePoll*(self: MainContext; fd: PollFD) =
  g_main_context_remove_poll(cast[ptr MainContext00](self.impl), cast[ptr PollFD00](fd.impl))

type
  MainLoop00* {.pure.} = object
  MainLoop* = ref object
    impl*: ptr MainLoop00

proc g_main_loop_new*(context: ptr MainContext00; isRunning: gboolean): ptr MainLoop00 {.
    importc: "g_main_loop_new", libprag.}

proc newMainLoop*(context: MainContext; isRunning: bool): MainLoop =
  new(result)
  result.impl = g_main_loop_new(cast[ptr MainContext00](context.impl), gboolean(isRunning))

proc initMainLoop*[T](result: var T; context: MainContext; isRunning: bool) =
  assert(result is MainLoop)
  new(result)
  result.impl = g_main_loop_new(cast[ptr MainContext00](context.impl), gboolean(isRunning))

proc g_main_loop_get_context*(self: ptr MainLoop00): ptr MainContext00 {.
    importc: "g_main_loop_get_context", libprag.}

proc getContext*(self: MainLoop): MainContext =
  new(result)
  result.impl = g_main_loop_get_context(cast[ptr MainLoop00](self.impl))

proc context*(self: MainLoop): MainContext =
  new(result)
  result.impl = g_main_loop_get_context(cast[ptr MainLoop00](self.impl))

proc g_main_loop_is_running*(self: ptr MainLoop00): gboolean {.
    importc: "g_main_loop_is_running", libprag.}

proc isRunning*(self: MainLoop): bool =
  toBool(g_main_loop_is_running(cast[ptr MainLoop00](self.impl)))

proc g_main_loop_quit*(self: ptr MainLoop00) {.
    importc: "g_main_loop_quit", libprag.}

proc quit*(self: MainLoop) =
  g_main_loop_quit(cast[ptr MainLoop00](self.impl))

proc g_main_loop_ref*(self: ptr MainLoop00): ptr MainLoop00 {.
    importc: "g_main_loop_ref", libprag.}

proc `ref`*(self: MainLoop): MainLoop =
  new(result)
  result.impl = g_main_loop_ref(cast[ptr MainLoop00](self.impl))

proc g_main_loop_run*(self: ptr MainLoop00) {.
    importc: "g_main_loop_run", libprag.}

proc run*(self: MainLoop) =
  g_main_loop_run(cast[ptr MainLoop00](self.impl))

proc g_main_loop_unref*(self: ptr MainLoop00) {.
    importc: "g_main_loop_unref", libprag.}

proc unref*(self: MainLoop) =
  g_main_loop_unref(cast[ptr MainLoop00](self.impl))

type
  MappedFile00* {.pure.} = object
  MappedFile* = ref object
    impl*: ptr MappedFile00

proc g_mapped_file_new*(filename: ucstring; writable: gboolean): ptr MappedFile00 {.
    importc: "g_mapped_file_new", libprag.}

proc newMappedFile*(filename: ucstring; writable: bool): MappedFile =
  new(result)
  result.impl = g_mapped_file_new(filename, gboolean(writable))

proc initMappedFile*[T](result: var T; filename: ucstring; writable: bool) =
  assert(result is MappedFile)
  new(result)
  result.impl = g_mapped_file_new(filename, gboolean(writable))

proc g_mapped_file_new_from_fd*(fd: int32; writable: gboolean): ptr MappedFile00 {.
    importc: "g_mapped_file_new_from_fd", libprag.}

proc newMappedFileFromFd*(fd: int; writable: bool): MappedFile =
  new(result)
  result.impl = g_mapped_file_new_from_fd(int32(fd), gboolean(writable))

proc initMappedFileFromFd*[T](result: var T; fd: int; writable: bool) =
  assert(result is MappedFile)
  new(result)
  result.impl = g_mapped_file_new_from_fd(int32(fd), gboolean(writable))

proc g_mapped_file_free*(self: ptr MappedFile00) {.
    importc: "g_mapped_file_free", libprag.}

proc free*(self: MappedFile) =
  g_mapped_file_free(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_get_bytes*(self: ptr MappedFile00): ptr Bytes00 {.
    importc: "g_mapped_file_get_bytes", libprag.}

proc getBytes*(self: MappedFile): Bytes =
  new(result)
  result.impl = g_mapped_file_get_bytes(cast[ptr MappedFile00](self.impl))

proc bytes*(self: MappedFile): Bytes =
  new(result)
  result.impl = g_mapped_file_get_bytes(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_get_contents*(self: ptr MappedFile00): cstring {.
    importc: "g_mapped_file_get_contents", libprag.}

proc getContents*(self: MappedFile): string =
  let resul0 = g_mapped_file_get_contents(cast[ptr MappedFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc contents*(self: MappedFile): string =
  let resul0 = g_mapped_file_get_contents(cast[ptr MappedFile00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_mapped_file_get_length*(self: ptr MappedFile00): uint64 {.
    importc: "g_mapped_file_get_length", libprag.}

proc getLength*(self: MappedFile): uint64 =
  g_mapped_file_get_length(cast[ptr MappedFile00](self.impl))

proc length*(self: MappedFile): uint64 =
  g_mapped_file_get_length(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_ref*(self: ptr MappedFile00): ptr MappedFile00 {.
    importc: "g_mapped_file_ref", libprag.}

proc `ref`*(self: MappedFile): MappedFile =
  new(result)
  result.impl = g_mapped_file_ref(cast[ptr MappedFile00](self.impl))

proc g_mapped_file_unref*(self: ptr MappedFile00) {.
    importc: "g_mapped_file_unref", libprag.}

proc unref*(self: MappedFile) =
  g_mapped_file_unref(cast[ptr MappedFile00](self.impl))

type
  MarkupCollectType* {.size: sizeof(cint), pure.} = enum
    invalid = 0
    string = 1
    strdup = 2
    boolean = 3
    tristate = 4
    optional = 65536

type
  MarkupError* {.size: sizeof(cint), pure.} = enum
    badUtf8 = 0
    empty = 1
    parse = 2
    unknownElement = 3
    unknownAttribute = 4
    invalidContent = 5
    missingAttribute = 6

type
  MarkupParseContext00* {.pure.} = object
  MarkupParseContext* = ref object
    impl*: ptr MarkupParseContext00

proc g_markup_parse_context_end_parse*(self: ptr MarkupParseContext00): gboolean {.
    importc: "g_markup_parse_context_end_parse", libprag.}

proc endParse*(self: MarkupParseContext): bool =
  toBool(g_markup_parse_context_end_parse(cast[ptr MarkupParseContext00](self.impl)))

proc g_markup_parse_context_free*(self: ptr MarkupParseContext00) {.
    importc: "g_markup_parse_context_free", libprag.}

proc free*(self: MarkupParseContext) =
  g_markup_parse_context_free(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_get_element*(self: ptr MarkupParseContext00): cstring {.
    importc: "g_markup_parse_context_get_element", libprag.}

proc getElement*(self: MarkupParseContext): string =
  let resul0 = g_markup_parse_context_get_element(cast[ptr MarkupParseContext00](self.impl))
  result = $resul0

proc element*(self: MarkupParseContext): string =
  let resul0 = g_markup_parse_context_get_element(cast[ptr MarkupParseContext00](self.impl))
  result = $resul0

proc g_markup_parse_context_get_position*(self: ptr MarkupParseContext00; lineNumber: ptr int32; 
    charNumber: ptr int32) {.
    importc: "g_markup_parse_context_get_position", libprag.}

proc getPosition*(self: MarkupParseContext; lineNumber: ptr int32; charNumber: ptr int32) =
  g_markup_parse_context_get_position(cast[ptr MarkupParseContext00](self.impl), lineNumber, charNumber)

proc position*(self: MarkupParseContext; lineNumber: ptr int32; charNumber: ptr int32) =
  g_markup_parse_context_get_position(cast[ptr MarkupParseContext00](self.impl), lineNumber, charNumber)

proc g_markup_parse_context_get_user_data*(self: ptr MarkupParseContext00): pointer {.
    importc: "g_markup_parse_context_get_user_data", libprag.}

proc getUserData*(self: MarkupParseContext): pointer =
  g_markup_parse_context_get_user_data(cast[ptr MarkupParseContext00](self.impl))

proc userData*(self: MarkupParseContext): pointer =
  g_markup_parse_context_get_user_data(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_parse*(self: ptr MarkupParseContext00; text: cstring; textLen: int64): gboolean {.
    importc: "g_markup_parse_context_parse", libprag.}

proc parse*(self: MarkupParseContext; text: string; textLen: int64): bool =
  toBool(g_markup_parse_context_parse(cast[ptr MarkupParseContext00](self.impl), cstring(text), textLen))

proc g_markup_parse_context_pop*(self: ptr MarkupParseContext00): pointer {.
    importc: "g_markup_parse_context_pop", libprag.}

proc pop*(self: MarkupParseContext): pointer =
  g_markup_parse_context_pop(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_ref*(self: ptr MarkupParseContext00): ptr MarkupParseContext00 {.
    importc: "g_markup_parse_context_ref", libprag.}

proc `ref`*(self: MarkupParseContext): MarkupParseContext =
  new(result)
  result.impl = g_markup_parse_context_ref(cast[ptr MarkupParseContext00](self.impl))

proc g_markup_parse_context_unref*(self: ptr MarkupParseContext00) {.
    importc: "g_markup_parse_context_unref", libprag.}

proc unref*(self: MarkupParseContext) =
  g_markup_parse_context_unref(cast[ptr MarkupParseContext00](self.impl))

type
  MarkupParser00* {.pure.} = object
    startElement*: proc(context: ptr MarkupParseContext00; elementName: cstring; 
    attributeNames: cstring; attributeValues: cstring; userData: pointer) {.cdecl.}
    endElement*: proc(context: ptr MarkupParseContext00; elementName: cstring; 
    userData: pointer) {.cdecl.}
    text*: proc(context: ptr MarkupParseContext00; text: cstring; 
    textLen: uint64; userData: pointer) {.cdecl.}
    passthrough*: proc(context: ptr MarkupParseContext00; passthroughText: cstring; 
    textLen: uint64; userData: pointer) {.cdecl.}
    error*: proc(context: ptr MarkupParseContext00; error: ptr Error00; 
    userData: pointer) {.cdecl.}
  MarkupParser* = ref object
    impl*: ptr MarkupParser00

proc g_markup_parse_context_push*(self: ptr MarkupParseContext00; parser: ptr MarkupParser00; 
    userData: pointer) {.
    importc: "g_markup_parse_context_push", libprag.}

proc push*(self: MarkupParseContext; parser: MarkupParser; userData: pointer) =
  g_markup_parse_context_push(cast[ptr MarkupParseContext00](self.impl), cast[ptr MarkupParser00](parser.impl), userData)

type
  MarkupParseFlag* {.size: sizeof(cint), pure.} = enum
    doNotUseThisUnsupportedFlag = 1
    treatCdataAsText = 2
    prefixErrorPosition = 3
    ignoreQualified = 4

  MarkupParseFlags* {.size: sizeof(cint).} = set[MarkupParseFlag]

proc g_markup_parse_context_new*(parser: ptr MarkupParser00; flags: MarkupParseFlags; 
    userData: pointer; userDataDnotify: DestroyNotify): ptr MarkupParseContext00 {.
    importc: "g_markup_parse_context_new", libprag.}

proc newMarkupParseContext*(parser: MarkupParser; flags: MarkupParseFlags; userData: pointer; 
    userDataDnotify: DestroyNotify): MarkupParseContext =
  new(result)
  result.impl = g_markup_parse_context_new(cast[ptr MarkupParser00](parser.impl), flags, userData, userDataDnotify)

proc initMarkupParseContext*[T](result: var T; parser: MarkupParser; flags: MarkupParseFlags; userData: pointer; 
    userDataDnotify: DestroyNotify) =
  assert(result is MarkupParseContext)
  new(result)
  result.impl = g_markup_parse_context_new(cast[ptr MarkupParser00](parser.impl), flags, userData, userDataDnotify)

type
  MatchInfo00* {.pure.} = object
  MatchInfo* = ref object
    impl*: ptr MatchInfo00

proc g_match_info_expand_references*(self: ptr MatchInfo00; stringToExpand: cstring): cstring {.
    importc: "g_match_info_expand_references", libprag.}

proc expandReferences*(self: MatchInfo; stringToExpand: string): string =
  let resul0 = g_match_info_expand_references(cast[ptr MatchInfo00](self.impl), cstring(stringToExpand))
  result = $resul0
  cogfree(resul0)

proc g_match_info_fetch*(self: ptr MatchInfo00; matchNum: int32): cstring {.
    importc: "g_match_info_fetch", libprag.}

proc fetch*(self: MatchInfo; matchNum: int): string =
  let resul0 = g_match_info_fetch(cast[ptr MatchInfo00](self.impl), int32(matchNum))
  result = $resul0
  cogfree(resul0)

proc g_match_info_fetch_all*(self: ptr MatchInfo00): cstringArray {.
    importc: "g_match_info_fetch_all", libprag.}

proc fetchAll*(self: MatchInfo): cstringArray =
  g_match_info_fetch_all(cast[ptr MatchInfo00](self.impl))

proc g_match_info_fetch_named*(self: ptr MatchInfo00; name: cstring): cstring {.
    importc: "g_match_info_fetch_named", libprag.}

proc fetchNamed*(self: MatchInfo; name: string): string =
  let resul0 = g_match_info_fetch_named(cast[ptr MatchInfo00](self.impl), cstring(name))
  result = $resul0
  cogfree(resul0)

proc g_match_info_fetch_named_pos*(self: ptr MatchInfo00; name: cstring; startPos: var int32; 
    endPos: var int32): gboolean {.
    importc: "g_match_info_fetch_named_pos", libprag.}

proc fetchNamedPos*(self: MatchInfo; name: string; startPos: var int; 
    endPos: var int): bool =
  var startPos_00 = int32(startPos)
  var endPos_00 = int32(endPos)
  result = toBool(g_match_info_fetch_named_pos(cast[ptr MatchInfo00](self.impl), cstring(name), startPos_00, endPos_00))
  startPos = int(startPos_00)
  endPos = int(endPos_00)

proc g_match_info_fetch_pos*(self: ptr MatchInfo00; matchNum: int32; startPos: var int32; 
    endPos: var int32): gboolean {.
    importc: "g_match_info_fetch_pos", libprag.}

proc fetchPos*(self: MatchInfo; matchNum: int; startPos: var int; 
    endPos: var int): bool =
  var startPos_00 = int32(startPos)
  var endPos_00 = int32(endPos)
  result = toBool(g_match_info_fetch_pos(cast[ptr MatchInfo00](self.impl), int32(matchNum), startPos_00, endPos_00))
  startPos = int(startPos_00)
  endPos = int(endPos_00)

proc g_match_info_free*(self: ptr MatchInfo00) {.
    importc: "g_match_info_free", libprag.}

proc free*(self: MatchInfo) =
  g_match_info_free(cast[ptr MatchInfo00](self.impl))

proc g_match_info_get_match_count*(self: ptr MatchInfo00): int32 {.
    importc: "g_match_info_get_match_count", libprag.}

proc getMatchCount*(self: MatchInfo): int =
  int(g_match_info_get_match_count(cast[ptr MatchInfo00](self.impl)))

proc matchCount*(self: MatchInfo): int =
  int(g_match_info_get_match_count(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_get_string*(self: ptr MatchInfo00): cstring {.
    importc: "g_match_info_get_string", libprag.}

proc getString*(self: MatchInfo): string =
  let resul0 = g_match_info_get_string(cast[ptr MatchInfo00](self.impl))
  result = $resul0

proc string*(self: MatchInfo): string =
  let resul0 = g_match_info_get_string(cast[ptr MatchInfo00](self.impl))
  result = $resul0

proc g_match_info_is_partial_match*(self: ptr MatchInfo00): gboolean {.
    importc: "g_match_info_is_partial_match", libprag.}

proc isPartialMatch*(self: MatchInfo): bool =
  toBool(g_match_info_is_partial_match(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_matches*(self: ptr MatchInfo00): gboolean {.
    importc: "g_match_info_matches", libprag.}

proc matches*(self: MatchInfo): bool =
  toBool(g_match_info_matches(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_next*(self: ptr MatchInfo00): gboolean {.
    importc: "g_match_info_next", libprag.}

proc next*(self: MatchInfo): bool =
  toBool(g_match_info_next(cast[ptr MatchInfo00](self.impl)))

proc g_match_info_ref*(self: ptr MatchInfo00): ptr MatchInfo00 {.
    importc: "g_match_info_ref", libprag.}

proc `ref`*(self: MatchInfo): MatchInfo =
  new(result)
  result.impl = g_match_info_ref(cast[ptr MatchInfo00](self.impl))

proc g_match_info_unref*(self: ptr MatchInfo00) {.
    importc: "g_match_info_unref", libprag.}

proc unref*(self: MatchInfo) =
  g_match_info_unref(cast[ptr MatchInfo00](self.impl))

type
  Regex00* {.pure.} = object
  Regex* = ref object
    impl*: ptr Regex00

proc g_regex_get_capture_count*(self: ptr Regex00): int32 {.
    importc: "g_regex_get_capture_count", libprag.}

proc getCaptureCount*(self: Regex): int =
  int(g_regex_get_capture_count(cast[ptr Regex00](self.impl)))

proc captureCount*(self: Regex): int =
  int(g_regex_get_capture_count(cast[ptr Regex00](self.impl)))

proc g_regex_get_has_cr_or_lf*(self: ptr Regex00): gboolean {.
    importc: "g_regex_get_has_cr_or_lf", libprag.}

proc getHasCrOrLf*(self: Regex): bool =
  toBool(g_regex_get_has_cr_or_lf(cast[ptr Regex00](self.impl)))

proc hasCrOrLf*(self: Regex): bool =
  toBool(g_regex_get_has_cr_or_lf(cast[ptr Regex00](self.impl)))

proc g_regex_get_max_backref*(self: ptr Regex00): int32 {.
    importc: "g_regex_get_max_backref", libprag.}

proc getMaxBackref*(self: Regex): int =
  int(g_regex_get_max_backref(cast[ptr Regex00](self.impl)))

proc maxBackref*(self: Regex): int =
  int(g_regex_get_max_backref(cast[ptr Regex00](self.impl)))

proc g_regex_get_max_lookbehind*(self: ptr Regex00): int32 {.
    importc: "g_regex_get_max_lookbehind", libprag.}

proc getMaxLookbehind*(self: Regex): int =
  int(g_regex_get_max_lookbehind(cast[ptr Regex00](self.impl)))

proc maxLookbehind*(self: Regex): int =
  int(g_regex_get_max_lookbehind(cast[ptr Regex00](self.impl)))

proc g_regex_get_pattern*(self: ptr Regex00): cstring {.
    importc: "g_regex_get_pattern", libprag.}

proc getPattern*(self: Regex): string =
  let resul0 = g_regex_get_pattern(cast[ptr Regex00](self.impl))
  result = $resul0

proc pattern*(self: Regex): string =
  let resul0 = g_regex_get_pattern(cast[ptr Regex00](self.impl))
  result = $resul0

proc g_regex_get_string_number*(self: ptr Regex00; name: cstring): int32 {.
    importc: "g_regex_get_string_number", libprag.}

proc getStringNumber*(self: Regex; name: string): int =
  int(g_regex_get_string_number(cast[ptr Regex00](self.impl), cstring(name)))

proc stringNumber*(self: Regex; name: string): int =
  int(g_regex_get_string_number(cast[ptr Regex00](self.impl), cstring(name)))

proc g_regex_ref*(self: ptr Regex00): ptr Regex00 {.
    importc: "g_regex_ref", libprag.}

proc `ref`*(self: Regex): Regex =
  new(result)
  result.impl = g_regex_ref(cast[ptr Regex00](self.impl))

proc g_regex_unref*(self: ptr Regex00) {.
    importc: "g_regex_unref", libprag.}

proc unref*(self: Regex) =
  g_regex_unref(cast[ptr Regex00](self.impl))

proc g_regex_check_replacement*(replacement: cstring; hasReferences: var gboolean): gboolean {.
    importc: "g_regex_check_replacement", libprag.}

proc checkReplacement*(replacement: cstring; hasReferences: var gboolean): gboolean {.
    importc: "g_regex_check_replacement", libprag.}

proc g_regex_error_quark*(): uint32 {.
    importc: "g_regex_error_quark", libprag.}

proc g_regex_escape_nul*(string: cstring; length: int32): cstring {.
    importc: "g_regex_escape_nul", libprag.}

proc escapeNul*(string: string; length: int): string =
  let resul0 = g_regex_escape_nul(cstring(string), int32(length))
  result = $resul0
  cogfree(resul0)

proc g_regex_escape_string*(string: cstringArray; length: int32): cstring {.
    importc: "g_regex_escape_string", libprag.}

proc escapeString*(string: cstringArray; length: int): string =
  let resul0 = g_regex_escape_string(string, int32(length))
  result = $resul0
  cogfree(resul0)

proc g_match_info_get_regex*(self: ptr MatchInfo00): ptr Regex00 {.
    importc: "g_match_info_get_regex", libprag.}

proc getRegex*(self: MatchInfo): Regex =
  new(result)
  result.impl = g_match_info_get_regex(cast[ptr MatchInfo00](self.impl))

proc regex*(self: MatchInfo): Regex =
  new(result)
  result.impl = g_match_info_get_regex(cast[ptr MatchInfo00](self.impl))

type
  RegexMatchFlags* {.size: sizeof(cint), pure.} = enum
    anchored = 16
    notbol = 128
    noteol = 256
    notempty = 1024
    partial = 32768
    newlineCr = 1048576
    newlineLf = 2097152
    newlineCrlf = 3145728
    newlineAny = 4194304
    newlineAnycrlf = 5242880
    bsrAnycrlf = 8388608
    bsrAny = 16777216
    partialHard = 134217728
    notemptyAtstart = 268435456

const
  RegexMatchFlagsPartialSoft* = RegexMatchFlags.partial

proc g_regex_get_match_flags*(self: ptr Regex00): RegexMatchFlags {.
    importc: "g_regex_get_match_flags", libprag.}

proc getMatchFlags*(self: Regex): RegexMatchFlags =
  g_regex_get_match_flags(cast[ptr Regex00](self.impl))

proc matchFlags*(self: Regex): RegexMatchFlags =
  g_regex_get_match_flags(cast[ptr Regex00](self.impl))

proc g_regex_match*(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags; 
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match", libprag.}

proc match*(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags; 
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match", libprag.}

proc g_regex_match_all*(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags; 
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_all", libprag.}

proc matchAll*(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags; 
    matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_all", libprag.}

proc g_regex_match_all_full*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_all_full", libprag.}

proc matchAllFull*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_all_full", libprag.}

proc g_regex_match_full*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_full", libprag.}

proc matchFull*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; matchOptions: RegexMatchFlags; matchInfo: var ptr MatchInfo00): gboolean {.
    importc: "g_regex_match_full", libprag.}

proc g_regex_replace*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; replacement: cstring; matchOptions: RegexMatchFlags): cstring {.
    importc: "g_regex_replace", libprag.}

proc replace*(self: Regex; string: cstringArray; stringLen: int64; 
    startPosition: int; replacement: string; matchOptions: RegexMatchFlags): string =
  let resul0 = g_regex_replace(cast[ptr Regex00](self.impl), string, stringLen, int32(startPosition), cstring(replacement), matchOptions)
  result = $resul0
  cogfree(resul0)

proc g_regex_replace_literal*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; replacement: cstring; matchOptions: RegexMatchFlags): cstring {.
    importc: "g_regex_replace_literal", libprag.}

proc replaceLiteral*(self: Regex; string: cstringArray; stringLen: int64; 
    startPosition: int; replacement: string; matchOptions: RegexMatchFlags): string =
  let resul0 = g_regex_replace_literal(cast[ptr Regex00](self.impl), string, stringLen, int32(startPosition), cstring(replacement), matchOptions)
  result = $resul0
  cogfree(resul0)

proc g_regex_split*(self: ptr Regex00; string: cstring; matchOptions: RegexMatchFlags): cstringArray {.
    importc: "g_regex_split", libprag.}

proc split*(self: Regex; string: string; matchOptions: RegexMatchFlags): cstringArray =
  g_regex_split(cast[ptr Regex00](self.impl), cstring(string), matchOptions)

proc g_regex_split_full*(self: ptr Regex00; string: cstringArray; stringLen: int64; 
    startPosition: int32; matchOptions: RegexMatchFlags; maxTokens: int32): cstringArray {.
    importc: "g_regex_split_full", libprag.}

proc splitFull*(self: Regex; string: cstringArray; stringLen: int64; 
    startPosition: int; matchOptions: RegexMatchFlags; maxTokens: int): cstringArray =
  g_regex_split_full(cast[ptr Regex00](self.impl), string, stringLen, int32(startPosition), matchOptions, int32(maxTokens))

type
  RegexCompileFlags* {.size: sizeof(cint), pure.} = enum
    caseless = 1
    multiline = 2
    dotall = 4
    extended = 8
    anchored = 16
    dollarEndonly = 32
    ungreedy = 512
    raw = 2048
    noAutoCapture = 4096
    optimize = 8192
    firstline = 262144
    dupnames = 524288
    newlineCr = 1048576
    newlineLf = 2097152
    newlineCrlf = 3145728
    newlineAnycrlf = 5242880
    bsrAnycrlf = 8388608
    javascriptCompat = 33554432

proc g_regex_new*(pattern: cstring; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): ptr Regex00 {.
    importc: "g_regex_new", libprag.}

proc newRegex*(pattern: string; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): Regex =
  new(result)
  result.impl = g_regex_new(cstring(pattern), compileOptions, matchOptions)

proc initRegex*[T](result: var T; pattern: string; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags) =
  assert(result is Regex)
  new(result)
  result.impl = g_regex_new(cstring(pattern), compileOptions, matchOptions)

proc g_regex_get_compile_flags*(self: ptr Regex00): RegexCompileFlags {.
    importc: "g_regex_get_compile_flags", libprag.}

proc getCompileFlags*(self: Regex): RegexCompileFlags =
  g_regex_get_compile_flags(cast[ptr Regex00](self.impl))

proc compileFlags*(self: Regex): RegexCompileFlags =
  g_regex_get_compile_flags(cast[ptr Regex00](self.impl))

proc g_regex_match_simple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): gboolean {.
    importc: "g_regex_match_simple", libprag.}

proc matchSimple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): gboolean {.
    importc: "g_regex_match_simple", libprag.}

proc g_regex_split_simple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): cstringArray {.
    importc: "g_regex_split_simple", libprag.}

proc splitSimple*(pattern: cstring; string: cstring; compileOptions: RegexCompileFlags; 
    matchOptions: RegexMatchFlags): cstringArray {.
    importc: "g_regex_split_simple", libprag.}

type
  MemVTable00* {.pure.} = object
    malloc*: proc(nBytes: uint64): pointer {.cdecl.}
    realloc*: proc(mem: pointer; nBytes: uint64): pointer {.cdecl.}
    free*: proc(mem: pointer) {.cdecl.}
    calloc*: proc(nBlocks: uint64; nBlockBytes: uint64): pointer {.cdecl.}
    tryMalloc*: proc(nBytes: uint64): pointer {.cdecl.}
    tryRealloc*: proc(mem: pointer; nBytes: uint64): pointer {.cdecl.}
  MemVTable* = ref object
    impl*: ptr MemVTable00

type
  Mutex00* = object {.union.}
    p*: pointer
    i*: array[2, uint32]
  Mutex* = ref object
    impl*: ptr Mutex00

proc g_mutex_clear*(self: ptr Mutex00) {.
    importc: "g_mutex_clear", libprag.}

proc clear*(self: Mutex) =
  g_mutex_clear(cast[ptr Mutex00](self.impl))

proc g_mutex_init*(self: ptr Mutex00) {.
    importc: "g_mutex_init", libprag.}

proc init*(self: Mutex) =
  g_mutex_init(cast[ptr Mutex00](self.impl))

proc g_mutex_lock*(self: ptr Mutex00) {.
    importc: "g_mutex_lock", libprag.}

proc lock*(self: Mutex) =
  g_mutex_lock(cast[ptr Mutex00](self.impl))

proc g_mutex_trylock*(self: ptr Mutex00): gboolean {.
    importc: "g_mutex_trylock", libprag.}

proc trylock*(self: Mutex): bool =
  toBool(g_mutex_trylock(cast[ptr Mutex00](self.impl)))

proc g_mutex_unlock*(self: ptr Mutex00) {.
    importc: "g_mutex_unlock", libprag.}

proc unlock*(self: Mutex) =
  g_mutex_unlock(cast[ptr Mutex00](self.impl))

proc g_cond_wait*(self: ptr Cond00; mutex: ptr Mutex00) {.
    importc: "g_cond_wait", libprag.}

proc wait*(self: Cond; mutex: Mutex) =
  g_cond_wait(cast[ptr Cond00](self.impl), cast[ptr Mutex00](mutex.impl))

proc g_cond_wait_until*(self: ptr Cond00; mutex: ptr Mutex00; endTime: int64): gboolean {.
    importc: "g_cond_wait_until", libprag.}

proc waitUntil*(self: Cond; mutex: Mutex; endTime: int64): bool =
  toBool(g_cond_wait_until(cast[ptr Cond00](self.impl), cast[ptr Mutex00](mutex.impl), endTime))

proc g_main_context_wait*(self: ptr MainContext00; cond: ptr Cond00; mutex: ptr Mutex00): gboolean {.
    importc: "g_main_context_wait", libprag.}

proc wait*(self: MainContext; cond: Cond; mutex: Mutex): bool =
  toBool(g_main_context_wait(cast[ptr MainContext00](self.impl), cast[ptr Cond00](cond.impl), cast[ptr Mutex00](mutex.impl)))

type
  Node00* {.pure.} = object
    data*: pointer
    next*: ptr Node00
    prev*: ptr Node00
    parent*: ptr Node00
    children*: ptr Node00
  Node* = ref object
    impl*: ptr Node00

proc g_node_child_index*(self: ptr Node00; data: pointer): int32 {.
    importc: "g_node_child_index", libprag.}

proc childIndex*(self: Node; data: pointer): int =
  int(g_node_child_index(cast[ptr Node00](self.impl), data))

proc g_node_child_position*(self: ptr Node00; child: ptr Node00): int32 {.
    importc: "g_node_child_position", libprag.}

proc childPosition*(self: Node; child: Node): int =
  int(g_node_child_position(cast[ptr Node00](self.impl), cast[ptr Node00](child.impl)))

proc g_node_depth*(self: ptr Node00): uint32 {.
    importc: "g_node_depth", libprag.}

proc depth*(self: Node): int =
  int(g_node_depth(cast[ptr Node00](self.impl)))

proc g_node_destroy*(self: ptr Node00) {.
    importc: "g_node_destroy", libprag.}

proc destroy*(self: Node) =
  g_node_destroy(cast[ptr Node00](self.impl))

proc g_node_is_ancestor*(self: ptr Node00; descendant: ptr Node00): gboolean {.
    importc: "g_node_is_ancestor", libprag.}

proc isAncestor*(self: Node; descendant: Node): bool =
  toBool(g_node_is_ancestor(cast[ptr Node00](self.impl), cast[ptr Node00](descendant.impl)))

proc g_node_max_height*(self: ptr Node00): uint32 {.
    importc: "g_node_max_height", libprag.}

proc maxHeight*(self: Node): int =
  int(g_node_max_height(cast[ptr Node00](self.impl)))

proc g_node_n_children*(self: ptr Node00): uint32 {.
    importc: "g_node_n_children", libprag.}

proc nChildren*(self: Node): int =
  int(g_node_n_children(cast[ptr Node00](self.impl)))

proc g_node_reverse_children*(self: ptr Node00) {.
    importc: "g_node_reverse_children", libprag.}

proc reverseChildren*(self: Node) =
  g_node_reverse_children(cast[ptr Node00](self.impl))

proc g_node_unlink*(self: ptr Node00) {.
    importc: "g_node_unlink", libprag.}

proc unlink*(self: Node) =
  g_node_unlink(cast[ptr Node00](self.impl))

type
  TraverseFlags* {.size: sizeof(cint), pure.} = enum
    leafs = 1
    nonLeafs = 2
    all = 3

const
  TraverseFlagsLeaves* = TraverseFlags.leafs
  TraverseFlagsNonLeaves* = TraverseFlags.nonLeafs
  TraverseFlagsMask* = TraverseFlags.all

proc g_node_n_nodes*(self: ptr Node00; flags: TraverseFlags): uint32 {.
    importc: "g_node_n_nodes", libprag.}

proc nNodes*(self: Node; flags: TraverseFlags): int =
  int(g_node_n_nodes(cast[ptr Node00](self.impl), flags))

type
  NodeForeachFunc* = proc (node: ptr Node00; data: pointer) {.cdecl.}

type
  NodeTraverseFunc* = proc (node: ptr Node00; data: pointer): gboolean {.cdecl.}

type
  NormalizeMode* {.size: sizeof(cint), pure.} = enum
    default = 0
    defaultCompose = 1
    all = 2
    allCompose = 3

const
  NormalizeModeNfd* = NormalizeMode.default
  NormalizeModeNfc* = NormalizeMode.defaultCompose
  NormalizeModeNfkd* = NormalizeMode.all
  NormalizeModeNfkc* = NormalizeMode.allCompose

const OPTION_REMAINING* = ""

type
  OnceStatus* {.size: sizeof(cint), pure.} = enum
    notcalled = 0
    progress = 1
    ready = 2

type
  Once00* {.pure.} = object
    status*: OnceStatus
    retval*: pointer
  Once* = ref object
    impl*: ptr Once00

proc g_once_init_enter*(location: pointer): gboolean {.
    importc: "g_once_init_enter", libprag.}

proc initEnter*(location: pointer): gboolean {.
    importc: "g_once_init_enter", libprag.}

proc g_once_init_leave*(location: pointer; resu: uint64) {.
    importc: "g_once_init_leave", libprag.}

proc initLeave*(location: pointer; resu: uint64) {.
    importc: "g_once_init_leave", libprag.}

type
  OptionArg* {.size: sizeof(cint), pure.} = enum
    none = 0
    string = 1
    int = 2
    callback = 3
    filename = 4
    stringArray = 5
    filenameArray = 6
    double = 7
    int64 = 8

type
  OptionArgFunc* = proc (optionName: cstring; value: cstring; data: pointer): gboolean {.cdecl.}

type
  OptionContext00* {.pure.} = object
  OptionContext* = ref object
    impl*: ptr OptionContext00

proc g_option_context_free*(self: ptr OptionContext00) {.
    importc: "g_option_context_free", libprag.}

proc free*(self: OptionContext) =
  g_option_context_free(cast[ptr OptionContext00](self.impl))

proc g_option_context_get_description*(self: ptr OptionContext00): cstring {.
    importc: "g_option_context_get_description", libprag.}

proc getDescription*(self: OptionContext): string =
  let resul0 = g_option_context_get_description(cast[ptr OptionContext00](self.impl))
  result = $resul0

proc description*(self: OptionContext): string =
  let resul0 = g_option_context_get_description(cast[ptr OptionContext00](self.impl))
  result = $resul0

proc g_option_context_get_help_enabled*(self: ptr OptionContext00): gboolean {.
    importc: "g_option_context_get_help_enabled", libprag.}

proc getHelpEnabled*(self: OptionContext): bool =
  toBool(g_option_context_get_help_enabled(cast[ptr OptionContext00](self.impl)))

proc helpEnabled*(self: OptionContext): bool =
  toBool(g_option_context_get_help_enabled(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_ignore_unknown_options*(self: ptr OptionContext00): gboolean {.
    importc: "g_option_context_get_ignore_unknown_options", libprag.}

proc getIgnoreUnknownOptions*(self: OptionContext): bool =
  toBool(g_option_context_get_ignore_unknown_options(cast[ptr OptionContext00](self.impl)))

proc ignoreUnknownOptions*(self: OptionContext): bool =
  toBool(g_option_context_get_ignore_unknown_options(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_strict_posix*(self: ptr OptionContext00): gboolean {.
    importc: "g_option_context_get_strict_posix", libprag.}

proc getStrictPosix*(self: OptionContext): bool =
  toBool(g_option_context_get_strict_posix(cast[ptr OptionContext00](self.impl)))

proc strictPosix*(self: OptionContext): bool =
  toBool(g_option_context_get_strict_posix(cast[ptr OptionContext00](self.impl)))

proc g_option_context_get_summary*(self: ptr OptionContext00): cstring {.
    importc: "g_option_context_get_summary", libprag.}

proc getSummary*(self: OptionContext): string =
  let resul0 = g_option_context_get_summary(cast[ptr OptionContext00](self.impl))
  result = $resul0

proc summary*(self: OptionContext): string =
  let resul0 = g_option_context_get_summary(cast[ptr OptionContext00](self.impl))
  result = $resul0

proc g_option_context_parse*(self: ptr OptionContext00; argc: int32; argv: cstringArray): gboolean {.
    importc: "g_option_context_parse", libprag.}

proc parse*(self: OptionContext; argc: int; argv: cstringArray): bool =
  toBool(g_option_context_parse(cast[ptr OptionContext00](self.impl), int32(argc), argv))

proc g_option_context_parse_strv*(self: ptr OptionContext00; arguments: cstringArray): gboolean {.
    importc: "g_option_context_parse_strv", libprag.}

proc parseStrv*(self: OptionContext; arguments: cstringArray): bool =
  toBool(g_option_context_parse_strv(cast[ptr OptionContext00](self.impl), arguments))

proc g_option_context_set_description*(self: ptr OptionContext00; description: cstring) {.
    importc: "g_option_context_set_description", libprag.}

proc setDescription*(self: OptionContext; description: string) =
  g_option_context_set_description(cast[ptr OptionContext00](self.impl), cstring(description))

proc `description=`*(self: OptionContext; description: string) =
  g_option_context_set_description(cast[ptr OptionContext00](self.impl), cstring(description))

proc g_option_context_set_help_enabled*(self: ptr OptionContext00; helpEnabled: gboolean) {.
    importc: "g_option_context_set_help_enabled", libprag.}

proc setHelpEnabled*(self: OptionContext; helpEnabled: bool) =
  g_option_context_set_help_enabled(cast[ptr OptionContext00](self.impl), gboolean(helpEnabled))

proc `helpEnabled=`*(self: OptionContext; helpEnabled: bool) =
  g_option_context_set_help_enabled(cast[ptr OptionContext00](self.impl), gboolean(helpEnabled))

proc g_option_context_set_ignore_unknown_options*(self: ptr OptionContext00; ignoreUnknown: gboolean) {.
    importc: "g_option_context_set_ignore_unknown_options", libprag.}

proc setIgnoreUnknownOptions*(self: OptionContext; ignoreUnknown: bool) =
  g_option_context_set_ignore_unknown_options(cast[ptr OptionContext00](self.impl), gboolean(ignoreUnknown))

proc `ignoreUnknownOptions=`*(self: OptionContext; ignoreUnknown: bool) =
  g_option_context_set_ignore_unknown_options(cast[ptr OptionContext00](self.impl), gboolean(ignoreUnknown))

proc g_option_context_set_strict_posix*(self: ptr OptionContext00; strictPosix: gboolean) {.
    importc: "g_option_context_set_strict_posix", libprag.}

proc setStrictPosix*(self: OptionContext; strictPosix: bool) =
  g_option_context_set_strict_posix(cast[ptr OptionContext00](self.impl), gboolean(strictPosix))

proc `strictPosix=`*(self: OptionContext; strictPosix: bool) =
  g_option_context_set_strict_posix(cast[ptr OptionContext00](self.impl), gboolean(strictPosix))

proc g_option_context_set_summary*(self: ptr OptionContext00; summary: cstring) {.
    importc: "g_option_context_set_summary", libprag.}

proc setSummary*(self: OptionContext; summary: string) =
  g_option_context_set_summary(cast[ptr OptionContext00](self.impl), cstring(summary))

proc `summary=`*(self: OptionContext; summary: string) =
  g_option_context_set_summary(cast[ptr OptionContext00](self.impl), cstring(summary))

proc g_option_context_set_translation_domain*(self: ptr OptionContext00; domain: cstring) {.
    importc: "g_option_context_set_translation_domain", libprag.}

proc setTranslationDomain*(self: OptionContext; domain: string) =
  g_option_context_set_translation_domain(cast[ptr OptionContext00](self.impl), cstring(domain))

proc `translationDomain=`*(self: OptionContext; domain: string) =
  g_option_context_set_translation_domain(cast[ptr OptionContext00](self.impl), cstring(domain))

type
  OptionEntry00* {.pure.} = object
    longName*: cstring
    shortName*: int8
    flags*: int32
    arg*: OptionArg
    argData*: pointer
    description*: cstring
    argDescription*: cstring
  OptionEntry* = ref object
    impl*: ptr OptionEntry00

proc g_option_context_add_main_entries*(self: ptr OptionContext00; entries: ptr OptionEntry00; 
    translationDomain: cstring) {.
    importc: "g_option_context_add_main_entries", libprag.}

proc addMainEntries*(self: OptionContext; entries: OptionEntry; translationDomain: string) =
  g_option_context_add_main_entries(cast[ptr OptionContext00](self.impl), cast[ptr OptionEntry00](entries.impl), cstring(translationDomain))

type
  OptionGroup00* {.pure.} = object
  OptionGroup* = ref object
    impl*: ptr OptionGroup00

proc g_option_group_new*(name: cstring; description: cstring; helpDescription: cstring; 
    userData: pointer; destroy: DestroyNotify): ptr OptionGroup00 {.
    importc: "g_option_group_new", libprag.}

proc newOptionGroup*(name: string; description: string; helpDescription: string; 
    userData: pointer; destroy: DestroyNotify): OptionGroup =
  new(result)
  result.impl = g_option_group_new(cstring(name), cstring(description), cstring(helpDescription), userData, destroy)

proc initOptionGroup*[T](result: var T; name: string; description: string; helpDescription: string; 
    userData: pointer; destroy: DestroyNotify) =
  assert(result is OptionGroup)
  new(result)
  result.impl = g_option_group_new(cstring(name), cstring(description), cstring(helpDescription), userData, destroy)

proc g_option_group_add_entries*(self: ptr OptionGroup00; entries: ptr OptionEntry00) {.
    importc: "g_option_group_add_entries", libprag.}

proc addEntries*(self: OptionGroup; entries: OptionEntry) =
  g_option_group_add_entries(cast[ptr OptionGroup00](self.impl), cast[ptr OptionEntry00](entries.impl))

proc g_option_group_free*(self: ptr OptionGroup00) {.
    importc: "g_option_group_free", libprag.}

proc free*(self: OptionGroup) =
  g_option_group_free(cast[ptr OptionGroup00](self.impl))

proc g_option_group_ref*(self: ptr OptionGroup00): ptr OptionGroup00 {.
    importc: "g_option_group_ref", libprag.}

proc `ref`*(self: OptionGroup): OptionGroup =
  new(result)
  result.impl = g_option_group_ref(cast[ptr OptionGroup00](self.impl))

proc g_option_group_set_translation_domain*(self: ptr OptionGroup00; domain: cstring) {.
    importc: "g_option_group_set_translation_domain", libprag.}

proc setTranslationDomain*(self: OptionGroup; domain: string) =
  g_option_group_set_translation_domain(cast[ptr OptionGroup00](self.impl), cstring(domain))

proc `translationDomain=`*(self: OptionGroup; domain: string) =
  g_option_group_set_translation_domain(cast[ptr OptionGroup00](self.impl), cstring(domain))

proc g_option_group_unref*(self: ptr OptionGroup00) {.
    importc: "g_option_group_unref", libprag.}

proc unref*(self: OptionGroup) =
  g_option_group_unref(cast[ptr OptionGroup00](self.impl))

proc g_option_context_add_group*(self: ptr OptionContext00; group: ptr OptionGroup00) {.
    importc: "g_option_context_add_group", libprag.}

proc addGroup*(self: OptionContext; group: OptionGroup) =
  g_option_context_add_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](group.impl))

proc g_option_context_get_help*(self: ptr OptionContext00; mainHelp: gboolean; group: ptr OptionGroup00): cstring {.
    importc: "g_option_context_get_help", libprag.}

proc getHelp*(self: OptionContext; mainHelp: bool; group: OptionGroup): string =
  let resul0 = g_option_context_get_help(cast[ptr OptionContext00](self.impl), gboolean(mainHelp), cast[ptr OptionGroup00](group.impl))
  result = $resul0
  cogfree(resul0)

proc help*(self: OptionContext; mainHelp: bool; group: OptionGroup): string =
  let resul0 = g_option_context_get_help(cast[ptr OptionContext00](self.impl), gboolean(mainHelp), cast[ptr OptionGroup00](group.impl))
  result = $resul0
  cogfree(resul0)

proc g_option_context_get_main_group*(self: ptr OptionContext00): ptr OptionGroup00 {.
    importc: "g_option_context_get_main_group", libprag.}

proc getMainGroup*(self: OptionContext): OptionGroup =
  new(result)
  result.impl = g_option_context_get_main_group(cast[ptr OptionContext00](self.impl))

proc mainGroup*(self: OptionContext): OptionGroup =
  new(result)
  result.impl = g_option_context_get_main_group(cast[ptr OptionContext00](self.impl))

proc g_option_context_set_main_group*(self: ptr OptionContext00; group: ptr OptionGroup00) {.
    importc: "g_option_context_set_main_group", libprag.}

proc setMainGroup*(self: OptionContext; group: OptionGroup) =
  g_option_context_set_main_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](group.impl))

proc `mainGroup=`*(self: OptionContext; group: OptionGroup) =
  g_option_context_set_main_group(cast[ptr OptionContext00](self.impl), cast[ptr OptionGroup00](group.impl))

type
  OptionError* {.size: sizeof(cint), pure.} = enum
    unknownOption = 0
    badValue = 1
    failed = 2

type
  OptionErrorFunc* = proc (context: ptr OptionContext00; group: ptr OptionGroup00; 
    data: pointer) {.cdecl.}

type
  OptionFlag* {.size: sizeof(cint), pure.} = enum
    hidden = 1
    inMain = 2
    reverse = 3
    noArg = 4
    filename = 5
    optionalArg = 6
    noalias = 7

  OptionFlags* {.size: sizeof(cint).} = set[OptionFlag]

type
  OptionParseFunc* = proc (context: ptr OptionContext00; group: ptr OptionGroup00; 
    data: pointer): gboolean {.cdecl.}

const PDP_ENDIAN* = 3412'i32

const PI* = 3.141593'f64

const PID_FORMAT* = "i"

const PI_2* = 1.570796'f64

const PI_4* = 0.785398'f64

const POLLFD_FORMAT* = "%d"

const PRIORITY_DEFAULT* = 0'i32

const PRIORITY_DEFAULT_IDLE* = 200'i32

const PRIORITY_HIGH* = -100'i32

const PRIORITY_HIGH_IDLE* = 100'i32

const PRIORITY_LOW* = 300'i32

type
  PatternSpec00* {.pure.} = object
  PatternSpec* = ref object
    impl*: ptr PatternSpec00

proc g_pattern_spec_equal*(self: ptr PatternSpec00; pspec2: ptr PatternSpec00): gboolean {.
    importc: "g_pattern_spec_equal", libprag.}

proc equal*(self: PatternSpec; pspec2: PatternSpec): bool =
  toBool(g_pattern_spec_equal(cast[ptr PatternSpec00](self.impl), cast[ptr PatternSpec00](pspec2.impl)))

proc g_pattern_spec_free*(self: ptr PatternSpec00) {.
    importc: "g_pattern_spec_free", libprag.}

proc free*(self: PatternSpec) =
  g_pattern_spec_free(cast[ptr PatternSpec00](self.impl))

type
  PollFunc* = proc (ufds: ptr PollFD00; nfsd: uint32; timeout: int32): int32 {.cdecl.}

type
  PrintFunc* = proc (string: cstring) {.cdecl.}

type
  Private00* {.pure.} = object
    p*: pointer
    notify*: DestroyNotify
    future*: array[2, pointer]
  Private* = ref object
    impl*: ptr Private00

proc g_private_get*(self: ptr Private00): pointer {.
    importc: "g_private_get", libprag.}

proc get*(self: Private): pointer =
  g_private_get(cast[ptr Private00](self.impl))

proc g_private_replace*(self: ptr Private00; value: pointer) {.
    importc: "g_private_replace", libprag.}

proc replace*(self: Private; value: pointer) =
  g_private_replace(cast[ptr Private00](self.impl), value)

proc g_private_set*(self: ptr Private00; value: pointer) {.
    importc: "g_private_set", libprag.}

proc set*(self: Private; value: pointer) =
  g_private_set(cast[ptr Private00](self.impl), value)

type
  PtrArray00* {.pure.} = object
    pdata*: pointer
    len*: uint32
  PtrArray* = ref object
    impl*: ptr PtrArray00

type
  Queue00* {.pure.} = object
    head*: ptr pointer
    tail*: ptr pointer
    length*: uint32
  Queue* = ref object
    impl*: ptr Queue00

proc g_queue_clear*(self: ptr Queue00) {.
    importc: "g_queue_clear", libprag.}

proc clear*(self: Queue) =
  g_queue_clear(cast[ptr Queue00](self.impl))

proc g_queue_free*(self: ptr Queue00) {.
    importc: "g_queue_free", libprag.}

proc free*(self: Queue) =
  g_queue_free(cast[ptr Queue00](self.impl))

proc g_queue_free_full*(self: ptr Queue00; freeFunc: DestroyNotify) {.
    importc: "g_queue_free_full", libprag.}

proc freeFull*(self: Queue; freeFunc: DestroyNotify) =
  g_queue_free_full(cast[ptr Queue00](self.impl), freeFunc)

proc g_queue_get_length*(self: ptr Queue00): uint32 {.
    importc: "g_queue_get_length", libprag.}

proc getLength*(self: Queue): int =
  int(g_queue_get_length(cast[ptr Queue00](self.impl)))

proc length*(self: Queue): int =
  int(g_queue_get_length(cast[ptr Queue00](self.impl)))

proc g_queue_index*(self: ptr Queue00; data: pointer): int32 {.
    importc: "g_queue_index", libprag.}

proc index*(self: Queue; data: pointer): int =
  int(g_queue_index(cast[ptr Queue00](self.impl), data))

proc g_queue_init*(self: ptr Queue00) {.
    importc: "g_queue_init", libprag.}

proc init*(self: Queue) =
  g_queue_init(cast[ptr Queue00](self.impl))

proc g_queue_is_empty*(self: ptr Queue00): gboolean {.
    importc: "g_queue_is_empty", libprag.}

proc isEmpty*(self: Queue): bool =
  toBool(g_queue_is_empty(cast[ptr Queue00](self.impl)))

proc g_queue_peek_head*(self: ptr Queue00): pointer {.
    importc: "g_queue_peek_head", libprag.}

proc peekHead*(self: Queue): pointer =
  g_queue_peek_head(cast[ptr Queue00](self.impl))

proc g_queue_peek_nth*(self: ptr Queue00; n: uint32): pointer {.
    importc: "g_queue_peek_nth", libprag.}

proc peekNth*(self: Queue; n: int): pointer =
  g_queue_peek_nth(cast[ptr Queue00](self.impl), uint32(n))

proc g_queue_peek_tail*(self: ptr Queue00): pointer {.
    importc: "g_queue_peek_tail", libprag.}

proc peekTail*(self: Queue): pointer =
  g_queue_peek_tail(cast[ptr Queue00](self.impl))

proc g_queue_pop_head*(self: ptr Queue00): pointer {.
    importc: "g_queue_pop_head", libprag.}

proc popHead*(self: Queue): pointer =
  g_queue_pop_head(cast[ptr Queue00](self.impl))

proc g_queue_pop_nth*(self: ptr Queue00; n: uint32): pointer {.
    importc: "g_queue_pop_nth", libprag.}

proc popNth*(self: Queue; n: int): pointer =
  g_queue_pop_nth(cast[ptr Queue00](self.impl), uint32(n))

proc g_queue_pop_tail*(self: ptr Queue00): pointer {.
    importc: "g_queue_pop_tail", libprag.}

proc popTail*(self: Queue): pointer =
  g_queue_pop_tail(cast[ptr Queue00](self.impl))

proc g_queue_push_head*(self: ptr Queue00; data: pointer) {.
    importc: "g_queue_push_head", libprag.}

proc pushHead*(self: Queue; data: pointer) =
  g_queue_push_head(cast[ptr Queue00](self.impl), data)

proc g_queue_push_nth*(self: ptr Queue00; data: pointer; n: int32) {.
    importc: "g_queue_push_nth", libprag.}

proc pushNth*(self: Queue; data: pointer; n: int) =
  g_queue_push_nth(cast[ptr Queue00](self.impl), data, int32(n))

proc g_queue_push_tail*(self: ptr Queue00; data: pointer) {.
    importc: "g_queue_push_tail", libprag.}

proc pushTail*(self: Queue; data: pointer) =
  g_queue_push_tail(cast[ptr Queue00](self.impl), data)

proc g_queue_remove*(self: ptr Queue00; data: pointer): gboolean {.
    importc: "g_queue_remove", libprag.}

proc remove*(self: Queue; data: pointer): bool =
  toBool(g_queue_remove(cast[ptr Queue00](self.impl), data))

proc g_queue_remove_all*(self: ptr Queue00; data: pointer): uint32 {.
    importc: "g_queue_remove_all", libprag.}

proc removeAll*(self: Queue; data: pointer): int =
  int(g_queue_remove_all(cast[ptr Queue00](self.impl), data))

proc g_queue_reverse*(self: ptr Queue00) {.
    importc: "g_queue_reverse", libprag.}

proc reverse*(self: Queue) =
  g_queue_reverse(cast[ptr Queue00](self.impl))

type
  RWLock00* {.pure.} = object
    p*: pointer
    i*: array[2, uint32]
  RWLock* = ref object
    impl*: ptr RWLock00

proc g_rw_lock_clear*(self: ptr RWLock00) {.
    importc: "g_rw_lock_clear", libprag.}

proc clear*(self: RWLock) =
  g_rw_lock_clear(cast[ptr RWLock00](self.impl))

proc g_rw_lock_init*(self: ptr RWLock00) {.
    importc: "g_rw_lock_init", libprag.}

proc init*(self: RWLock) =
  g_rw_lock_init(cast[ptr RWLock00](self.impl))

proc g_rw_lock_reader_lock*(self: ptr RWLock00) {.
    importc: "g_rw_lock_reader_lock", libprag.}

proc readerLock*(self: RWLock) =
  g_rw_lock_reader_lock(cast[ptr RWLock00](self.impl))

proc g_rw_lock_reader_trylock*(self: ptr RWLock00): gboolean {.
    importc: "g_rw_lock_reader_trylock", libprag.}

proc readerTrylock*(self: RWLock): bool =
  toBool(g_rw_lock_reader_trylock(cast[ptr RWLock00](self.impl)))

proc g_rw_lock_reader_unlock*(self: ptr RWLock00) {.
    importc: "g_rw_lock_reader_unlock", libprag.}

proc readerUnlock*(self: RWLock) =
  g_rw_lock_reader_unlock(cast[ptr RWLock00](self.impl))

proc g_rw_lock_writer_lock*(self: ptr RWLock00) {.
    importc: "g_rw_lock_writer_lock", libprag.}

proc writerLock*(self: RWLock) =
  g_rw_lock_writer_lock(cast[ptr RWLock00](self.impl))

proc g_rw_lock_writer_trylock*(self: ptr RWLock00): gboolean {.
    importc: "g_rw_lock_writer_trylock", libprag.}

proc writerTrylock*(self: RWLock): bool =
  toBool(g_rw_lock_writer_trylock(cast[ptr RWLock00](self.impl)))

proc g_rw_lock_writer_unlock*(self: ptr RWLock00) {.
    importc: "g_rw_lock_writer_unlock", libprag.}

proc writerUnlock*(self: RWLock) =
  g_rw_lock_writer_unlock(cast[ptr RWLock00](self.impl))

type
  Rand00* {.pure.} = object
  Rand* = ref object
    impl*: ptr Rand00

proc g_rand_double*(self: ptr Rand00): cdouble {.
    importc: "g_rand_double", libprag.}

proc double*(self: Rand): cdouble =
  g_rand_double(cast[ptr Rand00](self.impl))

proc g_rand_double_range*(self: ptr Rand00; begin: cdouble; `end`: cdouble): cdouble {.
    importc: "g_rand_double_range", libprag.}

proc doubleRange*(self: Rand; begin: cdouble; `end`: cdouble): cdouble =
  g_rand_double_range(cast[ptr Rand00](self.impl), begin, `end`)

proc g_rand_free*(self: ptr Rand00) {.
    importc: "g_rand_free", libprag.}

proc free*(self: Rand) =
  g_rand_free(cast[ptr Rand00](self.impl))

proc g_rand_int*(self: ptr Rand00): uint32 {.
    importc: "g_rand_int", libprag.}

proc intP*(self: Rand): int =
  int(g_rand_int(cast[ptr Rand00](self.impl)))

proc g_rand_int_range*(self: ptr Rand00; begin: int32; `end`: int32): int32 {.
    importc: "g_rand_int_range", libprag.}

proc intRange*(self: Rand; begin: int; `end`: int): int =
  int(g_rand_int_range(cast[ptr Rand00](self.impl), int32(begin), int32(`end`)))

proc g_rand_set_seed*(self: ptr Rand00; seed: uint32) {.
    importc: "g_rand_set_seed", libprag.}

proc setSeed*(self: Rand; seed: int) =
  g_rand_set_seed(cast[ptr Rand00](self.impl), uint32(seed))

proc `seed=`*(self: Rand; seed: int) =
  g_rand_set_seed(cast[ptr Rand00](self.impl), uint32(seed))

proc g_rand_set_seed_array*(self: ptr Rand00; seed: ptr uint32; seedLength: uint32) {.
    importc: "g_rand_set_seed_array", libprag.}

proc setSeedArray*(self: Rand; seed: ptr uint32; seedLength: int) =
  g_rand_set_seed_array(cast[ptr Rand00](self.impl), seed, uint32(seedLength))

type
  RecMutex00* {.pure.} = object
    p*: pointer
    i*: array[2, uint32]
  RecMutex* = ref object
    impl*: ptr RecMutex00

proc g_rec_mutex_clear*(self: ptr RecMutex00) {.
    importc: "g_rec_mutex_clear", libprag.}

proc clear*(self: RecMutex) =
  g_rec_mutex_clear(cast[ptr RecMutex00](self.impl))

proc g_rec_mutex_init*(self: ptr RecMutex00) {.
    importc: "g_rec_mutex_init", libprag.}

proc init*(self: RecMutex) =
  g_rec_mutex_init(cast[ptr RecMutex00](self.impl))

proc g_rec_mutex_lock*(self: ptr RecMutex00) {.
    importc: "g_rec_mutex_lock", libprag.}

proc lock*(self: RecMutex) =
  g_rec_mutex_lock(cast[ptr RecMutex00](self.impl))

proc g_rec_mutex_trylock*(self: ptr RecMutex00): gboolean {.
    importc: "g_rec_mutex_trylock", libprag.}

proc trylock*(self: RecMutex): bool =
  toBool(g_rec_mutex_trylock(cast[ptr RecMutex00](self.impl)))

proc g_rec_mutex_unlock*(self: ptr RecMutex00) {.
    importc: "g_rec_mutex_unlock", libprag.}

proc unlock*(self: RecMutex) =
  g_rec_mutex_unlock(cast[ptr RecMutex00](self.impl))

type
  RegexError* {.size: sizeof(cint), pure.} = enum
    compile = 0
    optimize = 1
    replace = 2
    match = 3
    internal = 4
    strayBackslash = 101
    missingControlChar = 102
    unrecognizedEscape = 103
    quantifiersOutOfOrder = 104
    quantifierTooBig = 105
    unterminatedCharacterClass = 106
    invalidEscapeInCharacterClass = 107
    rangeOutOfOrder = 108
    nothingToRepeat = 109
    unrecognizedCharacter = 112
    posixNamedClassOutsideClass = 113
    unmatchedParenthesis = 114
    inexistentSubpatternReference = 115
    unterminatedComment = 118
    expressionTooLarge = 120
    memoryError = 121
    variableLengthLookbehind = 125
    malformedCondition = 126
    tooManyConditionalBranches = 127
    assertionExpected = 128
    unknownPosixClassName = 130
    posixCollatingElementsNotSupported = 131
    hexCodeTooLarge = 134
    invalidCondition = 135
    singleByteMatchInLookbehind = 136
    infiniteLoop = 140
    missingSubpatternNameTerminator = 142
    duplicateSubpatternName = 143
    malformedProperty = 146
    unknownProperty = 147
    subpatternNameTooLong = 148
    tooManySubpatterns = 149
    invalidOctalValue = 151
    tooManyBranchesInDefine = 154
    defineRepetion = 155
    inconsistentNewlineOptions = 156
    missingBackReference = 157
    invalidRelativeReference = 158
    backtrackingControlVerbArgumentForbidden = 159
    unknownBacktrackingControlVerb = 160
    numberTooBig = 161
    missingSubpatternName = 162
    missingDigit = 163
    invalidDataCharacter = 164
    extraSubpatternName = 165
    backtrackingControlVerbArgumentRequired = 166
    invalidControlChar = 168
    missingName = 169
    notSupportedInClass = 171
    tooManyForwardReferences = 172
    nameTooLong = 175
    characterValueTooLarge = 176

type
  String00* {.pure.} = object
    str*: cstring
    len*: uint64
    allocatedLen*: uint64
  String* = ref object
    impl*: ptr String00

proc g_string_append*(self: ptr String00; val: cstring): ptr String00 {.
    importc: "g_string_append", libprag.}

proc append*(self: String; val: string): String =
  new(result)
  result.impl = g_string_append(cast[ptr String00](self.impl), cstring(val))

proc g_string_append_c*(self: ptr String00; c: int8): ptr String00 {.
    importc: "g_string_append_c", libprag.}

proc appendC*(self: String; c: int8): String =
  new(result)
  result.impl = g_string_append_c(cast[ptr String00](self.impl), c)

proc g_string_append_len*(self: ptr String00; val: cstring; len: int64): ptr String00 {.
    importc: "g_string_append_len", libprag.}

proc appendLen*(self: String; val: string; len: int64): String =
  new(result)
  result.impl = g_string_append_len(cast[ptr String00](self.impl), cstring(val), len)

proc g_string_append_unichar*(self: ptr String00; wc: gunichar): ptr String00 {.
    importc: "g_string_append_unichar", libprag.}

proc appendUnichar*(self: String; wc: gunichar): String =
  new(result)
  result.impl = g_string_append_unichar(cast[ptr String00](self.impl), wc)

proc g_string_append_uri_escaped*(self: ptr String00; unescaped: cstring; reservedCharsAllowed: cstring; 
    allowUtf8: gboolean): ptr String00 {.
    importc: "g_string_append_uri_escaped", libprag.}

proc appendUriEscaped*(self: String; unescaped: string; reservedCharsAllowed: string; 
    allowUtf8: bool): String =
  new(result)
  result.impl = g_string_append_uri_escaped(cast[ptr String00](self.impl), cstring(unescaped), cstring(reservedCharsAllowed), gboolean(allowUtf8))

proc g_string_ascii_down*(self: ptr String00): ptr String00 {.
    importc: "g_string_ascii_down", libprag.}

proc asciiDown*(self: String): String =
  new(result)
  result.impl = g_string_ascii_down(cast[ptr String00](self.impl))

proc g_string_ascii_up*(self: ptr String00): ptr String00 {.
    importc: "g_string_ascii_up", libprag.}

proc asciiUp*(self: String): String =
  new(result)
  result.impl = g_string_ascii_up(cast[ptr String00](self.impl))

proc g_string_assign*(self: ptr String00; rval: cstring): ptr String00 {.
    importc: "g_string_assign", libprag.}

proc assign*(self: String; rval: string): String =
  new(result)
  result.impl = g_string_assign(cast[ptr String00](self.impl), cstring(rval))

proc g_string_down*(self: ptr String00): ptr String00 {.
    importc: "g_string_down", libprag.}

proc down*(self: String): String =
  new(result)
  result.impl = g_string_down(cast[ptr String00](self.impl))

proc g_string_equal*(self: ptr String00; v2: ptr String00): gboolean {.
    importc: "g_string_equal", libprag.}

proc equal*(self: String; v2: String): bool =
  toBool(g_string_equal(cast[ptr String00](self.impl), cast[ptr String00](v2.impl)))

proc g_string_erase*(self: ptr String00; pos: int64; len: int64): ptr String00 {.
    importc: "g_string_erase", libprag.}

proc erase*(self: String; pos: int64; len: int64): String =
  new(result)
  result.impl = g_string_erase(cast[ptr String00](self.impl), pos, len)

proc g_string_free*(self: ptr String00; freeSegment: gboolean): cstring {.
    importc: "g_string_free", libprag.}

proc free*(self: String; freeSegment: bool): string =
  let resul0 = g_string_free(cast[ptr String00](self.impl), gboolean(freeSegment))
  result = $resul0
  cogfree(resul0)

proc g_string_free_to_bytes*(self: ptr String00): ptr Bytes00 {.
    importc: "g_string_free_to_bytes", libprag.}

proc freeToBytes*(self: String): Bytes =
  new(result)
  result.impl = g_string_free_to_bytes(cast[ptr String00](self.impl))

proc g_string_hash*(self: ptr String00): uint32 {.
    importc: "g_string_hash", libprag.}

proc hash*(self: String): int =
  int(g_string_hash(cast[ptr String00](self.impl)))

proc g_string_insert*(self: ptr String00; pos: int64; val: cstring): ptr String00 {.
    importc: "g_string_insert", libprag.}

proc insert*(self: String; pos: int64; val: string): String =
  new(result)
  result.impl = g_string_insert(cast[ptr String00](self.impl), pos, cstring(val))

proc g_string_insert_c*(self: ptr String00; pos: int64; c: int8): ptr String00 {.
    importc: "g_string_insert_c", libprag.}

proc insertC*(self: String; pos: int64; c: int8): String =
  new(result)
  result.impl = g_string_insert_c(cast[ptr String00](self.impl), pos, c)

proc g_string_insert_len*(self: ptr String00; pos: int64; val: cstring; len: int64): ptr String00 {.
    importc: "g_string_insert_len", libprag.}

proc insertLen*(self: String; pos: int64; val: string; len: int64): String =
  new(result)
  result.impl = g_string_insert_len(cast[ptr String00](self.impl), pos, cstring(val), len)

proc g_string_insert_unichar*(self: ptr String00; pos: int64; wc: gunichar): ptr String00 {.
    importc: "g_string_insert_unichar", libprag.}

proc insertUnichar*(self: String; pos: int64; wc: gunichar): String =
  new(result)
  result.impl = g_string_insert_unichar(cast[ptr String00](self.impl), pos, wc)

proc g_string_overwrite*(self: ptr String00; pos: uint64; val: cstring): ptr String00 {.
    importc: "g_string_overwrite", libprag.}

proc overwrite*(self: String; pos: uint64; val: string): String =
  new(result)
  result.impl = g_string_overwrite(cast[ptr String00](self.impl), pos, cstring(val))

proc g_string_overwrite_len*(self: ptr String00; pos: uint64; val: cstring; len: int64): ptr String00 {.
    importc: "g_string_overwrite_len", libprag.}

proc overwriteLen*(self: String; pos: uint64; val: string; len: int64): String =
  new(result)
  result.impl = g_string_overwrite_len(cast[ptr String00](self.impl), pos, cstring(val), len)

proc g_string_prepend*(self: ptr String00; val: cstring): ptr String00 {.
    importc: "g_string_prepend", libprag.}

proc prepend*(self: String; val: string): String =
  new(result)
  result.impl = g_string_prepend(cast[ptr String00](self.impl), cstring(val))

proc g_string_prepend_c*(self: ptr String00; c: int8): ptr String00 {.
    importc: "g_string_prepend_c", libprag.}

proc prependC*(self: String; c: int8): String =
  new(result)
  result.impl = g_string_prepend_c(cast[ptr String00](self.impl), c)

proc g_string_prepend_len*(self: ptr String00; val: cstring; len: int64): ptr String00 {.
    importc: "g_string_prepend_len", libprag.}

proc prependLen*(self: String; val: string; len: int64): String =
  new(result)
  result.impl = g_string_prepend_len(cast[ptr String00](self.impl), cstring(val), len)

proc g_string_prepend_unichar*(self: ptr String00; wc: gunichar): ptr String00 {.
    importc: "g_string_prepend_unichar", libprag.}

proc prependUnichar*(self: String; wc: gunichar): String =
  new(result)
  result.impl = g_string_prepend_unichar(cast[ptr String00](self.impl), wc)

proc g_string_set_size*(self: ptr String00; len: uint64): ptr String00 {.
    importc: "g_string_set_size", libprag.}

proc setSize*(self: String; len: uint64): String =
  new(result)
  result.impl = g_string_set_size(cast[ptr String00](self.impl), len)

proc `size=`*(self: String; len: uint64): String =
  new(result)
  result.impl = g_string_set_size(cast[ptr String00](self.impl), len)

proc g_string_truncate*(self: ptr String00; len: uint64): ptr String00 {.
    importc: "g_string_truncate", libprag.}

proc truncate*(self: String; len: uint64): String =
  new(result)
  result.impl = g_string_truncate(cast[ptr String00](self.impl), len)

proc g_string_up*(self: ptr String00): ptr String00 {.
    importc: "g_string_up", libprag.}

proc up*(self: String): String =
  new(result)
  result.impl = g_string_up(cast[ptr String00](self.impl))

type
  RegexEvalCallback* = proc (matchInfo: ptr MatchInfo00; resu: ptr String00; userData: pointer): gboolean {.cdecl.}

const SEARCHPATH_SEPARATOR* = 59'i32

const SEARCHPATH_SEPARATOR_S* = ";"

const SIZEOF_LONG* = 8'i32

const SIZEOF_SIZE_T* = 8'i32

const SIZEOF_SSIZE_T* = 8'i32

const SIZEOF_VOID_P* = 8'i32

type
  SList00* {.pure.} = object
    data*: pointer
    next*: ptr pointer
  SList* = ref object
    impl*: ptr SList00

const SOURCE_CONTINUE* = true

const SOURCE_REMOVE* = false

const SQRT2* = 1.414214'f64

const STR_DELIMITERS* = "_-|> <."

const SYSDEF_AF_INET* = 2'i32

const SYSDEF_AF_INET6* = 10'i32

const SYSDEF_AF_UNIX* = 1'i32

const SYSDEF_MSG_DONTROUTE* = 4'i32

const SYSDEF_MSG_OOB* = 1'i32

const SYSDEF_MSG_PEEK* = 2'i32

type
  ScannerConfig00* {.pure.} = object
    csetSkipCharacters*: cstring
    csetIdentifierFirst*: cstring
    csetIdentifierNth*: cstring
    cpairCommentSingle*: cstring
    caseSensitive*: uint32
    skipCommentMulti*: uint32
    skipCommentSingle*: uint32
    scanCommentMulti*: uint32
    scanIdentifier*: uint32
    scanIdentifier_1char*: uint32
    scanIdentifier_NULL*: uint32
    scanSymbols*: uint32
    scanBinary*: uint32
    scanOctal*: uint32
    scanFloat*: uint32
    scanHex*: uint32
    scanHexDollar*: uint32
    scanStringSq*: uint32
    scanStringDq*: uint32
    numbers_2Int*: uint32
    int_2Float*: uint32
    identifier_2String*: uint32
    char_2Token*: uint32
    symbol_2Token*: uint32
    scope_0Fallback*: uint32
    storeInt64*: uint32
    paddingDummy*: uint32
  ScannerConfig* = ref object
    impl*: ptr ScannerConfig00

type
  TokenType* {.size: sizeof(cint), pure.} = enum
    eof = 0
    leftParen = 40
    rightParen = 41
    comma = 44
    equalSign = 61
    leftBrace = 91
    rightBrace = 93
    leftCurly = 123
    rightCurly = 125
    none = 256
    error = 257
    char = 258
    binary = 259
    octal = 260
    int = 261
    hex = 262
    float = 263
    string = 264
    symbol = 265
    identifier = 266
    identifierNull = 267
    commentSingle = 268
    commentMulti = 269

type
  Sequence00* {.pure.} = object
  Sequence* = ref object
    impl*: ptr Sequence00

proc g_sequence_free*(self: ptr Sequence00) {.
    importc: "g_sequence_free", libprag.}

proc free*(self: Sequence) =
  g_sequence_free(cast[ptr Sequence00](self.impl))

proc g_sequence_get_length*(self: ptr Sequence00): int32 {.
    importc: "g_sequence_get_length", libprag.}

proc getLength*(self: Sequence): int =
  int(g_sequence_get_length(cast[ptr Sequence00](self.impl)))

proc length*(self: Sequence): int =
  int(g_sequence_get_length(cast[ptr Sequence00](self.impl)))

proc g_sequence_is_empty*(self: ptr Sequence00): gboolean {.
    importc: "g_sequence_is_empty", libprag.}

proc isEmpty*(self: Sequence): bool =
  toBool(g_sequence_is_empty(cast[ptr Sequence00](self.impl)))

type
  SequenceIter00* {.pure.} = object
  SequenceIter* = ref object
    impl*: ptr SequenceIter00

proc g_sequence_iter_compare*(self: ptr SequenceIter00; b: ptr SequenceIter00): int32 {.
    importc: "g_sequence_iter_compare", libprag.}

proc compare*(self: SequenceIter; b: SequenceIter): int =
  int(g_sequence_iter_compare(cast[ptr SequenceIter00](self.impl), cast[ptr SequenceIter00](b.impl)))

proc g_sequence_iter_get_position*(self: ptr SequenceIter00): int32 {.
    importc: "g_sequence_iter_get_position", libprag.}

proc getPosition*(self: SequenceIter): int =
  int(g_sequence_iter_get_position(cast[ptr SequenceIter00](self.impl)))

proc position*(self: SequenceIter): int =
  int(g_sequence_iter_get_position(cast[ptr SequenceIter00](self.impl)))

proc g_sequence_iter_is_begin*(self: ptr SequenceIter00): gboolean {.
    importc: "g_sequence_iter_is_begin", libprag.}

proc isBegin*(self: SequenceIter): bool =
  toBool(g_sequence_iter_is_begin(cast[ptr SequenceIter00](self.impl)))

proc g_sequence_iter_is_end*(self: ptr SequenceIter00): gboolean {.
    importc: "g_sequence_iter_is_end", libprag.}

proc isEnd*(self: SequenceIter): bool =
  toBool(g_sequence_iter_is_end(cast[ptr SequenceIter00](self.impl)))

proc g_sequence_get*(iter: ptr SequenceIter00): pointer {.
    importc: "g_sequence_get", libprag.}

proc get*(iter: SequenceIter): pointer =
  g_sequence_get(cast[ptr SequenceIter00](iter.impl))

proc g_sequence_move*(src: ptr SequenceIter00; dest: ptr SequenceIter00) {.
    importc: "g_sequence_move", libprag.}

proc move*(src: SequenceIter; dest: SequenceIter) =
  g_sequence_move(cast[ptr SequenceIter00](src.impl), cast[ptr SequenceIter00](dest.impl))

proc g_sequence_move_range*(dest: ptr SequenceIter00; begin: ptr SequenceIter00; 
    `end`: ptr SequenceIter00) {.
    importc: "g_sequence_move_range", libprag.}

proc moveRange*(dest: SequenceIter; begin: SequenceIter; `end`: SequenceIter) =
  g_sequence_move_range(cast[ptr SequenceIter00](dest.impl), cast[ptr SequenceIter00](begin.impl), cast[ptr SequenceIter00](`end`.impl))

proc g_sequence_remove*(iter: ptr SequenceIter00) {.
    importc: "g_sequence_remove", libprag.}

proc remove*(iter: SequenceIter) =
  g_sequence_remove(cast[ptr SequenceIter00](iter.impl))

proc g_sequence_remove_range*(begin: ptr SequenceIter00; `end`: ptr SequenceIter00) {.
    importc: "g_sequence_remove_range", libprag.}

proc removeRange*(begin: SequenceIter; `end`: SequenceIter) =
  g_sequence_remove_range(cast[ptr SequenceIter00](begin.impl), cast[ptr SequenceIter00](`end`.impl))

proc g_sequence_set*(iter: ptr SequenceIter00; data: pointer) {.
    importc: "g_sequence_set", libprag.}

proc set*(iter: SequenceIter; data: pointer) =
  g_sequence_set(cast[ptr SequenceIter00](iter.impl), data)

proc g_sequence_swap*(a: ptr SequenceIter00; b: ptr SequenceIter00) {.
    importc: "g_sequence_swap", libprag.}

proc swap*(a: SequenceIter; b: SequenceIter) =
  g_sequence_swap(cast[ptr SequenceIter00](a.impl), cast[ptr SequenceIter00](b.impl))

type
  SequenceIterCompareFunc* = proc (a: ptr SequenceIter00; b: ptr SequenceIter00; data: pointer): int32 {.cdecl.}

type
  ShellError* {.size: sizeof(cint), pure.} = enum
    badQuoting = 0
    emptyString = 1
    failed = 2

type
  SliceConfig* {.size: sizeof(cint), pure.} = enum
    alwaysMalloc = 1
    bypassMagazines = 2
    workingSetMsecs = 3
    colorIncrement = 4
    chunkSizes = 5
    contentionCounter = 6

type
  SourceDummyMarshal* = proc () {.cdecl.}

type
  SourceFunc* = proc (userData: pointer): gboolean {.cdecl.}

proc g_main_context_invoke_full*(self: ptr MainContext00; priority: int32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify) {.
    importc: "g_main_context_invoke_full", libprag.}

proc invokeFull*(self: MainContext; priority: int; function: SourceFunc; 
    data: pointer; notify: DestroyNotify) =
  g_main_context_invoke_full(cast[ptr MainContext00](self.impl), int32(priority), function, data, notify)

type
  SourcePrivate00* {.pure.} = object
  SourcePrivate* = ref object
    impl*: ptr SourcePrivate00
type

  SourceFuncs00* {.pure.} = object
    prepare*: proc(source: ptr Source00; timeout: ptr int32): gboolean {.cdecl.}
    check*: proc(source: ptr Source00): gboolean {.cdecl.}
    dispatch*: pointer
    finalize*: proc(source: ptr Source00) {.cdecl.}
    closureCallback*: SourceFunc
    closureMarshal*: SourceDummyMarshal
  SourceFuncs* = ref object
    impl*: ptr SourceFuncs00

  Source00* {.pure.} = object
    callbackData*: pointer
    callbackFuncs*: ptr SourceCallbackFuncs00
    sourceFuncs*: ptr SourceFuncs00
    refCount*: uint32
    context*: ptr MainContext00
    priority*: int32
    flags*: uint32
    sourceId*: uint32
    pollFds*: ptr pointer
    prev*: ptr Source00
    next*: ptr Source00
    name*: cstring
    priv*: ptr SourcePrivate00
  Source* = ref object
    impl*: ptr Source00

proc g_source_new*(sourceFuncs: ptr SourceFuncs00; structSize: uint32): ptr Source00 {.
    importc: "g_source_new", libprag.}

proc newSource*(sourceFuncs: SourceFuncs; structSize: int): Source =
  new(result)
  result.impl = g_source_new(cast[ptr SourceFuncs00](sourceFuncs.impl), uint32(structSize))

proc initSource*[T](result: var T; sourceFuncs: SourceFuncs; structSize: int) =
  assert(result is Source)
  new(result)
  result.impl = g_source_new(cast[ptr SourceFuncs00](sourceFuncs.impl), uint32(structSize))

proc g_source_add_child_source*(self: ptr Source00; childSource: ptr Source00) {.
    importc: "g_source_add_child_source", libprag.}

proc addChildSource*(self: Source; childSource: Source) =
  g_source_add_child_source(cast[ptr Source00](self.impl), cast[ptr Source00](childSource.impl))

proc g_source_add_poll*(self: ptr Source00; fd: ptr PollFD00) {.
    importc: "g_source_add_poll", libprag.}

proc addPoll*(self: Source; fd: PollFD) =
  g_source_add_poll(cast[ptr Source00](self.impl), cast[ptr PollFD00](fd.impl))

proc g_source_add_unix_fd*(self: ptr Source00; fd: int32; events: IOCondition): pointer {.
    importc: "g_source_add_unix_fd", libprag.}

proc addUnixFd*(self: Source; fd: int; events: IOCondition): pointer =
  g_source_add_unix_fd(cast[ptr Source00](self.impl), int32(fd), events)

proc g_source_attach*(self: ptr Source00; context: ptr MainContext00): uint32 {.
    importc: "g_source_attach", libprag.}

proc attach*(self: Source; context: MainContext): int =
  int(g_source_attach(cast[ptr Source00](self.impl), cast[ptr MainContext00](context.impl)))

proc g_source_destroy*(self: ptr Source00) {.
    importc: "g_source_destroy", libprag.}

proc destroy*(self: Source) =
  g_source_destroy(cast[ptr Source00](self.impl))

proc g_source_get_can_recurse*(self: ptr Source00): gboolean {.
    importc: "g_source_get_can_recurse", libprag.}

proc getCanRecurse*(self: Source): bool =
  toBool(g_source_get_can_recurse(cast[ptr Source00](self.impl)))

proc canRecurse*(self: Source): bool =
  toBool(g_source_get_can_recurse(cast[ptr Source00](self.impl)))

proc g_source_get_context*(self: ptr Source00): ptr MainContext00 {.
    importc: "g_source_get_context", libprag.}

proc getContext*(self: Source): MainContext =
  new(result)
  result.impl = g_source_get_context(cast[ptr Source00](self.impl))

proc context*(self: Source): MainContext =
  new(result)
  result.impl = g_source_get_context(cast[ptr Source00](self.impl))

proc g_source_get_current_time*(self: ptr Source00; timeval: ptr TimeVal00) {.
    importc: "g_source_get_current_time", libprag.}

proc getCurrentTime*(self: Source; timeval: TimeVal) =
  g_source_get_current_time(cast[ptr Source00](self.impl), cast[ptr TimeVal00](timeval.impl))

proc currentTime*(self: Source; timeval: TimeVal) =
  g_source_get_current_time(cast[ptr Source00](self.impl), cast[ptr TimeVal00](timeval.impl))

proc g_source_get_id*(self: ptr Source00): uint32 {.
    importc: "g_source_get_id", libprag.}

proc getId*(self: Source): int =
  int(g_source_get_id(cast[ptr Source00](self.impl)))

proc id*(self: Source): int =
  int(g_source_get_id(cast[ptr Source00](self.impl)))

proc g_source_get_name*(self: ptr Source00): cstring {.
    importc: "g_source_get_name", libprag.}

proc getName*(self: Source): string =
  let resul0 = g_source_get_name(cast[ptr Source00](self.impl))
  result = $resul0

proc name*(self: Source): string =
  let resul0 = g_source_get_name(cast[ptr Source00](self.impl))
  result = $resul0

proc g_source_get_priority*(self: ptr Source00): int32 {.
    importc: "g_source_get_priority", libprag.}

proc getPriority*(self: Source): int =
  int(g_source_get_priority(cast[ptr Source00](self.impl)))

proc priority*(self: Source): int =
  int(g_source_get_priority(cast[ptr Source00](self.impl)))

proc g_source_get_ready_time*(self: ptr Source00): int64 {.
    importc: "g_source_get_ready_time", libprag.}

proc getReadyTime*(self: Source): int64 =
  g_source_get_ready_time(cast[ptr Source00](self.impl))

proc readyTime*(self: Source): int64 =
  g_source_get_ready_time(cast[ptr Source00](self.impl))

proc g_source_get_time*(self: ptr Source00): int64 {.
    importc: "g_source_get_time", libprag.}

proc getTime*(self: Source): int64 =
  g_source_get_time(cast[ptr Source00](self.impl))

proc time*(self: Source): int64 =
  g_source_get_time(cast[ptr Source00](self.impl))

proc g_source_is_destroyed*(self: ptr Source00): gboolean {.
    importc: "g_source_is_destroyed", libprag.}

proc isDestroyed*(self: Source): bool =
  toBool(g_source_is_destroyed(cast[ptr Source00](self.impl)))

proc g_source_modify_unix_fd*(self: ptr Source00; tag: pointer; newEvents: IOCondition) {.
    importc: "g_source_modify_unix_fd", libprag.}

proc modifyUnixFd*(self: Source; tag: pointer; newEvents: IOCondition) =
  g_source_modify_unix_fd(cast[ptr Source00](self.impl), tag, newEvents)

proc g_source_query_unix_fd*(self: ptr Source00; tag: pointer): IOCondition {.
    importc: "g_source_query_unix_fd", libprag.}

proc queryUnixFd*(self: Source; tag: pointer): IOCondition =
  g_source_query_unix_fd(cast[ptr Source00](self.impl), tag)

proc g_source_ref*(self: ptr Source00): ptr Source00 {.
    importc: "g_source_ref", libprag.}

proc `ref`*(self: Source): Source =
  new(result)
  result.impl = g_source_ref(cast[ptr Source00](self.impl))

proc g_source_remove_child_source*(self: ptr Source00; childSource: ptr Source00) {.
    importc: "g_source_remove_child_source", libprag.}

proc removeChildSource*(self: Source; childSource: Source) =
  g_source_remove_child_source(cast[ptr Source00](self.impl), cast[ptr Source00](childSource.impl))

proc g_source_remove_poll*(self: ptr Source00; fd: ptr PollFD00) {.
    importc: "g_source_remove_poll", libprag.}

proc removePoll*(self: Source; fd: PollFD) =
  g_source_remove_poll(cast[ptr Source00](self.impl), cast[ptr PollFD00](fd.impl))

proc g_source_remove_unix_fd*(self: ptr Source00; tag: pointer) {.
    importc: "g_source_remove_unix_fd", libprag.}

proc removeUnixFd*(self: Source; tag: pointer) =
  g_source_remove_unix_fd(cast[ptr Source00](self.impl), tag)

proc g_source_set_callback*(self: ptr Source00; `func`: SourceFunc; data: pointer; 
    notify: DestroyNotify) {.
    importc: "g_source_set_callback", libprag.}

proc setCallback*(self: Source; `func`: SourceFunc; data: pointer; notify: DestroyNotify) =
  g_source_set_callback(cast[ptr Source00](self.impl), `func`, data, notify)

proc g_source_set_callback_indirect*(self: ptr Source00; callbackData: pointer; callbackFuncs: ptr SourceCallbackFuncs00) {.
    importc: "g_source_set_callback_indirect", libprag.}

proc setCallbackIndirect*(self: Source; callbackData: pointer; callbackFuncs: SourceCallbackFuncs) =
  g_source_set_callback_indirect(cast[ptr Source00](self.impl), callbackData, cast[ptr SourceCallbackFuncs00](callbackFuncs.impl))

proc g_source_set_can_recurse*(self: ptr Source00; canRecurse: gboolean) {.
    importc: "g_source_set_can_recurse", libprag.}

proc setCanRecurse*(self: Source; canRecurse: bool) =
  g_source_set_can_recurse(cast[ptr Source00](self.impl), gboolean(canRecurse))

proc `canRecurse=`*(self: Source; canRecurse: bool) =
  g_source_set_can_recurse(cast[ptr Source00](self.impl), gboolean(canRecurse))

proc g_source_set_funcs*(self: ptr Source00; funcs: ptr SourceFuncs00) {.
    importc: "g_source_set_funcs", libprag.}

proc setFuncs*(self: Source; funcs: SourceFuncs) =
  g_source_set_funcs(cast[ptr Source00](self.impl), cast[ptr SourceFuncs00](funcs.impl))

proc `funcs=`*(self: Source; funcs: SourceFuncs) =
  g_source_set_funcs(cast[ptr Source00](self.impl), cast[ptr SourceFuncs00](funcs.impl))

proc g_source_set_name*(self: ptr Source00; name: cstring) {.
    importc: "g_source_set_name", libprag.}

proc setName*(self: Source; name: string) =
  g_source_set_name(cast[ptr Source00](self.impl), cstring(name))

proc `name=`*(self: Source; name: string) =
  g_source_set_name(cast[ptr Source00](self.impl), cstring(name))

proc g_source_set_priority*(self: ptr Source00; priority: int32) {.
    importc: "g_source_set_priority", libprag.}

proc setPriority*(self: Source; priority: int) =
  g_source_set_priority(cast[ptr Source00](self.impl), int32(priority))

proc `priority=`*(self: Source; priority: int) =
  g_source_set_priority(cast[ptr Source00](self.impl), int32(priority))

proc g_source_set_ready_time*(self: ptr Source00; readyTime: int64) {.
    importc: "g_source_set_ready_time", libprag.}

proc setReadyTime*(self: Source; readyTime: int64) =
  g_source_set_ready_time(cast[ptr Source00](self.impl), readyTime)

proc `readyTime=`*(self: Source; readyTime: int64) =
  g_source_set_ready_time(cast[ptr Source00](self.impl), readyTime)

proc g_source_unref*(self: ptr Source00) {.
    importc: "g_source_unref", libprag.}

proc unref*(self: Source) =
  g_source_unref(cast[ptr Source00](self.impl))

proc g_source_remove*(tag: uint32): gboolean {.
    importc: "g_source_remove", libprag.}

proc remove*(tag: uint32): gboolean {.
    importc: "g_source_remove", libprag.}

proc g_source_remove_by_funcs_user_data*(funcs: ptr SourceFuncs00; userData: pointer): gboolean {.
    importc: "g_source_remove_by_funcs_user_data", libprag.}

proc removeByFuncsUserData*(funcs: SourceFuncs; userData: pointer): bool =
  toBool(g_source_remove_by_funcs_user_data(cast[ptr SourceFuncs00](funcs.impl), userData))

proc g_source_remove_by_user_data*(userData: pointer): gboolean {.
    importc: "g_source_remove_by_user_data", libprag.}

proc removeByUserData*(userData: pointer): gboolean {.
    importc: "g_source_remove_by_user_data", libprag.}

proc g_source_set_name_by_id*(tag: uint32; name: cstring) {.
    importc: "g_source_set_name_by_id", libprag.}

proc setNameById*(tag: uint32; name: cstring) {.
    importc: "g_source_set_name_by_id", libprag.}

proc `nameById=`*(tag: uint32; name: cstring) {.
    importc: "g_source_set_name_by_id", libprag.}

proc g_main_context_find_source_by_funcs_user_data*(self: ptr MainContext00; funcs: ptr SourceFuncs00; 
    userData: pointer): ptr Source00 {.
    importc: "g_main_context_find_source_by_funcs_user_data", libprag.}

proc findSourceByFuncsUserData*(self: MainContext; funcs: SourceFuncs; userData: pointer): Source =
  new(result)
  result.impl = g_main_context_find_source_by_funcs_user_data(cast[ptr MainContext00](self.impl), cast[ptr SourceFuncs00](funcs.impl), userData)

proc g_main_context_find_source_by_id*(self: ptr MainContext00; sourceId: uint32): ptr Source00 {.
    importc: "g_main_context_find_source_by_id", libprag.}

proc findSourceById*(self: MainContext; sourceId: int): Source =
  new(result)
  result.impl = g_main_context_find_source_by_id(cast[ptr MainContext00](self.impl), uint32(sourceId))

proc g_main_context_find_source_by_user_data*(self: ptr MainContext00; userData: pointer): ptr Source00 {.
    importc: "g_main_context_find_source_by_user_data", libprag.}

proc findSourceByUserData*(self: MainContext; userData: pointer): Source =
  new(result)
  result.impl = g_main_context_find_source_by_user_data(cast[ptr MainContext00](self.impl), userData)

type
  SpawnChildSetupFunc* = proc (userData: pointer) {.cdecl.}
type

  IOFuncs00* {.pure.} = object
    ioRead*: proc(channel: ptr IOChannel00; buf: cstring; count: uint64; 
    bytesRead: ptr uint64): IOStatus {.cdecl.}
    ioWrite*: proc(channel: ptr IOChannel00; buf: cstring; count: uint64; 
    bytesWritten: ptr uint64): IOStatus {.cdecl.}
    ioSeek*: proc(channel: ptr IOChannel00; offset: int64; `type`: SeekType): IOStatus {.cdecl.}
    ioClose*: proc(channel: ptr IOChannel00): IOStatus {.cdecl.}
    ioCreateWatch*: proc(channel: ptr IOChannel00; condition: IOCondition): ptr Source00 {.cdecl.}
    ioFree*: proc(channel: ptr IOChannel00) {.cdecl.}
    ioSetFlags*: proc(channel: ptr IOChannel00; flags: IOFlags): IOStatus {.cdecl.}
    ioGetFlags*: proc(channel: ptr IOChannel00): IOFlags {.cdecl.}
  IOFuncs* = ref object
    impl*: ptr IOFuncs00

  IOChannel00* {.pure.} = object
    refCount*: int32
    funcs*: ptr IOFuncs00
    encoding*: cstring
    readCd*: ptr IConv00
    writeCd*: ptr IConv00
    lineTerm*: cstring
    lineTermLen*: uint32
    bufSize*: uint64
    readBuf*: ptr String00
    encodedReadBuf*: ptr String00
    writeBuf*: ptr String00
    partialWriteBuf*: array[6, int8]
    useBuffer*: uint32
    doEncode*: uint32
    closeOnUnref*: uint32
    isReadable*: uint32
    isWriteable*: uint32
    isSeekable*: uint32
    reserved1*: pointer
    reserved2*: pointer
  IOChannel* = ref object
    impl*: ptr IOChannel00

proc g_io_channel_new_file*(filename: ucstring; mode: cstring): ptr IOChannel00 {.
    importc: "g_io_channel_new_file", libprag.}

proc newIOChannelFile*(filename: ucstring; mode: string): IOChannel =
  new(result)
  result.impl = g_io_channel_new_file(filename, cstring(mode))

proc initIOChannelFile*[T](result: var T; filename: ucstring; mode: string) =
  assert(result is IOChannel)
  new(result)
  result.impl = g_io_channel_new_file(filename, cstring(mode))

proc g_io_channel_unix_new*(fd: int32): ptr IOChannel00 {.
    importc: "g_io_channel_unix_new", libprag.}

proc unixNew*(fd: int): IOChannel =
  new(result)
  result.impl = g_io_channel_unix_new(int32(fd))

proc unixNew*[T](result: var T; fd: int) =
  assert(result is IOChannel)
  new(result)
  result.impl = g_io_channel_unix_new(int32(fd))

proc g_io_channel_close*(self: ptr IOChannel00) {.
    importc: "g_io_channel_close", libprag.}

proc close*(self: IOChannel) =
  g_io_channel_close(cast[ptr IOChannel00](self.impl))

proc g_io_channel_flush*(self: ptr IOChannel00): IOStatus {.
    importc: "g_io_channel_flush", libprag.}

proc flush*(self: IOChannel): IOStatus =
  g_io_channel_flush(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_buffer_condition*(self: ptr IOChannel00): IOCondition {.
    importc: "g_io_channel_get_buffer_condition", libprag.}

proc getBufferCondition*(self: IOChannel): IOCondition =
  g_io_channel_get_buffer_condition(cast[ptr IOChannel00](self.impl))

proc bufferCondition*(self: IOChannel): IOCondition =
  g_io_channel_get_buffer_condition(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_buffer_size*(self: ptr IOChannel00): uint64 {.
    importc: "g_io_channel_get_buffer_size", libprag.}

proc getBufferSize*(self: IOChannel): uint64 =
  g_io_channel_get_buffer_size(cast[ptr IOChannel00](self.impl))

proc bufferSize*(self: IOChannel): uint64 =
  g_io_channel_get_buffer_size(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_buffered*(self: ptr IOChannel00): gboolean {.
    importc: "g_io_channel_get_buffered", libprag.}

proc getBuffered*(self: IOChannel): bool =
  toBool(g_io_channel_get_buffered(cast[ptr IOChannel00](self.impl)))

proc buffered*(self: IOChannel): bool =
  toBool(g_io_channel_get_buffered(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_get_close_on_unref*(self: ptr IOChannel00): gboolean {.
    importc: "g_io_channel_get_close_on_unref", libprag.}

proc getCloseOnUnref*(self: IOChannel): bool =
  toBool(g_io_channel_get_close_on_unref(cast[ptr IOChannel00](self.impl)))

proc closeOnUnref*(self: IOChannel): bool =
  toBool(g_io_channel_get_close_on_unref(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_get_encoding*(self: ptr IOChannel00): cstring {.
    importc: "g_io_channel_get_encoding", libprag.}

proc getEncoding*(self: IOChannel): string =
  let resul0 = g_io_channel_get_encoding(cast[ptr IOChannel00](self.impl))
  result = $resul0

proc encoding*(self: IOChannel): string =
  let resul0 = g_io_channel_get_encoding(cast[ptr IOChannel00](self.impl))
  result = $resul0

proc g_io_channel_get_flags*(self: ptr IOChannel00): IOFlags {.
    importc: "g_io_channel_get_flags", libprag.}

proc getFlags*(self: IOChannel): IOFlags =
  g_io_channel_get_flags(cast[ptr IOChannel00](self.impl))

proc flags*(self: IOChannel): IOFlags =
  g_io_channel_get_flags(cast[ptr IOChannel00](self.impl))

proc g_io_channel_get_line_term*(self: ptr IOChannel00; length: ptr int32): cstring {.
    importc: "g_io_channel_get_line_term", libprag.}

proc getLineTerm*(self: IOChannel; length: ptr int32): string =
  let resul0 = g_io_channel_get_line_term(cast[ptr IOChannel00](self.impl), length)
  result = $resul0

proc lineTerm*(self: IOChannel; length: ptr int32): string =
  let resul0 = g_io_channel_get_line_term(cast[ptr IOChannel00](self.impl), length)
  result = $resul0

proc g_io_channel_init*(self: ptr IOChannel00) {.
    importc: "g_io_channel_init", libprag.}

proc init*(self: IOChannel) =
  g_io_channel_init(cast[ptr IOChannel00](self.impl))

proc g_io_channel_read*(self: ptr IOChannel00; buf: cstring; count: uint64; 
    bytesRead: ptr uint64): IOError {.
    importc: "g_io_channel_read", libprag.}

proc read*(self: IOChannel; buf: string; count: uint64; bytesRead: ptr uint64): IOError =
  g_io_channel_read(cast[ptr IOChannel00](self.impl), cstring(buf), count, bytesRead)

proc g_io_channel_read_chars*(self: ptr IOChannel00; buf: var uint8Array; count: uint64; 
    bytesRead: var uint64): IOStatus {.
    importc: "g_io_channel_read_chars", libprag.}

proc readChars*(self: IOChannel; buf: var uint8Array; count: uint64; 
    bytesRead: var uint64): IOStatus =
  g_io_channel_read_chars(cast[ptr IOChannel00](self.impl), buf, count, bytesRead)

proc g_io_channel_read_line*(self: ptr IOChannel00; strReturn: var cstring; length: var uint64; 
    terminatorPos: var uint64): IOStatus {.
    importc: "g_io_channel_read_line", libprag.}

proc readLine*(self: IOChannel; strReturn: var string; length: var uint64; 
    terminatorPos: var uint64): IOStatus =
  var strReturn_00 = cstring(strReturn)
  result = g_io_channel_read_line(cast[ptr IOChannel00](self.impl), strReturn_00, length, terminatorPos)
  strReturn = $(strReturn_00)

proc g_io_channel_read_line_string*(self: ptr IOChannel00; buffer: ptr String00; terminatorPos: ptr uint64): IOStatus {.
    importc: "g_io_channel_read_line_string", libprag.}

proc readLineString*(self: IOChannel; buffer: String; terminatorPos: ptr uint64): IOStatus =
  g_io_channel_read_line_string(cast[ptr IOChannel00](self.impl), cast[ptr String00](buffer.impl), terminatorPos)

proc g_io_channel_read_to_end*(self: ptr IOChannel00; strReturn: var uint8Array; 
    length: var uint64): IOStatus {.
    importc: "g_io_channel_read_to_end", libprag.}

proc readToEnd*(self: IOChannel; strReturn: var uint8Array; length: var uint64): IOStatus =
  g_io_channel_read_to_end(cast[ptr IOChannel00](self.impl), strReturn, length)

proc g_io_channel_read_unichar*(self: ptr IOChannel00; thechar: var gunichar): IOStatus {.
    importc: "g_io_channel_read_unichar", libprag.}

proc readUnichar*(self: IOChannel; thechar: var gunichar): IOStatus =
  g_io_channel_read_unichar(cast[ptr IOChannel00](self.impl), thechar)

proc g_io_channel_ref*(self: ptr IOChannel00): ptr IOChannel00 {.
    importc: "g_io_channel_ref", libprag.}

proc `ref`*(self: IOChannel): IOChannel =
  new(result)
  result.impl = g_io_channel_ref(cast[ptr IOChannel00](self.impl))

proc g_io_channel_seek*(self: ptr IOChannel00; offset: int64; `type`: SeekType): IOError {.
    importc: "g_io_channel_seek", libprag.}

proc seek*(self: IOChannel; offset: int64; `type`: SeekType): IOError =
  g_io_channel_seek(cast[ptr IOChannel00](self.impl), offset, `type`)

proc g_io_channel_seek_position*(self: ptr IOChannel00; offset: int64; `type`: SeekType): IOStatus {.
    importc: "g_io_channel_seek_position", libprag.}

proc seekPosition*(self: IOChannel; offset: int64; `type`: SeekType): IOStatus =
  g_io_channel_seek_position(cast[ptr IOChannel00](self.impl), offset, `type`)

proc g_io_channel_set_buffer_size*(self: ptr IOChannel00; size: uint64) {.
    importc: "g_io_channel_set_buffer_size", libprag.}

proc setBufferSize*(self: IOChannel; size: uint64) =
  g_io_channel_set_buffer_size(cast[ptr IOChannel00](self.impl), size)

proc `bufferSize=`*(self: IOChannel; size: uint64) =
  g_io_channel_set_buffer_size(cast[ptr IOChannel00](self.impl), size)

proc g_io_channel_set_buffered*(self: ptr IOChannel00; buffered: gboolean) {.
    importc: "g_io_channel_set_buffered", libprag.}

proc setBuffered*(self: IOChannel; buffered: bool) =
  g_io_channel_set_buffered(cast[ptr IOChannel00](self.impl), gboolean(buffered))

proc `buffered=`*(self: IOChannel; buffered: bool) =
  g_io_channel_set_buffered(cast[ptr IOChannel00](self.impl), gboolean(buffered))

proc g_io_channel_set_close_on_unref*(self: ptr IOChannel00; doClose: gboolean) {.
    importc: "g_io_channel_set_close_on_unref", libprag.}

proc setCloseOnUnref*(self: IOChannel; doClose: bool) =
  g_io_channel_set_close_on_unref(cast[ptr IOChannel00](self.impl), gboolean(doClose))

proc `closeOnUnref=`*(self: IOChannel; doClose: bool) =
  g_io_channel_set_close_on_unref(cast[ptr IOChannel00](self.impl), gboolean(doClose))

proc g_io_channel_set_encoding*(self: ptr IOChannel00; encoding: cstring): IOStatus {.
    importc: "g_io_channel_set_encoding", libprag.}

proc setEncoding*(self: IOChannel; encoding: string): IOStatus =
  g_io_channel_set_encoding(cast[ptr IOChannel00](self.impl), cstring(encoding))

proc `encoding=`*(self: IOChannel; encoding: string): IOStatus =
  g_io_channel_set_encoding(cast[ptr IOChannel00](self.impl), cstring(encoding))

proc g_io_channel_set_flags*(self: ptr IOChannel00; flags: IOFlags): IOStatus {.
    importc: "g_io_channel_set_flags", libprag.}

proc setFlags*(self: IOChannel; flags: IOFlags): IOStatus =
  g_io_channel_set_flags(cast[ptr IOChannel00](self.impl), flags)

proc `flags=`*(self: IOChannel; flags: IOFlags): IOStatus =
  g_io_channel_set_flags(cast[ptr IOChannel00](self.impl), flags)

proc g_io_channel_set_line_term*(self: ptr IOChannel00; lineTerm: cstring; length: int32) {.
    importc: "g_io_channel_set_line_term", libprag.}

proc setLineTerm*(self: IOChannel; lineTerm: string; length: int) =
  g_io_channel_set_line_term(cast[ptr IOChannel00](self.impl), cstring(lineTerm), int32(length))

proc g_io_channel_shutdown*(self: ptr IOChannel00; flush: gboolean): IOStatus {.
    importc: "g_io_channel_shutdown", libprag.}

proc shutdown*(self: IOChannel; flush: bool): IOStatus =
  g_io_channel_shutdown(cast[ptr IOChannel00](self.impl), gboolean(flush))

proc g_io_channel_unix_get_fd*(self: ptr IOChannel00): int32 {.
    importc: "g_io_channel_unix_get_fd", libprag.}

proc unixGetFd*(self: IOChannel): int =
  int(g_io_channel_unix_get_fd(cast[ptr IOChannel00](self.impl)))

proc g_io_channel_unref*(self: ptr IOChannel00) {.
    importc: "g_io_channel_unref", libprag.}

proc unref*(self: IOChannel) =
  g_io_channel_unref(cast[ptr IOChannel00](self.impl))

proc g_io_channel_write*(self: ptr IOChannel00; buf: cstring; count: uint64; 
    bytesWritten: ptr uint64): IOError {.
    importc: "g_io_channel_write", libprag.}

proc write*(self: IOChannel; buf: string; count: uint64; bytesWritten: ptr uint64): IOError =
  g_io_channel_write(cast[ptr IOChannel00](self.impl), cstring(buf), count, bytesWritten)

proc g_io_channel_write_chars*(self: ptr IOChannel00; buf: uint8Array; count: int64; 
    bytesWritten: var uint64): IOStatus {.
    importc: "g_io_channel_write_chars", libprag.}

proc writeChars*(self: IOChannel; buf: uint8Array; count: int64; bytesWritten: var uint64): IOStatus =
  g_io_channel_write_chars(cast[ptr IOChannel00](self.impl), buf, count, bytesWritten)

proc g_io_channel_write_unichar*(self: ptr IOChannel00; thechar: gunichar): IOStatus {.
    importc: "g_io_channel_write_unichar", libprag.}

proc writeUnichar*(self: IOChannel; thechar: gunichar): IOStatus =
  g_io_channel_write_unichar(cast[ptr IOChannel00](self.impl), thechar)

proc g_io_channel_error_from_errno*(en: int32): IOChannelError {.
    importc: "g_io_channel_error_from_errno", libprag.}

proc errorFromErrno*(en: int32): IOChannelError {.
    importc: "g_io_channel_error_from_errno", libprag.}

proc g_io_channel_error_quark*(): uint32 {.
    importc: "g_io_channel_error_quark", libprag.}

type
  SpawnError* {.size: sizeof(cint), pure.} = enum
    fork = 0
    read = 1
    chdir = 2
    acces = 3
    perm = 4
    tooBig = 5
    noexec = 6
    nametoolong = 7
    noent = 8
    nomem = 9
    notdir = 10
    loop = 11
    txtbusy = 12
    io = 13
    nfile = 14
    mfile = 15
    inval = 16
    isdir = 17
    libbad = 18
    failed = 19

type
  IOFunc* = proc (source: ptr IOChannel00; condition: IOCondition; data: pointer): gboolean {.cdecl.}

type
  SpawnFlag* {.size: sizeof(cint), pure.} = enum
    leaveDescriptorsOpen = 1
    doNotReapChild = 2
    searchPath = 3
    stdoutToDevNull = 4
    stderrToDevNull = 5
    childInheritsStdin = 6
    fileAndArgvZero = 7
    searchPathFromEnvp = 8
    cloexecPipes = 9

  SpawnFlags* {.size: sizeof(cint).} = set[SpawnFlag]

type
  StatBuf00* {.pure.} = object
  StatBuf* = ref object
    impl*: ptr StatBuf00

type
  StringChunk00* {.pure.} = object
  StringChunk* = ref object
    impl*: ptr StringChunk00

proc g_string_chunk_clear*(self: ptr StringChunk00) {.
    importc: "g_string_chunk_clear", libprag.}

proc clear*(self: StringChunk) =
  g_string_chunk_clear(cast[ptr StringChunk00](self.impl))

proc g_string_chunk_free*(self: ptr StringChunk00) {.
    importc: "g_string_chunk_free", libprag.}

proc free*(self: StringChunk) =
  g_string_chunk_free(cast[ptr StringChunk00](self.impl))

proc g_string_chunk_insert*(self: ptr StringChunk00; string: cstring): cstring {.
    importc: "g_string_chunk_insert", libprag.}

proc insert*(self: StringChunk; string: string): string =
  let resul0 = g_string_chunk_insert(cast[ptr StringChunk00](self.impl), cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_string_chunk_insert_const*(self: ptr StringChunk00; string: cstring): cstring {.
    importc: "g_string_chunk_insert_const", libprag.}

proc insertConst*(self: StringChunk; string: string): string =
  let resul0 = g_string_chunk_insert_const(cast[ptr StringChunk00](self.impl), cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_string_chunk_insert_len*(self: ptr StringChunk00; string: cstring; len: int64): cstring {.
    importc: "g_string_chunk_insert_len", libprag.}

proc insertLen*(self: StringChunk; string: string; len: int64): string =
  let resul0 = g_string_chunk_insert_len(cast[ptr StringChunk00](self.impl), cstring(string), len)
  result = $resul0
  cogfree(resul0)

const TIME_SPAN_DAY* = 86400000000'i64

const TIME_SPAN_HOUR* = 3600000000'i64

const TIME_SPAN_MILLISECOND* = 1000'i64

const TIME_SPAN_MINUTE* = 60000000'i64

const TIME_SPAN_SECOND* = 1000000'i64

type
  TestCase00* {.pure.} = object
  TestCase* = ref object
    impl*: ptr TestCase00

type
  TestConfig00* {.pure.} = object
    testInitialized*: gboolean
    testQuick*: gboolean
    testPerf*: gboolean
    testVerbose*: gboolean
    testQuiet*: gboolean
    testUndefined*: gboolean
  TestConfig* = ref object
    impl*: ptr TestConfig00

type
  TestDataFunc* = proc (userData: pointer) {.cdecl.}

type
  TestFileType* {.size: sizeof(cint), pure.} = enum
    dist = 0
    built = 1

type
  TestFixtureFunc* = proc (fixture: pointer; userData: pointer) {.cdecl.}

type
  TestFunc* = proc () {.cdecl.}

type
  TestLogBuffer00* {.pure.} = object
    data*: ptr String00
    msgs*: ptr pointer
  TestLogBuffer* = ref object
    impl*: ptr TestLogBuffer00

proc g_test_log_buffer_free*(self: ptr TestLogBuffer00) {.
    importc: "g_test_log_buffer_free", libprag.}

proc free*(self: TestLogBuffer) =
  g_test_log_buffer_free(cast[ptr TestLogBuffer00](self.impl))

proc g_test_log_buffer_push*(self: ptr TestLogBuffer00; nBytes: uint32; bytes: ptr uint8) {.
    importc: "g_test_log_buffer_push", libprag.}

proc push*(self: TestLogBuffer; nBytes: int; bytes: ptr uint8) =
  g_test_log_buffer_push(cast[ptr TestLogBuffer00](self.impl), uint32(nBytes), bytes)

type
  TestLogFatalFunc* = proc (logDomain: cstring; logLevel: LogLevelFlags; message: cstring; 
    userData: pointer): gboolean {.cdecl.}

type
  TestLogType* {.size: sizeof(cint), pure.} = enum
    none = 0
    error = 1
    startBinary = 2
    listCase = 3
    skipCase = 4
    startCase = 5
    stopCase = 6
    minResult = 7
    maxResult = 8
    message = 9
    startSuite = 10
    stopSuite = 11

type
  TestLogMsg00* {.pure.} = object
    logType*: TestLogType
    nStrings*: uint32
    strings*: cstring
    nNums*: uint32
    nums*: ptr int64
  TestLogMsg* = ref object
    impl*: ptr TestLogMsg00

proc g_test_log_msg_free*(self: ptr TestLogMsg00) {.
    importc: "g_test_log_msg_free", libprag.}

proc free*(self: TestLogMsg) =
  g_test_log_msg_free(cast[ptr TestLogMsg00](self.impl))

type
  TestSubprocessFlag* {.size: sizeof(cint), pure.} = enum
    stdin = 1
    stdout = 2
    stderr = 3

  TestSubprocessFlags* {.size: sizeof(cint).} = set[TestSubprocessFlag]

type
  TestSuite00* {.pure.} = object
  TestSuite* = ref object
    impl*: ptr TestSuite00

proc g_test_suite_add*(self: ptr TestSuite00; testCase: ptr TestCase00) {.
    importc: "g_test_suite_add", libprag.}

proc add*(self: TestSuite; testCase: TestCase) =
  g_test_suite_add(cast[ptr TestSuite00](self.impl), cast[ptr TestCase00](testCase.impl))

proc g_test_suite_add_suite*(self: ptr TestSuite00; nestedsuite: ptr TestSuite00) {.
    importc: "g_test_suite_add_suite", libprag.}

proc addSuite*(self: TestSuite; nestedsuite: TestSuite) =
  g_test_suite_add_suite(cast[ptr TestSuite00](self.impl), cast[ptr TestSuite00](nestedsuite.impl))

type
  TestTrapFlag* {.size: sizeof(cint), pure.} = enum
    silenceStdout = 8
    silenceStderr = 9
    inheritStdin = 10

  TestTrapFlags* {.size: sizeof(cint).} = set[TestTrapFlag]

type
  Thread00* {.pure.} = object
  Thread* = ref object
    impl*: ptr Thread00

proc g_thread_join*(self: ptr Thread00): pointer {.
    importc: "g_thread_join", libprag.}

proc join*(self: Thread): pointer =
  g_thread_join(cast[ptr Thread00](self.impl))

proc g_thread_ref*(self: ptr Thread00): ptr Thread00 {.
    importc: "g_thread_ref", libprag.}

proc `ref`*(self: Thread): Thread =
  new(result)
  result.impl = g_thread_ref(cast[ptr Thread00](self.impl))

proc g_thread_unref*(self: ptr Thread00) {.
    importc: "g_thread_unref", libprag.}

proc unref*(self: Thread) =
  g_thread_unref(cast[ptr Thread00](self.impl))

proc g_thread_error_quark*(): uint32 {.
    importc: "g_thread_error_quark", libprag.}

proc g_thread_exit*(retval: pointer) {.
    importc: "g_thread_exit", libprag.}

proc exit*(retval: pointer) {.
    importc: "g_thread_exit", libprag.}

proc g_thread_self*(): ptr Thread00 {.
    importc: "g_thread_self", libprag.}

proc self*(): Thread =
  new(result)
  result.impl = g_thread_self()

proc g_thread_yield*() {.
    importc: "g_thread_yield", libprag.}

proc `yield`*() {.
    importc: "g_thread_yield", libprag.}

type
  ThreadError* {.size: sizeof(cint), pure.} = enum
    threadErrorAgain = 0

type
  ThreadFunc* = proc (data: pointer): pointer {.cdecl.}

type
  ThreadPool00* {.pure.} = object
    `func`*: Func
    userData*: pointer
    exclusive*: gboolean
  ThreadPool* = ref object
    impl*: ptr ThreadPool00

proc g_thread_pool_free*(self: ptr ThreadPool00; immediate: gboolean; wait: gboolean) {.
    importc: "g_thread_pool_free", libprag.}

proc free*(self: ThreadPool; immediate: bool; wait: bool) =
  g_thread_pool_free(cast[ptr ThreadPool00](self.impl), gboolean(immediate), gboolean(wait))

proc g_thread_pool_get_max_threads*(self: ptr ThreadPool00): int32 {.
    importc: "g_thread_pool_get_max_threads", libprag.}

proc getMaxThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_max_threads(cast[ptr ThreadPool00](self.impl)))

proc maxThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_max_threads(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_get_num_threads*(self: ptr ThreadPool00): uint32 {.
    importc: "g_thread_pool_get_num_threads", libprag.}

proc getNumThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_num_threads(cast[ptr ThreadPool00](self.impl)))

proc numThreads*(self: ThreadPool): int =
  int(g_thread_pool_get_num_threads(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_move_to_front*(self: ptr ThreadPool00; data: pointer): gboolean {.
    importc: "g_thread_pool_move_to_front", libprag.}

proc moveToFront*(self: ThreadPool; data: pointer): bool =
  toBool(g_thread_pool_move_to_front(cast[ptr ThreadPool00](self.impl), data))

proc g_thread_pool_push*(self: ptr ThreadPool00; data: pointer): gboolean {.
    importc: "g_thread_pool_push", libprag.}

proc push*(self: ThreadPool; data: pointer): bool =
  toBool(g_thread_pool_push(cast[ptr ThreadPool00](self.impl), data))

proc g_thread_pool_set_max_threads*(self: ptr ThreadPool00; maxThreads: int32): gboolean {.
    importc: "g_thread_pool_set_max_threads", libprag.}

proc setMaxThreads*(self: ThreadPool; maxThreads: int): bool =
  toBool(g_thread_pool_set_max_threads(cast[ptr ThreadPool00](self.impl), int32(maxThreads)))

proc `maxThreads=`*(self: ThreadPool; maxThreads: int): bool =
  toBool(g_thread_pool_set_max_threads(cast[ptr ThreadPool00](self.impl), int32(maxThreads)))

proc g_thread_pool_unprocessed*(self: ptr ThreadPool00): uint32 {.
    importc: "g_thread_pool_unprocessed", libprag.}

proc unprocessed*(self: ThreadPool): int =
  int(g_thread_pool_unprocessed(cast[ptr ThreadPool00](self.impl)))

proc g_thread_pool_get_max_idle_time*(): uint32 {.
    importc: "g_thread_pool_get_max_idle_time", libprag.}

proc getMaxIdleTime*(): uint32 {.
    importc: "g_thread_pool_get_max_idle_time", libprag.}

proc maxIdleTime*(): uint32 {.
    importc: "g_thread_pool_get_max_idle_time", libprag.}

proc g_thread_pool_get_max_unused_threads*(): int32 {.
    importc: "g_thread_pool_get_max_unused_threads", libprag.}

proc getMaxUnusedThreads*(): int32 {.
    importc: "g_thread_pool_get_max_unused_threads", libprag.}

proc maxUnusedThreads*(): int32 {.
    importc: "g_thread_pool_get_max_unused_threads", libprag.}

proc g_thread_pool_get_num_unused_threads*(): uint32 {.
    importc: "g_thread_pool_get_num_unused_threads", libprag.}

proc getNumUnusedThreads*(): uint32 {.
    importc: "g_thread_pool_get_num_unused_threads", libprag.}

proc numUnusedThreads*(): uint32 {.
    importc: "g_thread_pool_get_num_unused_threads", libprag.}

proc g_thread_pool_set_max_idle_time*(interval: uint32) {.
    importc: "g_thread_pool_set_max_idle_time", libprag.}

proc setMaxIdleTime*(interval: uint32) {.
    importc: "g_thread_pool_set_max_idle_time", libprag.}

proc `maxIdleTime=`*(interval: uint32) {.
    importc: "g_thread_pool_set_max_idle_time", libprag.}

proc g_thread_pool_set_max_unused_threads*(maxThreads: int32) {.
    importc: "g_thread_pool_set_max_unused_threads", libprag.}

proc setMaxUnusedThreads*(maxThreads: int32) {.
    importc: "g_thread_pool_set_max_unused_threads", libprag.}

proc `maxUnusedThreads=`*(maxThreads: int32) {.
    importc: "g_thread_pool_set_max_unused_threads", libprag.}

proc g_thread_pool_stop_unused_threads*() {.
    importc: "g_thread_pool_stop_unused_threads", libprag.}

proc stopUnusedThreads*() {.
    importc: "g_thread_pool_stop_unused_threads", libprag.}

type
  Timer00* {.pure.} = object
  Timer* = ref object
    impl*: ptr Timer00

proc g_timer_continue*(self: ptr Timer00) {.
    importc: "g_timer_continue", libprag.}

proc `continue`*(self: Timer) =
  g_timer_continue(cast[ptr Timer00](self.impl))

proc g_timer_destroy*(self: ptr Timer00) {.
    importc: "g_timer_destroy", libprag.}

proc destroy*(self: Timer) =
  g_timer_destroy(cast[ptr Timer00](self.impl))

proc g_timer_elapsed*(self: ptr Timer00; microseconds: ptr uint64): cdouble {.
    importc: "g_timer_elapsed", libprag.}

proc elapsed*(self: Timer; microseconds: ptr uint64): cdouble =
  g_timer_elapsed(cast[ptr Timer00](self.impl), microseconds)

proc g_timer_reset*(self: ptr Timer00) {.
    importc: "g_timer_reset", libprag.}

proc reset*(self: Timer) =
  g_timer_reset(cast[ptr Timer00](self.impl))

proc g_timer_start*(self: ptr Timer00) {.
    importc: "g_timer_start", libprag.}

proc start*(self: Timer) =
  g_timer_start(cast[ptr Timer00](self.impl))

proc g_timer_stop*(self: ptr Timer00) {.
    importc: "g_timer_stop", libprag.}

proc stop*(self: Timer) =
  g_timer_stop(cast[ptr Timer00](self.impl))

type
  TokenValue00* = object {.union.}
    vSymbol*: pointer
    vIdentifier*: cstring
    vBinary*: uint64
    vOctal*: uint64
    vInt*: uint64
    vInt64*: uint64
    vFloat*: cdouble
    vHex*: uint64
    vString*: cstring
    vComment*: cstring
    vChar*: uint8
    vError*: uint32
  TokenValue* = ref object
    impl*: ptr TokenValue00
type

  ScannerMsgFunc* = proc (scanner: ptr Scanner00; message: cstring; error: gboolean) {.cdecl.}

  Scanner00* {.pure.} = object
    userData*: pointer
    maxParseErrors*: uint32
    parseErrors*: uint32
    inputName*: cstring
    qdata*: ptr Data00
    config*: ptr ScannerConfig00
    token*: TokenType
    value*: TokenValue00
    line*: uint32
    position*: uint32
    nextToken*: TokenType
    nextValue*: TokenValue00
    nextLine*: uint32
    nextPosition*: uint32
    symbolTable*: ptr HashTable00
    inputFd*: int32
    text*: cstring
    textEnd*: cstring
    buffer*: cstring
    scopeId*: uint32
    msgHandler*: ScannerMsgFunc
  Scanner* = ref object
    impl*: ptr Scanner00

proc g_scanner_cur_line*(self: ptr Scanner00): uint32 {.
    importc: "g_scanner_cur_line", libprag.}

proc curLine*(self: Scanner): int =
  int(g_scanner_cur_line(cast[ptr Scanner00](self.impl)))

proc g_scanner_cur_position*(self: ptr Scanner00): uint32 {.
    importc: "g_scanner_cur_position", libprag.}

proc curPosition*(self: Scanner): int =
  int(g_scanner_cur_position(cast[ptr Scanner00](self.impl)))

proc g_scanner_cur_token*(self: ptr Scanner00): TokenType {.
    importc: "g_scanner_cur_token", libprag.}

proc curToken*(self: Scanner): TokenType =
  g_scanner_cur_token(cast[ptr Scanner00](self.impl))

proc g_scanner_destroy*(self: ptr Scanner00) {.
    importc: "g_scanner_destroy", libprag.}

proc destroy*(self: Scanner) =
  g_scanner_destroy(cast[ptr Scanner00](self.impl))

proc g_scanner_eof*(self: ptr Scanner00): gboolean {.
    importc: "g_scanner_eof", libprag.}

proc eof*(self: Scanner): bool =
  toBool(g_scanner_eof(cast[ptr Scanner00](self.impl)))

proc g_scanner_get_next_token*(self: ptr Scanner00): TokenType {.
    importc: "g_scanner_get_next_token", libprag.}

proc getNextToken*(self: Scanner): TokenType =
  g_scanner_get_next_token(cast[ptr Scanner00](self.impl))

proc nextToken*(self: Scanner): TokenType =
  g_scanner_get_next_token(cast[ptr Scanner00](self.impl))

proc g_scanner_input_file*(self: ptr Scanner00; inputFd: int32) {.
    importc: "g_scanner_input_file", libprag.}

proc inputFile*(self: Scanner; inputFd: int) =
  g_scanner_input_file(cast[ptr Scanner00](self.impl), int32(inputFd))

proc g_scanner_input_text*(self: ptr Scanner00; text: cstring; textLen: uint32) {.
    importc: "g_scanner_input_text", libprag.}

proc inputText*(self: Scanner; text: string; textLen: int) =
  g_scanner_input_text(cast[ptr Scanner00](self.impl), cstring(text), uint32(textLen))

proc g_scanner_lookup_symbol*(self: ptr Scanner00; symbol: cstring): pointer {.
    importc: "g_scanner_lookup_symbol", libprag.}

proc lookupSymbol*(self: Scanner; symbol: string): pointer =
  g_scanner_lookup_symbol(cast[ptr Scanner00](self.impl), cstring(symbol))

proc g_scanner_peek_next_token*(self: ptr Scanner00): TokenType {.
    importc: "g_scanner_peek_next_token", libprag.}

proc peekNextToken*(self: Scanner): TokenType =
  g_scanner_peek_next_token(cast[ptr Scanner00](self.impl))

proc g_scanner_scope_add_symbol*(self: ptr Scanner00; scopeId: uint32; symbol: cstring; 
    value: pointer) {.
    importc: "g_scanner_scope_add_symbol", libprag.}

proc scopeAddSymbol*(self: Scanner; scopeId: int; symbol: string; value: pointer) =
  g_scanner_scope_add_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), cstring(symbol), value)

proc g_scanner_scope_lookup_symbol*(self: ptr Scanner00; scopeId: uint32; symbol: cstring): pointer {.
    importc: "g_scanner_scope_lookup_symbol", libprag.}

proc scopeLookupSymbol*(self: Scanner; scopeId: int; symbol: string): pointer =
  g_scanner_scope_lookup_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), cstring(symbol))

proc g_scanner_scope_remove_symbol*(self: ptr Scanner00; scopeId: uint32; symbol: cstring) {.
    importc: "g_scanner_scope_remove_symbol", libprag.}

proc scopeRemoveSymbol*(self: Scanner; scopeId: int; symbol: string) =
  g_scanner_scope_remove_symbol(cast[ptr Scanner00](self.impl), uint32(scopeId), cstring(symbol))

proc g_scanner_set_scope*(self: ptr Scanner00; scopeId: uint32): uint32 {.
    importc: "g_scanner_set_scope", libprag.}

proc setScope*(self: Scanner; scopeId: int): int =
  int(g_scanner_set_scope(cast[ptr Scanner00](self.impl), uint32(scopeId)))

proc `scope=`*(self: Scanner; scopeId: int): int =
  int(g_scanner_set_scope(cast[ptr Scanner00](self.impl), uint32(scopeId)))

proc g_scanner_sync_file_offset*(self: ptr Scanner00) {.
    importc: "g_scanner_sync_file_offset", libprag.}

proc syncFileOffset*(self: Scanner) =
  g_scanner_sync_file_offset(cast[ptr Scanner00](self.impl))

proc g_scanner_unexp_token*(self: ptr Scanner00; expectedToken: TokenType; identifierSpec: cstring; 
    symbolSpec: cstring; symbolName: cstring; message: cstring; isError: int32) {.
    importc: "g_scanner_unexp_token", libprag.}

proc unexpToken*(self: Scanner; expectedToken: TokenType; identifierSpec: string; 
    symbolSpec: string; symbolName: string; message: string; isError: int) =
  g_scanner_unexp_token(cast[ptr Scanner00](self.impl), expectedToken, cstring(identifierSpec), cstring(symbolSpec), cstring(symbolName), cstring(message), int32(isError))

type
  TranslateFunc* = proc (str: cstring; data: pointer): cstring {.cdecl.}

proc g_option_context_set_translate_func*(self: ptr OptionContext00; `func`: TranslateFunc; 
    data: pointer; destroyNotify: DestroyNotify) {.
    importc: "g_option_context_set_translate_func", libprag.}

proc setTranslateFunc*(self: OptionContext; `func`: TranslateFunc; data: pointer; 
    destroyNotify: DestroyNotify) =
  g_option_context_set_translate_func(cast[ptr OptionContext00](self.impl), `func`, data, destroyNotify)

proc g_option_group_set_translate_func*(self: ptr OptionGroup00; `func`: TranslateFunc; data: pointer; 
    destroyNotify: DestroyNotify) {.
    importc: "g_option_group_set_translate_func", libprag.}

proc setTranslateFunc*(self: OptionGroup; `func`: TranslateFunc; data: pointer; 
    destroyNotify: DestroyNotify) =
  g_option_group_set_translate_func(cast[ptr OptionGroup00](self.impl), `func`, data, destroyNotify)

type
  TrashStack00* {.pure.} = object
    next*: ptr TrashStack00
  TrashStack* = ref object
    impl*: ptr TrashStack00

proc g_trash_stack_height*(stackP: ptr TrashStack00): uint32 {.
    importc: "g_trash_stack_height", libprag.}

proc height*(stackP: TrashStack): int =
  int(g_trash_stack_height(cast[ptr TrashStack00](stackP.impl)))

proc g_trash_stack_peek*(stackP: ptr TrashStack00): pointer {.
    importc: "g_trash_stack_peek", libprag.}

proc peek*(stackP: TrashStack): pointer =
  g_trash_stack_peek(cast[ptr TrashStack00](stackP.impl))

proc g_trash_stack_pop*(stackP: ptr TrashStack00): pointer {.
    importc: "g_trash_stack_pop", libprag.}

proc pop*(stackP: TrashStack): pointer =
  g_trash_stack_pop(cast[ptr TrashStack00](stackP.impl))

proc g_trash_stack_push*(stackP: ptr TrashStack00; dataP: pointer) {.
    importc: "g_trash_stack_push", libprag.}

proc push*(stackP: TrashStack; dataP: pointer) =
  g_trash_stack_push(cast[ptr TrashStack00](stackP.impl), dataP)

type
  TraverseFunc* = proc (key: pointer; value: pointer; data: pointer): gboolean {.cdecl.}

type
  TraverseType* {.size: sizeof(cint), pure.} = enum
    inOrder = 0
    preOrder = 1
    postOrder = 2
    levelOrder = 3

type
  Tree00* {.pure.} = object
  Tree* = ref object
    impl*: ptr Tree00

proc g_tree_destroy*(self: ptr Tree00) {.
    importc: "g_tree_destroy", libprag.}

proc destroy*(self: Tree) =
  g_tree_destroy(cast[ptr Tree00](self.impl))

proc g_tree_height*(self: ptr Tree00): int32 {.
    importc: "g_tree_height", libprag.}

proc height*(self: Tree): int =
  int(g_tree_height(cast[ptr Tree00](self.impl)))

proc g_tree_insert*(self: ptr Tree00; key: pointer; value: pointer) {.
    importc: "g_tree_insert", libprag.}

proc insert*(self: Tree; key: pointer; value: pointer) =
  g_tree_insert(cast[ptr Tree00](self.impl), key, value)

proc g_tree_lookup*(self: ptr Tree00; key: pointer): pointer {.
    importc: "g_tree_lookup", libprag.}

proc lookup*(self: Tree; key: pointer): pointer =
  g_tree_lookup(cast[ptr Tree00](self.impl), key)

proc g_tree_lookup_extended*(self: ptr Tree00; lookupKey: pointer; origKey: pointer; 
    value: pointer): gboolean {.
    importc: "g_tree_lookup_extended", libprag.}

proc lookupExtended*(self: Tree; lookupKey: pointer; origKey: pointer; 
    value: pointer): bool =
  toBool(g_tree_lookup_extended(cast[ptr Tree00](self.impl), lookupKey, origKey, value))

proc g_tree_nnodes*(self: ptr Tree00): int32 {.
    importc: "g_tree_nnodes", libprag.}

proc nnodes*(self: Tree): int =
  int(g_tree_nnodes(cast[ptr Tree00](self.impl)))

proc g_tree_remove*(self: ptr Tree00; key: pointer): gboolean {.
    importc: "g_tree_remove", libprag.}

proc remove*(self: Tree; key: pointer): bool =
  toBool(g_tree_remove(cast[ptr Tree00](self.impl), key))

proc g_tree_replace*(self: ptr Tree00; key: pointer; value: pointer) {.
    importc: "g_tree_replace", libprag.}

proc replace*(self: Tree; key: pointer; value: pointer) =
  g_tree_replace(cast[ptr Tree00](self.impl), key, value)

proc g_tree_steal*(self: ptr Tree00; key: pointer): gboolean {.
    importc: "g_tree_steal", libprag.}

proc steal*(self: Tree; key: pointer): bool =
  toBool(g_tree_steal(cast[ptr Tree00](self.impl), key))

proc g_tree_unref*(self: ptr Tree00) {.
    importc: "g_tree_unref", libprag.}

proc unref*(self: Tree) =
  g_tree_unref(cast[ptr Tree00](self.impl))

const UNICHAR_MAX_DECOMPOSITION_LENGTH* = 18'i32

const URI_RESERVED_CHARS_GENERIC_DELIMITERS* = ":/?#[]@"

const URI_RESERVED_CHARS_SUBCOMPONENT_DELIMITERS* = "!$&'()*+,;="

const USEC_PER_SEC* = 1000000'i32

type
  UnicodeBreakType* {.size: sizeof(cint), pure.} = enum
    mandatory = 0
    carriageReturn = 1
    lineFeed = 2
    combiningMark = 3
    surrogate = 4
    zeroWidthSpace = 5
    inseparable = 6
    nonBreakingGlue = 7
    contingent = 8
    space = 9
    after = 10
    before = 11
    beforeAndAfter = 12
    hyphen = 13
    nonStarter = 14
    openPunctuation = 15
    closePunctuation = 16
    quotation = 17
    exclamation = 18
    ideographic = 19
    numeric = 20
    infixSeparator = 21
    symbol = 22
    alphabetic = 23
    prefix = 24
    postfix = 25
    complexContext = 26
    ambiguous = 27
    unknown = 28
    nextLine = 29
    wordJoiner = 30
    hangulLJamo = 31
    hangulVJamo = 32
    hangulTJamo = 33
    hangulLvSyllable = 34
    hangulLvtSyllable = 35
    closeParanthesis = 36
    conditionalJapaneseStarter = 37
    hebrewLetter = 38
    regionalIndicator = 39
    emojiBase = 40
    emojiModifier = 41
    zeroWidthJoiner = 42

type
  UnicodeScript* {.size: sizeof(cint), pure.} = enum
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
    avestan = 78
    bamum = 79
    egyptianHieroglyphs = 80
    imperialAramaic = 81
    inscriptionalPahlavi = 82
    inscriptionalParthian = 83
    javanese = 84
    kaithi = 85
    lisu = 86
    meeteiMayek = 87
    oldSouthArabian = 88
    oldTurkic = 89
    samaritan = 90
    taiTham = 91
    taiViet = 92
    batak = 93
    brahmi = 94
    mandaic = 95
    chakma = 96
    meroiticCursive = 97
    meroiticHieroglyphs = 98
    miao = 99
    sharada = 100
    soraSompeng = 101
    takri = 102
    bassaVah = 103
    caucasianAlbanian = 104
    duployan = 105
    elbasan = 106
    grantha = 107
    khojki = 108
    khudawadi = 109
    linearA = 110
    mahajani = 111
    manichaean = 112
    mendeKikakui = 113
    modi = 114
    mro = 115
    nabataean = 116
    oldNorthArabian = 117
    oldPermic = 118
    pahawhHmong = 119
    palmyrene = 120
    pauCinHau = 121
    psalterPahlavi = 122
    siddham = 123
    tirhuta = 124
    warangCiti = 125
    ahom = 126
    anatolianHieroglyphs = 127
    hatran = 128
    multani = 129
    oldHungarian = 130
    signwriting = 131
    adlam = 132
    bhaiksuki = 133
    marchen = 134
    newa = 135
    osage = 136
    tangut = 137

type
  UnicodeType* {.size: sizeof(cint), pure.} = enum
    control = 0
    format = 1
    unassigned = 2
    privateUse = 3
    surrogate = 4
    lowercaseLetter = 5
    modifierLetter = 6
    otherLetter = 7
    titlecaseLetter = 8
    uppercaseLetter = 9
    spacingMark = 10
    enclosingMark = 11
    nonSpacingMark = 12
    decimalNumber = 13
    letterNumber = 14
    otherNumber = 15
    connectPunctuation = 16
    dashPunctuation = 17
    closePunctuation = 18
    finalPunctuation = 19
    initialPunctuation = 20
    otherPunctuation = 21
    openPunctuation = 22
    currencySymbol = 23
    modifierSymbol = 24
    mathSymbol = 25
    otherSymbol = 26
    lineSeparator = 27
    paragraphSeparator = 28
    spaceSeparator = 29

type
  UnixFDSourceFunc* = proc (fd: int32; condition: IOCondition; userData: pointer): gboolean {.cdecl.}

type
  UserDirectory* {.size: sizeof(cint), pure.} = enum
    directoryDesktop = 0
    directoryDocuments = 1
    directoryDownload = 2
    directoryMusic = 3
    directoryPictures = 4
    directoryPublicShare = 5
    directoryTemplates = 6
    directoryVideos = 7
    nDirectories = 8

const VA_COPY_AS_ARRAY* = 1'i32

const VERSION_MIN_REQUIRED* = 2'i32

type
  Variant00* {.pure.} = object
  Variant* = ref object
    impl*: ptr Variant00

proc g_variant_new_boolean*(value: gboolean): ptr Variant00 {.
    importc: "g_variant_new_boolean", libprag.}

proc newVariantBoolean*(value: bool): Variant =
  new(result)
  result.impl = g_variant_new_boolean(gboolean(value))

proc initVariantBoolean*[T](result: var T; value: bool) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_boolean(gboolean(value))

proc g_variant_new_byte*(value: uint8): ptr Variant00 {.
    importc: "g_variant_new_byte", libprag.}

proc newVariantByte*(value: uint8): Variant =
  new(result)
  result.impl = g_variant_new_byte(value)

proc initVariantByte*[T](result: var T; value: uint8) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_byte(value)

proc g_variant_new_bytestring*(string: uint8Array): ptr Variant00 {.
    importc: "g_variant_new_bytestring", libprag.}

proc newVariantBytestring*(string: uint8Array): Variant =
  new(result)
  result.impl = g_variant_new_bytestring(string)

proc initVariantBytestring*[T](result: var T; string: uint8Array) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_bytestring(string)

proc g_variant_new_bytestring_array*(strv: cstringArray; length: int64): ptr Variant00 {.
    importc: "g_variant_new_bytestring_array", libprag.}

proc newVariantBytestringArray*(strv: cstringArray; length: int64): Variant =
  new(result)
  result.impl = g_variant_new_bytestring_array(strv, length)

proc initVariantBytestringArray*[T](result: var T; strv: cstringArray; length: int64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_bytestring_array(strv, length)

proc g_variant_new_dict_entry*(key: ptr Variant00; value: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_new_dict_entry", libprag.}

proc newVariantDictEntry*(key: Variant; value: Variant): Variant =
  new(result)
  result.impl = g_variant_new_dict_entry(cast[ptr Variant00](key.impl), cast[ptr Variant00](value.impl))

proc initVariantDictEntry*[T](result: var T; key: Variant; value: Variant) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_dict_entry(cast[ptr Variant00](key.impl), cast[ptr Variant00](value.impl))

proc g_variant_new_double*(value: cdouble): ptr Variant00 {.
    importc: "g_variant_new_double", libprag.}

proc newVariantDouble*(value: cdouble): Variant =
  new(result)
  result.impl = g_variant_new_double(value)

proc initVariantDouble*[T](result: var T; value: cdouble) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_double(value)

proc g_variant_new_handle*(value: int32): ptr Variant00 {.
    importc: "g_variant_new_handle", libprag.}

proc newVariantHandle*(value: int): Variant =
  new(result)
  result.impl = g_variant_new_handle(int32(value))

proc initVariantHandle*[T](result: var T; value: int) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_handle(int32(value))

proc g_variant_new_int16*(value: int16): ptr Variant00 {.
    importc: "g_variant_new_int16", libprag.}

proc newVariantInt16*(value: int16): Variant =
  new(result)
  result.impl = g_variant_new_int16(value)

proc initVariantInt16*[T](result: var T; value: int16) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_int16(value)

proc g_variant_new_int32*(value: int32): ptr Variant00 {.
    importc: "g_variant_new_int32", libprag.}

proc newVariantInt32*(value: int): Variant =
  new(result)
  result.impl = g_variant_new_int32(int32(value))

proc initVariantInt32*[T](result: var T; value: int) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_int32(int32(value))

proc g_variant_new_int64*(value: int64): ptr Variant00 {.
    importc: "g_variant_new_int64", libprag.}

proc newVariantInt64*(value: int64): Variant =
  new(result)
  result.impl = g_variant_new_int64(value)

proc initVariantInt64*[T](result: var T; value: int64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_int64(value)

proc g_variant_new_object_path*(objectPath: cstring): ptr Variant00 {.
    importc: "g_variant_new_object_path", libprag.}

proc newVariantObjectPath*(objectPath: string): Variant =
  new(result)
  result.impl = g_variant_new_object_path(cstring(objectPath))

proc initVariantObjectPath*[T](result: var T; objectPath: string) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_object_path(cstring(objectPath))

proc g_variant_new_objv*(strv: cstringArray; length: int64): ptr Variant00 {.
    importc: "g_variant_new_objv", libprag.}

proc newVariantObjv*(strv: cstringArray; length: int64): Variant =
  new(result)
  result.impl = g_variant_new_objv(strv, length)

proc initVariantObjv*[T](result: var T; strv: cstringArray; length: int64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_objv(strv, length)

proc g_variant_new_signature*(signature: cstring): ptr Variant00 {.
    importc: "g_variant_new_signature", libprag.}

proc newVariantSignature*(signature: string): Variant =
  new(result)
  result.impl = g_variant_new_signature(cstring(signature))

proc initVariantSignature*[T](result: var T; signature: string) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_signature(cstring(signature))

proc g_variant_new_string*(string: cstring): ptr Variant00 {.
    importc: "g_variant_new_string", libprag.}

proc newVariantString*(string: string): Variant =
  new(result)
  result.impl = g_variant_new_string(cstring(string))

proc initVariantString*[T](result: var T; string: string) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_string(cstring(string))

proc g_variant_new_strv*(strv: cstringArray; length: int64): ptr Variant00 {.
    importc: "g_variant_new_strv", libprag.}

proc newVariantStrv*(strv: cstringArray; length: int64): Variant =
  new(result)
  result.impl = g_variant_new_strv(strv, length)

proc initVariantStrv*[T](result: var T; strv: cstringArray; length: int64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_strv(strv, length)

proc g_variant_new_tuple*(children: ptr Variant00Array; nChildren: uint64): ptr Variant00 {.
    importc: "g_variant_new_tuple", libprag.}

proc newVariantTuple*(children: ptr Variant00Array; nChildren: uint64): Variant =
  new(result)
  result.impl = g_variant_new_tuple(children, nChildren)

proc initVariantTuple*[T](result: var T; children: ptr Variant00Array; nChildren: uint64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_tuple(children, nChildren)

proc g_variant_new_uint16*(value: uint16): ptr Variant00 {.
    importc: "g_variant_new_uint16", libprag.}

proc newVariantUint16*(value: uint16): Variant =
  new(result)
  result.impl = g_variant_new_uint16(value)

proc initVariantUint16*[T](result: var T; value: uint16) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_uint16(value)

proc g_variant_new_uint32*(value: uint32): ptr Variant00 {.
    importc: "g_variant_new_uint32", libprag.}

proc newVariantUint32*(value: int): Variant =
  new(result)
  result.impl = g_variant_new_uint32(uint32(value))

proc initVariantUint32*[T](result: var T; value: int) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_uint32(uint32(value))

proc g_variant_new_uint64*(value: uint64): ptr Variant00 {.
    importc: "g_variant_new_uint64", libprag.}

proc newVariantUint64*(value: uint64): Variant =
  new(result)
  result.impl = g_variant_new_uint64(value)

proc initVariantUint64*[T](result: var T; value: uint64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_uint64(value)

proc g_variant_new_variant*(value: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_new_variant", libprag.}

proc newVariantVariant*(value: Variant): Variant =
  new(result)
  result.impl = g_variant_new_variant(cast[ptr Variant00](value.impl))

proc initVariantVariant*[T](result: var T; value: Variant) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_variant(cast[ptr Variant00](value.impl))

proc g_variant_byteswap*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_byteswap", libprag.}

proc byteswap*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_byteswap(cast[ptr Variant00](self.impl))

proc g_variant_check_format_string*(self: ptr Variant00; formatString: cstring; copyOnly: gboolean): gboolean {.
    importc: "g_variant_check_format_string", libprag.}

proc checkFormatString*(self: Variant; formatString: string; copyOnly: bool): bool =
  toBool(g_variant_check_format_string(cast[ptr Variant00](self.impl), cstring(formatString), gboolean(copyOnly)))

proc g_variant_compare*(self: ptr Variant00; two: ptr Variant00): int32 {.
    importc: "g_variant_compare", libprag.}

proc compare*(self: Variant; two: Variant): int =
  int(g_variant_compare(cast[ptr Variant00](self.impl), cast[ptr Variant00](two.impl)))

proc g_variant_dup_bytestring*(self: ptr Variant00; length: var uint64): uint8Array {.
    importc: "g_variant_dup_bytestring", libprag.}

proc dupBytestring*(self: Variant; length: var uint64): uint8Array =
  g_variant_dup_bytestring(cast[ptr Variant00](self.impl), length)

proc g_variant_dup_bytestring_array*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_dup_bytestring_array", libprag.}

proc dupBytestringArray*(self: Variant; length: var uint64): cstringArray =
  g_variant_dup_bytestring_array(cast[ptr Variant00](self.impl), length)

proc g_variant_dup_objv*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_dup_objv", libprag.}

proc dupObjv*(self: Variant; length: var uint64): cstringArray =
  g_variant_dup_objv(cast[ptr Variant00](self.impl), length)

proc g_variant_dup_string*(self: ptr Variant00; length: var uint64): cstring {.
    importc: "g_variant_dup_string", libprag.}

proc dupString*(self: Variant; length: var uint64): string =
  let resul0 = g_variant_dup_string(cast[ptr Variant00](self.impl), length)
  result = $resul0
  cogfree(resul0)

proc g_variant_dup_strv*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_dup_strv", libprag.}

proc dupStrv*(self: Variant; length: var uint64): cstringArray =
  g_variant_dup_strv(cast[ptr Variant00](self.impl), length)

proc g_variant_equal*(self: ptr Variant00; two: ptr Variant00): gboolean {.
    importc: "g_variant_equal", libprag.}

proc equal*(self: Variant; two: Variant): bool =
  toBool(g_variant_equal(cast[ptr Variant00](self.impl), cast[ptr Variant00](two.impl)))

proc g_variant_get_boolean*(self: ptr Variant00): gboolean {.
    importc: "g_variant_get_boolean", libprag.}

proc getBoolean*(self: Variant): bool =
  toBool(g_variant_get_boolean(cast[ptr Variant00](self.impl)))

proc boolean*(self: Variant): bool =
  toBool(g_variant_get_boolean(cast[ptr Variant00](self.impl)))

proc g_variant_get_byte*(self: ptr Variant00): uint8 {.
    importc: "g_variant_get_byte", libprag.}

proc getByte*(self: Variant): uint8 =
  g_variant_get_byte(cast[ptr Variant00](self.impl))

proc byte*(self: Variant): uint8 =
  g_variant_get_byte(cast[ptr Variant00](self.impl))

proc g_variant_get_bytestring*(self: ptr Variant00): uint8Array {.
    importc: "g_variant_get_bytestring", libprag.}

proc getBytestring*(self: Variant): uint8Array =
  g_variant_get_bytestring(cast[ptr Variant00](self.impl))

proc bytestring*(self: Variant): uint8Array =
  g_variant_get_bytestring(cast[ptr Variant00](self.impl))

proc g_variant_get_bytestring_array*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_get_bytestring_array", libprag.}

proc getBytestringArray*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_bytestring_array(cast[ptr Variant00](self.impl), length)

proc bytestringArray*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_bytestring_array(cast[ptr Variant00](self.impl), length)

proc g_variant_get_child_value*(self: ptr Variant00; index: uint64): ptr Variant00 {.
    importc: "g_variant_get_child_value", libprag.}

proc getChildValue*(self: Variant; index: uint64): Variant =
  new(result)
  result.impl = g_variant_get_child_value(cast[ptr Variant00](self.impl), index)

proc childValue*(self: Variant; index: uint64): Variant =
  new(result)
  result.impl = g_variant_get_child_value(cast[ptr Variant00](self.impl), index)

proc g_variant_get_data*(self: ptr Variant00): pointer {.
    importc: "g_variant_get_data", libprag.}

proc getData*(self: Variant): pointer =
  g_variant_get_data(cast[ptr Variant00](self.impl))

proc data*(self: Variant): pointer =
  g_variant_get_data(cast[ptr Variant00](self.impl))

proc g_variant_get_data_as_bytes*(self: ptr Variant00): ptr Bytes00 {.
    importc: "g_variant_get_data_as_bytes", libprag.}

proc getDataAsBytes*(self: Variant): Bytes =
  new(result)
  result.impl = g_variant_get_data_as_bytes(cast[ptr Variant00](self.impl))

proc dataAsBytes*(self: Variant): Bytes =
  new(result)
  result.impl = g_variant_get_data_as_bytes(cast[ptr Variant00](self.impl))

proc g_variant_get_double*(self: ptr Variant00): cdouble {.
    importc: "g_variant_get_double", libprag.}

proc getDouble*(self: Variant): cdouble =
  g_variant_get_double(cast[ptr Variant00](self.impl))

proc double*(self: Variant): cdouble =
  g_variant_get_double(cast[ptr Variant00](self.impl))

proc g_variant_get_handle*(self: ptr Variant00): int32 {.
    importc: "g_variant_get_handle", libprag.}

proc getHandle*(self: Variant): int =
  int(g_variant_get_handle(cast[ptr Variant00](self.impl)))

proc handle*(self: Variant): int =
  int(g_variant_get_handle(cast[ptr Variant00](self.impl)))

proc g_variant_get_int16*(self: ptr Variant00): int16 {.
    importc: "g_variant_get_int16", libprag.}

proc getInt16*(self: Variant): int16 =
  g_variant_get_int16(cast[ptr Variant00](self.impl))

proc g_variant_get_int32*(self: ptr Variant00): int32 {.
    importc: "g_variant_get_int32", libprag.}

proc getInt32*(self: Variant): int =
  int(g_variant_get_int32(cast[ptr Variant00](self.impl)))

proc g_variant_get_int64*(self: ptr Variant00): int64 {.
    importc: "g_variant_get_int64", libprag.}

proc getInt64*(self: Variant): int64 =
  g_variant_get_int64(cast[ptr Variant00](self.impl))

proc g_variant_get_maybe*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_get_maybe", libprag.}

proc getMaybe*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_maybe(cast[ptr Variant00](self.impl))

proc maybe*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_maybe(cast[ptr Variant00](self.impl))

proc g_variant_get_normal_form*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_get_normal_form", libprag.}

proc getNormalForm*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_normal_form(cast[ptr Variant00](self.impl))

proc normalForm*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_normal_form(cast[ptr Variant00](self.impl))

proc g_variant_get_objv*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_get_objv", libprag.}

proc getObjv*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_objv(cast[ptr Variant00](self.impl), length)

proc objv*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_objv(cast[ptr Variant00](self.impl), length)

proc g_variant_get_size*(self: ptr Variant00): uint64 {.
    importc: "g_variant_get_size", libprag.}

proc getSize*(self: Variant): uint64 =
  g_variant_get_size(cast[ptr Variant00](self.impl))

proc size*(self: Variant): uint64 =
  g_variant_get_size(cast[ptr Variant00](self.impl))

proc g_variant_get_string*(self: ptr Variant00; length: var uint64): cstring {.
    importc: "g_variant_get_string", libprag.}

proc getString*(self: Variant; length: var uint64): string =
  let resul0 = g_variant_get_string(cast[ptr Variant00](self.impl), length)
  result = $resul0

proc string*(self: Variant; length: var uint64): string =
  let resul0 = g_variant_get_string(cast[ptr Variant00](self.impl), length)
  result = $resul0

proc g_variant_get_strv*(self: ptr Variant00; length: var uint64): cstringArray {.
    importc: "g_variant_get_strv", libprag.}

proc getStrv*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_strv(cast[ptr Variant00](self.impl), length)

proc strv*(self: Variant; length: var uint64): cstringArray =
  g_variant_get_strv(cast[ptr Variant00](self.impl), length)

proc g_variant_get_type_string*(self: ptr Variant00): cstring {.
    importc: "g_variant_get_type_string", libprag.}

proc getTypeString*(self: Variant): string =
  let resul0 = g_variant_get_type_string(cast[ptr Variant00](self.impl))
  result = $resul0

proc typeString*(self: Variant): string =
  let resul0 = g_variant_get_type_string(cast[ptr Variant00](self.impl))
  result = $resul0

proc g_variant_get_uint16*(self: ptr Variant00): uint16 {.
    importc: "g_variant_get_uint16", libprag.}

proc getUint16*(self: Variant): uint16 =
  g_variant_get_uint16(cast[ptr Variant00](self.impl))

proc g_variant_get_uint32*(self: ptr Variant00): uint32 {.
    importc: "g_variant_get_uint32", libprag.}

proc getUint32*(self: Variant): int =
  int(g_variant_get_uint32(cast[ptr Variant00](self.impl)))

proc g_variant_get_uint64*(self: ptr Variant00): uint64 {.
    importc: "g_variant_get_uint64", libprag.}

proc getUint64*(self: Variant): uint64 =
  g_variant_get_uint64(cast[ptr Variant00](self.impl))

proc g_variant_get_variant*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_get_variant", libprag.}

proc getVariant*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_variant(cast[ptr Variant00](self.impl))

proc variant*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_get_variant(cast[ptr Variant00](self.impl))

proc g_variant_hash*(self: ptr Variant00): uint32 {.
    importc: "g_variant_hash", libprag.}

proc hash*(self: Variant): int =
  int(g_variant_hash(cast[ptr Variant00](self.impl)))

proc g_variant_is_container*(self: ptr Variant00): gboolean {.
    importc: "g_variant_is_container", libprag.}

proc isContainer*(self: Variant): bool =
  toBool(g_variant_is_container(cast[ptr Variant00](self.impl)))

proc g_variant_is_floating*(self: ptr Variant00): gboolean {.
    importc: "g_variant_is_floating", libprag.}

proc isFloating*(self: Variant): bool =
  toBool(g_variant_is_floating(cast[ptr Variant00](self.impl)))

proc g_variant_is_normal_form*(self: ptr Variant00): gboolean {.
    importc: "g_variant_is_normal_form", libprag.}

proc isNormalForm*(self: Variant): bool =
  toBool(g_variant_is_normal_form(cast[ptr Variant00](self.impl)))

proc g_variant_n_children*(self: ptr Variant00): uint64 {.
    importc: "g_variant_n_children", libprag.}

proc nChildren*(self: Variant): uint64 =
  g_variant_n_children(cast[ptr Variant00](self.impl))

proc g_variant_print*(self: ptr Variant00; typeAnnotate: gboolean): cstring {.
    importc: "g_variant_print", libprag.}

proc print*(self: Variant; typeAnnotate: bool): string =
  let resul0 = g_variant_print(cast[ptr Variant00](self.impl), gboolean(typeAnnotate))
  result = $resul0
  cogfree(resul0)

proc g_variant_ref*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_ref", libprag.}

proc `ref`*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_ref(cast[ptr Variant00](self.impl))

proc g_variant_ref_sink*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_ref_sink", libprag.}

proc refSink*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_ref_sink(cast[ptr Variant00](self.impl))

proc g_variant_store*(self: ptr Variant00; data: pointer) {.
    importc: "g_variant_store", libprag.}

proc store*(self: Variant; data: pointer) =
  g_variant_store(cast[ptr Variant00](self.impl), data)

proc g_variant_take_ref*(self: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_take_ref", libprag.}

proc takeRef*(self: Variant): Variant =
  new(result)
  result.impl = g_variant_take_ref(cast[ptr Variant00](self.impl))

proc g_variant_unref*(self: ptr Variant00) {.
    importc: "g_variant_unref", libprag.}

proc unref*(self: Variant) =
  g_variant_unref(cast[ptr Variant00](self.impl))

proc g_variant_is_object_path*(string: cstring): gboolean {.
    importc: "g_variant_is_object_path", libprag.}

proc isObjectPath*(string: cstring): gboolean {.
    importc: "g_variant_is_object_path", libprag.}

proc g_variant_is_signature*(string: cstring): gboolean {.
    importc: "g_variant_is_signature", libprag.}

proc isSignature*(string: cstring): gboolean {.
    importc: "g_variant_is_signature", libprag.}

proc g_variant_parse_error_print_context*(error: ptr Error00; sourceStr: cstring): cstring {.
    importc: "g_variant_parse_error_print_context", libprag.}

proc parseErrorPrintContext*(error: ptr Error00; sourceStr: string): string =
  let resul0 = g_variant_parse_error_print_context(error, cstring(sourceStr))
  result = $resul0
  cogfree(resul0)

proc g_variant_parse_error_quark*(): uint32 {.
    importc: "g_variant_parse_error_quark", libprag.}

proc parseErrorQuark*(): uint32 {.
    importc: "g_variant_parse_error_quark", libprag.}

proc g_variant_parser_get_error_quark*(): uint32 {.
    importc: "g_variant_parser_get_error_quark", libprag.}

proc parserGetErrorQuark*(): uint32 {.
    importc: "g_variant_parser_get_error_quark", libprag.}

type
  VariantClass* {.size: sizeof(cint), pure.} = enum
    `tuple` = 40
    array = 97
    boolean = 98
    double = 100
    signature = 103
    handle = 104
    int32 = 105
    maybe = 109
    int16 = 110
    objectPath = 111
    uint16 = 113
    string = 115
    uint64 = 116
    uint32 = 117
    variant = 118
    int64 = 120
    byte = 121
    dictEntry = 123

proc g_variant_classify*(self: ptr Variant00): VariantClass {.
    importc: "g_variant_classify", libprag.}

proc classify*(self: Variant): VariantClass =
  g_variant_classify(cast[ptr Variant00](self.impl))

type
  VariantType00* {.pure.} = object
  VariantType* = ref object
    impl*: ptr VariantType00

proc g_variant_type_new*(typeString: cstring): ptr VariantType00 {.
    importc: "g_variant_type_new", libprag.}

proc newVariantType*(typeString: string): VariantType =
  new(result)
  result.impl = g_variant_type_new(cstring(typeString))

proc initVariantType*[T](result: var T; typeString: string) =
  assert(result is VariantType)
  new(result)
  result.impl = g_variant_type_new(cstring(typeString))

proc g_variant_type_new_array*(element: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_new_array", libprag.}

proc newVariantTypeArray*(element: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_new_array(cast[ptr VariantType00](element.impl))

proc initVariantTypeArray*[T](result: var T; element: VariantType) =
  assert(result is VariantType)
  new(result)
  result.impl = g_variant_type_new_array(cast[ptr VariantType00](element.impl))

proc g_variant_type_new_dict_entry*(key: ptr VariantType00; value: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_new_dict_entry", libprag.}

proc newVariantTypeDictEntry*(key: VariantType; value: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_new_dict_entry(cast[ptr VariantType00](key.impl), cast[ptr VariantType00](value.impl))

proc initVariantTypeDictEntry*[T](result: var T; key: VariantType; value: VariantType) =
  assert(result is VariantType)
  new(result)
  result.impl = g_variant_type_new_dict_entry(cast[ptr VariantType00](key.impl), cast[ptr VariantType00](value.impl))

proc g_variant_type_new_maybe*(element: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_new_maybe", libprag.}

proc newVariantTypeMaybe*(element: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_new_maybe(cast[ptr VariantType00](element.impl))

proc initVariantTypeMaybe*[T](result: var T; element: VariantType) =
  assert(result is VariantType)
  new(result)
  result.impl = g_variant_type_new_maybe(cast[ptr VariantType00](element.impl))

proc g_variant_type_new_tuple*(items: ptr VariantType00Array; length: int32): ptr VariantType00 {.
    importc: "g_variant_type_new_tuple", libprag.}

proc newVariantTypeTuple*(items: ptr VariantType00Array; length: int): VariantType =
  new(result)
  result.impl = g_variant_type_new_tuple(items, int32(length))

proc initVariantTypeTuple*[T](result: var T; items: ptr VariantType00Array; length: int) =
  assert(result is VariantType)
  new(result)
  result.impl = g_variant_type_new_tuple(items, int32(length))

proc g_variant_type_copy*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_copy", libprag.}

proc copy*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_copy(cast[ptr VariantType00](self.impl))

proc g_variant_type_dup_string*(self: ptr VariantType00): cstring {.
    importc: "g_variant_type_dup_string", libprag.}

proc dupString*(self: VariantType): string =
  let resul0 = g_variant_type_dup_string(cast[ptr VariantType00](self.impl))
  result = $resul0
  cogfree(resul0)

proc g_variant_type_element*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_element", libprag.}

proc element*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_element(cast[ptr VariantType00](self.impl))

proc g_variant_type_equal*(self: ptr VariantType00; type2: ptr VariantType00): gboolean {.
    importc: "g_variant_type_equal", libprag.}

proc equal*(self: VariantType; type2: VariantType): bool =
  toBool(g_variant_type_equal(cast[ptr VariantType00](self.impl), cast[ptr VariantType00](type2.impl)))

proc g_variant_type_first*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_first", libprag.}

proc first*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_first(cast[ptr VariantType00](self.impl))

proc g_variant_type_free*(self: ptr VariantType00) {.
    importc: "g_variant_type_free", libprag.}

proc free*(self: VariantType) =
  g_variant_type_free(cast[ptr VariantType00](self.impl))

proc g_variant_type_get_string_length*(self: ptr VariantType00): uint64 {.
    importc: "g_variant_type_get_string_length", libprag.}

proc getStringLength*(self: VariantType): uint64 =
  g_variant_type_get_string_length(cast[ptr VariantType00](self.impl))

proc stringLength*(self: VariantType): uint64 =
  g_variant_type_get_string_length(cast[ptr VariantType00](self.impl))

proc g_variant_type_hash*(self: ptr VariantType00): uint32 {.
    importc: "g_variant_type_hash", libprag.}

proc hash*(self: VariantType): int =
  int(g_variant_type_hash(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_array*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_array", libprag.}

proc isArray*(self: VariantType): bool =
  toBool(g_variant_type_is_array(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_basic*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_basic", libprag.}

proc isBasic*(self: VariantType): bool =
  toBool(g_variant_type_is_basic(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_container*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_container", libprag.}

proc isContainer*(self: VariantType): bool =
  toBool(g_variant_type_is_container(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_definite*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_definite", libprag.}

proc isDefinite*(self: VariantType): bool =
  toBool(g_variant_type_is_definite(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_dict_entry*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_dict_entry", libprag.}

proc isDictEntry*(self: VariantType): bool =
  toBool(g_variant_type_is_dict_entry(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_maybe*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_maybe", libprag.}

proc isMaybe*(self: VariantType): bool =
  toBool(g_variant_type_is_maybe(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_subtype_of*(self: ptr VariantType00; supertype: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_subtype_of", libprag.}

proc isSubtypeOf*(self: VariantType; supertype: VariantType): bool =
  toBool(g_variant_type_is_subtype_of(cast[ptr VariantType00](self.impl), cast[ptr VariantType00](supertype.impl)))

proc g_variant_type_is_tuple*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_tuple", libprag.}

proc isTuple*(self: VariantType): bool =
  toBool(g_variant_type_is_tuple(cast[ptr VariantType00](self.impl)))

proc g_variant_type_is_variant*(self: ptr VariantType00): gboolean {.
    importc: "g_variant_type_is_variant", libprag.}

proc isVariant*(self: VariantType): bool =
  toBool(g_variant_type_is_variant(cast[ptr VariantType00](self.impl)))

proc g_variant_type_key*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_key", libprag.}

proc key*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_key(cast[ptr VariantType00](self.impl))

proc g_variant_type_n_items*(self: ptr VariantType00): uint64 {.
    importc: "g_variant_type_n_items", libprag.}

proc nItems*(self: VariantType): uint64 =
  g_variant_type_n_items(cast[ptr VariantType00](self.impl))

proc g_variant_type_next*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_next", libprag.}

proc next*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_next(cast[ptr VariantType00](self.impl))

proc g_variant_type_value*(self: ptr VariantType00): ptr VariantType00 {.
    importc: "g_variant_type_value", libprag.}

proc value*(self: VariantType): VariantType =
  new(result)
  result.impl = g_variant_type_value(cast[ptr VariantType00](self.impl))

proc g_variant_type_string_is_valid*(typeString: cstring): gboolean {.
    importc: "g_variant_type_string_is_valid", libprag.}

proc stringIsValid*(typeString: cstring): gboolean {.
    importc: "g_variant_type_string_is_valid", libprag.}

proc g_variant_type_string_scan*(string: cstring; limit: cstring; endptr: var cstring): gboolean {.
    importc: "g_variant_type_string_scan", libprag.}

proc stringScan*(string: cstring; limit: cstring; endptr: var cstring): gboolean {.
    importc: "g_variant_type_string_scan", libprag.}

proc g_variant_new_array*(childType: ptr VariantType00; children: ptr Variant00Array; 
    nChildren: uint64): ptr Variant00 {.
    importc: "g_variant_new_array", libprag.}

proc newVariantArray*(childType: VariantType; children: ptr Variant00Array; 
    nChildren: uint64): Variant =
  new(result)
  result.impl = g_variant_new_array(cast[ptr VariantType00](childType.impl), children, nChildren)

proc initVariantArray*[T](result: var T; childType: VariantType; children: ptr Variant00Array; 
    nChildren: uint64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_array(cast[ptr VariantType00](childType.impl), children, nChildren)

proc g_variant_new_fixed_array*(elementType: ptr VariantType00; elements: pointer; 
    nElements: uint64; elementSize: uint64): ptr Variant00 {.
    importc: "g_variant_new_fixed_array", libprag.}

proc newVariantFixedArray*(elementType: VariantType; elements: pointer; nElements: uint64; 
    elementSize: uint64): Variant =
  new(result)
  result.impl = g_variant_new_fixed_array(cast[ptr VariantType00](elementType.impl), elements, nElements, elementSize)

proc initVariantFixedArray*[T](result: var T; elementType: VariantType; elements: pointer; nElements: uint64; 
    elementSize: uint64) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_fixed_array(cast[ptr VariantType00](elementType.impl), elements, nElements, elementSize)

proc g_variant_new_from_bytes*(`type`: ptr VariantType00; bytes: ptr Bytes00; trusted: gboolean): ptr Variant00 {.
    importc: "g_variant_new_from_bytes", libprag.}

proc newVariantFromBytes*(`type`: VariantType; bytes: Bytes; trusted: bool): Variant =
  new(result)
  result.impl = g_variant_new_from_bytes(cast[ptr VariantType00](`type`.impl), cast[ptr Bytes00](bytes.impl), gboolean(trusted))

proc initVariantFromBytes*[T](result: var T; `type`: VariantType; bytes: Bytes; trusted: bool) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_from_bytes(cast[ptr VariantType00](`type`.impl), cast[ptr Bytes00](bytes.impl), gboolean(trusted))

proc g_variant_new_from_data*(`type`: ptr VariantType00; data: uint8Array; size: uint64; 
    trusted: gboolean; notify: DestroyNotify; userData: pointer): ptr Variant00 {.
    importc: "g_variant_new_from_data", libprag.}

proc newVariantFromData*(`type`: VariantType; data: uint8Array; size: uint64; 
    trusted: bool; notify: DestroyNotify; userData: pointer): Variant =
  new(result)
  result.impl = g_variant_new_from_data(cast[ptr VariantType00](`type`.impl), data, size, gboolean(trusted), notify, userData)

proc initVariantFromData*[T](result: var T; `type`: VariantType; data: uint8Array; size: uint64; 
    trusted: bool; notify: DestroyNotify; userData: pointer) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_from_data(cast[ptr VariantType00](`type`.impl), data, size, gboolean(trusted), notify, userData)

proc g_variant_new_maybe*(childType: ptr VariantType00; child: ptr Variant00): ptr Variant00 {.
    importc: "g_variant_new_maybe", libprag.}

proc newVariantMaybe*(childType: VariantType; child: Variant): Variant =
  new(result)
  result.impl = g_variant_new_maybe(cast[ptr VariantType00](childType.impl), cast[ptr Variant00](child.impl))

proc initVariantMaybe*[T](result: var T; childType: VariantType; child: Variant) =
  assert(result is Variant)
  new(result)
  result.impl = g_variant_new_maybe(cast[ptr VariantType00](childType.impl), cast[ptr Variant00](child.impl))

proc g_variant_get_type*(self: ptr Variant00): ptr VariantType00 {.
    importc: "g_variant_get_type", libprag.}

proc getType*(self: Variant): VariantType =
  new(result)
  result.impl = g_variant_get_type(cast[ptr Variant00](self.impl))

proc g_variant_is_of_type*(self: ptr Variant00; `type`: ptr VariantType00): gboolean {.
    importc: "g_variant_is_of_type", libprag.}

proc isOfType*(self: Variant; `type`: VariantType): bool =
  toBool(g_variant_is_of_type(cast[ptr Variant00](self.impl), cast[ptr VariantType00](`type`.impl)))

proc g_variant_lookup_value*(self: ptr Variant00; key: cstring; expectedType: ptr VariantType00): ptr Variant00 {.
    importc: "g_variant_lookup_value", libprag.}

proc lookupValue*(self: Variant; key: string; expectedType: VariantType): Variant =
  new(result)
  result.impl = g_variant_lookup_value(cast[ptr Variant00](self.impl), cstring(key), cast[ptr VariantType00](expectedType.impl))

proc g_variant_parse*(`type`: ptr VariantType00; text: cstring; limit: cstring; 
    endptr: cstring): ptr Variant00 {.
    importc: "g_variant_parse", libprag.}

proc parse*(`type`: VariantType; text: string; limit: string; 
    endptr: string): Variant =
  new(result)
  result.impl = g_variant_parse(cast[ptr VariantType00](`type`.impl), cstring(text), cstring(limit), cstring(endptr))

type
  VariantBuilder00* {.pure.} = object
  VariantBuilder* = ref object
    impl*: ptr VariantBuilder00

proc g_variant_builder_new*(`type`: ptr VariantType00): ptr VariantBuilder00 {.
    importc: "g_variant_builder_new", libprag.}

proc newVariantBuilder*(`type`: VariantType): VariantBuilder =
  new(result)
  result.impl = g_variant_builder_new(cast[ptr VariantType00](`type`.impl))

proc initVariantBuilder*[T](result: var T; `type`: VariantType) =
  assert(result is VariantBuilder)
  new(result)
  result.impl = g_variant_builder_new(cast[ptr VariantType00](`type`.impl))

proc g_variant_builder_add_value*(self: ptr VariantBuilder00; value: ptr Variant00) {.
    importc: "g_variant_builder_add_value", libprag.}

proc addValue*(self: VariantBuilder; value: Variant) =
  g_variant_builder_add_value(cast[ptr VariantBuilder00](self.impl), cast[ptr Variant00](value.impl))

proc g_variant_builder_close*(self: ptr VariantBuilder00) {.
    importc: "g_variant_builder_close", libprag.}

proc close*(self: VariantBuilder) =
  g_variant_builder_close(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_end*(self: ptr VariantBuilder00): ptr Variant00 {.
    importc: "g_variant_builder_end", libprag.}

proc `end`*(self: VariantBuilder): Variant =
  new(result)
  result.impl = g_variant_builder_end(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_open*(self: ptr VariantBuilder00; `type`: ptr VariantType00) {.
    importc: "g_variant_builder_open", libprag.}

proc open*(self: VariantBuilder; `type`: VariantType) =
  g_variant_builder_open(cast[ptr VariantBuilder00](self.impl), cast[ptr VariantType00](`type`.impl))

proc g_variant_builder_ref*(self: ptr VariantBuilder00): ptr VariantBuilder00 {.
    importc: "g_variant_builder_ref", libprag.}

proc `ref`*(self: VariantBuilder): VariantBuilder =
  new(result)
  result.impl = g_variant_builder_ref(cast[ptr VariantBuilder00](self.impl))

proc g_variant_builder_unref*(self: ptr VariantBuilder00) {.
    importc: "g_variant_builder_unref", libprag.}

proc unref*(self: VariantBuilder) =
  g_variant_builder_unref(cast[ptr VariantBuilder00](self.impl))

type
  VariantDict00* {.pure.} = object
  VariantDict* = ref object
    impl*: ptr VariantDict00

proc g_variant_dict_new*(fromAsv: ptr Variant00): ptr VariantDict00 {.
    importc: "g_variant_dict_new", libprag.}

proc newVariantDict*(fromAsv: Variant): VariantDict =
  new(result)
  result.impl = g_variant_dict_new(cast[ptr Variant00](fromAsv.impl))

proc initVariantDict*[T](result: var T; fromAsv: Variant) =
  assert(result is VariantDict)
  new(result)
  result.impl = g_variant_dict_new(cast[ptr Variant00](fromAsv.impl))

proc g_variant_dict_clear*(self: ptr VariantDict00) {.
    importc: "g_variant_dict_clear", libprag.}

proc clear*(self: VariantDict) =
  g_variant_dict_clear(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_contains*(self: ptr VariantDict00; key: cstring): gboolean {.
    importc: "g_variant_dict_contains", libprag.}

proc contains*(self: VariantDict; key: string): bool =
  toBool(g_variant_dict_contains(cast[ptr VariantDict00](self.impl), cstring(key)))

proc g_variant_dict_end*(self: ptr VariantDict00): ptr Variant00 {.
    importc: "g_variant_dict_end", libprag.}

proc `end`*(self: VariantDict): Variant =
  new(result)
  result.impl = g_variant_dict_end(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_insert_value*(self: ptr VariantDict00; key: cstring; value: ptr Variant00) {.
    importc: "g_variant_dict_insert_value", libprag.}

proc insertValue*(self: VariantDict; key: string; value: Variant) =
  g_variant_dict_insert_value(cast[ptr VariantDict00](self.impl), cstring(key), cast[ptr Variant00](value.impl))

proc g_variant_dict_lookup_value*(self: ptr VariantDict00; key: cstring; expectedType: ptr VariantType00): ptr Variant00 {.
    importc: "g_variant_dict_lookup_value", libprag.}

proc lookupValue*(self: VariantDict; key: string; expectedType: VariantType): Variant =
  new(result)
  result.impl = g_variant_dict_lookup_value(cast[ptr VariantDict00](self.impl), cstring(key), cast[ptr VariantType00](expectedType.impl))

proc g_variant_dict_ref*(self: ptr VariantDict00): ptr VariantDict00 {.
    importc: "g_variant_dict_ref", libprag.}

proc `ref`*(self: VariantDict): VariantDict =
  new(result)
  result.impl = g_variant_dict_ref(cast[ptr VariantDict00](self.impl))

proc g_variant_dict_remove*(self: ptr VariantDict00; key: cstring): gboolean {.
    importc: "g_variant_dict_remove", libprag.}

proc remove*(self: VariantDict; key: string): bool =
  toBool(g_variant_dict_remove(cast[ptr VariantDict00](self.impl), cstring(key)))

proc g_variant_dict_unref*(self: ptr VariantDict00) {.
    importc: "g_variant_dict_unref", libprag.}

proc unref*(self: VariantDict) =
  g_variant_dict_unref(cast[ptr VariantDict00](self.impl))

type
  VariantParseError* {.size: sizeof(cint), pure.} = enum
    failed = 0
    basicTypeExpected = 1
    cannotInferType = 2
    definiteTypeExpected = 3
    inputNotAtEnd = 4
    invalidCharacter = 5
    invalidFormatString = 6
    invalidObjectPath = 7
    invalidSignature = 8
    invalidTypeString = 9
    noCommonType = 10
    numberOutOfRange = 11
    numberTooBig = 12
    typeError = 13
    unexpectedToken = 14
    unknownKeyword = 15
    unterminatedStringConstant = 16
    valueExpected = 17

type
  VoidFunc* = proc () {.cdecl.}

const WIN32_MSG_HANDLE* = 19981206'i32

proc g_access*(filename: ucstring; mode: int32): int32 {.
    importc: "g_access", libprag.}

proc access*(filename: ucstring; mode: int32): int32 {.
    importc: "g_access", libprag.}

proc g_ascii_digit_value*(c: int8): int32 {.
    importc: "g_ascii_digit_value", libprag.}

proc asciiDigitValue*(c: int8): int32 {.
    importc: "g_ascii_digit_value", libprag.}

proc g_ascii_dtostr*(buffer: cstring; bufLen: int32; d: cdouble): cstring {.
    importc: "g_ascii_dtostr", libprag.}

proc asciiDtostr*(buffer: string; bufLen: int; d: cdouble): string =
  let resul0 = g_ascii_dtostr(cstring(buffer), int32(bufLen), d)
  result = $resul0
  cogfree(resul0)

proc g_ascii_formatd*(buffer: cstring; bufLen: int32; format: cstring; d: cdouble): cstring {.
    importc: "g_ascii_formatd", libprag.}

proc asciiFormatd*(buffer: string; bufLen: int; format: string; d: cdouble): string =
  let resul0 = g_ascii_formatd(cstring(buffer), int32(bufLen), cstring(format), d)
  result = $resul0
  cogfree(resul0)

proc g_ascii_strcasecmp*(s1: cstring; s2: cstring): int32 {.
    importc: "g_ascii_strcasecmp", libprag.}

proc asciiStrcasecmp*(s1: cstring; s2: cstring): int32 {.
    importc: "g_ascii_strcasecmp", libprag.}

proc g_ascii_strdown*(str: cstring; len: int64): cstring {.
    importc: "g_ascii_strdown", libprag.}

proc asciiStrdown*(str: string; len: int64): string =
  let resul0 = g_ascii_strdown(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_ascii_strncasecmp*(s1: cstring; s2: cstring; n: uint64): int32 {.
    importc: "g_ascii_strncasecmp", libprag.}

proc asciiStrncasecmp*(s1: cstring; s2: cstring; n: uint64): int32 {.
    importc: "g_ascii_strncasecmp", libprag.}

proc g_ascii_strtod*(nptr: cstring; endptr: var cstring): cdouble {.
    importc: "g_ascii_strtod", libprag.}

proc asciiStrtod*(nptr: cstring; endptr: var cstring): cdouble {.
    importc: "g_ascii_strtod", libprag.}

proc g_ascii_strtoll*(nptr: cstring; endptr: var cstring; base: uint32): int64 {.
    importc: "g_ascii_strtoll", libprag.}

proc asciiStrtoll*(nptr: cstring; endptr: var cstring; base: uint32): int64 {.
    importc: "g_ascii_strtoll", libprag.}

proc g_ascii_strtoull*(nptr: cstring; endptr: var cstring; base: uint32): uint64 {.
    importc: "g_ascii_strtoull", libprag.}

proc asciiStrtoull*(nptr: cstring; endptr: var cstring; base: uint32): uint64 {.
    importc: "g_ascii_strtoull", libprag.}

proc g_ascii_strup*(str: cstring; len: int64): cstring {.
    importc: "g_ascii_strup", libprag.}

proc asciiStrup*(str: string; len: int64): string =
  let resul0 = g_ascii_strup(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_ascii_tolower*(c: int8): int8 {.
    importc: "g_ascii_tolower", libprag.}

proc asciiTolower*(c: int8): int8 {.
    importc: "g_ascii_tolower", libprag.}

proc g_ascii_toupper*(c: int8): int8 {.
    importc: "g_ascii_toupper", libprag.}

proc asciiToupper*(c: int8): int8 {.
    importc: "g_ascii_toupper", libprag.}

proc g_ascii_xdigit_value*(c: int8): int32 {.
    importc: "g_ascii_xdigit_value", libprag.}

proc asciiXdigitValue*(c: int8): int32 {.
    importc: "g_ascii_xdigit_value", libprag.}

proc g_assert_warning*(logDomain: cstring; file: cstring; line: int32; prettyFunction: cstring; 
    expression: cstring) {.
    importc: "g_assert_warning", libprag.}

proc assertWarning*(logDomain: cstring; file: cstring; line: int32; prettyFunction: cstring; 
    expression: cstring) {.
    importc: "g_assert_warning", libprag.}

proc g_assertion_message*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    message: cstring) {.
    importc: "g_assertion_message", libprag.}

proc assertionMessage*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    message: cstring) {.
    importc: "g_assertion_message", libprag.}

proc g_assertion_message_cmpstr*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    expr: cstring; arg1: cstring; cmp: cstring; arg2: cstring) {.
    importc: "g_assertion_message_cmpstr", libprag.}

proc assertionMessageCmpstr*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    expr: cstring; arg1: cstring; cmp: cstring; arg2: cstring) {.
    importc: "g_assertion_message_cmpstr", libprag.}

proc g_assertion_message_error*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    expr: cstring; error: ptr Error00; errorDomain: uint32; errorCode: int32) {.
    importc: "g_assertion_message_error", libprag.}

proc assertionMessageError*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    expr: cstring; error: ptr Error00; errorDomain: uint32; errorCode: int32) {.
    importc: "g_assertion_message_error", libprag.}

proc g_atexit*(`func`: VoidFunc) {.
    importc: "g_atexit", libprag.}

proc atexit*(`func`: VoidFunc) {.
    importc: "g_atexit", libprag.}

proc g_atomic_int_add*(`atomic`: ptr int32; val: int32): int32 {.
    importc: "g_atomic_int_add", libprag.}

proc atomicIntAdd*(`atomic`: ptr int32; val: int32): int32 {.
    importc: "g_atomic_int_add", libprag.}

proc g_atomic_int_and*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_and", libprag.}

proc atomicIntAnd*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_and", libprag.}

proc g_atomic_int_compare_and_exchange*(`atomic`: ptr int32; oldval: int32; newval: int32): gboolean {.
    importc: "g_atomic_int_compare_and_exchange", libprag.}

proc atomicIntCompareAndExchange*(`atomic`: ptr int32; oldval: int32; newval: int32): gboolean {.
    importc: "g_atomic_int_compare_and_exchange", libprag.}

proc g_atomic_int_dec_and_test*(`atomic`: ptr int32): gboolean {.
    importc: "g_atomic_int_dec_and_test", libprag.}

proc atomicIntDecAndTest*(`atomic`: ptr int32): gboolean {.
    importc: "g_atomic_int_dec_and_test", libprag.}

proc g_atomic_int_exchange_and_add*(`atomic`: ptr int32; val: int32): int32 {.
    importc: "g_atomic_int_exchange_and_add", libprag.}

proc atomicIntExchangeAndAdd*(`atomic`: ptr int32; val: int32): int32 {.
    importc: "g_atomic_int_exchange_and_add", libprag.}

proc g_atomic_int_get*(`atomic`: ptr int32): int32 {.
    importc: "g_atomic_int_get", libprag.}

proc atomicIntGet*(`atomic`: ptr int32): int32 {.
    importc: "g_atomic_int_get", libprag.}

proc g_atomic_int_inc*(`atomic`: ptr int32) {.
    importc: "g_atomic_int_inc", libprag.}

proc atomicIntInc*(`atomic`: ptr int32) {.
    importc: "g_atomic_int_inc", libprag.}

proc g_atomic_int_or*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_or", libprag.}

proc atomicIntOr*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_or", libprag.}

proc g_atomic_int_set*(`atomic`: ptr int32; newval: int32) {.
    importc: "g_atomic_int_set", libprag.}

proc atomicIntSet*(`atomic`: ptr int32; newval: int32) {.
    importc: "g_atomic_int_set", libprag.}

proc g_atomic_int_xor*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_xor", libprag.}

proc atomicIntXor*(`atomic`: ptr uint32; val: uint32): uint32 {.
    importc: "g_atomic_int_xor", libprag.}

proc g_atomic_pointer_add*(`atomic`: pointer; val: int64): int64 {.
    importc: "g_atomic_pointer_add", libprag.}

proc atomicPointerAdd*(`atomic`: pointer; val: int64): int64 {.
    importc: "g_atomic_pointer_add", libprag.}

proc g_atomic_pointer_and*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_and", libprag.}

proc atomicPointerAnd*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_and", libprag.}

proc g_atomic_pointer_compare_and_exchange*(`atomic`: pointer; oldval: pointer; newval: pointer): gboolean {.
    importc: "g_atomic_pointer_compare_and_exchange", libprag.}

proc atomicPointerCompareAndExchange*(`atomic`: pointer; oldval: pointer; newval: pointer): gboolean {.
    importc: "g_atomic_pointer_compare_and_exchange", libprag.}

proc g_atomic_pointer_get*(`atomic`: pointer): pointer {.
    importc: "g_atomic_pointer_get", libprag.}

proc atomicPointerGet*(`atomic`: pointer): pointer {.
    importc: "g_atomic_pointer_get", libprag.}

proc g_atomic_pointer_or*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_or", libprag.}

proc atomicPointerOr*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_or", libprag.}

proc g_atomic_pointer_set*(`atomic`: pointer; newval: pointer) {.
    importc: "g_atomic_pointer_set", libprag.}

proc atomicPointerSet*(`atomic`: pointer; newval: pointer) {.
    importc: "g_atomic_pointer_set", libprag.}

proc g_atomic_pointer_xor*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_xor", libprag.}

proc atomicPointerXor*(`atomic`: pointer; val: uint64): uint64 {.
    importc: "g_atomic_pointer_xor", libprag.}

proc g_base64_decode*(text: cstring; outLen: var uint64): uint8Array {.
    importc: "g_base64_decode", libprag.}

proc base64Decode*(text: cstring; outLen: var uint64): uint8Array {.
    importc: "g_base64_decode", libprag.}

proc g_base64_decode_inplace*(text: uint8Array; outLen: uint64): ptr uint8 {.
    importc: "g_base64_decode_inplace", libprag.}

proc base64DecodeInplace*(text: uint8Array; outLen: uint64): ptr uint8 {.
    importc: "g_base64_decode_inplace", libprag.}

proc g_base64_decode_step*(`in`: uint8Array; len: uint64; `out`: var uint8Array; 
    state: int32; save: uint32): uint64 {.
    importc: "g_base64_decode_step", libprag.}

proc base64DecodeStep*(`in`: uint8Array; len: uint64; `out`: var uint8Array; 
    state: int32; save: uint32): uint64 {.
    importc: "g_base64_decode_step", libprag.}

proc g_base64_encode*(data: uint8Array; len: uint64): cstring {.
    importc: "g_base64_encode", libprag.}

proc base64Encode*(data: uint8Array; len: uint64): string =
  let resul0 = g_base64_encode(data, len)
  result = $resul0
  cogfree(resul0)

proc g_base64_encode_close*(breakLines: gboolean; `out`: var uint8Array; state: int32; 
    save: int32): uint64 {.
    importc: "g_base64_encode_close", libprag.}

proc base64EncodeClose*(breakLines: gboolean; `out`: var uint8Array; state: int32; 
    save: int32): uint64 {.
    importc: "g_base64_encode_close", libprag.}

proc g_base64_encode_step*(`in`: uint8Array; len: uint64; breakLines: gboolean; 
    `out`: var uint8Array; state: int32; save: int32): uint64 {.
    importc: "g_base64_encode_step", libprag.}

proc base64EncodeStep*(`in`: uint8Array; len: uint64; breakLines: gboolean; 
    `out`: var uint8Array; state: int32; save: int32): uint64 {.
    importc: "g_base64_encode_step", libprag.}

proc g_basename*(fileName: ucstring): ucstring {.
    importc: "g_basename", libprag.}

proc basename*(fileName: ucstring): ucstring {.
    importc: "g_basename", libprag.}

proc g_bit_lock*(address: ptr int32; lockBit: int32) {.
    importc: "g_bit_lock", libprag.}

proc bitLock*(address: ptr int32; lockBit: int32) {.
    importc: "g_bit_lock", libprag.}

proc g_bit_nth_lsf*(mask: uint64; nthBit: int32): int32 {.
    importc: "g_bit_nth_lsf", libprag.}

proc bitNthLsf*(mask: uint64; nthBit: int32): int32 {.
    importc: "g_bit_nth_lsf", libprag.}

proc g_bit_nth_msf*(mask: uint64; nthBit: int32): int32 {.
    importc: "g_bit_nth_msf", libprag.}

proc bitNthMsf*(mask: uint64; nthBit: int32): int32 {.
    importc: "g_bit_nth_msf", libprag.}

proc g_bit_storage*(number: uint64): uint32 {.
    importc: "g_bit_storage", libprag.}

proc bitStorage*(number: uint64): uint32 {.
    importc: "g_bit_storage", libprag.}

proc g_bit_trylock*(address: ptr int32; lockBit: int32): gboolean {.
    importc: "g_bit_trylock", libprag.}

proc bitTrylock*(address: ptr int32; lockBit: int32): gboolean {.
    importc: "g_bit_trylock", libprag.}

proc g_bit_unlock*(address: ptr int32; lockBit: int32) {.
    importc: "g_bit_unlock", libprag.}

proc bitUnlock*(address: ptr int32; lockBit: int32) {.
    importc: "g_bit_unlock", libprag.}

proc g_build_filenamev*(args: ucstringArray): ucstring {.
    importc: "g_build_filenamev", libprag.}

proc buildFilenamev*(args: ucstringArray): ucstring {.
    importc: "g_build_filenamev", libprag.}

proc g_build_pathv*(separator: cstring; args: ucstringArray): ucstring {.
    importc: "g_build_pathv", libprag.}

proc buildPathv*(separator: cstring; args: ucstringArray): ucstring {.
    importc: "g_build_pathv", libprag.}

proc g_chdir*(path: ucstring): int32 {.
    importc: "g_chdir", libprag.}

proc chdir*(path: ucstring): int32 {.
    importc: "g_chdir", libprag.}

proc glib_check_version*(requiredMajor: uint32; requiredMinor: uint32; requiredMicro: uint32): cstring {.
    importc: "glib_check_version", libprag.}

proc checkVersion*(requiredMajor: int; requiredMinor: int; requiredMicro: int): string =
  let resul0 = glib_check_version(uint32(requiredMajor), uint32(requiredMinor), uint32(requiredMicro))
  result = $resul0

proc g_child_watch_add_full*(priority: int32; pid: int32; function: ChildWatchFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_child_watch_add_full", libprag.}

proc childWatchAdd*(priority: int32; pid: int32; function: ChildWatchFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_child_watch_add_full", libprag.}

proc g_child_watch_source_new*(pid: int32): ptr Source00 {.
    importc: "g_child_watch_source_new", libprag.}

proc childWatchSourceNew*(pid: int): Source =
  new(result)
  result.impl = g_child_watch_source_new(int32(pid))

proc g_clear_error*() {.
    importc: "g_clear_error", libprag.}

proc clearError*() {.
    importc: "g_clear_error", libprag.}

proc g_close*(fd: int32): gboolean {.
    importc: "g_close", libprag.}

proc close*(fd: int32): gboolean {.
    importc: "g_close", libprag.}

proc g_compute_checksum_for_bytes*(checksumType: ChecksumType; data: ptr Bytes00): cstring {.
    importc: "g_compute_checksum_for_bytes", libprag.}

proc computeChecksumForBytes*(checksumType: ChecksumType; data: Bytes): string =
  let resul0 = g_compute_checksum_for_bytes(checksumType, cast[ptr Bytes00](data.impl))
  result = $resul0
  cogfree(resul0)

proc g_compute_checksum_for_data*(checksumType: ChecksumType; data: uint8Array; length: uint64): cstring {.
    importc: "g_compute_checksum_for_data", libprag.}

proc computeChecksumForData*(checksumType: ChecksumType; data: uint8Array; length: uint64): string =
  let resul0 = g_compute_checksum_for_data(checksumType, data, length)
  result = $resul0
  cogfree(resul0)

proc g_compute_checksum_for_string*(checksumType: ChecksumType; str: cstring; length: int64): cstring {.
    importc: "g_compute_checksum_for_string", libprag.}

proc computeChecksumForString*(checksumType: ChecksumType; str: string; length: int64): string =
  let resul0 = g_compute_checksum_for_string(checksumType, cstring(str), length)
  result = $resul0
  cogfree(resul0)

proc g_compute_hmac_for_bytes*(digestType: ChecksumType; key: ptr Bytes00; data: ptr Bytes00): cstring {.
    importc: "g_compute_hmac_for_bytes", libprag.}

proc computeHmacForBytes*(digestType: ChecksumType; key: Bytes; data: Bytes): string =
  let resul0 = g_compute_hmac_for_bytes(digestType, cast[ptr Bytes00](key.impl), cast[ptr Bytes00](data.impl))
  result = $resul0
  cogfree(resul0)

proc g_compute_hmac_for_data*(digestType: ChecksumType; key: uint8Array; keyLen: uint64; 
    data: uint8Array; length: uint64): cstring {.
    importc: "g_compute_hmac_for_data", libprag.}

proc computeHmacForData*(digestType: ChecksumType; key: uint8Array; keyLen: uint64; 
    data: uint8Array; length: uint64): string =
  let resul0 = g_compute_hmac_for_data(digestType, key, keyLen, data, length)
  result = $resul0
  cogfree(resul0)

proc g_compute_hmac_for_string*(digestType: ChecksumType; key: uint8Array; keyLen: uint64; 
    str: cstring; length: int64): cstring {.
    importc: "g_compute_hmac_for_string", libprag.}

proc computeHmacForString*(digestType: ChecksumType; key: uint8Array; keyLen: uint64; 
    str: string; length: int64): string =
  let resul0 = g_compute_hmac_for_string(digestType, key, keyLen, cstring(str), length)
  result = $resul0
  cogfree(resul0)

proc g_convert*(str: cstring; len: int64; toCodeset: cstring; fromCodeset: cstring; 
    bytesRead: var uint64; bytesWritten: var uint64): cstring {.
    importc: "g_convert", libprag.}

proc convert*(str: string; len: int64; toCodeset: string; fromCodeset: string; 
    bytesRead: var uint64; bytesWritten: var uint64): string =
  let resul0 = g_convert(cstring(str), len, cstring(toCodeset), cstring(fromCodeset), bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_convert_error_quark*(): uint32 {.
    importc: "g_convert_error_quark", libprag.}

proc convertErrorQuark*(): uint32 {.
    importc: "g_convert_error_quark", libprag.}

proc g_convert_with_fallback*(str: cstring; len: int64; toCodeset: cstring; fromCodeset: cstring; 
    fallback: cstring; bytesRead: ptr uint64; bytesWritten: ptr uint64): cstring {.
    importc: "g_convert_with_fallback", libprag.}

proc convertWithFallback*(str: string; len: int64; toCodeset: string; fromCodeset: string; 
    fallback: string; bytesRead: ptr uint64; bytesWritten: ptr uint64): string =
  let resul0 = g_convert_with_fallback(cstring(str), len, cstring(toCodeset), cstring(fromCodeset), cstring(fallback), bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_convert_with_iconv*(str: cstring; len: int64; `converter`: ptr IConv00; 
    bytesRead: ptr uint64; bytesWritten: ptr uint64): cstring {.
    importc: "g_convert_with_iconv", libprag.}

proc convertWithIconv*(str: string; len: int64; `converter`: IConv; bytesRead: ptr uint64; 
    bytesWritten: ptr uint64): string =
  let resul0 = g_convert_with_iconv(cstring(str), len, cast[ptr IConv00](`converter`.impl), bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_datalist_clear*(datalist: ptr Data00) {.
    importc: "g_datalist_clear", libprag.}

proc datalistClear*(datalist: Data) =
  g_datalist_clear(cast[ptr Data00](datalist.impl))

proc g_datalist_get_data*(datalist: ptr Data00; key: cstring): pointer {.
    importc: "g_datalist_get_data", libprag.}

proc datalistGetData*(datalist: Data; key: string): pointer =
  g_datalist_get_data(cast[ptr Data00](datalist.impl), cstring(key))

proc g_datalist_get_flags*(datalist: ptr Data00): uint32 {.
    importc: "g_datalist_get_flags", libprag.}

proc datalistGetFlags*(datalist: Data): int =
  int(g_datalist_get_flags(cast[ptr Data00](datalist.impl)))

proc g_datalist_id_get_data*(datalist: ptr Data00; keyId: uint32): pointer {.
    importc: "g_datalist_id_get_data", libprag.}

proc datalistIdGetData*(datalist: Data; keyId: int): pointer =
  g_datalist_id_get_data(cast[ptr Data00](datalist.impl), uint32(keyId))

proc g_datalist_id_remove_no_notify*(datalist: ptr Data00; keyId: uint32): pointer {.
    importc: "g_datalist_id_remove_no_notify", libprag.}

proc datalistIdRemoveNoNotify*(datalist: Data; keyId: int): pointer =
  g_datalist_id_remove_no_notify(cast[ptr Data00](datalist.impl), uint32(keyId))

proc g_datalist_id_replace_data*(datalist: ptr Data00; keyId: uint32; oldval: pointer; 
    newval: pointer; destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): gboolean {.
    importc: "g_datalist_id_replace_data", libprag.}

proc datalistIdReplaceData*(datalist: Data; keyId: int; oldval: pointer; newval: pointer; 
    destroy: DestroyNotify; oldDestroy: ptr DestroyNotify): bool =
  toBool(g_datalist_id_replace_data(cast[ptr Data00](datalist.impl), uint32(keyId), oldval, newval, destroy, oldDestroy))

proc g_datalist_id_set_data_full*(datalist: ptr Data00; keyId: uint32; data: pointer; 
    destroyFunc: DestroyNotify) {.
    importc: "g_datalist_id_set_data_full", libprag.}

proc datalistIdSetDataFull*(datalist: Data; keyId: int; data: pointer; destroyFunc: DestroyNotify) =
  g_datalist_id_set_data_full(cast[ptr Data00](datalist.impl), uint32(keyId), data, destroyFunc)

proc g_datalist_init*(datalist: ptr Data00) {.
    importc: "g_datalist_init", libprag.}

proc datalistInit*(datalist: Data) =
  g_datalist_init(cast[ptr Data00](datalist.impl))

proc g_datalist_set_flags*(datalist: ptr Data00; flags: uint32) {.
    importc: "g_datalist_set_flags", libprag.}

proc datalistSetFlags*(datalist: Data; flags: int) =
  g_datalist_set_flags(cast[ptr Data00](datalist.impl), uint32(flags))

proc g_datalist_unset_flags*(datalist: ptr Data00; flags: uint32) {.
    importc: "g_datalist_unset_flags", libprag.}

proc datalistUnsetFlags*(datalist: Data; flags: int) =
  g_datalist_unset_flags(cast[ptr Data00](datalist.impl), uint32(flags))

proc g_dataset_destroy*(datasetLocation: pointer) {.
    importc: "g_dataset_destroy", libprag.}

proc datasetDestroy*(datasetLocation: pointer) {.
    importc: "g_dataset_destroy", libprag.}

proc g_dataset_id_get_data*(datasetLocation: pointer; keyId: uint32): pointer {.
    importc: "g_dataset_id_get_data", libprag.}

proc datasetIdGetData*(datasetLocation: pointer; keyId: uint32): pointer {.
    importc: "g_dataset_id_get_data", libprag.}

proc g_dataset_id_remove_no_notify*(datasetLocation: pointer; keyId: uint32): pointer {.
    importc: "g_dataset_id_remove_no_notify", libprag.}

proc datasetIdRemoveNoNotify*(datasetLocation: pointer; keyId: uint32): pointer {.
    importc: "g_dataset_id_remove_no_notify", libprag.}

proc g_dataset_id_set_data_full*(datasetLocation: pointer; keyId: uint32; data: pointer; 
    destroyFunc: DestroyNotify) {.
    importc: "g_dataset_id_set_data_full", libprag.}

proc datasetIdSetDataFull*(datasetLocation: pointer; keyId: uint32; data: pointer; 
    destroyFunc: DestroyNotify) {.
    importc: "g_dataset_id_set_data_full", libprag.}

proc g_dcgettext*(domain: cstring; msgid: cstring; category: int32): cstring {.
    importc: "g_dcgettext", libprag.}

proc dcgettext*(domain: string; msgid: string; category: int): string =
  let resul0 = g_dcgettext(cstring(domain), cstring(msgid), int32(category))
  result = $resul0

proc g_dgettext*(domain: cstring; msgid: cstring): cstring {.
    importc: "g_dgettext", libprag.}

proc dgettext*(domain: string; msgid: string): string =
  let resul0 = g_dgettext(cstring(domain), cstring(msgid))
  result = $resul0

proc g_direct_equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_direct_equal", libprag.}

proc directEqual*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_direct_equal", libprag.}

proc g_direct_hash*(v: pointer): uint32 {.
    importc: "g_direct_hash", libprag.}

proc directHash*(v: pointer): uint32 {.
    importc: "g_direct_hash", libprag.}

proc g_dngettext*(domain: cstring; msgid: cstring; msgidPlural: cstring; 
    n: uint64): cstring {.
    importc: "g_dngettext", libprag.}

proc dngettext*(domain: string; msgid: string; msgidPlural: string; 
    n: uint64): string =
  let resul0 = g_dngettext(cstring(domain), cstring(msgid), cstring(msgidPlural), n)
  result = $resul0

proc g_double_equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_double_equal", libprag.}

proc doubleEqual*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_double_equal", libprag.}

proc g_double_hash*(v: pointer): uint32 {.
    importc: "g_double_hash", libprag.}

proc doubleHash*(v: pointer): uint32 {.
    importc: "g_double_hash", libprag.}

proc g_dpgettext*(domain: cstring; msgctxtid: cstring; msgidoffset: uint64): cstring {.
    importc: "g_dpgettext", libprag.}

proc dpgettext*(domain: string; msgctxtid: string; msgidoffset: uint64): string =
  let resul0 = g_dpgettext(cstring(domain), cstring(msgctxtid), msgidoffset)
  result = $resul0

proc g_dpgettext2*(domain: cstring; context: cstring; msgid: cstring): cstring {.
    importc: "g_dpgettext2", libprag.}

proc dpgettext2*(domain: string; context: string; msgid: string): string =
  let resul0 = g_dpgettext2(cstring(domain), cstring(context), cstring(msgid))
  result = $resul0

proc g_environ_getenv*(envp: cstringArray; variable: cstring): cstring {.
    importc: "g_environ_getenv", libprag.}

proc environGetenv*(envp: cstringArray; variable: string): string =
  let resul0 = g_environ_getenv(envp, cstring(variable))
  result = $resul0

proc g_environ_setenv*(envp: cstringArray; variable: cstring; value: cstring; 
    overwrite: gboolean): cstringArray {.
    importc: "g_environ_setenv", libprag.}

proc environSetenv*(envp: cstringArray; variable: cstring; value: cstring; 
    overwrite: gboolean): cstringArray {.
    importc: "g_environ_setenv", libprag.}

proc g_environ_unsetenv*(envp: cstringArray; variable: cstring): cstringArray {.
    importc: "g_environ_unsetenv", libprag.}

proc environUnsetenv*(envp: cstringArray; variable: cstring): cstringArray {.
    importc: "g_environ_unsetenv", libprag.}

proc g_file_error_from_errno*(errNo: int32): FileError {.
    importc: "g_file_error_from_errno", libprag.}

proc fileErrorFromErrno*(errNo: int32): FileError {.
    importc: "g_file_error_from_errno", libprag.}

proc g_file_error_quark*(): uint32 {.
    importc: "g_file_error_quark", libprag.}

proc fileErrorQuark*(): uint32 {.
    importc: "g_file_error_quark", libprag.}

proc g_file_get_contents*(filename: ucstring; contents: var uint8Array; length: var uint64): gboolean {.
    importc: "g_file_get_contents", libprag.}

proc fileGetContents*(filename: ucstring; contents: var uint8Array; length: var uint64): gboolean {.
    importc: "g_file_get_contents", libprag.}

proc g_file_open_tmp*(tmpl: ucstring; nameUsed: var ucstring): int32 {.
    importc: "g_file_open_tmp", libprag.}

proc fileOpenTmp*(tmpl: ucstring; nameUsed: var ucstring): int32 {.
    importc: "g_file_open_tmp", libprag.}

proc g_file_read_link*(filename: ucstring): ucstring {.
    importc: "g_file_read_link", libprag.}

proc fileReadLink*(filename: ucstring): ucstring {.
    importc: "g_file_read_link", libprag.}

proc g_file_set_contents*(filename: ucstring; contents: uint8Array; length: int64): gboolean {.
    importc: "g_file_set_contents", libprag.}

proc fileSetContents*(filename: ucstring; contents: uint8Array; length: int64): gboolean {.
    importc: "g_file_set_contents", libprag.}

proc g_file_test*(filename: ucstring; test: FileTest): gboolean {.
    importc: "g_file_test", libprag.}

proc fileTest*(filename: ucstring; test: FileTest): gboolean {.
    importc: "g_file_test", libprag.}

proc g_filename_display_basename*(filename: ucstring): cstring {.
    importc: "g_filename_display_basename", libprag.}

proc filenameDisplayBasename*(filename: ucstring): string =
  let resul0 = g_filename_display_basename(filename)
  result = $resul0
  cogfree(resul0)

proc g_filename_display_name*(filename: ucstring): cstring {.
    importc: "g_filename_display_name", libprag.}

proc filenameDisplayName*(filename: ucstring): string =
  let resul0 = g_filename_display_name(filename)
  result = $resul0
  cogfree(resul0)

proc g_filename_from_uri*(uri: cstring; hostname: var cstring): ucstring {.
    importc: "g_filename_from_uri", libprag.}

proc filenameFromUri*(uri: cstring; hostname: var cstring): ucstring {.
    importc: "g_filename_from_uri", libprag.}

proc g_filename_from_utf8*(utf8string: cstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): uint8Array {.
    importc: "g_filename_from_utf8", libprag.}

proc filenameFromUtf8*(utf8string: cstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): uint8Array {.
    importc: "g_filename_from_utf8", libprag.}

proc g_filename_to_uri*(filename: ucstring; hostname: cstring): cstring {.
    importc: "g_filename_to_uri", libprag.}

proc filenameToUri*(filename: ucstring; hostname: string): string =
  let resul0 = g_filename_to_uri(filename, cstring(hostname))
  result = $resul0
  cogfree(resul0)

proc g_filename_to_utf8*(opsysstring: ucstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): cstring {.
    importc: "g_filename_to_utf8", libprag.}

proc filenameToUtf8*(opsysstring: ucstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): string =
  let resul0 = g_filename_to_utf8(opsysstring, len, bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_find_program_in_path*(program: ucstring): ucstring {.
    importc: "g_find_program_in_path", libprag.}

proc findProgramInPath*(program: ucstring): ucstring {.
    importc: "g_find_program_in_path", libprag.}

proc g_format_size*(size: uint64): cstring {.
    importc: "g_format_size", libprag.}

proc formatSize*(size: uint64): string =
  let resul0 = g_format_size(size)
  result = $resul0
  cogfree(resul0)

proc g_format_size_for_display*(size: int64): cstring {.
    importc: "g_format_size_for_display", libprag.}

proc formatSizeForDisplay*(size: int64): string =
  let resul0 = g_format_size_for_display(size)
  result = $resul0
  cogfree(resul0)

proc g_format_size_full*(size: uint64; flags: FormatSizeFlags): cstring {.
    importc: "g_format_size_full", libprag.}

proc formatSizeFull*(size: uint64; flags: FormatSizeFlags): string =
  let resul0 = g_format_size_full(size, flags)
  result = $resul0
  cogfree(resul0)

proc g_free*(mem: pointer) {.
    importc: "g_free", libprag.}

proc free*(mem: pointer) {.
    importc: "g_free", libprag.}

proc g_get_application_name*(): cstring {.
    importc: "g_get_application_name", libprag.}

proc getApplicationName*(): string =
  let resul0 = g_get_application_name()
  result = $resul0

proc applicationName*(): string =
  let resul0 = g_get_application_name()
  result = $resul0

proc g_get_charset*(charset: var cstring): gboolean {.
    importc: "g_get_charset", libprag.}

proc getCharset*(charset: var cstring): gboolean {.
    importc: "g_get_charset", libprag.}

proc charset*(charset: var cstring): gboolean {.
    importc: "g_get_charset", libprag.}

proc g_get_codeset*(): cstring {.
    importc: "g_get_codeset", libprag.}

proc getCodeset*(): string =
  let resul0 = g_get_codeset()
  result = $resul0
  cogfree(resul0)

proc codeset*(): string =
  let resul0 = g_get_codeset()
  result = $resul0
  cogfree(resul0)

proc g_get_current_dir*(): ucstring {.
    importc: "g_get_current_dir", libprag.}

proc getCurrentDir*(): ucstring {.
    importc: "g_get_current_dir", libprag.}

proc currentDir*(): ucstring {.
    importc: "g_get_current_dir", libprag.}

proc g_get_current_time*(resu: ptr TimeVal00) {.
    importc: "g_get_current_time", libprag.}

proc getCurrentTime*(resu: TimeVal) =
  g_get_current_time(cast[ptr TimeVal00](resu.impl))

proc currentTime*(resu: TimeVal) =
  g_get_current_time(cast[ptr TimeVal00](resu.impl))

proc g_get_environ*(): cstringArray {.
    importc: "g_get_environ", libprag.}

proc getEnviron*(): cstringArray {.
    importc: "g_get_environ", libprag.}

proc environ*(): cstringArray {.
    importc: "g_get_environ", libprag.}

proc g_get_filename_charsets*(charsets: cstring): gboolean {.
    importc: "g_get_filename_charsets", libprag.}

proc getFilenameCharsets*(charsets: cstring): gboolean {.
    importc: "g_get_filename_charsets", libprag.}

proc filenameCharsets*(charsets: cstring): gboolean {.
    importc: "g_get_filename_charsets", libprag.}

proc g_get_home_dir*(): ucstring {.
    importc: "g_get_home_dir", libprag.}

proc getHomeDir*(): ucstring {.
    importc: "g_get_home_dir", libprag.}

proc homeDir*(): ucstring {.
    importc: "g_get_home_dir", libprag.}

proc g_get_host_name*(): cstring {.
    importc: "g_get_host_name", libprag.}

proc getHostName*(): string =
  let resul0 = g_get_host_name()
  result = $resul0

proc hostName*(): string =
  let resul0 = g_get_host_name()
  result = $resul0

proc g_get_language_names*(): cstringArray {.
    importc: "g_get_language_names", libprag.}

proc getLanguageNames*(): cstringArray {.
    importc: "g_get_language_names", libprag.}

proc languageNames*(): cstringArray {.
    importc: "g_get_language_names", libprag.}

proc g_get_locale_variants*(locale: cstring): cstringArray {.
    importc: "g_get_locale_variants", libprag.}

proc getLocaleVariants*(locale: cstring): cstringArray {.
    importc: "g_get_locale_variants", libprag.}

proc localeVariants*(locale: cstring): cstringArray {.
    importc: "g_get_locale_variants", libprag.}

proc g_get_monotonic_time*(): int64 {.
    importc: "g_get_monotonic_time", libprag.}

proc getMonotonicTime*(): int64 {.
    importc: "g_get_monotonic_time", libprag.}

proc monotonicTime*(): int64 {.
    importc: "g_get_monotonic_time", libprag.}

proc g_get_num_processors*(): uint32 {.
    importc: "g_get_num_processors", libprag.}

proc getNumProcessors*(): uint32 {.
    importc: "g_get_num_processors", libprag.}

proc numProcessors*(): uint32 {.
    importc: "g_get_num_processors", libprag.}

proc g_get_prgname*(): cstring {.
    importc: "g_get_prgname", libprag.}

proc getPrgname*(): string =
  let resul0 = g_get_prgname()
  result = $resul0

proc prgname*(): string =
  let resul0 = g_get_prgname()
  result = $resul0

proc g_get_real_name*(): ucstring {.
    importc: "g_get_real_name", libprag.}

proc getRealName*(): ucstring {.
    importc: "g_get_real_name", libprag.}

proc realName*(): ucstring {.
    importc: "g_get_real_name", libprag.}

proc g_get_real_time*(): int64 {.
    importc: "g_get_real_time", libprag.}

proc getRealTime*(): int64 {.
    importc: "g_get_real_time", libprag.}

proc realTime*(): int64 {.
    importc: "g_get_real_time", libprag.}

proc g_get_system_config_dirs*(): ucstringArray {.
    importc: "g_get_system_config_dirs", libprag.}

proc getSystemConfigDirs*(): ucstringArray {.
    importc: "g_get_system_config_dirs", libprag.}

proc systemConfigDirs*(): ucstringArray {.
    importc: "g_get_system_config_dirs", libprag.}

proc g_get_system_data_dirs*(): ucstringArray {.
    importc: "g_get_system_data_dirs", libprag.}

proc getSystemDataDirs*(): ucstringArray {.
    importc: "g_get_system_data_dirs", libprag.}

proc systemDataDirs*(): ucstringArray {.
    importc: "g_get_system_data_dirs", libprag.}

proc g_get_tmp_dir*(): ucstring {.
    importc: "g_get_tmp_dir", libprag.}

proc getTmpDir*(): ucstring {.
    importc: "g_get_tmp_dir", libprag.}

proc tmpDir*(): ucstring {.
    importc: "g_get_tmp_dir", libprag.}

proc g_get_user_cache_dir*(): ucstring {.
    importc: "g_get_user_cache_dir", libprag.}

proc getUserCacheDir*(): ucstring {.
    importc: "g_get_user_cache_dir", libprag.}

proc userCacheDir*(): ucstring {.
    importc: "g_get_user_cache_dir", libprag.}

proc g_get_user_config_dir*(): ucstring {.
    importc: "g_get_user_config_dir", libprag.}

proc getUserConfigDir*(): ucstring {.
    importc: "g_get_user_config_dir", libprag.}

proc userConfigDir*(): ucstring {.
    importc: "g_get_user_config_dir", libprag.}

proc g_get_user_data_dir*(): ucstring {.
    importc: "g_get_user_data_dir", libprag.}

proc getUserDataDir*(): ucstring {.
    importc: "g_get_user_data_dir", libprag.}

proc userDataDir*(): ucstring {.
    importc: "g_get_user_data_dir", libprag.}

proc g_get_user_name*(): ucstring {.
    importc: "g_get_user_name", libprag.}

proc getUserName*(): ucstring {.
    importc: "g_get_user_name", libprag.}

proc userName*(): ucstring {.
    importc: "g_get_user_name", libprag.}

proc g_get_user_runtime_dir*(): ucstring {.
    importc: "g_get_user_runtime_dir", libprag.}

proc getUserRuntimeDir*(): ucstring {.
    importc: "g_get_user_runtime_dir", libprag.}

proc userRuntimeDir*(): ucstring {.
    importc: "g_get_user_runtime_dir", libprag.}

proc g_get_user_special_dir*(directory: UserDirectory): ucstring {.
    importc: "g_get_user_special_dir", libprag.}

proc getUserSpecialDir*(directory: UserDirectory): ucstring {.
    importc: "g_get_user_special_dir", libprag.}

proc userSpecialDir*(directory: UserDirectory): ucstring {.
    importc: "g_get_user_special_dir", libprag.}

proc g_getenv*(variable: cstring): cstring {.
    importc: "g_getenv", libprag.}

proc getenv*(variable: string): string =
  let resul0 = g_getenv(cstring(variable))
  result = $resul0

proc env*(variable: string): string =
  let resul0 = g_getenv(cstring(variable))
  result = $resul0

proc g_hostname_is_ascii_encoded*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_ascii_encoded", libprag.}

proc hostnameIsAsciiEncoded*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_ascii_encoded", libprag.}

proc g_hostname_is_ip_address*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_ip_address", libprag.}

proc hostnameIsIpAddress*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_ip_address", libprag.}

proc g_hostname_is_non_ascii*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_non_ascii", libprag.}

proc hostnameIsNonAscii*(hostname: cstring): gboolean {.
    importc: "g_hostname_is_non_ascii", libprag.}

proc g_hostname_to_ascii*(hostname: cstring): cstring {.
    importc: "g_hostname_to_ascii", libprag.}

proc hostnameToAscii*(hostname: string): string =
  let resul0 = g_hostname_to_ascii(cstring(hostname))
  result = $resul0
  cogfree(resul0)

proc g_hostname_to_unicode*(hostname: cstring): cstring {.
    importc: "g_hostname_to_unicode", libprag.}

proc hostnameToUnicode*(hostname: string): string =
  let resul0 = g_hostname_to_unicode(cstring(hostname))
  result = $resul0
  cogfree(resul0)

proc g_idle_add_full*(priority: int32; function: SourceFunc; data: pointer; 
    notify: DestroyNotify): uint32 {.
    importc: "g_idle_add_full", libprag.}

proc idleAdd*(priority: int32; function: SourceFunc; data: pointer; 
    notify: DestroyNotify): uint32 {.
    importc: "g_idle_add_full", libprag.}

proc g_idle_remove_by_data*(data: pointer): gboolean {.
    importc: "g_idle_remove_by_data", libprag.}

proc idleRemoveByData*(data: pointer): gboolean {.
    importc: "g_idle_remove_by_data", libprag.}

proc g_idle_source_new*(): ptr Source00 {.
    importc: "g_idle_source_new", libprag.}

proc idleSourceNew*(): Source =
  new(result)
  result.impl = g_idle_source_new()

proc g_int64_equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_int64_equal", libprag.}

proc int64Equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_int64_equal", libprag.}

proc g_int64_hash*(v: pointer): uint32 {.
    importc: "g_int64_hash", libprag.}

proc int64Hash*(v: pointer): uint32 {.
    importc: "g_int64_hash", libprag.}

proc g_int_equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_int_equal", libprag.}

proc intEqual*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_int_equal", libprag.}

proc g_int_hash*(v: pointer): uint32 {.
    importc: "g_int_hash", libprag.}

proc intHash*(v: pointer): uint32 {.
    importc: "g_int_hash", libprag.}

proc g_intern_static_string*(string: cstring): cstring {.
    importc: "g_intern_static_string", libprag.}

proc internStaticString*(string: string): string =
  let resul0 = g_intern_static_string(cstring(string))
  result = $resul0

proc g_intern_string*(string: cstring): cstring {.
    importc: "g_intern_string", libprag.}

proc internString*(string: string): string =
  let resul0 = g_intern_string(cstring(string))
  result = $resul0

proc g_io_add_watch_full*(channel: ptr IOChannel00; priority: int32; condition: IOCondition; 
    `func`: IOFunc; userData: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_io_add_watch_full", libprag.}

proc ioAddWatch*(channel: IOChannel; priority: int; condition: IOCondition; 
    `func`: IOFunc; userData: pointer; notify: DestroyNotify): int =
  int(g_io_add_watch_full(cast[ptr IOChannel00](channel.impl), int32(priority), condition, `func`, userData, notify))

proc g_io_create_watch*(channel: ptr IOChannel00; condition: IOCondition): ptr Source00 {.
    importc: "g_io_create_watch", libprag.}

proc ioCreateWatch*(channel: IOChannel; condition: IOCondition): Source =
  new(result)
  result.impl = g_io_create_watch(cast[ptr IOChannel00](channel.impl), condition)

proc g_listenv*(): cstringArray {.
    importc: "g_listenv", libprag.}

proc listenv*(): cstringArray {.
    importc: "g_listenv", libprag.}

proc g_locale_from_utf8*(utf8string: cstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): cstring {.
    importc: "g_locale_from_utf8", libprag.}

proc localeFromUtf8*(utf8string: string; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): string =
  let resul0 = g_locale_from_utf8(cstring(utf8string), len, bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_locale_to_utf8*(opsysstring: cstring; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): cstring {.
    importc: "g_locale_to_utf8", libprag.}

proc localeToUtf8*(opsysstring: string; len: int64; bytesRead: var uint64; 
    bytesWritten: var uint64): string =
  let resul0 = g_locale_to_utf8(cstring(opsysstring), len, bytesRead, bytesWritten)
  result = $resul0
  cogfree(resul0)

proc g_log_default_handler*(logDomain: cstring; logLevel: LogLevelFlags; message: cstring; 
    unusedData: pointer) {.
    importc: "g_log_default_handler", libprag.}

proc logDefaultHandler*(logDomain: cstring; logLevel: LogLevelFlags; message: cstring; 
    unusedData: pointer) {.
    importc: "g_log_default_handler", libprag.}

proc g_log_remove_handler*(logDomain: cstring; handlerId: uint32) {.
    importc: "g_log_remove_handler", libprag.}

proc logRemoveHandler*(logDomain: cstring; handlerId: uint32) {.
    importc: "g_log_remove_handler", libprag.}

proc g_log_set_always_fatal*(fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_always_fatal", libprag.}

proc logSetAlwaysFatal*(fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_always_fatal", libprag.}

proc g_log_set_fatal_mask*(logDomain: cstring; fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_fatal_mask", libprag.}

proc logSetFatalMask*(logDomain: cstring; fatalMask: LogLevelFlags): LogLevelFlags {.
    importc: "g_log_set_fatal_mask", libprag.}

proc g_log_set_handler_full*(logDomain: cstring; logLevels: LogLevelFlags; logFunc: LogFunc; 
    userData: pointer; destroy: DestroyNotify): uint32 {.
    importc: "g_log_set_handler_full", libprag.}

proc logSetHandler*(logDomain: cstring; logLevels: LogLevelFlags; logFunc: LogFunc; 
    userData: pointer; destroy: DestroyNotify): uint32 {.
    importc: "g_log_set_handler_full", libprag.}

proc g_log_set_writer_func*(`func`: LogWriterFunc; userData: pointer; userDataFree: DestroyNotify) {.
    importc: "g_log_set_writer_func", libprag.}

proc logSetWriterFunc*(`func`: LogWriterFunc; userData: pointer; userDataFree: DestroyNotify) {.
    importc: "g_log_set_writer_func", libprag.}

proc g_log_structured_array*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64) {.
    importc: "g_log_structured_array", libprag.}

proc logStructuredArray*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64) {.
    importc: "g_log_structured_array", libprag.}

proc g_log_variant*(logDomain: cstring; logLevel: LogLevelFlags; fields: ptr Variant00) {.
    importc: "g_log_variant", libprag.}

proc logVariant*(logDomain: string; logLevel: LogLevelFlags; fields: Variant) =
  g_log_variant(cstring(logDomain), logLevel, cast[ptr Variant00](fields.impl))

proc g_log_writer_default*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_default", libprag.}

proc logWriterDefault*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_default", libprag.}

proc g_log_writer_format_fields*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; useColor: gboolean): cstring {.
    importc: "g_log_writer_format_fields", libprag.}

proc logWriterFormatFields*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; useColor: bool): string =
  let resul0 = g_log_writer_format_fields(logLevel, fields, nFields, gboolean(useColor))
  result = $resul0
  cogfree(resul0)

proc g_log_writer_is_journald*(outputFd: int32): gboolean {.
    importc: "g_log_writer_is_journald", libprag.}

proc logWriterIsJournald*(outputFd: int32): gboolean {.
    importc: "g_log_writer_is_journald", libprag.}

proc g_log_writer_journald*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_journald", libprag.}

proc logWriterJournald*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_journald", libprag.}

proc g_log_writer_standard_streams*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_standard_streams", libprag.}

proc logWriterStandardStreams*(logLevel: LogLevelFlags; fields: LogField00Array; 
    nFields: uint64; userData: pointer): LogWriterOutput {.
    importc: "g_log_writer_standard_streams", libprag.}

proc g_log_writer_supports_color*(outputFd: int32): gboolean {.
    importc: "g_log_writer_supports_color", libprag.}

proc logWriterSupportsColor*(outputFd: int32): gboolean {.
    importc: "g_log_writer_supports_color", libprag.}

proc g_main_current_source*(): ptr Source00 {.
    importc: "g_main_current_source", libprag.}

proc mainCurrentSource*(): Source =
  new(result)
  result.impl = g_main_current_source()

proc g_main_depth*(): int32 {.
    importc: "g_main_depth", libprag.}

proc mainDepth*(): int32 {.
    importc: "g_main_depth", libprag.}

proc g_malloc*(nBytes: uint64): pointer {.
    importc: "g_malloc", libprag.}

proc malloc*(nBytes: uint64): pointer {.
    importc: "g_malloc", libprag.}

proc g_malloc0*(nBytes: uint64): pointer {.
    importc: "g_malloc0", libprag.}

proc malloc0*(nBytes: uint64): pointer {.
    importc: "g_malloc0", libprag.}

proc g_malloc0_n*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc0_n", libprag.}

proc malloc0N*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc0_n", libprag.}

proc g_malloc_n*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc_n", libprag.}

proc mallocN*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_malloc_n", libprag.}

proc g_markup_error_quark*(): uint32 {.
    importc: "g_markup_error_quark", libprag.}

proc markupErrorQuark*(): uint32 {.
    importc: "g_markup_error_quark", libprag.}

proc g_markup_escape_text*(text: cstring; length: int64): cstring {.
    importc: "g_markup_escape_text", libprag.}

proc markupEscapeText*(text: string; length: int64): string =
  let resul0 = g_markup_escape_text(cstring(text), length)
  result = $resul0
  cogfree(resul0)

proc g_mem_is_system_malloc*(): gboolean {.
    importc: "g_mem_is_system_malloc", libprag.}

proc memIsSystemMalloc*(): gboolean {.
    importc: "g_mem_is_system_malloc", libprag.}

proc g_mem_profile*() {.
    importc: "g_mem_profile", libprag.}

proc memProfile*() {.
    importc: "g_mem_profile", libprag.}

proc g_mem_set_vtable*(vtable: ptr MemVTable00) {.
    importc: "g_mem_set_vtable", libprag.}

proc memSetVtable*(vtable: MemVTable) =
  g_mem_set_vtable(cast[ptr MemVTable00](vtable.impl))

proc g_memdup*(mem: pointer; byteSize: uint32): pointer {.
    importc: "g_memdup", libprag.}

proc memdup*(mem: pointer; byteSize: uint32): pointer {.
    importc: "g_memdup", libprag.}

proc g_mkdir_with_parents*(pathname: ucstring; mode: int32): int32 {.
    importc: "g_mkdir_with_parents", libprag.}

proc mkdirWithParents*(pathname: ucstring; mode: int32): int32 {.
    importc: "g_mkdir_with_parents", libprag.}

proc g_mkdtemp*(tmpl: ucstring): ucstring {.
    importc: "g_mkdtemp", libprag.}

proc mkdtemp*(tmpl: ucstring): ucstring {.
    importc: "g_mkdtemp", libprag.}

proc g_mkdtemp_full*(tmpl: ucstring; mode: int32): ucstring {.
    importc: "g_mkdtemp_full", libprag.}

proc mkdtempFull*(tmpl: ucstring; mode: int32): ucstring {.
    importc: "g_mkdtemp_full", libprag.}

proc g_mkstemp*(tmpl: ucstring): int32 {.
    importc: "g_mkstemp", libprag.}

proc mkstemp*(tmpl: ucstring): int32 {.
    importc: "g_mkstemp", libprag.}

proc g_mkstemp_full*(tmpl: ucstring; flags: int32; mode: int32): int32 {.
    importc: "g_mkstemp_full", libprag.}

proc mkstempFull*(tmpl: ucstring; flags: int32; mode: int32): int32 {.
    importc: "g_mkstemp_full", libprag.}

proc g_nullify_pointer*(nullifyLocation: pointer) {.
    importc: "g_nullify_pointer", libprag.}

proc nullifyPointer*(nullifyLocation: pointer) {.
    importc: "g_nullify_pointer", libprag.}

proc g_on_error_query*(prgName: cstring) {.
    importc: "g_on_error_query", libprag.}

proc onErrorQuery*(prgName: cstring) {.
    importc: "g_on_error_query", libprag.}

proc g_on_error_stack_trace*(prgName: cstring) {.
    importc: "g_on_error_stack_trace", libprag.}

proc onErrorStackTrace*(prgName: cstring) {.
    importc: "g_on_error_stack_trace", libprag.}

proc g_option_error_quark*(): uint32 {.
    importc: "g_option_error_quark", libprag.}

proc optionErrorQuark*(): uint32 {.
    importc: "g_option_error_quark", libprag.}

proc g_parse_debug_string*(string: cstring; keys: DebugKey00Array; nkeys: uint32): uint32 {.
    importc: "g_parse_debug_string", libprag.}

proc parseDebugString*(string: cstring; keys: DebugKey00Array; nkeys: uint32): uint32 {.
    importc: "g_parse_debug_string", libprag.}

proc g_path_get_basename*(fileName: ucstring): ucstring {.
    importc: "g_path_get_basename", libprag.}

proc pathGetBasename*(fileName: ucstring): ucstring {.
    importc: "g_path_get_basename", libprag.}

proc g_path_get_dirname*(fileName: ucstring): ucstring {.
    importc: "g_path_get_dirname", libprag.}

proc pathGetDirname*(fileName: ucstring): ucstring {.
    importc: "g_path_get_dirname", libprag.}

proc g_path_is_absolute*(fileName: ucstring): gboolean {.
    importc: "g_path_is_absolute", libprag.}

proc pathIsAbsolute*(fileName: ucstring): gboolean {.
    importc: "g_path_is_absolute", libprag.}

proc g_path_skip_root*(fileName: ucstring): ucstring {.
    importc: "g_path_skip_root", libprag.}

proc pathSkipRoot*(fileName: ucstring): ucstring {.
    importc: "g_path_skip_root", libprag.}

proc g_pattern_match*(pspec: ptr PatternSpec00; stringLength: uint32; string: cstring; 
    stringReversed: cstring): gboolean {.
    importc: "g_pattern_match", libprag.}

proc patternMatch*(pspec: PatternSpec; stringLength: int; string: string; 
    stringReversed: string): bool =
  toBool(g_pattern_match(cast[ptr PatternSpec00](pspec.impl), uint32(stringLength), cstring(string), cstring(stringReversed)))

proc g_pattern_match_simple*(pattern: cstring; string: cstring): gboolean {.
    importc: "g_pattern_match_simple", libprag.}

proc patternMatchSimple*(pattern: cstring; string: cstring): gboolean {.
    importc: "g_pattern_match_simple", libprag.}

proc g_pattern_match_string*(pspec: ptr PatternSpec00; string: cstring): gboolean {.
    importc: "g_pattern_match_string", libprag.}

proc patternMatchString*(pspec: PatternSpec; string: string): bool =
  toBool(g_pattern_match_string(cast[ptr PatternSpec00](pspec.impl), cstring(string)))

proc g_pointer_bit_lock*(address: pointer; lockBit: int32) {.
    importc: "g_pointer_bit_lock", libprag.}

proc pointerBitLock*(address: pointer; lockBit: int32) {.
    importc: "g_pointer_bit_lock", libprag.}

proc g_pointer_bit_trylock*(address: pointer; lockBit: int32): gboolean {.
    importc: "g_pointer_bit_trylock", libprag.}

proc pointerBitTrylock*(address: pointer; lockBit: int32): gboolean {.
    importc: "g_pointer_bit_trylock", libprag.}

proc g_pointer_bit_unlock*(address: pointer; lockBit: int32) {.
    importc: "g_pointer_bit_unlock", libprag.}

proc pointerBitUnlock*(address: pointer; lockBit: int32) {.
    importc: "g_pointer_bit_unlock", libprag.}

proc g_poll*(fds: ptr PollFD00; nfds: uint32; timeout: int32): int32 {.
    importc: "g_poll", libprag.}

proc poll*(fds: PollFD; nfds: int; timeout: int): int =
  int(g_poll(cast[ptr PollFD00](fds.impl), uint32(nfds), int32(timeout)))

proc g_propagate_error*(dest: var ptr Error00; src: ptr Error00) {.
    importc: "g_propagate_error", libprag.}

proc propagateError*(dest: var ptr Error00; src: ptr Error00) {.
    importc: "g_propagate_error", libprag.}

proc g_quark_from_static_string*(string: cstring): uint32 {.
    importc: "g_quark_from_static_string", libprag.}

proc quarkFromStaticString*(string: cstring): uint32 {.
    importc: "g_quark_from_static_string", libprag.}

proc g_quark_from_string*(string: cstring): uint32 {.
    importc: "g_quark_from_string", libprag.}

proc quarkFromString*(string: cstring): uint32 {.
    importc: "g_quark_from_string", libprag.}

proc g_quark_to_string*(quark: uint32): cstring {.
    importc: "g_quark_to_string", libprag.}

proc quarkToString*(quark: int): string =
  let resul0 = g_quark_to_string(uint32(quark))
  result = $resul0

proc g_quark_try_string*(string: cstring): uint32 {.
    importc: "g_quark_try_string", libprag.}

proc quarkTryString*(string: cstring): uint32 {.
    importc: "g_quark_try_string", libprag.}

proc g_random_double*(): cdouble {.
    importc: "g_random_double", libprag.}

proc randomDouble*(): cdouble {.
    importc: "g_random_double", libprag.}

proc g_random_double_range*(begin: cdouble; `end`: cdouble): cdouble {.
    importc: "g_random_double_range", libprag.}

proc randomDoubleRange*(begin: cdouble; `end`: cdouble): cdouble {.
    importc: "g_random_double_range", libprag.}

proc g_random_int*(): uint32 {.
    importc: "g_random_int", libprag.}

proc randomInt*(): uint32 {.
    importc: "g_random_int", libprag.}

proc g_random_int_range*(begin: int32; `end`: int32): int32 {.
    importc: "g_random_int_range", libprag.}

proc randomIntRange*(begin: int32; `end`: int32): int32 {.
    importc: "g_random_int_range", libprag.}

proc g_random_set_seed*(seed: uint32) {.
    importc: "g_random_set_seed", libprag.}

proc randomSetSeed*(seed: uint32) {.
    importc: "g_random_set_seed", libprag.}

proc g_realloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_realloc", libprag.}

proc realloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_realloc", libprag.}

proc g_realloc_n*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_realloc_n", libprag.}

proc reallocN*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_realloc_n", libprag.}

proc g_reload_user_special_dirs_cache*() {.
    importc: "g_reload_user_special_dirs_cache", libprag.}

proc reloadUserSpecialDirsCache*() {.
    importc: "g_reload_user_special_dirs_cache", libprag.}

proc g_rmdir*(filename: ucstring): int32 {.
    importc: "g_rmdir", libprag.}

proc rmdir*(filename: ucstring): int32 {.
    importc: "g_rmdir", libprag.}

proc g_set_application_name*(applicationName: cstring) {.
    importc: "g_set_application_name", libprag.}

proc setApplicationName*(applicationName: cstring) {.
    importc: "g_set_application_name", libprag.}

proc `applicationName=`*(applicationName: cstring) {.
    importc: "g_set_application_name", libprag.}

proc g_set_error_literal*(err: var ptr Error00; domain: uint32; code: int32; 
    message: cstring) {.
    importc: "g_set_error_literal", libprag.}

proc setErrorLiteral*(err: var ptr Error00; domain: uint32; code: int32; 
    message: cstring) {.
    importc: "g_set_error_literal", libprag.}

proc g_set_prgname*(prgname: cstring) {.
    importc: "g_set_prgname", libprag.}

proc setPrgname*(prgname: cstring) {.
    importc: "g_set_prgname", libprag.}

proc `prgname=`*(prgname: cstring) {.
    importc: "g_set_prgname", libprag.}

proc g_setenv*(variable: cstring; value: cstring; overwrite: gboolean): gboolean {.
    importc: "g_setenv", libprag.}

proc setenv*(variable: cstring; value: cstring; overwrite: gboolean): gboolean {.
    importc: "g_setenv", libprag.}

proc g_shell_error_quark*(): uint32 {.
    importc: "g_shell_error_quark", libprag.}

proc shellErrorQuark*(): uint32 {.
    importc: "g_shell_error_quark", libprag.}

proc g_shell_parse_argv*(commandLine: cstring; argcp: var int32; argvp: var cstringArray): gboolean {.
    importc: "g_shell_parse_argv", libprag.}

proc shellParseArgv*(commandLine: cstring; argcp: var int32; argvp: var cstringArray): gboolean {.
    importc: "g_shell_parse_argv", libprag.}

proc g_shell_quote*(unquotedString: cstring): cstring {.
    importc: "g_shell_quote", libprag.}

proc shellQuote*(unquotedString: string): string =
  let resul0 = g_shell_quote(cstring(unquotedString))
  result = $resul0
  cogfree(resul0)

proc g_shell_unquote*(quotedString: cstring): cstring {.
    importc: "g_shell_unquote", libprag.}

proc shellUnquote*(quotedString: string): string =
  let resul0 = g_shell_unquote(cstring(quotedString))
  result = $resul0
  cogfree(resul0)

proc g_slice_alloc*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc", libprag.}

proc sliceAlloc*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc", libprag.}

proc g_slice_alloc0*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc0", libprag.}

proc sliceAlloc0*(blockSize: uint64): pointer {.
    importc: "g_slice_alloc0", libprag.}

proc g_slice_copy*(blockSize: uint64; memBlock: pointer): pointer {.
    importc: "g_slice_copy", libprag.}

proc sliceCopy*(blockSize: uint64; memBlock: pointer): pointer {.
    importc: "g_slice_copy", libprag.}

proc g_slice_free1*(blockSize: uint64; memBlock: pointer) {.
    importc: "g_slice_free1", libprag.}

proc sliceFree1*(blockSize: uint64; memBlock: pointer) {.
    importc: "g_slice_free1", libprag.}

proc g_slice_free_chain_with_offset*(blockSize: uint64; memChain: pointer; nextOffset: uint64) {.
    importc: "g_slice_free_chain_with_offset", libprag.}

proc sliceFreeChainWithOffset*(blockSize: uint64; memChain: pointer; nextOffset: uint64) {.
    importc: "g_slice_free_chain_with_offset", libprag.}

proc g_slice_get_config*(ckey: SliceConfig): int64 {.
    importc: "g_slice_get_config", libprag.}

proc sliceGetConfig*(ckey: SliceConfig): int64 {.
    importc: "g_slice_get_config", libprag.}

proc g_slice_get_config_state*(ckey: SliceConfig; address: int64; nValues: ptr uint32): ptr int64 {.
    importc: "g_slice_get_config_state", libprag.}

proc sliceGetConfigState*(ckey: SliceConfig; address: int64; nValues: ptr uint32): ptr int64 {.
    importc: "g_slice_get_config_state", libprag.}

proc g_slice_set_config*(ckey: SliceConfig; value: int64) {.
    importc: "g_slice_set_config", libprag.}

proc sliceSetConfig*(ckey: SliceConfig; value: int64) {.
    importc: "g_slice_set_config", libprag.}

proc g_spaced_primes_closest*(num: uint32): uint32 {.
    importc: "g_spaced_primes_closest", libprag.}

proc spacedPrimesClosest*(num: uint32): uint32 {.
    importc: "g_spaced_primes_closest", libprag.}

proc g_spawn_async*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; childPid: var int32): gboolean {.
    importc: "g_spawn_async", libprag.}

proc spawnAsync*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; childPid: var int32): gboolean {.
    importc: "g_spawn_async", libprag.}

proc g_spawn_async_with_pipes*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; childPid: var int32; 
    standardInput: var int32; standardOutput: var int32; standardError: var int32): gboolean {.
    importc: "g_spawn_async_with_pipes", libprag.}

proc spawnAsyncWithPipes*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; childPid: var int32; 
    standardInput: var int32; standardOutput: var int32; standardError: var int32): gboolean {.
    importc: "g_spawn_async_with_pipes", libprag.}

proc g_spawn_check_exit_status*(exitStatus: int32): gboolean {.
    importc: "g_spawn_check_exit_status", libprag.}

proc spawnCheckExitStatus*(exitStatus: int32): gboolean {.
    importc: "g_spawn_check_exit_status", libprag.}

proc g_spawn_close_pid*(pid: int32) {.
    importc: "g_spawn_close_pid", libprag.}

proc spawnClosePid*(pid: int32) {.
    importc: "g_spawn_close_pid", libprag.}

proc g_spawn_command_line_async*(commandLine: cstring): gboolean {.
    importc: "g_spawn_command_line_async", libprag.}

proc spawnCommandLineAsync*(commandLine: cstring): gboolean {.
    importc: "g_spawn_command_line_async", libprag.}

proc g_spawn_command_line_sync*(commandLine: cstring; standardOutput: var uint8Array; 
    standardError: var uint8Array; exitStatus: var int32): gboolean {.
    importc: "g_spawn_command_line_sync", libprag.}

proc spawnCommandLineSync*(commandLine: cstring; standardOutput: var uint8Array; 
    standardError: var uint8Array; exitStatus: var int32): gboolean {.
    importc: "g_spawn_command_line_sync", libprag.}

proc g_spawn_error_quark*(): uint32 {.
    importc: "g_spawn_error_quark", libprag.}

proc spawnErrorQuark*(): uint32 {.
    importc: "g_spawn_error_quark", libprag.}

proc g_spawn_exit_error_quark*(): uint32 {.
    importc: "g_spawn_exit_error_quark", libprag.}

proc spawnExitErrorQuark*(): uint32 {.
    importc: "g_spawn_exit_error_quark", libprag.}

proc g_spawn_sync*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; standardOutput: var uint8Array; 
    standardError: var uint8Array; exitStatus: var int32): gboolean {.
    importc: "g_spawn_sync", libprag.}

proc spawnSync*(workingDirectory: ucstring; argv: cstringArray; envp: cstringArray; 
    flags: SpawnFlags; childSetup: SpawnChildSetupFunc; userData: pointer; standardOutput: var uint8Array; 
    standardError: var uint8Array; exitStatus: var int32): gboolean {.
    importc: "g_spawn_sync", libprag.}

proc g_stpcpy*(dest: cstring; src: cstring): cstring {.
    importc: "g_stpcpy", libprag.}

proc stpcpy*(dest: string; src: string): string =
  let resul0 = g_stpcpy(cstring(dest), cstring(src))
  result = $resul0
  cogfree(resul0)

proc g_str_equal*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_str_equal", libprag.}

proc strEqual*(v1: pointer; v2: pointer): gboolean {.
    importc: "g_str_equal", libprag.}

proc g_str_has_prefix*(str: cstring; prefix: cstring): gboolean {.
    importc: "g_str_has_prefix", libprag.}

proc strHasPrefix*(str: cstring; prefix: cstring): gboolean {.
    importc: "g_str_has_prefix", libprag.}

proc g_str_has_suffix*(str: cstring; suffix: cstring): gboolean {.
    importc: "g_str_has_suffix", libprag.}

proc strHasSuffix*(str: cstring; suffix: cstring): gboolean {.
    importc: "g_str_has_suffix", libprag.}

proc g_str_hash*(v: pointer): uint32 {.
    importc: "g_str_hash", libprag.}

proc strHash*(v: pointer): uint32 {.
    importc: "g_str_hash", libprag.}

proc g_str_is_ascii*(str: cstring): gboolean {.
    importc: "g_str_is_ascii", libprag.}

proc strIsAscii*(str: cstring): gboolean {.
    importc: "g_str_is_ascii", libprag.}

proc g_str_match_string*(searchTerm: cstring; potentialHit: cstring; acceptAlternates: gboolean): gboolean {.
    importc: "g_str_match_string", libprag.}

proc strMatchString*(searchTerm: cstring; potentialHit: cstring; acceptAlternates: gboolean): gboolean {.
    importc: "g_str_match_string", libprag.}

proc g_str_to_ascii*(str: cstring; fromLocale: cstring): cstring {.
    importc: "g_str_to_ascii", libprag.}

proc strToAscii*(str: string; fromLocale: string): string =
  let resul0 = g_str_to_ascii(cstring(str), cstring(fromLocale))
  result = $resul0
  cogfree(resul0)

proc g_str_tokenize_and_fold*(string: cstring; translitLocale: cstring; asciiAlternates: var cstringArray): cstringArray {.
    importc: "g_str_tokenize_and_fold", libprag.}

proc strTokenizeAndFold*(string: cstring; translitLocale: cstring; asciiAlternates: var cstringArray): cstringArray {.
    importc: "g_str_tokenize_and_fold", libprag.}

proc g_strcanon*(string: cstring; validChars: cstring; substitutor: int8): cstring {.
    importc: "g_strcanon", libprag.}

proc strcanon*(string: string; validChars: string; substitutor: int8): string =
  let resul0 = g_strcanon(cstring(string), cstring(validChars), substitutor)
  result = $resul0
  cogfree(resul0)

proc g_strcasecmp*(s1: cstring; s2: cstring): int32 {.
    importc: "g_strcasecmp", libprag.}

proc strcasecmp*(s1: cstring; s2: cstring): int32 {.
    importc: "g_strcasecmp", libprag.}

proc g_strchomp*(string: cstring): cstring {.
    importc: "g_strchomp", libprag.}

proc strchomp*(string: string): string =
  let resul0 = g_strchomp(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_strchug*(string: cstring): cstring {.
    importc: "g_strchug", libprag.}

proc strchug*(string: string): string =
  let resul0 = g_strchug(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_strcmp0*(str1: cstring; str2: cstring): int32 {.
    importc: "g_strcmp0", libprag.}

proc strcmp0*(str1: cstring; str2: cstring): int32 {.
    importc: "g_strcmp0", libprag.}

proc g_strcompress*(source: cstring): cstring {.
    importc: "g_strcompress", libprag.}

proc strcompress*(source: string): string =
  let resul0 = g_strcompress(cstring(source))
  result = $resul0
  cogfree(resul0)

proc g_strdelimit*(string: cstring; delimiters: cstring; newDelimiter: int8): cstring {.
    importc: "g_strdelimit", libprag.}

proc strdelimit*(string: string; delimiters: string; newDelimiter: int8): string =
  let resul0 = g_strdelimit(cstring(string), cstring(delimiters), newDelimiter)
  result = $resul0
  cogfree(resul0)

proc g_strdown*(string: cstring): cstring {.
    importc: "g_strdown", libprag.}

proc strdown*(string: string): string =
  let resul0 = g_strdown(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_strdup*(str: cstring): cstring {.
    importc: "g_strdup", libprag.}

proc strdup*(str: string): string =
  let resul0 = g_strdup(cstring(str))
  result = $resul0
  cogfree(resul0)

proc g_strerror*(errnum: int32): cstring {.
    importc: "g_strerror", libprag.}

proc strerror*(errnum: int): string =
  let resul0 = g_strerror(int32(errnum))
  result = $resul0

proc g_strescape*(source: cstring; exceptions: cstring): cstring {.
    importc: "g_strescape", libprag.}

proc strescape*(source: string; exceptions: string): string =
  let resul0 = g_strescape(cstring(source), cstring(exceptions))
  result = $resul0
  cogfree(resul0)

proc g_strfreev*(strArray: cstring) {.
    importc: "g_strfreev", libprag.}

proc strfreev*(strArray: cstring) {.
    importc: "g_strfreev", libprag.}

proc g_string_new*(init: cstring): ptr String00 {.
    importc: "g_string_new", libprag.}

proc stringNew*(init: string): String =
  new(result)
  result.impl = g_string_new(cstring(init))

proc g_string_new_len*(init: cstring; len: int64): ptr String00 {.
    importc: "g_string_new_len", libprag.}

proc stringNewLen*(init: string; len: int64): String =
  new(result)
  result.impl = g_string_new_len(cstring(init), len)

proc g_string_sized_new*(dflSize: uint64): ptr String00 {.
    importc: "g_string_sized_new", libprag.}

proc stringSizedNew*(dflSize: uint64): String =
  new(result)
  result.impl = g_string_sized_new(dflSize)

proc g_strip_context*(msgid: cstring; msgval: cstring): cstring {.
    importc: "g_strip_context", libprag.}

proc stripContext*(msgid: string; msgval: string): string =
  let resul0 = g_strip_context(cstring(msgid), cstring(msgval))
  result = $resul0

proc g_strjoinv*(separator: cstring; strArray: cstring): cstring {.
    importc: "g_strjoinv", libprag.}

proc strjoinv*(separator: string; strArray: string): string =
  let resul0 = g_strjoinv(cstring(separator), cstring(strArray))
  result = $resul0
  cogfree(resul0)

proc g_strlcat*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcat", libprag.}

proc strlcat*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcat", libprag.}

proc g_strlcpy*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcpy", libprag.}

proc strlcpy*(dest: cstring; src: cstring; destSize: uint64): uint64 {.
    importc: "g_strlcpy", libprag.}

proc g_strncasecmp*(s1: cstring; s2: cstring; n: uint32): int32 {.
    importc: "g_strncasecmp", libprag.}

proc strncasecmp*(s1: cstring; s2: cstring; n: uint32): int32 {.
    importc: "g_strncasecmp", libprag.}

proc g_strndup*(str: cstring; n: uint64): cstring {.
    importc: "g_strndup", libprag.}

proc strndup*(str: string; n: uint64): string =
  let resul0 = g_strndup(cstring(str), n)
  result = $resul0
  cogfree(resul0)

proc g_strnfill*(length: uint64; fillChar: int8): cstring {.
    importc: "g_strnfill", libprag.}

proc strnfill*(length: uint64; fillChar: int8): string =
  let resul0 = g_strnfill(length, fillChar)
  result = $resul0
  cogfree(resul0)

proc g_strreverse*(string: cstring): cstring {.
    importc: "g_strreverse", libprag.}

proc strreverse*(string: string): string =
  let resul0 = g_strreverse(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_strrstr*(haystack: cstring; needle: cstring): cstring {.
    importc: "g_strrstr", libprag.}

proc strrstr*(haystack: string; needle: string): string =
  let resul0 = g_strrstr(cstring(haystack), cstring(needle))
  result = $resul0
  cogfree(resul0)

proc g_strrstr_len*(haystack: cstring; haystackLen: int64; needle: cstring): cstring {.
    importc: "g_strrstr_len", libprag.}

proc strrstrLen*(haystack: string; haystackLen: int64; needle: string): string =
  let resul0 = g_strrstr_len(cstring(haystack), haystackLen, cstring(needle))
  result = $resul0
  cogfree(resul0)

proc g_strsignal*(signum: int32): cstring {.
    importc: "g_strsignal", libprag.}

proc strsignal*(signum: int): string =
  let resul0 = g_strsignal(int32(signum))
  result = $resul0

proc g_strstr_len*(haystack: cstring; haystackLen: int64; needle: cstring): cstring {.
    importc: "g_strstr_len", libprag.}

proc strstrLen*(haystack: string; haystackLen: int64; needle: string): string =
  let resul0 = g_strstr_len(cstring(haystack), haystackLen, cstring(needle))
  result = $resul0
  cogfree(resul0)

proc g_strtod*(nptr: cstring; endptr: var cstring): cdouble {.
    importc: "g_strtod", libprag.}

proc strtod*(nptr: cstring; endptr: var cstring): cdouble {.
    importc: "g_strtod", libprag.}

proc g_strup*(string: cstring): cstring {.
    importc: "g_strup", libprag.}

proc strup*(string: string): string =
  let resul0 = g_strup(cstring(string))
  result = $resul0
  cogfree(resul0)

proc g_strv_contains*(strv: cstring; str: cstring): gboolean {.
    importc: "g_strv_contains", libprag.}

proc strvContains*(strv: cstring; str: cstring): gboolean {.
    importc: "g_strv_contains", libprag.}

proc g_strv_get_type*(): GType {.
    importc: "g_strv_get_type", libprag.}

proc strvGetType*(): GType {.
    importc: "g_strv_get_type", libprag.}

proc g_strv_length*(strArray: cstring): uint32 {.
    importc: "g_strv_length", libprag.}

proc strvLength*(strArray: cstring): uint32 {.
    importc: "g_strv_length", libprag.}

proc g_test_add_data_func*(testpath: cstring; testData: pointer; testFunc: TestDataFunc) {.
    importc: "g_test_add_data_func", libprag.}

proc testAddDataFunc*(testpath: cstring; testData: pointer; testFunc: TestDataFunc) {.
    importc: "g_test_add_data_func", libprag.}

proc g_test_add_data_func_full*(testpath: cstring; testData: pointer; testFunc: TestDataFunc; 
    dataFreeFunc: DestroyNotify) {.
    importc: "g_test_add_data_func_full", libprag.}

proc testAddDataFuncFull*(testpath: cstring; testData: pointer; testFunc: TestDataFunc; 
    dataFreeFunc: DestroyNotify) {.
    importc: "g_test_add_data_func_full", libprag.}

proc g_test_add_func*(testpath: cstring; testFunc: TestFunc) {.
    importc: "g_test_add_func", libprag.}

proc testAddFunc*(testpath: cstring; testFunc: TestFunc) {.
    importc: "g_test_add_func", libprag.}

proc g_test_assert_expected_messages_internal*(domain: cstring; file: cstring; line: int32; `func`: cstring) {.
    importc: "g_test_assert_expected_messages_internal", libprag.}

proc testAssertExpectedMessagesInternal*(domain: cstring; file: cstring; line: int32; `func`: cstring) {.
    importc: "g_test_assert_expected_messages_internal", libprag.}

proc g_test_bug*(bugUriSnippet: cstring) {.
    importc: "g_test_bug", libprag.}

proc testBug*(bugUriSnippet: cstring) {.
    importc: "g_test_bug", libprag.}

proc g_test_bug_base*(uriPattern: cstring) {.
    importc: "g_test_bug_base", libprag.}

proc testBugBase*(uriPattern: cstring) {.
    importc: "g_test_bug_base", libprag.}

proc g_test_expect_message*(logDomain: cstring; logLevel: LogLevelFlags; pattern: cstring) {.
    importc: "g_test_expect_message", libprag.}

proc testExpectMessage*(logDomain: cstring; logLevel: LogLevelFlags; pattern: cstring) {.
    importc: "g_test_expect_message", libprag.}

proc g_test_fail*() {.
    importc: "g_test_fail", libprag.}

proc testFail*() {.
    importc: "g_test_fail", libprag.}

proc g_test_failed*(): gboolean {.
    importc: "g_test_failed", libprag.}

proc testFailed*(): gboolean {.
    importc: "g_test_failed", libprag.}

proc g_test_get_dir*(fileType: TestFileType): ucstring {.
    importc: "g_test_get_dir", libprag.}

proc testGetDir*(fileType: TestFileType): ucstring {.
    importc: "g_test_get_dir", libprag.}

proc g_test_incomplete*(msg: cstring) {.
    importc: "g_test_incomplete", libprag.}

proc testIncomplete*(msg: cstring) {.
    importc: "g_test_incomplete", libprag.}

proc g_test_log_type_name*(logType: TestLogType): cstring {.
    importc: "g_test_log_type_name", libprag.}

proc testLogTypeName*(logType: TestLogType): string =
  let resul0 = g_test_log_type_name(logType)
  result = $resul0

proc g_test_queue_destroy*(destroyFunc: DestroyNotify; destroyData: pointer) {.
    importc: "g_test_queue_destroy", libprag.}

proc testQueueDestroy*(destroyFunc: DestroyNotify; destroyData: pointer) {.
    importc: "g_test_queue_destroy", libprag.}

proc g_test_queue_free*(gfreePointer: pointer) {.
    importc: "g_test_queue_free", libprag.}

proc testQueueFree*(gfreePointer: pointer) {.
    importc: "g_test_queue_free", libprag.}

proc g_test_rand_double*(): cdouble {.
    importc: "g_test_rand_double", libprag.}

proc testRandDouble*(): cdouble {.
    importc: "g_test_rand_double", libprag.}

proc g_test_rand_double_range*(rangeStart: cdouble; rangeEnd: cdouble): cdouble {.
    importc: "g_test_rand_double_range", libprag.}

proc testRandDoubleRange*(rangeStart: cdouble; rangeEnd: cdouble): cdouble {.
    importc: "g_test_rand_double_range", libprag.}

proc g_test_rand_int*(): int32 {.
    importc: "g_test_rand_int", libprag.}

proc testRandInt*(): int32 {.
    importc: "g_test_rand_int", libprag.}

proc g_test_rand_int_range*(begin: int32; `end`: int32): int32 {.
    importc: "g_test_rand_int_range", libprag.}

proc testRandIntRange*(begin: int32; `end`: int32): int32 {.
    importc: "g_test_rand_int_range", libprag.}

proc g_test_run*(): int32 {.
    importc: "g_test_run", libprag.}

proc testRun*(): int32 {.
    importc: "g_test_run", libprag.}

proc g_test_run_suite*(suite: ptr TestSuite00): int32 {.
    importc: "g_test_run_suite", libprag.}

proc testRunSuite*(suite: TestSuite): int =
  int(g_test_run_suite(cast[ptr TestSuite00](suite.impl)))

proc g_test_set_nonfatal_assertions*() {.
    importc: "g_test_set_nonfatal_assertions", libprag.}

proc testSetNonfatalAssertions*() {.
    importc: "g_test_set_nonfatal_assertions", libprag.}

proc g_test_skip*(msg: cstring) {.
    importc: "g_test_skip", libprag.}

proc testSkip*(msg: cstring) {.
    importc: "g_test_skip", libprag.}

proc g_test_subprocess*(): gboolean {.
    importc: "g_test_subprocess", libprag.}

proc testSubprocess*(): gboolean {.
    importc: "g_test_subprocess", libprag.}

proc g_test_timer_elapsed*(): cdouble {.
    importc: "g_test_timer_elapsed", libprag.}

proc testTimerElapsed*(): cdouble {.
    importc: "g_test_timer_elapsed", libprag.}

proc g_test_timer_last*(): cdouble {.
    importc: "g_test_timer_last", libprag.}

proc testTimerLast*(): cdouble {.
    importc: "g_test_timer_last", libprag.}

proc g_test_timer_start*() {.
    importc: "g_test_timer_start", libprag.}

proc testTimerStart*() {.
    importc: "g_test_timer_start", libprag.}

proc g_test_trap_assertions*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    assertionFlags: uint64; pattern: cstring) {.
    importc: "g_test_trap_assertions", libprag.}

proc testTrapAssertions*(domain: cstring; file: cstring; line: int32; `func`: cstring; 
    assertionFlags: uint64; pattern: cstring) {.
    importc: "g_test_trap_assertions", libprag.}

proc g_test_trap_fork*(usecTimeout: uint64; testTrapFlags: TestTrapFlags): gboolean {.
    importc: "g_test_trap_fork", libprag.}

proc testTrapFork*(usecTimeout: uint64; testTrapFlags: TestTrapFlags): gboolean {.
    importc: "g_test_trap_fork", libprag.}

proc g_test_trap_has_passed*(): gboolean {.
    importc: "g_test_trap_has_passed", libprag.}

proc testTrapHasPassed*(): gboolean {.
    importc: "g_test_trap_has_passed", libprag.}

proc g_test_trap_reached_timeout*(): gboolean {.
    importc: "g_test_trap_reached_timeout", libprag.}

proc testTrapReachedTimeout*(): gboolean {.
    importc: "g_test_trap_reached_timeout", libprag.}

proc g_test_trap_subprocess*(testPath: cstring; usecTimeout: uint64; testFlags: TestSubprocessFlags) {.
    importc: "g_test_trap_subprocess", libprag.}

proc testTrapSubprocess*(testPath: cstring; usecTimeout: uint64; testFlags: TestSubprocessFlags) {.
    importc: "g_test_trap_subprocess", libprag.}

proc g_timeout_add_full*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_timeout_add_full", libprag.}

proc timeoutAdd*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_timeout_add_full", libprag.}

proc g_timeout_add_seconds_full*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_timeout_add_seconds_full", libprag.}

proc timeoutAddSeconds*(priority: int32; interval: uint32; function: SourceFunc; 
    data: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_timeout_add_seconds_full", libprag.}

proc g_timeout_source_new*(interval: uint32): ptr Source00 {.
    importc: "g_timeout_source_new", libprag.}

proc timeoutSourceNew*(interval: int): Source =
  new(result)
  result.impl = g_timeout_source_new(uint32(interval))

proc g_timeout_source_new_seconds*(interval: uint32): ptr Source00 {.
    importc: "g_timeout_source_new_seconds", libprag.}

proc timeoutSourceNewSeconds*(interval: int): Source =
  new(result)
  result.impl = g_timeout_source_new_seconds(uint32(interval))

proc g_try_malloc*(nBytes: uint64): pointer {.
    importc: "g_try_malloc", libprag.}

proc tryMalloc*(nBytes: uint64): pointer {.
    importc: "g_try_malloc", libprag.}

proc g_try_malloc0*(nBytes: uint64): pointer {.
    importc: "g_try_malloc0", libprag.}

proc tryMalloc0*(nBytes: uint64): pointer {.
    importc: "g_try_malloc0", libprag.}

proc g_try_malloc0_n*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc0_n", libprag.}

proc tryMalloc0N*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc0_n", libprag.}

proc g_try_malloc_n*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc_n", libprag.}

proc tryMallocN*(nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_malloc_n", libprag.}

proc g_try_realloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_try_realloc", libprag.}

proc tryRealloc*(mem: pointer; nBytes: uint64): pointer {.
    importc: "g_try_realloc", libprag.}

proc g_try_realloc_n*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_realloc_n", libprag.}

proc tryReallocN*(mem: pointer; nBlocks: uint64; nBlockBytes: uint64): pointer {.
    importc: "g_try_realloc_n", libprag.}

proc g_ucs4_to_utf16*(str: ptr gunichar; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): ptr uint16 {.
    importc: "g_ucs4_to_utf16", libprag.}

proc ucs4ToUtf16*(str: ptr gunichar; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): ptr uint16 {.
    importc: "g_ucs4_to_utf16", libprag.}

proc g_ucs4_to_utf8*(str: ptr gunichar; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): cstring {.
    importc: "g_ucs4_to_utf8", libprag.}

proc ucs4ToUtf8*(str: ptr gunichar; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): string =
  let resul0 = g_ucs4_to_utf8(str, len, itemsRead, itemsWritten)
  result = $resul0
  cogfree(resul0)

proc g_unichar_break_type*(c: gunichar): UnicodeBreakType {.
    importc: "g_unichar_break_type", libprag.}

proc unicharBreakType*(c: gunichar): UnicodeBreakType {.
    importc: "g_unichar_break_type", libprag.}

proc g_unichar_combining_class*(uc: gunichar): int32 {.
    importc: "g_unichar_combining_class", libprag.}

proc unicharCombiningClass*(uc: gunichar): int32 {.
    importc: "g_unichar_combining_class", libprag.}

proc g_unichar_compose*(a: gunichar; b: gunichar; ch: ptr gunichar): gboolean {.
    importc: "g_unichar_compose", libprag.}

proc unicharCompose*(a: gunichar; b: gunichar; ch: ptr gunichar): gboolean {.
    importc: "g_unichar_compose", libprag.}

proc g_unichar_decompose*(ch: gunichar; a: ptr gunichar; b: ptr gunichar): gboolean {.
    importc: "g_unichar_decompose", libprag.}

proc unicharDecompose*(ch: gunichar; a: ptr gunichar; b: ptr gunichar): gboolean {.
    importc: "g_unichar_decompose", libprag.}

proc g_unichar_digit_value*(c: gunichar): int32 {.
    importc: "g_unichar_digit_value", libprag.}

proc unicharDigitValue*(c: gunichar): int32 {.
    importc: "g_unichar_digit_value", libprag.}

proc g_unichar_fully_decompose*(ch: gunichar; compat: gboolean; resu: ptr gunichar; 
    resultLen: uint64): uint64 {.
    importc: "g_unichar_fully_decompose", libprag.}

proc unicharFullyDecompose*(ch: gunichar; compat: gboolean; resu: ptr gunichar; 
    resultLen: uint64): uint64 {.
    importc: "g_unichar_fully_decompose", libprag.}

proc g_unichar_get_mirror_char*(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc: "g_unichar_get_mirror_char", libprag.}

proc unicharGetMirrorChar*(ch: gunichar; mirroredCh: ptr gunichar): gboolean {.
    importc: "g_unichar_get_mirror_char", libprag.}

proc g_unichar_get_script*(ch: gunichar): UnicodeScript {.
    importc: "g_unichar_get_script", libprag.}

proc unicharGetScript*(ch: gunichar): UnicodeScript {.
    importc: "g_unichar_get_script", libprag.}

proc g_unichar_isalnum*(c: gunichar): gboolean {.
    importc: "g_unichar_isalnum", libprag.}

proc unicharIsalnum*(c: gunichar): gboolean {.
    importc: "g_unichar_isalnum", libprag.}

proc g_unichar_isalpha*(c: gunichar): gboolean {.
    importc: "g_unichar_isalpha", libprag.}

proc unicharIsalpha*(c: gunichar): gboolean {.
    importc: "g_unichar_isalpha", libprag.}

proc g_unichar_iscntrl*(c: gunichar): gboolean {.
    importc: "g_unichar_iscntrl", libprag.}

proc unicharIscntrl*(c: gunichar): gboolean {.
    importc: "g_unichar_iscntrl", libprag.}

proc g_unichar_isdefined*(c: gunichar): gboolean {.
    importc: "g_unichar_isdefined", libprag.}

proc unicharIsdefined*(c: gunichar): gboolean {.
    importc: "g_unichar_isdefined", libprag.}

proc g_unichar_isdigit*(c: gunichar): gboolean {.
    importc: "g_unichar_isdigit", libprag.}

proc unicharIsdigit*(c: gunichar): gboolean {.
    importc: "g_unichar_isdigit", libprag.}

proc g_unichar_isgraph*(c: gunichar): gboolean {.
    importc: "g_unichar_isgraph", libprag.}

proc unicharIsgraph*(c: gunichar): gboolean {.
    importc: "g_unichar_isgraph", libprag.}

proc g_unichar_islower*(c: gunichar): gboolean {.
    importc: "g_unichar_islower", libprag.}

proc unicharIslower*(c: gunichar): gboolean {.
    importc: "g_unichar_islower", libprag.}

proc g_unichar_ismark*(c: gunichar): gboolean {.
    importc: "g_unichar_ismark", libprag.}

proc unicharIsmark*(c: gunichar): gboolean {.
    importc: "g_unichar_ismark", libprag.}

proc g_unichar_isprint*(c: gunichar): gboolean {.
    importc: "g_unichar_isprint", libprag.}

proc unicharIsprint*(c: gunichar): gboolean {.
    importc: "g_unichar_isprint", libprag.}

proc g_unichar_ispunct*(c: gunichar): gboolean {.
    importc: "g_unichar_ispunct", libprag.}

proc unicharIspunct*(c: gunichar): gboolean {.
    importc: "g_unichar_ispunct", libprag.}

proc g_unichar_isspace*(c: gunichar): gboolean {.
    importc: "g_unichar_isspace", libprag.}

proc unicharIsspace*(c: gunichar): gboolean {.
    importc: "g_unichar_isspace", libprag.}

proc g_unichar_istitle*(c: gunichar): gboolean {.
    importc: "g_unichar_istitle", libprag.}

proc unicharIstitle*(c: gunichar): gboolean {.
    importc: "g_unichar_istitle", libprag.}

proc g_unichar_isupper*(c: gunichar): gboolean {.
    importc: "g_unichar_isupper", libprag.}

proc unicharIsupper*(c: gunichar): gboolean {.
    importc: "g_unichar_isupper", libprag.}

proc g_unichar_iswide*(c: gunichar): gboolean {.
    importc: "g_unichar_iswide", libprag.}

proc unicharIswide*(c: gunichar): gboolean {.
    importc: "g_unichar_iswide", libprag.}

proc g_unichar_iswide_cjk*(c: gunichar): gboolean {.
    importc: "g_unichar_iswide_cjk", libprag.}

proc unicharIswideCjk*(c: gunichar): gboolean {.
    importc: "g_unichar_iswide_cjk", libprag.}

proc g_unichar_isxdigit*(c: gunichar): gboolean {.
    importc: "g_unichar_isxdigit", libprag.}

proc unicharIsxdigit*(c: gunichar): gboolean {.
    importc: "g_unichar_isxdigit", libprag.}

proc g_unichar_iszerowidth*(c: gunichar): gboolean {.
    importc: "g_unichar_iszerowidth", libprag.}

proc unicharIszerowidth*(c: gunichar): gboolean {.
    importc: "g_unichar_iszerowidth", libprag.}

proc g_unichar_to_utf8*(c: gunichar; outbuf: var cstring): int32 {.
    importc: "g_unichar_to_utf8", libprag.}

proc unicharToUtf8*(c: gunichar; outbuf: var cstring): int32 {.
    importc: "g_unichar_to_utf8", libprag.}

proc g_unichar_tolower*(c: gunichar): gunichar {.
    importc: "g_unichar_tolower", libprag.}

proc unicharTolower*(c: gunichar): gunichar {.
    importc: "g_unichar_tolower", libprag.}

proc g_unichar_totitle*(c: gunichar): gunichar {.
    importc: "g_unichar_totitle", libprag.}

proc unicharTotitle*(c: gunichar): gunichar {.
    importc: "g_unichar_totitle", libprag.}

proc g_unichar_toupper*(c: gunichar): gunichar {.
    importc: "g_unichar_toupper", libprag.}

proc unicharToupper*(c: gunichar): gunichar {.
    importc: "g_unichar_toupper", libprag.}

proc g_unichar_type*(c: gunichar): UnicodeType {.
    importc: "g_unichar_type", libprag.}

proc unicharType*(c: gunichar): UnicodeType {.
    importc: "g_unichar_type", libprag.}

proc g_unichar_validate*(ch: gunichar): gboolean {.
    importc: "g_unichar_validate", libprag.}

proc unicharValidate*(ch: gunichar): gboolean {.
    importc: "g_unichar_validate", libprag.}

proc g_unichar_xdigit_value*(c: gunichar): int32 {.
    importc: "g_unichar_xdigit_value", libprag.}

proc unicharXdigitValue*(c: gunichar): int32 {.
    importc: "g_unichar_xdigit_value", libprag.}

proc g_unicode_canonical_decomposition*(ch: gunichar; resultLen: ptr uint64): ptr gunichar {.
    importc: "g_unicode_canonical_decomposition", libprag.}

proc unicodeCanonicalDecomposition*(ch: gunichar; resultLen: ptr uint64): ptr gunichar {.
    importc: "g_unicode_canonical_decomposition", libprag.}

proc g_unicode_canonical_ordering*(string: ptr gunichar; len: uint64) {.
    importc: "g_unicode_canonical_ordering", libprag.}

proc unicodeCanonicalOrdering*(string: ptr gunichar; len: uint64) {.
    importc: "g_unicode_canonical_ordering", libprag.}

proc g_unicode_script_from_iso15924*(iso15924: uint32): UnicodeScript {.
    importc: "g_unicode_script_from_iso15924", libprag.}

proc unicodeScriptFromIso15924*(iso15924: uint32): UnicodeScript {.
    importc: "g_unicode_script_from_iso15924", libprag.}

proc g_unicode_script_to_iso15924*(script: UnicodeScript): uint32 {.
    importc: "g_unicode_script_to_iso15924", libprag.}

proc unicodeScriptToIso15924*(script: UnicodeScript): uint32 {.
    importc: "g_unicode_script_to_iso15924", libprag.}

proc g_unix_error_quark*(): uint32 {.
    importc: "g_unix_error_quark", libprag.}

proc unixErrorQuark*(): uint32 {.
    importc: "g_unix_error_quark", libprag.}

proc g_unix_fd_add_full*(priority: int32; fd: int32; condition: IOCondition; 
    function: UnixFDSourceFunc; userData: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_unix_fd_add_full", libprag.}

proc unixFdAddFull*(priority: int32; fd: int32; condition: IOCondition; 
    function: UnixFDSourceFunc; userData: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_unix_fd_add_full", libprag.}

proc g_unix_fd_source_new*(fd: int32; condition: IOCondition): ptr Source00 {.
    importc: "g_unix_fd_source_new", libprag.}

proc unixFdSourceNew*(fd: int; condition: IOCondition): Source =
  new(result)
  result.impl = g_unix_fd_source_new(int32(fd), condition)

proc g_unix_open_pipe*(fds: ptr int32; flags: int32): gboolean {.
    importc: "g_unix_open_pipe", libprag.}

proc unixOpenPipe*(fds: ptr int32; flags: int32): gboolean {.
    importc: "g_unix_open_pipe", libprag.}

proc g_unix_set_fd_nonblocking*(fd: int32; nonblock: gboolean): gboolean {.
    importc: "g_unix_set_fd_nonblocking", libprag.}

proc unixSetFdNonblocking*(fd: int32; nonblock: gboolean): gboolean {.
    importc: "g_unix_set_fd_nonblocking", libprag.}

proc g_unix_signal_add_full*(priority: int32; signum: int32; handler: SourceFunc; 
    userData: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_unix_signal_add_full", libprag.}

proc unixSignalAdd*(priority: int32; signum: int32; handler: SourceFunc; 
    userData: pointer; notify: DestroyNotify): uint32 {.
    importc: "g_unix_signal_add_full", libprag.}

proc g_unix_signal_source_new*(signum: int32): ptr Source00 {.
    importc: "g_unix_signal_source_new", libprag.}

proc unixSignalSourceNew*(signum: int): Source =
  new(result)
  result.impl = g_unix_signal_source_new(int32(signum))

proc g_unlink*(filename: ucstring): int32 {.
    importc: "g_unlink", libprag.}

proc unlink*(filename: ucstring): int32 {.
    importc: "g_unlink", libprag.}

proc g_unsetenv*(variable: cstring) {.
    importc: "g_unsetenv", libprag.}

proc unsetenv*(variable: cstring) {.
    importc: "g_unsetenv", libprag.}

proc g_uri_escape_string*(unescaped: cstring; reservedCharsAllowed: cstring; 
    allowUtf8: gboolean): cstring {.
    importc: "g_uri_escape_string", libprag.}

proc uriEscapeString*(unescaped: string; reservedCharsAllowed: string; allowUtf8: bool): string =
  let resul0 = g_uri_escape_string(cstring(unescaped), cstring(reservedCharsAllowed), gboolean(allowUtf8))
  result = $resul0
  cogfree(resul0)

proc g_uri_list_extract_uris*(uriList: cstring): cstringArray {.
    importc: "g_uri_list_extract_uris", libprag.}

proc uriListExtractUris*(uriList: cstring): cstringArray {.
    importc: "g_uri_list_extract_uris", libprag.}

proc g_uri_parse_scheme*(uri: cstring): cstring {.
    importc: "g_uri_parse_scheme", libprag.}

proc uriParseScheme*(uri: string): string =
  let resul0 = g_uri_parse_scheme(cstring(uri))
  result = $resul0
  cogfree(resul0)

proc g_uri_unescape_segment*(escapedString: cstring; escapedStringEnd: cstring; 
    illegalCharacters: cstring): cstring {.
    importc: "g_uri_unescape_segment", libprag.}

proc uriUnescapeSegment*(escapedString: string; escapedStringEnd: string; illegalCharacters: string): string =
  let resul0 = g_uri_unescape_segment(cstring(escapedString), cstring(escapedStringEnd), cstring(illegalCharacters))
  result = $resul0
  cogfree(resul0)

proc g_uri_unescape_string*(escapedString: cstring; illegalCharacters: cstring): cstring {.
    importc: "g_uri_unescape_string", libprag.}

proc uriUnescapeString*(escapedString: string; illegalCharacters: string): string =
  let resul0 = g_uri_unescape_string(cstring(escapedString), cstring(illegalCharacters))
  result = $resul0
  cogfree(resul0)

proc g_usleep*(microseconds: uint64) {.
    importc: "g_usleep", libprag.}

proc usleep*(microseconds: uint64) {.
    importc: "g_usleep", libprag.}

proc g_utf16_to_ucs4*(str: ptr uint16; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf16_to_ucs4", libprag.}

proc utf16ToUcs4*(str: ptr uint16; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf16_to_ucs4", libprag.}

proc g_utf16_to_utf8*(str: ptr uint16; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): cstring {.
    importc: "g_utf16_to_utf8", libprag.}

proc utf16ToUtf8*(str: ptr uint16; len: int64; itemsRead: var int64; 
    itemsWritten: var int64): string =
  let resul0 = g_utf16_to_utf8(str, len, itemsRead, itemsWritten)
  result = $resul0
  cogfree(resul0)

proc g_utf8_casefold*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_casefold", libprag.}

proc utf8Casefold*(str: string; len: int64): string =
  let resul0 = g_utf8_casefold(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_collate*(str1: cstring; str2: cstring): int32 {.
    importc: "g_utf8_collate", libprag.}

proc utf8Collate*(str1: cstring; str2: cstring): int32 {.
    importc: "g_utf8_collate", libprag.}

proc g_utf8_collate_key*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_collate_key", libprag.}

proc utf8CollateKey*(str: string; len: int64): string =
  let resul0 = g_utf8_collate_key(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_collate_key_for_filename*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_collate_key_for_filename", libprag.}

proc utf8CollateKeyForFilename*(str: string; len: int64): string =
  let resul0 = g_utf8_collate_key_for_filename(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_find_next_char*(p: cstring; `end`: cstring): cstring {.
    importc: "g_utf8_find_next_char", libprag.}

proc utf8FindNextChar*(p: string; `end`: string): string =
  let resul0 = g_utf8_find_next_char(cstring(p), cstring(`end`))
  result = $resul0
  cogfree(resul0)

proc g_utf8_find_prev_char*(str: cstring; p: cstring): cstring {.
    importc: "g_utf8_find_prev_char", libprag.}

proc utf8FindPrevChar*(str: string; p: string): string =
  let resul0 = g_utf8_find_prev_char(cstring(str), cstring(p))
  result = $resul0
  cogfree(resul0)

proc g_utf8_get_char*(p: cstring): gunichar {.
    importc: "g_utf8_get_char", libprag.}

proc utf8GetChar*(p: cstring): gunichar {.
    importc: "g_utf8_get_char", libprag.}

proc g_utf8_get_char_validated*(p: cstring; maxLen: int64): gunichar {.
    importc: "g_utf8_get_char_validated", libprag.}

proc utf8GetCharValidated*(p: cstring; maxLen: int64): gunichar {.
    importc: "g_utf8_get_char_validated", libprag.}

proc g_utf8_normalize*(str: cstring; len: int64; mode: NormalizeMode): cstring {.
    importc: "g_utf8_normalize", libprag.}

proc utf8Normalize*(str: string; len: int64; mode: NormalizeMode): string =
  let resul0 = g_utf8_normalize(cstring(str), len, mode)
  result = $resul0
  cogfree(resul0)

proc g_utf8_offset_to_pointer*(str: cstring; offset: int64): cstring {.
    importc: "g_utf8_offset_to_pointer", libprag.}

proc utf8OffsetToPointer*(str: string; offset: int64): string =
  let resul0 = g_utf8_offset_to_pointer(cstring(str), offset)
  result = $resul0
  cogfree(resul0)

proc g_utf8_pointer_to_offset*(str: cstring; pos: cstring): int64 {.
    importc: "g_utf8_pointer_to_offset", libprag.}

proc utf8PointerToOffset*(str: cstring; pos: cstring): int64 {.
    importc: "g_utf8_pointer_to_offset", libprag.}

proc g_utf8_prev_char*(p: cstring): cstring {.
    importc: "g_utf8_prev_char", libprag.}

proc utf8PrevChar*(p: string): string =
  let resul0 = g_utf8_prev_char(cstring(p))
  result = $resul0
  cogfree(resul0)

proc g_utf8_strchr*(p: cstring; len: int64; c: gunichar): cstring {.
    importc: "g_utf8_strchr", libprag.}

proc utf8Strchr*(p: string; len: int64; c: gunichar): string =
  let resul0 = g_utf8_strchr(cstring(p), len, c)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strdown*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_strdown", libprag.}

proc utf8Strdown*(str: string; len: int64): string =
  let resul0 = g_utf8_strdown(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strlen*(p: cstring; max: int64): int64 {.
    importc: "g_utf8_strlen", libprag.}

proc utf8Strlen*(p: cstring; max: int64): int64 {.
    importc: "g_utf8_strlen", libprag.}

proc g_utf8_strncpy*(dest: cstring; src: cstring; n: uint64): cstring {.
    importc: "g_utf8_strncpy", libprag.}

proc utf8Strncpy*(dest: string; src: string; n: uint64): string =
  let resul0 = g_utf8_strncpy(cstring(dest), cstring(src), n)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strrchr*(p: cstring; len: int64; c: gunichar): cstring {.
    importc: "g_utf8_strrchr", libprag.}

proc utf8Strrchr*(p: string; len: int64; c: gunichar): string =
  let resul0 = g_utf8_strrchr(cstring(p), len, c)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strreverse*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_strreverse", libprag.}

proc utf8Strreverse*(str: string; len: int64): string =
  let resul0 = g_utf8_strreverse(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_strup*(str: cstring; len: int64): cstring {.
    importc: "g_utf8_strup", libprag.}

proc utf8Strup*(str: string; len: int64): string =
  let resul0 = g_utf8_strup(cstring(str), len)
  result = $resul0
  cogfree(resul0)

proc g_utf8_substring*(str: cstring; startPos: int64; endPos: int64): cstring {.
    importc: "g_utf8_substring", libprag.}

proc utf8Substring*(str: string; startPos: int64; endPos: int64): string =
  let resul0 = g_utf8_substring(cstring(str), startPos, endPos)
  result = $resul0
  cogfree(resul0)

proc g_utf8_to_ucs4*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf8_to_ucs4", libprag.}

proc utf8ToUcs4*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf8_to_ucs4", libprag.}

proc g_utf8_to_ucs4_fast*(str: cstring; len: int64; itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf8_to_ucs4_fast", libprag.}

proc utf8ToUcs4Fast*(str: cstring; len: int64; itemsWritten: var int64): ptr gunichar {.
    importc: "g_utf8_to_ucs4_fast", libprag.}

proc g_utf8_to_utf16*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64): ptr uint16 {.
    importc: "g_utf8_to_utf16", libprag.}

proc utf8ToUtf16*(str: cstring; len: int64; itemsRead: var int64; itemsWritten: var int64): ptr uint16 {.
    importc: "g_utf8_to_utf16", libprag.}

proc g_utf8_validate*(str: uint8Array; maxLen: int64; `end`: var cstring): gboolean {.
    importc: "g_utf8_validate", libprag.}

proc utf8Validate*(str: uint8Array; maxLen: int64; `end`: var cstring): gboolean {.
    importc: "g_utf8_validate", libprag.}

proc g_variant_get_gtype*(): GType {.
    importc: "g_variant_get_gtype", libprag.}

proc variantGetGtype*(): GType {.
    importc: "g_variant_get_gtype", libprag.}
# === remaining symbols:

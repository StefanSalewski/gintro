{.compile: "gobjectWrapper.c", 
  passc: gorge("pkg-config gobject-2.0 --cflags"),
  passl: gorge("pkg-config gobject-2.0 --libs")
  .}

import gintro/gobject
import std/[genasts, macros]

type
  InternalGObjectWrapper[T] {.importc: "GObjectWrapper", header: "gobjectWrapper.h".} = object of InitiallyUnowned00
    data: pointer

  GObjectWrapper*[T] = ref object of InitiallyUnowned

proc internalGObjectWrapperNew(data: pointer): pointer {.importc: "gobject_wrapper_new", header: "gobjectWrapper.h".}

macro gobjectWrapperNew*(data: typed): untyped =
  let dataType = getTypeInst(data)
  result = genAst(data, dataType):
    when `data` is (ref or ptr):
      let internal: pointer = internalGObjectWrapperNew(cast[pointer](`data`))
    else:
      let reffed: ref `dataType` = new(ref `dataType`)
      reffed[] = `data`
      GC_ref(reffed)
      let internal: pointer = internalGObjectWrapperNew(cast[pointer](reffed))
    let internalObject = cast[ptr InternalGObjectWrapper[`dataType`]](internal)
    GObjectWrapper[`dataType`](impl: internalObject, ignoreFinalizer: true)


proc gobjectWrapperGetData*[T](wrapper: GObjectWrapper[T]): var T =
  let internal = cast[ptr InternalGObjectWrapper[T]](wrapper.impl)
  when T is (ref or ptr):
    result = cast[T](internal.data)
  else:
    result = cast[ref T](internal.data)[]

var five = 5

let gobectWrapper = gobjectWrapperNew(five)
echo gobectWrapper.gobjectWrapperGetData()

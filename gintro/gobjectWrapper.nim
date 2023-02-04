{.compile: "gobjectWrapper.c", 
  passc: gorge("pkg-config gobject-2.0 --cflags"),
  passl: gorge("pkg-config gobject-2.0 --libs")
  .}

import std/macros

type
  InternalGObjectWrapper[T] {.importc: "GObjectWrapper", header: "gobjectWrapper.h".} = object
    data: pointer

  GObjectWrapper*[T] = ptr InternalGObjectWrapper[T]

proc internalGObjectWrapperNew(data: pointer): pointer {.importc: "gobject_wrapper_new", header: "gobjectWrapper.h".}

macro gobjectWrapperNew*(data: typed): untyped =
  let dataType = getTypeInst(data)
  result = quote do:
    when `data` is (ref or ptr):
      let internal: pointer = internalGObjectWrapperNew(cast[pointer](`data`))
    else:
      let reffed: ref `dataType` = new(ref `dataType`) # maybe we should create a ptr instead ref here?
      reffed[] = `data`
      GC_ref(reffed)
      let internal: pointer = internalGObjectWrapperNew(cast[pointer](reffed))
    cast[GObjectWrapper[`dataType`]](internal)

proc gobjectWrapperGetData*[T](wrapper: GObjectWrapper[T]): var T =
  when T is (ref or ptr):
    result = cast[T](wrapper.data)
  else:
    result = cast[ref T](wrapper.data)[]

var five = 5

let gobectWrapper = gobjectWrapperNew(five)
echo gobectWrapper.gobjectWrapperGetData()

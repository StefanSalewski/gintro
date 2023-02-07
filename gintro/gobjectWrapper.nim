{.compile: "gobjectWrapper.c", 
  passc: gorge("pkg-config gobject-2.0 --cflags"),
  passl: gorge("pkg-config gobject-2.0 --libs")
  .}

import gintro/gobject
import std/[genasts, macros]

type
  GObjectWrapper00 = object of Object00
  GObjectWrapper*[T] = ref object of Object

proc gobjectWrapper00New(data: pointer): pointer {.importc: "gobject_wrapper_new".}

# I could implement this with gobject properties instead, which might be nicer, but it also requires a lot more boilerplate code
proc gobjectWrapper00GetData(self: ptr GObjectWrapper00): pointer {.importc: "gobject_wrapper_get_data".}

macro gobjectWrapperNew*(data: typed): untyped =
  let dataType = getTypeInst(data)
  result = genAst(data, dataType):
    when `data` is (ref or ptr):
      let internal: pointer = gobjectWrapper00New(cast[pointer](`data`))
    else:
      let reffed: ref `dataType` = new(ref `dataType`)
      reffed[] = `data`
      GC_ref(reffed)
      let internal: pointer = gobjectWrapper00New(cast[pointer](reffed))
    let internalObject = cast[ptr GObjectWrapper00](internal)
    GObjectWrapper[`dataType`](impl: internalObject, ignoreFinalizer: true)

proc data*[T](wrapper: GObjectWrapper[T]): T =
  let internal = cast[ptr GObjectWrapper00](wrapper.impl)
  when T is (ref or ptr):
    result = cast[T](gobjectWrapper00GetData(internal))
  else:
    result = cast[ref T](gobjectWrapper00GetData(internal))[]

proc `data=`*[T](wrapper: var GObjectWrapper[T], data: T) =
  let internal = cast[ptr GObjectWrapper00](wrapper.impl)
  when T is (ref or ptr):
    let temp = cast[T](gobjectWrapper00GetData(internal))
  else:
    let temp = cast[ref T](gobjectWrapper00GetData(internal))
  temp[] = data
# https://github.com/StefanSalewski/gintro/issues/215#issuecomment-1408144934
macro newTreeListModel*(root: ListModel; passthrough, autoexpand: bool;
    createFunc: untyped): untyped =
  result = quote do:
    proc realCreateFunc(self: ptr gobject.Object00; ignore: pointer): ptr ListModel00 {.cdecl.} =
      let h: pointer = g_object_get_qdata(self, Quark)
      let returnedList = `createFunc`(cast[Object](h))
      returnedList.ignoreFinalizer = true
      result = cast[ptr ListModel00](returnedList.impl)
    newTreeListModel(`root`, `passthrough`, `autoexpand`, realCreateFunc, nil, nil)

macro newTreeListModel*(root: ListModel; passthrough, autoexpand: bool;
    createFunc: untyped; userData: typed): untyped =
  let userDataType = getTypeInst(userData)
  result = quote do:
    static: assert((`userData` isnot proc), "Directly passing procs as user data is not supported.")
    proc realCreateFunc(self: ptr gobject.Object00; userData: pointer): ptr ListModel00 {.cdecl.} =
      let h: pointer = g_object_get_qdata(self, Quark)
      when `userData` is (ref or ptr) or (sizeof(`userData`) <= sizeof(pointer)):# second test includes the first one
        let returnedList = `createFunc`(cast[Object](h), cast[`userDataType`](userData))
      else:
        let returnedList = `createFunc`(cast[Object](h), cast[ref `userDataType`](userData)[])
      returnedList.ignoreFinalizer = true # GTK will free it
      result = cast[ptr ListModel00](returnedList.impl)
    when `userData` is ref or ((sizeof(`userData`) <= sizeof(pointer)) and (`userData` isnot ptr)):
      when `userData` is ref:
        GC_ref(`userData`)
      newTreeListModel(`root`, `passthrough`, `autoexpand`, realCreateFunc, cast[pointer](`userData`), nil)
    else: # for value types or unsafe pointers, make a copy
      when `userData` is ptr:
        let reffed: `userDataType` = cast[`userDataType`](alloc(sizeof(`userDataType`)))
        reffed[] = `userData`[]
      else:
        let reffed: ref `userDataType` = new(ref `userDataType`) # maybe we should create a ptr instead ref here?
        reffed[] = `userData`
        GC_ref(reffed)
      newTreeListModel(`root`, `passthrough`, `autoexpand`, realCreateFunc, cast[pointer](reffed), nil)

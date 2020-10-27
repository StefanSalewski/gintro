### CellDataFunc,
# see https://developer.gnome.org/gtk3/stable/GtkTreeViewColumn.html#gtk-tree-view-column-set-cell-data-func

# the low level GTK interface:
# proc cellDataFunc(column00: ptr TreeViewColumn00; renderer00: ptr CellRenderer00;
#   model00: ptr TreeModel00; iter: TreeIter; data: pointer) {.cdecl.}

# unset -- the macro can do this already
proc unsetCellDataFunc*(column: TreeViewColumn; renderer: CellRenderer) =
  setCellDataFunc(column, renderer, nil, nil, nil)

# set a function with this parameter list and one more optional argument
# proc cellDataFunc(column: TreeViewColumn; renderer: CellRenderer; model: TreeModel; iter: TreeIter)
# if there is no optional arg, then we make it a pointer with nil value.
# if arg is a ref, then we apply GC_ref() and pass it
# if arg is a ptr, then we pass it. (but we never free that object)
# if arg is a value type, then we replace it with a copy of a ref type to guaranty lifetime
macro setCellDataFunc*(column: TreeViewColumn; renderer: CellRenderer; fn: untyped = nil; arg: typed = nil): untyped =

  if fn == nil: # unset
    result = parseStmt("setCellDataFunc($1, $2, nil, nil, nil)" % [$column, $renderer])
    return

  var CdfID {.compileTime, global.}: int # unique id for our generated cell data functions
  inc(CdfID)
  var ats: string # the type of optional argument as string (arg type string)
  var argStr: string # the value of optional argument as string
  var atsfix: string # we have to prefix with "ref " if arg is avalue type 
  if arg == nil: # no optional argument, so fake a nil pointer
    argStr = "nil"
    ats = "pointer"
  else:
    argStr = $(arg.toStrLit)
    ats = $getTypeInst(arg).toStrLit

    if getTypeInst(arg).typeKind != ntyRef and getTypeInst(arg).typeKind != ntyPtr:
      atsFix = "ref "

  let procName = "celldatafunc_" & $CdfID # our init code
  let procNameCdecl = "celldatafunc_cdecl_" & $CdfID # the proc that is called from GTK
  var procNameDestroy: string # the proc that GTK calls when we unset the cellDataFunc
  # first we generate the destroy proc
  var r0s: string

  # GTK should unref the optional argument later, so we generate a destroy proc which GTK can call
  if arg != nil and getTypeInst(arg).typeKind != ntyPtr:
    procNameDestroy = "celldatafunc_destroy" & $CdfID
    r0s ="""
proc $1(p: pointer) {.cdecl.} =
  # echo "GC_Unref(arg)"
  GC_Unref(cast[$2](p))
""" % [$procNameDestroy, atsFix & ats]
  else:
    procNameDestroy = "nil"
    r0s = ""

# now we generate the proc which GTK will call for each cell of the treeview. g_object_get_qdata() is
# the GTK function which retrieves the Nim proxy objects from the plain GTK data objects.
  var r1s = """
proc $1(column00: ptr TreeViewColumn00; renderer00: ptr CellRenderer00;
                  model00: ptr TreeModel00; iter: TreeIter; pdata: pointer) {.cdecl.} =
  let column = cast[TreeViewColumn](g_object_get_qdata(column00, Quark))
  let renderer = cast[CellRenderer](g_object_get_qdata(renderer00, Quark))
  let model = cast[TreeModel](g_object_get_qdata(model00, Quark))
""" % [$procNameCdecl]
  if arg == nil:
    r1s.add """
  $1(column, renderer, model, iter) # call the user provided Nim proc
""" % [$fn]
  elif getTypeInst(arg).typeKind == ntyRef or getTypeInst(arg).typeKind == ntyPtr:
    r1s.add """
  let a = cast[$2](pdata)
  $1(column, renderer, model, iter, a) # call the user provided Nim proc
""" % [$fn, ats]
  else: # arg was a value type, but we pass a copy of ref type
    r1s.add """
  let a = cast[ref $2](pdata)[]
  $1(column, renderer, model, iter, a) # call the user provided Nim proc
""" % [$fn, ats]

# this is basically only a code block which is called for initialization, mostly
# making a deep copy of optional argument when argumant is not a ref
  var r2s: string
  if arg == nil:
    r2s ="""
proc $1(column: TreeViewColumn; renderer: CellRenderer; pdata: $2) =
    setCellDataFunc($3, $4, $5, nil, nil)
$1(column, renderer, $6)
""" % [$procName, ats, $column, $renderer, $procNameCdecl, argStr, $procNameDestroy]
  elif getTypeInst(arg).typeKind == ntyPtr:
    r2s ="""
proc $1(column: TreeViewColumn; renderer: CellRenderer; pdata: $2) =
    setCellDataFunc($3, $4, $5, cast[pointer](pdata), $7)
$1(column, renderer, $6)
""" % [$procName, ats, $column, $renderer, $procNameCdecl, argStr, $procNameDestroy]
  elif getTypeInst(arg).typeKind == ntyRef:
    r2s ="""
proc $1(column: TreeViewColumn; renderer: CellRenderer; pdata: $2) =
    if not pdata.isNil: # or pdata is pointer):
      GC_ref(pdata)
    setCellDataFunc($3, $4, $5, cast[pointer](pdata), $7)
$1(column, renderer, $6)
""" % [$procName, ats, $column, $renderer, $procNameCdecl, argStr, $procNameDestroy]
  else: # arg is value object
    r2s ="""
proc $1(column: TreeViewColumn; renderer: CellRenderer; pdata: $2) =
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], pdata)
    ar[] = pdata
    GC_ref(ar)
    setCellDataFunc($3, $4, $5, cast[pointer](ar), $7)
$1(column, renderer, $6)
""" % [$procName, ats, $column, $renderer, $procNameCdecl, argStr, $procNameDestroy]

  result = parseStmt(r0s & r1s & r2s)
# 117 lines

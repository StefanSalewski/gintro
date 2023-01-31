#
import gintro/[gtk4, gobject, gio, glib]

# This is a way to replace ugly casts with safer conversion procs,
# see https://github.com/StefanSalewski/gintro/issues/215#issuecomment-1408891125
proc ListModel(el: StringList): gio.ListModel =
  assert(typeCheckInstanceIsA(el, g_type_from_name("GtkStringList"))) # not really necessary
  assert(typeCheckInstanceIsA(el, g_type_from_name("GListModel")))
  return cast[gio.ListModel](el)

proc ListItem(el: gobject.Object): ListItem =
  assert(typeCheckInstanceIsA(el, g_object_get_type())) # not really necessary
  assert(typeCheckInstanceIsA(el, g_type_from_name("GObject"))) # the same as above
  assert(typeCheckInstanceIsA(el, g_type_from_name("GtkListItem")))
  return cast[gtk4.ListItem](el)

proc createChildLists(item: gobject.Object, userData: seq[int]): ListModel =
  let list = newStringList("test1", "test2")
  assert(typeCheckInstanceIsA(list, g_type_from_name("GtkStringList"))) # possible checks
  assert(typeCheckInstanceIsA(list, g_type_from_name("GListModel")))
  for el in userData:
    list.append($el)
  #return cast[ListModel](list)
  return ListModel(list)

proc setup(self: SignalListItemFactory; obj: Object) =
  #let item = cast[ListItem](obj)
  let item = ListItem(obj)
  let expnr = newTreeExpander()
  let label = newLabel()
  expnr.setChild(label)
  item.setChild(expnr)

proc bnd(self: SignalListItemFactory; obj: Object) =
  let item = cast[ListItem](obj)
  let realItem = item.getItem
  let row = cast[TreeListRow](realItem)
  let expnr: TreeExpander = cast[TreeExpander](item.getChild)
  expnr.setListRow(row)
  let label = cast[Label](expnr.getChild)
  let stringObject = cast[StringObject](row.getItem)
  let str = stringObject.getString
  label.setLabel(str)

proc getTreeView: ListView =
  let list = newStringList("test1", "test2")
  let s = @[3, 5, 7] # value objects, and refs and ptrs should work as userData
  let treeList = newTreeListModel(cast[ListModel](list), false, false, createChildLists, s)
  let selectionModel = newSingleSelection(cast[ListModel](treeList))
  let factory = newSignalListItemFactory()
  factory.connect("setup", setup)
  factory.connect("bind", bnd)
  return newListView(selectionModel, factory)

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Window"
  window.defaultSize = (200, 200)
  window.setChild(getTreeView())
  window.present

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()

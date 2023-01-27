
import gintro/[gtk4, gobject, gio, glib]

proc createChildLists(item: gobject.Object, userData: (string, string)): ListModel =
  let list = newStringList("test1", "test2", userData[0], userData[1])
  list.ignoreFinalizer = true # because GTK frees it itself
  return cast[ListModel](list)

proc setup(self: SignalListItemFactory; obj: Object) =
  let item = cast[ListItem](obj)
  let expnr = newTreeExpander()
  let label = newLabel() # or ""
  expnr.setChild(label)
  item.setChild(expnr)

proc bnd(self: SignalListItemFactory; obj: Object) =
  let item = cast[ListItem](obj)
  let realItem = item.getItem
  let row = cast[TreeListRow](realItem)
  let expnr: TreeExpander =  cast[TreeExpander](item.getChild)
  expnr.setListRow(row)
  let label = cast[Label](expnr.getChild)
  let stringObject = cast[StringObject](row.getItem)
  let str = stringObject.getString
  label.setLabel(str)

proc getTreeView: ListView =
  let list = newStringList("test1", "test2")
  let s = ("hello", "hiiii")
  let treeList = newTreeListModel(cast[ListModel](list), false, false, createChildLists, s, nil)
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
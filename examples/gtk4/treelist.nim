
import ../../gintro/[gtk4, gobject, gio, glib]

# this is called from GTK, so all data types are the 00 onces.
proc createChildLists(item: gobject.Object): ListModel =
  let list = newStringList("test1", "test2")
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
  #proc newTreeListModel*(root: gio.ListModel; passthrough: bool; autoexpand: bool;
  #  createFunc: TreeListModelCreateModelFunc; userData: pointer; userDestroy: DestroyNotify): TreeListModel =
  let treeList = newTreeListModelt(cast[ListModel](list), false, false, createChildLists)
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
  window.present # gtk_widget_show(GTK_WIDGET(window));

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
# http://zetcode.com/gui/gtk2/gtktreeview/
# dynamiclistview.c

import gintro/[glib, gobject, gtk]
import gintro/gio except ListStore

const    
  LIST_ITEM = 0
  N_COLUMNS = 1

var list: TreeView

# this is copied from gtk.nim
#proc getModel*(self: TreeView): TreeModel =
#  new(result)
#  result.impl = gtk_tree_view_get_model(cast[ptr TreeView00](self.impl))

proc getListStore(self: TreeView): ListStore =
  new(result)
  result.impl = gtk_tree_view_get_model(cast[ptr TreeView00](self.impl))

proc appendItem(widget: Button; entry: Entry) =
  var
    val: Value
    iter: TreeIter
  let store = getListStore(list)
  let gtype = typeFromName("gchararray")
  discard gValueInit(val, gtype)
  gValueSetString(val, entry.text)
  store.append(iter)
  store.setValue(iter, LIST_ITEM, val)
  entry.text = ""

proc removeItem(widget: Button; selection: TreeSelection) =
  var    
    ls: ListStore
    iter: TreeIter
  let store = getListStore(list)
  if not store.getIterFirst(iter):
      return
  if getSelected(selection, ls, iter):
    discard store.remove(iter)

proc onRemoveAll(widget: Button; selection: TreeSelection) =
  var
    iter: TreeIter
  let store = getListStore(list)
  if not store.getIterFirst(iter):
    return
  clear(store)

proc initList(list: TreeView) =
  let renderer = newCellRendererText()
  let column = newTreeViewColumn()
  column.title = "List Item"
  column.packStart(renderer, true)
  column.addAttribute(renderer, "text", LIST_ITEM)
  discard list.appendColumn(column)
  let gtype = typeFromName("gchararray")
  let store = newListStore(N_COLUMNS, cast[pointer]( unsafeaddr gtype)) # cast due to bug in gtk.nim
  list.setModel(store)

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    sw = newScrolledWindow()
    hbox = newBox(Orientation.horizontal, 5)
    vbox = newBox(Orientation.vertical, 0)
    add = newButton("Add")
    remove = newButton("Remove")
    removeAll = newButton("Remove All")
    entry = newEntry()
  window. title = "List view"
  window.position = WindowPosition.center
  window.borderWidth = 10
  window.setSizeRequest(370, 270)
  list = newTreeView()  
  sw.add(list)
  sw.setPolicy(PolicyType.automatic, PolicyType.automatic)
  sw.setShadowType(ShadowType.etchedIn)
  list.setHeadersVisible(false)
  vbox.packStart(sw, true, true, 5)
  entry.setSizeRequest(120, -1)
  hbox.packStart(add, false, true, 3)
  hbox.packStart(entry, false, true, 3)
  hbox.packStart(remove, false, true, 3)
  hbox.packStart(removeAll, false, true, 3)
  vbox.packStart(hbox, false, true, 3)
  window.add(vbox)
  initList(list)
  let selection = getSelection(list)
  connect(add, "clicked", appendItem, entry)
  connect(remove, "clicked", removeItem, selection)
  connect(removeAll, "clicked", onRemoveAll, selection)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

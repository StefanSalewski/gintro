# This example shows how to apply a CellDataFunc to a GtkTreeView
# C example code was provided by A.Krause in chapter 8 of his book
import gintro/[gtk, gobject, glib]

const
  Color = 0
  Columns = 1
  clr = ["00", "33", "66", "99", "CC", "FF"]

proc bye(w: Window) =
  mainQuit()
  echo "Bye..."

proc toStringVal(s: string): Value =
  let gtype = gStringGetType() # typeFromName("gchararray")
  discard init(result, gtype)
  setString(result, s)

proc toBoolVal(b: bool): Value =
  let gtype = gBooleanGetType() # typeFromName("gboolean")
  discard init(result, gtype)
  setBoolean(result, b)

# our Nim function
proc cellDataFuncN(column: TreeViewColumn; renderer: CellRenderer;
                  model: TreeModel; iter: TreeIter, data: TreeViewColumn) =
  ##  Get the color string stored by the column and make it the foreground color.
  # for testing that optional args work, we pass a TreeViewColumn and echo its title
  echo data.title
  var val: Value
  model.getValue(iter, Color, val) 
  let text = val.getString
  val.unset # is this necessary?
  setProperty(renderer, "foreground", toStringVal("#FFFFFF"))
  setProperty(renderer, "foreground-set", toBoolVal(true))
  setProperty(renderer, "background", toStringVal(text))
  setProperty(renderer, "background-set", toBoolVal(true))
  setProperty(renderer, "text", toStringVal(text))

##  Add three columns to the GtkTreeView. All three of the columns will be
##  displayed as text, although one is a gboolean value and another is
##  an integer.
proc setupTreeView(treeview: TreeView) =
  let renderer = gtk.newCellRendererText()
  let column = newTreeViewColumn()
  column.title = "Standard Colors"
  column.packStart(renderer, expand = true)
  column.addAttribute(renderer, "text", Color)
  discard treeview.appendColumn(column)
  column.setCellDataFunc(renderer, cellDataFuncN, column)
  column.setCellDataFunc(renderer) # test unsetting!
  column.setCellDataFunc(renderer, nil)
  column.unsetCellDataFunc(renderer)
  column.setCellDataFunc(renderer, cellDataFuncN, column)

proc main =
  var iter: TreeIter
  gtk.init()
  let window = newWindow()
  window.setTitle("Color List")
  window.setBorderWidth(10)
  window.setSizeRequest(250, 175)
  window.connect("destroy", bye)
  let treeview = newTreeView()
  setupTreeView(treeview)
  let gtype = typeFromName("gchararray")
  let store = newListStore(Columns, cast[pointer](unsafeaddr gtype)) # ugly cast
  ##  Add all of the products to the GtkListStore.
  for i in 0 ..< 6:
    for j in 0 ..< 6:
      for k in 0 ..< 6:
        let color: string = "#" & clr[i] & clr[j] & clr[k]
        store.append(iter)
        store.setValue(iter, Color, toStringVal(color))
  treeView.setModel(store)
  let scrolledWin = newScrolledWindow(nil, nil)
  scrolledWin.setPolicy(PolicyType.automatic, PolicyType.automatic)
  scrolledWin.add(treeview)
  window.add(scrolledWin)
  window.showAll
  gtk.main()

main() 

##  https://discourse.gnome.org/t/gtk-treeview-cell-color-change/1750/4
##  C. Eric Cashon

# nim c css_colored_listview.nim
import gintro/[gtk, gdk, glib, gobject]
const # maybe we should use Nim's enum here?
  Id = 0
  Program = 1
  Color1 = 2
  Color2 = 3
  Columns = 4

proc bye(w: gtk.Window) =
  mainQuit()
  echo "Bye..."

proc toStringVal(s: string): Value =
  let gtype = typeFromName("gchararray")
  discard init(result, gtype)
  setString(result, s)

proc toUIntVal(i: int): Value =
  let gtype = typeFromName("guint")
  discard init(result, gtype)
  setUint(result, i)

proc toBoolVal(b: bool): Value =
  let gtype = typeFromName("gboolean")
  discard init(result, gtype)
  setBoolean(result, b)

# we need the following two procs for now -- later we will not use that ugly cast...
proc typeTest(o: gobject.Object; s: string): bool =
  let gt = g_type_from_name(s)
  return g_type_check_instance_is_a(cast[ptr TypeInstance00](o.impl), gt).toBool

proc listStore(o: gobject.Object): gtk.ListStore =
  assert(typeTest(o, "GtkListStore"))
  cast[gtk.ListStore](o)

proc updateRow(renderer: CellRendererText; path: cstring; newText: cstring; tree: TreeView) =
  var iter: TreeIter
  var value: Value
  let gtype = typeFromName("gchararray")
  discard init(value, gtype)
  let store = listStore(tree.getModel())   
  value.setString(newText)
  let treePath = newTreePathFromString(path)
  discard store.getIter(iter, treePath)
  store.setValue(iter, 1, value)

# we use the old gtk style with init() as is used in the C original -- maybe better use modern app sytle 
proc main() =
  gtk.init()
  let window = newWindow()
  window.title = "Select Cell"
  window.position = WindowPosition.center
  window.defaultSize = (500, 500)
  window.borderWidth = 20
  connect(window, "destroy", bye)
  var iter: TreeIter
  var h = [typeFromName("guint"), typeFromName("gchararray"), typeFromName("gchararray"),
    typeFromName("gchararray")]
  var store = newListStore(Columns,  cast[pointer]( unsafeaddr h)) # cast is ugly, we should fix it in bindings.
  let progNames = ["Gedit", "Gimp", "Inkscape", "Firefox", "Calculator", "Devhelp"]
  for i, n in progNames:
    store.append(iter) # currently we have to use setValue() as there is no varargs proc as in C original
    store.setValue(iter, Id, toUIntVal(i))
    store.setValue(iter, Program, toStringVal(n))
    store.setValue(iter, Color1, toStringVal(if (i and 1) != 0: "LightSlateGray" else: "DarkCyan"))
    store.setValue(iter, Color2, toStringVal("cyan"))
  var tree  = newTreeViewWithModel(store)
  tree.setHexpand
  tree.setVexpand
  setProperty(tree, "activate-on-single-click", toBoolVal(true))
  var selection = tree.getSelection()
  selection.setMode(SelectionMode.single)
  var renderer1 = newCellRendererText()
  setProperty(renderer1, "editable", toBoolVal(false))
  var renderer2 = newCellRendererText()
  setProperty(renderer2, "editable", toBoolVal(true))
  connect(renderer2, "edited", updateRow, tree)
  ## Bind the Color column to the "cell-background" property.
  var column1 = newTreeViewColumn()
  column1.setTitle("ID")
  column1.packStart(renderer1, true)
  column1.addAttribute(renderer1, "text", Id)
  column1.addAttribute(renderer1, "cell-background", Color1)
  discard tree.appendColumn(column1)
  var column2  = newTreeViewColumn()
  column1.setTitle("Program")
  column1.packStart(renderer2, true)
  column1.addAttribute(renderer2, "text", Program)
  column1.addAttribute(renderer2, "cell-background", Color2)
  discard tree.appendColumn(column2)
  var grid = newGrid() # only one occupied cell makes no sense -- but so we can add more widgets later
  grid.attach(tree, 0, 0, 1, 1)
  window.add(grid)
  const cssString = # note: big font selected intentionally
    """treeview{background-color: rgba(0,255,255,1.0); font-size:30pt} treeview:selected{background-color:
    rgba(255,255,0,1.0); color: rgba(0,0,255,1.0);}"""
  var provider  = newCssProvider()
  discard provider.loadFromData(cssString)
  addProviderForScreen(getDefaultScreen(), provider, STYLE_PROVIDER_PRIORITY_APPLICATION)
  window.showAll
  gtk.main()

main()

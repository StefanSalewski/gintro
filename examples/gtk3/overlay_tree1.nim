# nim c overlayTree1.nim
# https://discourse.gnome.org/t/gtk-how-to-draw-on-top-of-gtktreeview/1783/2
import gintro/[gtk, gdk, glib, gobject, cairo]
import strformat
from strutils import parseInt
const
  Id = 0
  Program = 1
  Color = 2
  Color2 = 3
  Columns = 4

var
  rowG = 0
  columnG = 1

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

proc selectCell(treeView: TreeView; path: TreePath; column: TreeViewColumn) =
  let str = toString(path)
  echo fmt"{str} {getTitle(column)}"
  rowG = parseInt(str)
  queueDraw(treeView)

proc drawRectangle(overlay: Overlay; cr: cairo.Context; treeView: TreeView): bool =
  echo fmt"Draw Rectangle {rowG} {columnG}"
  let path = newTreePathFromIndices(@[rowG.int32])
  echo path.toString
  let column = getColumn(treeView, columnG)
  var rect: gdk.Rectangle
  var x, y: int
  treeView.convertBinWindowToWidgetCoords(0, 0, x, y)
  cr.save
  cr.translate(x.float, y.float)
  cr.setLineWidth(2)
  cr.setSource(0, 0, 0, 1)
  treeView.getCellArea(path, column, rect)
  cr.rectangle(rect.x.float + 1, rect.y.float + 1, rect.width.float - 1, rect.height.float - 1)
  cr.stroke
  cr.restore
  return EVENT_PROPAGATE # false

proc main =
  gtk.init()
  let window = newWindow()
  window.setTitle("Overlay Tree")
  window.setPosition(WindowPosition.center)
  window.setDefaultSize(500, 500)
  window.setBorderWidth(20)
  window.connect("destroy", bye)
  var iter: TreeIter
  let h = [typeFromName("guint"), typeFromName("gchararray"), typeFromName("gchararray"),
    typeFromName("gchararray")]
  let store = newListStore(Columns, cast[pointer](unsafeaddr h)) # cast is ugly, we should fix it in bindings.
  let progNames = ["Gedit", "Gimp", "Inkscape", "Firefox", "Calculator", "Devhelp"]
  for i, n in progNames:
    store.append(iter) # currently we have to use setValue() as there is no varargs proc as in C original
    store.setValue(iter, Id, toUIntVal(i))
    store.setValue(iter, Program, toStringVal(n))
    store.setValue(iter, Color, toStringVal("SpringGreen"))
    store.setValue(iter, Color2, toStringVal("cyan"))
  let tree = newTreeViewWithModel(store)
  tree.setHexpand
  tree.setVexpand
  tree.setProperty("activate-on-single-click", toBoolVal(true))
  let selection = tree.getSelection
  selection.setMode(SelectionMode.single)
  let renderer1 = newCellRendererText()
  renderer1.setProperty("editable", toBoolVal(false))
  let renderer2 = newCellRendererText()
  renderer2.setProperty("editable", toBoolVal(true))
  tree.connect("row-activated", selectCell)
  ## Bind the COLOR column to the "cell-background" property.
  let column1 = newTreeViewColumn()
  column1.setTitle("ID")
  column1.packStart(renderer1, true)
  column1.addAttribute(renderer1, "text", Id)
  column1.addAttribute(renderer1, "cell-background", Color)
  discard tree.appendColumn(column1)
  let column2 = newTreeViewColumn()
  column2.setTitle("Program")
  column2.packStart(renderer2, true)
  column2.addAttribute(renderer2, "text", Program)
  column2.addAttribute(renderer2, "cell-background", Color2)
  discard tree.appendColumn(column2)
  ## For drawing the outline of the cell.
  let overlay = newOverlay()
  overlay.setHexpand
  overlay.setVexpand
  overlay.setAppPaintable
  overlay.addOverlay(tree)
  overlay.setOverlayPassThrough(tree, true)
  overlay.connectAfter("draw", drawRectangle, tree)
  let grid = newGrid()
  grid.attach(overlay, 0, 0, 1, 1)
  window.add(grid)
  const cssString =
    """treeview{background-color: rgba(0,255,255,1.0);
      font-size:30pt} treeview:selected{background-color:rgba(0,255,255,1.0);
      color: rgba(0,0,255,1.0);}"""
  let provider = newCssProvider()
  discard provider.loadFromData(cssString)
  getDefaultScreen().addProviderForScreen(provider, STYLE_PROVIDER_PRIORITY_APPLICATION)
  window.showAll
  gtk.main()

main() # 123 lines

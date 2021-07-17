import gintro/[gtk4, gobject, gio]
import std/with

type
  AddControlData = tuple 
    entry: Entry
    list: StringList
  DeleteControlData = tuple
    selection: SingleSelection
    list: StringList

### Utils
func getNItems(self: StringList): int = 
  let lm = cast[ListModel](self)
  return lm.getNItems()

proc getString(self: ListItem): string = 
  let strobj = cast[StringObject](self.getItem())
  result = gtk4.getString(strobj)

func generate100Strings(itemNum: int): seq[string] = 
  for index in itemNum..itemNum + 100:
    result.add "item №" & $index

### SignalFactory callbacks
proc setup_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  listitem.setChild(newLabel(""))
  
proc bind_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  listitem.getChild().Label.text = listitem.getString()


proc unbind_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  echo "unbind"

proc teardown_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  listitem.setChild (nil)


### Controls callbacks
func btnAddCb(btn: Button, controlData: AddControlData) =
  if controlData.entry.text != "":
    controlData.list.append controlData.entry.text
    controlData.entry.text = ""
  
func btnRemoveCb(btn: Button, data: DeleteControlData) =
  data.list.remove data.selection.getSelected()
  
func btnRemoveAllCb(btn: Button, data: StringList) =
  data.splice(0, data.getNItems())

func btnAdd100Cb(btn: Button, data: StringList) =
  let maxItemPosition = data.getNItems()
  data.splice(maxItemPosition, 0, generate100Strings(maxItemPosition))

proc activate(app: gtk4.Application) =
  let
    # main
    window = newApplicationWindow(app)
    scrolled = newScrolledWindow()
    mainBox = newBox(Orientation.vertical, 0)
    # ListView
    sl = gtk4.newStringList("Nim", "Vala", "Rust", "Zig")
    ls = cast[ListModel](sl)
    ns = gtk4.newSingleSelection(ls)
    factory = gtk4.newSignalListItemFactory()
    lv = newListView(ns, factory)
    # Controls
    controlBox = newBox(Orientation.horizontal, 0)
    add = newButton("Add")
    remove = newButton("Remove")
    removeAll = newButton("Remove All")
    add100 = newButton("Add 100")
    entry = newEntry()

  # Connect controls
  add.connect("clicked", btnAddCb, (entry, sl))
  remove.connect("clicked", btnRemoveCb, (ns, sl))
  removeAll.connect("clicked", btnRemoveAllCb, sl)
  add100.connect("clicked", btnAdd100Cb, sl)

  
  with controlBox:
    halign= Align.center
    setCssClasses("linked")
    append add
    append remove
    append removeAll
    append add100
    append entry
  
  with scrolled:
    setChild lv
    vexpand = true

  with factory:
    connect("setup", setup_cb)
    connect("bind", bind_cb)
    connect("unbind", unbind_cb)
    connect("teardown", teardown_cb)

  with mainBox:
    append scrolled
    append controlBox

  with window:
    defaultSize = (500, 300)
    title = "Nim Simple Todo Example"
    setChild mainBox
    show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

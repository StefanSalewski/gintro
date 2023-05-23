import gintro/[gtk4, gobject, gio]
import std/with


proc setup_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  listitem.setChild(newLabel(""))
  
proc bind_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  let 
    lb: Label = listitem.getChild.Label
    strobj: StringObject = stringObject(listitem.getItem())
  lb.setText strobj.getString().cstring

proc unbind_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  # There's nothing to do here. 
  # If you does something like setting a signal in bind_cb,
  # then disconnecting the signal is necessary in unbind_cb. 
  echo "unbind"

proc teardown_cb(factory: gtk4.SignalListItemFactory, listitem: gtk4.ListItem) =
  listitem.setChild (nil)
  # When the child of listitem is set to NULL, the reference to GtkLabel will be released and lb will be destroyed. 
  # Therefore, g_object_unref () for the GtkLabel object doesn't need in the user code. 


proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    scr = newScrolledWindow()

    sl = gtk4.newStringList("Nim", "Vala", "Rust", "Zig")
    ls = listModel(sl)
    ns = gtk4.newMultiSelection(ls)
    factory = gtk4.newSignalListItemFactory()
    columnView = newColumnView(ns)
    columnViewColumn = newColumnViewColumn("sas", factory)
    columnViewColumn2 = newColumnViewColumn("sus", factory)
    columnViewColumn3 = newColumnViewColumn("sus", factory)

  with columnView:
    appendColumn columnViewColumn
    appendColumn columnViewColumn2
    appendColumn columnViewColumn3
  with scr:
    hexpand = true
    vexpand = true


  with factory:
    connect("setup", setup_cb)
    connect("bind", bind_cb)
    connect("unbind", unbind_cb)
    connect("teardown", teardown_cb)

  with window:
    defaultSize = (600, 400)
    title = "Nim ListView"
    setChild columnView
    show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

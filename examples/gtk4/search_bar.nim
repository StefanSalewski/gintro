import gintro/[gtk4, gobject, gio]
import std/with

proc searchChangedCb(entry: SearchEntry, label: Label) =
  label.text = entry.text

proc appActivate(app: Application) =
  let
    window = newApplicationWindow(app)
    header = newHeaderBar()
    searchBar = newSearchBar()
    box = newBox(Orientation.vertical, 5)
    hbox = newBox(Orientation.horizontal, 5)
    vbox = newBox(Orientation.vertical, 5)
    entry = newSearchEntry()
    searchButton = newToggleButton()
    label1 = newLabel("Searching for:")
    label2 = newLabel("")

  with searchBar:
    connectEntry entry
    showCloseButton = false
    child = entry
    keyCaptureWidget = window

  with vbox:
    append searchBar
    append box

  box.append hbox

  with hbox:
    append label1
    append label2


  searchButton.setIconName("system-search-symbolic")
  discard searchButton.bindProperty("active", searchBar, "search-mode-enabled", {bidirectional})
  header.packEnd searchButton

  entry.connect("search-changed", searchChangedCb, label2)
  entry.halign = Align.center

  with window:
    titlebar = header
    child = vbox
    title = "SearchBar Nim"
    defaultSize = (200, 200)
    show

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

import gintro/[gtk4, gobject, gio]

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


  window.titlebar = header

  window.child = vbox

  entry.halign = Align.center

  searchBar.connectEntry entry
  searchBar.showCloseButton = false
  searchBar.child = entry
  vbox.append searchBar

  searchBar.keyCaptureWidget = window

  vbox.append box

  searchButton.setIconName("system-search-symbolic")
  discard searchButton.bindProperty("active", searchBar, "search-mode-enabled", {bidirectional})
  header.packEnd searchButton

  box.append hbox
  hbox.append label1
  hbox.append label2

  entry.connect("search-changed", searchChangedCb, label2)


  window.title = "SearchBar Nim"
  window.defaultSize = (200, 200)
  show(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

import gintro/[gtk4, gobject, gio, adw]
import std/with

proc setFirstRowParams(label: Label) =
  with label:
    xalign = 0
    halign = Align.start
    valign = Align.center
    hexpand = true

proc createExpandRow(): ExpanderRow =
  let
    expanderRow = newExpanderRow()
    
  expanderRow.showEnableSwitch = true

  with expanderRow: 
    setTitle("ExpanderRow Title")
    setSubtitle("Subtitle")
  result = expanderRow

proc createListBoxFrame1(): Frame =
  let
    frame1 = newFrame()
    mainListBox = newListBox()
    expanderListBox = newListBox()

    listBoxRow1 = newBox(Orientation.horizontal, 0)
    labelSwitch = newLabel("Switch")
    switch = newSwitch()

    listBoxRow2 = newBox(Orientation.horizontal, 0)
    labelCheck = newLabel("Check")
    check = newCheckButton()

    listBoxRow3 = newBox(Orientation.horizontal, 0)
    labelImage = newLabel("Image")
    image = newImageFromIconName("start-here-symbolic")

    expanderRow1 = createExpandRow()


  frame1.child = mainListBox

  with expanderListBox:
    selectionMode = SelectionMode.none
    showSeparators = true
    setCssClasses("rich-list")

    append listBoxRow1
    append listBoxRow2
    append listBoxRow3

  expanderRow1.add(expanderListBox)

  with mainListBox:
    selectionMode = SelectionMode.none
    showSeparators = true
    setCssClasses("rich-list")
    append expanderRow1

  with listBoxRow1:
    append labelSwitch
    append switch

  setFirstRowParams labelSwitch

  with switch:
    halign = Align.end
    valign = Align.center

  with listBoxRow2:
    append labelCheck
    append check

  setFirstRowParams labelCheck

  with check:
    halign = Align.end
    valign = Align.center
    marginStart = 10
    marginEnd = 10
    active = true

  with listBoxRow3:
    append labelImage
    append image

  setFirstRowParams labelImage

  with image:
    halign = Align.end
    valign = Align.center
    marginStart = 10
    marginEnd = 10
    opacity = 1

  result = frame1


proc activate(app: gtk4.Application) =
  let
    window = adw.newApplicationWindow(app)

    scrolledWindow = newScrolledWindow()
    viewPort = newViewport()
    mainBox = newBox(Orientation.vertical, 10)

    labelGroup1 = newLabel("Group 1")

    header = adw.newHeaderBar()
    adwBox = newBox(Orientation.vertical, 0)

  with scrolledWindow:
    hexpand = true
    vexpand = true
    minContentHeight = 200
    child = viewPort

  viewPort.scrollToFocus = true
  viewPort.child = mainBox

  with mainBox:
    marginStart = 60
    marginEnd = 60
    marginTop = 30
    marginBottom = 30
    append labelGroup1
    append createListBoxFrame1()


  with labelGroup1:
    xalign = 0
    marginBottom = 10
    setCssClasses("title-2")


  with adwBox:
    append header
    append scrolledWindow

  with window:
    title = "ListBox GTK 4 example"
    defaultSize = (400, 600)
    setChild adwBox
    show


proc initAdw(app: Application) = 
  adw.init()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("startup", initAdw)
  app.connect("activate", activate)
  discard run(app)

main()

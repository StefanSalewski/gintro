import gintro/[adw, gtk4, gobject, gio]
import std/with


proc toActionRow(widget: Widget, title: string): ActionRow = 
  result = newActionRow()
  result.title = title
  result.activatableWidget = widget
  result.addSuffix widget
  widget.valign = Align.center


proc createPage1(): Widget =
  let
    page = newPreferencesPage()
    group = newPreferencesGroup()
    listExpanderRow0 = adw.newExpanderRow()

  page.add group

  listExpanderRow0.title = "ExpanderRow"
  listExpanderRow0.add newButton("Test").toActionRow("Button")

  with group:
    add listExpanderRow0
    add newSwitch().toActionRow("Switch")
    add newCheckButton().toActionRow("Check")
    add newImageFromIconName("start-here-symbolic").toActionRow("Image")

  result = page

proc createPage2(): Widget =
  let
    page = newPreferencesPage()
    group = newPreferencesGroup()
    scale = newScale(Orientation.horizontal, newAdjustment(50, 0, 100, 1, 10))

  page.add group
  scale.hexpand = true

  with group:
    add scale.toActionRow("Scale")
    add newSpinButton(newAdjustment(50, 0, 100, 1, 10), 10, 0).toActionRow("Spin")
    add newDropDownFromStrings(["Nim", "Vala", "Rust", "Python"]).toActionRow("Drop Down")
    add newEntry().toActionRow("Entry")
  result = page


proc activate(app: adw.Application) =
  let
    window = adw.newApplicationWindow(app)

    scrolledWindow = newScrolledWindow()
    viewPort = newViewport()
    mainBox = newBox(Orientation.vertical, 10)
    header = adw.newHeaderBar()
    adwBox = newBox(Orientation.vertical, 0)

    labelGroup1 = newLabel("Group 1")
    labelGroup2 = newLabel("Group 2")

  with scrolledWindow:
    hexpand = true
    vexpand = false
    minContentHeight = 200
    child = viewPort

  with adwBox:
    append header
    append mainBox

  viewPort.scrollToFocus = true
  viewPort.child = adwBox

  with mainBox:
    marginStart = 60
    marginEnd = 60
    marginTop = 30
    marginBottom = 30
    append labelGroup1
    append createPage1()
    append labelGroup2
    append createPage2()

  with labelGroup1:
    xalign = 0
    marginBottom = 10
    setCssClasses("title-2")

  with labelGroup2:
    xalign = 0
    marginBottom = 10
    setCssClasses("title-2")

  with window:
    title = "Adwaita Preference Page"
    defaultSize = (400, 650)
    setChild scrolledWindow
    show

proc initAdw(app: adw.Application) = 
  adw.init()

proc main =
  let app = adw.newApplication("org.gtk.example", {})
  app.connect("startup", initAdw)
  app.connect("activate", activate)
  discard run(app)

main()



import gintro/[gtk4, gobject, gio, adw]
import std/with


proc activate(app: gtk4.Application) =
  let
    window = adw.newApplicationWindow(app)
    label = newLabel("on adwaita ApplicationWindow bottom corners are rounded")

    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)

  with mainBox:
    append header
    append label
    
  with label:
    text = "on adwaita ApplicationWindow bottom corners are rounded"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10


  with window:
    title = "Adwaita ApplicationWindow"
    setChild mainBox
    show

proc initAdw(app: Application) = 
  adw.init()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("startup", initAdw)
  app.connect("activate", activate)
  discard run(app)

main()

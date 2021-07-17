import gintro/[gtk4, gobject, gio]
import std/with

proc hello(b: Button) =
  echo "hello world"

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    button1 = newButton()
    button2 = newButton()
    headerBar = newHeaderBar()

  with button1:
    label = "packStart"
    connect("clicked", hello)

  with button2:
    label = "packEnd"
    connect("clicked", hello)

  with headerBar:
    packStart button1
    packEnd button2

  with window:
    title = "headerBar"
    setTitlebar headerBar
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

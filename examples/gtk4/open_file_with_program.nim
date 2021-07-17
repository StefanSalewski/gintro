import gintro/[gtk4, gdk4, gobject, gio]
import std/with

# receiver has the sender of the signal as the first argument
proc hello(b: Button, window: ApplicationWindow) =
  let file = gio.newGFileForPath("screenshots/listbox_controls.png")
  gtk4.showUri(window, file.uri, gdk4.CURRENT_TIME)
  echo "hello world"

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    button = newButton()

  with button:
    label = "open picture from screenshots"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    connect("clicked", hello, window)

  with window:
    title = "gtk4.showUri"
    defaultSize = (200, 200)
    resizable = false
    setChild button
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

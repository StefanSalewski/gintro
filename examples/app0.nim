# app0.nim -- minimal application style example
# nim c app0.nim
import gintro/[gtk, glib, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3 & Nim"
  window.defaultSize = (200, 200)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

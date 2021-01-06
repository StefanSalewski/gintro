# https://wiki.gnome.org/Projects/WebKitGtk/ProgrammingGuide/Tutorial
# nim c --gc:arc webkitgtk.nim
import gintro/[gtk, glib, gobject, gio, webkit2]

proc appActivate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "WebKitGtk"
  window.defaultSize = (800, 600)
  let view = newWebView()
  view.loadUri("https://nim-lang.org/")
  window.add(view)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


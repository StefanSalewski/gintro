# https://wiki.gnome.org/Projects/WebKitGtk/ProgrammingGuide/Tutorial
# nim c --gc:arc webkitgtk.nim
import gintro/[gtk4, glib, gobject, gio, webkit2]

proc appActivate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "WebKitGtk"
  window.defaultSize = (800, 600)
  let view = newWebView()
  view.loadUri("https://nim-lang.org/")
  window.setChild(view)
  window.show

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


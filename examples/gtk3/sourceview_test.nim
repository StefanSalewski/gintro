import gintro/[gtk, glib, gobject, gio, gtksource]

proc appActivate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTKSourceView"
  window.defaultSize = (250, 350)
  let view = newView()
  window.add(view)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()

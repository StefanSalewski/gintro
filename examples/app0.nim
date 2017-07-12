# app0.nim -- minimal application style example
# nim c app0.nim
import gintro/gtk
import gintro/gio except Application, newApplication # we want to use GTK application
#from gintro/gio import ApplicationFlags, scActivate, run

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3 & Nim"
  window.defaultSize = (200, 200)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", activate)
  discard run(app)

main()

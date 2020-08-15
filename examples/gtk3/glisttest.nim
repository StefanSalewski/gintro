# nim c --gc:arc glisttest.nim
import gintro/[gtk, glib, gobject, gio]

proc buttonClicked (button: Button) =
  button.label = utf8Strreverse(button.label, -1)

proc appActivate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GNOME Button"
  window.defaultSize = (250, 50)
  let button = newButton("Click Me")
  window.add(button)
  #button.connect("clicked",  buttonClicked)
  let ch = window.getChildren # glist to Nim seq test 
  echo ch.len
  echo ch[0] == button
  echo cast[int](ch[0].impl)
  echo cast[int](button.impl)
  echo ch[0] is Button
  echo ch[0] of Button
  Button(ch[0]).connect("clicked",  buttonClicked)
  #button.connect("clicked",  buttonClicked)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


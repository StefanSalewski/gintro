# https://developer.gnome.org/gtk3/stable/ch01s03.html
# builder.nim -- application style example using builder/glade xml file for user interface
# nim c builder.nim
import gintro/[gtk, glib, gobject, gio]

proc hello(b: Button; msg: string) =
  echo "Hello", msg

proc quitApp(b: Button; app: Application) =
  echo "Bye"
  quit(app)

proc appActivate(app: Application) =
  let builder = newBuilder()
  discard builder.addFromFile("builder.ui")
  let window = builder.getApplicationWindow("window")
  window.setApplication(app)
  var button = builder.getButton("button1")
  button.connect("clicked", hello, "")
  button = builder.getButton("button2")
  button.connect("clicked", hello, " again...")
  button = builder.getButton("quit")
  button.connect("clicked", quitApp, app)
  #showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

import gintro/[gtk4, gobject, gio]
import std/with

# receiver has the sender of the signal as the first argument
proc hello(b: Button) =
  echo "hello world"

proc activate(app: gtk4.Application) =
  let 
    window = newApplicationWindow(app)
    button = newButton()
  
  with button:
    label = "hello world"
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    connect("clicked", hello)

  with window :
    title = "hello world"
    resizable = false
    setChild button
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

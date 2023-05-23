import gintro/[gtk4, glib, gobject, gio]
import std/with

var button: Button
var countdown = 0

proc updateGUI(b: Button): bool =
  countdown.inc()
  echo countdown
  if countdown <= 60:
    b.label = $countdown
    echo b.label
    return SOURCE_CONTINUE
  else:
    return SOURCE_REMOVE


proc buttonClicked(button: Button) =
  countdown = 1
  button.label = "1"
  discard timeoutAdd(100, updateGUI, button)


proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
  
  button = newButton("Click Me")
  button.connect("clicked",  buttonClicked)
    
  with window:
    title = "Countdown"
    defaultSize = (250, 50)
    setChild(button)
    show

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard app.run()

main()
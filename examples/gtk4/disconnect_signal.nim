import gintro/[gtk4, gobject, gio]

var 
  counter: int
  id: culong

proc button2ClickedCb(button: Button) =
  inc(counter)
  button.label = $counter
  
proc buttonClickedCb(button: Button; arg: Button) =
  echo("disconnect")
  arg.signalHandlerDisconnect(id)

proc activate(app: gtk4.Application) =
  let 
    window = newApplicationWindow(app)
    button = newButton("disconnect btn 2")
    button2 = newButton("connected")
    box = newBox(Orientation.horizontal, 0)
  id = button2.connect("clicked", button2ClickedCb)

  button.connect("clicked", buttonClickedCb, button2)  
  box.append(button)
  box.append(button2)
  window.setChild(box)
  window.present()

proc main =
  let app = newApplication("org.gtk.example", {})
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
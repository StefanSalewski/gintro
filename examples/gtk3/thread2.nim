# nim c --threads:on --gc:arc -r thread2.nim

import gintro/[gtk, glib, gobject, gio]
from  os import sleep

var workThread: system.Thread[void]
var button: Button

proc idleFunc(i: int): bool =
  button.label = $i
  return SOURCE_REMOVE

proc workProc =
  var countdown {.global.} = 25
  while countdown > 0:
    sleep(1000)
    dec(countdown)
    idleAdd(idleFunc, countdown)

proc buttonClicked(button: Button) =
  button.label = utf8Strreverse(button.label, -1)

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Countdown"
  window.defaultSize = (250, 50)
  button = newButton("Click Me")
  window.add(button)
  button.connect("clicked",  buttonClicked)
  window.showAll
  createThread(workThread, workProc)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", activate)
  discard app.run

main()

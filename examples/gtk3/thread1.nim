# https://nim-lang.org/docs/channels.html
# nim c --threads:on --gc:arc -r thread1.nim

import gintro/[gtk, glib, gobject, gio]
from  os import sleep

var channel: Channel[int]
var workThread: system.Thread[void]

proc workProc =
  var countdown {.global.} = 25
  while countdown > 0:
    sleep(1000)
    dec(countdown)
    channel.send(countdown)

proc updateGUI(b: Button): bool =
  let msg = channel.tryRecv()
  if msg.dataAvailable:
    b.label = $msg.msg
    if msg.msg == 0:
      workThread.joinThread
      channel.close
      return SOURCE_REMOVE
  return SOURCE_CONTINUE

proc buttonClicked (b: Button) =
  b.label = utf8Strreverse(b.label, -1)

proc activate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Countdown"
  window.defaultSize = (250, 50)
  let button = newButton("Click Me")
  window.add(button)
  button.connect("clicked",  buttonClicked)
  window.showAll
  channel.open
  createThread(workThread, workProc)
  discard timeoutAdd(1000 div 60, updateGUI, button)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", activate)
  discard app.run

main()

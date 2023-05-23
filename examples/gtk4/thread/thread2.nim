# nim c --threads:on --gc:arc -r thread2.nim

import gintro/[gtk4, glib, gobject, gio]
import std/with

from  os import sleep

var workThread: system.Thread[void]
var button: Button
var countdown = 0

proc idleFunc(i: int): bool =
  button.label = $i
  return SOURCE_REMOVE

proc workProc =
  
  while countdown < 1000:
    sleep(1)
    inc(countdown)
    idleAdd(idleFunc, countdown)

proc buttonClicked(button: Button) =
  countdown = 0
  button.label = "0001"
  createThread(workThread, workProc)
  # button.label = utf8Strreverse(button.label, -1)

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
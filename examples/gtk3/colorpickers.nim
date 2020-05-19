# nim c button.nim
import gintro/[gtk, glib, gobject, gio, cairo]
from math import Tau

type
  ColorPicker = ref object of Button
    c: array[4, float]

proc newColorPicker(c: array[4, float]): ColorPicker =
  result = newButton(ColorPicker)
  result.c = c

proc buttonClicked (button: ColorPicker) =
  #button.label = utf8Strreverse(button.label, -1)
  echo "clicked"

proc draw(b: ColorPicker; cr: cairo.Context): bool =
  echo "draw"
  let x = getAllocatedWidth(b).float / 2
  let y = getAllocatedHeight(b).float / 2
  cr.moveTo(x, y)
  cr.newPath
  cr.arc(x, y, 10, 0, math.Tau)
  cr.setSource(b.c)
  cr.setLineWidth(5)
  cr.stroke

proc appActivate (app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GNOME Button"
  window.defaultSize = (250, 50)
  let box = newBox(Orientation.horizontal, 0)
  var button = newColorPicker([1.0, 0, 0, 1])#newButton(ColorPicker)#"Click Me")
  box.add(button)
  button.connect("clicked",  buttonClicked)
  button.connectAfter("draw", draw)
  button = newColorPicker([0.0, 0, 1, 1])#newButton(ColorPicker)#"Click Me")
  box.add(button)
  button.connect("clicked",  buttonClicked)
  button.connectAfter("draw", draw)
  button = newColorPicker([0.0, 1, 0, 1])#newButton(ColorPicker)#"Click Me")
  box.add(button)
  button.connect("clicked",  buttonClicked)
  button.connectAfter("draw", draw)
  window.add(box)

  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


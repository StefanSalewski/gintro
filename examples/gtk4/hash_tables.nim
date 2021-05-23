import gintro/[gtk4, gobject, gio]
import std/with, tables, hashes

# This example shows how you can store any data structure associated with a widget 
# so that you can access it in events. 
# This may be the better analog of gobject.setData().

var buttonTable: Table[gtk4.Button, string]
const fruits = ["banana", "cherri", "peach", "mandarin", "apple"]
const fruitsIcons = ["🍌", "🍒", "🍑", "🍊", "🍎"]

proc hash(b: Widget): Hash = 
  # create hash from widget pointer
  result =  cast[Hash](cast[uint](b) shr 3)
  echo result

# click on buttons will print icons of fruits
proc buttonClickedCb(b: gtk4.Button) =
  echo buttonTable[b]

proc createFruitButtons(): seq[Button] =
  for i, fruit in fruits:
    let btn = newButton(fruit)
    buttonTable[btn] = fruitsIcons[i]
    btn.connect("clicked", buttonClickedCb)
    result.add btn

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    box = newBox(Orientation.horizontal, 2)
    buttons: seq[Button] = createFruitButtons()
    
  for btn in buttons:
    box.append btn

  with window:
    title = "widget hash"
    setChild box
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

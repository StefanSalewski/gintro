# nim c connect_args.nim
import gintro/[gtk, gobject, gio]

type
  O = object
    i, j: int

proc b1Callback(button: Button; str: string) =
  echo str

proc b2Callback(button: Button; o: O) =
  echo "Value of field i in object o = ", o.i

proc b3Callback(button: Button; r: ref O) =
  echo "Value of field i in ref to object o = ", r.i

proc b4Callback(button: Button; w: ApplicationWindow) =
  if w.title == "Nim with GTK3":
    w.title = "GTK3 with Nim"
  else:
    w.title = "Nim with GTK3"

proc appActivate(app: Application) =
  let
    o = O(i: 1234567)
    r = (ref O)(i: 7654321)
    window = newApplicationWindow(app)
    box = newBox(Orientation.vertical, 0)
    b1 = newButton("Nim with GTK3")
    b2 = newButton("Passing an object from stack")
    b3 = newButton("Passing an object from heap")
    b4 = newButton("Passing a Widget")
  window.title = "Parameters for callbacks"
  b1.connect("clicked", b1Callback, "is much fun.")
  b2.connect("clicked", b2Callback, o)
  b3.connect("clicked", b3Callback, r)
  b4.connect("clicked", b4Callback, window)
  for b in [b1, b2, b3, b4]:
    box.add(b)
  window.add(box)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


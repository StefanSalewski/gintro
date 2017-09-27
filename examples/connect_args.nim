# nim c connect_args.nim
import gintro/[gtk, glib, gobject]
import gintro/gio except Application, newApplication

type
  O = object
    i: int

proc b1Callback(button: Button; str: string) =
  echo str

proc b2Callback(button: Button; o: O) =
  echo "Value of field i in object o = ", o.i

proc b3Callback(button: Button; r: ref O) =
  echo "Value of field i in ref to object O = ", r.i

proc b4Callback(button: Button; w: ApplicationWindow) =
  if w.title == "Nim with GTK3":
    w.title = "GTK3 with Nim"
  else:
    w.title = "Nim with GTK3"

proc appActivate (app: Application) =
  var o: O
  var r: ref O
  new r
  o.i = 1234567
  r.i = 7654321
  let window = newApplicationWindow(app)
  let box = newBox(Orientation.vertical, 0)
  window.title = "Parameters for callbacks"
  let b1 = newButton("Nim with GTK3")
  let b2 = newButton("Passing an object from stack")
  let b3 = newButton("Passing an object from heap")
  let b4 = newButton("Passing a Widget")
  b1.connect("clicked",  b1Callback, "is much fun.")
  b2.connect("clicked",  b2Callback, o)
  b3.connect("clicked",  b3Callback, r)
  b4.connect("clicked",  b4Callback, window)
  box.add(b1)
  box.add(b2)
  box.add(b3)
  box.add(b4)
  window.add(box)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


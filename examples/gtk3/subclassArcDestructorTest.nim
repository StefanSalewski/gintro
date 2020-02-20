# nim c --gc:arc count_button.nim
import gintro/[gtk, glib, gobject, gio]

type
  CountButton = ref object of Button
    counter: int

when compileOption("gc", "arc"):
  proc `=destroy`(x: var typeof(CountButton()[])) =
    echo "CountButtonDestroy"
    echo cast[CountButton](addr(x)).label # really ugly, only for test
    gtk.`=destroy`(typeof(Button()[])(x))

proc buttonClicked (button: CountButton; decrement: int) =
  dec(button.counter, decrement)
  button.label = "Counter: " & $button.counter 
  echo "Counter is now: ", button.counter

proc appActivate (app: Application) =
  var button, d: CountButton
  let window = newApplicationWindow(app)
  window.title = "Count Button"
  initButton(button, "Counting down from 100 by 5")
  initButton(d, "Dummy Button") # to test call of destroy
  echo d.getLabel
  button.counter = 100
  window.add(button)
  button.connect("clicked",  buttonClicked, 5)
  window.showAll

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard app.run

main()


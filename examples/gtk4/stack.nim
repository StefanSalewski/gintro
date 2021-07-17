import gintro/[gtk4, gobject, gio]
import std/with
var x = true

# receiver has the sender of the signal as the first argument
proc hello(b: Button, stack: Stack) =
  if x:
    stack.setVisibleChildName("child2")
  else:
    stack.setVisibleChildName("child1")
  x = not x

  echo "hello world"


proc addToStack(stack: Stack, w1: Widget, w2: Widget) = 
  discard stack.addNamed(w1, "child1")
  discard stack.addNamed(w2, "child2")



proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    mainBox = newBox(Orientation.vertical, 6)
    button = newButton("Change stack child")
    stack1 = newStack()
    stackChildren1 = newLabel("Stack children 1")
    stackChildren2 = newLabel("Stack children 2")

  stack1.addToStack(stackChildren1, stackChildren2)

  stack1.transitionDuration = 800
  stack1.transitionType = StackTransitionType.slideLeftRight


  with mainBox:
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    append button
    append stack1

  with button:
    label = "hello world"
    connect("clicked", hello, stack1)

  with window:
    title = "Stack"
    setChild mainBox
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

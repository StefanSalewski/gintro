import gintro/[gtk4, gobject, gio]
import std/with

proc addToStack(stack: Stack, w1: Widget, w2: Widget) = 
  discard stack.addTitled(w1,"child1", "child1")
  discard stack.addTitled(w2, "child2","child2")

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    mainBox = newBox(Orientation.horizontal, 6)
    stackSidebar = newStackSidebar()
    stack1 = newStack()
    stackChildren1 = newButton("Stack children 1")
    stackChildren2 = newButton("Stack children 2")

  stackSidebar.stack = stack1
  stackSidebar.hexpand = true
  stack1.addToStack(stackChildren1, stackChildren2)

  stack1.transitionType = StackTransitionType.slideUpDown

  with mainBox:
    hexpand = true
    marginTop = 10
    marginBottom = 10
    marginStart = 10
    marginEnd = 10
    append stackSidebar
    append stack1

  with window:
    title = "Stack"
    defaultSize = (200, 200)
    setChild mainBox
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

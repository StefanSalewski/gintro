import gintro/[gtk4, gobject, gio]
import std/with

proc hello(b: Button, reveal: Revealer) =
  echo "hello world"
  reveal.revealChild = not reveal.childRevealed

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    mainBox = newBox(Orientation.vertical, 0)
    button1 = newButton()

    headerBar = newHeaderBar()
    reveal = newRevealer()
    centerBox = newCenterBox()
    buttonsBox = newBox(Orientation.horizontal, 0)
    # statusEntry = newEntry()
    statusBtn1 = newButton("sus")
    statusBtn2 = newButton("sas")
    statusBtn3 = newButton("sos")

  reveal.child = centerBox
  
  centerBox.centerWidget = buttonsBox
  centerBox.orientation = Orientation.horizontal

  with buttonsBox:
    append(statusBtn1)
    append(statusBtn2)
    append(statusBtn3)
    setCssClasses("linked")


  with button1:
    label = "reveal"
    connect("clicked", hello, reveal)


  with headerBar:
    packStart button1

  mainBox.append reveal

  with window:
    title = "headerBar"
    setTitlebar headerBar
    child = mainBox
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

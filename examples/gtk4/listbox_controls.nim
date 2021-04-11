import gintro/[gtk4, gobject, gio]
import std/with

proc hello(b: Button) =
  echo "hello world"

proc setFirstRowParams(label: Label) = 
  with label:
    xalign = 0
    halign = Align.start
    valign = Align.center 
    hexpand = true

proc createListBoxFrame1(): Frame =
  let 
    frame1 = newFrame()
    listBox1 = newListBox()

    listBoxRow1 = newBox(Orientation.horizontal, 0)
    labelSwitch = newLabel("Switch")
    switch = newSwitch()

    listBoxRow2 = newBox(Orientation.horizontal, 0)
    labelCheck = newLabel("Check")
    check = newCheckButton()

    listBoxRow3 = newBox(Orientation.horizontal, 0)
    labelImage = newLabel("Image")
    image = newImageFromIconName("leonflix-symbolic")

  frame1.child = listBox1

  with listBox1:
    selectionMode = SelectionMode.none
    showSeparators = true
    setCssClasses("rich-list")
    append listBoxRow1
    append listBoxRow2
    append listBoxRow3

  with listBoxRow1:
    append labelSwitch
    append switch

  setFirstRowParams labelSwitch
  
  with switch:
    halign = Align.end
    valign = Align.center

  with listBoxRow2:
    append labelCheck
    append check

  setFirstRowParams labelCheck
  
  with check:
    halign = Align.end
    valign = Align.center
    marginStart = 10
    marginEnd = 10
    active = true

  with listBoxRow3:
    append labelImage
    append image

  setFirstRowParams labelImage
  
  with image:
    halign = Align.end
    valign = Align.center
    marginStart = 10
    marginEnd = 10
    opacity = 1
    # setFromIconName ("heart-filled-symbolic")
  # image.fromIconName="heart-filled-symbolic"
  # image.setFromIconName
  result = frame1


proc createListBoxFrame2(): Frame =
  let 
    frame1 = newFrame()
    listBox1 = newListBox()

    listBoxRow1 = newBox(Orientation.horizontal, 0)
    labelScale = newLabel("Scale")
    scale = newScale(Orientation.horizontal)

    listBoxRow2 = newBox(Orientation.horizontal, 0)
    labelSpin = newLabel("Spin")
    spin = newSpinButton(newAdjustment(50, 0, 100, 1, 10), 10, 0)

    listBoxRow3 = newBox(Orientation.horizontal, 0)
    labelDropDown = newLabel("DropDown")
    dropDown = newDropDownFromStrings(["Nim", "Vala", "Rust", "Python"])

    listBoxRow4 = newBox(Orientation.horizontal, 0)
    labelEntry = newLabel("Entry")
    entry = newEntry()

  frame1.child = listBox1

  with listBox1:
    selectionMode = SelectionMode.none
    showSeparators = true
    setCssClasses("rich-list")
    append listBoxRow1
    append listBoxRow2
    append listBoxRow3

  with listBoxRow1:
    append labelScale
    append scale

  setFirstRowParams labelScale
  
  
  with scale:
    halign = Align.end
    valign = Align.center
    drawValue = false
    vexpand = true
    hexpand = true
    # width = 150
    

  with listBoxRow2:
    append labelSpin
    append spin

  setFirstRowParams labelSpin
  
  with spin:
    halign = Align.end
    valign = Align.center

  with listBoxRow3:
    append labelDropDown
    append dropDown

  setFirstRowParams labelDropDown
  
  with dropDown:
    halign = Align.end
    valign = Align.center

  with listBoxRow4:
    append labelEntry
    append entry

  setFirstRowParams labelEntry

  with entry:
    halign = Align.end
    valign = Align.center
    placeholderText = "Placeholder Text"
  
  result = frame1


proc activate(app: gtk4.Application) =
  let 
    window = newApplicationWindow(app)

    scrolledWindow = newScrolledWindow()
    viewPort = newViewport()
    mainBox = newBox(Orientation.vertical, 10)


    labelGroup1 = newLabel("Group 1")
    labelGroup2 = newLabel("Group 2")

  with scrolledWindow: 
    hexpand = true 
    vexpand = false
    minContentHeight = 200
    child = viewPort

  viewPort.scrollToFocus = true
  viewPort.child = mainBox

  with mainBox:
    marginStart = 60
    marginEnd = 60
    marginTop = 30
    marginBottom = 30
    append labelGroup1
    append createListBoxFrame1()
    append labelGroup2
    append createListBoxFrame2()


  
  with labelGroup1:
    xalign = 0
    marginBottom = 10
    setCssClasses("title-2")

  with labelGroup2:
    xalign = 0
    marginBottom = 10
    setCssClasses("title-2")
  
 

  with window :
    title = "ListBox GTK 4 example"
    defaultSize = (400, 600)
    setChild scrolledWindow
    show


proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

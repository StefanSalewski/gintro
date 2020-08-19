# https://gitlab.gnome.org/GNOME/libhandy/-/blob/master/examples/example.py
# nim c --gc:arc handy.nim
import gintro/[gtk, gobject, handy]

proc main =
  gtk.init()
  handy.init()
  let window = gtk.newWindow()
  let vbox = newBox(Orientation.vertical, 0)
  let entry = newEntry()
  let keypad = handy.newKeypad(symbolsVisible = true, lettersVisible = true)
  window.title = "Keypad Example with Nim"
  vbox.add(entry) # widget to show dialed number
  vbox.add(keypad)
  vbox.setHalign(gtk.Align.center)
  vbox.setValign(gtk.Align.center)
  vbox.marginStart = 18
  vbox.marginEnd = 18
  vbox.marginTop = 18
  vbox.marginBottom = 18
  vbox.spacing = 18
  keypad.setRowSpacing(6)
  keypad.setColumnSpacing(6)
  keypad.setEntry(entry) # attach the entry widget
  window.connect("destroy", gtk.mainQuit)
  window.add(vbox)
  window.showAll()
  gtk.main()
  
main()


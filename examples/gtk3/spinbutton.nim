##  https://github.com/GNOME/gtk/blob/gtk-3-24/tests/testspinbutton.c
##  gcc `pkg-config gtk+-3.0 --cflags` spinbutton.c -o spinbutton `pkg-config --libs gtk+-3.0`

import gintro/[gtk, gdk, glib, gobject]

var numWindows: int

proc onDeleteEvent(w: gtk.Window; event: gdk.Event): bool =
  dec(numWindows)
  if numWindows == 0:
    gtk.mainQuit()
  return EVENT_PROPAGATE # false

proc prepareWindowForOrientation(orientation: gtk.Orientation) =
  let window = newWindow()
  discard connect(window, "delete_event", onDeleteEvent)
  let mainbox = gtk.newBox(if orientation == gtk.Orientation.horizontal: Orientation.vertical else: Orientation.horizontal, 2)
  window.add(mainbox)
  let wrapButton = newToggleButtonWithLabel("Wrap")
  mainbox.add(wrapButton)
  var max = 0
  while max <= 999999999:
    let adj = newAdjustment(max.float, 1, max.float, 1, (max.float + 1) * 0.1, 0)
    let spin = newSpinButton(adj, 1, 0)
    spin.setOrientation(orientation)
    spin.setHalign(gtk.Align.center)
    discard bindProperty(wrapButton, "active", spin, "wrap", {BindingFlag.syncCreate})
    let hbox = newBox(gtk.Orientation.horizontal, 2)
    hbox.packStart(spin, false, false, 2)
    mainbox.add(hbox)
    max = max * 10 + 9
  window.showAll()
  inc(numWindows)

proc main =
  gtk.init()
  prepareWindowForOrientation(gtk.Orientation.horizontal)
  prepareWindowForOrientation(gtk.Orientation.vertical)
  gtk.main()

main()


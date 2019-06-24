# gsettings.nim -- basic use of gsettings
# nim c gsettings.nim
# https://blog.gtk.org/2017/05/01/first-steps-with-gsettings/
import gintro/[gtk, glib, gobject, gio]

# unused
proc toggle(b: CheckButton) = 
  echo b.active
  let s = newSettings("org.gnome.Recipes")
  discard s.setBoolean("like-nim", b.active)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3, Nim and GSettings"
  window.defaultSize = (200, 200)
  let b = newCheckButton()
  b.halign = Align.center
  b.label = "I like Nim"
  #b.connect("toggled", toggle) # we don't need this for plain binding!
  let s = newSettings("org.gnome.Recipes")
  if s.getBoolean("like-nim"):
    echo "I like Nim language"
  `bind`(s, "like-nim", b, "active", {SettingsBindFlag.get, SettingsBindFlag.set})
  window.add(b)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

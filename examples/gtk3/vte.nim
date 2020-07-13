# https://vincent.bernat.im/en/blog/2017-write-own-terminal
import gintro/[gtk, glib, gobject, gio, vte]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "GTK3 & Nim"
  window.defaultSize = (600, 200)
  let terminal = newTerminal()
  let environ = getEnviron()
  let command = environ.environGetenv("SHELL")
  var pid = 0
  echo terminal.spawnSync({}, nil, [command], [], {SpawnFlag.leaveDescriptorsOpen}, nil, nil, pid, nil)
  window.add(terminal)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
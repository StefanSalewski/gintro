# nim c t0.nim
import gintro/[gtk, gobject]

proc bye(w: Window) =
  mainQuit()
  echo "Bye..."

proc main =
  gtk.init()
  let window = newWindow()
  window.title = "First Test"
  window.connect("destroy", bye)
  window.showAll
  gtk.main()

main()

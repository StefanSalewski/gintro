import gintro/[gtk4, gobject, gio, adw]
import std/with

const N_PAGES = 5

# & - string concatenation, $ - to_stirng()
proc createPage(num: int): Widget = newLabel("Some widget here №" & $num & "   ")

proc setupCarousel(): Carousel =
  result = newCarousel()
  result.interactive = true
  result.allowMouseDrag = true
  for i in 0 ..< N_PAGES:
    result.prepend (createPage (i))

proc appActivate(app: Application) =
  let 
    window = adw.newApplicationWindow(app)
    carousel = setupCarousel()
    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)

  header.showStartTitleButtons = true
  carousel.vexpand = true

  with mainBox:
    append header
    append carousel

  with window:
    title = "GTK4 & Nim"
    defaultSize = (200, 200)
    child = mainBox
    show()

proc initAdw(app: Application) = 
  adw.init()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("startup", initAdw)
  app.connect("activate", appActivate)
  discard run(app)

main()

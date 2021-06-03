import gintro/[gtk4, gobject, gio, adw]
import std/with

const N_PAGES = 10

# & - string concatenation, $ - to_stirng()
# proc createPage(num: int): Widget = newLabel("Some widget here №" & $num & "   ")
proc createPage(num: int): Widget = adw.newAvatar(400, $num, true)


proc setupCarousel(): Carousel =
  result = newCarousel()
  result.interactive = true
  result.allowMouseDrag = true
  for i in 0 ..< N_PAGES:
    result.append (createPage (i))

proc appActivate(app: Application) =
  let 
    window = adw.newApplicationWindow(app)
    carousel = setupCarousel()
    carouselIndicatorDots = newCarouselIndicatorDots()
    carouselIndicatorLines = newCarouselIndicatorLines()
    
    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)

  header.showStartTitleButtons = true
  carousel.allowLongSwipes = true
  carousel.vexpand = true
  carouselIndicatorDots.carousel = carousel
  carouselIndicatorLines.carousel = carousel
  with mainBox:
    append header
    append carousel
    append carouselIndicatorDots
    append carouselIndicatorLines

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

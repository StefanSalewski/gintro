# https://lists.cairographics.org/archives/cairo/2016-October/027791.html
# Nim version of that plain cairo animation example

import gintro/[gtk, glib, gobject, gio, cairo]
import math

const
  NumPoints = 1000
  Period = 100.0

proc invalidateCb(w: Widget): bool =
  queueDraw(w)
  return SOURCE_CONTINUE

proc sineToPoint(x, width, height: int): float =
  math.sin(x.float * math.TAU / Period) * height.float * 0.5 + height.float * 0.5

proc drawingAreaDrawCb(widget: DrawingArea; context: Context): bool =
  var redrawNumber {.global.} : int
  let width = getAllocatedWidth(widget)
  let height = getAllocatedHeight(widget)
  for i in 1 ..< NumPoints:
    context.lineTo(i.float , sineToPoint(i + redrawNumber, width, height))
  context.stroke
  inc(redrawNumber)
  return true # TRUE to stop other handlers from being invoked for the event. FALSE to propagate the event further.

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Drawing example"
  window.defaultSize = (400, 400)
  let drawingArea = newDrawingArea()
  window.add(drawingArea)
  showAll(window)
  discard timeoutAdd(1000 div 60, invalidateCb, drawingArea)
  connect(drawingArea, "draw", drawingAreaDrawCb)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()


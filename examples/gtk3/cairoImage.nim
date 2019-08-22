# https://discourse.gnome.org/t/proper-zoom-pan-image-approach-for-large-images/1497/6
# Nim version of the C example of C. Eric Cashon
import gintro/[gtk, gobject, glib, cairo]
from math import TAU
import strutils

const
  Width = 5000
  Height = 5000
  CFormat = cairo.Format.argb32

var
  Key: cairo.UserDataKey
  translateX: float
  translateY: float
  scale = 1.0
  ## Store data from file.
  bigSurfaceData*: ptr cuchar = nil

proc translateXSpinChanged(spinButton: SpinButton; data: DrawingArea) =
  translateX = spinButton.value
  data.queueDraw

proc translateYSpinChanged(spinButton: SpinButton; data: DrawingArea) =
  translateY = spinButton.getValue
  data.queueDraw

proc scaleSpinChanged(spinButton: SpinButton; data: DrawingArea) =
  scale = spinButton.value
  data.queueDraw

proc saveBigSurface =
  ## Use gdk_cairo_surface_create_from_pixbuf() to read in a pixbuf. Try a test surface here.
  let bigSurface = imageSurfaceCreate(CFormat, Width, Height)
  let cr = newContext(bigSurface)
  ## Paint the background.
  cr.setSource(1, 1, 1)
  cr.paint
  ## Draw a circle.
  cr.setSource(0, 0, 1)
  cr.arc(250, 250, 50, 0, math.TAU)
  cr.fill
  ## Draw some test grid lines.
  cr.setSource(0, 1, 0)
  for i in countup(0, 4900, 100):
    cr.moveTo(0, i.float)
    cr.lineTo(5000, i.float)
    cr.stroke
  for i in countup(0, 4900, 100):
    cr.moveTo(i.float, 0)
    cr.lineTo(i.float, 5000)
    cr.stroke
  cr.setSource(0, 0, 1)
  cr.setLineWidth(10)
  for i in 0 ..< 10:
    cr.moveTo(0, i.float * 500.0)
    cr.lineTo(5000, i.float * 500.0)
    cr.stroke
  for i in 0 ..< 10:
    cr.moveTo(i.float * 500.0, 0)
    cr.lineTo(i.float * 500.0, 5000)
    cr.stroke
  ## Outside box.
  cr.setLineWidth(20)
  cr.setSource(1, 0, 1)
  cr.rectangle(0, 0, 5000, 5000)
  cr.stroke
  ## Save surface data to file.
  let f: File = open("big_surface.s", fmWrite)
  let p: ptr cuchar = cairo_image_surface_get_data(bigSurface.impl)
  let len = writeBuffer(f, p, cairo_format_stride_for_width(CFormat, Width) * Height)
  echo("write $1\n" % $len)
  close(f)

proc myDealloc(data: pointer) {.cdecl.} =
  system.dealloc(data)

proc getBigSurface(): Surface =
  let f: File = open("big_surface.s", fmRead)
  # setFilePos(f, 0)
  # https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-format-stride-for-width
  let stride = cairo_format_stride_for_width(CFormat, Width)
  bigSurfaceData = cast[ptr cuchar](malloc((stride * Height).uint64))
  var len = readBuffer(f, bigSurfaceData, stride * Height)
  echo("read $1" % $len)
  close(f)
  let bigSurface: Surface = new Surface # this is a temporary fix, we will support this later in cairo modul
  bigSurface.impl = cairo_image_surface_create_for_data(bigSurfaceData, CFormat, Width, Height, stride)
  discard setUserData(bigSurface, addr(Key), bigSurfaceData, myDealloc) # automatic deallocation
  # flush(bigSurface)
  echo("open $1" % bigSurface.status.statusToString)
  return bigSurface

proc daDrawing*(da: DrawingArea; cr: Context; bigSurface: Surface): bool =
  var
    width = da.getAllocatedWidth.float
    height = da.getAllocatedHeight.float
    originX = translateX
    originY = translateY
  ## Some constraints.
  if translateX > 5000.0 - width:
    originX = 5000.0 - width / scale
  if translateY > 5000.0 - height:
    originY = 5000.0 - height / scale
  cr.setSource(0, 0, 0)
  cr.paint
  ## Partition the big surface.
  var littleSurface: Surface = cairo.surfaceCreateForRectangle(bigSurface,
      originX, originY, width / scale, height / scale)
  cr.scale(scale, scale)
  cr.setSourceSurface(littleSurface, 0, 0)
  setFilter(getSource(cr), cairo.Filter.bilinear)
  cr.paint
  return true

proc bye(w: Window) =
  mainQuit()
  echo "Bye..."

proc main =
  gtk.init()
  let window = newWindow()
  window.setTitle("Big Surface2")
  window.setDefaultSize(500, 500)
  window.setPosition(gtk.WindowPosition.center)
  window.connect("destroy", bye)
  ## Get a test surface.
  saveBigSurface()
  let bigSurface = getBigSurface()
  let da: DrawingArea = newDrawingArea()
  da.setHexpand
  da.setVexpand
  da.connect("draw", daDrawing, bigSurface)
  let
    translateXAdj = newAdjustment(0, 0, 5000, 20, 0, 0)
    translateYAdj = newAdjustment(0, 0, 5000, 20, 0, 0)
    scaleAdj = newAdjustment(1, 1, 5, 0.1, 0, 0)
    translateXLabel = newLabel("translate x")
    translateXSpin= newSpinButton(translateXAdj, 50, 1)
  connect(translateXSpin, "value-changed", translateXSpinChanged, da)
  let translateYLabel = newLabel("translate y")
  let translateYSpin = newSpinButton(translateYAdj, 50, 1)
  connect(translateYSpin, "value-changed", translateYSpinChanged, da)
  let scaleLabel = newLabel("Scale")
  let scaleSpin = newSpinButton(scaleAdj, 0.2, 1)
  connect(scaleSpin, "value-changed", scaleSpinChanged, da)
  let grid = newGrid()
  grid.attach(da, 0, 0, 3, 1)
  grid.attach(translateXLabel, 0, 1, 1, 1)
  grid.attach(translateYLabel, 1, 1, 1, 1)
  grid.attach(scaleLabel, 2, 1, 1, 1)
  grid.attach(translateXSpin, 0, 2, 1, 1)
  grid.attach(translateYSpin, 1, 2, 1, 1)
  grid.attach(scaleSpin, 2, 2, 1, 1)
  add(window, grid)
  showAll(window)
  gtk.main()

main()


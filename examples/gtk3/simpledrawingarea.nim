# Plain demo for zooming, panning, scrolling with GTK DrawingArea
# (c) S. Salewski, 21-DEC-2010 (initial Ruby version)
# Nim version April 2019
# License MIT

# This is a simplified example, where all the drawing is done in
# the draw callback function. No separate paint proc with own buffer surface.

# https://discourse.gnome.org/t/problem-with-gtkscrollbar-gtk-window-resize-and-gtk-adjustment-set-value/1081

import gintro/[gtk, gdk, glib, gobject, gio, cairo]

const
  ZoomFactorMouseWheel = 1.1
  ZoomFactorSelectMax = 10 # ignore zooming in tiny selection
  ZoomNearMousepointer = true # mouse wheel zooming -- to mouse-pointer or center
  SelectRectCol = [0.0, 0, 1, 0.5] # blue with transparency

discard """
Zooming, scrolling, panning...

|-------------------------|
|<-------- A ------------>|
|                         |
|  |---------------|      |
|  | <---- a ----->|      |
|  |    visible    |      |
|  |---------------|      |
|                         |
|                         |
|-------------------------|

a is the visible, zoomed in area == darea.allocatedWidth
A is the total data range
A/a == userZoom >= 1
For horizontal adjustment we use
hadjustment.setUpper(darea.allocatedWidth * userZoom) == A
hadjustment.setPageSize(darea.allocatedWidth) == a
So hadjustment.value == left side of visible area

Initially, we set userZoom = 1, scale our data to fit into darea.allocatedWidth
and translate the origin of our data to (0, 0)

Zooming: Mouse wheel or selecting a rectangle with left mouse button pressed
Scrolling: Scrollbars
Panning: Moving mouse while middle mouse button pressed
"""

# drawing area and scroll bars in 2x2 grid (PDA == Plain Drawing Area)

type
  PosAdj = ref object of Adjustment
    handlerID: uint64

proc newPosAdj: PosAdj =
  initAdjustment(result, 0, 0, 1, 1, 10, 1)

type
  PDA_Data* = object
    draw*: proc (cr: Context)
    extents*: proc (): tuple[x, y, w, h: float]
    windowSize*: tuple[w, h: int]

type
  PDA = ref object of Grid
    zoomNearMousepointer: bool
    selecting: bool
    userZoom: float
    darea: DrawingArea
    hadjustment: PosAdj
    vadjustment: PosAdj
    hscrollbar: Scrollbar
    vscrollbar: Scrollbar
    fullScale: float
    dataX: float
    dataY: float
    dataWidth: float
    dataHeight: float
    lastButtonDownPosX: float
    lastButtonDownPosY: float
    lastMousePosX: float
    lastMousePosY: float
    zoomRectX1: float
    zoomRectY1: float
    oldSizeX: int
    oldSizeY: int
    drawWorld: proc (cr: Context)
    extents: proc (): tuple[x, y, w, h: float]

proc drawingAreaDrawCb(darea: DrawingArea; cr: Context; this: PDA): bool =
  cr.save
  cr.translate(this.hadjustment.upper * 0.5 - this.hadjustment.value, # our origin is the center
    this.vadjustment.upper * 0.5 - this.vadjustment.value)
  cr.scale(this.fullScale * this.userZoom, this.fullScale * this.userZoom)
  cr.translate(-this.dataX - this.dataWidth * 0.5, -this.dataY - this.dataHeight * 0.5)
  this.drawWorld(cr) # call the user provided drawing function
  cr.restore
  if this.selecting:
    cr.rectangle(this.lastButtonDownPosX, this.lastButtonDownPosY,
      this.zoomRectX1 - this.lastButtonDownPosX, this.zoomRectY1 - this.lastButtonDownPosY)
    cr.setSource(0, 0, 1, 0.5) # SELECT_RECT_COL) # 0, 0, 1, 0.5
    cr.fillPreserve
    cr.setSource(0, 0, 0)
    cr.setLineWidth(2)
    cr.stroke
  return gdk.EVENT_STOP # EVENT_PROPAGATE
  #return true # TRUE to stop other handlers from being invoked for the event. FALSE to propagate the event further.

# clamp to correct values, 0 <= value <= (adj.upper - adj.pageSize), block calling onAdjustmentEvent()
proc updateVal(adj: PosAdj; d: float) =
  adj.signalHandlerBlock(adj.handlerID)
  adj.setValue(max(0.0, min(adj.value + d, adj.upper - adj.pageSize)))
  adj.signalHandlerUnblock(adj.handlerID)

proc updateAdjustments(this: PDA; dx, dy: float) =
  this.hadjustment.setUpper(this.darea.allocatedWidth.float * this.userZoom)
  this.vadjustment.setUpper(this.darea.allocatedHeight.float * this.userZoom)
  this.hadjustment.setPageSize(this.darea.allocatedWidth.float)
  this.vadjustment.setPageSize(this.darea.allocatedHeight.float)
  updateVal(this.hadjustment, dx)
  updateVal(this.vadjustment, dy)

proc dareaConfigureCallback(darea: DrawingArea; event: EventConfigure; this: PDA): bool =
  (this.dataX, this.dataY, this.dataWidth,
    this.dataHeight) = this.extents() # query user defined size
  this.fullScale = min(this.darea.allocatedWidth.float / this.dataWidth,
      this.darea.allocatedHeight.float / this.dataHeight)
  return gdk.EVENT_STOP

proc hscrollbarSizeAllocateCallback(s: Scrollbar; r: gdk.Rectangle; pda: PDA) =
  pda.hadjustment.setUpper(r.width.float * pda.userZoom)
  pda.hadjustment.setPageSize(r.width.float)
  if pda.oldSizeX != 0: # this fix is not exact, as fullScale can ...
    updateVal(pda.hadjustment, (r.width - pda.oldSizeX).float * 0.5)
  pda.oldSizeX = r.width

proc vscrollbarSizeAllocateCallback(s: Scrollbar; r: gdk.Rectangle; pda: PDA) =
  pda.vadjustment.setUpper(r.height.float * pda.userZoom)
  pda.vadjustment.setPageSize(r.height.float)
  if pda.oldSizeY != 0: # ... change when window is rezized. But it's good enough!
    updateVal(pda.vadjustment, (r.height - pda.oldSizeY).float * 0.5)
  pda.oldSizeY = r.height

proc updateAdjustmentsAndPaint(this: PDA; dx, dy: float) =
  this.updateAdjustments(dx, dy)
  this.darea.queueDrawArea(0, 0, this.darea.allocatedWidth, this.darea.allocatedHeight)

# event coordinates to user space
proc getUserCoordinates(this: PDA; eventX, eventY: float): (float, float) =
  ((eventX - this.hadjustment.upper * 0.5 + this.hadjustment.value) / (
      this.fullScale * this.userZoom) + this.dataX + this.dataWidth * 0.5,
   (eventY - this.vadjustment.upper * 0.5 + this.vadjustment.value) / (
       this.fullScale * this.userZoom) + this.dataY + this.dataHeight * 0.5)

proc onMotion(darea: DrawingArea; event: EventMotion; this: PDA): bool =
  let state = getState(event)
  let (x, y) = event.getCoords
  if state.contains(button1): # selecting
    this.selecting = true
    this.zoomRectX1 = x
    this.zoomRectY1 = y
    this.darea.queueDrawArea(0, 0, this.darea.allocatedWidth, this.darea.allocatedHeight)
  elif button2 in state: # panning
    this.updateAdjustmentsAndPaint(this.lastMousePosX - x, this.lastMousePosY - y)
  else:
    return gdk.EVENT_PROPAGATE
  this.lastMousePosX = x
  this.lastMousePosY = y
  return gdk.EVENT_STOP
  #event.request # request more motion events ?

# zooming with mouse wheel -- data near mouse pointer should not move if possible!
# hadjustment.value + event.x is the position in our zoomed_in world, (userZoom / z0 - 1)
# is the relative movement caused by zooming
# In other words, this is the delta-move d of a point at position P from zooming:
# d = newPos - P = P * scale - P = P * (z/z0) - P = P * (z/z0 - 1). We have to compensate for this d.
proc scrollEvent(darea: DrawingArea; event: EventScroll; this: PDA): bool =
  let z0 = this.userZoom
  case getScrollDirection(event)
  of ScrollDirection.up:
    this.userZoom *= ZoomFactorMouseWheel
  of ScrollDirection.down:
    this.userZoom /= ZoomFactorMouseWheel
    if this.userZoom < 1:
      this.userZoom = 1
  else:
    return gdk.EVENT_PROPAGATE
  if this.zoomNearMousepointer:
    let (x, y) = event.getCoords
    this.updateAdjustmentsAndPaint((this.hadjustment.value + x) * (this.userZoom / z0 - 1),
      (this.vadjustment.value + y) * (this.userZoom / z0 - 1))
  else: # zoom to center
    this.updateAdjustmentsAndPaint((this.hadjustment.value +
        this.darea.allocatedWidth.float * 0.5) * (this.userZoom / z0 - 1),
        (this.vadjustment.value + this.darea.allocatedHeight.float * 0.5) * (this.userZoom / z0 - 1))
  return gdk.EVENT_STOP

proc buttonPressEvent(darea: DrawingArea; event: EventButton; this: PDA): bool =
  var (x, y) = event.getCoords
  this.lastMousePosX = x
  this.lastMousePosY = y
  this.lastButtonDownPosX = x
  this.lastButtonDownPosY = y
  echo "buttonPressEvent", x, " ", y
  (x, y) = this.getUserCoordinates(x, y)
  echo "User coordinates: ", x, ' ', y, "\n" # to verify getUserCoordinates()
  return gdk.EVENT_STOP

# zoom into selected rectangle and center it
# math: we first center the selection rectangle, and then compensate for translation due to scale
proc buttonReleaseEvent(darea: DrawingArea; event: EventButton; this: PDA): bool =
  let (x, y) = event.getCoords
  let b = getButton(event)
  if b == 1:
    this.selecting = false
    let z1 = min(this.darea.allocatedWidth.float / (this.lastButtonDownPosX - x).abs,
      this.darea.allocatedHeight.float / (this.lastButtonDownPosY - y).abs)
    if z1 < ZoomFactorSelectMax: # else selection rectangle will persist, we may output a message...
      this.userZoom *= z1
      this.updateAdjustmentsAndPaint(
        ((x + this.lastButtonDownPosX) * z1 - this.darea.allocatedWidth.float) * 0.5 + this.hadjustment.value * (z1 - 1),
        ((y + this.lastButtonDownPosY) * z1 - this.darea.allocatedHeight.float) * 0.5 + this.vadjustment.value * (z1 - 1))
    return gdk.EVENT_STOP
  return gdk.EVENT_PROPAGATE
 
proc onAdjustmentEvent(this: PosAdj; pda: PDA) =
  pda.darea.queueDrawArea(0, 0, pda.darea.allocatedWidth, pda.darea.allocatedHeight)

proc newPDA: PDA =
  initGrid(result)
  let da = newDrawingArea()
  result.darea = da
  da.setHExpand
  da.setVExpand
  da.connect("draw", drawingAreaDrawCb, result)
  da.connect("configure-event", dareaConfigureCallback, result)
  da.addEvents({EventFlag.buttonPress, EventFlag.buttonRelease,
      EventFlag.scroll, button1Motion, button2Motion, pointerMotionHint})
  da.connect("motion-notify-event", onMotion, result)
  da.connect("scroll_event", scrollEvent, result)
  da.connect("button_press_event", buttonPressEvent, result)
  da.connect("button_release_event", buttonReleaseEvent, result)
  result.zoomNearMousepointer = ZoomNearMousepointer # mouse wheel zooming
  result.userZoom = 1.0
  result.hadjustment = newPosAdj()
  result.hadjustment.handlerID = result.hadjustment.connect("value-changed", onAdjustmentEvent, result)
  result.vadjustment = newPosAdj()
  result.vadjustment.handlerID = result.vadjustment.connect("value-changed", onAdjustmentEvent, result)
  result.hscrollbar = newScrollbar(Orientation.horizontal, result.hadjustment)
  result.vscrollbar = newScrollbar(Orientation.vertical, result.vadjustment)
  result.hscrollbar.setHExpand
  result.vscrollbar.setVExpand
  result.hscrollbar.connect("size-allocate", hscrollbarSizeAllocateCallback, result)
  result.vscrollbar.connect("size-allocate", vscrollbarSizeAllocateCallback, result)
  result.attach(result.darea, 0, 0, 1, 1)
  result.attach(result.vscrollbar, 1, 0, 1, 1)
  result.attach(result.hscrollbar, 0, 1, 1, 1)

proc appStartup(app: Application) =
  echo "appStartup"

proc appActivate(app: Application; initData: PDA_Data) =
  let window = newApplicationWindow(app)
  window.title = "Drawing example"
  # window.defaultSize = initData.windowSize
  window.defaultSize = (initData.windowSize[0], initData.windowSize[1])
  let pda = newPDA()
  pda.drawWorld = initData.draw
  pda.extents = initData.extents
  window.add(pda)
  showAll(window)

proc newDisplay*(initData: PDA_Data) =
  let app = newApplication("org.gtk.example")
  connect(app, "startup", appStartup)
  connect(app, "activate", appActivate, initData)
  discard run(app)

when isMainModule:

  const # arbitrary locations for our data
    DataX = 150.0
    DataY = 250.0
    DataWidth = 200.0
    DataHeight = 120.0

  # we need two user defined functions -- one gives the extent of the graphics,
  # and the other does the cairo drawing using a cairo context.

  # bounding box of user data -- x, y, w, h -- top left corner, width, height
  proc worldExtents(): (float, float, float, float) =
    (DataX, DataY, DataWidth, DataHeight) # current extents of our user world

  # draw to cairo context
  proc drawWorld(cr: cairo.Context) =
    cr.setSource(1, 1, 1)
    cr.paint
    cr.setSource(0, 0, 0)
    cr.setLineWidth(2)
    var i = 0.0
    while min(DataWidth - 2 * i, DataHeight - 2 * i) > 0:
      cr.rectangle(DataX + i, DataY + i, DataWidth - 2 * i, DataHeight - 2 * i)
      i += 10
    cr.stroke

  proc test =
    let data = PDA_Data(draw: drawWorld, extents: worldExtents, windowSize: (800, 600))
    newDisplay(data)

  test() # 310 lines

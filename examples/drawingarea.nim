# Plain demo for zooming, panning, scrolling with GTK DrawingArea
# (c) S. Salewski, 21-DEC-2010 (initial Ruby version)
# Nim version April 2019 -- well first draft :-)
# License MIT

import gintro/[gtk, gdk, glib, gobject, gio, cairo]

const
  DataX = 150.0
  DataY = 250.0
  DataWidth = 200.0
  DataHeight = 120.0

# The following two functions are intended to be user defined -- we have still
# to investigate how to do that best.

# bounding box of user data -- x, y, w, h -- top left corner, width, height
proc getWorldExtends(): (float, float, float, float) =
  (DataX, DataY, DataWidth, DataHeight) # current extents of our user world 

# draw to cairo context
proc drawWorld(cr: cairo.Context) =
  cr.setSource(1, 1, 1)
  cr.paint
  cr.setSource(0, 0, 0)
  cr.setLineWidth(2)
  cr.rectangle(DataX, DataY, DataWidth, DataHeight)
  var i = 10.0
  while true:
    if min(DataWidth - 2.0 * i, DataHeight - 2.0 * i) <= 0:
      break
    cr.rectangle(DataX + i, DataY + i, DataWidth - 2.0 * i,
        DataHeight - 2.0 * i)
    i += 10.0
  cr.stroke

const

  ZOOM_FACTOR_MOUSE_WHEEL = 1.1
  ZOOM_FACTOR_SELECT_MAX = 10 # ignore zooming in tiny selection
  ZOOM_NEAR_MOUSEPOINTER = true # mouse wheel zooming -- to mousepointer or center
  SELECT_RECT_COL = [0.0, 0, 1, 0.5] # blue with transparency

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

# drawing area and scroll bars in 2x2 table (PDA == Plain Drawing Area)

type
  PosAdj = ref object of Adjustment
    handlerID: uint64

proc newPosAdj: PosAdj =
  initAdjustment(result, 0, 0, 1, 1, 10, 1)

type
  PDA = ref object of Grid
    zoomNearMousepointer: bool
    selecting: bool
    userZoom: float
    surf: Surface
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

proc drawingAreaDrawCb(darea: DrawingArea; cr: Context; this: PDA): bool =
  if this.surf.isNil: return
  cr.setSource(patternCreateForSurface(this.surf))
  cr.paint
  if this.selecting:
    cr.rectangle(this.lastButtonDownPosX, this.lastButtonDownPosY,
                 this.zoomRectX1 - this.lastButtonDownPosX,
                     this.zoomRectY1 - this.lastButtonDownPosY)
    cr.setSource(0, 0, 1, 0.5) # SELECT_RECT_COL) # 0, 0, 1, 0.5
    cr.fillPreserve
    cr.setSource(0, 0, 0)
    cr.setLineWidth(2)
    cr.stroke
  return true # TRUE to stop other handlers from being invoked for the event. FALSE to propagate the event further.

# clamp to correct values, 0 <= value <= (adj.upper - adj.pageSize), block calling onAdjustmentEvent()
proc updateVal(adj: PosAdj; d: float) =
  adj.signalHandlerBlock(adj.handlerID)
  adj.setValue(max(0.0, min(adj.value + d, adj.upper - adj.pageSize)))
  adj.signalHandlerUnblock(adj.handlerID)

proc updateAdjustments(this: PDA; dx, dy: float) =
  this.hadjustment.setUpper(this.darea.allocatedWidth.float * this.userZoom)
  this.vadjustment.setUpper(this.darea.allocatedHeight.float *
      this.userZoom)
  this.hadjustment.setPageSize(this.darea.allocatedWidth.float)
  this.vadjustment.setPageSize(this.darea.allocatedHeight.float)
  updateVal(this.hadjustment, dx)
  updateVal(this.vadjustment, dy)

# Maybe we should fix this for latest GTK3, see
# https://developer.gnome.org/gdk3/stable/gdk3-Cairo-Interaction.html
# so use gdk_drawing_context_get_cairo_context ()
# or maybe even better do all drwing from within "draw" callback?
proc paint(this: PDA) =
  if this.surf != nil:
    cairosurfaceDestroy(this.surf.impl) # we may have to fix that later for automatically destroy
  this.surf = this.darea.window.createSimilarSurface(Content.color,
      this.darea.allocatedWidth, this.darea.allocatedHeight)
  let cr = newContext(this.surf)
  cr.translate(this.hadjustment.upper * 0.5 - this.hadjustment.value, # our origin is the center
    this.vadjustment.upper * 0.5 - this.vadjustment.value)
  cr.scale(this.fullScale * this.userZoom, this.fullScale * this.userZoom)
  cr.translate(-this.dataX - this.dataWidth * 0.5,
      -this.dataY - this.dataHeight * 0.5)
  drawWorld(cr) # call the user provided drawing fonction

proc dareaConfigureCallback(darea: DrawingArea; event: EventConfigure;
    this: PDA): bool =
  this.updateAdjustments(0, 0)
  (this.dataX, this.dataY, this.dataWidth,
    this.dataHeight) = getWorldExtends() # query user defined size
  this.fullScale = min(this.darea.allocatedWidth.float / this.dataWidth,
      this.darea.allocatedHeight.float / this.dataHeight)
  this.paint

proc updateAdjustmentsAndPaint(this: PDA; dx, dy: float) =
  this.updateAdjustments(dx, dy)
  this.paint
  this.darea.queueDrawArea(0, 0, this.darea.allocatedWidth,
      this.darea.allocatedHeight)

# event coordinates to user space
proc getUserCoordinates(this: PDA; eventX, eventY: float): (float, float) =
  ((eventX - this.hadjustment.upper * 0.5 + this.hadjustment.value) / (
      this.fullScale * this.userZoom) + this.dataX + this.dataWidth * 0.5,
   (eventY - this.vadjustment.upper * 0.5 + this.vadjustment.value) / (
       this.fullScale * this.userZoom) + this.dataY + this.dataHeight * 0.5)

proc onMotion(darea: DrawingArea; event: EventMotion; this: PDA): bool =
  let state = getState(event)
  let (x, y) = event.getCoords
  #(x, y) = this.getUserCoordinates(x, y)
  if (state.contains(button1)): # selecting
    this.selecting = true
    this.zoomRectX1 = x
    this.zoomRectY1 = y
    this.darea.queueDrawArea(0, 0, this.darea.allocatedWidth,
        this.darea.allocatedHeight)
  elif button2 in state: # panning
    this.updateAdjustmentsAndPaint(this.lastMousePosX - x,
        this.lastMousePosY - y)
  this.lastMousePosX = x
  this.lastMousePosY = y
  #event.request # request more motion events ?

# zooming with mouse wheel -- data near mouse pointer should not move if possible!
# hadjustment.value + event.x is the position in our zoomed_in world, (userZoom / z0 - 1)
# is the relative movement caused by zooming
proc scrollEvent(darea: DrawingArea; event: EventScroll; this: PDA): bool =
  let z0 = this.userZoom
  var d = getScrollDirection(event)
  var (x, y) = event.getCoords
  if d == ScrollDirection.up:
    this.userZoom *= ZOOM_FACTOR_MOUSE_WHEEL
  elif d == ScrollDirection.down:
    this.userZoom /= ZOOM_FACTOR_MOUSE_WHEEL
    if (this.userZoom < 1):
      this.userZoom = 1
  if this.zoomNearMousepointer:
    this.updateAdjustmentsAndPaint((this.hadjustment.value + x) * (
        this.userZoom / z0 - 1),
                                 (this.vadjustment.value + y) * (
                                     this.userZoom / z0 - 1))
  else: # zoom to center
    this.updateAdjustmentsAndPaint((this.hadjustment.value +
        this.darea.allocatedWidth.float * 0.5) * (this.userZoom / z0 - 1),
                                 (this.vadjustment.value +
                                     this.darea.allocatedHeight.float * 0.5) * (
                                         this.userZoom / z0 - 1))

proc buttonPressEvent(darea: DrawingArea; event: EventButton;
    this: PDA): bool =
  var (x, y) = event.getCoords
  this.lastMousePosX = x
  this.lastMousePosY = y
  this.lastButtonDownPosX = x
  this.lastButtonDownPosY = y
  echo "buttonPressEvent", x, " ", y
  (x, y) = this.getUserCoordinates(x, y)
  echo "User coordinates: ", x, ' ', y, "\n" # to verify getUserCoordinates()

# zoom into selected rectangle and center it
proc buttonReleaseEvent(darea: DrawingArea; event: EventButton;
    this: PDA): bool =
  var (x, y) = event.getCoords
  var b = getButton(event)
  if b == 1:
    this.selecting = false
    let z1 = min(this.darea.allocatedWidth.float / (
        this.lastButtonDownPosX - x).abs, this.darea.allocatedHeight.float / (
        this.lastButtonDownPosY - y).abs)
    if z1 < ZOOM_FACTOR_SELECT_MAX: # else selection rectangle will persist, we may output a message...
      this.userZoom *= z1
      this.updateAdjustmentsAndPaint(
        ((2 * this.hadjustment.value + x + this.lastButtonDownPosX) * z1 -
            this.darea.allocatedWidth.float) * 0.5 - this.hadjustment.value,
        ((2 * this.vadjustment.value + y + this.lastButtonDownPosY) * z1 -
            this.darea.allocatedHeight.float) * 0.5 - this.vadjustment.value)

proc onAdjustmentEvent(this: PosAdj; pda: PDA) =
  pda.paint
  pda.darea.queueDrawArea(0, 0, pda.darea.allocatedWidth,
      pda.darea.allocatedHeight)

proc newPDA: PDA =
  initGrid(result)
  result.zoomNearMousepointer = ZOOM_NEAR_MOUSEPOINTER # mouse wheel zooming
  result.selecting = false
  result.userZoom = 1.0
  result.surf = nil
  result.darea = newDrawingArea()
  result.darea.setHExpand#(true)
  result.darea.setVExpand#(true)
  result.darea.connect("draw", drawingAreaDrawCb, result)
  result.darea.connect("configure-event", dareaConfigureCallback, result)
  result.darea.addEvents({EventFlag.buttonPress, EventFlag.buttonRelease,
      EventFlag.scroll,
                    EventFlag.button1Motion, EventFlag.button2Motion,
                        EventFlag.pointerMotionHint})
  result.darea.connect("motion-notify-event", onMotion, result)
  result.darea.connect("scroll_event", scrollEvent, result)
  result.darea.connect("button_press_event", buttonPressEvent, result)
  result.darea.connect("button_release_event", buttonReleaseEvent, result)
  result.hadjustment = newPosAdj()
  result.hadjustment.handlerID = result.hadjustment.connect("value-changed",
      onAdjustmentEvent, result)
  result.vadjustment = newPosAdj()
  result.vadjustment.handlerID = result.vadjustment.connect("value-changed",
      onAdjustmentEvent, result)
  result.hscrollbar = newScrollbar(Orientation.horizontal, result.hadjustment)
  result.vscrollbar = newScrollbar(Orientation.vertical, result.vadjustment)
  result.hscrollbar.setHExpand#(true)
  result.vscrollbar.setVExpand#(true)
  result.attach(result.darea, 0, 0, 1, 1)
  result.attach(result.vscrollbar, 1, 0, 1, 1)
  result.attach(result.hscrollbar, 0, 1, 1, 1)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Drawing example"
  window.defaultSize = (400, 400)
  let pda = newPDA()
  window.add(pda)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()

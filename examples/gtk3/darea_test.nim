import gintro/cairo
import drawingarea
from math import PI

proc extents(): (float, float, float, float) =
  (0.0, 0.0, 100.0, 100.0) # ugly float literals

# draw to cairo context
proc draw(cr: cairo.Context) =
  cr.setSource(1, 1, 1) # set background color and paint
  cr.paint
  cr.setSource(0, 0, 0) # forground color
  cr.arc(20, 30, 10, 0, 5) # nearly a circle
  cr.newSubPath # do not join the two arcs
  cr.arc(70, 60, 20, 0, math.PI)
  cr.stroke # finally do it

proc main =
  var data: PDA_Data
  data.draw = draw
  data.extents = extents
  data.windowSize = (800, 600)
  newDisplay(data)

main()

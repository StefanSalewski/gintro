# https://gstreamer.freedesktop.org/documentation/tutorials/basic/hello-world.html?gi-language=c
# nim c gstBasicTutorial1.nim
import gintro/gst

proc main =
  var pipeline: gst.Element
  var bus: gst.Bus
  var msg: gst.Message
  ##  Initialize GStreamer
  gst.init()
  ##  Build the pipeline
  pipeline = gst.parseLaunch("playbin uri=https://www.freedesktop.org/software/gstreamer-sdk/data/media/sintel_trailer-480p.webm")
  ##  Start playing
  discard gst.setState(pipeline, gst.State.playing)
  ##  Wait until error or EOS
  bus = gst.getBus(pipeline)
  msg = gst.timedPopFiltered(bus, gst.Clock_Time_None, {gst.MessageFlag.error, gst.MessageFlag.eos})
  discard gst.setState(pipeline, gst.State.null) # is this necessary?

main()

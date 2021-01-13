##  gcc -Wall appsink-src.c -o appsink-src $(pkg-config --cflags --libs gstreamer-1.0 gstreamer-audio-1.0 gstreamer-app-1.0)
##  GStreamer
##
##  appsink-src.c: example for using appsink and appsrc.
##
##  Copyright (C) 2008 Wim Taymans <wim.taymans@gmail.com>
##

import gintro/[gtk, gst, gstapp, gobject, glib]
from std/os import paramCount, paramStr
from std/strutils import `%`

proc toBoolVal(b: bool): Value =
  let gtype = typeFromName("gboolean")
  discard init(result, gtype)
  setBoolean(result, b)

proc toUIntVal(i: int): Value =
  let gtype = typeFromName("guint")
  discard init(result, gtype)
  setUint(result, i)

##  these are the caps we are going to pass through the appsink and appsrc
const
  audioCaps = "audio/x-raw,format=S16LE,channels=1,rate=8000, layout=interleaved"

type
  ProgramData = ref object
    loop: MainLoop
    source: gst.Element
    sink: gst.Element

##  called when the appsink notifies us that there is a new buffer ready for processing
proc onNewSampleFromSink(elt: AppSink; data: ProgramData): gst.FlowReturn =
  var
    sample: gst.Sample
    appBuffer: gst.Buffer
    buffer: gst.Buffer
    source: gst.Element
  ##  get the sample from appsink
  sample = pullSample(cast[AppSink](elt))
  buffer = sample.getBuffer
  ##  make a copy
  appBuffer = buffer.copy()
  ##  we don't need the appsink sample anymore
  # gst_sample_unref(sample)
  ##  get source an push new buffer
  source = getByName(cast[gst.Bin](data.sink), "testsource")
  result = pushBuffer(cast[AppSrc](source), appBuffer)
  # gst_object_unref(source)

##  called when we get a GstMessage from the source pipeline when we get EOS, we notify the appsrc of it.
#BusFunc* = proc (bus: ptr Bus00; message: ptr Message00; userData: pointer): gboolean {.cdecl.}
proc onSourceMessage(bus: gst.Bus; message: gst.Message; data: ProgramData): bool =
  var source: gst.Element
  var h = message.impl.type
  if h == {MessageFlag.eos}:
    echo("The source got dry")
    source = getByName(cast[gst.Bin](data.sink), "testsource")
    discard endOfStream(cast[AppSrc](source))
    # gst_object_unref(source)
  elif h == {MessageFlag.error}:
    echo("Received error")
    glib.quit(data.loop)
  else:
    discard
  return true

##  called when we get a GstMessage from the sink pipeline when we get EOS, we
##  exit the mainloop and this testapp.
proc onSinkMessage(bus: gst.Bus; message: gst.Message; data: ProgramData): bool =
  var h = message.impl.type
  if h == {MessageFlag.eos}:
    echo("Finished playback")
    glib.quit(data.loop)
  elif h == {MessageFlag.error}:
    echo("Received error")
    glib.quit(data.loop)
  else:
    discard
  return true

proc main =
  ##  Parse arguments
  let argc = paramCount() + 1
  var argv = newSeq[string](argc)
  for i in 0 ..< argc:
    argv[i] = paramStr(i)

  var
    filename: string
    data: ProgramData
    str: string
    bus: gst.Bus
    testsink: gstApp.AppSink
    testsource: gst.Element

  gst.init()
  if argc == 2:
    filename = argv[1]
  else:
    filename = "/usr/share/sounds/ekiga/ring.wav"
  if not fileTest(filename, FileTest.exists):
    echo("File $1 does not exist" % [filename])
    # g_free(filename)
    quit(QuitFailure)
  data = new ProgramData #g_new0(ProgramData, 1)
  data.loop = glib.newMainLoop(nil, false)
  ##  setting up source pipeline, we read from a file and convert to our desired caps.
  str = "filesrc location=\"$1\" ! wavparse ! audioconvert ! audioresample ! appsink caps=\"$2\" name=testsink" % [filename, audioCaps]
  #g_free(filename)
  data.source = gst.parseLaunch(str) #, nil)
  #g_free(string)
  if data.source == nil:
    echo("Bad source")
    # g_main_loop_unref(data.loop)
    # g_free(data)
    quit(QuitFailure)
  bus = gst.getBus(data.source)
  gst.addWatch(bus, glib.PRIORITY_DEFAULT.int, onSourceMessage, data)
  # gst_object_unref(bus)
  ##  we use appsink in push mode, it sends us a signal when data is available
  ##  and we pull out the data in the signal callback. We want the appsink to
  ##  push as fast as it can, hence the sync=false
  testsink = cast[AppSink](getByName(cast[gst.Bin](data.source), "testsink"))
  # g_object_set(G_OBJECT(testsink), "emit-signals", TRUE, "sync", FALSE, nil)
  setProperty(testsink, "emit-signals", toBoolVal(true))
  setProperty(testsink, "sync", toBoolVal(false))
  connect(testsink, "new-sample", onNewSampleFromSink, data)
  #gst_object_unref(testsink)
  ##  setting up sink pipeline, we push audio data into this pipeline that will
  ##  then play it back using the default audio sink. We have no blocking
  ##  behaviour on the src which means that we will push the entire file into
  ##  memory.
  str = "appsrc name=testsource caps=\"$1\" ! autoaudiosink" % [audioCaps]
  data.sink = gst.parseLaunch(str) # , nil) was GError
  #g_free(string)
  if data.sink == nil:
    echo("Bad sink")
    #gst_object_unref(data.source)
    #g_main_loop_unref(data.loop)
    #g_free(data)
    quit(QuitFailure)
  testsource = gst.getByName(cast[gst.Bin](data.sink), "testsource")
  ##  configure for time-based format
  setProperty(testsource, "format", toUIntVal(Format.time.ord)) # caution, is the enum signed or unsigned?
  #g_object_set(testsource, "format", GST_FORMAT_TIME, nil)
  ##  uncomment the next line to block when appsrc has buffered enough
  ##  g_object_set (testsource, "block", TRUE, NULL);
  #gst_object_unref(testsource)
  bus = getBus(data.sink)
  addWatch(bus, glib.PRIORITY_DEFAULT.int, onSinkMessage, data)
  #gst_object_unref(bus)
  ##  launching things
  discard setState(data.sink, State.playing)
  discard setState(data.source, State.playing)
  ##  let's run !, this loop will quit when the sink pipeline goes EOS or when an
  ##  error occurs in the source or sink pipelines.
  echo("Let\'s run!")
  glib.run(data.loop)
  echo("Going out")
  discard setState(data.source, State.null)
  discard setState(data.sink, State.null)
  # gst_object_unref(data.source)
  # gst_object_unref(data.sink)
  # g_main_loop_unref(data.loop)
  # g_free(data)
  quit(QuitSuccess)

main()


# https://gitlab.freedesktop.org/libnice/libnice/-/blob/master/examples/sdp-example.c
# nim c --gc:arc sdp_example.nim
#
#  Example using libnice to negotiate a UDP connection between two clients,
#  possibly on the same network or behind different NATs and/or stateful
#  firewalls.
#
#  Run two clients, one controlling and one controlled:
#    ./sdp-example 0 $(host -4 -t A stun.stunprotocol.org | awk '{ print $4 }')
#    ./sdp-example 1 $(host -4 -t A stun.stunprotocol.org | awk '{ print $4 }')


# https://forum.nim-lang.org/t/3752
when (compiles do: import gintro/gtk):
  import gintro/[gtk, glib, gobject, gio, nice]
else:
  import gintro/[dummygtk, glib, gobject, gio, nice] # For windows with glib but no gtk

from strutils import `%`
from os import paramCount, paramStr
from strutils import parseInt

when defined(windows):
  import winlean
else:
  discard # import posix

var
  gloop: glib.MainLoop
  stunAddr: string
  stunPort: int
  controlling: int
  exitThread: bool
  candidateGatheringDone: bool
  negotiationDone: bool
  gatherMutex: glib.Mutex
  negotiateMutex: glib.Mutex
  gatherCond: glib.Cond
  negotiateCond: glib.Cond
  stateName = ["disconnected", "gathering", "connecting", "connected", "ready", "failed"]

proc gDebug(s: string) =
  stdout.write(s)
  flushFile(stdout)

proc gError(s: string) =
  stderr.write(s)
  flushFile(stderr)

proc toStringVal(s: string): Value =
  let gtype = gStringGetType()
  discard init(result, gtype)
  setString(result, s)
  
proc toBoolVal(b: bool): Value =
  let gtype = gBooleanGetType()
  discard init(result, gtype)
  setBoolean(result, b)
  
proc toIntVal(i: int): Value =
  let gtype = typeFromName("gint")
  discard init(result, gtype)
  setInt(result, i)

proc cbCandidateGatheringDone(agent: nice.Agent; streamID: int) =
  gDebug("SIGNAL candidate gathering done\n")
  glib.lock(gatherMutex)
  candidateGatheringDone = true
  glib.signal(gatherCond)
  glib.unlock(gatherMutex)

proc cbComponentStateChanged(agent: nice.Agent; streamID: int; componentID: int; state: int) =
  gDebug("SIGNAL: state changed $1 $2 $3[$4]\n" % [$streamID, $componentID, stateName[state.ord], $state])
  if state == nice.ComponentState.ready.ord:
    glib.lock(negotiateMutex)
    negotiationDone = true
    glib.signal(negotiateCond)
    glib.unlock(negotiateMutex)
  elif state == nice.ComponentState.failed.ord:
    glib.quit(gloop)

# proc nice_agent_attach_recv*(self: ptr Agent00; streamID: cuint; componentID: cuint; ctx: ptr glib.MainContext;
#   fn: AgentRecvFunc; data: pointer): gboolean {.importc, libprag.}
#
# this has to be a low level function!
# AgentRecvFunc* = proc (agent: ptr Agent00; streamId: uint32; componentId: uint32; len: uint32;
#   buf: cstring; userData: pointer) {.cdecl.}
proc cbNiceRecv(agent: ptr nice.Agent00; streamID: uint32; componentID: uint32; len: uint32; buf: cstring; userData: pointer) {.cdecl.} =
  if len == 1 and buf[0] == '\x00':
    glib.quit(gloop)
  discard stdout.writeBuffer(buf, len)
  flushfile(stdout)

proc exampleThread(data: pointer): pointer {.cdecl.} =
  var
    agent: nice.Agent
    ioStdin: glib.IOChannel
    streamID: int
    line: string
    sdp: string
    sdp64: string

  # https://gist.github.com/demotomohiro/c9d9ad7e17639c6acb9bd2be7c204f3f
  when hostOS == "windows":
    ioStdin = win32NewFd(system.stdin.getFileHandle)
  else:
    ioStdin = unixNew(system.stdin.getFileHandle)

  discard setFlags(ioStdin, glib.IOFlags.nonBlock)
  #  Create the nice agent
  agent = nice.newAgent(glib.getContext(gloop), nice.CompatibilityRfc5245)
  if agent == nil:
    gError("Failed to create agent")
  # Set the STUN settings and controlling mode
  if stunAddr.len > 0:
    setProperty(agent, "stun-server", toStringVal(stunAddr))
    setProperty(agent, "stun-server-port", toIntVal(stunPort))
  setProperty(agent, "controlling-mode", toIntVal(controlling))
  #  Connect to the signals
  agent.connect("candidate-gathering-done", cbCandidateGatheringDone)
  agent.connect("component-state-changed", cbComponentStateChanged)
  #  Create a new stream with one component
  streamID = addStream(agent, 1)
  if streamID == 0:
    gError("Failed to add stream")
  discard setStreamName(agent, streamID, "text")
  #  Attach to the component to receive the data
  #  Without this call, candidates cannot be gathered
  discard attachRecv(agent, streamID, 1, getContext(gloop), cbNiceRecv, nil)
  #  Start gathering local candidates
  if not gatherCandidates(agent, stream_id):
    gError("Failed to start candidate gathering")
  gDebug("waiting for candidate-gathering-done signal...")
  lock(gatherMutex)
  while not exitThread and not candidateGatheringDone:
    wait(gatherCond, gatherMutex)
  unlock(gatherMutex)
  block gotoEnd:
    if exitThread:
      break gotoEnd
    # Candidate gathering is done. Send our local candidates on stdout
    sdp = generateLocalSdp(agent)
    stdout.write("Generated SDP from agent :\n$1\n\n" % [sdp])
    stdout.write("Copy the following line to remote client:\n")
    sdp64 = base64Encode(sdp)
    stdout.write("\n  $1\n", sdp64)
    #  Listen on stdin for the remote candidate list
    stdout.write("Enter remote data (single line, no wrapping):\n")
    stdout.write("> ")
    flushFile(stdout)
    while not exitThread:
      var terminatorPos: uint64
      var length: uint64
      var s: IOStatus = readLine(ioStdin, line, length, terminatorPos)
      if s == IOStatus.normal:
        var sdpLen: uint64
        let sdp = cast[string](base64Decode(line, sdpLen)) #seq[uint8]
        #  Parse remote candidate list and set it on the agent
        if sdp.len > 0 and parseRemoteSdp(agent, sdp) > 0:
          break
        else:
          write(stderr, "ERROR: failed to parse remote data\n")
          write(stdout, "Enter remote data (single line, no wrapping):\n")
          stdout.write("> ")
          flushFile(stdout)
      elif s == IOStatus.again:
        usleep(100000)
    gDebug("waiting for state READY or FAILED signal...")
    lock(negotiateMutex)
    while not exitThread and not negotiationDone:
      wait(negotiateCond, negotiateMutex)
    unlock(negotiateMutex)
    if exitThread:
      break gotoEnd
    # Listen to stdin and send data written to it
    stdout.write("\nSend lines to remote (Ctrl-D to quit):\n")
    stdout.write("> ")
    flushFile(stdout)
    while not exitThread:
      var terminatorPos: uint64
      var length: uint64
      var s: IOStatus = readLine(ioStdin, line, length, terminatorPos);
      if s == IOStatus.normal:
        discard send(agent, streamID, 1, line.len, line)
        stdout.write("> ")
        flushFile(stdout)
      elif s == IOStatus.again:
        usleep(100000)
      else:
        # Ctrl-D was pressed.
        discard send(agent, stream_id, 1, 1, "\x00")
        break
  # END label
  quit(gloop)
  return nil

proc main =
  #echo paramCount()
  #for i in 0 .. paramCount():
  #  echo paramStr(i)
  let argc = paramCount() + 1
  var argv = newSeq[string](argc)
  for i in 0 ..< argc:
    argv[i] = paramStr(i)
  var gexamplethread: glib.Thread
  # Parse arguments
  if argc > 4 or argc < 2 or argv[1].len > 1: # argv[1][1] != '\x00':
    write(stderr, "Usage: $1 0|1 stun_addr [stun_port]\n" % [argv[0]])
    quit(QuitFailure)
  controlling = argv[1][0].ord - '0'.ord
  if controlling != 0 and controlling != 1:
    write(stderr, "Usage: $1 0|1 stun_addr [stun_port]\n" % [argv[0]])
    quit(QuitFailure)
  if argc > 2:
    stun_addr = argv[2]
    if argc > 3:
      stun_port = parseInt(argv[3])
    else:
      stun_port = 3478
    gDebug("Using stun server \'[$1]:$2\'\n" % [$stunAddr, $stunPort])
  gio.networkingInit()
  gloop = newMainLoop(nil, false)
  # Run the mainloop and the example thread
  exitThread = false
  gexamplethread = newThread("example thread", exampleThread, nil)
  run(gloop)
  exitThread = true
  discard join(gexamplethread)
  quit(QuitSuccess)

main()

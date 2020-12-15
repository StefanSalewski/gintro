## https://gitlab.freedesktop.org/libnice/libnice/-/blob/master/examples/simple-example.c
## nim c --gc:arc simple_example.nim
##  Example using libnice to negotiate a UDP connection between two clients,
##  possibly on the same network or behind different NATs and/or stateful
##  firewalls.
##
##  Run two clients, one controlling and one controlled:
##    simple-example 0 $(host -4 -t A stun.stunprotocol.org | awk '{ print $4 }')
##    simple-example 1 $(host -4 -t A stun.stunprotocol.org | awk '{ print $4 }')
##

# https://forum.nim-lang.org/t/3752
when (compiles do: import gintro/gtk):
  import gintro/[gtk, glib, gobject, gio, nice]
else:
  import gintro/[dummygtk, glib, gobject, gio, nice] # For windows with glib but no gtk

from strutils import `%`, split
from os import paramCount, paramStr
from strutils import parseInt, removeSuffix
import nativesockets

var
  gloop: glib.MainLoop
  ioStdin: glib.IOChannel
  streamId: int
  candidateTypeName = ["host", "srflx", "prflx", "relay"]
  stateName = ["disconnected", "gathering", "connecting", "connected", "ready", "failed"]

proc gMsg(s: string) =
  stdout.write(s & '\n')
  flushFile(stdout)

proc gDebug(s: string) =
  stdout.write(s & '\n')
  flushFile(stdout)

proc gError(s: string) =
  stderr.write(s)
  flushFile(stderr)

proc toStringVal(s: string): Value =
  let gtype = gStringGetType()
  discard init(result, gtype)
  setString(result, s)

proc toIntVal(i: int): Value =
  let gtype = typeFromName("gint")
  discard init(result, gtype)
  setInt(result, i)

proc addrString(niceAddr: Address): string =
  getAddrString(unsafeAddr niceAddr.`addr`)

proc printLocalData(agent: nice.Agent; streamId: int; componentId: int): int =
  var
    localUfrag: string
    localPassword: string
    cands: seq[Candidate]
  result = QuitFailure
  block gotoEnd:
    if not getLocalCredentials(agent, streamId, localUfrag, localPassword):
      break gotoEnd
    cands = getLocalCandidates(agent, streamId, componentId)
    if cands.len == 0:
      break gotoEnd
    stdout.write(localUfrag, ' ', localPassword)
    for el in cands:
      let ipaddr = el.impl.`addr`.addrString
      ##  (foundation),(prio),(addr),(port),(type)
      stdout.write(' ', cast[cstring](addr el.impl.foundation), ',', el.impl.priority, ',', ipaddr, ',', getPort(el.impl.`addr`),
          ',', candidateTypeName[el.impl.`type`.ord])
    echo ""
    # end label
    result = QuitSuccess

  return result

proc parseCandidate(scand: string; streamId: int): nice.Candidate =
  var
    cand: nice.Candidate = nil
    ntype: nice.CandidateType = CandidateType.host # that initialization is never used!
    tokens = scand.split(',', 5)
  block gotoEnd:
    if tokens.len < 5:
      gMsg("Invalid candidate text: " & scand)
    for i in 0 .. 4:
      if tokens[i] == "":
        gMsg("Empty candidate field: " & scand)
        break gotoEnd
    #[ should work too
    for i, el in candidateTypeName:
      var h = false
      if tokens[4] == el:
        ntype = i
        h = true
      if not h:
        break gotoEnd
      ]#
    var i: int
    var candTypeName = tokens[4]
    removeSuffix(candTypeName)
    while i < candidateTypeName.len:
      if candTypeName == candidateTypeName[i]:
        ntype = CandidateType(i)
        break # missing in initial release!
      inc(i)
    if i == candidateTypeName.len:
      gMsg("Invalid candidate type name: " & candTypeName)
      break gotoEnd
    cand = newCandidate(ntype)
    #cand.impl.componentId = 1
    cand.setComponentID(1) # we have a few manually created getters and setters already
    cand.impl.streamId = uint32(streamId)
    cand.impl.transport = nice.CandidateTransport.udp
    cand.setFoundation(tokens[0])
    cand.impl.priority = uint32(parseInt(tokens[1]))
    if not setFromString(cand.impl.`addr`, tokens[2]):
      gMsg("failed to parse addr: " & tokens[2])
      cand = nil
      break gotoEnd
    setPort(cand.impl.`addr`, parseInt(tokens[3]))
  # end label
  return cand

proc parseRemoteData(agent: Agent; streamId: int; componentId: int; line: string): cint =
  var
    remoteCandidates: seq[Candidate]
    lineArgv: seq[string]
    ufrag: string
    passwd: string
  result = QuitFailure
  lineArgv = split(line, {' ', '\t', '\n'})
  block gotoEnd:
    for i, x in lineArgv:
      if x.len == 0:
        continue
      ## first two args are remote ufrag and password
      if ufrag == "":
        ufrag = x
      elif passwd == "":
        passwd = x
      else:
        ##  Remaining args are serialized canidates (at least one is required)
        var c: nice.Candidate = parseCandidate(x, streamId)
        if c == nil:
          gMsg("failed to parse candidate: " & x)
          break gotoEnd
        remoteCandidates.add(c) # caution prepend in C code!
    if ufrag == "" or passwd == "" or remoteCandidates.len == 0:
      gMsg("line must have at least ufrag, password, and one candidate")
      break gotoEnd
    if not setRemoteCredentials(agent, streamId, ufrag, passwd):
      gMsg("failed to set remote credentials")
      break gotoEnd
    ## Note: this will trigger the start of negotiation.
    if setRemoteCandidates(agent, streamId, componentId, remoteCandidates) < 1:
      gMsg("failed to set remote candidates")
      break gotoEnd
    result = QuitSuccess

  return result

proc stdinRemoteInfoCb(source: glib.IOChannel; cond: glib.IOCondition; agent: nice.Agent): bool =
  var
    line: string
    rval: cint
    ret: bool = true
  if readLine(source, line) == IOStatus.normal:
    ##  Parse remote candidate list and set it on the agent
    rval = parseRemoteData(agent, streamId, 1, line)
    if rval == QuitSuccess:
      ##  Return FALSE so we stop listening to stdin since we parsed the
      ##  candidates correctly
      ret = false
      gDebug("waiting for state READY or FAILED signal...")
    else:
      write(stderr, "ERROR: failed to parse remote data\n")
      echo("Enter remote data (single line, no wrapping):")
      stdout.write("> ")
      flushFile(stdout)
  return ret

proc cbCandidateGatheringDone(agent: nice.Agent; streamId: int) =
  gDebug("SIGNAL candidate gathering done\n")
  ##  Candidate gathering is done. Send our local candidates on stdout
  echo("Copy this line to remote client:")
  stdout.write("\n  ")
  discard printLocalData(agent, streamId, 1)
  echo("")
  ##  Listen on stdin for the remote candidate list
  echo("Enter remote data (single line, no wrapping):")
  discard addWatch(ioStdin, glib.PRIORITY_DEFAULT, {IOCFlag.`in`} , stdinRemoteInfoCb, agent)
  stdout.write("> ")
  flushFile(stdout)

proc cbNewSelectedPair(agent: nice.Agent; streamId: int; componentId: int; lfoundation: string; rfoundation: string) =
  gDebug("SIGNAL: selected pair " & lfoundation & " " & rfoundation)

proc stdinSendDataCb(source: IOChannel; cond: IOCondition; agent: nice.Agent): bool =
  var line: string
  if readLine(source, line) == IOStatus.normal:
    discard send(agent, streamId, 1, line.len, line)
    stdout.write("> ")
    flushFile(stdout)
  else:
    discard send(agent, streamId, 1, 1, "\x00")
    ##  Ctrl-D was pressed.
    quit(gloop)
  return true

proc cbComponentStateChanged(agent: nice.Agent; streamId: int; componentId: int; state: int) =
  gDebug("SIGNAL: state changed $1 $2 $3[$4]\n" % [$streamId, $componentId, stateName[state], $state])
  if state == ComponentState.connected.ord:
    var
      local: Candidate
      remote: nice.Candidate
    ##  Get current selected candidate pair and print IP address used
    if getSelectedPair(agent, streamId, componentId, local, remote):
      var ipaddr = local.impl.`addr`.addrString
      echo("\nNegotiation complete: ([$1]:$2," % [$ipaddr, $getPort(local.impl.`addr`)])
      ipaddr = remote.impl.`addr`.addrString
      echo(" [$1]:$2)" % [$ipaddr, $getPort(remote.impl.`addr`)])
    ## Listen to stdin and send data written to it
    echo("\nSend lines to remote (Ctrl-D to quit):")
    discard addWatch(ioStdin, glib.PRIORITY_DEFAULT, {IOCFlag.`in`} , stdinSendDataCb, agent)
    stdout.write("> ")
    flushFile(stdout)
  elif state == ComponentState.failed.ord:
    quit(gloop)

proc cbNiceRecv(agent: nice.Agent; streamID: cuint; componentID: cuint; len: cuint; buf: cstring) = #{.cdecl.} =
  if len == 1 and buf[0] == '\x00':
    glib.quit(gloop)
  discard stdout.writeBuffer(buf, len)
  flushfile(stdout)

proc main =
  var
    agent: nice.Agent
    stunAddr: string
    stunPort: int
    controlling: int

  ##  Parse arguments
  let argc = paramCount() + 1
  var argv = newSeq[string](argc)
  for i in 0 ..< argc:
    argv[i] = paramStr(i)

  if argc > 4 or argc < 2 or argv[1].len > 1:
    write(stderr, "Usage: $1 0|1 stun_addr [stun_port]\n" % [argv[0]])
    quit(QuitFailure)

  controlling = argv[1][0].ord - '0'.ord
  if controlling != 0 and controlling != 1:
    write(stderr, "Usage: $1 0|1 stun_addr [stun_port]\n" % [argv[0]])
    quit(QuitFailure)

  if argc > 2:
    stunAddr = argv[2]
    if argc > 3:
      stunPort = parseInt(argv[3])
    else:
      stunPort = 3478
    gDebug("Using stun server \'[$1]:$2\'\n" % [$stunAddr, $stunPort])

  gio.networkingInit()
  gloop = newMainLoop(nil, false)

  # https://gist.github.com/demotomohiro/c9d9ad7e17639c6acb9bd2be7c204f3f
  when hostOS == "windows":
    ioStdin = win32NewFd(system.stdin.getFileHandle)
  else:
    ioStdin = unixNew(system.stdin.getFileHandle)

  ##  Create the nice agent
  agent = nice.newAgent(glib.getContext(gloop), nice.CompatibilityRfc5245)
  if agent == nil:
    gError("Failed to create agent")

  ## Set the STUN settings and controlling mode
  if stunAddr.len > 0:
    setProperty(agent, "stun-server", toStringVal(stunAddr))
    setProperty(agent, "stun-server-port", toIntVal(stunPort))
  setProperty(agent, "controlling-mode", toIntVal(controlling))

  ##  Connect to the signals
  agent.connect("candidate-gathering-done", cbCandidateGatheringDone)
  agent.connect("new-selected-pair", cbNewSelectedPair)
  agent.connect("component-state-changed", cbComponentStateChanged)

  ##  Create a new stream with one component
  streamId = addStream(agent, 1)
  if streamId == 0:
    gError("Failed to add stream")

  ## Attach to the component to receive the data
  ## Without this call, candidates cannot be gathered
  attachRecv(agent, streamId.cuint, 1, getContext(gloop), cbNiceRecv)

  ##  Start gathering local candidates
  if not gatherCandidates(agent, streamId):
    gError("Failed to start candidate gathering")
  gDebug("waiting for candidate-gathering-done signal...")

  ##  Run the mainloop. Everything else will happen asynchronously
  ##  when the candidates are done gathering.
  run(gloop)
  quit(QuitSuccess)

main()


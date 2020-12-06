# nim c libnice_simple_test.nim
#
#  Test code for libnice.
#  If test succeeded, it prints "Test success".
#  You don't need to run 2 processes of this program to test.

when (compiles do: import gintro/gtk):
  import gintro/[gtk, glib, gobject, gio, nice]
else:
  import gintro/[dummygtk, glib, gobject, gio, nice] # For system has glib but no gtk

import strformat, nativesockets

const
  ltestMessage = "some test message"
  rtestMessage = "random text for test"

var
  gloop: glib.MainLoop
  lagent, ragent: nice.Agent
  lstreamId, rstreamId: int
  gatheringCount, recvCount: int

proc toIntVal(i: int): Value =
  let gtype = typeFromName("gint")
  discard init(result, gtype)
  setInt(result, i)

proc addrString(niceAddr: Address): string =
  getAddrString(unsafeAddr niceAddr.`addr`)

proc cbCandidateGatheringDone(agent: nice.Agent; streamId: int) =
  proc copyCandidates(src, dst: nice.Agent; srcStreamId, dstStreamId: int) =
    var
      ufrag: string
      password: string

    doAssert src.getLocalCredentials(srcStreamId, ufrag, password)
    doAssert dst.setRemoteCredentials(dstStreamId, ufrag, password)
    var cands: seq[Candidate] = src.getLocalCandidates(srcStreamId, 1)
    for c in cands.mitems:
      c.setStreamID(dstStreamId.uint32)
      c.setComponentID(1)
    doAssert cands.len != 0
    doAssert dst.setRemoteCandidates(dstStreamId, 1, cands) > 0

  doAssert agent == lagent or agent == ragent
  doAssert gatheringCount in (0..1)

  if gatheringCount == 1:
    copyCandidates(lagent, ragent, lstreamId, rstreamId)
    copyCandidates(ragent, lagent, rstreamId, lstreamId)

  inc gatheringCount

proc cbNewSelectedPairFull(self: Agent; streamId: int; componentId: int; lcandidate: Candidate; rcandidate: Candidate) =
  echo &"SIGNAL: selected pair ({lcandidate.impl.`addr`.addrString}:{lcandidate.impl.`addr`.port} {rcandidate.impl.`addr`.addrString}:{rcandidate.impl.`addr`.port})"

proc cbComponentStateChanged(agent: nice.Agent; streamId: int; componentId: int; state: int) =
  doAssert agent == lagent or agent == ragent

  let stat = ComponentState(state)
  echo &"SIGNAL: state changed {streamId}, {componentId}, {stat}"

  case stat
  of ComponentState.connected:
    var
      local = Candidate(ignoreFinalizer: true)
      remote = Candidate(ignoreFinalizer: true)
    ##  Get current selected candidate pair and print IP address used
    if getSelectedPair(agent, streamId, componentId, local, remote):
      echo &"Negotiation complete: ({local.impl.`addr`.addrString}:{local.impl.`addr`.port} {remote.impl.`addr`.addrString}:{remote.impl.`addr`.port})"
  of ComponentState.ready:
    if agent == lagent:
      doAssert agent.send(streamId, componentId, ltestMessage.len, ltestMessage.cstring) == ltestMessage.len
    else:
      doAssert agent.send(streamId, componentId, rtestMessage.len, rtestMessage.cstring) == rtestMessage.len
  of ComponentState.failed:
    gloop.quit
  else:
    discard

proc cbNiceRecv(agent: nice.Agent; streamID: cuint; componentID: cuint; len: cuint; buf: cstring) =
  doAssert agent.impl == lagent.impl or agent.impl == ragent.impl
  if agent.impl == lagent.impl:
    doAssert len == rtestMessage.len
    doAssert equalMem(buf, rtestMessage.cstring, len)
    echo "lagent received test message"
  else:
    doAssert len == ltestMessage.len
    doAssert equalMem(buf, ltestMessage.cstring, len)
    echo "ragent received test message"

  doAssert recvCount in (0..1)
  if recvCount == 1:
    gloop.quit
  inc recvCount

proc main =
  gio.networkingInit()

  
  gloop = newMainLoop(nil, false)

  lagent = nice.newAgent(glib.getContext(gloop), nice.CompatibilityRfc5245)
  ragent = nice.newAgent(glib.getContext(gloop), nice.CompatibilityRfc5245)

  doAssert lagent != nil and ragent != nil

  lagent.setProperty("controlling-mode", toIntVal(0))
  ragent.setProperty("controlling-mode", toIntVal(1))

  lagent.connect("candidate-gathering-done", cbCandidateGatheringDone)
  ragent.connect("candidate-gathering-done", cbCandidateGatheringDone)
  lagent.connect("new-selected-pair-full", cbNewSelectedPairFull)
  ragent.connect("new-selected-pair-full", cbNewSelectedPairFull)
  lagent.connect("component-state-changed", cbComponentStateChanged)
  ragent.connect("component-state-changed", cbComponentStateChanged)

  lstreamId = lagent.addStream(1)
  rstreamId = ragent.addStream(1)
  doAssert lstreamId != 0 and rstreamId != 0

  lagent.attachRecv(lstreamId.cuint, 1, getContext(gloop), cbNiceRecv)
  ragent.attachRecv(rstreamId.cuint, 1, getContext(gloop), cbNiceRecv)

  doAssert gatherCandidates(lagent, lstreamId)
  doAssert gatherCandidates(ragent, rstreamId)

  gloop.run

  doAssert gatheringCount == 2
  doAssert recvCount == 2

  echo "Test success"

main()

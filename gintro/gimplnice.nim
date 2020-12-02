proc nice_agent_attach_recv*(self: ptr Object00; streamID: cuint; componentID: cuint; ctx: ptr glib.MainContext00;
  fn: AgentRecvFunc; data: pointer): gboolean {.importc, libprag.}

# we will never use this proc, as we use the macro!
proc attachRecv*(self: Agent; streamID: int; componentID: int; ctx: MainContext; fn: AgentRecvFunc; data: pointer): bool =
  toBool(nice_agent_attach_recv(self.impl, streamID.cuint, componentID.cuint, ctx.impl, fn, data))

import macros

macro mattachRecv(ag: Agent; streamID: cuint; componentID: cuint; ctx: glib.MainContext; p: untyped; arg: typed;
    ignoreArg: bool): untyped =
  var IdleID {.compileTime, global.}: int
  inc(IdleID)
  let ats = $getTypeInst(arg).toStrLit
  let procName = "recvfunc_" & $IdleID
  let procNameCdecl = "recvfunc_cdecl_" & $IdleID
  var r1s = """

proc $1(self: ptr Agent00; streamId: uint32; componentId: uint32; len: uint32; buf: cstring; userData: pointer) {.cdecl.} =
  var ag1 {.global.}: nice.Agent
  if ag1.isNil:
    new ag1
    GC_ref(ag1) # never call destroy/finalizer on this global variable
    ag1.ignoreFinalizer = true
  ag1.impl = self
  $2(ag1, streamID, componentID, len, buf"""

  if not ignoreArg.boolVal:
    if getTypeInst(arg).typeKind == ntyRef:
      r1s.add(", cast[$3](userdata)")
    else:
      r1s.add(", cast[$3](userdata)")
  r1s.add(")\n")

  r1s = r1s % [$procNameCdecl, $p, ats]

  let r2s =
    if ignoreArg.boolVal:

      """
proc $1(self: Agent; streamId: uint32; componentId: uint32; ctx: glib.MainContext) =
    #gtk_drawing_area_set_draw_func(self.impl, $3, nil, nil)
    #g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, nil, nil)
    discard nice_agent_attach_recv(cast[ptr Agent00](self.impl), streamId, componentId, cast[ptr MainContext00](ctx.impl), $7, nil)#, userData)
    #gtk_drawing_area_set_draw_func(cast[ptr DrawingArea00](self.impl), $3, nil, nil)

$1($5, $3, $4, $6)
""" % [$procName, ats, $(streamID.toStrLit), $(componentID.toStrLit), $(ag.toStrLit), $(ctx.toStrLit), $procNameCdecl, $(arg.toStrLit)]

    else:

      """
proc $1(self: Agent; streamId: uint32; componentId: uint32; a: $2) =
  when (a is ref object):
    GC_ref(a)
    discard nice_agent_attach_recv(cast[ptr Agent00](self.impl), streamId, componentId, $7, cast[pointer](a))
    #discard g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](a), nil)
  else:
    var ar: ref $2
    new(ar)
    #deepCopy(ar[], a)
    ar[] = a
    GC_ref(ar)
    discard nice_agent_attach_recv(cast[ptr Agent00](self.impl), streamId, componentId, $7, cast[pointer](a[]))
    #discard g_io_add_watch_full(cast[ptr IOChannel00](self.impl), pri, cond, $5, cast[pointer](ar[]), nil)
$1($5, $3, $4, $5, $8)
""" % [$procName, ats, $streamID, $componentID, $(ag.toStrLit), "xx", $procNameCdecl, $(arg.toStrLit)]
  #echo r1s
  #echo r2s
  result = parseStmt(r1s & r2s)

template attachRecv*(ag: Agent; streamID: cuint; componentID: cuint; ctx: glib.MainContext; p: untyped; arg: typed): untyped =
  mattachRecv(ag, streamID, componentID, ctx, p, arg, false)

template attachRecv*(ag: Agent; streamID: cuint; componentID: cuint; ctx: glib.MainContext; p: untyped): untyped =
  mattachRecv(ag, streamID, componentID, ctx, p, "", true)

proc setAddress*(c: Candidate; s: cstring): bool =
  toBool(nice_address_set_from_string(c.impl.addr, s))

proc setPort*(c: Candidate; p: uint32) =
  nice_address_set_port(c.impl.addr, p)

proc setTransport*(c: Candidate; t: CandidateTransport) =
  c.impl.transport = t

proc setcomponentID*(c: Candidate; id: uint32) =
  c.impl.componentId = id

proc setStreamID*(c: Candidate; id: uint32) =
  c.impl.streamId = id

proc setPriority*(c: Candidate; pri: uint32) =
  c.impl.priority = pri

proc setFoundation*(c: Candidate; s: cstring) =
  var i: int
  while i < c.impl.foundation.high:
    c.impl.foundation[i] = s[i].int8
    if s[i] == '\x0':
      break
    inc(i)
  c.impl.foundation[^1] = 0



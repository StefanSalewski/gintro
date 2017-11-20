# Package

version       = "0.2.0"
author        = "Stefan Salewski"
description = "High level GObject-Introspection based GTK3 bindings"
license       = "MIT"
skipDirs = @["examples", "tests"]

# Dependencies

requires "nim >= 0.17.0"

when defined(nimdistros):
  import distros
  if detectOs(Ubuntu) or detectOs(Debian):
    foreignDep "libgtk-3-dev"
  elif detectOs(Gentoo):
    foreignDep "gtk+" # can we specify gtk3?
  #else: we don't know the names for all the other distributions
  #  foreignDep "openssl"

import ospaths

proc prep =
  let this = thisDir()
  let td = getTempDir()
  cd(td)
  let wd = "gintrosalewski"
  if dirExists(wd):
    quit("gintro: tmp directory already exists!")
  mkDir(wd)
  cd(wd)
  mkDir("ngtk3")
  cd("ngtk3")

  exec("git clone https://github.com/ngtk3/nim-glib")
  exec("git clone https://github.com/ngtk3/nim-gobject")
  exec("git clone https://github.com/ngtk3/nim-gir")

  cpFile(this / "tests" / "gen.nim", td / wd / "gen.nim")
  cpFile(this / "tests" / "combinatorics.nim", td / wd / "combinatorics.nim")

  cpFile("nim-glib/src/glib.nim", td / wd / "glib.nim")
  cpFile("nim-gobject/src/gobject.nim", td / wd / "gobject.nim")
  cpFile("nim-gir/src/gir.nim", td / wd / "gir.nim")

  cd(td)
  cd(wd)
  exec("nim c gen.nim")
  mkDir("nim_gi")
  exec(td / wd / "gen")
  let mods = listFiles("nim_gi")
  for i in mods:
    let j = i[7 .. ^1]
    cpFile(i, this / "gintro" / j)
  cd(td)
  rmDir(wd) # cleanup

task prepare, "preparing gintro":
#before install:

  echo "preparing gintro"
  prep()
  


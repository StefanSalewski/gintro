# Package

version       = "0.9.1"
author        = "Stefan Salewski"
description = "High level GObject-Introspection based GTK4/GTK3 bindings"
license       = "MIT"
skipDirs = @["examples", "tests"]

# Dependencies

requires "nim >= 1.0.0"

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
    rmDir(wd)
    # quit("gintro: tmp directory already exists!")
  mkDir(wd)
  cd(wd)
  mkDir("ngtk3")
  cd("ngtk3")

  cpFile(this / "tests" / "gen.nim", td / wd / "gen.nim")
  cpFile(this / "tests" / "combinatorics.nim", td / wd / "combinatorics.nim")
  cpFile(this / "tests" / "maxby.nim", td / wd / "maxby.nim")

  cd(td)
  cd(wd)

  try:
    exec("wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gobject.nim -O gobject.nim")
    exec("wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/glib.nim -O glib.nim")
    exec("wget https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gir.nim -O gir.nim")
  except:
    try:
      exec("nimgrab https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gobject.nim gobject.nim")
      exec("nimgrab https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/glib.nim glib.nim")
      exec("nimgrab https://raw.githubusercontent.com/StefanSalewski/oldgtk3/master/oldgtk3/gir.nim gir.nim")
    except:
      echo "For bootstrapping of gintro package we need the low level files gobject.nim, glib.nim and gir.nim."
      echo "We take these from package oldgtk3. As most gintro users will not need the whole oldgtk3 package"
      echo "we tried to only download these 3 single files using wget or nimgrab. But that failed."
      echo "Ensure that wget or nimgrab are available. wget should be available for Unix like systems."
      echo "Nimgrab should be available in Nim/tools directory. You may compile it with 'nim c -d:ssl nimgrab.nim'"
      echo "and put it into your search path"
      echo "For the unlikely case that you have already full oldgtk3 package installed, we will just try to continue..."

  exec("nim c gen.nim")
  mkDir("nim_gi")
  exec(td / wd / "gen 1")
  exec(td / wd / "gen")
  let mods = listFiles("nim_gi")
  for i in mods:
    let j = i[7 .. ^1]
    cpFile(i, this / "gintro" / j)
  cd(td)
  rmDir(wd) # cleanup

#task prepare, "preparing gintro":
before install:

  echo "preparing gintro"
  prep()
  


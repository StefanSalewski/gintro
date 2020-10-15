# https://developer.gnome.org/glib/stable/glib-GVariant.html
# https://developer.gnome.org/glib/stable/glib-GVariantType.html
# https://wiki.gnome.org/HowDoI/GMenu
# https://wiki.gnome.org/HowDoI/GAction
# nim c menubar.nim
import gintro/[gtk, glib, gobject, gio]
from strutils import `%`, format

# https://github.com/GNOME/glib/blob/master/gio/tests/gapplication-example-actions.c
proc activateToggleAction(action: SimpleAction; parameter: Variant; app: Application) =
  app.hold # hold/release taken over from C example, there may be reasons...
  block:
    echo format("action $1 activated", action.name)
    let state: Variant = action.state
    let b = state.getBoolean
    action.state = newVariantBoolean(not b)
    echo format("state change $1 -> $2", b, not b)
  app.release

proc activateStatefulAction(action: SimpleAction; parameter: Variant; app: Application) =
  app.hold
  block:
    echo format("action $1 activated", action.name)
    let state: Variant = action.state
    var l: uint64
    let oldState = state.getString(l) # yes uint64 parameter is a bit ugly
    let newState = parameter.getString(l)
    action.state = newVariantString(newState)
    echo format("state change $1 -> $2", oldState, newState)
  app.release

proc quitProgram(action: SimpleAction; parameter: Variant; app: Application) =
  quit(app)

proc appStartup(app: Application) =
  echo "appStartup"
  let quit = newSimpleAction("quit") # here we create the actions for whole app
  connect(quit, "activate", quitProgram, app)
  app.addAction(quit)

  let menu = gio.newMenu() # root of all menus
  block: # plain stateless menu
    let subMenu = gio.newMenu()
    menu.appendSubMenu("Application", submenu)
    # let section = gio.newMenu() # no separating section needed here
    # submenu.appendSection(nil, section)
    # section.append("Quit", "app.quit")
    submenu.append("Quit", "app.quit")

  block: #stateful menu with radio items
    let subMenu = gio.newMenu()
    menu.appendSubMenu("Layout", submenu)
    let subMenu2 = gio.newMenu()
    submenu.appendSubMenu("justify", submenu2)
    let section = gio.newMenu()
    submenu2.appendSection(nil, section)
    section.append("left", "win.justify::left")
    section.append("center", "win.justify::center")
    section.append("right", "win.justify::right")

  block: # and finally a toggle menu
    let subMenu = gio.newMenu()
    menu.appendSubMenu("Spelling", submenu)
    let section = gio.newMenu()
    submenu.appendSection(nil, section)
    section.append("Check", "win.toggleSpellCheck")
  # finally add the menubar
    setMenuBar(app, menu)

proc appActivate(app: Application) =
  echo "appActivate"
  let window = newApplicationWindow(app)
  window.title = "GTK3 App with Menubar"
  window.defaultSize = (500, 200)
  window.position = WindowPosition.center
  block: # creat the window related actions
    let v = newVariantBoolean(true)
    let spellCheck = newSimpleActionStateful("toggleSpellCheck", nil, v)
    connect(spellCheck, "activate", activateToggleAction, app)
    window.actionMap.addAction(spellCheck)
  block:
    let v = newVariantString("left") # default value and
    let vt = newVariantType("s") # string (value type)
    let justifyAction = newSimpleActionStateful("justify", vt, v)
    connect(justifyAction, "activate", activateStatefulAction, app)
    window.actionMap.addAction(justifyAction)
  let button = newButton()
  button.label = "Justify Center"
  #window.add(button) # do not add it here already: (menubar:10010): Gtk-WARNING **: 22:00:33.230: actionhelper:
  # action win.justify can't be activated due to parameter type mismatch (parameter type s, target type NULL)
  button.setDetailedActionName("win.justify::center")
  #button.setActionName("app.quit") # for a stateless action
  setAccelsForAction(app, "win.justify::right", "<Control><Shift>R")
  window.add(button)
  showAll(window)

proc main =
  let app = newApplication("app.example")
  connect(app, "startup", appStartup)
  connect(app, "activate", appActivate)
  echo "GTK Version $1.$2.$3" % [$getMajorVersion(), $getMinorVersion(), $getMicroVersion()]
  let status = run(app)
  quit(status)

main()

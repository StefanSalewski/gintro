# https://developer.gnome.org/glib/stable/glib-GVariant.html
# https://developer.gnome.org/glib/stable/glib-GVariantType.html
# https://wiki.gnome.org/HowDoI/GMenu
# https://wiki.gnome.org/HowDoI/GAction
# https://developer.gnome.org/gnome-devel-demos/stable/menubutton.c.html.en
# nim c gearsmenu.nim
import gintro/[gtk, glib, gobject, gio]
import strformat

# https://github.com/GNOME/glib/blob/master/gio/tests/gapplication-example-actions.c
proc activateToggleAction(action: SimpleAction; parameter: Variant; app: Application) =
  app.hold # hold/release taken over from C example, there may be reasons...
  block:
    echo fmt"action {action.name} activated"
    let state: Variant = action.state
    let b = state.getBoolean
    action.state = newVariantBoolean(not b)
    echo fmt"state change {b} -> {not b}"
  app.release

proc activateStatefulAction(action: SimpleAction; parameter: Variant; app: Application) =
  app.hold
  block:
    echo fmt"action {action.name} activated"
    let state: Variant = action.state
    var l: uint64
    let oldState = state.getString(l) # yes uint64 parameter is a bit ugly
    let newState = parameter.getString(l)
    action.state = newVariantString(newState)
    echo fmt"state change {oldState} -> {newState}"
  app.release

proc quitProgram(action: SimpleAction; parameter: Variant; app: Application) =
  quit(app)

proc appStartup(app: Application) =
  echo "appStartup"
  let quit = newSimpleAction("quit") # here we create the actions for whole app
  connect(quit, "activate", quitProgram, app)
  app.addAction(quit)

proc appActivate(app: Application) =
  echo "appActivate"
  let window = newApplicationWindow(app)
  # window.title = "GTK3 App with Headerbar and Gears Menu" # unused due to HeaderBar
  window.defaultSize = (500, 200)
  window.position = WindowPosition.center

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

  let headerBar = newHeaderBar()
  headerBar.setShowCloseButton
  headerBar.setTitle("Title")
  headerBar.setSubtitle("Subtitle")
  window.setTitlebar (headerBar)

  let menubar = newMenuButton()
  # menubar.setDirection(ArrowType.none) # show the gears Icon
  # let image = newImageFromIconName("open-menu-symbolic", IconSize.menu.ord)
  let image = newImageFromIconName("document-save", IconSize.dialog.ord) # dialog is really big!
  menubar.setImage(image) # this is only an example for a custom image
  # menubar.setIconName("open-menu-symbolic") # only gtk4
  headerBar.packEnd(menubar)
  menubar.setMenuModel(menu)

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
  button.setDetailedActionName("win.justify::center")
  #button.setActionName("app.quit") # for a stateless action
  setAccelsForAction(app, "win.justify::right", "<Control><Shift>R")
  window.add(button)
  showAll(window)

proc main =
  let app = newApplication("app.example")
  connect(app, "startup", appStartup)
  connect(app, "activate", appActivate)
  echo fmt"GTK Version {majorVersion()}.{minorVersion()}.{microVersion()}"
  let status = run(app)
  quit(status)

main()

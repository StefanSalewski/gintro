# nim c gaction.nim
# https://github.com/GNOME/gtk/blob/mainline/tests/testgaction.c
# gcc -Wall gaction.c -o gaction `pkg-config --cflags --libs gtk4`
import gintro/[gtk, glib, gobject, gio]

const menuData = """
<interface>
  <menu id="menuModel">
    <section>
      <item>
        <attribute name="label">Normal Menu Item</attribute>
        <attribute name="action">win.normal-menu-item</attribute>
      </item>
      <submenu>
        <attribute name="label">Submenu</attribute>
        <item>
          <attribute name="label">Submenu Item</attribute>
          <attribute name="action">win.submenu-item</attribute>
        </item>
      </submenu>
      <item>
        <attribute name="label">Toggle Menu Item</attribute>
        <attribute name="action">win.toggle-menu-item</attribute>
      </item>
    </section>
    <section>
      <item>
        <attribute name="label">Radio 1</attribute>
        <attribute name="action">win.radio</attribute>
        <attribute name="target">1</attribute>
      </item>
      <item>
        <attribute name="label">Radio 2</attribute>
        <attribute name="action">win.radio</attribute>
        <attribute name="target">2</attribute>
      </item>
      <item>
        <attribute name="label">Radio 3</attribute>
        <attribute name="action">win.radio</attribute>
        <attribute name="target">3</attribute>
      </item>
    </section>
  </menu>
</interface>
"""

proc changeLabelButton(action: SimpleAction; v: Variant; label: Label) =
  label.setLabel("Text set from button")

proc normalMenuItem(action: SimpleAction; v: Variant; label: Label) =
  label.setLabel("Text set from normal menu item")

proc toggleMenuItem(action: SimpleAction; v: Variant; label: Label) =
  label.setLabel("Text set from toggle menu item")

proc submenuItem(action: SimpleAction; v: Variant; label: Label) =
  label.setLabel("Text set from submenu item")

proc radio(action: SimpleAction; parameter: Variant; label: Label) =
  var l: uint64
  let newState: Variant = newVariantString(getString(parameter, l))
  let str: string = "From Radio menu item " & getString(newState, l)
  label.setLabel(str)

proc bye(w: Window) =
  mainQuit()
  echo "Bye..."

proc main =
  gtk.init()
  let
    window = newWindow()
    box = newBox(Orientation.vertical, 12)
    menubutton = newMenuButton()
    button1 = newButton("Change Label Text")
    label = newLabel("Initial Text")
    actionGroup = newSimpleActionGroup()

  window.connect("destroy", gtk.mainQuit)
  #window.connect("destroy", bye)

  var action = newSimpleAction("change-label-button")
  discard action.connect("activate", changeLabelButton, label)
  actionGroup.addAction(action)

  action = newSimpleAction("normal-menu-item")
  discard action.connect("activate", normalMenuItem, label)
  actionGroup.addAction(action)

  var v = newVariantBoolean(true)
  action = newSimpleActionStateful("toggle-menu-item", nil, v)
  discard action.connect("activate", toggleMenuItem, label)
  actionGroup.addAction(action)

  action = newSimpleAction("submenu-item")
  discard action.connect("activate", subMenuItem, label)
  actionGroup.addAction(action)

  v = newVariantString("1")
  let vt = newVariantType("s")
  action = newSimpleActionStateful("radio", vt, v)
  discard action.connect("activate", radio, label)
  actionGroup.addAction(action)

  insertActionGroup(window, "win", actionGroup)

  label.setMarginTop(12)
  label.setMarginBottom(12)
  box.add(label)
  menubutton.setHAlign(Align.center)
  let builder: Builder = newBuilderFromString(menuData)
  let menuModel = builder.getMenuModel("menuModel")
  let menu = newMenuFromModel(menuModel)
  menuButton.setPopup(menu)
  box.add(menubutton)
  button1.setHalign(Align.center)
  button1.setActionName("win.change-label-button")
  box.add(button1)
  window.add(box)
  window.showAll
  gtk.main()

main()

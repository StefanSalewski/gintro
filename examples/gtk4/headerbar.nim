# https://github.com/GNOME/gtk/blob/mainline/tests/testheaderbar.c
# this is still based on the original testheaderbar.c, which was recently replaced by testheaderbar2.c
# and testheaderbar.c is not a very good Nim GTK4 example unfortunately -- too comlicated and strange code.
# nim c headerbar.nim
import gintro/[gtk4, glib, gobject]

const
  Css = """
 .main.background {
 background-image: linear-gradient(to bottom, red, blue);
 border-width: 0px;
 }
 .titlebar.backdrop {
 background-image: none;
 background-color: @bg_color;
 border-radius: 10px 10px 0px 0px;
 }
 .titlebar {
 background-image: linear-gradient(to bottom, white, @bg_color);
 border-radius: 10px 10px 0px 0px;
 }
"""

# we try to avoid use of global header variable as done in C code
type
  MyWindow = ref object of gtk4.Window
    header: gtk4.Widget

proc response(d: gtk4.FileChooserDialog; responseID: int) = gtk4.destroy(d)

proc onBookmarkClicked(button: Button; data: MyWindow) =
  let window = gtk4.Window(data)
  let chooser = newFileChooserDialog("File Chooser Test", window,
      FileChooserAction.open)
  discard chooser.addButton("_Close", gtk4.ResponseType.close.ord)
  chooser.connect("response", response)
  chooser.show

#proc changeSubtitle(button: Button; w: MyWindow) =
#  if w.header.subtitle == "":
#    w.header.setSubtitle("(subtle subtitle)")
#  else:
#    w.header.setSubtitle("") # can we pass nil?

proc toggleFullscreen(button: Button; window: MyWindow) =
  var fullscreen {.global.}: bool
  if fullscreen:
    window.unfullscreen
    fullscreen = false
  else:
    window.fullscreen
    fullscreen = true

proc toIntVal(i: int): Value =
  let gtype = typeFromName("gint")
  discard init(result, gtype)
  setInt(result, i)

var done = false

proc quit_cb(b: Button) = # we can not pass a var parameter
 #gtk4.mainQuit()
 done = true
 wakeup(defaultMainContext()) # g_main_context_wakeup (NULL);

proc changeHeader(button: ToggleButton; window: MyWindow) =
  if button != nil and button.getActive:
    window.header = (newBox(gtk4.Orientation.horizontal,
        10))
    addCssClass(window.header, "titlebar")
    addCssClass(window.header, "header-bar")
    #window.header.setProperty("margin_start", toIntVal(10))
    #window.header.setProperty("margin_end", toIntVal(10))
    #window.header.setProperty("margin_top", toIntVal(10))
    #window.header.setProperty("margin_bottom", toIntVal(10))
    window.header.setMarginStart(10)
    window.header.setMarginEnd(10)
    window.header.setMarginTop(10)
    window.header.setMarginBottom(10)
    let label = newLabel("Label")
    gtk4.Box(window.header).append(label)
    let levelBar = newLevelBar()
    levelBar.setValue(0.4)
    levelBar.setHexpand
    gtk4.Box(window.header).append(levelBar)
  else:
    window.header = newHeaderBar()
    #addClass(getStyleContext(window.header), "titlebar")
    addCssClass(window.header, "titlebar")
    #window.header.setTitle("Example header")
    var button = newButton("_Close")
    button.setUseUnderline
    addCssClass(button, "suggested-action")
    button.connect("clicked", quit_cb)
    gtk4.HeaderBar(window.header).packEnd(button)
    button = newButton()
    let image = newImageFromIconName("bookmark-new-symbolic")
    button.connect("clicked", onBookmarkClicked, window)
    button.setChild(image)
    gtk4.HeaderBar(window.header).packStart(button)
  window.setTitlebar(window.header)

proc main =
  gtk4.init()
  #var window: MyWindow
  let window = newWindow(MyWindow)
  addCssClass(window, "main") # gtk_widget_add_css_class (window, "main");
  let provider = newCssProvider()
  provider.loadFromData(Css)
  addProviderForDisplay(getDisplay(window), provider, STYLE_PROVIDER_PRIORITY_USER)
  changeHeader(nil, window)
  let box = newBox(Orientation.vertical, 0)
  window.setChild(box) # gtk_window_set_child (GTK_WINDOW (window), box);
  #window.add(box)
  let content = newImageFromIconName("start-here-symbolic")
  content.setPixelSize(512)
  content.setVexpand
  box.append(content)
  let footer = newActionBar()
  footer.setCenterWidget(newCheckButtonWithLabel("Middle"))
  let button = newToggleButtonWithLabel("Custom")
  button.connect("clicked", changeHeader, window)
  footer.packStart(button)
  #var button1 = newButton("Subtitle")
  #button1.connect("clicked", changeSubtitle, window)
  #footer.packEnd(button1)
  var button1 = newButton("Fullscreen")
  footer.packEnd(button1)
  button1.connect("clicked", toggleFullscreen, window)
  box.append(footer)
  window.show
  #gtk4.main()
  while not done:
    discard iteration(defaultMainContext(), true) # g_main_context_iteration (NULL, TRUE);
  destroy(window) # this is special for this example, see  https://discourse.gnome.org/t/tests-testgaction-c/2232/6

main() # 137 lines

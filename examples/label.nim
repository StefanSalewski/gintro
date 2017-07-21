# nim c label.nim
import gintro/[gtk, glib]
import gintro/gio except Application, newApplication

proc activate(app: Application) =
  let window = newApplicationWindow(app)
  let label = newLabel("Yellow text on green background")
  let cssProvider = newCssProvider()
  let data = "label {color: yellow; background: green;}"
  #discard cssProvider.loadFromPath("doesnotexist")
  discard cssProvider.loadFromData(data)
  let styleContext = label.getStyleContext
  assert styleContext != nil
  addProvider(styleContext, cssProvider, STYLE_PROVIDER_PRIORITY_USER)
  window.add(label)
  showAll(window)

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", activate)
  discard run(app)

main()

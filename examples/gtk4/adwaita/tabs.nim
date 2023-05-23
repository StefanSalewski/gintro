import gintro/[gtk4, gobject, gio, pango, adw]
import std/with

proc addNewPage(btn: Button, tabView: TabView) = 
  let page = tabView.append newLabel($tabView.nPages)
  page.title = $tabView.nPages

proc activate(app: gtk4.Application) =
  adw.init()

  let
    window = adw.newApplicationWindow(app)
    header = adw.newHeaderBar()
    mainBox = newBox(Orientation.vertical, 0)
    addNewPageBtn = newButtonFromIconName("list-add-symbolic")

    tabBar = newTabBar()

    tabView = newTabView()
    label1 = newLabel("content 1")
    label2 = newLabel("content 2")

  let page1 = tabView.append label1
  page1.title = "page 1"
  let page2 = tabView.append label2
  page2.title = "page 2"


  tabBar.view = tabView
  tabBar.endActionWidget = addNewPageBtn
  # let data: Data = (tabView, newLabel("page Num " & $tabView.nPages)) 
  # addNewPageBtn.connect("clicked", addNewPage, data)
  addNewPageBtn.connect("clicked", addNewPage, tabView)

  with mainBox: 
    append header
    append tabBar
    append tabView

  with window:
    child = mainBox
    title = "Main"
    defaultSize = (100, 300)
    show

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  discard run(app)

main()

import QtQuick
import QtQuick.Window
import WINUX11 1.0
Window {
 id:root
 width:1280
 height:720
 visible:true
 visibility:Window.FullScreen
 flags:Qt.Window | Qt.FramelessWindowHint
 color:Theme.backgroundDeep
 property bool startOpen:false
 property bool searchOpen:false
 property bool quickSettingsOpen:false
 property string activeApp:""
 property string activeTitle:""
 function launch(command) {
  var titles = {
   explorer:"File Explorer", browser:"WINUX11 Browser", terminal:"WINUX11 Terminal",
   settings:"Settings", taskmanager:"Task Manager", editor:"Text Editor", calculator:"Calculator",
   network:"Network", security:"Security Center", notifications:"Notification Center",
   about:"About WINUX11", compatibility:"Windows Compatibility",
   disk:"Disk Management", storage:"Storage", wifi:"Wi-Fi Manager", bluetooth:"Bluetooth Manager",
   updates:"System Updates", firewall:"Firewall Manager", accounts:"Users & Accounts",
   startup:"Startup Apps", packages:"Package Manager", developer:"Developer Tools",
   display:"Display", sound:"Sound Manager", screenshot:"Screenshot Tool",
   clock:"Clock", calendar:"Calendar", privacy:"Privacy Center"
  }
  activeApp = command
  activeTitle = titles[command] || "WINUX11"
  startOpen = false
  searchOpen = false
 }
 Desktop { anchors.fill:parent; z:0 }
 StartMenu {
  id:startMenu
  width:Math.min(root.width-56,760)
  height:Math.min(root.height-145,620)
  anchors.left:parent.left
  anchors.bottom:taskbar.top
  anchors.leftMargin:28
  anchors.bottomMargin:8
  z:700
  open:root.startOpen
  onSearchRequested: function() { root.startOpen=false; root.searchOpen=true }
  onLaunch: function(command) { root.launch(command) }
 }
 Search {
  id:search
  anchors.fill:parent
  z:800
  open:root.searchOpen
  onLaunch: function(command) { root.launch(command) }
 }
 Taskbar {
  id:taskbar
  z:1000
  startOpen:root.startOpen
  searchOpen:root.searchOpen
  quickSettingsOpen:root.quickSettingsOpen
  onStartClicked: function() { root.startOpen=!root.startOpen }
  onSearchClicked: function() { root.searchOpen=!root.searchOpen }
  onLaunch: function(command) { root.launch(command) }
  onQuickSettingsOpenChanged: root.quickSettingsOpen=quickSettingsOpen
 }
 QuickSettings {
  id:quickSettings
  width:380
  height:470
  anchors.right:parent.right
  anchors.bottom:taskbar.top
  anchors.rightMargin:22
  anchors.bottomMargin:8
  z:1100
  open:root.quickSettingsOpen
 }
 AppWindow {
  id:appWindow
  z:1200
  appId:root.activeApp
  title:root.activeTitle
  onClosed: root.activeApp=""
  onMinimized: root.activeApp=""
 }
}
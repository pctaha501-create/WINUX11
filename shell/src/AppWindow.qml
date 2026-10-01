import QtQuick
import WINUX11 1.0
Item{
 id:root
 property string title:"WINUX11"
 property string appId:""
 signal closed()
 signal minimized()
 anchors.fill:parent
 visible:appId.length>0
 z:900
 function appSource(id){var s={terminal:"qrc:/qt/qml/WINUX11/apps/TerminalApp.qml",browser:"qrc:/qt/qml/WINUX11/apps/BrowserApp.qml",explorer:"qrc:/qt/qml/WINUX11/apps/ExplorerApp.qml",settings:"qrc:/qt/qml/WINUX11/apps/SettingsApp.qml",taskmanager:"qrc:/qt/qml/WINUX11/apps/TaskManagerApp.qml",editor:"qrc:/qt/qml/WINUX11/apps/TextEditorApp.qml",calculator:"qrc:/qt/qml/WINUX11/apps/CalculatorApp.qml",network:"qrc:/qt/qml/WINUX11/apps/NetworkApp.qml",security:"qrc:/qt/qml/WINUX11/apps/SecurityApp.qml",notifications:"qrc:/qt/qml/WINUX11/apps/NotificationsApp.qml",about:"qrc:/qt/qml/WINUX11/apps/AboutApp.qml",compatibility:"qrc:/qt/qml/WINUX11/apps/CompatibilityApp.qml"};return s[id]||"qrc:/qt/qml/WINUX11/apps/GenericApp.qml"}
 Rectangle{anchors.fill:parent;color:"#aa000000";visible:root.visible}
 GlassPanel{id:frame;width:Math.min(parent.width-90,1240);height:Math.min(parent.height-145,760);anchors.centerIn:parent;radius:20;glassColor:"#F51A2533";borderColor:"#70FFFFFF"
  Text{anchors.left:parent.left;anchors.leftMargin:20;anchors.verticalCenter:parent.top;anchors.verticalCenterOffset:27;text:root.title;color:"#FFFFFF";font.pixelSize:14;font.weight:Font.DemiBold}
  Row{anchors.right:parent.right;anchors.rightMargin:12;anchors.top:parent.top;anchors.topMargin:10;spacing:7
   Rectangle{width:32;height:32;radius:10;color:"#22FFFFFF";Text{anchors.centerIn:parent;text:"—";color:"#FFFFFF";font.pixelSize:18};MouseArea{anchors.fill:parent;onClicked:root.minimized()}}
   Rectangle{width:32;height:32;radius:10;color:"#22FFFFFF";Text{anchors.centerIn:parent;text:"×";color:"#FFFFFF";font.pixelSize:21};MouseArea{anchors.fill:parent;onClicked:root.closed()}}
  }
  Loader{anchors.fill:parent;anchors.topMargin:54;anchors.margins:1;source:root.appId.length?root.appSource(root.appId):""}
 }
}
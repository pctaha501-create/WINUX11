import QtQuick
import QtQuick.Controls
Item{anchors.fill:parent
 Rectangle{anchors.fill:parent;radius:18;color:"#ee0b1018";border.color:"#55ffffff";border.width:1}
 Column{anchors.fill:parent;anchors.margins:24;spacing:14
  Text{text:"Network";color:"#ffffff";font.pixelSize:26;font.bold:true}
  Text{text:systemService.networkEnabled?"Network is enabled":"Network is disabled";color:"#ffffff"}
  Row{spacing:10;Button{text:"Enable";onClicked:systemService.toggleNetwork()};Button{text:"Disable";onClicked:systemService.toggleNetwork()};Button{text:"Refresh";onClicked:systemService.refresh()}}
  Text{text:"WINUX11 uses the native Linux network stack for actual interface management.";color:"#bfffffff";wrapMode:Text.WordWrap;width:parent.width}
 }}
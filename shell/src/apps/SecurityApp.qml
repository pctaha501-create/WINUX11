import QtQuick
import QtQuick.Controls
Item{anchors.fill:parent
 Rectangle{anchors.fill:parent;radius:18;color:"#ee0b1018";border.color:"#55ffffff";border.width:1}
 Column{anchors.fill:parent;anchors.margins:24;spacing:14
  Text{text:"WINUX11 Security";color:"#ffffff";font.pixelSize:26;font.bold:true}
  Text{text:"System security center";color:"#ffffff"}
  Text{text:"Live process visibility and system controls are available through the native service layer.";color:"#bfffffff";wrapMode:Text.WordWrap;width:parent.width}
  Button{text:"Refresh system state";onClicked:systemService.refresh()}
  Button{text:"Open system settings";onClicked:systemService.openSettings()}
 }}
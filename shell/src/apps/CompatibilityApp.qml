import QtQuick
import QtQuick.Controls
Item{anchors.fill:parent
 Rectangle{anchors.fill:parent;radius:18;color:"#ee0b1018";border.color:"#55ffffff";border.width:1}
 Column{anchors.fill:parent;anchors.margins:24;spacing:14
  Text{text:"Windows Compatibility";color:"#ffffff";font.pixelSize:26;font.bold:true}
  Text{text:compatibilityService.wineAvailable?"Wine is available":"Wine is not installed";color:"#ffffff"}
  Text{text:compatibilityService.wineVersion;color:"#bfffffff"}
  Text{text:compatibilityService.protonAvailable?"Proton detected":"Proton not detected";color:"#ffffff"}
  Button{text:"Refresh";onClicked:compatibilityService.refresh()}
  Text{text:"Windows programs can be launched through Wine or Proton when the runtime is installed.";color:"#bfffffff";wrapMode:Text.WordWrap;width:parent.width}
 }}
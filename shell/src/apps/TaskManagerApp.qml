import QtQuick
import QtQuick.Controls
Item{anchors.fill:parent;property string snapshot:systemService.processSnapshot()
 Timer{interval:1500;running:true;repeat:true;onTriggered:snapshot=systemService.processSnapshot()}
 Rectangle{anchors.fill:parent;radius:18;color:"#ee0b1018";border.color:"#55ffffff";border.width:1}
 Column{anchors.fill:parent;anchors.margins:18;spacing:10
  Text{text:"Task Manager";color:"#ffffff";font.pixelSize:24;font.bold:true}
  Text{text:"PID    CPU    MEM    COMMAND";color:"#ffffff";font.bold:true}
  ScrollView{width:parent.width;height:parent.height-60;TextArea{width:parent.width;text:snapshot;readOnly:true;color:"#ffffff";wrapMode:TextArea.NoWrap;background:Rectangle{color:"#22000000";radius:10}}}
 }}
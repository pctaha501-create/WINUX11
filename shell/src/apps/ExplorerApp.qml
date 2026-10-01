import QtQuick
import QtQuick.Controls
Item{anchors.fill:parent;property string currentPath:fileService.homePath();property var entries:[]
 function refresh(){entries=fileService.list(currentPath)}
 Component.onCompleted:refresh()
 Rectangle{anchors.fill:parent;radius:18;color:"#ee0b1018";border.color:"#55ffffff";border.width:1}
 Column{anchors.fill:parent;anchors.margins:14;spacing:10
  Row{width:parent.width;spacing:8
   Button{text:"↑";onClicked:{var p=currentPath.split("/");if(p.length>1)p.pop();currentPath=p.join("/")||"/";refresh()}}
   TextField{id:pathBox;width:parent.width-90;text:currentPath;color:"#ffffff";background:Rectangle{radius:9;color:"#331c2330";border.color:"#44ffffff"};onAccepted:{currentPath=text;refresh()}}
   Button{text:"↻";onClicked:refresh()}
  }
  ListView{width:parent.width;height:parent.height-64;clip:true;model:entries
   delegate:Rectangle{width:ListView.view.width;height:42;radius:8;color:mouse.containsMouse?"#22ffffff":"transparent"
    Text{anchors.left:parent.left;anchors.leftMargin:12;anchors.verticalCenter:parent.verticalCenter;text:modelData;color:"#ffffff";elide:Text.ElideRight}
    MouseArea{id:mouse;anchors.fill:parent;hoverEnabled:true;onDoubleClicked:fileService.open(currentPath+"/"+modelData)}
   }}
 }}
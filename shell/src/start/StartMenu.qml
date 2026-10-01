import QtQuick
import WINUX11 1.0
Item{
 id:root
 property bool open:false
 signal searchRequested()
 signal launch(string command)
 visible:open;opacity:open?1:0;scale:open?1:0.97
 Behavior on opacity{NumberAnimation{duration:140}}
 Behavior on scale{NumberAnimation{duration:160;easing.type:Easing.OutCubic}}
 GlassPanel{anchors.fill:parent;radius:24;glassColor:"#F2192431";borderColor:"#66FFFFFF"
  Column{anchors.fill:parent;anchors.margins:24;spacing:16
   Text{text:"WINUX11";color:"#FFFFFF";font.pixelSize:24;font.bold:true}
   Text{text:"Pinned applications";color:"#FFFFFF";font.pixelSize:13}
   Grid{width:parent.width;columns:4;rowSpacing:10;columnSpacing:10
    Repeater{model:[{n:"Explorer",c:"explorer"},{n:"Browser",c:"browser"},{n:"Terminal",c:"terminal"},{n:"Settings",c:"settings"},{n:"Calculator",c:"calculator"},{n:"Editor",c:"editor"},{n:"Network",c:"network"},{n:"Security",c:"security"},{n:"Task Manager",c:"taskmanager"},{n:"Compatibility",c:"compatibility"},{n:"Disk Management",c:"disk"},{n:"Storage",c:"storage"},{n:"Wi-Fi",c:"wifi"},{n:"Bluetooth",c:"bluetooth"},{n:"Updates",c:"updates"},{n:"Firewall",c:"firewall"},{n:"Accounts",c:"accounts"},{n:"Startup Apps",c:"startup"},{n:"Packages",c:"packages"},{n:"Developer Tools",c:"developer"},{n:"Display",c:"display"},{n:"Sound",c:"sound"},{n:"Screenshot",c:"screenshot"},{n:"Clock",c:"clock"},{n:"Calendar",c:"calendar"},{n:"Privacy",c:"privacy"}]
     delegate:Rectangle{width:(parent.width-30)/4;height:78;radius:14;color:mouse.containsMouse?"#33465D78":"#1E16202C";border.color:"#35FFFFFF";border.width:1
      Text{anchors.centerIn:parent;text:modelData.n;color:"#FFFFFF";font.pixelSize:11}
      MouseArea{id:mouse;anchors.fill:parent;hoverEnabled:true;onClicked:root.launch(modelData.c)}
     }}
   }
   Rectangle{width:parent.width;height:54;radius:14;color:"#1E16202C";border.color:"#35FFFFFF"
    Text{anchors.left:parent.left;anchors.leftMargin:16;anchors.verticalCenter:parent.verticalCenter;text:"Search apps, settings and files";color:"#C8D3E1";font.pixelSize:12}
    MouseArea{anchors.fill:parent;onClicked:root.searchRequested()}
   }
  }
 }
}
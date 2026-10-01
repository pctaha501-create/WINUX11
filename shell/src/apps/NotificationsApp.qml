import QtQuick
import WINUX11 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"
        Text { x:24; y:20; text:"Notifications"; color:"#FFFFFF"; font.pixelSize:25; font.weight:Font.DemiBold }
        Text { x:24; y:56; text:"Notification center"; color:Theme.textMuted; font.pixelSize:12 }

        Rectangle {
            x:24; y:100; width:parent.width-48; height:100; radius:18
            color:"#14000000"; border.width:1; border.color:"#24FFFFFF"
            Text { x:16; y:16; text:"WINUX11"; color:"#FFFFFF"; font.pixelSize:13 }
            Text { x:16; y:44; text:"No new notifications."; color:Theme.textMuted; font.pixelSize:12 }
        }
    }
}
import QtQuick
import WINUX11 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"

        Text { x:24; y:20; text:"Network"; color:"#FFFFFF"; font.pixelSize:25; font.weight:Font.DemiBold }
        Text { x:24; y:56; text:"Connectivity and adapter control"; color:Theme.textMuted; font.pixelSize:12 }

        Rectangle {
            x:24; y:100; width:parent.width-48; height:86; radius:18
            color:"#14000000"; border.width:1; border.color:"#24FFFFFF"
            Text { x:16; y:16; text:"Network"; color:"#FFFFFF"; font.pixelSize:13 }
            Text { x:16; y:46; text:systemService.networkEnabled ? "Connected / enabled" : "Disabled"; color:systemService.networkEnabled ? Theme.success : Theme.danger; font.pixelSize:12 }
            MouseArea { anchors.fill:parent; onClicked:systemService.toggleNetwork() }
        }

        Rectangle {
            x:24; y:198; width:parent.width-48; height:86; radius:18
            color:"#14000000"; border.width:1; border.color:"#24FFFFFF"
            Text { x:16; y:16; text:"Bluetooth"; color:"#FFFFFF"; font.pixelSize:13 }
            Text { x:16; y:46; text:systemService.bluetoothEnabled ? "Powered" : "Off"; color:systemService.bluetoothEnabled ? Theme.success : Theme.textMuted; font.pixelSize:12 }
            MouseArea { anchors.fill:parent; onClicked:systemService.toggleBluetooth() }
        }
    }
}
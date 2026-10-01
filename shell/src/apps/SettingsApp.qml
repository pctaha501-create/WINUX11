import QtQuick
import WINUX11 1.0

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: "#E80A0E14"

        Text {
            x: 24; y: 20
            text: "Settings"
            color: "#FFFFFF"
            font.pixelSize: 25
            font.weight: Font.DemiBold
        }

        Text {
            x: 25; y: 54
            text: "WINUX11 system configuration"
            color: Theme.textMuted
            font.pixelSize: 12
        }

        Column {
            x: 24
            y: 98
            width: parent.width - 48
            spacing: 10

            Repeater {
                model: [
                    {name:"Network", state:function(){return systemService.networkEnabled}, action:function(){systemService.toggleNetwork()}},
                    {name:"Bluetooth", state:function(){return systemService.bluetoothEnabled}, action:function(){systemService.toggleBluetooth()}}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: parent.width
                    height: 58
                    radius: 16
                    color: "#14000000"
                    border.width: 1
                    border.color: "#24FFFFFF"

                    Text {
                        x: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.name
                        color: "#FFFFFF"
                        font.pixelSize: 13
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.state() ? "ON" : "OFF"
                        color: modelData.state() ? Theme.success : Theme.textMuted
                        font.pixelSize: 11
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.action()
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 86
                radius: 18
                color: "#14000000"
                border.width: 1
                border.color: "#24FFFFFF"

                Text { x: 16; y: 15; text: "Audio"; color:"#FFFFFF"; font.pixelSize:13 }
                Text { x: 16; y: 43; text: systemService.volume + "%"; color:Theme.accent; font.pixelSize:22; font.weight:Font.DemiBold }
            }

            Rectangle {
                width: parent.width
                height: 58
                radius: 16
                color: "#14000000"
                border.width: 1
                border.color: "#24FFFFFF"
                Text { x:16; anchors.verticalCenter:parent.verticalCenter; text:"Open desktop settings"; color:"#FFFFFF"; font.pixelSize:13 }
                MouseArea { anchors.fill:parent; onClicked:systemService.openSettings() }
            }
        }
    }
}
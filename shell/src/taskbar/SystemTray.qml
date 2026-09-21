import QtQuick
import WINUX11 1.0

Item {
    id: root
    width: 270
    height: 42

    property bool panelOpen: false
    signal panelToggled()

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        TaskbarButton {
            iconSource: "../../assets/icons/network.svg"
            label: "Wi-Fi"
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            iconSource: "../../assets/icons/volume.svg"
            label: "Volume"
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            iconSource: "../../assets/icons/settings.svg"
            label: "Settings"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatTime(new Date(), "HH:mm")
            color: "#FFFFFF"
            font.pixelSize: 13
            font.weight: Font.Medium

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }
    }

    GlassPanel {
        id: panel
        z: 100
        width: 360
        height: 410
        anchors.right: parent.right
        anchors.bottom: parent.top
        anchors.bottomMargin: 10
        glassColor: "#F00A0E15"
        borderColor: "#50FFFFFF"
        visible: root.panelOpen
        opacity: root.panelOpen ? 1 : 0
        scale: root.panelOpen ? 1 : 0.94
        transformOrigin: Item.BottomRight

        Behavior on opacity { NumberAnimation { duration: 150 } }
        Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

        Text {
            x: 22
            y: 20
            text: "Quick Settings"
            color: "#FFFFFF"
            font.pixelSize: 20
            font.weight: Font.DemiBold
        }

        Text {
            x: 22
            y: 50
            text: "System controls"
            color: "#FFFFFF"
            font.pixelSize: 12
        }

        Grid {
            x: 22
            y: 88
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: [
                    {name:"Network", icon:"network.svg"},
                    {name:"Bluetooth", icon:"bluetooth.svg"},
                    {name:"Night light", icon:"moon.svg"},
                    {name:"Focus", icon:"focus.svg"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: 153
                    height: 72
                    radius: 15
                    color: mouse.containsMouse ? "#22FFFFFF" : "#14000000"
                    border.width: 1
                    border.color: "#28FFFFFF"

                    Image {
                        x: 15
                        anchors.verticalCenter: parent.verticalCenter
                        width: 25
                        height: 25
                        source: "../../assets/icons/" + modelData.icon
                        sourceSize: Qt.size(50, 50)
                    }

                    Text {
                        x: 53
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.name
                        color: "#FFFFFF"
                        font.pixelSize: 13
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }
            }
        }

        Rectangle {
            x: 22
            y: 278
            width: 316
            height: 1
            color: "#24FFFFFF"
        }

        Text {
            x: 22
            y: 300
            text: "Audio"
            color: "#FFFFFF"
            font.pixelSize: 12
        }

        Text {
            x: 22
            y: 326
            text: audioService ? (audioService.muted ? "Muted" : audioService.volume + "%") : "40%"
            color: "#FFFFFF"
            font.pixelSize: 26
            font.weight: Font.DemiBold
        }

        Rectangle {
            x: 22
            y: 370
            width: 316
            height: 7
            radius: 4
            color: "#20FFFFFF"

            Rectangle {
                width: parent.width * ((audioService ? audioService.volume : 40) / 100)
                height: parent.height
                radius: 4
                color: Theme.accent
            }
        }
    }
}

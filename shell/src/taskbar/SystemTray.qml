import QtQuick
import WINUX11 1.0

Item {
    id: root
    width: 190
    height: 62

    property bool panelOpen: false
    signal panelToggled()

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        TaskbarButton {
            width: 48
            height: 48
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/network.svg"
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            width: 48
            height: 48
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/volume.svg"
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            width: 48
            height: 48
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/settings.svg"
            onClicked: root.panelToggled()
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatTime(new Date(), "HH:mm")
            color: Theme.textPrimary
            font.pixelSize: 15
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
        width: 380
        height: 440
        anchors.right: parent.right
        anchors.bottom: parent.top
        anchors.bottomMargin: 14
        glassColor: "#EE0D252E"
        borderColor: "#99A9EAF4"
        visible: root.panelOpen
        opacity: root.panelOpen ? 1 : 0
        scale: root.panelOpen ? 1 : 0.88
        transformOrigin: Item.BottomRight

        Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
        Behavior on scale { NumberAnimation { duration: 240; easing.type: Easing.OutBack } }

        Text {
            x: 24
            y: 22
            text: "Quick Settings"
            color: Theme.textPrimary
            font.pixelSize: 22
            font.weight: Font.DemiBold
        }

        Text {
            x: 24
            y: 56
            text: "Water Flow controls"
            color: Theme.textSecondary
            font.pixelSize: 13
        }

        Grid {
            x: 24
            y: 98
            columns: 2
            rowSpacing: 12
            columnSpacing: 12

            Repeater {
                model: [
                    {name:"Wi-Fi", icon:"network.svg"},
                    {name:"Bluetooth", icon:"bluetooth.svg"},
                    {name:"Night light", icon:"moon.svg"},
                    {name:"Focus", icon:"focus.svg"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: 158
                    height: 86
                    radius: 18
                    color: mouse.containsMouse ? "#2BFFFFFF" : "#182D4650"
                    border.width: 1
                    border.color: "#55B8EAF2"

                    Image {
                        x: 16
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 30
                        source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        x: 58
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.name
                        color: Theme.textPrimary
                        font.pixelSize: 14
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
            x: 24
            y: 292
            width: 332
            height: 1
            color: "#48C5EAF4"
        }

        Text {
            x: 24
            y: 314
            text: "Audio"
            color: Theme.textSecondary
            font.pixelSize: 13
        }

        Text {
            x: 24
            y: 340
            text: audioService ? (audioService.muted ? "Muted" : audioService.volume + "%") : "40%"
            color: Theme.textPrimary
            font.pixelSize: 28
            font.weight: Font.DemiBold
        }

        Rectangle {
            x: 24
            y: 386
            width: 332
            height: 8
            radius: 4
            color: "#24485B64"

            Rectangle {
                width: parent.width * ((audioService ? audioService.volume : 40) / 100)
                height: parent.height
                radius: 4
                color: Theme.accent
            }
        }
    }
}
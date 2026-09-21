import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool open: false
    signal searchRequested()
    signal launch(string command)

    width: 760
    height: 600
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.92
    visible: opacity > 0
    transformOrigin: Item.Bottom

    Behavior on opacity { NumberAnimation { duration: 170; easing.type: Easing.OutCubic } }
    Behavior on scale { NumberAnimation { duration: 240; easing.type: Easing.OutBack } }

    GlassPanel {
        anchors.fill: parent
        glassColor: "#F00D2730"
        borderColor: "#99A9EAF4"

        Text {
            x: 32
            y: 28
            text: "WINUX11"
            color: Theme.textPrimary
            font.pixelSize: 28
            font.weight: Font.DemiBold
        }

        Text {
            x: 34
            y: 66
            text: "Start"
            color: Theme.textSecondary
            font.pixelSize: 14
        }

        Rectangle {
            x: 30
            y: 104
            width: parent.width - 60
            height: 56
            radius: 18
            color: "#213D5058"
            border.width: 1
            border.color: "#55B8EAF2"

            Image {
                x: 17
                anchors.verticalCenter: parent.verticalCenter
                width: 24
                height: 24
                source: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
            }

            Text {
                x: 54
                anchors.verticalCenter: parent.verticalCenter
                text: "Search apps, files and settings"
                color: Theme.textSecondary
                font.pixelSize: 15
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.searchRequested()
            }
        }

        Grid {
            x: 30
            y: 184
            columns: 4
            columnSpacing: 12
            rowSpacing: 12

            Repeater {
                model: [
                    {name:"File Explorer", icon:"explorer.svg", cmd:"explorer"},
                    {name:"Browser", icon:"browser.svg", cmd:"browser"},
                    {name:"Terminal", icon:"terminal.svg", cmd:"terminal"},
                    {name:"Network", icon:"network.svg", cmd:"network"},
                    {name:"Settings", icon:"settings.svg", cmd:"settings"},
                    {name:"Security", icon:"focus.svg", cmd:"security"},
                    {name:"Notifications", icon:"notifications.svg", cmd:"notifications"},
                    {name:"Audio", icon:"volume.svg", cmd:"audio"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: 166
                    height: 112
                    radius: 20
                    color: mouse.containsMouse ? "#2DFFFFFF" : "#172C424A"
                    border.width: 1
                    border.color: "#45B8EAF2"
                    scale: mouse.pressed ? 0.96 : (mouse.containsMouse ? 1.025 : 1)

                    Behavior on scale { NumberAnimation { duration: 140; easing.type: Easing.OutCubic } }

                    Image {
                        x: 18
                        y: 20
                        width: 32
                        height: 32
                        source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon
                    }

                    Text {
                        x: 18
                        y: 65
                        text: modelData.name
                        color: Theme.textPrimary
                        font.pixelSize: 14
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: root.launch(modelData.cmd)
                    }
                }
            }
        }
    }
}
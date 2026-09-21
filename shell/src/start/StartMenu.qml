import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool open: false
    signal searchRequested()
    signal launch(string command)

    width: 720
    height: 560
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.94
    visible: opacity > 0
    transformOrigin: Item.Bottom

    Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
    Behavior on scale { NumberAnimation { duration: 190; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        glassColor: "#F00B1018"
        borderColor: "#45FFFFFF"

        Text {
            x: 28
            y: 24
            text: "WINUX11"
            color: "#FFFFFF"
            font.pixelSize: 25
            font.weight: Font.DemiBold
        }

        Text {
            x: 30
            y: 57
            text: "Start"
            color: "#FFFFFF"
            font.pixelSize: 12
        }

        Rectangle {
            x: 26
            y: 90
            width: parent.width - 52
            height: 50
            radius: 16
            color: "#16000000"
            border.width: 1
            border.color: "#32FFFFFF"

            Image {
                x: 15
                anchors.verticalCenter: parent.verticalCenter
                width: 21
                height: 21
                source: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
                sourceSize: Qt.size(42, 42)
            }

            Text {
                x: 50
                anchors.verticalCenter: parent.verticalCenter
                text: "Search apps, files and settings"
                color: "#FFFFFF"
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.searchRequested()
            }
        }

        Text {
            x: 28
            y: 164
            text: "Pinned"
            color: "#FFFFFF"
            font.pixelSize: 13
        }

        Grid {
            x: 26
            y: 198
            columns: 4
            columnSpacing: 10
            rowSpacing: 10

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
                    width: 164
                    height: 100
                    radius: 16
                    color: mouse.containsMouse ? "#20FFFFFF" : "#10000000"
                    border.width: 1
                    border.color: "#24FFFFFF"
                    scale: mouse.pressed ? 0.97 : (mouse.containsMouse ? 1.02 : 1)

                    Behavior on scale { NumberAnimation { duration: 110 } }

                    Image {
                        x: 17
                        y: 17
                        width: 28
                        height: 28
                        source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon
                        sourceSize: Qt.size(56, 56)
                    }

                    Text {
                        x: 17
                        y: 62
                        text: modelData.name
                        color: "#FFFFFF"
                        font.pixelSize: 13
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

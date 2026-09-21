import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool open: false
    signal launch(string command)

    anchors.fill: parent
    visible: open
    opacity: open ? 1 : 0

    Rectangle {
        anchors.fill: parent
        color: "#28030B10"
        visible: root.open
    }

    GlassPanel {
        width: 720
        height: 520
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 86
        glassColor: "#F00C252E"
        borderColor: "#A0B4EDF5"
        scale: root.open ? 1 : 0.94
        opacity: root.open ? 1 : 0

        Behavior on scale { NumberAnimation { duration: 230; easing.type: Easing.OutBack } }
        Behavior on opacity { NumberAnimation { duration: 170 } }

        Text {
            x: 28
            y: 24
            text: "Search"
            color: Theme.textPrimary
            font.pixelSize: 24
            font.weight: Font.DemiBold
        }

        Rectangle {
            x: 28
            y: 72
            width: parent.width - 56
            height: 60
            radius: 18
            color: "#233A515A"
            border.width: 1
            border.color: "#65B8EAF2"

            Image {
                x: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 26
                height: 26
                source: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
            }

            TextInput {
                id: input
                x: 58
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 75
                color: Theme.textPrimary
                selectionColor: Theme.accent
                font.pixelSize: 17
                focus: root.open
                clip: true
                placeholderText: "Type to search..."
                placeholderTextColor: Theme.textMuted
            }
        }

        Text {
            x: 30
            y: 158
            text: input.text.length === 0 ? "Quick actions" : "Results"
            color: Theme.textSecondary
            font.pixelSize: 14
        }

        Column {
            x: 28
            y: 194
            width: parent.width - 56
            spacing: 10

            Repeater {
                model: [
                    {name:"File Explorer", desc:"Browse files and folders", icon:"explorer.svg", cmd:"explorer"},
                    {name:"Terminal", desc:"Open the WINUX11 terminal", icon:"terminal.svg", cmd:"terminal"},
                    {name:"Settings", desc:"System settings", icon:"settings.svg", cmd:"settings"},
                    {name:"Browser", desc:"Open the web browser", icon:"browser.svg", cmd:"browser"}
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: parent.width
                    height: 64
                    radius: 16
                    color: mouse.containsMouse ? "#2DFFFFFF" : "#152A4148"

                    Image {
                        x: 15
                        anchors.verticalCenter: parent.verticalCenter
                        width: 30
                        height: 30
                        source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon
                    }

                    Text {
                        x: 58
                        y: 13
                        text: modelData.name
                        color: Theme.textPrimary
                        font.pixelSize: 15
                    }

                    Text {
                        x: 58
                        y: 36
                        text: modelData.desc
                        color: Theme.textSecondary
                        font.pixelSize: 12
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
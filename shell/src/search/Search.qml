import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    signal launch(string command)

    visible: open
    opacity: open ? 1 : 0
    anchors.fill: parent

    Rectangle { anchors.fill: parent; color: "#88000000" }

    GlassPanel {
        width: Math.min(parent.width - 120, 820)
        height: 520
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 70
        radius: 28
        glassColor: "#F20A1019"
        borderColor: "#45FFFFFF"

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            Rectangle {
                width: parent.width
                height: 58
                radius: 18
                color: "#18FFFFFF"
                border.width: 1
                border.color: "#28FFFFFF"

                TextInput {
                    id: input
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 18
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    color: Theme.textPrimary
                    selectionColor: Theme.accent
                    font.pixelSize: 16
                    focus: root.open
                    onTextChanged: results.visible = text.length > 0
                }
                Text {
                    anchors.left: input.left
                    anchors.verticalCenter: input.verticalCenter
                    text: "Search apps, settings and files"
                    color: Theme.textMuted
                    font.pixelSize: 14
                    visible: input.text.length === 0
                }
            }

            Text { text: input.text.length ? "Results" : "Quick launch"; color: Theme.textSecondary; font.pixelSize: 11 }

            Column {
                id: results
                width: parent.width
                spacing: 8
                visible: true

                Repeater {
                    model: [
                        {n:"File Explorer",d:"Browse files and folders",g:"▣",c:"explorer"},
                        {n:"Settings",d:"System configuration",g:"⚙",c:"settings"},
                        {n:"Terminal",d:"Command line",g:">_",c:"terminal"},
                        {n:"Task Manager",d:"Processes and resources",g:"▤",c:"taskmanager"},
                        {n:"Browser",d:"Web browser",g:"◉",c:"browser"}
                    ]
                    delegate: Rectangle {
                        width: results.width
                        height: 54
                        radius: 14
                        color: mouse.containsMouse ? "#18FFFFFF" : "#0AFFFFFF"
                        Text { x: 16; anchors.verticalCenter: parent.verticalCenter; text: modelData.g; color: Theme.textPrimary; font.pixelSize: 19 }
                        Text { x: 54; y: 10; text: modelData.n; color: Theme.textPrimary; font.pixelSize: 11; font.weight: Font.Medium }
                        Text { x: 54; y: 29; text: modelData.d; color: Theme.textMuted; font.pixelSize: 9 }
                        MouseArea { id: mouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.launch(modelData.c) }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: root.open = false
    }
}

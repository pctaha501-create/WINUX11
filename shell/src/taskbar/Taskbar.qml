import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool startOpen: false
    property bool searchOpen: false

    signal startClicked()
    signal searchClicked()
    signal launch(string command)

    height: 78
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    GlassPanel {
        id: bar

        width: Math.min(parent.width - 32, 930)
        height: 62
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        radius: 20
        glassColor: "#e611141b"
        borderColor: "#353c47"

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 9
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3

            TaskbarButton {
                iconText: "⊞"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                iconText: "⌕"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            Rectangle {
                width: 1
                height: 28
                color: "#303641"
                anchors.verticalCenter: parent.verticalCenter
            }

            TaskbarButton {
                iconText: "▣"
                label: "File Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                iconText: "◎"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                iconText: ">"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }
        }

        SystemTray {
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}

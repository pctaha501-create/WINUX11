import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: Theme.taskbarHeight

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    signal startClicked()
    signal searchClicked()
    signal launch(string command)

    GlassPanel {
        id: bar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: Math.min(parent.width - 32, 1180)
        height: 92
        radius: 32
        glassColor: "#B5163D49"
        borderColor: "#A8DDF8FF"

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/explorer.svg"
                label: "Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/browser.svg"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/terminal.svg"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }
        }

        Rectangle {
            width: 1
            height: 54
            anchors.verticalCenter: parent.verticalCenter
            x: 480
            color: "#78D9F7FF"
        }

        SystemTray {
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            panelOpen: root.quickSettingsOpen
            onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
        }
    }
}

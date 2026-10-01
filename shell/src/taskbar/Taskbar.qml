import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 76

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false

    signal startClicked()
    signal searchClicked()
    signal launch(string command)

    GlassPanel {
        id: bar
        width: Math.min(parent.width - 48, 1120)
        height: 58
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        radius: 20
        glassColor: "#D90A0F18"
        borderColor: "#42FFFFFF"
        borderWidth: 1

        Row {
            id: left
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/start.svg"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/search.svg"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }
        }

        Row {
            id: apps
            anchors.centerIn: parent
            spacing: 4

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/explorer.svg"
                label: "Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/browser.svg"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/terminal.svg"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }

            TaskbarButton {
                width: 42; height: 42
                iconSource: "../assets/icons/settings.svg"
                label: "Settings"
                onClicked: root.launch("settings")
            }
        }

        Rectangle {
            id: divider
            width: 1
            height: 30
            anchors.right: tray.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            color: "#35FFFFFF"
        }

        SystemTray {
            id: tray
            width: 285
            height: 46
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            panelOpen: root.quickSettingsOpen
            onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
        }
    }
}

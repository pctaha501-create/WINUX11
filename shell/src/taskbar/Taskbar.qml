import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 70

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    signal startClicked()
    signal searchClicked()
    signal launch(string command)

    GlassPanel {
        id: bar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: Math.min(parent.width - 24, 1440)
        height: 54
        radius: 18
        glassColor: "#E50A0E15"
        borderColor: "#55FFFFFF"
        borderWidth: 1

        // System controls stay on the right.
        SystemTray {
            id: systemTray
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            width: 245
            height: 44
            panelOpen: root.quickSettingsOpen
            onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
        }

        // App launcher icons stay centered.
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 6

            TaskbarButton {
                width: 44
                height: 44
                iconSource: "../../assets/icons/start.svg"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                width: 44
                height: 44
                iconSource: "../../assets/icons/search.svg"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            Rectangle {
                width: 1
                height: 28
                anchors.verticalCenter: parent.verticalCenter
                color: "#35FFFFFF"
            }

            TaskbarButton {
                width: 44
                height: 44
                iconSource: "../../assets/icons/explorer.svg"
                label: "Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                width: 44
                height: 44
                iconSource: "../../assets/icons/browser.svg"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                width: 44
                height: 44
                iconSource: "../../assets/icons/terminal.svg"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }
        }
    }
}
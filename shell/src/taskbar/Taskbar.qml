import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 82

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
        anchors.bottomMargin: 16
        width: Math.min(parent.width - 32, 1180)
        height: 60
        radius: 20
        glassColor: "#E50A0E15"
        borderColor: "#55FFFFFF"
        borderWidth: 1

        Row {
            anchors.centerIn: parent
            spacing: 10

            TaskbarButton {
                width: 50
                height: 50
                iconSource: "../../assets/icons/start.svg"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                width: 50
                height: 50
                iconSource: "../../assets/icons/search.svg"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            Rectangle {
                width: 1
                height: 34
                anchors.verticalCenter: parent.verticalCenter
                color: "#40FFFFFF"
            }

            TaskbarButton {
                width: 50
                height: 50
                iconSource: "../../assets/icons/explorer.svg"
                label: "Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                width: 50
                height: 50
                iconSource: "../../assets/icons/browser.svg"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                width: 50
                height: 50
                iconSource: "../../assets/icons/terminal.svg"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }

            Rectangle {
                width: 1
                height: 34
                anchors.verticalCenter: parent.verticalCenter
                color: "#40FFFFFF"
            }

            SystemTray {
                width: 290
                height: 50
                panelOpen: root.quickSettingsOpen
                onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
            }
        }
    }
}

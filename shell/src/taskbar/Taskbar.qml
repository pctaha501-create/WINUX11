import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false

    signal startClicked()
    signal searchClicked()
    signal quickSettingsClicked()
    signal launch(string command)

    height: 66
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    GlassPanel {
        id: bar
        width: Math.min(parent.width - 28, 760)
        height: 54
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        radius: 18
        glassColor: "#D4111723"
        borderColor: "#55FFFFFF"

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 7
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

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

            Rectangle {
                width: 1
                height: 24
                radius: 1
                color: "#30FFFFFF"
                anchors.verticalCenter: parent.verticalCenter
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/explorer.svg"
                label: "File Explorer"
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

        SystemTray {
            anchors.right: parent.right
            anchors.rightMargin: 7
            anchors.verticalCenter: parent.verticalCenter
            panelOpen: root.quickSettingsOpen
            onPanelToggled: root.quickSettingsClicked()
        }
    }
}

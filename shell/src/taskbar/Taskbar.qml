import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 78

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
        anchors.bottomMargin: 12
        width: Math.min(parent.width - 40, 820)
        height: 56
        radius: 22
        glassColor: "#D814303B"
        borderColor: "#72B8E7EF"
        borderWidth: 1

        Row {
            anchors.centerIn: parent
            spacing: 7

            TaskbarButton {
                width: 48
                height: 48
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
                label: "Start"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                width: 48
                height: 48
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
                label: "Search"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            TaskbarButton {
                width: 48
                height: 48
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/explorer.svg"
                label: "Explorer"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                width: 48
                height: 48
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/browser.svg"
                label: "Browser"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                width: 48
                height: 48
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/terminal.svg"
                label: "Terminal"
                onClicked: root.launch("terminal")
            }

            Rectangle {
                width: 1
                height: 34
                anchors.verticalCenter: parent.verticalCenter
                color: "#55C9EEF7"
            }

            SystemTray {
                width: 164
                height: 48
            }
        }
    }
}

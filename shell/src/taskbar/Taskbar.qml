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
        anchors.bottomMargin: 12
        width: Math.min(parent.width - 48, 900)
        height: 48
        radius: 18
        glassColor: "#E20A0E15"
        borderColor: "#42FFFFFF"
        borderWidth: 1

        Row {
            anchors.centerIn: parent
            spacing: 5

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
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
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/explorer.svg"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/browser.svg"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/terminal.svg"
                onClicked: root.launch("terminal")
            }

            Rectangle {
                width: 1
                height: 28
                anchors.verticalCenter: parent.verticalCenter
                color: "#35FFFFFF"
            }

            SystemTray {
                width: 270
                height: 42
                panelOpen: root.quickSettingsOpen
                onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
            }
        }
    }
}
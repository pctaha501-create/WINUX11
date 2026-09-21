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

    Rectangle {
        anchors.fill: parent
        color: "#30040B10"
    }

    GlassPanel {
        id: bar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: Math.min(parent.width - 28, 900)
        height: 68
        radius: 24
        glassColor: "#D51A3A46"
        borderColor: "#70B8E7EF"

        Behavior on width { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }

        Row {
            anchors.centerIn: parent
            spacing: 9

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

            Rectangle {
                width: 1
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                color: "#55C9EEF7"
            }

            SystemTray {
                panelOpen: root.quickSettingsOpen
                onPanelToggled: root.quickSettingsOpen = !root.quickSettingsOpen
            }
        }
    }
}

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
        id: dock
        width: Math.min(parent.width - 32, 1080)
        height: 62
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        radius: 20
        glassColor: "#EE111A25"
        borderColor: "#55FFFFFF"

        Row {
            anchors.fill: parent
            anchors.margins: 7
            spacing: 5

            TaskbarButton {
                glyph: "⊞"
                label: "Start"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
                active: root.startOpen
                onClicked: root.startClicked()
            }

            TaskbarButton {
                glyph: "⌕"
                label: "Search"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"
                active: root.searchOpen
                onClicked: root.searchClicked()
            }

            Rectangle {
                width: 1
                height: 34
                anchors.verticalCenter: parent.verticalCenter
                color: "#36FFFFFF"
            }

            TaskbarButton {
                label: "File Explorer"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/explorer.svg"
                onClicked: root.launch("explorer")
            }

            TaskbarButton {
                label: "Browser"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/browser.svg"
                onClicked: root.launch("browser")
            }

            TaskbarButton {
                glyph: ">_"
                label: "Terminal"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/terminal.svg"
                onClicked: root.launch("terminal")
            }

            TaskbarButton {
                label: "Settings"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/settings.svg"
                onClicked: root.launch("settings")
            }

            Item {
                width: Math.max(8, parent.width - 7 * 5 - 4 * 48 - 5 * 48 - 3 - 120)
                height: 1
            }

            TaskbarButton {
                label: "Network"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/network.svg"
                active: root.quickSettingsOpen
                onClicked: root.quickSettingsOpen = !root.quickSettingsOpen
            }

            TaskbarButton {
                label: "Volume"
                iconSource: "qrc:/qt/qml/WINUX11/assets/icons/volume.svg"
                active: root.quickSettingsOpen
                onClicked: root.quickSettingsOpen = !root.quickSettingsOpen
            }

            Item {
                width: 74
                height: parent.height

                Column {
                    anchors.centerIn: parent
                    spacing: 1

                    Text {
                        width: 74
                        text: Qt.formatTime(new Date(), "HH:mm")
                        color: "#FFFFFFFF"
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Text {
                        width: 74
                        text: Qt.formatDate(new Date(), "dd/MM")
                        color: Theme.textMuted
                        font.pixelSize: 9
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Timer {
                        interval: 1000
                        repeat: true
                        running: true
                        onTriggered: parent.parent.children[0].text = Qt.formatTime(new Date(), "HH:mm")
                    }
                }
            }
        }
    }
}

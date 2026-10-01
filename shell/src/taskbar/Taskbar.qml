import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    height: 84

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    signal startClicked()
    signal searchClicked()
    signal launch(string command)

    GlassPanel {
        id: dock
        width: Math.min(parent.width - 56, 980)
        height: 64
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        radius: 22
        glassColor: "#E80A0F18"
        borderColor: "#38FFFFFF"

        Row {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 4

            TaskbarButton {
                glyph: "⊞"; label: "Start"; active: root.startOpen
                onClicked: root.startClicked()
            }
            TaskbarButton {
                glyph: "⌕"; label: "Search"; active: root.searchOpen
                onClicked: root.searchClicked()
            }

            Rectangle {
                width: 1; height: 30
                anchors.verticalCenter: parent.verticalCenter
                color: "#24FFFFFF"
            }

            Row {
                id: apps
                width: Math.max(0, parent.width - 360)
                anchors.verticalCenter: parent.verticalCenter
                spacing: 3

                TaskbarButton { glyph: "▣"; label: "File Explorer"; onClicked: root.launch("explorer") }
                TaskbarButton { glyph: "◉"; label: "Browser"; onClicked: root.launch("browser") }
                TaskbarButton { glyph: ">_"; label: "Terminal"; onClicked: root.launch("terminal") }
                TaskbarButton { glyph: "⚙"; label: "Settings"; onClicked: root.launch("settings") }
                TaskbarButton { glyph: "▤"; label: "Task Manager"; onClicked: root.launch("taskmanager") }
            }

            Item { width: 1; height: 1; Layout.fillWidth: true }

            Rectangle {
                width: 1; height: 30
                anchors.verticalCenter: parent.verticalCenter
                color: "#24FFFFFF"
            }

            TaskbarButton {
                glyph: "⌁"; label: "Network"; active: root.quickSettingsOpen
                onClicked: root.quickSettingsOpen = !root.quickSettingsOpen
            }
            TaskbarButton {
                glyph: "◖"; label: "Volume"; active: root.quickSettingsOpen
                onClicked: root.quickSettingsOpen = !root.quickSettingsOpen
            }
            TaskbarButton {
                glyph: "◐"; label: "Quick Settings"; active: root.quickSettingsOpen
                onClicked: root.quickSettingsOpen = !root.quickSettingsOpen
            }

            Column {
                width: 74
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1

                Text {
                    width: parent.width
                    text: Qt.formatTime(new Date(), "HH:mm")
                    color: Theme.textPrimary
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    width: parent.width
                    text: Qt.formatDate(new Date(), "dd MMM")
                    color: Theme.textMuted
                    font.pixelSize: 9
                    horizontalAlignment: Text.AlignHCenter
                }
                Timer {
                    interval: 1000
                    repeat: true
                    running: true
                    onTriggered: parent.children[0].text = Qt.formatTime(new Date(), "HH:mm")
                }
            }
        }
    }
}

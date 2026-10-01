import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    signal searchRequested()
    signal launch(string command)

    visible: open
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.96
    Behavior on opacity { NumberAnimation { duration: 140 } }
    Behavior on scale { NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        radius: 28
        glassColor: "#F20A1019"
        borderColor: "#42FFFFFF"

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 18

            Row {
                width: parent.width
                spacing: 12

                Rectangle {
                    width: 44; height: 44; radius: 14
                    color: Theme.accentSoft
                    Text { anchors.centerIn: parent; text: "⊞"; color: Theme.textPrimary; font.pixelSize: 24 }
                }
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Text { text: "WINUX11"; color: Theme.textPrimary; font.pixelSize: 17; font.weight: Font.DemiBold }
                    Text { text: "Everything you need, one place."; color: Theme.textMuted; font.pixelSize: 10 }
                }
            }

            Rectangle {
                width: parent.width
                height: 48
                radius: 16
                color: "#12FFFFFF"
                border.width: 1
                border.color: "#22FFFFFF"
                Text { x: 16; anchors.verticalCenter: parent.verticalCenter; text: "⌕  Search apps, settings and files"; color: Theme.textMuted; font.pixelSize: 12 }
                MouseArea { anchors.fill: parent; onClicked: root.searchRequested() }
            }

            Text { text: "Pinned"; color: Theme.textSecondary; font.pixelSize: 11; font.weight: Font.Medium }

            Grid {
                width: parent.width
                columns: 4
                rowSpacing: 10
                columnSpacing: 10

                Repeater {
                    model: [
                        {n:"Explorer",g:"◫",c:"explorer"},
                        {n:"Browser",g:"◉",c:"browser"},
                        {n:"Terminal",g:">_",c:"terminal"},
                        {n:"Settings",g:"⚙",c:"settings"},
                        {n:"Calculator",g:"⌗",c:"calculator"},
                        {n:"Editor",g:"✎",c:"editor"},
                        {n:"Network",g:"◌",c:"network"},
                        {n:"Security",g:"◈",c:"security"}
                    ]

                    delegate: Rectangle {
                        width: (parent.width - 30) / 4
                        height: 86
                        radius: 18
                        color: mouse.containsMouse ? "#1DFFFFFF" : "#0CFFFFFF"
                        border.width: 1
                        border.color: "#18FFFFFF"

                        Text { anchors.horizontalCenter: parent.horizontalCenter; y: 15; text: modelData.g; color: Theme.textPrimary; font.pixelSize: 24 }
                        Text { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.bottom; anchors.bottomMargin: 14; text: modelData.n; color: Theme.textSecondary; font.pixelSize: 10 }
                        MouseArea { id: mouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.launch(modelData.c) }
                    }
                }
            }

            Row {
                width: parent.width
                spacing: 10
                Text { text: "Recommended"; color: Theme.textSecondary; font.pixelSize: 11; font.weight: Font.Medium }
                Item { width: 1; height: 1 }
                Text { text: "2 items"; color: Theme.textMuted; font.pixelSize: 10 }
            }

            Rectangle {
                width: parent.width
                height: 58
                radius: 16
                color: "#0CFFFFFF"
                Text { x: 14; anchors.verticalCenter: parent.verticalCenter; text: "✨  Finish WINUX11 setup"; color: Theme.textPrimary; font.pixelSize: 11 }
                Text { x: 14; anchors.verticalCenter: parent.verticalCenter; anchors.verticalCenterOffset: 16; text: "Review system preferences"; color: Theme.textMuted; font.pixelSize: 9 }
                MouseArea { anchors.fill: parent; onClicked: root.launch("settings") }
            }
        }
    }
}

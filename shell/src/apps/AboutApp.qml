import QtQuick
import WINUX11 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text { anchors.horizontalCenter:parent.horizontalCenter; text:"WINUX11"; color:"#FFFFFF"; font.pixelSize:38; font.weight:Font.DemiBold }
            Text { anchors.horizontalCenter:parent.horizontalCenter; text:"A Windows-inspired Linux operating system"; color:Theme.textMuted; font.pixelSize:13 }
            Text { anchors.horizontalCenter:parent.horizontalCenter; text:"Qt 6 • Wayland-ready • Glassmorphism Shell"; color:Theme.textMuted; font.pixelSize:11 }
            Text { anchors.horizontalCenter:parent.horizontalCenter; text:"Built as an original open architecture."; color:Theme.textMuted; font.pixelSize:11 }
        }
    }
}
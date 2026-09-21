import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#183B7180" }
            GradientStop { position: 0.45; color: "#081F2B" }
            GradientStop { position: 1.0; color: "#030B12" }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 36
        anchors.topMargin: 30
        text: "WINUX11"
        color: Theme.textPrimary
        font.pixelSize: 22
        font.weight: Font.DemiBold
        opacity: 0.95
    }

    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 38
        anchors.topMargin: 60
        text: "Glassmorphism Shell"
        color: Theme.textSecondary
        font.pixelSize: 13
    }
}

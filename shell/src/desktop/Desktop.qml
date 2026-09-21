import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    WaterFlow { anchors.fill: parent }

    Rectangle {
        anchors.fill: parent
        color: "#22000000"
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
        text: "Water Flow Shell"
        color: Theme.textSecondary
        font.pixelSize: 13
    }
}

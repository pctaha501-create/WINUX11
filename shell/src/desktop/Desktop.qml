import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.fill: parent

    Watermorphism {
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        color: "#18000000"
    }

    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 44
        anchors.topMargin: 34
        text: "WINUX11"
        color: Theme.textPrimary
        font.pixelSize: 26
        font.weight: Font.DemiBold
    }

    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 46
        anchors.topMargin: 70
        text: "Watermorphism Shell"
        color: Theme.textSecondary
        font.pixelSize: 14
    }
}

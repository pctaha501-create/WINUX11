import QtQuick
import WINUX11 1.0

Rectangle {
    id: root

    property color glassColor: Theme.surfaceGlass
    property color borderColor: Theme.border
    property real shadowOpacity: 0.28

    radius: Theme.radiusMedium
    color: glassColor
    border.width: 1
    border.color: borderColor

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: Math.max(0, parent.radius - 1)
        color: "transparent"
        border.width: 1
        border.color: "#18FFFFFF"
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1
        height: Math.min(52, parent.height * 0.34)
        radius: Math.min(parent.radius - 1, 18)
        color: "#12FFFFFF"
        opacity: 0.8
    }
}

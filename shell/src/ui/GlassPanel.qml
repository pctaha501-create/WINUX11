import QtQuick
import WINUX11 1.0

Rectangle {
    id: root

    property color glassColor: Theme.surfaceGlass
    property color borderColor: Theme.border
    property real borderWidth: 1
    property bool animated: true

    color: glassColor
    radius: Theme.radiusLarge
    border.width: borderWidth
    border.color: borderColor

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: Math.max(0, root.radius - 1)
        color: "transparent"
        border.width: 1
        border.color: "#10FFFFFF"
        opacity: 0.75
    }

    Behavior on color {
        enabled: root.animated
        ColorAnimation { duration: 160; easing.type: Easing.OutCubic }
    }

    Behavior on scale {
        enabled: root.animated
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }
}
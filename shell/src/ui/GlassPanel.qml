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

    Behavior on color {
        enabled: root.animated
        ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on scale {
        enabled: root.animated
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }
}
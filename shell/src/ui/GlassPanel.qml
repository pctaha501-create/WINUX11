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
    clip: true

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#46FFFFFF" }
            GradientStop { position: 0.20; color: "#16DFFFFF" }
            GradientStop { position: 0.58; color: "#06000000" }
            GradientStop { position: 1.0; color: "#28000000" }
        }
        opacity: 0.9
    }

    Rectangle {
        width: parent.width * 0.72
        height: parent.height * 0.55
        x: -width * 0.20
        y: -height * 0.25
        radius: width
        rotation: -18
        opacity: 0.16
        color: Theme.waterSoft

        SequentialAnimation on x {
            running: root.animated
            loops: Animation.Infinite
            NumberAnimation { to: parent.width * 0.48; duration: 5200; easing.type: Easing.InOutSine }
            NumberAnimation { to: -parent.width * 0.20; duration: 5200; easing.type: Easing.InOutSine }
        }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 2
        radius: 2
        color: "#BFFFFFFF"
        opacity: 0.58
    }

    Behavior on color {
        enabled: root.animated
        ColorAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Behavior on scale {
        enabled: root.animated
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }
}

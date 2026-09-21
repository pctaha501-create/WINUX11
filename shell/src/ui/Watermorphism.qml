import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.fill: parent
    clip: true

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    Rectangle {
        width: parent.width * 0.72
        height: parent.height * 0.72
        x: -parent.width * 0.16
        y: -parent.height * 0.18
        radius: width * 0.45
        opacity: 0.72
        rotation: -12
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#7A43DFFF" }
            GradientStop { position: 0.42; color: "#5638C9F5" }
            GradientStop { position: 1.0; color: "#0038A8C2" }
        }

        SequentialAnimation on x {
            loops: Animation.Infinite
            NumberAnimation { to: -parent.width * 0.03; duration: 7000; easing.type: Easing.InOutSine }
            NumberAnimation { to: -parent.width * 0.16; duration: 7000; easing.type: Easing.InOutSine }
        }
    }

    Rectangle {
        width: parent.width * 0.60
        height: parent.height * 0.66
        x: parent.width * 0.52
        y: parent.height * 0.28
        radius: width * 0.48
        opacity: 0.58
        rotation: 18
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#006DE9FF" }
            GradientStop { position: 0.45; color: "#5C21B8D0" }
            GradientStop { position: 1.0; color: "#004B768A" }
        }

        SequentialAnimation on y {
            loops: Animation.Infinite
            NumberAnimation { to: parent.height * 0.12; duration: 8200; easing.type: Easing.InOutSine }
            NumberAnimation { to: parent.height * 0.28; duration: 8200; easing.type: Easing.InOutSine }
        }
    }

    Rectangle {
        width: parent.width * 0.42
        height: parent.height * 0.42
        x: parent.width * 0.30
        y: parent.height * 0.05
        radius: width * 0.5
        opacity: 0.25
        gradient: Gradient {
            GradientStop { position: 0; color: "#FFFFFFFF" }
            GradientStop { position: 0.5; color: "#6EEBFFFF" }
            GradientStop { position: 1; color: "#001A8B9D" }
        }

        SequentialAnimation on rotation {
            loops: Animation.Infinite
            NumberAnimation { from: -8; to: 8; duration: 9000; easing.type: Easing.InOutSine }
            NumberAnimation { from: 8; to: -8; duration: 9000; easing.type: Easing.InOutSine }
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#18FFFFFF" }
            GradientStop { position: 0.48; color: "#00000000" }
            GradientStop { position: 1; color: "#36000000" }
        }
    }

    Rectangle {
        x: parent.width * 0.08
        y: parent.height * 0.16
        width: parent.width * 0.26
        height: 2
        radius: 2
        rotation: -22
        opacity: 0.35
        color: "#E9FFFFFF"

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            NumberAnimation { to: 0.08; duration: 2400 }
            NumberAnimation { to: 0.35; duration: 2400 }
        }
    }
}

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
        id: glow1
        width: root.width * 0.72
        height: root.height * 0.28
        radius: height / 2
        x: -width * 0.18
        y: root.height * 0.12
        rotation: -8
        opacity: 0.28
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#005C79" }
            GradientStop { position: 0.5; color: "#18C8E6" }
            GradientStop { position: 1.0; color: "#073E58" }
        }
        NumberAnimation on x {
            from: -root.width * 0.35
            to: root.width * 0.55
            duration: 9000
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
        NumberAnimation on y {
            from: root.height * 0.08
            to: root.height * 0.25
            duration: 6000
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
    }

    Rectangle {
        id: glow2
        width: root.width * 0.88
        height: root.height * 0.22
        radius: height / 2
        x: root.width * 0.35
        y: root.height * 0.50
        rotation: 7
        opacity: 0.24
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#073C58" }
            GradientStop { position: 0.48; color: "#29D9E8" }
            GradientStop { position: 1.0; color: "#006A88" }
        }
        NumberAnimation on x {
            from: root.width * 0.62
            to: -root.width * 0.35
            duration: 10500
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
        NumberAnimation on y {
            from: root.height * 0.44
            to: root.height * 0.68
            duration: 7200
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
    }

    Rectangle {
        id: glow3
        width: root.width * 0.65
        height: root.height * 0.18
        radius: height / 2
        x: root.width * 0.02
        y: root.height * 0.76
        rotation: -5
        opacity: 0.18
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00435D" }
            GradientStop { position: 0.5; color: "#44E6F2" }
            GradientStop { position: 1.0; color: "#0B7188" }
        }
        NumberAnimation on x {
            from: -root.width * 0.25
            to: root.width * 0.72
            duration: 12000
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
        NumberAnimation on y {
            from: root.height * 0.72
            to: root.height * 0.84
            duration: 6800
            loops: Animation.Infinite
            easing.type: Easing.InOutSine
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#55030D12"
    }

    Repeater {
        model: 16
        delegate: Rectangle {
            required property int index
            width: 2 + (index % 3)
            height: width
            radius: width / 2
            x: (index * 97) % Math.max(1, root.width)
            y: (index * 53) % Math.max(1, root.height)
            color: "#99CFF8FF"
            opacity: 0.12 + (index % 4) * 0.04

            NumberAnimation on y {
                from: y
                to: y - 90
                duration: 2800 + index * 180
                loops: Animation.Infinite
                easing.type: Easing.InOutSine
            }
        }
    }
}
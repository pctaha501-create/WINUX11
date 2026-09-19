import QtQuick

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: "#07090e"
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#172235" }
            GradientStop { position: 0.38; color: "#0c111a" }
            GradientStop { position: 1.0; color: "#050609" }
        }
    }

    Rectangle {
        width: parent.width * 0.58
        height: parent.height * 0.58
        x: parent.width * 0.28
        y: -parent.height * 0.10
        radius: width / 2
        color: "#3c6fa8"
        opacity: 0.08
    }

    Rectangle {
        width: parent.width * 0.32
        height: parent.width * 0.32
        x: -parent.width * 0.10
        y: parent.height * 0.55
        radius: width / 2
        color: "#4b78ad"
        opacity: 0.055
    }
}

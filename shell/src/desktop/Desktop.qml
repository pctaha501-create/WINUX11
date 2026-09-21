import QtQuick
import WINUX11 1.0

Item {
    id: root
    anchors.fill: parent

    signal desktopClicked()

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101A2B" }
            GradientStop { position: 0.48; color: "#080D16" }
            GradientStop { position: 1.0; color: "#03050A" }
        }
    }

    Rectangle {
        width: 560
        height: 560
        radius: width / 2
        x: parent.width - 360
        y: -210
        color: "#111D35"
        opacity: 0.48
    }

    Rectangle {
        width: 420
        height: 420
        radius: width / 2
        x: -190
        y: parent.height - 240
        color: "#0B1727"
        opacity: 0.58
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 38
        anchors.topMargin: 34
        spacing: 5

        Text {
            text: "WINUX11"
            color: Theme.textPrimary
            font.pixelSize: 22
            font.weight: Font.DemiBold
        }

        Text {
            text: "A familiar desktop. Built from the ground up."
            color: Theme.textMuted
            font.pixelSize: 12
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -42
        text: "WINUX11"
        color: "#FFFFFF"
        opacity: 0.035
        font.pixelSize: 170
        font.weight: Font.Black
    }

    // Clicking anywhere on the desktop closes open shell menus/panels.
    MouseArea {
        anchors.fill: parent
        z: 100
        onClicked: root.desktopClicked()
    }
}

import QtQuick
import WINUX11 1.0

Item {
    id: root
    signal desktopClicked()

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101827" }
            GradientStop { position: 0.45; color: "#080D16" }
            GradientStop { position: 1.0; color: "#03050A" }
        }
    }

    Rectangle {
        width: parent.width * 0.55
        height: parent.height * 0.7
        x: parent.width * 0.35
        y: -parent.height * 0.18
        radius: width
        color: "#143C6FA8"
        opacity: 0.34
    }

    Rectangle {
        width: parent.width * 0.38
        height: parent.height * 0.58
        x: -parent.width * 0.14
        y: parent.height * 0.38
        radius: width
        color: "#122E6A55"
        opacity: 0.24
    }

    Column {
        x: 34
        y: 30
        spacing: 4

        Text {
            text: "WINUX11"
            color: "#EAF1FF"
            font.pixelSize: 13
            font.weight: Font.DemiBold
            opacity: 0.85
        }
        Text {
            text: "A desktop built around your workflow."
            color: Theme.textMuted
            font.pixelSize: 11
        }
    }

    Row {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 34
        anchors.topMargin: 30
        spacing: 8

        Rectangle {
            width: 8; height: 8; radius: 4
            color: Theme.success
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: "System online"
            color: Theme.textSecondary
            font.pixelSize: 11
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.desktopClicked()
    }
}

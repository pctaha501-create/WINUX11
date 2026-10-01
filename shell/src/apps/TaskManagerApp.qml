import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string snapshot: "Loading processes…"

    Timer {
        interval: 1500
        running: true
        repeat: true
        onTriggered: root.snapshot = systemService.processSnapshot()
    }

    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"

        Text {
            x: 22; y: 20
            text: "Task Manager"
            color: "#FFFFFF"
            font.pixelSize: 24
            font.weight: Font.DemiBold
        }

        Text {
            x: 22; y: 54
            text: "Live process snapshot"
            color: Theme.textMuted
            font.pixelSize: 12
        }

        Flickable {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 22
            anchors.topMargin: 86
            contentHeight: processText.height
            clip: true

            Text {
                id: processText
                width: parent.width
                text: root.snapshot
                color: "#DDEAF0"
                font.family: "monospace"
                font.pixelSize: 11
                wrapMode: Text.NoWrap
            }
        }
    }

    Component.onCompleted: snapshot = systemService.processSnapshot()
}
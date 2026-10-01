import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent
    property string snapshot: systemService.processSnapshot()

    Timer {
        interval: 1500
        running: true
        repeat: true
        onTriggered: snapshot = systemService.processSnapshot()
    }

    Rectangle {
        anchors.fill: parent
        radius: 18
        color: "#EE0B1018"
        border.color: "#55FFFFFF"
        border.width: 1
    }

    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 10

        Row {
            width: parent.width
            spacing: 12
            Text {
                text: "Task Manager"
                color: "#FFFFFF"
                font.pixelSize: 24
                font.bold: true
            }
            Text {
                text: "Live process snapshot"
                color: "#AFC0D0"
                anchors.verticalCenter: parent.verticalCenter
            }
            Button {
                text: "Refresh"
                onClicked: snapshot = systemService.processSnapshot()
            }
        }

        Text {
            text: "PID       CPU%     MEM%     PROCESS"
            color: "#FFFFFF"
            font.bold: true
            font.family: "monospace"
        }

        ScrollView {
            width: parent.width
            height: parent.height - 78

            TextArea {
                width: parent.width
                text: snapshot
                readOnly: true
                color: "#FFFFFF"
                font.family: "monospace"
                font.pixelSize: 12
                wrapMode: TextEdit.NoWrap
                background: Rectangle {
                    radius: 10
                    color: "#22000000"
                }
            }
        }
    }
}
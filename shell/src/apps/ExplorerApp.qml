import QtQuick
import WINUX11 1.0

Item {
    id: root
    property string currentPath: fileService.homePath()

    Rectangle {
        anchors.fill: parent
        color: "#E8090D13"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 54
            color: "#16000000"

            Text {
                x: 18
                anchors.verticalCenter: parent.verticalCenter
                text: currentPath
                color: "#FFFFFF"
                font.pixelSize: 14
            }

            Rectangle {
                width: 72; height: 34
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                radius: 12
                color: Theme.accent
                Text { anchors.centerIn: parent; text: "Refresh"; color: "#071018"; font.pixelSize: 11 }
                MouseArea { anchors.fill: parent; onClicked: fileModel = fileService.list(currentPath) }
            }
        }

        GridView {
            id: files
            anchors.fill: parent
            anchors.topMargin: 70
            anchors.margins: 18
            cellWidth: 150
            cellHeight: 105
            model: fileModel

            delegate: Rectangle {
                width: 136
                height: 92
                radius: 18
                color: mouse.containsMouse ? "#24FFFFFF" : "#13000000"
                border.width: 1
                border.color: "#20FFFFFF"

                Text {
                    anchors.centerIn: parent
                    width: parent.width - 16
                    text: modelData
                    color: "#FFFFFF"
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideMiddle
                    font.pixelSize: 12
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onDoubleClicked: fileService.open(currentPath + "/" + modelData)
                }
            }
        }
    }

    property var fileModel: []

    Component.onCompleted: fileModel = fileService.list(currentPath)
}
import QtQuick
import WINUX11 1.0

Item {
    Rectangle {
        anchors.fill: parent
        color: "#E8090C12"

        TextInput {
            id: path
            x: 18; y: 14
            width: parent.width - 36
            height: 34
            color: "#FFFFFF"
            text: "untitled.txt"
            font.pixelSize: 12
            selectionColor: Theme.accent
        }

        TextEdit {
            id: editor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: path.bottom
            anchors.bottom: parent.bottom
            anchors.margins: 18
            anchors.topMargin: 12
            color: "#EAF4F7"
            selectionColor: Theme.accent
            font.family: "monospace"
            font.pixelSize: 13
            wrapMode: TextEdit.Wrap
            text: "// WINUX11 Text Editor\n// Ready."
        }

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 14
            anchors.rightMargin: 18
            width: 70; height: 34
            radius: 12
            color: Theme.accent
            Text { anchors.centerIn:parent; text:"Save"; color:"#071018"; font.pixelSize:11 }
            MouseArea {
                anchors.fill: parent
                onClicked: fileService.writeText(path.text, editor.text)
            }
        }
    }
}
import QtQuick
import QtQuick.Controls
Item {
    anchors.fill: parent
    property string title: "WINUX11 System Tool"
    property string program: "true"
    property var arguments: []
    property string output: ""
    function refresh() {
        output = systemService.commandOutput(program, arguments)
        if (output.length === 0)
            output = "No output was returned."
    }
    Component.onCompleted: refresh()
    Rectangle { anchors.fill: parent; radius: 18; color: "#EE0B1018"; border.color: "#55FFFFFF"; border.width: 1 }
    Column {
        anchors.fill: parent
        anchors.margins: 18
        spacing: 12
        Row {
            width: parent.width
            spacing: 12
            Text { text: title; color: "#FFFFFF"; font.pixelSize: 23; font.bold: true }
            Button { text: "Refresh"; onClicked: refresh() }
        }
        Text { text: "Native Linux backend • live system data"; color: "#AFC0D0"; font.pixelSize: 11 }
        ScrollView {
            width: parent.width
            height: parent.height - 72
            TextArea {
                width: parent.width
                text: output
                readOnly: true
                selectByMouse: true
                color: "#FFFFFF"
                font.family: "monospace"
                font.pixelSize: 12
                wrapMode: TextEdit.NoWrap
                background: Rectangle { radius: 10; color: "#22000000" }
            }
        }
    }
}
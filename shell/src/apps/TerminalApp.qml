import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string output: "WINUX11 Terminal\nType 'help' for available commands.\n\n"

    Rectangle {
        anchors.fill: parent
        color: "#E8080B10"

        Flickable {
            id: scroll
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: inputBar.top
            anchors.margins: 18
            contentHeight: outputText.height
            clip: true

            Text {
                id: outputText
                width: scroll.width
                text: root.output
                color: "#EAF4F7"
                font.family: "monospace"
                font.pixelSize: 13
                wrapMode: Text.WrapAnywhere
            }

            onContentHeightChanged: contentY = Math.max(0, contentHeight - height)
        }

        Rectangle {
            id: inputBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 52
            color: "#18000000"

            Text {
                x: 18
                anchors.verticalCenter: parent.verticalCenter
                text: "taha@winux11:$"
                color: Theme.accent
                font.family: "monospace"
                font.pixelSize: 13
            }

            TextInput {
                id: input
                anchors.left: parent.left
                anchors.leftMargin: 150
                anchors.right: run.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.textPrimary
                selectionColor: Theme.accent
                font.family: "monospace"
                font.pixelSize: 13
                focus: true

                Keys.onReturnPressed: runCommand()
                Keys.onEnterPressed: runCommand()

                function runCommand() {
                    if (text.trim().length === 0)
                        return
                    root.output += "\n$ " + text + "\n"
                    terminalService.execute(text)
                    text = ""
                }
            }

            Rectangle {
                id: run
                width: 42
                height: 34
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                radius: 12
                color: Theme.accent

                Text {
                    anchors.centerIn: parent
                    text: "↵"
                    color: "#071018"
                    font.pixelSize: 17
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: input.runCommand()
                }
            }
        }
    }

    Connections {
        target: terminalService
        function onOutputReady(text) {
            root.output += text
        }
        function onErrorReady(text) {
            root.output += "\n[error] " + text + "\n"
        }
        function onFinished(code) {
            root.output += "\n[exit " + code + "]\n"
        }
    }

    Component.onCompleted: input.forceActiveFocus()
}
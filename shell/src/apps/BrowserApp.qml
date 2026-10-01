import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string url: "https://www.google.com"

    Rectangle {
        anchors.fill: parent
        color: "#E80A0E14"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 58
            color: "#16000000"

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                Rectangle {
                    width: 34; height: 34; radius: 17
                    color: "#18FFFFFF"
                    Text { anchors.centerIn: parent; text: "‹"; color: "#FFFFFF"; font.pixelSize: 24 }
                    MouseArea { anchors.fill: parent; onClicked: root.url = "https://www.google.com" }
                }

                Rectangle {
                    width: 34; height: 34; radius: 17
                    color: "#18FFFFFF"
                    Text { anchors.centerIn: parent; text: "›"; color: "#FFFFFF"; font.pixelSize: 24 }
                }

                Rectangle {
                    width: 34; height: 34; radius: 17
                    color: "#18FFFFFF"
                    Text { anchors.centerIn: parent; text: "↻"; color: "#FFFFFF"; font.pixelSize: 19 }
                    MouseArea { anchors.fill: parent; onClicked: launcher.openBrowserUrl(root.url) }
                }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 128
                anchors.right: go.left
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                height: 38
                radius: 19
                color: "#25000000"
                border.width: 1
                border.color: "#28FFFFFF"

                TextInput {
                    id: address
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    color: "#FFFFFF"
                    selectionColor: Theme.accent
                    text: root.url
                    font.pixelSize: 13
                    onAccepted: {
                        root.url = text
                        launcher.openBrowserUrl(root.url)
                    }
                }
            }

            Rectangle {
                id: go
                width: 64
                height: 38
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                radius: 19
                color: Theme.accent
                Text { anchors.centerIn: parent; text: "Go"; color: "#071018"; font.weight: Font.DemiBold }
                MouseArea { anchors.fill: parent; onClicked: launcher.openBrowserUrl(address.text) }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 10

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "WINUX Browser"
                color: "#FFFFFF"
                font.pixelSize: 28
                font.weight: Font.DemiBold
            }

            Text {
                width: 620
                horizontalAlignment: Text.AlignHCenter
                text: "Fast system browser shell • tabs and web engine integration"
                color: Theme.textMuted
                font.pixelSize: 13
                wrapMode: Text.WordWrap
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8
                Repeater {
                    model: ["Google", "YouTube", "GitHub", "WINUX11"]
                    Rectangle {
                        width: 110; height: 42; radius: 14
                        color: "#18000000"
                        border.width: 1
                        border.color: "#24FFFFFF"
                        Text { anchors.centerIn: parent; text: modelData; color: "#FFFFFF"; font.pixelSize: 12 }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var targets = {
                                    "Google":"https://www.google.com",
                                    "YouTube":"https://www.youtube.com",
                                    "GitHub":"https://github.com",
                                    "WINUX11":"https://github.com/pctaha501-create/WINUX11"
                                }
                                root.url = targets[modelData]
                                launcher.openBrowserUrl(root.url)
                            }
                        }
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "The OS uses the installed Chromium/Chrome engine when available."
                color: Theme.textMuted
                font.pixelSize: 11
            }
        }
    }
}
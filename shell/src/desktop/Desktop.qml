import QtQuick
import WINUX11 1.0

Item {
    id: root
    signal desktopClicked()
    signal launch(string command)

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundDeep
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#101D2D" }
            GradientStop { position: 0.45; color: "#08131F" }
            GradientStop { position: 1.0; color: "#03070C" }
        }
    }

    Rectangle {
        width: parent.width * 0.52
        height: parent.height * 0.62
        x: parent.width * 0.24
        y: parent.height * 0.02
        radius: width / 2
        color: "#245B9CFF"
        opacity: 0.16
    }

    Rectangle {
        width: parent.width
        height: 1
        y: parent.height * 0.5
        color: "#12FFFFFF"
        opacity: 0.35
    }

    Rectangle {
        width: 1
        height: parent.height
        x: parent.width * 0.5
        color: "#12FFFFFF"
        opacity: 0.18
    }

    Column {
        x: 36
        y: 32
        spacing: 5

        Text {
            text: "WINUX11"
            color: "#FFFFFFFF"
            font.pixelSize: 14
            font.weight: Font.DemiBold
        }

        Text {
            text: "Desktop"
            color: Theme.textMuted
            font.pixelSize: 11
        }
    }

    Grid {
        x: 34
        y: 118
        columns: 1
        rowSpacing: 18

        Repeater {
            model: [
                { n: "This PC", g: "▣", c: "explorer" },
                { n: "Network", g: "⌁", c: "network" },
                { n: "Recycle Bin", g: "♲", c: "explorer" }
            ]

            delegate: Item {
                width: 94
                height: 82

                Rectangle {
                    anchors.centerIn: parent
                    width: 62
                    height: 62
                    radius: 16
                    color: mouse.containsMouse ? "#243B4F66" : "#16202C44"
                    border.width: 1
                    border.color: "#30FFFFFF"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 10
                    text: modelData.g
                    color: "#FFFFFFFF"
                    font.pixelSize: 27
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    text: modelData.n
                    color: "#FFFFFFFF"
                    font.pixelSize: 10
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.launch(modelData.c)
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        z: -1
        onClicked: root.desktopClicked()
    }
}

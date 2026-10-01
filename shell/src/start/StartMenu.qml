import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    signal searchRequested()
    signal launch(string command)

    visible: open
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.97

    Behavior on opacity { NumberAnimation { duration: 140 } }
    Behavior on scale { NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        radius: 24
        glassColor: "#F2192431"
        borderColor: "#66FFFFFF"

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 18

            Row {
                width: parent.width
                spacing: 13

                Rectangle {
                    width: 46
                    height: 46
                    radius: 14
                    color: "#2B6EA8FF"

                    Image {
                        anchors.centerIn: parent
                        width: 27
                        height: 27
                        source: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: "WINUX11"
                        color: "#FFFFFFFF"
                        font.pixelSize: 18
                        font.weight: Font.DemiBold
                    }

                    Text {
                        text: "Everything you need, one place."
                        color: "#C7D2E1"
                        font.pixelSize: 10
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 48
                radius: 14
                color: "#E51B2735"
                border.width: 1
                border.color: "#45FFFFFF"

                Text {
                    x: 16
                    anchors.verticalCenter: parent.verticalCenter
                    text: "⌕  Search apps, settings and files"
                    color: "#C8D3E1"
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.searchRequested()
                }
            }

            Text {
                text: "Pinned"
                color: "#FFFFFFFF"
                font.pixelSize: 12
                font.weight: Font.DemiBold
            }

            Grid {
                width: parent.width
                columns: 4
                rowSpacing: 10
                columnSpacing: 10

                Repeater {
                    model: [
                        {n:"Explorer", i:"explorer.svg", c:"explorer"},
                        {n:"Browser", i:"browser.svg", c:"browser"},
                        {n:"Terminal", i:"terminal.svg", c:"terminal"},
                        {n:"Settings", i:"settings.svg", c:"settings"},
                        {n:"Calculator", i:"calculator.svg", c:"calculator"},
                        {n:"Editor", i:"terminal.svg", c:"editor"},
                        {n:"Network", i:"network.svg", c:"network"},
                        {n:"Security", i:"settings.svg", c:"security"}
                    ]

                    delegate: Rectangle {
                        width: (parent.width - 30) / 4
                        height: 82
                        radius: 15
                        color: mouse.containsMouse ? "#33465D78" : "#E016202C"
                        border.width: 1
                        border.color: "#35FFFFFF"

                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 12
                            width: 27
                            height: 27
                            source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.i
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 12
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

            Row {
                width: parent.width
                spacing: 10

                Text {
                    text: "Recommended"
                    color: "#FFFFFFFF"
                    font.pixelSize: 11
                    font.weight: Font.Medium
                }

                Item { width: 1; height: 1 }

                Text {
                    text: "2 items"
                    color: "#B4C0D0"
                    font.pixelSize: 10
                }
            }

            Rectangle {
                width: parent.width
                height: 58
                radius: 14
                color: "#E016202C"
                border.width: 1
                border.color: "#35FFFFFF"

                Text {
                    x: 14
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -8
                    text: "✨  Finish WINUX11 setup"
                    color: "#FFFFFFFF"
                    font.pixelSize: 11
                }

                Text {
                    x: 14
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 12
                    text: "Review system preferences"
                    color: "#B4C0D0"
                    font.pixelSize: 9
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.launch("settings")
                }
            }
        }
    }
}

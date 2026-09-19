import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool open: false
    signal searchRequested()
    signal launch(string command)

    visible: open
    width: Math.min(parent ? parent.width - 40 : 720, 720)
    height: Math.min(parent ? parent.height - 130 : 700, 650)

    GlassPanel {
        anchors.fill: parent
        glassColor: "#f0141720"
        radius: 26

        scale: root.open ? 1 : 0.96
        opacity: root.open ? 1 : 0

        Behavior on scale {
            NumberAnimation {
                duration: 190
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 140 }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 28
            spacing: 18

            Text {
                text: "Start"
                color: "#f8f9fb"
                font.pixelSize: 26
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: 50
                radius: 15
                color: "#252a34"
                border.width: 1
                border.color: "#353c48"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 17
                    anchors.verticalCenter: parent.verticalCenter
                    text: "⌕  Search"
                    color: "#929aa7"
                    font.pixelSize: 15
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.open = false
                        root.searchRequested()
                    }
                }
            }

            Text {
                text: "Pinned"
                color: "#f4f6f9"
                font.pixelSize: 17
                font.bold: true
            }

            Grid {
                width: parent.width
                columns: 4
                rowSpacing: 8
                columnSpacing: 8

                Repeater {
                    model: [
                        {name:"Explorer", icon:"▣", command:"explorer"},
                        {name:"Terminal", icon:">", command:"terminal"},
                        {name:"Settings", icon:"⚙", command:"settings"},
                        {name:"Browser", icon:"◎", command:"browser"},
                        {name:"Notepad", icon:"▤", command:"notepad"},
                        {name:"Calculator", icon:"=", command:"calculator"},
                        {name:"Files", icon:"□", command:"explorer"},
                        {name:"Store", icon:"◆", command:"browser"}
                    ]

                    delegate: Rectangle {
                        width: (parent.width - 24) / 4
                        height: 82
                        radius: 14
                        color: hover.containsMouse ? "#252b36" : "transparent"

                        Column {
                            anchors.centerIn: parent
                            spacing: 6

                            Text {
                                width: 120
                                text: modelData.icon
                                color: "#f4f6f9"
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                width: 120
                                text: modelData.name
                                color: "#cdd2da"
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        MouseArea {
                            id: hover
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.launch(modelData.command)
                        }
                    }
                }
            }

            Text {
                text: "Recommended"
                color: "#f4f6f9"
                font.pixelSize: 17
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: 74
                radius: 15
                color: "#171a21"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 17
                    anchors.verticalCenter: parent.verticalCenter
                    text: "WINUX11 Shell\nWelcome to your workspace"
                    color: "#dfe3e9"
                    font.pixelSize: 14
                }
            }

            Item { width: 1; height: 1 }

            Rectangle {
                width: parent.width
                height: 48
                radius: 14
                color: "#191c23"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Taha"
                    color: "#eef1f5"
                    font.pixelSize: 14
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: "⏻"
                    color: "#e7eaf0"
                    font.pixelSize: 21
                }
            }
        }
    }

    Keys.onEscapePressed: root.open = false
}

import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool open: false
    property var applications: [
        {name:"File Explorer", icon:"▣", command:"explorer"},
        {name:"Terminal", icon:">", command:"terminal"},
        {name:"Settings", icon:"⚙", command:"settings"},
        {name:"Browser", icon:"◎", command:"browser"},
        {name:"Calculator", icon:"=", command:"calculator"},
        {name:"Notepad", icon:"▤", command:"notepad"}
    ]

    signal launch(string command)

    visible: open
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.38

        MouseArea {
            anchors.fill: parent
            onClicked: root.open = false
        }
    }

    GlassPanel {
        id: panel

        width: Math.min(parent.width - 48, 760)
        height: Math.min(parent.height - 100, 540)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 70

        glassColor: "#f0141720"
        radius: 24

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            Rectangle {
                width: parent.width
                height: 58
                radius: 16
                color: "#252a34"
                border.width: 1
                border.color: "#343b47"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    text: "⌕"
                    color: "#9da5b3"
                    font.pixelSize: 25
                }

                TextInput {
                    id: input
                    anchors.left: parent.left
                    anchors.leftMargin: 54
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#f6f7fa"
                    selectionColor: "#477fce"
                    font.pixelSize: 17
                    onTextChanged: panel.rebuild()
                    onAccepted: {
                        if (filtered.count)
                            root.launch(filtered.get(0).command)
                    }
                }

                Text {
                    anchors.left: input.left
                    anchors.verticalCenter: input.verticalCenter
                    text: "Search apps, files, settings..."
                    color: "#858d9a"
                    font.pixelSize: 17
                    visible: input.text.length === 0
                }
            }

            Text {
                text: input.text.length ? "Search results" : "Quick access"
                color: "#f5f7fa"
                font.pixelSize: 19
                font.bold: true
            }

            ListModel { id: filtered }

            ListView {
                id: list
                width: parent.width
                height: parent.height - 112
                spacing: 5
                clip: true
                model: filtered

                delegate: Rectangle {
                    width: list.width
                    height: 60
                    radius: 13
                    color: hover.containsMouse ? "#252b36" : "transparent"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 14
                        spacing: 15

                        Text {
                            width: 38
                            anchors.verticalCenter: parent.verticalCenter
                            text: model.icon
                            color: "#f5f7fa"
                            font.pixelSize: 22
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                text: model.name
                                color: "#f5f7fa"
                                font.pixelSize: 15
                            }

                            Text {
                                text: "Application"
                                color: "#818997"
                                font.pixelSize: 12
                            }
                        }
                    }

                    MouseArea {
                        id: hover
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.launch(model.command)
                    }
                }
            }
        }

        function rebuild() {
            filtered.clear()
            const q = input.text.toLowerCase()

            for (let i = 0; i < applications.length; ++i) {
                if (!q || applications[i].name.toLowerCase().indexOf(q) >= 0)
                    filtered.append(applications[i])
            }
        }

        onVisibleChanged: {
            if (visible) {
                input.text = ""
                rebuild()
                input.forceActiveFocus()
            }
        }
    }

    Keys.onEscapePressed: root.open = false
}

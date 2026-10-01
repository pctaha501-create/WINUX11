import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent
    property string currentPath: fileService.homePath()
    property var entries: []
    property string statusText: ""

    function refresh() {
        entries = fileService.list(currentPath)
        statusText = entries.length + " items"
    }

    function navigate(path) {
        if (fileService.isDirectory(path)) {
            currentPath = path
            refresh()
        }
    }

    Component.onCompleted: refresh()

    Rectangle {
        anchors.fill: parent
        radius: 18
        color: "#EE0B1018"
        border.color: "#55FFFFFF"
        border.width: 1
    }

    Column {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 10

        Row {
            width: parent.width
            spacing: 7

            Button { text: "←"; onClicked: navigate(fileService.parentPath(currentPath)) }
            Button { text: "↑"; onClicked: navigate(fileService.parentPath(currentPath)) }

            TextField {
                id: pathBox
                width: parent.width - 250
                text: currentPath
                color: "#FFFFFF"
                selectByMouse: true
                background: Rectangle {
                    radius: 9
                    color: "#331C2330"
                    border.color: "#44FFFFFF"
                }
                onAccepted: navigate(text)
            }

            Button { text: "↻"; onClicked: refresh() }
            Button {
                text: "+ Folder"
                onClicked: {
                    if (fileService.createFolder(currentPath, "New Folder"))
                        refresh()
                }
            }
        }

        Row {
            width: parent.width
            spacing: 8

            Text {
                text: currentPath
                color: "#FFFFFF"
                elide: Text.ElideMiddle
                width: parent.width - 90
                font.pixelSize: 12
            }

            Text {
                text: statusText
                color: "#AFC0D0"
                font.pixelSize: 11
            }
        }

        ListView {
            id: listView
            width: parent.width
            height: parent.height - 88
            clip: true
            model: entries
            spacing: 4

            delegate: Rectangle {
                required property string modelData
                width: listView.width
                height: 44
                radius: 9
                color: mouse.containsMouse ? "#22FFFFFF" : "#10000000"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    text: fileService.isDirectory(currentPath + "/" + modelData) ? "▣  " + modelData : "▤  " + modelData
                    color: "#FFFFFF"
                    font.pixelSize: 13
                    elide: Text.ElideRight
                    width: parent.width - 28
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onDoubleClicked: {
                        var target = currentPath + "/" + modelData
                        if (fileService.isDirectory(target))
                            navigate(target)
                        else
                            fileService.open(target)
                    }
                }

                ToolTip.visible: mouse.containsMouse
                ToolTip.text: "Double-click to open"
                ToolTip.delay: 500
            }
        }
    }
}
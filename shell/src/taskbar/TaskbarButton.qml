import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property bool active: false
    signal clicked()

    width: 42
    height: 42

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 13
        color: root.active ? "#253B536A" : (mouse.containsMouse ? "#20FFFFFF" : "transparent")
        border.width: root.active || mouse.containsMouse ? 1 : 0
        border.color: "#45FFFFFF"
        scale: mouse.pressed ? 0.90 : (mouse.containsMouse ? 1.06 : 1.0)

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

        Image {
            anchors.centerIn: parent
            width: 22
            height: 22
            source: root.iconSource
            sourceSize: Qt.size(44, 44)
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            asynchronous: false
            visible: status === Image.Ready
        }

        Rectangle {
            anchors.centerIn: parent
            width: 5
            height: 5
            radius: 3
            color: Theme.accent
            visible: parent.children.length > 0 && root.iconSource.length > 0
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 50
    height: 50

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 15
        color: root.active ? "#304A6175" : (mouse.containsMouse ? "#24FFFFFF" : "#10000000")
        border.width: root.active || mouse.containsMouse ? 1 : 0
        border.color: "#62FFFFFF"
        scale: mouse.pressed ? 0.92 : (mouse.containsMouse ? 1.04 : 1.0)

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

        Image {
            id: icon
            anchors.centerIn: parent
            width: 32
            height: 32
            source: root.iconSource
            sourceSize: Qt.size(96, 96)
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            asynchronous: false
            opacity: status === Image.Ready ? 1.0 : 0.0
        }

        Rectangle {
            anchors.centerIn: parent
            width: 30
            height: 30
            radius: 8
            color: "transparent"
            border.width: 1
            border.color: "#18FFFFFF"
            visible: icon.status !== Image.Ready
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: 5
        text: root.label
        color: Theme.textPrimary
        font.pixelSize: 10
        font.weight: Font.Medium
        visible: mouse.containsMouse
    }
}
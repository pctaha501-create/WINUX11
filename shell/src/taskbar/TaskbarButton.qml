import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 44
    height: 44

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 13
        color: root.active ? "#304A6175" : (mouse.containsMouse ? "#20FFFFFF" : "#08000000")
        border.width: root.active || mouse.containsMouse ? 1 : 0
        border.color: "#62FFFFFF"
        scale: mouse.pressed ? 0.94 : (mouse.containsMouse ? 1.03 : 1.0)

        Behavior on color { ColorAnimation { duration: 110 } }
        Behavior on scale { NumberAnimation { duration: 110; easing.type: Easing.OutCubic } }

        Image {
            id: icon
            anchors.centerIn: parent
            width: 28
            height: 28
            source: root.iconSource
            sourceSize: Qt.size(64, 64)
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            asynchronous: false
            visible: status === Image.Ready
        }

        Rectangle {
            anchors.centerIn: parent
            width: 25
            height: 25
            radius: 7
            color: "transparent"
            border.width: 1
            border.color: "#35EAF2FF"
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
        anchors.topMargin: 4
        text: root.label
        color: "#FFFFFF"
        font.pixelSize: 9
        font.weight: Font.Medium
        visible: mouse.containsMouse
    }
}

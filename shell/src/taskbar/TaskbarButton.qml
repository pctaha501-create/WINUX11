import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 62
    height: 62

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 18
        color: root.active ? "#5547D7FF" : (mouse.containsMouse ? "#35FFFFFF" : "#182B4650")
        border.width: root.active || mouse.containsMouse ? 1 : 0
        border.color: "#78C7F4FF"
        scale: mouse.pressed ? 0.90 : (mouse.containsMouse ? 1.06 : 1.0)

        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on scale { NumberAnimation { duration: 150; easing.type: Easing.OutBack } }

        Image {
            anchors.centerIn: parent
            width: 34
            height: 34
            source: root.iconSource
            sourceSize.width: 68
            sourceSize.height: 68
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            asynchronous: true
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
        anchors.topMargin: 3
        text: root.label
        color: Theme.textPrimary
        font.pixelSize: 11
        visible: mouse.containsMouse && root.label.length > 0
    }
}
import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 48
    height: 48

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 15
        color: root.active ? "#4A47D7FF" : (mouse.containsMouse ? "#35FFFFFF" : "#182B4650")
        border.width: root.active || mouse.containsMouse ? 1 : 0
        border.color: "#78C7F4FF"
        scale: mouse.pressed ? 0.92 : (mouse.containsMouse ? 1.05 : 1.0)

        Behavior on color { ColorAnimation { duration: 130 } }
        Behavior on scale { NumberAnimation { duration: 130; easing.type: Easing.OutCubic } }

        Image {
            anchors.centerIn: parent
            width: 27
            height: 27
            source: root.iconSource
            sourceSize.width: 54
            sourceSize.height: 54
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            asynchronous: false
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
        anchors.topMargin: 1
        text: root.label
        color: Theme.textPrimary
        font.pixelSize: 9
        visible: mouse.containsMouse && root.label.length > 0
    }
}

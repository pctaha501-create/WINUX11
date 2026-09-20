import QtQuick
import WINUX11 1.0

Rectangle {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 42
    height: 42
    radius: 13
    color: mouse.pressed ? "#3C485D"
         : mouse.containsMouse ? "#2A3445"
         : root.active ? "#27364D"
         : "transparent"

    Behavior on color { ColorAnimation { duration: 120 } }

    Image {
        anchors.centerIn: parent
        width: 22
        height: 22
        source: root.iconSource
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Rectangle {
        visible: root.active
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        width: 5
        height: 3
        radius: 2
        color: Theme.accentBright
    }

    ToolTip {
        visible: mouse.containsMouse && root.label.length > 0
        text: root.label
        delay: 550
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}

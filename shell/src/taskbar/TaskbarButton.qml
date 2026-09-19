import QtQuick

Rectangle {
    id: root

    property string iconText: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 48
    height: 48
    radius: 14

    color: mouse.pressed ? "#354052"
         : mouse.containsMouse ? "#252c38"
         : root.active ? "#202936"
         : "transparent"

    Behavior on color {
        ColorAnimation { duration: 110 }
    }

    Text {
        anchors.centerIn: parent
        text: root.iconText
        color: "#f5f7fa"
        font.pixelSize: 21
    }

    Rectangle {
        visible: root.active
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        width: 5
        height: 3
        radius: 2
        color: "#5b9cff"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}

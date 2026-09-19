import QtQuick

Rectangle {
    id: root

    property color glassColor: "#e610141b"
    property color borderColor: "#353c48"
    property real shadowOpacity: 0.42

    radius: 20
    color: glassColor
    border.width: 1
    border.color: borderColor

    Rectangle {
        anchors.fill: parent
        anchors.margins: 1
        radius: Math.max(0, parent.radius - 1)
        color: "transparent"
        border.width: 1
        border.color: "#12ffffff"
    }

    Rectangle {
        z: -1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        anchors.topMargin: 7
        height: 20
        radius: 14
        color: "#000000"
        opacity: root.shadowOpacity
    }
}

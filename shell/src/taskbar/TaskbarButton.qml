import QtQuick
import WINUX11 1.0

Item {
    id: root
    property string glyph: "•"
    property string label: ""
    property bool active: false
    signal clicked()

    width: 44
    height: 44

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: root.active ? "#286EA8FF" : (mouse.containsMouse ? "#18FFFFFF" : "transparent")
        border.width: root.active ? 1 : 0
        border.color: "#55A9C9FF"
        scale: mouse.pressed ? 0.94 : (mouse.containsMouse ? 1.04 : 1.0)

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on scale { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

        Text {
            anchors.centerIn: parent
            text: root.glyph
            color: Theme.textPrimary
            font.pixelSize: 20
            font.weight: Font.Medium
        }

        Rectangle {
            visible: root.active
            width: 5; height: 5; radius: 2.5
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 4
            color: Theme.accent
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }

    ToolTip {
        visible: mouse.containsMouse && root.label.length > 0
        text: root.label
    }
}

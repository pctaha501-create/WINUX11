import QtQuick
import QtQuick.Controls
import WINUX11 1.0

Item {
    id: root
    property string glyph: "◆"
    property string label: ""
    property string iconSource: ""
    property bool active: false
    signal clicked()

    width: label.length > 0 ? 48 : 48
    height: 48

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: root.active ? "#3D5B8AFF" : (mouse.containsMouse ? "#263B5066" : "transparent")
        border.width: root.active ? 1 : 0
        border.color: "#66FFFFFF"

        Behavior on color { ColorAnimation { duration: 120 } }

        Image {
            anchors.centerIn: parent
            width: 25
            height: 25
            source: root.iconSource
            fillMode: Image.PreserveAspectFit
            visible: root.iconSource.length > 0
            smooth: true
        }

        Text {
            anchors.centerIn: parent
            text: root.glyph
            color: "#FFFFFFFF"
            font.pixelSize: 21
            font.weight: Font.Medium
            visible: root.iconSource.length === 0
        }

        Rectangle {
            visible: root.active
            width: 6
            height: 3
            radius: 2
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 3
            color: Theme.accent
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }

    ToolTip {
        id: tip
        visible: mouse.containsMouse && root.label.length > 0
        text: root.label
    }
}

import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string label: ""
    property bool active: false
    signal clicked()

    width: 72
    height: 76

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: 22
        color: root.active ? "#705DE9FF" : (mouse.containsMouse ? "#5AFFFFFF" : "#281D6573")
        border.width: root.active || mouse.containsMouse ? 1.5 : 1
        border.color: root.active ? "#D9FFFFFF" : "#72C9F2FA"
        scale: mouse.pressed ? 0.91 : (mouse.containsMouse ? 1.07 : 1.0)

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 2
            radius: 2
            color: "#DFFFFFFF"
            opacity: 0.65
        }

        Image {
            anchors.centerIn: parent
            width: 42
            height: 42
            source: root.iconSource
            sourceSize.width: 96
            sourceSize.height: 96
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
        }

        Behavior on color { ColorAnimation { duration: 160 } }
        Behavior on scale {
            NumberAnimation { duration: 180; easing.type: Easing.OutBack }
        }
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: root.active ? 28 : 0
        height: 3
        radius: 3
        color: Theme.accentBright

        Behavior on width { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: 3
        text: root.label
        color: Theme.textPrimary
        font.pixelSize: 11
        font.weight: Font.DemiBold
        visible: mouse.containsMouse
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}

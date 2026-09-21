import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string iconSource: ""
    property string text: ""
    property bool checked: false
    property bool compact: false
    signal clicked()

    width: compact ? 48 : 58
    height: compact ? 48 : 58

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: root.checked ? "#4A47D7FF" : (mouse.containsMouse ? "#2DFFFFFF" : "#142A3B44")
        border.width: 1
        border.color: root.checked ? "#99B9F5FF" : "#45B7DCE7"

        Behavior on color { ColorAnimation { duration: 140 } }
        Behavior on scale { NumberAnimation { duration: 140; easing.type: Easing.OutCubic } }

        Image {
            anchors.centerIn: parent
            width: root.compact ? 25 : 30
            height: width
            source: root.iconSource
            sourceSize.width: width * 2
            sourceSize.height: height * 2
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onPressed: parent.scale = 0.92
            onReleased: parent.scale = 1.0
            onCanceled: parent.scale = 1.0
            onClicked: root.clicked()
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        anchors.topMargin: 5
        text: root.text
        color: Theme.textPrimary
        font.pixelSize: 12
        visible: root.text.length > 0
    }
}
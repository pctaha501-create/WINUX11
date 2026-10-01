import QtQuick
import QtWayland.Compositor

Item {
    id: frame

    required property var shellSurface
    required property var toplevel

    width: 720
    height: 480
    clip: true

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: "#e80b1119"
        border.width: 1
        border.color: "#55ffffff"
    }

    Rectangle {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 38
        radius: 16
        color: "#f0141822"
        border.width: 1
        border.color: "#40ffffff"

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.right: closeButton.left
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: frame.toplevel ? (frame.toplevel.title || "WINUX11 Application") : "WINUX11 Application"
            color: "#ffffff"
            font.pixelSize: 13
            font.weight: Font.DemiBold
            elide: Text.ElideRight
        }

        Rectangle {
            id: maximizeButton
            anchors.right: closeButton.left
            anchors.rightMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: "#25FFFFFF"
            Text { anchors.centerIn: parent; text: frame.toplevel && frame.toplevel.maximized ? "❐" : "□"; color: "#FFFFFF"; font.pixelSize: 13 }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!frame.toplevel)
                        return
                    if (frame.toplevel.maximized)
                        frame.toplevel.sendUnmaximized(Qt.size(720, 480))
                    else
                        frame.toplevel.sendMaximized(Qt.size(1280, 662))
                }
            }
        }

        Rectangle {
            id: closeButton
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            radius: 12
            color: closeMouse.containsMouse ? "#ff5f57" : "#25ffffff"

            Text {
                anchors.centerIn: parent
                text: "×"
                color: "#ffffff"
                font.pixelSize: 17
            }

            MouseArea {
                id: closeMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (frame.toplevel)
                        frame.toplevel.sendClose()
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onPressed: {
                if (frame.toplevel)
                    frame.toplevel.sendConfigure(Qt.size(frame.width, frame.height - titleBar.height), [XdgToplevel.ActivatedState])
            }
        }

        DragHandler {
            target: frame
            enabled: frame.toplevel !== null
        }
    }

    ShellSurfaceItem {
        id: shellItem
        x: 1
        y: titleBar.height
        width: Math.max(1, frame.width - 2)
        height: Math.max(1, frame.height - titleBar.height - 1)
        shellSurface: frame.shellSurface
        moveItem: frame

        onSurfaceDestroyed: frame.destroy()
    }
}

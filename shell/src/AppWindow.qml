import QtQuick
import WINUX11 1.0

Item {
    id: root

    property string title: "WINUX11 App"
    property string appId: ""
    signal closed()
    signal minimized()

    anchors.fill: parent
    visible: appId.length > 0
    z: 900

    Rectangle {
        anchors.fill: parent
        color: "#52000000"
    }

    GlassPanel {
        id: frame
        width: Math.min(parent.width - 48, 1180)
        height: Math.min(parent.height - 110, 700)
        anchors.centerIn: parent
        radius: 24
        glassColor: "#F00A0E15"
        borderColor: "#65FFFFFF"
        borderWidth: 1

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 58
            radius: 24
            color: "#18000000"

            Text {
                x: 22
                anchors.verticalCenter: parent.verticalCenter
                text: root.title
                color: Theme.textPrimary
                font.pixelSize: 16
                font.weight: Font.DemiBold
            }

            Text {
                anchors.right: closeButton.left
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                text: root.appId
                color: Theme.textMuted
                font.pixelSize: 11
            }

            Rectangle {
                id: minimizeButton
                width: 34
                height: 34
                anchors.right: closeButton.left
                anchors.rightMargin: 6
                anchors.verticalCenter: parent.verticalCenter
                radius: 17
                color: minMouse.containsMouse ? "#25FFFFFF" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "—"
                    color: Theme.textPrimary
                    font.pixelSize: 17
                }

                MouseArea {
                    id: minMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.minimized()
                }
            }

            Rectangle {
                id: closeButton
                width: 34
                height: 34
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                radius: 17
                color: closeMouse.containsMouse ? "#45E85A67" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "×"
                    color: Theme.textPrimary
                    font.pixelSize: 22
                }

                MouseArea {
                    id: closeMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.closed()
                }
            }
        }

        Loader {
            id: appLoader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 58
            anchors.bottom: parent.bottom
            source:
                root.appId === "terminal" ? "apps/TerminalApp.qml" :
                root.appId === "browser" ? "apps/BrowserApp.qml" :
                root.appId === "explorer" ? "apps/ExplorerApp.qml" :
                root.appId === "settings" ? "apps/SettingsApp.qml" :
                root.appId === "taskmanager" ? "apps/TaskManagerApp.qml" :
                root.appId === "editor" ? "apps/TextEditorApp.qml" :
                root.appId === "calculator" ? "apps/CalculatorApp.qml" :
                root.appId === "network" ? "apps/NetworkApp.qml" :
                root.appId === "security" ? "apps/SecurityApp.qml" :
                root.appId === "notifications" ? "apps/NotificationsApp.qml" :
                root.appId === "about" ? "apps/AboutApp.qml" : ""
        }
    }
}
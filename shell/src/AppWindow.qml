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

    function appSource(id) {
        var known = {
            terminal: "apps/TerminalApp.qml",
            browser: "apps/BrowserApp.qml",
            explorer: "apps/ExplorerApp.qml",
            settings: "apps/SettingsApp.qml",
            taskmanager: "apps/TaskManagerApp.qml",
            editor: "apps/TextEditorApp.qml",
            calculator: "apps/CalculatorApp.qml",
            network: "apps/NetworkApp.qml",
            security: "apps/SecurityApp.qml",
            notifications: "apps/NotificationsApp.qml",
            about: "apps/AboutApp.qml"
        }
        return known[id] || "apps/GenericApp.qml"
    }

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
            source: root.appId.length > 0 ? root.appSource(root.appId) : ""

            onLoaded: {
                if (item) {
                    if (item.hasOwnProperty("appTitle"))
                        item.appTitle = root.title
                    if (item.hasOwnProperty("appId"))
                        item.appId = root.appId
                }
            }
        }
    }
}

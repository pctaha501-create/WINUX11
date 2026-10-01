import QtQuick
import WINUX11 1.0

Item {
    id: root
    property string title: "WINUX11"
    property string appId: ""
    signal closed()
    signal minimized()

    anchors.fill: parent
    visible: appId.length > 0
    z: 900

    function appSource(id) {
        var sources = {
            terminal: "qrc:/qt/qml/WINUX11/apps/TerminalApp.qml",
            browser: "qrc:/qt/qml/WINUX11/apps/BrowserApp.qml",
            explorer: "qrc:/qt/qml/WINUX11/apps/ExplorerApp.qml",
            settings: "qrc:/qt/qml/WINUX11/apps/SettingsApp.qml",
            taskmanager: "qrc:/qt/qml/WINUX11/apps/TaskManagerApp.qml",
            editor: "qrc:/qt/qml/WINUX11/apps/TextEditorApp.qml",
            calculator: "qrc:/qt/qml/WINUX11/apps/CalculatorApp.qml",
            network: "qrc:/qt/qml/WINUX11/apps/NetworkApp.qml",
            security: "qrc:/qt/qml/WINUX11/apps/SecurityApp.qml",
            notifications: "qrc:/qt/qml/WINUX11/apps/NotificationsApp.qml",
            about: "qrc:/qt/qml/WINUX11/apps/AboutApp.qml"
        }
        return sources[id] || "qrc:/qt/qml/WINUX11/apps/GenericApp.qml"
    }

    Rectangle {
        anchors.fill: parent
        color: "#66000000"
    }

    GlassPanel {
        id: frame
        width: Math.min(parent.width - 72, 1180)
        height: Math.min(parent.height - 132, 700)
        anchors.centerIn: parent
        radius: 26
        glassColor: "#F20B1019"
        borderColor: "#55FFFFFF"
        borderWidth: 1

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 62
            radius: 26
            color: "#16000000"

            Text {
                x: 24
                anchors.verticalCenter: parent.verticalCenter
                text: root.title
                color: Theme.textPrimary
                font.pixelSize: 17
                font.weight: Font.DemiBold
            }

            Text {
                x: 24
                anchors.top: parent.verticalCenter
                anchors.topMargin: 8
                text: root.appId
                color: Theme.textMuted
                font.pixelSize: 9
                visible: root.appId.length > 0
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                Rectangle {
                    width: 36
                    height: 36
                    radius: 12
                    color: minMouse.containsMouse ? "#20FFFFFF" : "transparent"
                    Text { anchors.centerIn: parent; text: "—"; color: Theme.textPrimary; font.pixelSize: 18 }
                    MouseArea { id: minMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.minimized() }
                }

                Rectangle {
                    width: 36
                    height: 36
                    radius: 12
                    color: closeMouse.containsMouse ? "#35E85A67" : "transparent"
                    Text { anchors.centerIn: parent; text: "×"; color: Theme.textPrimary; font.pixelSize: 23 }
                    MouseArea { id: closeMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.closed() }
                }
            }
        }

        Loader {
            id: appLoader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 62
            source: root.appId.length > 0 ? root.appSource(root.appId) : ""

            onLoaded: {
                if (item && item.hasOwnProperty("appTitle"))
                    item.appTitle = root.title
            }

            onStatusChanged: {
                if (status === Loader.Error)
                    console.log("WINUX11: failed to load app", root.appId, source)
            }
        }
    }
}

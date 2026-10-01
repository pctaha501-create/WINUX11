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
        color: "#44000000"
    }

    GlassPanel {
        id: frame
        width: Math.min(parent.width - 90, 1180)
        height: Math.min(parent.height - 155, 690)
        anchors.centerIn: parent
        radius: 26
        glassColor: "#F20B1018"
        borderColor: "#48FFFFFF"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 60
            radius: 26
            color: "#10000000"

            Text {
                x: 22
                anchors.verticalCenter: parent.verticalCenter
                text: root.title
                color: Theme.textPrimary
                font.pixelSize: 15
                font.weight: Font.DemiBold
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                Rectangle {
                    width: 34; height: 34; radius: 11
                    color: minMouse.containsMouse ? "#20FFFFFF" : "transparent"
                    Text { anchors.centerIn: parent; text: "—"; color: Theme.textPrimary; font.pixelSize: 18 }
                    MouseArea { id: minMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.minimized() }
                }

                Rectangle {
                    width: 34; height: 34; radius: 11
                    color: closeMouse.containsMouse ? "#40F16C78" : "transparent"
                    Text { anchors.centerIn: parent; text: "×"; color: Theme.textPrimary; font.pixelSize: 21 }
                    MouseArea { id: closeMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.closed() }
                }
            }
        }

        Loader {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 60
            source: root.appId.length > 0 ? root.appSource(root.appId) : ""
            onStatusChanged: if (status === Loader.Error) console.log("WINUX11 app load failed:", source)
        }
    }
}

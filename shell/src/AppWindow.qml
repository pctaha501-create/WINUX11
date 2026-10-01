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
        color: "#AA000000"
        visible: root.visible
    }

    GlassPanel {
        id: frame
        width: Math.min(parent.width - 90, 1240)
        height: Math.min(parent.height - 145, 760)
        anchors.centerIn: parent
        radius: 20
        glassColor: "#F51A2533"
        borderColor: "#70FFFFFF"

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 54
            radius: 20
            color: "#F51A2533"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#35FFFFFF"
            }

            Text {
                x: 20
                anchors.verticalCenter: parent.verticalCenter
                text: root.title
                color: "#FFFFFFFF"
                font.pixelSize: 14
                font.weight: Font.DemiBold
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                spacing: 7

                Rectangle {
                    width: 32
                    height: 32
                    radius: 10
                    color: minMouse.containsMouse ? "#33465D78" : "transparent"
                    Text { anchors.centerIn: parent; text: "—"; color: "#FFFFFFFF"; font.pixelSize: 18 }
                    MouseArea { id: minMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.minimized() }
                }

                Rectangle {
                    width: 32
                    height: 32
                    radius: 10
                    color: closeMouse.containsMouse ? "#C93D5263" : "transparent"
                    Text { anchors.centerIn: parent; text: "×"; color: "#FFFFFFFF"; font.pixelSize: 21 }
                    MouseArea { id: closeMouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.closed() }
                }
            }
        }

        Loader {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 54
            anchors.margins: 1
            source: root.appId.length > 0 ? root.appSource(root.appId) : ""
            onStatusChanged: if (status === Loader.Error) console.log("WINUX11 app load failed:", source)
        }
    }
}

import QtQuick
import QtQuick.Controls
import WINUX11 1.0

Item {
    id: root
    property string appTitle: "WINUX11 App"
    property string appDescription: "System application"
    property string appId: ""

    anchors.fill: parent

    Column {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 18

        Text {
            text: root.appTitle
            color: Theme.textPrimary
            font.pixelSize: 26
            font.weight: Font.DemiBold
        }

        Text {
            text: root.appDescription
            color: Theme.textSecondary
            font.pixelSize: 14
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Rectangle {
            width: parent.width
            height: 1
            color: Theme.border
        }

        Text {
            text: "WINUX11 system component"
            color: Theme.textPrimary
            font.pixelSize: 16
        }

        Text {
            text: "This application is registered with the WINUX11 Shell and is ready for its native service implementation."
            color: Theme.textSecondary
            font.pixelSize: 13
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Row {
            spacing: 10

            Button {
                text: "Open Home"
                onClicked: launcher.openExplorer()
            }

            Button {
                text: "Open Terminal"
                onClicked: launcher.openTerminal()
            }
        }
    }
}

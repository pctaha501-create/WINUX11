import QtQuick
import WINUX11 1.0

Item {
    id: root

    width: 245
    height: 42

    property bool panelOpen: false
    signal panelToggled()

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        TaskbarButton {
            iconSource: "../../assets/icons/network.svg"
            label: "Wi-Fi"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            iconSource: "../../assets/icons/volume.svg"
            label: "Volume"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            iconSource: "../../assets/icons/settings.svg"
            label: "Settings"
            onClicked: systemService.openSettings()
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatTime(new Date(), "HH:mm")
            color: "#FFFFFF"
            font.pixelSize: 13
            font.weight: Font.Medium

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }
    }
}

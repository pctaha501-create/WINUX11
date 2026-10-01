import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool panelOpen: false
    signal panelToggled()

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        TaskbarButton {
            width: 38; height: 38
            iconSource: "../assets/icons/network.svg"
            label: "Wi-Fi"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            width: 38; height: 38
            iconSource: "../assets/icons/volume.svg"
            label: "Volume"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            width: 38; height: 38
            iconSource: "../assets/icons/bluetooth.svg"
            label: "Bluetooth"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        TaskbarButton {
            width: 38; height: 38
            iconSource: "../assets/icons/settings.svg"
            label: "Quick Settings"
            active: root.panelOpen
            onClicked: root.panelToggled()
        }

        Text {
            width: 62
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatTime(new Date(), "HH:mm")
            color: Theme.textPrimary
            font.pixelSize: 12
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: parent.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }
    }
}

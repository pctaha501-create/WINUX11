import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    property bool nightLightEnabled: false
    property bool focusEnabled: false

    visible: open
    opacity: open ? 1 : 0
    y: open ? 0 : 12
    Behavior on opacity { NumberAnimation { duration: 140 } }
    Behavior on y { NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        radius: 26
        glassColor: "#F20B111A"
        borderColor: "#42FFFFFF"

        Column {
            anchors.fill: parent
            anchors.margins: 22
            spacing: 16

            Row {
                width: parent.width
                spacing: 12
                Column {
                    width: parent.width - 44
                    Text { text: "Control Center"; color: Theme.textPrimary; font.pixelSize: 22; font.weight: Font.DemiBold }
                    Text { text: "Quick access to system controls"; color: Theme.textMuted; font.pixelSize: 11 }
                }
                Text { text: "×"; color: Theme.textSecondary; font.pixelSize: 24 }
            }

            Grid {
                width: parent.width
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                Repeater {
                    model: [
                        {name:"Wi-Fi", glyph:"⌁", key:"network"},
                        {name:"Bluetooth", glyph:"ᛒ", key:"bluetooth"},
                        {name:"Night light", glyph:"☾", key:"night"},
                        {name:"Focus", glyph:"◌", key:"focus"}
                    ]

                    delegate: Rectangle {
                        width: (parent.width - 10) / 2
                        height: 84
                        radius: 18
                        color: mouse.containsMouse ? "#20FFFFFF" : "#0DFFFFFF"
                        border.width: 1
                        border.color: "#20FFFFFF"

                        Text { x: 14; y: 12; text: modelData.glyph; color: Theme.textPrimary; font.pixelSize: 20 }
                        Text { x: 14; y: 43; text: modelData.name; color: Theme.textPrimary; font.pixelSize: 12; font.weight: Font.Medium }
                        Text {
                            x: 14; y: 62
                            text: modelData.key === "network" ? (systemService.networkEnabled ? "Connected" : "Off")
                                : modelData.key === "bluetooth" ? (systemService.bluetoothEnabled ? "On" : "Off")
                                : modelData.key === "night" ? (root.nightLightEnabled ? "On" : "Off")
                                : (root.focusEnabled ? "On" : "Off")
                            color: Theme.textMuted
                            font.pixelSize: 9
                        }

                        MouseArea {
                            id: mouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                if (modelData.key === "network") systemService.toggleNetwork()
                                else if (modelData.key === "bluetooth") systemService.toggleBluetooth()
                                else if (modelData.key === "night") {
                                    root.nightLightEnabled = !root.nightLightEnabled
                                    systemService.toggleNightLight(root.nightLightEnabled)
                                } else {
                                    root.focusEnabled = !root.focusEnabled
                                    systemService.toggleFocus(root.focusEnabled)
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#18FFFFFF"
            }

            Row {
                width: parent.width
                spacing: 12
                Text { text: "Volume"; color: Theme.textSecondary; font.pixelSize: 11; width: 56; anchors.verticalCenter: parent.verticalCenter }
                Rectangle {
                    width: parent.width - 68
                    height: 8
                    radius: 4
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#20FFFFFF"
                    Rectangle {
                        width: parent.width * systemService.volume / 100
                        height: parent.height
                        radius: 4
                        color: Theme.accent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: systemService.setVolume(Math.round(mouse.x / width * 100))
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 52
                radius: 16
                color: "#0DFFFFFF"
                Text { x: 14; anchors.verticalCenter: parent.verticalCenter; text: "System Settings"; color: Theme.textPrimary; font.pixelSize: 12 }
                Text { anchors.right: parent.right; anchors.rightMargin: 14; anchors.verticalCenter: parent.verticalCenter; text: "›"; color: Theme.textMuted; font.pixelSize: 20 }
                MouseArea { anchors.fill: parent; onClicked: systemService.openSettings() }
            }
        }
    }
}

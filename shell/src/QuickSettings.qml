import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    property bool nightLightEnabled: false
    property bool focusEnabled: false

    visible: open
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.96
    Behavior on opacity { NumberAnimation { duration: 140 } }
    Behavior on scale { NumberAnimation { duration: 170; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        radius: 24
        glassColor: "#F20B1019"
        borderColor: "#50FFFFFF"
        borderWidth: 1

        Column {
            anchors.fill: parent
            anchors.margins: 22
            spacing: 14

            Text { text: "Quick Settings"; color: Theme.textPrimary; font.pixelSize: 21; font.weight: Font.DemiBold }
            Text { text: "System controls"; color: Theme.textMuted; font.pixelSize: 12 }

            Grid {
                width: parent.width
                columns: 2
                rowSpacing: 10
                columnSpacing: 10

                Repeater {
                    model: [
                        {name:"Wi-Fi", key:"network"},
                        {name:"Bluetooth", key:"bluetooth"},
                        {name:"Night Light", key:"night"},
                        {name:"Focus", key:"focus"}
                    ]

                    delegate: Rectangle {
                        required property var modelData
                        width: (parent.width - 10) / 2
                        height: 72
                        radius: 18
                        color: mouse.containsMouse ? "#22FFFFFF" : "#12000000"
                        border.width: 1
                        border.color: "#28FFFFFF"

                        Text {
                            x: 14; y: 13
                            text: modelData.name
                            color: Theme.textPrimary
                            font.pixelSize: 13
                            font.weight: Font.Medium
                        }

                        Text {
                            x: 14; y: 42
                            text: modelData.key === "network" ? (systemService.networkEnabled ? "Connected" : "Off")
                                 : modelData.key === "bluetooth" ? (systemService.bluetoothEnabled ? "On" : "Off")
                                 : modelData.key === "night" ? (root.nightLightEnabled ? "On" : "Off")
                                 : (root.focusEnabled ? "On" : "Off")
                            color: Theme.textMuted
                            font.pixelSize: 10
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

            Text { text: "Audio"; color: Theme.textMuted; font.pixelSize: 12 }

            Row {
                width: parent.width
                spacing: 12
                Text {
                    text: systemService.volume + "%"
                    color: Theme.textPrimary
                    font.pixelSize: 25
                    font.weight: Font.DemiBold
                    width: 54
                }

                Slider {
                    id: volumeSlider
                    width: parent.width - 66
                    anchors.verticalCenter: parent.verticalCenter
                    from: 0; to: 100
                    value: systemService.volume
                    onMoved: systemService.setVolume(Math.round(value))
                }
            }
        }
    }
}

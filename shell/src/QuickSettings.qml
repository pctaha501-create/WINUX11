import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false

    width: 360
    height: 370
    visible: open
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.96
    z: 1100

    Behavior on opacity {
        NumberAnimation { duration: 150 }
    }

    Behavior on scale {
        NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    GlassPanel {
        id: panel
        anchors.fill: parent
        radius: 30
        glassColor: "#F00A0E15"
        borderColor: "#58FFFFFF"
        borderWidth: 1

        Text {
            x: 22
            y: 20
            text: "Quick Settings"
            color: "#FFFFFF"
            font.pixelSize: 20
            font.weight: Font.DemiBold
        }

        Text {
            x: 22
            y: 50
            text: "System controls"
            color: "#FFFFFF"
            font.pixelSize: 12
        }

        Grid {
            x: 22
            y: 88
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: [
                    { name: "Network", icon: "network.svg", key: "network" },
                    { name: "Bluetooth", icon: "bluetooth.svg", key: "bluetooth" },
                    { name: "Night light", icon: "moon.svg", key: "night" },
                    { name: "Focus", icon: "focus.svg", key: "focus" }
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: 153
                    height: 72
                    radius: 22

                    property bool enabledState:
                        modelData.key === "network" ? systemService.networkEnabled :
                        modelData.key === "bluetooth" ? systemService.bluetoothEnabled :
                        modelData.key === "night" ? root.nightLightEnabled :
                        root.focusEnabled

                    color: enabledState ? "#304A6175" : (controlMouse.containsMouse ? "#22FFFFFF" : "#14000000")
                    border.width: 1
                    border.color: enabledState ? "#65FFFFFF" : "#28FFFFFF"

                    Behavior on color {
                        ColorAnimation { duration: 120 }
                    }

                    Image {
                        x: 14
                        width: 25
                        height: 25
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../../assets/icons/" + modelData.icon
                        sourceSize: Qt.size(50, 50)
                        smooth: true
                    }

                    Text {
                        x: 53
                        anchors.verticalCenter: parent.verticalCenter
                        text: modelData.name
                        color: "#FFFFFF"
                        font.pixelSize: 13
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        text: enabledState ? "ON" : "OFF"
                        color: "#FFFFFF"
                        font.pixelSize: 9
                        font.weight: Font.DemiBold
                    }

                    MouseArea {
                        id: controlMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (modelData.key === "network")
                                systemService.toggleNetwork()
                            else if (modelData.key === "bluetooth")
                                systemService.toggleBluetooth()
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
            x: 22
            y: 258
            width: 316
            height: 1
            color: "#24FFFFFF"
        }

        Text {
            x: 22
            y: 278
            text: "Audio"
            color: "#FFFFFF"
            font.pixelSize: 12
        }

        Text {
            x: 22
            y: 300
            text: systemService.volume + "%"
            color: "#FFFFFF"
            font.pixelSize: 26
            font.weight: Font.DemiBold
        }

        Rectangle {
            id: volumeTrack
            x: 22
            y: 340
            width: 316
            height: 7
            radius: 4
            color: "#20FFFFFF"

            Rectangle {
                width: parent.width * (systemService.volume / 100)
                height: parent.height
                radius: 4
                color: Theme.accent
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                function updateVolume(mouseX) {
                    var value = Math.max(0, Math.min(100,
                        Math.round((mouseX / volumeTrack.width) * 100)))
                    systemService.setVolume(value)
                }

                onPressed: updateVolume(mouse.x)
                onPositionChanged: {
                    if (pressed)
                        updateVolume(mouse.x)
                }
            }
        }
    }
}

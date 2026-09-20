import QtQuick
import WINUX11 1.0

Item {
    id: root

    property bool panelOpen: false
    property string currentTime: Qt.formatTime(new Date(), "HH:mm")
    signal panelToggled()

    width: 150
    height: 42

    Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        TrayButton {
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/network.svg"
            label: "Network"
            onClicked: root.panelToggled()
        }
        TrayButton {
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/volume.svg"
            label: "Audio"
            onClicked: root.panelToggled()
        }
        TrayButton {
            iconSource: "qrc:/qt/qml/WINUX11/assets/icons/battery.svg"
            label: "Power"
            onClicked: root.panelToggled()
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.currentTime
            color: Theme.textPrimary
            font.pixelSize: 12
            font.weight: Font.Medium
            leftPadding: 7
        }
    }

    Rectangle {
        id: panel
        visible: root.panelOpen
        z: 100
        width: 320
        height: 390
        x: parent.width - width
        y: -height - 12
        radius: 24
        color: "#EE101722"
        border.width: 1
        border.color: "#62FFFFFF"

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: 23
            color: "transparent"
            border.width: 1
            border.color: "#15FFFFFF"
        }

        Column {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 14

            Row {
                width: parent.width
                spacing: 10

                Column {
                    width: parent.width - 52
                    spacing: 2
                    Text { text: "Quick Settings"; color: Theme.textPrimary; font.pixelSize: 19; font.weight: Font.DemiBold }
                    Text { text: "WINUX11 control center"; color: Theme.textMuted; font.pixelSize: 11 }
                }

                Rectangle {
                    width: 40
                    height: 40
                    radius: 13
                    color: "#1C2635"
                    border.width: 1
                    border.color: "#28FFFFFF"
                    Text { anchors.centerIn: parent; text: "×"; color: Theme.textSecondary; font.pixelSize: 21 }
                    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.panelToggled() }
                }
            }

            Row {
                width: parent.width
                spacing: 10
                QuickTile { title: "Wi-Fi"; subtitle: "Connected"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/network.svg"; width: (parent.width - 10) / 2 }
                QuickTile { title: "Bluetooth"; subtitle: "Off"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/bluetooth.svg"; width: (parent.width - 10) / 2 }
            }

            Row {
                width: parent.width
                spacing: 10
                QuickTile { title: "Night light"; subtitle: "Off"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/moon.svg"; width: (parent.width - 10) / 2 }
                QuickTile { title: "Focus"; subtitle: "Ready"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/focus.svg"; width: (parent.width - 10) / 2 }
            }

            Text {
                text: "Volume"
                color: Theme.textSecondary
                font.pixelSize: 12
                font.weight: Font.Medium
            }

            Rectangle {
                width: parent.width
                height: 42
                radius: 14
                color: "#14202F"
                border.width: 1
                border.color: "#25FFFFFF"

                Image { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter; width: 18; height: 18; source: "qrc:/qt/qml/WINUX11/assets/icons/volume.svg" }

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 42
                    anchors.right: parent.right
                    anchors.rightMargin: 18
                    anchors.verticalCenter: parent.verticalCenter
                    height: 5
                    radius: 3
                    color: "#26364C"
                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.leftMargin: 42
                    anchors.verticalCenter: parent.verticalCenter
                    width: 150
                    height: 5
                    radius: 3
                    color: Theme.accent
                }

                Text { anchors.right: parent.right; anchors.rightMargin: 12; anchors.verticalCenter: parent.verticalCenter; text: "40%"; color: Theme.textPrimary; font.pixelSize: 11 }
            }

            Text {
                text: "Battery  •  Connected to power"
                color: Theme.textSecondary
                font.pixelSize: 12
            }

            Rectangle { width: parent.width; height: 1; color: "#18FFFFFF" }

            Row {
                width: parent.width
                spacing: 8
                QuickAction { title: "Settings"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/settings.svg"; width: (parent.width - 8) / 2 }
                QuickAction { title: "Notifications"; iconSource: "qrc:/qt/qml/WINUX11/assets/icons/notifications.svg"; width: (parent.width - 8) / 2 }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.currentTime = Qt.formatTime(new Date(), "HH:mm")
    }

    component TrayButton: Rectangle {
        id: tray
        property string iconSource: ""
        property string label: ""
        signal clicked()
        width: 32
        height: 38
        radius: 11
        color: mouse.containsMouse ? "#273245" : "transparent"
        Image { anchors.centerIn: parent; width: 17; height: 17; source: tray.iconSource }
        MouseArea { id: mouse; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: tray.clicked() }
    }

    component QuickTile: Rectangle {
        property string title: ""
        property string subtitle: ""
        property string iconSource: ""
        width: 100
        height: 76
        radius: 17
        color: "#182435"
        border.width: 1
        border.color: "#30FFFFFF"
        Image { x: 12; y: 13; width: 20; height: 20; source: parent.iconSource }
        Text { x: 12; y: 42; text: parent.title; color: Theme.textPrimary; font.pixelSize: 12; font.weight: Font.Medium }
        Text { x: 12; y: 59; text: parent.subtitle; color: Theme.textMuted; font.pixelSize: 9 }
        MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor }
    }

    component QuickAction: Rectangle {
        property string title: ""
        property string iconSource: ""
        width: 100
        height: 42
        radius: 13
        color: "#14202F"
        border.width: 1
        border.color: "#25FFFFFF"
        Image { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter; width: 16; height: 16; source: parent.iconSource }
        Text { anchors.left: parent.left; anchors.leftMargin: 36; anchors.verticalCenter: parent.verticalCenter; text: parent.title; color: Theme.textSecondary; font.pixelSize: 11 }
        MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor }
    }
}

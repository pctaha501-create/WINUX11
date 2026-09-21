import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    signal launch(string command)
    anchors.fill: parent
    visible: open
    opacity: open ? 1 : 0

    Rectangle { anchors.fill: parent; color: "#70000000"; visible: root.open }

    GlassPanel {
        width: 680; height: 500
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top; anchors.topMargin: 76
        glassColor: "#F00A0E15"; borderColor: "#48FFFFFF"; radius: 28
        scale: root.open ? 1 : 0.95; opacity: root.open ? 1 : 0
        Behavior on scale { NumberAnimation { duration: 190; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: 140 } }

        Text { x: 26; y: 22; text: "Search"; color: "#FFFFFF"; font.pixelSize: 23; font.weight: Font.DemiBold }

        Rectangle {
            x: 26; y: 66; width: parent.width - 52; height: 54; radius: 24
            color: "#14000000"; border.width: 1; border.color: "#32FFFFFF"
            Image { x: 16; anchors.verticalCenter: parent.verticalCenter; width: 23; height: 23; source: "qrc:/qt/qml/WINUX11/assets/icons/search.svg"; sourceSize: Qt.size(46,46) }
            TextInput { id: input; x: 52; anchors.verticalCenter: parent.verticalCenter; width: parent.width-68; color: "#FFFFFF"; selectionColor: Theme.accent; font.pixelSize: 16; focus: root.open; clip: true }
            Text { x: 52; anchors.verticalCenter: parent.verticalCenter; width: parent.width-68; text: "Type to search..."; color: "#FFFFFF"; font.pixelSize: 16; visible: input.text.length === 0; clip: true }
        }

        Text { x: 28; y: 143; text: input.text.length === 0 ? "Quick actions" : "Results"; color: "#FFFFFF"; font.pixelSize: 13 }

        Column {
            x: 26; y: 176; width: parent.width-52; spacing: 8
            Repeater {
                model: [
                    {name:"File Explorer",desc:"Browse files and folders",icon:"explorer.svg",cmd:"explorer"},
                    {name:"Terminal",desc:"Open the WINUX11 terminal",icon:"terminal.svg",cmd:"terminal"},
                    {name:"Settings",desc:"System settings",icon:"settings.svg",cmd:"settings"},
                    {name:"Browser",desc:"Open the web browser",icon:"browser.svg",cmd:"browser"}
                ]
                delegate: Rectangle {
                    required property var modelData
                    width: parent.width; height: 62; radius: 20
                    color: mouse.containsMouse ? "#1CFFFFFF" : "#10000000"
                    border.width: 1; border.color: "#20FFFFFF"
                    Image { x: 14; anchors.verticalCenter: parent.verticalCenter; width: 28; height: 28; source: "qrc:/qt/qml/WINUX11/assets/icons/" + modelData.icon; sourceSize: Qt.size(56,56) }
                    Text { x: 55; y: 11; text: modelData.name; color: "#FFFFFF"; font.pixelSize: 14 }
                    Text { x: 55; y: 34; text: modelData.desc; color: "#FFFFFF"; font.pixelSize: 11 }
                    MouseArea { id: mouse; anchors.fill: parent; hoverEnabled: true; onClicked: root.launch(modelData.cmd) }
                }
            }
        }
    }
}

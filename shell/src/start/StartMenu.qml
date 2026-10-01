import QtQuick
import WINUX11 1.0

Item {
    id: root
    property bool open: false
    signal searchRequested()
    signal launch(string command)

    width: 860
    height: 610
    opacity: open ? 1 : 0
    scale: open ? 1 : 0.96
    visible: opacity > 0

    Behavior on opacity { NumberAnimation { duration: 150 } }
    Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }

    GlassPanel {
        anchors.fill: parent
        glassColor: "#F00B0F17"
        borderColor: "#58FFFFFF"
        radius: 30

        Text {
            x: 28
            y: 22
            text: "WINUX11"
            color: Theme.textPrimary
            font.pixelSize: 25
            font.weight: Font.DemiBold
        }

        Text {
            x: 30
            y: 56
            text: "All applications"
            color: Theme.textSecondary
            font.pixelSize: 12
        }

        Rectangle {
            x: 26
            y: 88
            width: parent.width - 52
            height: 48
            radius: 18
            color: "#16000000"
            border.width: 1
            border.color: "#30FFFFFF"

            Text {
                anchors.verticalCenter: parent.verticalCenter
                x: 18
                text: "Search apps, files and settings"
                color: Theme.textSecondary
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.searchRequested()
            }
        }

        GridView {
            id: grid
            x: 26
            y: 160
            width: parent.width - 52
            height: parent.height - 180
            cellWidth: 194
            cellHeight: 78
            clip: true
            model: [
                {name:"File Explorer",cmd:"explorer"},
                {name:"Browser",cmd:"browser"},
                {name:"Terminal",cmd:"terminal"},
                {name:"Settings",cmd:"settings"},
                {name:"Task Manager",cmd:"taskmanager"},
                {name:"Text Editor",cmd:"editor"},
                {name:"Calculator",cmd:"calculator"},
                {name:"Network",cmd:"network"},
                {name:"Security",cmd:"security"},
                {name:"Notifications",cmd:"notifications"},
                {name:"Audio",cmd:"audio"},
                {name:"Photos",cmd:"photos"},
                {name:"Media Player",cmd:"mediaplayer"},
                {name:"Music Player",cmd:"musicplayer"},
                {name:"App Store",cmd:"appstore"},
                {name:"Downloader",cmd:"downloader"},
                {name:"Archive Manager",cmd:"archivemanager"},
                {name:"Printer Manager",cmd:"printermanager"},
                {name:"Disk Management",cmd:"diskmanagement"},
                {name:"Storage Manager",cmd:"storagemanager"},
                {name:"Bluetooth",cmd:"bluetooth"},
                {name:"Wi-Fi",cmd:"wifi"},
                {name:"Users & Accounts",cmd:"users"},
                {name:"Password Manager",cmd:"passwordmanager"},
                {name:"Privacy Center",cmd:"privacy"},
                {name:"Firewall",cmd:"firewall"},
                {name:"Threat Center",cmd:"threatcenter"},
                {name:"System Search",cmd:"systemsearch"},
                {name:"System Tools",cmd:"systemtools"},
                {name:"Calendar",cmd:"calendar"},
                {name:"Clock & Alarms",cmd:"clock"},
                {name:"Camera",cmd:"camera"},
                {name:"Voice Recorder",cmd:"voicerecorder"},
                {name:"Clipboard",cmd:"clipboard"},
                {name:"Sticky Notes",cmd:"stickynotes"},
                {name:"Maps",cmd:"maps"},
                {name:"Mail",cmd:"mail"},
                {name:"Messaging",cmd:"messaging"},
                {name:"Remote Desktop",cmd:"remotedesktop"},
                {name:"Screenshot",cmd:"screenshot"},
                {name:"System Update",cmd:"updates"},
                {name:"Package Manager",cmd:"packages"},
                {name:"Developer Tools",cmd:"developer"},
                {name:"Startup Apps",cmd:"startup"},
                {name:"Virtual Desktops",cmd:"virtualdesktops"},
                {name:"Snap Manager",cmd:"snap"},
                {name:"Notification Center",cmd:"notificationcenter"},
                {name:"Personalization",cmd:"personalization"},
                {name:"Display",cmd:"display"},
                {name:"Sound",cmd:"sound"},
                {name:"Game / Proton",cmd:"games"},
                {name:"Windows Apps",cmd:"wine"},
                {name:"About WINUX11",cmd:"about"}
            ]

            delegate: Rectangle {
                required property var modelData
                width: 182
                height: 66
                radius: 18
                color: mouse.containsMouse ? "#20FFFFFF" : "#10000000"
                border.width: 1
                border.color: "#24FFFFFF"

                Text {
                    anchors.centerIn: parent
                    width: parent.width - 24
                    text: modelData.name
                    color: Theme.textPrimary
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.launch(modelData.cmd)
                }
            }
        }
    }
}

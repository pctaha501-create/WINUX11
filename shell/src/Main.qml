import QtQuick
import QtQuick.Window
import WINUX11 1.0

Window {
    id: root
    width: 1280
    height: 720
    visible: true
    visibility: Window.FullScreen
    flags: Qt.Window | Qt.FramelessWindowHint
    color: Theme.backgroundDeep
    title: "WINUX11"

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    property string activeApp: ""
    property string activeTitle: ""

    function launch(command) {
        var titles = {
            explorer: "File Explorer",
            browser: "WINUX11 Browser",
            terminal: "WINUX11 Terminal",
            settings: "Settings",
            taskmanager: "Task Manager",
            editor: "Text Editor",
            calculator: "Calculator",
            network: "Network",
            security: "Security Center",
            notifications: "Notification Center",
            about: "About WINUX11"
        }

        activeApp = command
        activeTitle = titles[command] || "WINUX11"
        startOpen = false
        searchOpen = false
        quickSettingsOpen = false
    }

    Desktop {
        anchors.fill: parent
        z: 0
        onDesktopClicked: {
            root.startOpen = false
            root.searchOpen = false
            root.quickSettingsOpen = false
        }
        onLaunch: command => root.launch(command)
    }

    Row {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 28
        anchors.topMargin: 24
        spacing: 12
        z: 50

        Rectangle {
            width: 42
            height: 42
            radius: 13
            color: "#286EA8FF"
            border.width: 1
            border.color: "#55FFFFFF"

            Image {
                anchors.centerIn: parent
                width: 25
                height: 25
                source: "qrc:/qt/qml/WINUX11/assets/icons/start.svg"
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 1

            Text {
                text: "WINUX11"
                color: "#FFFFFFFF"
                font.pixelSize: 16
                font.weight: Font.DemiBold
            }

            Text {
                text: "Windows-style Linux desktop"
                color: "#B4C0D0"
                font.pixelSize: 10
            }
        }
    }

    StartMenu {
        id: startMenu
        width: Math.min(root.width - 56, 760)
        height: Math.min(root.height - 145, 620)
        anchors.left: parent.left
        anchors.bottom: taskbar.top
        anchors.leftMargin: 28
        anchors.bottomMargin: 8
        z: 700
        open: root.startOpen
        onSearchRequested: {
            root.startOpen = false
            root.searchOpen = true
        }
        onLaunch: command => root.launch(command)
    }

    Search {
        id: search
        anchors.fill: parent
        z: 800
        open: root.searchOpen
        onLaunch: command => root.launch(command)
    }

    Taskbar {
        id: taskbar
        z: 1000
        startOpen: root.startOpen
        searchOpen: root.searchOpen
        quickSettingsOpen: root.quickSettingsOpen
        onStartClicked: {
            root.startOpen = !root.startOpen
            root.searchOpen = false
        }
        onSearchClicked: {
            root.searchOpen = !root.searchOpen
            root.startOpen = false
        }
        onLaunch: command => root.launch(command)
        onQuickSettingsOpenChanged: root.quickSettingsOpen = taskbar.quickSettingsOpen
    }

    QuickSettings {
        id: quickSettings
        z: 1100
        width: 380
        height: 470
        anchors.right: parent.right
        anchors.bottom: taskbar.top
        anchors.rightMargin: 22
        anchors.bottomMargin: 8
        open: root.quickSettingsOpen
    }

    AppWindow {
        id: appWindow
        z: 1200
        appId: root.activeApp
        title: root.activeTitle
        onClosed: root.activeApp = ""
        onMinimized: root.activeApp = ""
    }
}

import QtQuick
import QtQuick.Window
import WINUX11 1.0

Window {
    id: root
    width: 1280
    height: 720
    minimumWidth: 960
    minimumHeight: 600
    visible: true
    visibility: Window.Maximized
    color: Theme.backgroundDeep
    title: "WINUX11"

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    property string activeApp: ""
    property string activeTitle: ""

    function launch(command) {
        var titles = {
            explorer:"File Explorer", browser:"WINUX11 Browser", terminal:"Terminal",
            settings:"Settings", taskmanager:"Task Manager", editor:"Text Editor",
            calculator:"Calculator", network:"Network", security:"Security",
            notifications:"Notifications", about:"About WINUX11"
        }
        activeApp = command
        activeTitle = titles[command] || "WINUX11"
        startOpen = false
        searchOpen = false
        quickSettingsOpen = false
    }

    Desktop {
        anchors.fill: parent
        onDesktopClicked: {
            root.startOpen = false
            root.searchOpen = false
            root.quickSettingsOpen = false
        }
    }

    Row {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 34
        anchors.topMargin: 88
        spacing: 12

        Rectangle {
            width: 190; height: 112; radius: 22
            color: "#0DFFFFFF"; border.width: 1; border.color: "#18FFFFFF"
            Column {
                anchors.fill: parent; anchors.margins: 16; spacing: 5
                Text { text: "Today"; color: Theme.textMuted; font.pixelSize: 10 }
                Text { text: Qt.formatDate(new Date(), "dddd"); color: Theme.textPrimary; font.pixelSize: 18; font.weight: Font.DemiBold }
                Text { text: Qt.formatDate(new Date(), "dd MMMM yyyy"); color: Theme.textSecondary; font.pixelSize: 10 }
            }
        }

        Rectangle {
            width: 190; height: 112; radius: 22
            color: "#0DFFFFFF"; border.width: 1; border.color: "#18FFFFFF"
            Column {
                anchors.fill: parent; anchors.margins: 16; spacing: 5
                Text { text: "System"; color: Theme.textMuted; font.pixelSize: 10 }
                Text { text: "WINUX11"; color: Theme.textPrimary; font.pixelSize: 18; font.weight: Font.DemiBold }
                Text { text: "All services operational"; color: Theme.success; font.pixelSize: 10 }
            }
        }
    }

    StartMenu {
        id: startMenu
        width: Math.min(parent.width - 120, 720)
        height: 590
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: taskbar.top
        anchors.bottomMargin: 8
        z: 700
        open: root.startOpen
        onSearchRequested: { root.startOpen = false; root.searchOpen = true }
        onLaunch: function(command) { root.launch(command) }
    }

    Search {
        id: search
        z: 800
        open: root.searchOpen
        onLaunch: function(command) { root.launch(command) }
    }

    Taskbar {
        id: taskbar
        z: 1000
        startOpen: root.startOpen
        searchOpen: root.searchOpen
        quickSettingsOpen: root.quickSettingsOpen
        onStartClicked: {
            root.searchOpen = false
            root.startOpen = !root.startOpen
        }
        onSearchClicked: {
            root.startOpen = false
            root.searchOpen = !root.searchOpen
        }
        onLaunch: function(command) { root.launch(command) }
        onQuickSettingsOpenChanged: root.quickSettingsOpen = taskbar.quickSettingsOpen
    }

    QuickSettings {
        id: quickSettings
        z: 1100
        width: 360
        height: 430
        x: root.width - width - 30
        y: Math.max(24, taskbar.y - height - 8)
        open: root.quickSettingsOpen
    }

    AppWindow {
        id: appWindow
        anchors.fill: parent
        z: 900
        appId: root.activeApp
        title: root.activeTitle
        onClosed: root.activeApp = ""
        onMinimized: root.activeApp = ""
    }
}

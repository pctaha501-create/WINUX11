import QtQuick
import QtQuick.Window
import WINUX11 1.0

Window {
    id: root
    width: 1280
    height: 720
    minimumWidth: 980
    minimumHeight: 600
    visible: true
    color: Theme.backgroundDeep
    title: "WINUX11"
    visibility: Window.Maximized

    property bool startOpen: false
    property bool searchOpen: false
    property bool quickSettingsOpen: false
    property string activeApp: ""
    property string activeTitle: ""

    function closeShellMenus() {
        startOpen = false
        searchOpen = false
        quickSettingsOpen = false
    }

    function launch(command) {
        const titles = {
            terminal:"Terminal", explorer:"File Explorer", browser:"WINUX Browser",
            settings:"Settings", taskmanager:"Task Manager", editor:"Text Editor",
            calculator:"Calculator", network:"Network", security:"Security",
            notifications:"Notifications", about:"About WINUX11", audio:"Audio"
        }

        if (command === "network" || command === "audio" || command === "notifications")
            activeApp = command
        else
            activeApp = command

        activeTitle = titles[command] || "WINUX11 App"
        closeShellMenus()
    }

    Desktop {
        anchors.fill: parent
        onDesktopClicked: root.closeShellMenus()
    }

    WindowManager { id: windowManager }

    StartMenu {
        id: startMenu
        z: 500
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: taskbar.top
        anchors.bottomMargin: 14
        open: root.startOpen
        onSearchRequested: {
            root.startOpen = false
            root.searchOpen = true
        }
        onLaunch: function(command) { root.launch(command) }
    }

    Search {
        id: search
        z: 600
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
            root.quickSettingsOpen = false
            root.startOpen = !root.startOpen
        }

        onSearchClicked: {
            root.startOpen = false
            root.quickSettingsOpen = false
            root.searchOpen = !root.searchOpen
        }

        onLaunch: function(command) { root.launch(command) }

        onQuickSettingsOpenChanged: root.quickSettingsOpen = quickSettingsOpen
    }

    QuickSettings {
        id: quickSettings
        z: 1100
        anchors.right: parent.right
        anchors.bottom: taskbar.top
        anchors.rightMargin: 16
        anchors.bottomMargin: 12
        width: Math.min(360, parent.width - 32)
        height: Math.min(370, parent.height - 110)
        open: root.quickSettingsOpen
    }

    AppWindow {
        id: appWindow
        appId: root.activeApp
        title: root.activeTitle
        onClosed: root.activeApp = ""
        onMinimized: root.activeApp = ""
    }

    Item {
        id: keyboardLayer
        anchors.fill: parent
        focus: true
        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                root.closeShellMenus()
                if (root.activeApp.length > 0)
                    root.activeApp = ""
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_E) {
                root.launch("explorer")
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_R) {
                root.launch("terminal")
                event.accepted = true
            } else if (event.key === Qt.Key_Meta) {
                root.startOpen = !root.startOpen
                event.accepted = true
            }
        }
    }
}
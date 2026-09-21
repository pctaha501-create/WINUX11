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

    function closeShellMenus() {
        startOpen = false
        searchOpen = false
        quickSettingsOpen = false
    }

    function launch(command) {
        if (command === "terminal")
            launcher.openTerminal()
        else if (command === "explorer")
            launcher.openExplorer()
        else if (command === "browser")
            launcher.openBrowser()

        closeShellMenus()
    }

    Desktop {
        anchors.fill: parent
        onDesktopClicked: root.closeShellMenus()
    }

    WindowManager {
        id: windowManager
    }

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
        onLaunch: function(command) {
            root.launch(command)
        }
    }

    Search {
        id: search
        z: 600
        open: root.searchOpen
        onLaunch: function(command) {
            root.launch(command)
        }
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

        onLaunch: function(command) {
            root.launch(command)
        }

        onQuickSettingsOpenChanged:
            root.quickSettingsOpen = taskbar.quickSettingsOpen
    }

    QuickSettings {
        id: quickSettings
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 16
        anchors.bottomMargin: 82
        open: root.quickSettingsOpen
    }

    Item {
        id: keyboardLayer
        anchors.fill: parent
        focus: true

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                root.closeShellMenus()
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_E) {
                root.launch("explorer")
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) && event.key === Qt.Key_R) {
                root.launch("terminal")
                event.accepted = true
            } else if (event.key === Qt.Key_Meta) {
                root.searchOpen = false
                root.quickSettingsOpen = false
                root.startOpen = !root.startOpen
                event.accepted = true
            }
        }
    }
}

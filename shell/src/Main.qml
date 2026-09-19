import QtQuick
import QtQuick.Window
import WINUX11 1.0

Window {
    id: root

    width: 1280
    height: 760
    minimumWidth: 900
    minimumHeight: 600
    visible: true
    color: "#08090d"
    title: "WINUX11"

    property bool startOpen: false
    property bool searchOpen: false

    function launch(command) {
        if (command === "terminal")
            launcher.openTerminal()
        else if (command === "explorer")
            launcher.openExplorer()
        else if (command === "browser")
            launcher.openBrowser()

        startOpen = false
        searchOpen = false
    }

    Desktop {
        anchors.fill: parent
    }

    WindowManager {
        id: windowManager
    }

    StartMenu {
        id: startMenu
        z: 500
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: taskbar.top
        anchors.bottomMargin: 8
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

        onStartClicked: {
            root.searchOpen = false
            root.startOpen = !root.startOpen
        }

        onSearchClicked: {
            root.startOpen = false
            root.searchOpen = !root.searchOpen
        }

        onLaunch: function(command) {
            root.launch(command)
        }
    }

    Item {
        id: keyboardLayer
        anchors.fill: parent
        focus: true

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Escape) {
                root.startOpen = false
                root.searchOpen = false
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) &&
                       event.key === Qt.Key_E) {
                root.launch("explorer")
                event.accepted = true
            } else if ((event.modifiers & Qt.MetaModifier) &&
                       event.key === Qt.Key_R) {
                root.launch("terminal")
                event.accepted = true
            } else if (event.key === Qt.Key_Meta) {
                root.searchOpen = false
                root.startOpen = !root.startOpen
                event.accepted = true
            }
        }
    }
}

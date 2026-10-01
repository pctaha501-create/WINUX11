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
        var titles = {
            terminal:"Terminal", explorer:"File Explorer", browser:"WINUX11 Browser",
            settings:"Settings", taskmanager:"Task Manager", editor:"Text Editor",
            calculator:"Calculator", network:"Network", security:"Security",
            notifications:"Notifications", audio:"Audio", photos:"Photos",
            mediaplayer:"Media Player", musicplayer:"Music Player", appstore:"App Store",
            downloader:"Downloader", archivemanager:"Archive Manager", printermanager:"Printer Manager",
            diskmanagement:"Disk Management", storagemanager:"Storage Manager", bluetooth:"Bluetooth",
            wifi:"Wi-Fi", users:"Users & Accounts", passwordmanager:"Password Manager",
            privacy:"Privacy Center", firewall:"Firewall", threatcenter:"Threat Center",
            systemsearch:"System Search", systemtools:"System Tools", calendar:"Calendar",
            clock:"Clock & Alarms", camera:"Camera", voicerecorder:"Voice Recorder",
            clipboard:"Clipboard", stickynotes:"Sticky Notes", maps:"Maps", mail:"Mail",
            messaging:"Messaging", remotedesktop:"Remote Desktop", screenshot:"Screenshot",
            updates:"System Update", packages:"Package Manager", developer:"Developer Tools",
            startup:"Startup Apps", virtualdesktops:"Virtual Desktops", snap:"Snap Manager",
            notificationcenter:"Notification Center", personalization:"Personalization",
            display:"Display", sound:"Sound", games:"Game / Proton", wine:"Windows Apps",
            about:"About WINUX11"
        }

        activeApp = command
        activeTitle = titles[command] || "WINUX11 App"
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
        onLaunch: function(command) { root.launch(command) }
    }

    Search {
        id: search
        z: 600
        anchors.fill: parent
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
        width: Math.min(340, root.width - 48)
        height: Math.min(370, root.height - 118)
        x: Math.max(24, root.width - width - 28)
        y: Math.max(24, taskbar.y - height - 14)
        open: root.quickSettingsOpen
    }

    AppWindow {
        id: appWindow
        z: 900
        anchors.fill: parent
        appId: root.activeApp
        title: root.activeTitle
        onClosed: root.activeApp = ""
        onMinimized: root.activeApp = ""
    }

    Item {
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
